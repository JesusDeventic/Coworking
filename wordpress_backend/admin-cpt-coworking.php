<?php
/**
 * CPT "Espacio coworking" + meta en REST + taxonomías (sin ACF/CPT UI).
 * Pegar en Code Snippets o cargar como mu-plugin / require desde functions.php.
 *
 * REST (ejemplos):
 * - Listar: GET /wp-json/wp/v2/espacio_coworking
 * - Uno:    GET /wp-json/wp/v2/espacio_coworking/{id}
 * - Crear:  POST /wp-json/wp/v2/espacio_coworking (usuario autenticado con permiso)
 * - Meta aparece en la respuesta bajo "meta": { vac_direccion, vac_lat, ... }
 */

if (!defined('ABSPATH')) {
    exit;
}

add_action('init', 'VACoworking_register_espacio_coworking_cpt', 5);

function VACoworking_register_espacio_coworking_cpt() {
    $labels = array(
        'name'               => 'Espacios coworking',
        'singular_name'      => 'Espacio coworking',
        'add_new'            => 'Añadir espacio',
        'add_new_item'       => 'Añadir nuevo espacio',
        'edit_item'          => 'Editar espacio',
        'new_item'           => 'Nuevo espacio',
        'view_item'          => 'Ver espacio',
        'search_items'       => 'Buscar espacios',
        'not_found'          => 'No hay espacios',
        'not_found_in_trash' => 'No hay espacios en la papelera',
        'menu_name'          => 'Espacios coworking',
    );

    register_post_type(
        'espacio_coworking',
        array(
            'labels'              => $labels,
            'public'              => true,
            'has_archive'         => true,
            'show_ui'             => true,
            'show_in_menu'        => true,
            'menu_position'       => 21,
            'menu_icon'           => 'dashicons-location',
            'supports'            => array('title', 'editor', 'thumbnail', 'excerpt', 'author', 'revisions'),
            'rewrite'             => array('slug' => 'espacio-coworking'),
            'show_in_rest'        => true,
            'rest_base'           => 'espacio_coworking',
            'capability_type'     => 'post',
            'map_meta_cap'        => true,
        )
    );

    register_taxonomy(
        'servicio_coworking',
        array('espacio_coworking'),
        array(
            'label'             => 'Servicios',
            'public'            => true,
            'hierarchical'      => false,
            'show_admin_column' => true,
            'show_in_rest'      => true,
            'rest_base'         => 'servicio_coworking',
        )
    );

    register_taxonomy(
        'equipamiento_coworking',
        array('espacio_coworking'),
        array(
            'label'             => 'Equipamiento',
            'public'            => true,
            'hierarchical'      => false,
            'show_admin_column' => true,
            'show_in_rest'      => true,
            'rest_base'         => 'equipamiento_coworking',
        )
    );

    VACoworking_register_espacio_coworking_meta();
}

/**
 * Registra meta con show_in_rest para leer/escribir desde el front o la app (usuario autenticado).
 */
function VACoworking_register_espacio_coworking_meta() {
    $meta = array(
        'vac_direccion' => array(
            'type'    => 'string',
            'default' => '',
            'sanitize_callback' => 'sanitize_text_field',
        ),
        'vac_lat' => array(
            'type'    => 'number',
            'default' => 0,
            'sanitize_callback' => 'VACoworking_sanitize_float_meta',
        ),
        'vac_lng' => array(
            'type'    => 'number',
            'default' => 0,
            'sanitize_callback' => 'VACoworking_sanitize_float_meta',
        ),
        'vac_telefono' => array(
            'type'    => 'string',
            'default' => '',
            'sanitize_callback' => 'sanitize_text_field',
        ),
        'vac_email' => array(
            'type'    => 'string',
            'default' => '',
            'sanitize_callback' => 'sanitize_email',
        ),
        'vac_web' => array(
            'type'    => 'string',
            'default' => '',
            'sanitize_callback' => 'esc_url_raw',
        ),
        'vac_horario' => array(
            'type'    => 'string',
            'default' => '',
            'sanitize_callback' => 'sanitize_textarea_field',
        ),
        'vac_capacidad_total' => array(
            'type'    => 'integer',
            'default' => 0,
            'sanitize_callback' => 'absint',
        ),
        /**
         * IDs de adjuntos para galería (además de la imagen destacada).
         * En el front: enviar array de enteros en JSON.
         */
        'vac_galeria_ids' => array(
            'type'    => 'array',
            'default' => array(),
            'sanitize_callback' => 'VACoworking_sanitize_attachment_id_array',
        ),
        /**
         * Salas: JSON libre validado. Ejemplo:
         * [{"nombre":"Sala A","capacidad":8,"notas":"Proyector"}]
         */
        'vac_salas_json' => array(
            'type'    => 'string',
            'default' => '',
            'sanitize_callback' => 'VACoworking_sanitize_salas_json',
        ),
    );

    foreach ($meta as $key => $args) {
        $show_in_rest = true;
        if ($key === 'vac_galeria_ids') {
            $show_in_rest = array(
                'schema' => array(
                    'type'  => 'array',
                    'items' => array('type' => 'integer'),
                ),
            );
        }

        register_post_meta(
            'espacio_coworking',
            $key,
            array(
                'type'              => $args['type'],
                'single'            => true,
                'default'           => isset($args['default']) ? $args['default'] : null,
                'show_in_rest'      => $show_in_rest,
                'sanitize_callback' => $args['sanitize_callback'],
                'auth_callback'     => 'VACoworking_meta_auth_edit_post',
            )
        );
    }
}

/**
 * Permite que el meta salga en REST para posts publicados (mapa / app sin login).
 * Las peticiones que modifican el post siguen exigiendo capacidad edit_post en el controlador REST.
 */
function VACoworking_meta_auth_edit_post($allowed, $meta_key, $post_id) {
    $post_id = (int) $post_id;
    if ($post_id <= 0) {
        return false;
    }
    if (get_post_status($post_id) === 'publish' && is_post_publicly_viewable($post_id)) {
        return true;
    }
    return current_user_can('edit_post', $post_id);
}

function VACoworking_sanitize_float_meta($value) {
    if ($value === '' || $value === null) {
        return 0.0;
    }
    return is_numeric($value) ? (float) $value : 0.0;
}

function VACoworking_sanitize_attachment_id_array($value) {
    if (!is_array($value)) {
        return array();
    }
    $out = array();
    foreach ($value as $id) {
        $id = absint($id);
        if ($id > 0) {
            $out[] = $id;
        }
    }
    return array_values(array_unique($out));
}

function VACoworking_sanitize_salas_json($value) {
    if ($value === '' || $value === null) {
        return '';
    }
    if (!is_string($value)) {
        return '';
    }
    $decoded = json_decode(wp_unslash($value), true);
    if (!is_array($decoded)) {
        return '';
    }
    return wp_json_encode($decoded);
}
