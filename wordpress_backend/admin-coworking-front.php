<?php
/**
 * Panel de gestión de espacios coworking en el front (shortcode).
 * Roles permitidos: administrator, editor.
 * - Administrador: ve y gestiona todos los espacios.
 * - Editor: solo los espacios donde es autor.
 *
 * Uso: crea una página (ej. "Gestión espacios") y añade el shortcode:
 * [vacoworking_espacios_admin]
 *
 * Requiere el CPT espacio_coworking (admin-cpt-coworking.php).
 *
 * Guardado: el formulario hace POST a la propia página; el procesamiento va en
 * init (no admin-post.php), para que funcione bien con Code Snippets y sin depender de wp-admin.
 */

if (!defined('ABSPATH')) {
    exit;
}

add_shortcode('vacoworking_espacios_admin', 'VACoworking_front_espacios_admin_shortcode');

add_filter('wp_editor_settings', 'VACoworking_front_espacios_editor_settings_no_code_tab', 10, 2);

add_action('template_redirect', 'VACoworking_front_espacios_guard_shortcode_page', 5);

/**
 * Guardar/borrar en init (no admin-post.php): evita que los snippets no enganchen
 * o que el hosting bloquee wp-admin/admin-post.php desde el front.
 */
add_action('init', 'VACoworking_front_espacios_process_post_requests', 20);

add_action('wp_enqueue_scripts', 'VACoworking_front_espacios_enqueue_assets', 20);

add_filter('wp_handle_upload', 'VACoworking_front_espacios_maybe_webp', 20, 2);

/**
 * Solo administrador o editor.
 */
/**
 * Solo pestaña Visual en la descripción (sin «Código» / HTML).
 */
function VACoworking_front_espacios_editor_settings_no_code_tab($settings, $editor_id) {
    if ($editor_id === 'vac_content') {
        $settings['quicktags'] = false;
    }
    return $settings;
}

function VACoworking_front_espacios_user_can_access() {
    if (!is_user_logged_in()) {
        return false;
    }
    $user = wp_get_current_user();
    $roles = (array) $user->roles;
    return in_array('administrator', $roles, true) || in_array('editor', $roles, true);
}

/**
 * Administrador: todos. Editor: solo propios.
 */
function VACoworking_front_espacios_is_admin_role() {
    $user = wp_get_current_user();
    return in_array('administrator', (array) $user->roles, true);
}

/**
 * Redirige a inicio si la página contiene el shortcode y el usuario no es admin ni editor.
 */
function VACoworking_front_espacios_guard_shortcode_page() {
    if (!is_singular()) {
        return;
    }
    global $post;
    if (!$post || !has_shortcode($post->post_content, 'vacoworking_espacios_admin')) {
        return;
    }
    if (!VACoworking_front_espacios_user_can_access()) {
        wp_safe_redirect(home_url('/'));
        exit;
    }
}

function VACoworking_front_espacios_can_edit_post($post_id) {
    $post = get_post((int) $post_id);
    if (!$post || $post->post_type !== 'espacio_coworking') {
        return false;
    }
    if (VACoworking_front_espacios_is_admin_role()) {
        return current_user_can('edit_post', $post_id);
    }
    return (int) $post->post_author === get_current_user_id() && current_user_can('edit_post', $post_id);
}

function VACoworking_front_espacios_can_delete_post($post_id) {
    $post = get_post((int) $post_id);
    if (!$post || $post->post_type !== 'espacio_coworking') {
        return false;
    }
    if (VACoworking_front_espacios_is_admin_role()) {
        return current_user_can('delete_post', $post_id);
    }
    return (int) $post->post_author === get_current_user_id() && current_user_can('delete_post', $post_id);
}

function VACoworking_front_espacios_enqueue_assets() {
    global $post;
    if (!$post || !has_shortcode($post->post_content, 'vacoworking_espacios_admin')) {
        return;
    }
    if (!VACoworking_front_espacios_user_can_access()) {
        return;
    }
    wp_enqueue_editor();
}

/**
 * Convierte JPEG/PNG a WebP solo cuando la subida viene del formulario de espacios.
 */
function VACoworking_front_espacios_maybe_webp($upload, $context) {
    if ($context !== 'upload') {
        return $upload;
    }
    if (empty($GLOBALS['vacoworking_espacio_webp_upload'])) {
        return $upload;
    }
    if (!empty($upload['error'])) {
        return $upload;
    }
    $file = $upload['file'];
    $check = wp_check_filetype($file);
    $mime = isset($check['type']) ? $check['type'] : '';
    if (!in_array($mime, array('image/jpeg', 'image/png'), true)) {
        return $upload;
    }
    $webp = VACoworking_front_espacios_image_to_webp($file);
    if (!$webp || !file_exists($webp)) {
        return $upload;
    }
    $upload['file'] = $webp;
    $upload['url'] = str_replace(basename($file), basename($webp), $upload['url']);
    $upload['type'] = 'image/webp';
    return $upload;
}

/**
 * Genera WebP junto al archivo original y borra el original si todo va bien.
 */
function VACoworking_front_espacios_image_to_webp($source_path) {
    if (!file_exists($source_path)) {
        return false;
    }
    $info = @getimagesize($source_path);
    if (!$info) {
        return false;
    }
    $mime = $info['mime'];
    if ($mime === 'image/webp') {
        return $source_path;
    }
    $webp_path = preg_replace('/\.(jpe?g|png)$/i', '.webp', $source_path);
    if ($webp_path === $source_path) {
        return false;
    }
    $im = null;
    if ($mime === 'image/jpeg' && function_exists('imagecreatefromjpeg')) {
        $im = @imagecreatefromjpeg($source_path);
    } elseif ($mime === 'image/png' && function_exists('imagecreatefrompng')) {
        $im = @imagecreatefrompng($source_path);
        if ($im) {
            imagealphablending($im, false);
            imagesavealpha($im, true);
        }
    }
    if (!$im || !function_exists('imagewebp')) {
        if ($im) {
            imagedestroy($im);
        }
        return false;
    }
    $quality = 85;
    $ok = imagewebp($im, $webp_path, $quality);
    imagedestroy($im);
    if (!$ok || !file_exists($webp_path)) {
        @unlink($webp_path);
        return false;
    }
    @unlink($source_path);
    return $webp_path;
}

function VACoworking_front_espacios_get_page_url() {
    global $post;
    if ($post && is_page()) {
        return get_permalink($post->ID);
    }
    return home_url('/');
}

/**
 * Extracto automático a partir de la descripción (equivalente a lo que WordPress hace si no rellenas el campo manualmente).
 */
function VACoworking_front_espacios_build_excerpt_from_content($content) {
    $text = strip_shortcodes((string) $content);
    $text = wp_strip_all_tags($text);
    $text = preg_replace('/\s+/u', ' ', $text);
    $text = trim($text);
    if ($text === '') {
        return '';
    }
    return wp_trim_words($text, 55, '…');
}

/**
 * Lee vac_galeria_ids: array en meta o cadena JSON (p. ej. guardada vía REST/app).
 * Sin esto, get_post_meta puede devolver string y el guardado del formulario vaciaba la galería.
 */
function VACoworking_front_espacios_get_gallery_attachment_ids($post_id) {
    $post_id = (int) $post_id;
    if ($post_id <= 0) {
        return array();
    }
    $raw = get_post_meta($post_id, 'vac_galeria_ids', true);
    if (is_array($raw)) {
        $ids = $raw;
    } elseif (is_string($raw) && $raw !== '') {
        $decoded = json_decode($raw, true);
        $ids = is_array($decoded) ? $decoded : array();
    } else {
        $ids = array();
    }
    $out = array();
    foreach ((array) $ids as $id) {
        $id = absint($id);
        if ($id > 0) {
            $out[] = $id;
        }
    }
    return array_values(array_unique($out));
}

/**
 * Normaliza $_FILES['vac_gallery'] a una fila por archivo (name[] en array o un solo fichero).
 */
function VACoworking_front_espacios_get_gallery_upload_files() {
    if (empty($_FILES['vac_gallery']) || !is_array($_FILES['vac_gallery'])) {
        return array();
    }
    $f = $_FILES['vac_gallery'];
    if (!isset($f['name'])) {
        return array();
    }
    if (!is_array($f['name'])) {
        if ($f['name'] === '' || $f['name'] === null) {
            return array();
        }
        $err = isset($f['error']) ? (int) $f['error'] : UPLOAD_ERR_NO_FILE;
        if ($err !== UPLOAD_ERR_OK) {
            return array();
        }
        return array(array(
            'name' => $f['name'],
            'type' => isset($f['type']) ? $f['type'] : '',
            'tmp_name' => isset($f['tmp_name']) ? $f['tmp_name'] : '',
            'error' => $err,
            'size' => isset($f['size']) ? $f['size'] : 0,
        ));
    }
    $out = array();
    $n = count($f['name']);
    for ($i = 0; $i < $n; $i++) {
        if (!isset($f['name'][$i]) || $f['name'][$i] === '') {
            continue;
        }
        $err = isset($f['error'][$i]) ? (int) $f['error'][$i] : UPLOAD_ERR_NO_FILE;
        if ($err !== UPLOAD_ERR_OK) {
            continue;
        }
        $out[] = array(
            'name' => $f['name'][$i],
            'type' => isset($f['type'][$i]) ? $f['type'][$i] : '',
            'tmp_name' => isset($f['tmp_name'][$i]) ? $f['tmp_name'][$i] : '',
            'error' => $err,
            'size' => isset($f['size'][$i]) ? $f['size'][$i] : 0,
        );
    }
    return $out;
}

/**
 * Filtro simple para IDs enteros positivos (sin closures, compatible con PHP antiguos).
 */
function VACoworking_front_espacios_is_positive_id($id) {
    return ((int) $id) > 0;
}

/**
 * Iconos SVG para acciones (evita emojis que no se ven en algunos entornos).
 */
function VACoworking_front_espacios_icon_edit() {
    return '<svg class="vacoworking-icon-svg" xmlns="http://www.w3.org/2000/svg" width="18" height="18" viewBox="0 0 24 24" fill="none" stroke="currentColor" stroke-width="2" stroke-linecap="round" stroke-linejoin="round" aria-hidden="true"><path d="M11 4H4a2 2 0 0 0-2 2v14a2 2 0 0 0 2 2h14a2 2 0 0 0 2-2v-7"/><path d="M18.5 2.5a2.121 2.121 0 0 1 3 3L12 15l-4 1 1-4 9.5-9.5z"/></svg>';
}

function VACoworking_front_espacios_icon_trash() {
    return '<svg class="vacoworking-icon-svg" xmlns="http://www.w3.org/2000/svg" width="18" height="18" viewBox="0 0 24 24" fill="none" stroke="currentColor" stroke-width="2" stroke-linecap="round" stroke-linejoin="round" aria-hidden="true"><path d="M3 6h18"/><path d="M19 6v14a2 2 0 0 1-2 2H7a2 2 0 0 1-2-2V6"/><path d="M8 6V4a2 2 0 0 1 2-2h4a2 2 0 0 1 2 2v2"/><path d="M10 11v6"/><path d="M14 11v6"/></svg>';
}

/**
 * Procesa POST del listado (borrar) y del formulario (guardar).
 */
function VACoworking_front_espacios_process_post_requests() {
    if (($_SERVER['REQUEST_METHOD'] ?? '') !== 'POST') {
        return;
    }
    // Evita mezclar con otros POST del sitio; nuestros formularios llevan este campo.
    if (!isset($_POST['vacoworking_redirect'])) {
        return;
    }
    if (!empty($_POST['vacoworking_delete_nonce'])) {
        VACoworking_front_espacios_handle_delete();
        return;
    }
    if (isset($_POST['vac_gallery_remove']) && $_POST['vac_gallery_remove'] !== '') {
        VACoworking_front_espacios_handle_remove_gallery_item();
        return;
    }
    if (!empty($_POST['vacoworking_espacio_nonce'])) {
        VACoworking_front_espacios_handle_save();
    }
}

function VACoworking_front_espacios_handle_save() {
    if (!isset($_POST['vacoworking_espacio_nonce']) || !wp_verify_nonce(wp_unslash($_POST['vacoworking_espacio_nonce']), 'vacoworking_espacio_save')) {
        $base = isset($_POST['vacoworking_redirect']) ? esc_url_raw(wp_unslash($_POST['vacoworking_redirect'])) : home_url('/');
        wp_safe_redirect(add_query_arg('vac_err', 'nonce', $base));
        exit;
    }
    if (!VACoworking_front_espacios_user_can_access()) {
        wp_safe_redirect(home_url('/'));
        exit;
    }

    $redirect_base = isset($_POST['vacoworking_redirect']) ? esc_url_raw(wp_unslash($_POST['vacoworking_redirect'])) : home_url('/');
    $post_id = isset($_POST['vac_post_id']) ? absint($_POST['vac_post_id']) : 0;

    if ($post_id && !VACoworking_front_espacios_can_edit_post($post_id)) {
        wp_safe_redirect(add_query_arg('vac_err', 'perm', $redirect_base));
        exit;
    }

    $featured_upload = !empty($_FILES['vac_featured']['name']);
    if (!$post_id) {
        if (!$featured_upload) {
            wp_safe_redirect(add_query_arg('vac_err', 'no_image', $redirect_base));
            exit;
        }
    } else {
        $prev_thumb = (int) get_post_thumbnail_id($post_id);
        if (!$prev_thumb && !$featured_upload) {
            wp_safe_redirect(add_query_arg('vac_err', 'no_image', $redirect_base));
            exit;
        }
    }

    $title = isset($_POST['vac_title']) ? sanitize_text_field(wp_unslash($_POST['vac_title'])) : '';
    $content = isset($_POST['vac_content']) ? wp_kses_post(wp_unslash($_POST['vac_content'])) : '';
    $excerpt = VACoworking_front_espacios_build_excerpt_from_content($content);

    $data = array(
        'post_type' => 'espacio_coworking',
        'post_title' => $title,
        'post_content' => $content,
        'post_excerpt' => $excerpt,
        'post_status' => 'publish',
    );

    if ($post_id) {
        $data['ID'] = $post_id;
        $data['post_type'] = 'espacio_coworking';
        $result = wp_update_post($data, true);
    } else {
        $data['post_author'] = get_current_user_id();
        $result = wp_insert_post($data, true);
    }

    if (is_wp_error($result)) {
        wp_safe_redirect(add_query_arg('vac_err', 'save', $redirect_base));
        exit;
    }

    $post_id = (int) $result;

    if (isset($_POST['vac_sala_nombre']) && is_array($_POST['vac_sala_nombre'])) {
        $_POST['vac_salas_json'] = VACoworking_front_espacios_build_salas_json_from_visual_fields(
            isset($_POST['vac_sala_nombre']) ? wp_unslash($_POST['vac_sala_nombre']) : array(),
            isset($_POST['vac_sala_capacidad']) ? wp_unslash($_POST['vac_sala_capacidad']) : array(),
            isset($_POST['vac_sala_notas']) ? wp_unslash($_POST['vac_sala_notas']) : array()
        );
    }

    $meta_map = array(
        'vac_direccion' => 'sanitize_text_field',
        'vac_lat' => 'floatval',
        'vac_lng' => 'floatval',
        'vac_telefono' => 'sanitize_text_field',
        'vac_email' => 'sanitize_email',
        'vac_web' => 'esc_url_raw',
        'vac_horario' => 'sanitize_textarea_field',
        'vac_capacidad_total' => 'absint',
        'vac_salas_json' => 'VACoworking_front_espacios_sanitize_salas_json_field',
    );

    foreach ($meta_map as $key => $cb) {
        $raw = isset($_POST[$key]) ? wp_unslash($_POST[$key]) : '';
        if ($cb === 'floatval') {
            $val = is_numeric($raw) ? floatval($raw) : 0;
        } elseif ($cb === 'absint') {
            $val = absint($raw);
        } elseif ($cb === 'VACoworking_front_espacios_sanitize_salas_json_field') {
            $val = VACoworking_front_espacios_sanitize_salas_json_field($raw);
        } else {
            $val = call_user_func($cb, $raw);
        }
        update_post_meta($post_id, $key, $val);
    }

    // Taxonomías: solo IDs de términos existentes (validados)
    $servicio_ids = VACoworking_front_espacios_sanitize_term_ids_from_post('vac_servicios', 'servicio_coworking');
    wp_set_post_terms($post_id, $servicio_ids, 'servicio_coworking', false);
    $equip_ids = VACoworking_front_espacios_sanitize_term_ids_from_post('vac_equipamiento', 'equipamiento_coworking');
    wp_set_post_terms($post_id, $equip_ids, 'equipamiento_coworking', false);

    require_once ABSPATH . 'wp-admin/includes/file.php';
    require_once ABSPATH . 'wp-admin/includes/media.php';
    require_once ABSPATH . 'wp-admin/includes/image.php';

    $GLOBALS['vacoworking_espacio_webp_upload'] = true;

    if (!empty($_FILES['vac_featured']['name'])) {
        $old_thumb_id = (int) get_post_thumbnail_id($post_id);
        $aid = media_handle_upload('vac_featured', $post_id);
        if (!is_wp_error($aid)) {
            $aid = (int) $aid;
            set_post_thumbnail($post_id, $aid);
            if ($old_thumb_id > 0 && $old_thumb_id !== $aid) {
                $gids = VACoworking_front_espacios_get_gallery_attachment_ids($post_id);
                if (in_array($old_thumb_id, $gids, true)) {
                    $gids = array_values(array_diff($gids, array($old_thumb_id)));
                    update_post_meta($post_id, 'vac_galeria_ids', $gids);
                }
                wp_delete_attachment($old_thumb_id, true);
            }
        }
    }

    $existing_gallery = VACoworking_front_espacios_get_gallery_attachment_ids($post_id);

    foreach (VACoworking_front_espacios_get_gallery_upload_files() as $file_row) {
        $_FILES['vac_gallery_single'] = $file_row;
        $aid = media_handle_upload('vac_gallery_single', $post_id);
        if (!is_wp_error($aid)) {
            $existing_gallery[] = (int) $aid;
        }
    }
    unset($_FILES['vac_gallery_single']);

    $existing_gallery = array_values(array_unique(array_filter(array_map('absint', $existing_gallery), 'VACoworking_front_espacios_is_positive_id')));
    update_post_meta($post_id, 'vac_galeria_ids', $existing_gallery);

    unset($GLOBALS['vacoworking_espacio_webp_upload']);

    wp_safe_redirect(add_query_arg('vac_ok', '1', $redirect_base));
    exit;
}

function VACoworking_front_espacios_sanitize_salas_json_field($raw) {
    if ($raw === '' || $raw === null) {
        return '';
    }
    $decoded = json_decode(is_string($raw) ? $raw : wp_json_encode($raw), true);
    if (!is_array($decoded)) {
        return '';
    }
    return wp_json_encode($decoded);
}

/**
 * Convierte campos visuales de salas a JSON estable para meta vac_salas_json.
 */
function VACoworking_front_espacios_build_salas_json_from_visual_fields($names, $capacities, $notes) {
    $names = is_array($names) ? $names : array();
    $capacities = is_array($capacities) ? $capacities : array();
    $notes = is_array($notes) ? $notes : array();
    $max = max(count($names), count($capacities), count($notes));
    $rows = array();
    for ($i = 0; $i < $max; $i++) {
        $name = isset($names[$i]) ? sanitize_text_field((string) $names[$i]) : '';
        $cap_raw = isset($capacities[$i]) ? $capacities[$i] : 0;
        $capacity = is_numeric($cap_raw) ? absint($cap_raw) : 0;
        $note = isset($notes[$i]) ? sanitize_textarea_field((string) $notes[$i]) : '';
        if ($name === '' && $capacity === 0 && $note === '') {
            continue;
        }
        $row = array(
            'nombre' => $name,
            'capacidad' => $capacity,
        );
        if ($note !== '') {
            $row['notas'] = $note;
        }
        $rows[] = $row;
    }
    return wp_json_encode($rows);
}

/**
 * IDs de término enviados por checkbox[]; solo acepta términos que existen en la taxonomía.
 */
function VACoworking_front_espacios_sanitize_term_ids_from_post($post_key, $taxonomy) {
    if (!isset($_POST[$post_key]) || !is_array($_POST[$post_key])) {
        return array();
    }
    $out = array();
    foreach ($_POST[$post_key] as $raw) {
        $id = absint($raw);
        if ($id <= 0) {
            continue;
        }
        $term = get_term($id, $taxonomy);
        if ($term && !is_wp_error($term)) {
            $out[] = $id;
        }
    }
    return array_values(array_unique($out));
}

/**
 * Casillas con términos ya creados en WordPress (no se crean nuevos desde este formulario).
 */
function VACoworking_front_espacios_render_term_checkboxes($taxonomy, $input_base_name, $selected_ids, $legend) {
    $terms = get_terms(array(
        'taxonomy' => $taxonomy,
        'hide_empty' => false,
        'orderby' => 'name',
        'order' => 'ASC',
    ));

    echo '<fieldset class="vacoworking-tax-checkboxes"><legend>' . esc_html($legend) . '</legend>';

    if (is_wp_error($terms) || empty($terms)) {
        echo '<p class="description vacoworking-tax-empty">';
        esc_html_e('No hay opciones disponibles. Contacta con el administrador para añadir categorías.', 'vacoworking');
        echo '</p>';
        echo '</fieldset>';
        return;
    }

    $selected_ids = array_map('intval', (array) $selected_ids);
    $name = esc_attr($input_base_name) . '[]';

    echo '<div class="vacoworking-tax-checkboxes-grid">';
    foreach ($terms as $term) {
        $tid = (int) $term->term_id;
        $fid = 'vac_' . sanitize_key($taxonomy) . '_' . $tid;
        $checked = in_array($tid, $selected_ids, true);
        echo '<label class="vacoworking-tax-checkboxes-item" for="' . esc_attr($fid) . '">';
        echo '<input type="checkbox" name="' . $name . '" id="' . esc_attr($fid) . '" value="' . esc_attr((string) $tid) . '" ' . checked($checked, true, false) . ' /> ';
        echo '<span>' . esc_html($term->name) . '</span>';
        echo '</label>';
    }
    echo '</div>';
    echo '</fieldset>';
}

function VACoworking_front_espacios_handle_delete() {
    if (!isset($_POST['vacoworking_delete_nonce']) || !wp_verify_nonce(wp_unslash($_POST['vacoworking_delete_nonce']), 'vacoworking_espacio_delete')) {
        $base = isset($_POST['vacoworking_redirect']) ? esc_url_raw(wp_unslash($_POST['vacoworking_redirect'])) : home_url('/');
        wp_safe_redirect(add_query_arg('vac_err', 'nonce', $base));
        exit;
    }
    if (!VACoworking_front_espacios_user_can_access()) {
        wp_safe_redirect(home_url('/'));
        exit;
    }

    $redirect_base = isset($_POST['vacoworking_redirect']) ? esc_url_raw(wp_unslash($_POST['vacoworking_redirect'])) : home_url('/');
    $post_id = isset($_POST['vac_post_id']) ? absint($_POST['vac_post_id']) : 0;

    if (!$post_id || !VACoworking_front_espacios_can_delete_post($post_id)) {
        wp_safe_redirect(add_query_arg('vac_err', 'perm', $redirect_base));
        exit;
    }

    $deleted = wp_delete_post($post_id, true);
    if (!$deleted) {
        wp_safe_redirect(add_query_arg('vac_err', 'del', $redirect_base));
        exit;
    }

    wp_safe_redirect(add_query_arg('vac_ok', 'del', $redirect_base));
    exit;
}

function VACoworking_front_espacios_redirect_to_form($page_url, $post_id) {
    $url = add_query_arg(
        array(
            'vac_page' => 'form',
            'vac_id' => absint($post_id),
        ),
        $page_url
    );
    wp_safe_redirect($url);
    exit;
}

function VACoworking_front_espacios_handle_remove_gallery_item() {
    if (!isset($_POST['vacoworking_gallery_remove_nonce']) || !wp_verify_nonce(wp_unslash($_POST['vacoworking_gallery_remove_nonce']), 'vacoworking_gallery_remove')) {
        $base = isset($_POST['vacoworking_redirect']) ? esc_url_raw(wp_unslash($_POST['vacoworking_redirect'])) : home_url('/');
        wp_safe_redirect(add_query_arg('vac_err', 'nonce', $base));
        exit;
    }
    if (!VACoworking_front_espacios_user_can_access()) {
        wp_safe_redirect(home_url('/'));
        exit;
    }
    $redirect_base = isset($_POST['vacoworking_redirect']) ? esc_url_raw(wp_unslash($_POST['vacoworking_redirect'])) : home_url('/');
    $post_id = isset($_POST['vac_post_id']) ? absint($_POST['vac_post_id']) : 0;
    $att_id = isset($_POST['vac_gallery_remove']) ? absint($_POST['vac_gallery_remove']) : 0;
    if (!$post_id || !$att_id || !VACoworking_front_espacios_can_edit_post($post_id)) {
        wp_safe_redirect(add_query_arg('vac_err', 'perm', $redirect_base));
        exit;
    }
    $gids = VACoworking_front_espacios_get_gallery_attachment_ids($post_id);
    if (!in_array($att_id, $gids, true)) {
        wp_safe_redirect(add_query_arg('vac_err', 'perm', $redirect_base));
        exit;
    }
    $gids = array_values(array_diff($gids, array($att_id)));
    update_post_meta($post_id, 'vac_galeria_ids', $gids);
    if (wp_attachment_is_image($att_id) && current_user_can('delete_post', $att_id)) {
        wp_delete_attachment($att_id, true);
    }
    VACoworking_front_espacios_redirect_to_form($redirect_base, $post_id);
}

function VACoworking_front_espacios_admin_shortcode() {
    if (!VACoworking_front_espacios_user_can_access()) {
        return '';
    }

    $page_url = VACoworking_front_espacios_get_page_url();
    $vac_page = isset($_GET['vac_page']) ? sanitize_key(wp_unslash($_GET['vac_page'])) : 'list';
    $vac_id = isset($_GET['vac_id']) ? absint($_GET['vac_id']) : 0;

    ob_start();

    $admin_wrap_class = 'vacoworking-espacios-admin' . ($vac_page === 'form' ? ' vacoworking-espacios-admin--solo-formulario' : '');
    echo '<div class="' . esc_attr($admin_wrap_class) . '">';
    if ($vac_page !== 'form') {
        echo '<div class="vacoworking-espacios-header">';
        $add_url = esc_url(add_query_arg(array('vac_page' => 'form'), $page_url));
        echo '<a class="vacoworking-btn vacoworking-btn-primary" href="' . $add_url . '">' . esc_html__('Añadir espacio Coworking', 'vacoworking') . '</a>';
        echo '<a class="vacoworking-btn vacoworking-btn-logout" href="' . esc_url(wp_logout_url(home_url('/'))) . '">' . esc_html__('Cerrar sesión', 'vacoworking') . '</a>';
        echo '</div>';
    }

    if (isset($_GET['vac_ok'])) {
        $ok = sanitize_key(wp_unslash($_GET['vac_ok']));
        if ($ok === '1') {
            echo '<p class="vacoworking-notice vacoworking-notice-ok">' . esc_html__('Espacio guardado correctamente.', 'vacoworking') . '</p>';
        } elseif ($ok === 'del') {
            echo '<p class="vacoworking-notice vacoworking-notice-ok">' . esc_html__('Espacio eliminado.', 'vacoworking') . '</p>';
        }
    }
    if (isset($_GET['vac_err'])) {
        $err = sanitize_key(wp_unslash($_GET['vac_err']));
        $msg = __('No se pudo completar la acción.', 'vacoworking');
        if ($err === 'perm') {
            $msg = __('No tienes permiso para esta operación.', 'vacoworking');
        } elseif ($err === 'save') {
            $msg = __('Error al guardar. Revisa los datos.', 'vacoworking');
        } elseif ($err === 'del') {
            $msg = __('No se pudo eliminar.', 'vacoworking');
        } elseif ($err === 'nonce') {
            $msg = __('La sesión de seguridad ha caducado o no es válida. Recarga la página e inténtalo de nuevo.', 'vacoworking');
        } elseif ($err === 'no_image') {
            $msg = __('Debes indicar el nombre del espacio y subir una imagen principal.', 'vacoworking');
        }
        echo '<p class="vacoworking-notice vacoworking-notice-err">' . esc_html($msg) . '</p>';
    }

    if ($vac_page === 'form') {
        VACoworking_front_espacios_render_form($page_url, $vac_id);
    } else {
        VACoworking_front_espacios_render_list($page_url);
    }

    echo '</div>';

    VACoworking_front_espacios_print_styles();

    return ob_get_clean();
}

function VACoworking_front_espacios_render_list($page_url) {
    $args = array(
        'post_type' => 'espacio_coworking',
        'post_status' => array('publish', 'draft', 'pending'),
        'posts_per_page' => -1,
        'orderby' => 'date',
        'order' => 'DESC',
    );
    if (!VACoworking_front_espacios_is_admin_role()) {
        $args['author'] = get_current_user_id();
    }

    $q = new WP_Query($args);

    if (!$q->have_posts()) {
        echo '<p>' . esc_html__('No hay espacios todavía.', 'vacoworking') . '</p>';
        wp_reset_postdata();
        return;
    }

    echo '<table class="vacoworking-table"><thead><tr>';
    echo '<th class="vacoworking-col-thumb">' . esc_html__('Imagen', 'vacoworking') . '</th>';
    echo '<th>' . esc_html__('Nombre', 'vacoworking') . '</th>';
    if (VACoworking_front_espacios_is_admin_role()) {
        echo '<th>' . esc_html__('Autor', 'vacoworking') . '</th>';
    }
    echo '<th class="vacoworking-actions">' . esc_html__('Acciones', 'vacoworking') . '</th>';
    echo '</tr></thead><tbody>';

    while ($q->have_posts()) {
        $q->the_post();
        $pid = get_the_ID();
        if (!VACoworking_front_espacios_can_edit_post($pid)) {
            continue;
        }
        $edit_url = esc_url(add_query_arg(array('vac_page' => 'form', 'vac_id' => $pid), $page_url));
        $title = get_the_title() ?: __('(sin título)', 'vacoworking');
        $thumb_id = (int) get_post_thumbnail_id($pid);

        echo '<tr>';
        echo '<td class="vacoworking-col-thumb">';
        if ($thumb_id) {
            echo wp_get_attachment_image(
                $thumb_id,
                'thumbnail',
                false,
                array(
                    'class' => 'vacoworking-list-thumb',
                    'alt' => '',
                )
            );
        } else {
            echo '<span class="vacoworking-list-thumb-placeholder" aria-hidden="true"></span>';
        }
        echo '</td>';
        echo '<td>' . esc_html($title) . '</td>';
        if (VACoworking_front_espacios_is_admin_role()) {
            $author = get_the_author_meta('display_name', get_post_field('post_author', $pid));
            echo '<td>' . esc_html($author) . '</td>';
        }
        echo '<td class="vacoworking-actions">';
        echo '<a class="vacoworking-icon-btn" href="' . $edit_url . '" title="' . esc_attr__('Editar', 'vacoworking') . '">' . VACoworking_front_espacios_icon_edit() . '</a>';
        echo '<form method="post" action="' . esc_url($page_url) . '" class="vacoworking-inline-form" onsubmit="return confirm(\'' . esc_js(__('¿Eliminar este espacio? Esta acción no se puede deshacer.', 'vacoworking')) . '\');">';
        wp_nonce_field('vacoworking_espacio_delete', 'vacoworking_delete_nonce');
        echo '<input type="hidden" name="vac_post_id" value="' . esc_attr((string) $pid) . '" />';
        echo '<input type="hidden" name="vacoworking_redirect" value="' . esc_attr($page_url) . '" />';
        echo '<button type="submit" class="vacoworking-icon-btn vacoworking-danger" title="' . esc_attr__('Eliminar', 'vacoworking') . '">' . VACoworking_front_espacios_icon_trash() . '<span class="vacoworking-sr-only"> ' . esc_html__('Borrar', 'vacoworking') . '</span></button>';
        echo '</form>';
        echo '</td>';
        echo '</tr>';
    }
    echo '</tbody></table>';
    wp_reset_postdata();
}

function VACoworking_front_espacios_render_form($page_url, $post_id) {
    $post_id = absint($post_id);
    $is_new = $post_id === 0;

    if (!$is_new && !VACoworking_front_espacios_can_edit_post($post_id)) {
        echo '<p>' . esc_html__('No puedes editar este espacio.', 'vacoworking') . '</p>';
        echo '<p><a href="' . esc_url($page_url) . '">' . esc_html__('Volver al listado', 'vacoworking') . '</a></p>';
        return;
    }

    $p = $is_new ? null : get_post($post_id);
    $title = $p ? $p->post_title : '';
    $content = $p ? $p->post_content : '';

    $meta = array(
        'vac_direccion' => '',
        'vac_lat' => '',
        'vac_lng' => '',
        'vac_telefono' => '',
        'vac_email' => '',
        'vac_web' => '',
        'vac_horario' => '',
        'vac_capacidad_total' => '',
        'vac_salas_json' => '',
    );
    if (!$is_new) {
        foreach ($meta as $k => $_) {
            $meta[$k] = get_post_meta($post_id, $k, true);
            if ($meta[$k] === false) {
                $meta[$k] = '';
            }
        }
    }

    $servicio_term_ids = $is_new ? array() : wp_get_post_terms($post_id, 'servicio_coworking', array('fields' => 'ids'));
    if (is_wp_error($servicio_term_ids)) {
        $servicio_term_ids = array();
    }
    $equipamiento_term_ids = $is_new ? array() : wp_get_post_terms($post_id, 'equipamiento_coworking', array('fields' => 'ids'));
    if (is_wp_error($equipamiento_term_ids)) {
        $equipamiento_term_ids = array();
    }

    $thumb = $is_new ? 0 : get_post_thumbnail_id($post_id);
    $thumb_url = $thumb ? wp_get_attachment_image_url($thumb, 'medium') : '';

    $list_url = esc_url($page_url);

    $form_action_args = array('vac_page' => 'form');
    if (!$is_new && $post_id > 0) {
        $form_action_args['vac_id'] = $post_id;
    }
    $form_action = esc_url(add_query_arg($form_action_args, $page_url));

    echo '<p><a class="vacoworking-back" href="' . $list_url . '">← ' . esc_html__('Volver al listado', 'vacoworking') . '</a></p>';
    echo '<form method="post" action="' . $form_action . '" enctype="multipart/form-data" class="vacoworking-espacio-form" onsubmit="if (typeof tinyMCE !== \'undefined\' && tinyMCE.triggerSave) { tinyMCE.triggerSave(); }">';
    wp_nonce_field('vacoworking_espacio_save', 'vacoworking_espacio_nonce');
    wp_nonce_field('vacoworking_gallery_remove', 'vacoworking_gallery_remove_nonce');
    echo '<input type="hidden" name="vac_post_id" value="' . esc_attr((string) $post_id) . '" />';
    echo '<input type="hidden" name="vacoworking_redirect" value="' . esc_attr($page_url) . '" />';

    echo '<p><label>' . esc_html__('Nombre del espacio', 'vacoworking') . ' <span class="vacoworking-required-mark">*</span><br />';
    echo '<input type="text" name="vac_title" class="widefat" required value="' . esc_attr($title) . '" autocomplete="organization" /></label></p>';

    $featured_required = $is_new || !$thumb;
    echo '<div class="vacoworking-media-block vacoworking-media-block--featured-top">';
    echo '<p class="vacoworking-media-label"><strong>' . esc_html__('Imagen principal', 'vacoworking') . '</strong>';
    echo ' <span class="vacoworking-required-mark">*</span>';
    echo '</p>';
    echo '<div class="vacoworking-featured-preview-row">';
    echo '<div id="vac-featured-server-preview" class="vacoworking-featured-server-preview">';
    if ($thumb_url) {
        echo '<div class="vacoworking-featured-preview-box"><img src="' . esc_url($thumb_url) . '" alt="" class="vacoworking-featured-preview-img" /></div>';
    } else {
        echo '<div class="vacoworking-featured-preview-box vacoworking-featured-preview-box--empty"><span>' . esc_html__('Sin imagen aún', 'vacoworking') . '</span></div>';
    }
    echo '</div>';
    echo '<div id="vac-featured-file-preview" class="vacoworking-featured-file-preview" hidden></div>';
    echo '</div>';
    echo '<p><label for="vac_featured_input">';
    echo $featured_required
        ? esc_html__('Selecciona la imagen principal', 'vacoworking')
        : esc_html__('Sustituir imagen principal', 'vacoworking');
    echo '<br />';
    echo '<input type="file" name="vac_featured" id="vac_featured_input" class="widefat vacoworking-input-file" accept="image/jpeg,image/png,image/webp"';
    if ($featured_required) {
        echo ' required';
    }
    echo ' /></label></p>';
    echo '</div>';

    echo '<p><strong>' . esc_html__('Descripción', 'vacoworking') . '</strong></p>';
    wp_editor(
        $content,
        'vac_content',
        array(
            'textarea_name' => 'vac_content',
            'media_buttons' => false,
            'textarea_rows' => 10,
            'teeny' => true,
            'quicktags' => false,
        )
    );

    VACoworking_front_espacios_render_term_checkboxes(
        'servicio_coworking',
        'vac_servicios',
        $servicio_term_ids,
        __('Servicios', 'vacoworking')
    );
    VACoworking_front_espacios_render_term_checkboxes(
        'equipamiento_coworking',
        'vac_equipamiento',
        $equipamiento_term_ids,
        __('Equipamiento', 'vacoworking')
    );

    echo '<p class="vacoworking-tax-footer-note">' . esc_html__('*Contacta con el administrador para añadir más.', 'vacoworking') . '</p>';

    echo '<h3>' . esc_html__('Ubicación y contacto', 'vacoworking') . '</h3>';
    echo '<p><label>' . esc_html__('Dirección', 'vacoworking') . '<br />';
    echo '<input type="text" name="vac_direccion" class="widefat" value="' . esc_attr($meta['vac_direccion']) . '" /></label></p>';
    echo '<p><label>' . esc_html__('Latitud', 'vacoworking') . '<br />';
    echo '<input type="text" name="vac_lat" class="widefat" value="' . esc_attr($meta['vac_lat']) . '" /></label></p>';
    echo '<p><label>' . esc_html__('Longitud', 'vacoworking') . '<br />';
    echo '<input type="text" name="vac_lng" class="widefat" value="' . esc_attr($meta['vac_lng']) . '" /></label></p>';
    echo '<p><label>' . esc_html__('Teléfono', 'vacoworking') . '<br />';
    echo '<input type="text" name="vac_telefono" class="widefat" value="' . esc_attr($meta['vac_telefono']) . '" /></label></p>';
    echo '<p><label>' . esc_html__('Email', 'vacoworking') . '<br />';
    echo '<input type="email" name="vac_email" class="widefat" value="' . esc_attr($meta['vac_email']) . '" /></label></p>';
    echo '<p><label>' . esc_html__('Web', 'vacoworking') . '<br />';
    echo '<input type="url" name="vac_web" class="widefat" value="' . esc_attr($meta['vac_web']) . '" /></label></p>';
    echo '<p><label>' . esc_html__('Horario', 'vacoworking') . '<br />';
    echo '<textarea name="vac_horario" class="widefat" rows="3">' . esc_textarea($meta['vac_horario']) . '</textarea></label></p>';
    echo '<p><label>' . esc_html__('Capacidad total (aprox.)', 'vacoworking') . '<br />';
    echo '<input type="number" name="vac_capacidad_total" class="widefat" min="0" value="' . esc_attr((string) $meta['vac_capacidad_total']) . '" /></label></p>';

    $salas_rows = array();
    if (!empty($meta['vac_salas_json']) && is_string($meta['vac_salas_json'])) {
        $decoded_salas = json_decode($meta['vac_salas_json'], true);
        if (is_array($decoded_salas)) {
            foreach ($decoded_salas as $item) {
                if (!is_array($item)) {
                    continue;
                }
                $salas_rows[] = array(
                    'nombre' => isset($item['nombre']) ? sanitize_text_field((string) $item['nombre']) : '',
                    'capacidad' => isset($item['capacidad']) ? absint($item['capacidad']) : 0,
                    'notas' => isset($item['notas']) ? sanitize_textarea_field((string) $item['notas']) : '',
                );
            }
        }
    }
    if (empty($salas_rows)) {
        $salas_rows[] = array('nombre' => '', 'capacidad' => 0, 'notas' => '');
    }
    echo '<div class="vacoworking-salas-visual">';
    echo '<p><strong>' . esc_html__('Salas', 'vacoworking') . '</strong></p>';
    echo '<p class="description">' . esc_html__('Añade o elimina filas. Las vacías se ignoran al guardar.', 'vacoworking') . '</p>';
    echo '<div id="vac-salas-rows">';
    foreach ($salas_rows as $row) {
        echo '<div class="vacoworking-salas-row">';
        echo '<p><label>' . esc_html__('Nombre', 'vacoworking') . '<br />';
        echo '<input type="text" name="vac_sala_nombre[]" class="widefat" value="' . esc_attr($row['nombre']) . '" /></label></p>';
        echo '<p><label>' . esc_html__('Capacidad', 'vacoworking') . '<br />';
        echo '<input type="number" name="vac_sala_capacidad[]" class="widefat" min="0" value="' . esc_attr((string) $row['capacidad']) . '" /></label></p>';
        echo '<p><label>' . esc_html__('Notas', 'vacoworking') . '<br />';
        echo '<input type="text" name="vac_sala_notas[]" class="widefat" value="' . esc_attr($row['notas']) . '" /></label></p>';
        echo '<p class="vacoworking-salas-row-actions"><button type="button" class="vacoworking-icon-btn vacoworking-danger vacoworking-salas-remove" title="' . esc_attr__('Eliminar sala', 'vacoworking') . '">' . VACoworking_front_espacios_icon_trash() . '<span class="vacoworking-sr-only">' . esc_html__('Eliminar sala', 'vacoworking') . '</span></button></p>';
        echo '</div>';
    }
    echo '</div>';
    echo '<div class="vacoworking-salas-controls"><button type="button" id="vac-salas-add" class="vacoworking-btn">' . esc_html__('Añadir sala', 'vacoworking') . '</button></div>';
    echo '<template id="vac-salas-template">';
    echo '<div class="vacoworking-salas-row">';
    echo '<p><label>' . esc_html__('Nombre', 'vacoworking') . '<br /><input type="text" name="vac_sala_nombre[]" class="widefat" value="" /></label></p>';
    echo '<p><label>' . esc_html__('Capacidad', 'vacoworking') . '<br /><input type="number" name="vac_sala_capacidad[]" class="widefat" min="0" value="0" /></label></p>';
    echo '<p><label>' . esc_html__('Notas', 'vacoworking') . '<br /><input type="text" name="vac_sala_notas[]" class="widefat" value="" /></label></p>';
    echo '<p class="vacoworking-salas-row-actions"><button type="button" class="vacoworking-icon-btn vacoworking-danger vacoworking-salas-remove" title="' . esc_attr__('Eliminar sala', 'vacoworking') . '">' . VACoworking_front_espacios_icon_trash() . '<span class="vacoworking-sr-only">' . esc_html__('Eliminar sala', 'vacoworking') . '</span></button></p>';
    echo '</div>';
    echo '</template>';
    echo '</div>';

    $galeria_ids = array();
    if (!$is_new) {
        $galeria_ids = VACoworking_front_espacios_get_gallery_attachment_ids($post_id);
    }

    echo '<h3>' . esc_html__('Imágenes', 'vacoworking') . '</h3>';

    echo '<div class="vacoworking-media-block vacoworking-media-block--gallery">';
    echo '<p class="vacoworking-media-label"><strong>' . esc_html__('Galería', 'vacoworking') . '</strong></p>';
    if (!empty($galeria_ids)) {
        echo '<div class="vacoworking-gallery-grid">';
        foreach ($galeria_ids as $gid) {
            if ($gid <= 0) {
                continue;
            }
            $gurl = wp_get_attachment_image_url($gid, 'medium');
            if (!$gurl) {
                continue;
            }
            echo '<div class="vacoworking-gallery-cell">';
            echo '<span class="vacoworking-gallery-thumb-wrap"><img src="' . esc_url($gurl) . '" alt="" class="vacoworking-gallery-thumb-img" /></span>';
            if (!$is_new) {
                echo '<button type="submit" name="vac_gallery_remove" value="' . esc_attr((string) $gid) . '" class="vacoworking-gallery-remove-btn" title="' . esc_attr__('Eliminar', 'vacoworking') . '" onclick="return confirm(\'' . esc_js(__('¿Eliminar esta imagen de la galería?', 'vacoworking')) . '\');"><span aria-hidden="true">×</span><span class="vacoworking-sr-only">' . esc_html__('Eliminar', 'vacoworking') . '</span></button>';
            }
            echo '</div>';
        }
        echo '</div>';
    } else {
        echo '<p class="description">' . esc_html__('Aún no hay imágenes en la galería.', 'vacoworking') . '</p>';
    }
    echo '<p><label for="vac_gallery_input">' . esc_html__('Añadir imágenes a la galería', 'vacoworking') . '<br />';
    echo '<input type="file" name="vac_gallery[]" id="vac_gallery_input" class="widefat vacoworking-input-file" multiple accept="image/jpeg,image/png,image/webp" /></label></p>';
    echo '<div id="vac-gallery-file-preview" class="vacoworking-gallery-file-preview"></div>';
    echo '</div>';

    $js_fp = wp_json_encode(__('Vista previa (se guardará al pulsar «Guardar espacio»)', 'vacoworking'));
    $js_gp = wp_json_encode(__('Vista previa de archivos seleccionados (se subirán al guardar)', 'vacoworking'));
    echo '<script>
(function(){
var fi=document.getElementById("vac_featured_input");
var prev=document.getElementById("vac-featured-file-preview");
var sv=document.getElementById("vac-featured-server-preview");
function vacFeaturedRevoke(){
if(prev&&prev._vacBlobUrl){try{URL.revokeObjectURL(prev._vacBlobUrl);}catch(e){}prev._vacBlobUrl=null;}
}
if(fi&&prev){fi.addEventListener("change",function(){
vacFeaturedRevoke();
prev.innerHTML="";
prev.hidden=true;
var f=fi.files&&fi.files[0];
if(!f){
if(sv)sv.hidden=false;
return;
}
if(!f.type.match(/^image\\//)){
if(sv)sv.hidden=false;
return;
}
if(sv)sv.hidden=true;
prev.hidden=false;
var blobUrl=URL.createObjectURL(f);
prev._vacBlobUrl=blobUrl;
var img=document.createElement("img");
img.alt="";img.className="vacoworking-featured-preview-img";
img.src=blobUrl;
prev.appendChild(img);
var cap=document.createElement("p");cap.className="description";cap.textContent=' . $js_fp . ';
prev.appendChild(cap);
});}
var g=document.getElementById("vac_gallery_input");
var gp=document.getElementById("vac-gallery-file-preview");
if(g&&gp){g.addEventListener("change",function(){
gp.innerHTML="";
var files=g.files||[];
if(!files.length)return;
var wrap=document.createElement("div");wrap.className="vacoworking-gallery-new-preview-grid";
for(var i=0;i<files.length;i++){
if(!files[i].type.match(/^image\\//))continue;
var cell=document.createElement("div");cell.className="vacoworking-gallery-new-preview-cell";
var im=document.createElement("img");im.alt="";im.src=URL.createObjectURL(files[i]);
cell.appendChild(im);wrap.appendChild(cell);
}
if(wrap.children.length){
var t=document.createElement("p");t.className="description";t.textContent=' . $js_gp . ';
gp.appendChild(t);gp.appendChild(wrap);
}
});}
var salasWrap=document.getElementById("vac-salas-rows");
var salasAdd=document.getElementById("vac-salas-add");
var salasTpl=document.getElementById("vac-salas-template");
if(salasWrap&&salasAdd&&salasTpl){
salasAdd.addEventListener("click",function(){
var node=document.importNode(salasTpl.content,true);
salasWrap.appendChild(node);
});
salasWrap.addEventListener("click",function(e){
var btn=e.target&&e.target.closest?e.target.closest(".vacoworking-salas-remove"):null;
if(!btn)return;
var rows=salasWrap.querySelectorAll(".vacoworking-salas-row");
if(rows.length<=1){
var first=rows[0];
if(!first)return;
var inputs=first.querySelectorAll("input");
for(var i=0;i<inputs.length;i++){inputs[i].value=(inputs[i].type==="number"?"0":"");}
return;
}
var row=btn.closest(".vacoworking-salas-row");
if(row)row.remove();
});
}
})();
</script>';

    echo '<p class="vacoworking-submit-wrap"><button type="submit" class="vacoworking-btn vacoworking-btn-primary vacoworking-btn-submit-wide">' . esc_html__('Guardar espacio', 'vacoworking') . '</button></p>';
    echo '</form>';
}

function VACoworking_front_espacios_print_styles() {
    ?>
<style>
.vacoworking-espacios-admin { width: 100%; max-width: 960px; margin: 0 auto; box-sizing: border-box; }
.vacoworking-espacios-header { display: flex; justify-content: space-between; align-items: center; margin-bottom: 16px; gap: 12px; flex-wrap: wrap; width: 100%; box-sizing: border-box; }
.vacoworking-btn-logout { color: #444; }
.vacoworking-btn-logout:hover { background: #eee; }
.vacoworking-notice { padding: 10px 14px; border-radius: 6px; }
.vacoworking-notice-ok { background: #e8f5e9; color: #1b5e20; }
.vacoworking-notice-err { background: #ffebee; color: #b71c1c; }
.vacoworking-required-mark { color: #c62828; font-weight: 600; }
.vacoworking-table { width: 100%; border-collapse: collapse; }
.vacoworking-table th, .vacoworking-table td { border: 1px solid #ddd; padding: 8px 10px; text-align: left; vertical-align: middle; }
.vacoworking-table th { background: #f5f5f5; }
.vacoworking-col-thumb { width: 72px; text-align: center; }
.vacoworking-list-thumb { width: 56px; height: 56px; object-fit: cover; border-radius: 8px; display: block; margin: 0 auto; }
.vacoworking-list-thumb-placeholder { display: block; width: 56px; height: 56px; margin: 0 auto; background: #e8e8e8; border-radius: 8px; border: 1px dashed #ccc; box-sizing: border-box; }
.vacoworking-actions { white-space: nowrap; text-align: right; width: 1%; }
.vacoworking-icon-btn {
  display: inline-flex; align-items: center; justify-content: center;
  width: 36px; height: 36px; margin-left: 6px;
  border: 1px solid #ccc; background: #fff; border-radius: 6px;
  cursor: pointer; text-decoration: none; font-size: 16px;
  color: #333; position: relative;
}
.vacoworking-icon-btn .vacoworking-icon-svg { display: block; flex-shrink: 0; }
.vacoworking-icon-btn:hover { background: #f0f0f0; }
.vacoworking-danger { color: #c62828; border-color: #ef9a9a; }
.vacoworking-sr-only {
  position: absolute; width: 1px; height: 1px; padding: 0; margin: -1px;
  overflow: hidden; clip: rect(0, 0, 0, 0); white-space: nowrap; border: 0;
}
.vacoworking-inline-form { display: inline; margin: 0; padding: 0; }
.vacoworking-btn { display: inline-block; padding: 10px 18px; border-radius: 6px; text-decoration: none; border: 1px solid #ccc; background: #fafafa; cursor: pointer; font-size: 15px; }
.vacoworking-btn-primary { background: #1976d2; color: #fff; border-color: #1565c0; }
.vacoworking-btn-primary:hover { filter: brightness(1.05); }
.vacoworking-espacios-admin .vacoworking-espacio-form .vacoworking-submit-wrap {
  width: 100%; max-width: 100%; box-sizing: border-box; margin: 1.5em 0 0; padding: 0;
}
.vacoworking-espacios-admin .vacoworking-espacio-form .vacoworking-btn-submit-wide {
  width: 100%; max-width: 100%; box-sizing: border-box; display: block; text-align: center;
}
/* Ancho completo: el tema suele limitar input { max-width: … }; se anula con prefijo fuerte */
.vacoworking-espacios-admin .vacoworking-espacio-form {
  display: block;
  width: 100% !important;
  max-width: 100% !important;
  box-sizing: border-box;
}
.vacoworking-espacios-admin .vacoworking-espacio-form p,
.vacoworking-espacios-admin .vacoworking-espacio-form .description {
  display: block;
  width: 100% !important;
  max-width: 100% !important;
  box-sizing: border-box;
  float: none !important;
}
.vacoworking-espacios-admin .vacoworking-espacio-form label {
  display: block !important;
  width: 100% !important;
  max-width: 100% !important;
  box-sizing: border-box;
}
.vacoworking-espacios-admin .vacoworking-espacio-form .widefat,
.vacoworking-espacios-admin .vacoworking-espacio-form input.widefat,
.vacoworking-espacios-admin .vacoworking-espacio-form input[type="text"],
.vacoworking-espacios-admin .vacoworking-espacio-form input[type="email"],
.vacoworking-espacios-admin .vacoworking-espacio-form input[type="url"],
.vacoworking-espacios-admin .vacoworking-espacio-form input[type="number"],
.vacoworking-espacios-admin .vacoworking-espacio-form input[type="file"],
.vacoworking-espacios-admin .vacoworking-espacio-form textarea {
  width: 100% !important;
  max-width: 100% !important;
  min-width: 0 !important;
  box-sizing: border-box !important;
}
.vacoworking-espacios-admin .vacoworking-espacio-form .vacoworking-input-file { padding: 8px 0; }
.vacoworking-espacios-admin .vacoworking-espacio-form .wp-editor-wrap,
.vacoworking-espacios-admin .vacoworking-espacio-form .wp-editor-container,
.vacoworking-espacios-admin .vacoworking-espacio-form .mce-tinymce,
.vacoworking-espacios-admin .vacoworking-espacio-form .mce-container-body {
  width: 100% !important;
  max-width: 100% !important;
  box-sizing: border-box;
}
.vacoworking-espacios-admin .vacoworking-espacio-form .wp-editor-area { box-sizing: border-box; width: 100% !important; }
.vacoworking-espacios-admin--solo-formulario { max-width: 100%; }
.vacoworking-espacios-admin .vacoworking-espacio-form h3 { width: 100%; max-width: 100%; box-sizing: border-box; }
/* Temas con columnas o .entry-content que encogen el shortcode */
.entry-content .vacoworking-espacios-admin,
.wp-block-column .vacoworking-espacios-admin,
main .vacoworking-espacios-admin {
  width: 100%;
  max-width: 100%;
}
.vacoworking-back { text-decoration: none; }
.vacoworking-tax-checkboxes { width: 100% !important; max-width: 100%; margin: 0 0 1.25em; padding: 0; border: 0; box-sizing: border-box; }
.vacoworking-tax-checkboxes legend { font-weight: 600; font-size: 1.05em; margin-bottom: 10px; padding: 0; float: none; width: 100%; }
/* Varias columnas que se adaptan al ancho (el tema forzaba label a 100% y todo quedaba en una columna) */
.vacoworking-espacios-admin .vacoworking-espacio-form .vacoworking-tax-checkboxes-grid {
  display: grid !important;
  grid-template-columns: repeat(auto-fill, minmax(200px, 1fr));
  gap: 8px 16px;
  align-items: center;
  width: 100%;
  box-sizing: border-box;
}
.vacoworking-espacios-admin .vacoworking-espacio-form .vacoworking-tax-checkboxes-item {
  display: inline-flex !important;
  align-items: center;
  gap: 8px;
  font-weight: normal;
  cursor: pointer;
  margin: 0 !important;
  width: auto !important;
  max-width: 100% !important;
  min-width: 0;
  box-sizing: border-box;
}
.vacoworking-espacios-admin .vacoworking-espacio-form .vacoworking-tax-checkboxes-item input {
  width: auto !important;
  min-width: auto !important;
  max-width: none !important;
  flex-shrink: 0;
}
.vacoworking-espacios-admin .vacoworking-espacio-form .vacoworking-tax-checkboxes-item span {
  min-width: 0;
  word-break: break-word;
}
.vacoworking-tax-empty { margin-top: 0; }
.vacoworking-tax-footer-note { margin: 0 0 1.25em; font-size: 0.9em; color: #555; font-style: italic; width: 100%; box-sizing: border-box; }
.vacoworking-media-block { margin-bottom: 1.5em; width: 100%; box-sizing: border-box; }
.vacoworking-media-label { margin: 0 0 10px; }
.vacoworking-featured-preview-row { display: flex; flex-wrap: wrap; gap: 12px; align-items: flex-start; margin-bottom: 10px; }
.vacoworking-featured-preview-box { border: 1px solid #ddd; border-radius: 10px; overflow: hidden; background: #fafafa; min-height: 120px; min-width: 120px; display: flex; align-items: center; justify-content: center; }
.vacoworking-featured-preview-box--empty { color: #888; padding: 16px; }
.vacoworking-featured-preview-img { display: block; max-width: 280px; max-height: 200px; width: auto; height: auto; object-fit: contain; }
.vacoworking-featured-file-preview { width: 100%; }
.vacoworking-featured-file-preview .vacoworking-featured-preview-img { max-width: 280px; border-radius: 8px; }
.vacoworking-btn-danger-outline { background: #fff; color: #c62828; border-color: #ef9a9a; }
.vacoworking-btn-danger-outline:hover { background: #ffebee; }
.vacoworking-gallery-grid { display: grid; grid-template-columns: repeat(auto-fill, minmax(140px, 1fr)); gap: 12px; margin-bottom: 12px; }
.vacoworking-gallery-cell { position: relative; border: 1px solid #ddd; border-radius: 10px; overflow: hidden; background: #f9f9f9; }
.vacoworking-gallery-thumb-wrap { display: block; aspect-ratio: 4/3; }
.vacoworking-gallery-thumb-img { width: 100%; height: 100%; object-fit: cover; display: block; }
.vacoworking-gallery-remove-btn {
  position: absolute; top: 6px; right: 6px; width: 32px; height: 32px; padding: 0; margin: 0;
  border-radius: 50%; border: 1px solid #c62828; background: rgba(255,255,255,0.95); color: #c62828;
  font-size: 22px; line-height: 1; cursor: pointer; font-weight: bold;
}
.vacoworking-gallery-remove-btn:hover { background: #ffebee; }
.vacoworking-gallery-file-preview { margin-top: 8px; }
.vacoworking-gallery-new-preview-grid { display: flex; flex-wrap: wrap; gap: 10px; margin-top: 8px; }
.vacoworking-gallery-new-preview-cell { width: 100px; height: 80px; border-radius: 8px; overflow: hidden; border: 1px solid #ddd; }
.vacoworking-gallery-new-preview-cell img { width: 100%; height: 100%; object-fit: cover; display: block; }
.vacoworking-salas-visual { margin: 0 0 1.25em; }
.vacoworking-salas-row { display: grid; grid-template-columns: 2fr 1fr 2fr auto; gap: 10px; margin: 0 0 10px; align-items: end; }
.vacoworking-espacios-admin .vacoworking-espacio-form .vacoworking-salas-row > p { width: auto !important; max-width: none !important; margin: 0; }
.vacoworking-espacios-admin .vacoworking-espacio-form .vacoworking-salas-row > p label { width: 100% !important; max-width: 100% !important; }
.vacoworking-salas-row-actions { margin: 0; text-align: right; justify-self: end; align-self: end; width: auto !important; }
.vacoworking-salas-controls { margin: 4px 0 0; }
.vacoworking-salas-remove { margin: 0; }
@media (max-width: 800px) { .vacoworking-salas-row { grid-template-columns: 1fr; } }
</style>
    <?php
}
