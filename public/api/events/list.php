<?php
header("Content-Type: application/json");
header("Access-Control-Allow-Origin: *");

require_once '../config/db.php';

try {
    $sql = "SELECT \"Codigo_Event\" as id, \"Nomb_Event\" as nombre, 
                   \"Tipo_Event\" as tipo, \"Fecha_ingre\" as fecha, 
                   \"Lugar_Event\" as lugar, \"Modalidad\" as modalidad,
                   \"Descrp_Event\" as descripcion
            FROM eventos
            ORDER BY \"Fecha_ingre\" ASC";

    $stmt = $pdo->query($sql);
    $events = $stmt->fetchAll();

    echo json_encode($events);

} catch (Exception $e) {
    http_response_code(500);
    echo json_encode(["error" => "Error al obtener eventos: " . $e->getMessage()]);
}
?>