<?php
/**
 * Endpoints REST para mapa/filtros de espacios coworking.
 *
 * Rutas:
 * - GET /wp-json/VACoworking/v1/coworking/map
 * - GET /wp-json/VACoworking/v1/coworking/filters
 *
 * Requiere:
 * - CPT espacio_coworking y taxonomias servicio_coworking/equipamiento_coworking
 * - Meta: vac_lat, vac_lng, vac_direccion, vac_capacidad_total, vac_salas_json, vac_galeria_ids
 */

if (!defined('ABSPATH')) {  //Seguridad, constante que WordPress define al arrancar para evitar accesos directos desde el navegador sin pasar por WordPress
    exit;
}

add_action('rest_api_init', 'VACoworking_map_register_routes'); //rest_api_init es un hook de WordPress que se ejecuta cuando se inicializa la API REST y mi función VACoworking_map_register_routes la registra

function VACoworking_map_register_routes() { //crea 2 endpoints
    register_rest_route('VACoworking/v1', '/coworking/map', array( //pedira lista de espacios de coworking
        'methods'             => 'GET',                           //método HTTP
        'callback'            => 'VACoworking_map_get_spaces',   //función que se ejecuta cuando se llama al endpoint
        'permission_callback' => '__return_true',                //permiso para que cualquier persona pueda acceder
    ));

    register_rest_route('VACoworking/v1', '/coworking/filters', array(  //pedira opciones de filtros
        'methods'             => 'GET',
        'callback'            => 'VACoworking_map_get_filters',
        'permission_callback' => '__return_true',
    ));
}

//funcion que obtiene los espacios coworking de la base de datos
function VACoworking_map_get_spaces(WP_REST_Request $request) { 

   //Captura y limpieza de filtros
    $search = trim((string) $request->get_param('search')); //busca por nombre o dirección

    $servicio_ids = VACoworking_map_parse_term_filter($request->get_param('servicios'), 'servicio_coworking'); //filtra por servicios
    $equipamiento_ids = VACoworking_map_parse_term_filter($request->get_param('equipamientos'), 'equipamiento_coworking'); //filtra por equipamientos

    $cap_total_min = VACoworking_map_parse_int_or_null($request->get_param('cap_total_min')); //filtra por capacidad total mínima
    $cap_total_max = VACoworking_map_parse_int_or_null($request->get_param('cap_total_max')); //filtra por capacidad total máxima
    $sala_cap_min = VACoworking_map_parse_int_or_null($request->get_param('sala_cap_min')); //filtra por capacidad de sala mínima
    $sala_cap_max = VACoworking_map_parse_int_or_null($request->get_param('sala_cap_max')); //filtra por capacidad de sala máxima


    //Paginacion, control de cantidad de elementos por página
    $page = max(1, (int) $request->get_param('page'));  //página actual
    $per_page = (int) $request->get_param('per_page');  //número de elementos por página
    if ($per_page <= 0) {
        $per_page = 50;  //valor por defecto
    }
    $per_page = min(200, $per_page);  //límite máximo
    

    //guarda datos de filtros en dos tablas: taxonomías y metadatos, logica de consultas

    $tax_query = array();      //consulta taxonomías, como servicios o equipamientos
    if (!empty($servicio_ids)) {
        $tax_query[] = array(
            'taxonomy' => 'servicio_coworking',
            'field'    => 'term_id',
            'terms'    => $servicio_ids,
            'operator' => 'AND', // Debe tener todos los servicios seleccionados
        );
    }
    if (!empty($equipamiento_ids)) {
        $tax_query[] = array(
            'taxonomy' => 'equipamiento_coworking',
            'field'    => 'term_id',
            'terms'    => $equipamiento_ids,
            'operator' => 'AND', // Debe tener todos los equipamientos seleccionados
        );
    }
    if (count($tax_query) > 1) {
        $tax_query['relation'] = 'AND';
    }

    $meta_query = array();     //consulta metadatos, como capacidades maximas de personas
    if ($cap_total_min !== null || $cap_total_max !== null) {
        $meta_query[] = array(
            'key'     => 'vac_capacidad_total',
            'type'    => 'NUMERIC',
            'value'   => array(
                $cap_total_min !== null ? $cap_total_min : 0,
                $cap_total_max !== null ? $cap_total_max : PHP_INT_MAX,
            ),
            'compare' => 'BETWEEN',
        );
    }
    if (!empty($meta_query)) {
        $meta_query['relation'] = 'AND';
    }

    //Pedido a la base de Datos

    $args = array(              //Lista de instrucciones para WP_Query
        'post_type'      => 'espacio_coworking',
        'post_status'    => 'publish',
        'posts_per_page' => $per_page,
        'paged'          => $page,
        's'              => $search,
        'orderby'        => 'date',
        'order'          => 'DESC',
    );
    if (!empty($tax_query)) {
        $args['tax_query'] = $tax_query;
    }
    if (!empty($meta_query)) {
        $args['meta_query'] = $meta_query;
    }


    //Ir a la base de datos y obtener los espacios
    $q = new WP_Query($args);


    //Procesamiento de resultados

    $items = array();  //array de espacios
    foreach ($q->posts as $post) {
        $item = VACoworking_map_build_space_item($post); //convierte el post en un array
        if (!$item) {
            continue; //si no se puede convertir, salta al siguiente post
        } 
        if (!VACoworking_map_match_sala_capacity_filter($item, $sala_cap_min, $sala_cap_max)) {  //filtra por capacidad de sala
            continue; //si no cumple con el filtro de capacidad de sala, salta al siguiente post
        }
        $items[] = $item; //agrega el espacio al array
    }

    //devuelve la respuesta, la convierte en JSON
    return rest_ensure_response(array( 
        'success' => true, 
        'page' => $page,
        'per_page' => $per_page,
        'found_posts' => (int) $q->found_posts, 
        'total_pages' => (int) $q->max_num_pages,
        'count' => count($items),
        'filters_applied' => array(
            'search' => $search,
            'servicios' => $servicio_ids,
            'equipamientos' => $equipamiento_ids,
            'cap_total_min' => $cap_total_min, 
            'cap_total_max' => $cap_total_max,
            'sala_cap_min' => $sala_cap_min,
            'sala_cap_max' => $sala_cap_max,
        ),
        'items' => $items, 
    ));
}

//muestra los filtros para el mapa
function VACoworking_map_get_filters(WP_REST_Request $request) {
    $servicios = get_terms(array(                                 //obtiene los términos de la taxonomía servicio_coworking
        'taxonomy' => 'servicio_coworking',
        'hide_empty' => false,
        'orderby' => 'name',
        'order' => 'ASC',
    ));
    $equipamientos = get_terms(array(                            //obtiene los términos de la taxonomía equipamiento_coworking
        'taxonomy' => 'equipamiento_coworking',
        'hide_empty' => false,
        'orderby' => 'name',
        'order' => 'ASC',
    ));

    $servicios_out = array();
    if (!is_wp_error($servicios)) {
        foreach ($servicios as $term) {
            $servicios_out[] = array(
                'id' => (int) $term->term_id,
                'slug' => (string) $term->slug,
                'name' => (string) $term->name,
                'count' => (int) $term->count,
            );
        }
    }

    $equipamientos_out = array();
    if (!is_wp_error($equipamientos)) {
        foreach ($equipamientos as $term) {
            $equipamientos_out[] = array(
                'id' => (int) $term->term_id,
                'slug' => (string) $term->slug,
                'name' => (string) $term->name,
                'count' => (int) $term->count,
            );
        }
    }

    $capacity_stats = VACoworking_map_get_capacity_stats();    //busca cual es la capacidad mínima y máxima de todos los coworkings en la base de datos

    return rest_ensure_response(array(
        'success' => true,
        'servicios' => $servicios_out,
        'equipamientos' => $equipamientos_out,
        'capacity' => $capacity_stats,
    ));
}

//función que obtiene estadísticas de capacidad
function VACoworking_map_get_capacity_stats() {
    $q = new WP_Query(array(
        'post_type' => 'espacio_coworking',  // tipo de post
        'post_status' => 'publish',          // solo publicados
        'posts_per_page' => -1,              // todos
        'fields' => 'ids',                   // solo IDs para performance
        'no_found_rows' => true,             // no necesitamos total
    ));

    $total_values = array();
    $sala_values = array();

    foreach ($q->posts as $post_id) {
        $cap_total = (int) get_post_meta($post_id, 'vac_capacidad_total', true);
        if ($cap_total > 0) {
            $total_values[] = $cap_total;
        }

        $salas = VACoworking_map_parse_salas_json(get_post_meta($post_id, 'vac_salas_json', true));
        foreach ($salas as $sala) {
            if (isset($sala['capacidad']) && is_numeric($sala['capacidad'])) {
                $cap = absint($sala['capacidad']);
                if ($cap > 0) {
                    $sala_values[] = $cap;
                }
            }
        }
    }

    return array(
        'cap_total' => array(
            'min' => !empty($total_values) ? min($total_values) : 0,
            'max' => !empty($total_values) ? max($total_values) : 0,
        ),
        'sala_cap' => array(
            'min' => !empty($sala_values) ? min($sala_values) : 0,
            'max' => !empty($sala_values) ? max($sala_values) : 0,
        ),
    );
}


//toma los datos de la base de datos y los prepara en un array para enviar al frontend
function VACoworking_map_build_space_item($post) {
    $post_id = (int) $post->ID;                                   // ID del post
    $lat = (float) get_post_meta($post_id, 'vac_lat', true);      // latitud
    $lng = (float) get_post_meta($post_id, 'vac_lng', true);      // longitud
    if ($lat === 0.0 && $lng === 0.0) {                           // si no tiene coordenadas, no se muestra
        return null;
    }

    $cap_total = (int) get_post_meta($post_id, 'vac_capacidad_total', true);
    $direccion = (string) get_post_meta($post_id, 'vac_direccion', true);
    $telefono = (string) get_post_meta($post_id, 'vac_telefono', true);
    $email = (string) get_post_meta($post_id, 'vac_email', true);
    $web = (string) get_post_meta($post_id, 'vac_web', true);
    $horario = (string) get_post_meta($post_id, 'vac_horario', true);

    $thumb_id = (int) get_post_thumbnail_id($post_id);
    $featured_url = $thumb_id ? wp_get_attachment_image_url($thumb_id, 'large') : '';
    $featured_thumb = $thumb_id ? wp_get_attachment_image_url($thumb_id, 'medium') : '';

    $gallery_ids = VACoworking_map_parse_gallery_ids(get_post_meta($post_id, 'vac_galeria_ids', true));
    $gallery_urls = array();
    foreach ($gallery_ids as $aid) {
        $url = wp_get_attachment_image_url($aid, 'large');
        if ($url) {
            $gallery_urls[] = $url;
        }
    }

    $servicios = VACoworking_map_get_terms_for_post($post_id, 'servicio_coworking');
    $equipamientos = VACoworking_map_get_terms_for_post($post_id, 'equipamiento_coworking');
    $salas = VACoworking_map_parse_salas_json(get_post_meta($post_id, 'vac_salas_json', true));

    $sala_capacities = array();
    foreach ($salas as $sala) {
        if (isset($sala['capacidad']) && is_numeric($sala['capacidad'])) {
            $c = absint($sala['capacidad']);
            if ($c > 0) {
                $sala_capacities[] = $c;
            }
        }
    }

    return array(
        'id' => $post_id,
        'name' => get_the_title($post_id),
        'excerpt' => get_the_excerpt($post_id),
        'content' => apply_filters('the_content', $post->post_content),
        'location' => array(
            'lat' => $lat,
            'lng' => $lng,
            'direccion' => $direccion,
        ),
        'contact' => array(
            'telefono' => $telefono,
            'email' => $email,
            'web' => $web,
            'horario' => $horario,
        ),
        'capacity' => array(
            'total' => $cap_total,
            'sala_min' => !empty($sala_capacities) ? min($sala_capacities) : 0,
            'sala_max' => !empty($sala_capacities) ? max($sala_capacities) : 0,
        ),
        'media' => array(
            'featured' => $featured_url ?: '',
            'featured_thumb' => $featured_thumb ?: '',
            'gallery' => $gallery_urls,
        ),
        'servicios' => $servicios,
        'equipamientos' => $equipamientos,
        'salas' => $salas,
    );
}


function VACoworking_map_get_terms_for_post($post_id, $taxonomy) {
    $terms = wp_get_post_terms($post_id, $taxonomy);
    if (is_wp_error($terms) || empty($terms)) {
        return array();
    }
    $out = array();
    foreach ($terms as $term) {
        $out[] = array(
            'id' => (int) $term->term_id,
            'slug' => (string) $term->slug,
            'name' => (string) $term->name,
        );
    }
    return $out;
}

function VACoworking_map_match_sala_capacity_filter($item, $min, $max) {
    if ($min === null && $max === null) {
        return true;
    }
    if (empty($item['salas']) || !is_array($item['salas'])) {
        return false;
    }
    foreach ($item['salas'] as $sala) {
        if (!isset($sala['capacidad']) || !is_numeric($sala['capacidad'])) {
            continue;
        }
        $cap = absint($sala['capacidad']);
        if ($min !== null && $cap < $min) {
            continue;
        }
        if ($max !== null && $cap > $max) {
            continue;
        }
        return true;
    }
    return false;
}

function VACoworking_map_parse_salas_json($raw) {
    if (!is_string($raw) || $raw === '') {
        return array();
    }
    $decoded = json_decode($raw, true);
    if (!is_array($decoded)) {
        return array();
    }
    $out = array();
    foreach ($decoded as $row) {
        if (!is_array($row)) {
            continue;
        }
        $out[] = array(
            'nombre' => isset($row['nombre']) ? sanitize_text_field((string) $row['nombre']) : '',
            'capacidad' => isset($row['capacidad']) && is_numeric($row['capacidad']) ? absint($row['capacidad']) : 0,
            'notas' => isset($row['notas']) ? sanitize_textarea_field((string) $row['notas']) : '',
        );
    }
    return $out;
}

function VACoworking_map_parse_gallery_ids($raw) {
    if (is_array($raw)) {
        $arr = $raw;
    } elseif (is_string($raw) && $raw !== '') {
        $decoded = json_decode($raw, true);
        $arr = is_array($decoded) ? $decoded : array();
    } else {
        $arr = array();
    }
    $ids = array();
    foreach ($arr as $v) {
        $id = absint($v);
        if ($id > 0) {
            $ids[] = $id;
        }
    }
    return array_values(array_unique($ids));
}

function VACoworking_map_parse_int_or_null($value) {
    if ($value === null || $value === '') {
        return null;
    }
    if (!is_numeric($value)) {
        return null;
    }
    return max(0, (int) $value);
}

/**
 * Acepta CSV de ids/slugs o array mixto.
 * Ej: ?servicios=1,2 o ?servicios=wifi,salas-reunion
 */
function VACoworking_map_parse_term_filter($raw, $taxonomy) {
    if ($raw === null || $raw === '') {
        return array();
    }
    $parts = is_array($raw) ? $raw : explode(',', (string) $raw);
    $term_ids = array();
    foreach ($parts as $part) {
        $part = trim((string) $part);
        if ($part === '') {
            continue;
        }
        if (ctype_digit($part)) {
            $id = absint($part);
            if ($id > 0) {
                $term_ids[] = $id;
            }
            continue;
        }
        $term = get_term_by('slug', sanitize_title($part), $taxonomy);
        if ($term && !is_wp_error($term)) {
            $term_ids[] = (int) $term->term_id;
        }
    }
    return array_values(array_unique(array_filter($term_ids)));
}
