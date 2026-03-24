<?php
if (!defined('ABSPATH')) {
    exit;
}

if (!is_user_logged_in()) {
    echo '<p style="color:red; padding:20px; border:1px solid #fcc; background:#fee; border-radius:4px; max-width:600px; margin:30px auto;">Acceso restringido. Debes iniciar sesión.</p>';
    return;
}
$user = wp_get_current_user();
$roles = (array) $user->roles;
$allowed = in_array('administrator', $roles, true) || in_array('editor', $roles, true);
if (!$allowed) {
    echo '<p style="color:red; padding:20px; border:1px solid #fcc; background:#fee; border-radius:4px; max-width:600px; margin:30px auto;">Acceso restringido. Debes ser administrador o editor para ver esta página.</p>';
    return;
}

$message_output = '';
$title = '';
$body = '';
$topic = 'global';
$show_form = false;

if (($_SERVER['REQUEST_METHOD'] ?? '') === 'POST') {
    $action = sanitize_key($_POST['vac_push_action'] ?? '');
    if (!isset($_POST['vac_push_nonce']) || !wp_verify_nonce(wp_unslash($_POST['vac_push_nonce']), 'vac_push_admin_form')) {
        $message_output = '<p style="color:red;">❌ Sesión no válida. Recarga la página e inténtalo de nuevo.</p>';
    } elseif ($action === 'send') {
        $show_form = true;
        $title = sanitize_text_field($_POST['fcm_title'] ?? '');
        $body = sanitize_text_field($_POST['fcm_body'] ?? '');
        $topic = sanitize_key($_POST['fcm_topic'] ?? 'global');
        if ($topic === '') {
            $topic = 'global';
        }

        if ($title === '' || $body === '') {
            $message_output = '<p style="color:red;">❗ Debes rellenar título y contenido.</p>';
        } elseif (!function_exists('VACoworking_send_push_to_topic')) {
            $message_output = '<p style="color:red;">❌ La función de envío push no está disponible.</p>';
        } else {
            $notification_id = 0;
            if (function_exists('VACoworking_create_global_notification')) {
                $notification_id = (int) VACoworking_create_global_notification($title, $body, $topic);
            }
            $result = VACoworking_send_push_to_topic($topic, $title, $body);
            if (is_wp_error($result)) {
                $message_output = '<p style="color:red;">❌ Error enviando al topic <code>' . esc_html($topic) . '</code>: ' . esc_html($result->get_error_message()) . '</p>';
            } else {
                $message_output = '<p style="color:green;">✅ Notificación enviada al topic <code>' . esc_html($topic) . '</code>' .
                    ($notification_id > 0 ? ' (ID interno: ' . esc_html((string) $notification_id) . ')' : '') .
                    '.</p>';
                $title = '';
                $body = '';
                $topic = 'global';
                $show_form = false;
            }
        }
    } elseif ($action === 'delete') {
        global $wpdb;
        $table_name = $wpdb->prefix . 'VACoworking_notifications';
        $notification_id = absint($_POST['notification_id'] ?? 0);
        if ($notification_id <= 0) {
            $message_output = '<p style="color:red;">❌ ID de notificación no válido.</p>';
        } else {
            $deleted = $wpdb->delete($table_name, array('id' => $notification_id), array('%d'));
            if ($deleted) {
                $message_output = '<p style="color:green;">✅ Notificación eliminada.</p>';
            } else {
                $message_output = '<p style="color:red;">❌ No se pudo eliminar la notificación (puede que ya no exista).</p>';
            }
        }
    }
}

global $wpdb;
$table_name = $wpdb->prefix . 'VACoworking_notifications';
$page = max(1, absint($_GET['vac_page_n'] ?? 1));
$per_page = 20;
$offset = ($page - 1) * $per_page;
$total = (int) $wpdb->get_var("SELECT COUNT(*) FROM {$table_name}");
$total_pages = max(1, (int) ceil($total / $per_page));
if ($page > $total_pages) {
    $page = $total_pages;
    $offset = ($page - 1) * $per_page;
}
$rows = $wpdb->get_results(
    $wpdb->prepare(
        "SELECT id, title, message, topic, created_at
         FROM {$table_name}
         ORDER BY created_at DESC
         LIMIT %d OFFSET %d",
        $per_page,
        $offset
    ),
    ARRAY_A
);

$current_url = get_permalink(get_the_ID());
?>

    <style>
        * {
            box-sizing: border-box;
        }
        .VACoworking-push-wrapper {
            font-family: -apple-system, BlinkMacSystemFont, 'Segoe UI', Roboto, Oxygen, Ubuntu, Cantarell, sans-serif;
            width: 100%;
            max-width: 100%;
            margin: 30px auto;
        }
        .VACoworking-push-container {
            /* sin fondo ni sombra para integrarse con el theme */
            width: 100%;
            max-width: 100%;
        }
        h3 {
            margin: 0 0 16px 0;
            color: #111111;
            font-size: 20px;
            font-weight: 600;
        }
        label {
            display: block;
            margin-bottom: 5px;
            font-weight: 500;
            color: #111111;
        }
        input[type="text"],
        textarea {
            width: 100%;
            padding: 10px;
            margin-bottom: 15px;
            border: 1px solid #ddd;
            border-radius: 4px;
            font-size: 14px;
            font-family: inherit;
        }
        textarea {
            height: 80px;
            resize: vertical;
        }
        button {
            background-color: #1976d2;
            color: #ffffff;
            padding: 12px 24px;
            border: none;
            border-radius: 4px;
            cursor: pointer;
            font-size: 16px;
            font-weight: 500;
            width: 100%;
        }
        button:hover {
            background-color: #1565c0;
        }
        .vac-btn-secondary {
            background: #f4f4f4;
            color: #111;
            border: 1px solid #ddd;
        }
        .vac-btn-secondary:hover {
            background: #eaeaea;
        }
        .vac-btn-danger {
            background: #fff;
            color: #c62828;
            border: 1px solid #ef9a9a;
            width: auto;
            padding: 8px 12px;
            font-size: 13px;
        }
        .vac-btn-danger:hover { background: #ffebee; }
        .vac-toolbar {
            display: flex;
            gap: 10px;
            margin-bottom: 14px;
        }
        .vac-form-wrap[hidden] { display: none !important; }
        .vac-table {
            width: 100%;
            border-collapse: collapse;
            margin-top: 16px;
            background: #fff;
        }
        .vac-table th, .vac-table td {
            border: 1px solid #ddd;
            padding: 8px 10px;
            text-align: left;
            vertical-align: top;
            color: #111;
        }
        .vac-table th { background: #f7f7f7; }
        .vac-msg-cell { white-space: pre-wrap; }
        .vac-pagination {
            display: flex;
            gap: 8px;
            align-items: center;
            margin-top: 12px;
        }
        .vac-pagination a {
            padding: 6px 10px;
            border: 1px solid #ddd;
            border-radius: 4px;
            text-decoration: none;
            color: #111;
            background: #fff;
        }
        .vac-pagination strong {
            color: #111;
        }
        code {
            display: block;
            margin: 5px 0;
            padding: 5px;
            background-color: rgba(0,0,0,0.05);
            border-radius: 3px;
            font-family: monospace;
            font-size: 12px;
            word-break: break-all;
        }
        .api-config {
            margin-bottom: 20px;
            padding: 15px;
            background-color: #f8f9fa;
            border-radius: 4px;
            border: 1px solid #dee2e6;
        }
        .api-config label {
            display: inline-block;
            width: 120px;
        }
        .api-config input {
            width: calc(100% - 130px);
            margin-bottom: 10px;
        }
        .warning {
            background-color: #fff3cd;
            border: 1px solid #ffc107;
            color: #856404;
            padding: 10px;
            border-radius: 4px;
            margin-bottom: 20px;
        }
    </style>

    <div class="VACoworking-push-wrapper">
        <div class="VACoworking-push-container">
            <h3>Notificaciones Push</h3>

            <div class="vac-toolbar">
                <button type="button" id="vac-toggle-form" class="vac-btn-secondary">Enviar notificación</button>
            </div>

            <div id="vac-form-wrap" class="vac-form-wrap" <?php echo $show_form ? '' : 'hidden'; ?>>
                <form method="post" id="notificationForm">
                    <?php wp_nonce_field('vac_push_admin_form', 'vac_push_nonce'); ?>
                    <input type="hidden" name="vac_push_action" value="send">

                    <label for="fcm_topic">Topic (por defecto: global):</label>
                    <input type="text" name="fcm_topic" id="fcm_topic" value="<?php echo esc_attr($topic ?: 'global'); ?>" placeholder="global">

                    <label for="fcm_title">Título:</label>
                    <input type="text" name="fcm_title" id="fcm_title" value="<?php echo esc_attr($title); ?>" required>

                    <label for="fcm_body">Contenido:</label>
                    <textarea name="fcm_body" id="fcm_body" required><?php echo esc_textarea($body); ?></textarea>

                    <button type="submit">Enviar</button>
                </form>
            </div>

            <?php if ($message_output) {
                echo '<div style="margin-top:20px;">' . $message_output . '</div>';
            } ?>

            <h3 style="margin-top:24px;">Notificaciones enviadas</h3>
            <table class="vac-table">
                <thead>
                    <tr>
                        <th style="width:70px;">ID</th>
                        <th style="width:120px;">Topic</th>
                        <th style="width:180px;">Fecha</th>
                        <th style="width:180px;">Título</th>
                        <th>Contenido</th>
                        <th style="width:110px;">Acciones</th>
                    </tr>
                </thead>
                <tbody>
                    <?php if (empty($rows)) : ?>
                        <tr><td colspan="6">No hay notificaciones todavía.</td></tr>
                    <?php else : ?>
                        <?php foreach ($rows as $row) : ?>
                            <tr>
                                <td><?php echo esc_html((string) $row['id']); ?></td>
                                <td><code><?php echo esc_html((string) $row['topic']); ?></code></td>
                                <td><?php echo esc_html((string) $row['created_at']); ?></td>
                                <td><?php echo esc_html((string) $row['title']); ?></td>
                                <td class="vac-msg-cell"><?php echo esc_html((string) $row['message']); ?></td>
                                <td>
                                    <form method="post" onsubmit="return confirm('¿Eliminar esta notificación?');">
                                        <?php wp_nonce_field('vac_push_admin_form', 'vac_push_nonce'); ?>
                                        <input type="hidden" name="vac_push_action" value="delete">
                                        <input type="hidden" name="notification_id" value="<?php echo esc_attr((string) $row['id']); ?>">
                                        <button type="submit" class="vac-btn-danger">Eliminar</button>
                                    </form>
                                </td>
                            </tr>
                        <?php endforeach; ?>
                    <?php endif; ?>
                </tbody>
            </table>

            <div class="vac-pagination">
                <?php if ($page > 1) : ?>
                    <a href="<?php echo esc_url(add_query_arg('vac_page_n', $page - 1, $current_url)); ?>">← Anterior</a>
                <?php endif; ?>
                <strong>Página <?php echo esc_html((string) $page); ?> de <?php echo esc_html((string) $total_pages); ?></strong>
                <?php if ($page < $total_pages) : ?>
                    <a href="<?php echo esc_url(add_query_arg('vac_page_n', $page + 1, $current_url)); ?>">Siguiente →</a>
                <?php endif; ?>
            </div>
        </div>
    </div>

    <script>
        (function() {
            const toggleBtn = document.getElementById('vac-toggle-form');
            const formWrap = document.getElementById('vac-form-wrap');
            const topicInput = document.getElementById('fcm_topic');
            if (toggleBtn && formWrap) {
                toggleBtn.addEventListener('click', function() {
                    formWrap.hidden = !formWrap.hidden;
                    if (!formWrap.hidden) {
                        const titleInput = document.getElementById('fcm_title');
                        if (titleInput) titleInput.focus();
                    }
                });
            }
            if (!topicInput) return;
            if (!topicInput.value.trim()) {
                topicInput.value = 'global';
            }
        })();
    </script>
