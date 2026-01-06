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

$usuario = $data['username'];
$password = $data['password'];

try {
    // Buscar usuario
    $sql = "SELECT u.*, r.\"Nomb_Rol\" as RolNombre 
            FROM usuario u
            JOIN usuario_roles ur ON u.\"Codigo_Usuar\" = ur.\"Codigo_Usuar\"
            JOIN roles r ON ur.\"Codigo_Rol\" = r.\"Codigo_Rol\"
            WHERE u.\"Usuario\" = :user";

    $stmt = $pdo->prepare($sql);
    $stmt->execute([':user' => $usuario]);
    $user = $stmt->fetch();

    if ($user && $user['Contrasena'] === $password) {
        // Login exitoso
        // Quitamos la contraseña del response
        unset($user['Contrasena']);

        echo json_encode([
            "message" => "Login exitoso",
            "user" => $user
        ]);
    } else {
        http_response_code(401);
        echo json_encode(["error" => "Credenciales inválidas"]);
    }

} catch (Exception $e) {
    http_response_code(500);
    echo json_encode(["error" => "Error interno: " . $e->getMessage()]);
}
?>