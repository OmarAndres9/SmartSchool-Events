<?php
// Configuración de la base de datos PostgreSQL
$host = '127.0.0.1';
$db = 'school_event';
$user = 'postgres'; // CAMBIAR POR TU USUARIO REAL
$pass = 'ADMIN12345'; // CAMBIAR POR TU CONTRASEÑA REAL
$port = '5432';

$dsn = "pgsql:host=$host;port=$port;dbname=$db";
$options = [
     PDO::ATTR_ERRMODE => PDO::ERRMODE_EXCEPTION,
     PDO::ATTR_DEFAULT_FETCH_MODE => PDO::FETCH_ASSOC,
     PDO::ATTR_EMULATE_PREPARES => false,
];

try {
     $pdo = new PDO($dsn, $user, $pass, $options);
} catch (\PDOException $e) {
     http_response_code(500);
     echo json_encode(["error" => "Error de conexión a la base de datos: " . $e->getMessage()]);
     exit();
}
?>