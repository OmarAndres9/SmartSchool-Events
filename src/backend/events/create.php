<?php
header("Content-Type: application/json");
header("Access-Control-Allow-Origin: *");
header("Access-Control-Allow-Methods: POST");
header("Access-Control-Allow-Headers: Content-Type");

require_once '../config/db.php';

$data = json_decode(file_get_contents("php://input"), true);

if (!$data) {
    http_response_code(400);
    echo json_encode(["error" => "Datos no válidos"]);
    exit();
}

$nombre = $data['nombre'];
$tipo = $data['tipo'];
$fecha = $data['fecha']; // YYYY-MM-DD
$hora = $data['hora'];   // HH:MM
$lugar = $data['lugar'];
$descripcion = $data['descripcion'];

// Campos por defecto o adicionales
$modalidad = $data['modalidad'] ?? 'Presencial';
$objetivo = $data['objetivo'] ?? 'General';
$control = $data['control'] ?? 'U001'; // Debería venir de la sesión
$grupo = $data['grupo'] ?? 'Todos';

// Construir Fecha Final (por defecto 2 horas después)
$fechaFinal = $fecha . ' ' . date('H:i:s', strtotime($hora) + 7200);

try {
    $pdo->beginTransaction();

    // 1. Generar ID de Evento (Exxx)
    $stmt = $pdo->query("SELECT \"Codigo_Event\" FROM eventos ORDER BY \"Codigo_Event\" DESC LIMIT 1");
    $lastEvent = $stmt->fetch();

    $newId = 'E01';
    if ($lastEvent) {
        $lastId = $lastEvent['Codigo_Event']; // ej 'E09'
        $num = intval(substr($lastId, 1)); // 9
        $newId = 'E' . str_pad($num + 1, 2, '0', STR_PAD_LEFT);
    }

    // 2. Insertar Evento
    $sql = "INSERT INTO eventos (
        \"Codigo_Event\", \"Tipo_Event\", \"Fecha_ingre\", \"Hora\", 
        \"Fecha_Final\", \"Lugar_Event\", \"Modalidad\", \"Descrp_Event\", 
        \"Objetiv_Event\", \"Control_Person\", \"Nomb_Event\", \"Grupo_Destinad\"
    ) VALUES (
        :id, :tipo, :fecha, :hora, 
        :final, :lugar, :modal, :desc, 
        :obj, :ctrl, :nomb, :grup
    )";

    $stmtIns = $pdo->prepare($sql);
    $stmtIns->execute([
        ':id' => $newId,
        ':tipo' => $tipo,
        ':fecha' => $fecha,
        ':hora' => $hora,
        ':final' => $fechaFinal,
        ':lugar' => $lugar,
        ':modal' => $modalidad,
        ':desc' => $descripcion,
        ':obj' => $objetivo,
        ':ctrl' => $control,
        ':nomb' => $nombre,
        ':grup' => $grupo
    ]);

    $pdo->commit();
    echo json_encode(["message" => "Evento creado exitosamente", "eventId" => $newId]);

} catch (Exception $e) {
    $pdo->rollBack();
    http_response_code(500);
    echo json_encode(["error" => "Error al crear evento: " . $e->getMessage()]);
}
?>