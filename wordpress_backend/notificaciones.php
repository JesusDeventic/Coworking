<?php
if (!defined('ABSPATH')) {
    exit;
}

//require_once __DIR__ . '/VACoworking_translations.php'; // No hace falta porque estan en otro snippet

/**
 * =========================================================
 * CREAR TABLA DE NOTIFICACIONES
 * =========================================================
 * DÃ©jalo activo una vez para crear/actualizar la tabla.
 * Luego, si quieres, comentas el add_action de abajo.
 */

function VACoworking_notifications_create_table() {
    global $wpdb;

    $charset_collate = $wpdb->get_charset_collate();
    $table_name = $wpdb->prefix . 'VACoworking_notifications';

    require_once ABSPATH . 'wp-admin/includes/upgrade.php';

    $sql = "CREATE TABLE {$table_name} (
        id BIGINT UNSIGNED NOT NULL AUTO_INCREMENT,
        title VARCHAR(255) NOT NULL,
        message TEXT NOT NULL,
        topic VARCHAR(120) NOT NULL DEFAULT 'global',
        created_at DATETIME NOT NULL,
        PRIMARY KEY (id),
        KEY topic (topic),
        KEY created_at (created_at)
    ) {$charset_collate};";

    dbDelta($sql);
}
add_action('init', 'VACoworking_notifications_create_table');

/**
 * =========================================================
 * ENDPOINTS
 * =========================================================
 */
add_action('rest_api_init', function () {
    register_rest_route('VACoworking/v1', '/push/register-token', [
        'methods' => 'POST',
        'callback' => 'VACoworking_register_push_token',
        'permission_callback' => '__return_true',
    ]);

    register_rest_route('VACoworking/v1', '/push/unregister-token', [
        'methods' => 'POST',
        'callback' => 'VACoworking_unregister_push_token',
        'permission_callback' => '__return_true',
    ]);

    register_rest_route('VACoworking/v1', '/notifications', [
        'methods' => 'GET',
        'callback' => 'VACoworking_get_notifications',
        'permission_callback' => '__return_true',
    ]);

    register_rest_route('VACoworking/v1', '/notifications/topics', [
        'methods' => 'GET',
        'callback' => 'VACoworking_get_notification_topics',
        'permission_callback' => '__return_true',
    ]);

    register_rest_route('VACoworking/v1', '/notifications/send', [
        'methods' => 'POST',
        'callback' => 'VACoworking_send_global_notification',
        'permission_callback' => '__return_true',
    ]);
});

/**
 * =========================================================
 * HELPERS GENERALES
 * =========================================================
 */
function VACoworking_notifications_error($code, $message, $status = 400) {
    return new WP_Error($code, $message, ['status' => $status]);
}

function VACoworking_notifications_get_json_params(WP_REST_Request $request) {
    $params = $request->get_json_params();
    return is_array($params) ? $params : [];
}

function VACoworking_get_authenticated_user_id_or_error(WP_REST_Request $request) {
    if (!function_exists('VACoworking_auth_validate_token')) {
        return VACoworking_notifications_error('auth_not_available', 'La autenticaciÃ³n de VACoworking no estÃ¡ disponible.', 500);
    }

    return VACoworking_auth_validate_token($request);
}

/**
 * =========================================================
 * TOKENS FCM EN USERMETA
 * =========================================================
 */
function VACoworking_get_user_fcm_tokens($user_id) {
    $tokens = get_user_meta($user_id, 'VACoworking_fcm_tokens', true);
    return is_array($tokens) ? $tokens : [];
}

function VACoworking_token_is_not_target($token, $target) {
    return (string) $token !== (string) $target;
}

function VACoworking_add_user_fcm_token($user_id, $fcm_token) {
    $tokens = VACoworking_get_user_fcm_tokens($user_id);

    if (!in_array($fcm_token, $tokens, true)) {
        $tokens[] = $fcm_token;
        update_user_meta($user_id, 'VACoworking_fcm_tokens', $tokens);
    }

    return $tokens;
}

function VACoworking_remove_user_fcm_token($user_id, $fcm_token) {
    $tokens = VACoworking_get_user_fcm_tokens($user_id);
    $filtered = array();
    foreach ($tokens as $token) {
        if (VACoworking_token_is_not_target($token, $fcm_token)) {
            $filtered[] = $token;
        }
    }
    $tokens = array_values($filtered);

    update_user_meta($user_id, 'VACoworking_fcm_tokens', $tokens);

    return $tokens;
}

function VACoworking_create_global_notification($title, $message, $topic = 'global') {
    global $wpdb;

    $table_name = $wpdb->prefix . 'VACoworking_notifications';
    $topic = VACoworking_sanitize_notification_topic($topic);
    $wpdb->insert(
        $table_name,
        [
            'title' => $title,
            'message' => $message,
            'topic' => $topic,
            'created_at' => current_time('mysql'),
        ],
        ['%s', '%s', '%s', '%s']
    );

    return (int) $wpdb->insert_id;
}

function VACoworking_sanitize_notification_topic($topic) {
    $topic = sanitize_key((string) $topic);
    if ($topic === '') {
        return 'global';
    }
    return $topic;
}

/**
 * =========================================================
 * PUSH - REGISTRAR / ELIMINAR TOKEN
 * =========================================================
 */
function VACoworking_register_push_token(WP_REST_Request $request) {
    $user_id = VACoworking_get_authenticated_user_id_or_error($request);

    if (is_wp_error($user_id)) {
        return $user_id;
    }

    $params = VACoworking_notifications_get_json_params($request);
    $fcm_token = sanitize_text_field($params['fcm_token'] ?? '');

    if ($fcm_token === '') {
        return VACoworking_notifications_error('missing_fcm_token', 'El fcm_token es obligatorio.', 400);
    }

    VACoworking_add_user_fcm_token($user_id, $fcm_token);

    return new WP_REST_Response([
        'success' => true,
        'message' => 'Token push registrado correctamente.',
    ], 200);
}

function VACoworking_unregister_push_token(WP_REST_Request $request) {
    $user_id = VACoworking_get_authenticated_user_id_or_error($request);

    if (is_wp_error($user_id)) {
        return $user_id;
    }

    $params = VACoworking_notifications_get_json_params($request);
    $fcm_token = sanitize_text_field($params['fcm_token'] ?? '');

    if ($fcm_token === '') {
        return VACoworking_notifications_error('missing_fcm_token', 'El fcm_token es obligatorio.', 400);
    }

    VACoworking_remove_user_fcm_token($user_id, $fcm_token);

    return new WP_REST_Response([
        'success' => true,
        'message' => 'Token push eliminado correctamente.',
    ], 200);
}

/**
 * =========================================================
 * NOTIFICACIONES - LISTADO
 * =========================================================
 */
function VACoworking_get_notifications(WP_REST_Request $request) {
    global $wpdb;

    $page = max(1, (int) ($request->get_param('page') ?: 1));
    $per_page = max(1, min((int) ($request->get_param('per_page') ?: 20), 100));
    $offset = ($page - 1) * $per_page;
    $topic = VACoworking_sanitize_notification_topic((string) $request->get_param('topic'));
    $all_topics = !empty($request->get_param('all_topics'));
    $since_id = (int) ($request->get_param('since_id') ?: 0);

    $table_name = $wpdb->prefix . 'VACoworking_notifications';

    $where = "1=1";
    $params = [];
    if (!$all_topics) {
        $where .= " AND topic = %s";
        $params[] = $topic;
    }
    if ($since_id > 0) {
        $where .= " AND id > %d";
        $params[] = $since_id;
    }

    $total_sql = "SELECT COUNT(*) FROM {$table_name} WHERE {$where}";
    $total = (int) $wpdb->get_var(!empty($params) ? $wpdb->prepare($total_sql, $params) : $total_sql);

    $list_sql = "SELECT id, title, message, topic, created_at
                 FROM {$table_name}
                 WHERE {$where}
                 ORDER BY created_at DESC
                 LIMIT %d OFFSET %d";
    $list_params = $params;
    $list_params[] = $per_page;
    $list_params[] = $offset;
    $notifications = $wpdb->get_results($wpdb->prepare($list_sql, $list_params), ARRAY_A);

    foreach ($notifications as &$notification) {
        $notification['id'] = (int) $notification['id'];
        $notification['topic'] = (string) ($notification['topic'] ?? 'global');
    }

    return new WP_REST_Response([
        'success' => true,
        'mode' => 'global',
        'notifications' => $notifications,
        'total' => $total,
        'page' => $page,
        'per_page' => $per_page,
        'total_pages' => (int) ceil($total / $per_page),
    ], 200);
}

/**
 * =========================================================
 * TOPICS DISPONIBLES (para construir filtros/suscripciones en app)
 * =========================================================
 */
function VACoworking_get_notification_topics(WP_REST_Request $request) {
    global $wpdb;
    $table_name = $wpdb->prefix . 'VACoworking_notifications';
    $rows = $wpdb->get_results("SELECT topic, COUNT(*) as total FROM {$table_name} GROUP BY topic ORDER BY topic ASC", ARRAY_A);
    $topics = [];
    foreach ($rows as $row) {
        $topics[] = [
            'topic' => (string) $row['topic'],
            'count' => (int) $row['total'],
        ];
    }
    return new WP_REST_Response([
        'success' => true,
        'topics' => $topics,
    ], 200);
}

/**
 * =========================================================
 * ENVIO GLOBAL (admin/editor): guarda notificacion + push por topic
 * =========================================================
 */
function VACoworking_send_global_notification(WP_REST_Request $request) {
    $user_id = VACoworking_get_authenticated_user_id_or_error($request);
    if (is_wp_error($user_id)) {
        return $user_id;
    }
    if (!VACoworking_notifications_user_is_admin_or_editor((int) $user_id)) {
        return VACoworking_notifications_error('forbidden', 'No tienes permisos para enviar notificaciones globales.', 403);
    }

    $params = VACoworking_notifications_get_json_params($request);
    $title = sanitize_text_field($params['title'] ?? '');
    $message = sanitize_textarea_field($params['message'] ?? '');
    $topic = VACoworking_sanitize_notification_topic($params['topic'] ?? 'global');
    $send_push = !isset($params['send_push']) || (bool) $params['send_push'];
    if ($title === '' || $message === '') {
        return VACoworking_notifications_error('missing_fields', 'title y message son obligatorios.', 400);
    }

    $notification_id = VACoworking_create_global_notification($title, $message, $topic);
    $push_result = [
        'success' => true,
        'sent' => $send_push ? 1 : 0,
        'topic' => $topic,
    ];
    if ($send_push) {
        $send = VACoworking_send_push_to_topic($topic, $title, $message);
        if (is_wp_error($send)) {
            $push_result = [
                'success' => false,
                'error' => $send->get_error_message(),
                'data' => $send->get_error_data(),
                'topic' => $topic,
            ];
        } else {
            $push_result = [
                'success' => true,
                'topic' => $topic,
                'provider_response' => $send,
            ];
        }
    }

    return new WP_REST_Response([
        'success' => true,
        'mode' => 'global',
        'notification_id' => (int) $notification_id,
        'topic' => $topic,
        'push' => $push_result,
    ], 200);
}

function VACoworking_notifications_user_is_admin_or_editor($user_id) {
    $user = get_userdata((int) $user_id);
    if (!$user) {
        return false;
    }
    $roles = (array) $user->roles;
    return in_array('administrator', $roles, true) || in_array('editor', $roles, true);
}

/**
 * =========================================================
 * FIREBASE FCM HTTP v1
 * =========================================================
 * Necesitas en wp-config.php:
 *
 * define('VACoworking_FIREBASE_PROJECT_ID', 'tu-project-id');
 * define('VACoworking_FIREBASE_SERVICE_ACCOUNT_PATH', ABSPATH . 'wp-content/VACoworking-firebase.json o ruta que sea');
 */

function VACoworking_firebase_base64url_encode($data) {
    return rtrim(strtr(base64_encode($data), '+/', '-_'), '=');
}

function VACoworking_get_firebase_access_token() {
    if (!defined('VACoworking_FIREBASE_SERVICE_ACCOUNT_PATH')) {
        return new WP_Error('firebase_config_missing', 'VACoworking_FIREBASE_SERVICE_ACCOUNT_PATH no estÃ¡ definida.');
    }

    $path = VACoworking_FIREBASE_SERVICE_ACCOUNT_PATH;

    if (!file_exists($path)) {
        return new WP_Error('firebase_service_account_missing', 'No se encuentra el JSON de la cuenta de servicio.');
    }

    $service_account = json_decode(file_get_contents($path), true);

    if (
        empty($service_account['client_email']) ||
        empty($service_account['private_key']) ||
        empty($service_account['token_uri'])
    ) {
        return new WP_Error('firebase_service_account_invalid', 'El JSON de la cuenta de servicio no es vÃ¡lido.');
    }

    $now = time();

    $header = [
        'alg' => 'RS256',
        'typ' => 'JWT',
    ];

    $claim_set = [
        'iss' => $service_account['client_email'],
        'scope' => 'https://www.googleapis.com/auth/firebase.messaging',
        'aud' => $service_account['token_uri'],
        'iat' => $now,
        'exp' => $now + 3600,
    ];

    $jwt_header = VACoworking_firebase_base64url_encode(wp_json_encode($header));
    $jwt_claims = VACoworking_firebase_base64url_encode(wp_json_encode($claim_set));
    $unsigned_jwt = $jwt_header . '.' . $jwt_claims;

    $signature = '';
    $private_key = openssl_pkey_get_private($service_account['private_key']);

    if (!$private_key) {
        return new WP_Error('firebase_private_key_invalid', 'No se pudo cargar la private key.');
    }

    $signed = openssl_sign($unsigned_jwt, $signature, $private_key, 'sha256WithRSAEncryption');
    openssl_free_key($private_key);

    if (!$signed) {
        return new WP_Error('firebase_jwt_sign_failed', 'No se pudo firmar el JWT de Google.');
    }

    $jwt = $unsigned_jwt . '.' . VACoworking_firebase_base64url_encode($signature);

    $response = wp_remote_post($service_account['token_uri'], [
        'headers' => [
            'Content-Type' => 'application/x-www-form-urlencoded',
        ],
        'body' => [
            'grant_type' => 'urn:ietf:params:oauth:grant-type:jwt-bearer',
            'assertion' => $jwt,
        ],
        'timeout' => 20,
    ]);

    if (is_wp_error($response)) {
        return $response;
    }

    $body = json_decode(wp_remote_retrieve_body($response), true);

    if (empty($body['access_token'])) {
        return new WP_Error('firebase_access_token_failed', 'No se pudo obtener el access token de Firebase.', [
            'response' => $body,
        ]);
    }

    return $body['access_token'];
}

function VACoworking_send_push_to_token($fcm_token, $title, $message) {
    if (!defined('VACoworking_FIREBASE_PROJECT_ID')) {
        return new WP_Error('firebase_project_missing', 'VACoworking_FIREBASE_PROJECT_ID no estÃ¡ definida.');
    }

    $access_token = VACoworking_get_firebase_access_token();

    if (is_wp_error($access_token)) {
        return $access_token;
    }

    $endpoint = 'https://fcm.googleapis.com/v1/projects/' . VACoworking_FIREBASE_PROJECT_ID . '/messages:send';

    $payload = [
        'message' => [
            'token' => $fcm_token,
            'notification' => [
                'title' => $title,
                'body' => $message,
            ],
        ],
    ];

    $response = wp_remote_post($endpoint, [
        'headers' => [
            'Authorization' => 'Bearer ' . $access_token,
            'Content-Type' => 'application/json; charset=UTF-8',
        ],
        'body' => wp_json_encode($payload),
        'timeout' => 20,
    ]);

    if (is_wp_error($response)) {
        return $response;
    }

    $code = wp_remote_retrieve_response_code($response);
    $body = json_decode(wp_remote_retrieve_body($response), true);

    if ($code < 200 || $code >= 300) {
        return new WP_Error('firebase_send_failed', 'Error enviando push a Firebase.', [
            'status_code' => $code,
            'response' => $body,
        ]);
    }

    return $body;
}

function VACoworking_send_push_to_topic($topic, $title, $message) {
    if (!defined('VACoworking_FIREBASE_PROJECT_ID')) {
        return new WP_Error('firebase_project_missing', 'VACoworking_FIREBASE_PROJECT_ID no estÃ¡ definida.');
    }

    $access_token = VACoworking_get_firebase_access_token();

    if (is_wp_error($access_token)) {
        return $access_token;
    }

    $endpoint = 'https://fcm.googleapis.com/v1/projects/' . VACoworking_FIREBASE_PROJECT_ID . '/messages:send';

    $payload = [
        'message' => [
            'topic' => $topic,
            'notification' => [
                'title' => $title,
                'body' => $message,
            ],
            'data' => [
                'click_action' => 'FLUTTER_NOTIFICATION_CLICK',
                'topic' => $topic,
            ],
        ],
    ];

    $response = wp_remote_post($endpoint, [
        'headers' => [
            'Authorization' => 'Bearer ' . $access_token,
            'Content-Type' => 'application/json; charset=UTF-8',
        ],
        'body' => wp_json_encode($payload),
        'timeout' => 20,
    ]);

    if (is_wp_error($response)) {
        return $response;
    }

    $code = wp_remote_retrieve_response_code($response);
    $body = json_decode(wp_remote_retrieve_body($response), true);

    if ($code < 200 || $code >= 300) {
        return new WP_Error('firebase_send_failed', 'Error enviando push a Firebase (topic).', [
            'status_code' => $code,
            'response' => $body,
        ]);
    }

    return $body;
}

