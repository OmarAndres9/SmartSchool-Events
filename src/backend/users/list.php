<?php
header("Content-Type: application/json");
header("Access-Control-Allow-Origin: *");

require_once '../config/db.php';

try {
    // Obtenemos usuarios junto con su rol
    $sql = "SELECT u.\"Codigo_Usuar\" as id, u.\"Nombre\" as nombre, 
                   u.\"Usuario\" as usuario, u.\"Correo\" as correo, 
                   r.\"Nomb_Rol\" as rol
            FROM usuario u
            LEFT JOIN usuario_roles ur ON u.\"Codigo_Usuar\" = ur.\"Codigo_Usuar\"
            LEFT JOIN roles r ON ur.\"Codigo_Rol\" = r.\"Codigo_Rol\"
            ORDER BY u.\"Codigo_Usuar\" DESC";

    $stmt = $pdo->query($sql);
    $users = $stmt->fetchAll();

    echo json_encode($users);

} catch (Exception $e) {
    http_response_code(500);
    echo json_encode(["error" => "Error al obtener usuarios: " . $e->getMessage()]);
}
?>