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

$nombre = $data['fullName'];
$usuario = $data['username'];
$email = $data['email'];
$password = $data['password']; // En producción: password_hash($data['password'], PASSWORD_DEFAULT);
$role = $data['role']; // 'admin', 'teacher', etc. Mapularemos esto a IDs

// Mapeo simple de roles (esto debería estar en la BD, pero lo harcodeamos para coincidir con la lógica)
$roleMap = [
    'admin' => 'R01',
    'teacher' => 'R02',
    'student' => 'R03',
    'parent' => 'R04'
];
$codigoRol = $roleMap[$role] ?? 'R03';

// Campos adicionales (asumiendo valores por defecto o vacíos si no vienen en el form original)
$documento = isset($data['documento']) ? $data['documento'] : 0;
$tipoDoc = isset($data['tipoDoc']) ? $data['tipoDoc'] : 'CC';

try {
    $pdo->beginTransaction();

    // 1. Generar ID de Usuario (Uxxx)
    // Buscamos el último ID para incrementar
    $stmt = $pdo->query("SELECT \"Codigo_Usuar\" FROM usuario ORDER BY \"Codigo_Usuar\" DESC LIMIT 1");
    $lastUser = $stmt->fetch();

    $newId = 'U001';
    if ($lastUser) {
        $lastId = $lastUser['Codigo_Usuar']; // ej 'U010'
        $num = intval(substr($lastId, 1)); // 10
        $newId = 'U' . str_pad($num + 1, 3, '0', STR_PAD_LEFT);
    }

    // 2. Insertar Usuario
    $sqlUser = "INSERT INTO usuario (\"Codigo_Usuar\", \"Nombre\", \"Documento\", \"Tip_Doc\", \"Usuario\", \"Contrasena\", \"Correo\") 
                VALUES (:id, :nombre, :doc, :tdoc, :user, :pass, :mail)";

    $stmtUser = $pdo->prepare($sqlUser);
    $stmtUser->execute([
        ':id' => $newId,
        ':nombre' => $nombre,
        ':doc' => $documento,
        ':tdoc' => $tipoDoc,
        ':user' => $usuario,
        ':pass' => $password,
        ':mail' => $email
    ]);

    // 3. Asignar Rol
    $sqlRole = "INSERT INTO usuario_roles (\"Codigo_Usuar\", \"Codigo_Rol\") VALUES (:uid, :rid)";
    $stmtRole = $pdo->prepare($sqlRole);
    $stmtRole->execute([
        ':uid' => $newId,
        ':rid' => $codigoRol
    ]);

    $pdo->commit();
    echo json_encode(["message" => "Usuario registrado exitosamente", "userId" => $newId]);

} catch (Exception $e) {
    $pdo->rollBack();
    http_response_code(500);
    echo json_encode(["error" => "Error al registrar: " . $e->getMessage()]);
}
?>