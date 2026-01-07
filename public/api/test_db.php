<?php
header("Content-Type: text/plain");

echo "Diagnosticando conexión a PostgreSQL...\n";
echo "---------------------------------------\n";

// 1. Verificar si la extensión PGSQL está habilitada
if (!extension_loaded('pdo_pgsql')) {
    echo "[ERROR] La extensión 'pdo_pgsql' no está habilitada en PHP.\n";
    echo "Habilítala en tu archivo php.ini descomentando: extension=pdo_pgsql\n";
    exit;
} else {
    echo "[OK] Extensión 'pdo_pgsql' detectada.\n";
}

// 2. Intentar conexión
require_once 'config/db.php';

if (isset($pdo)) {
    echo "[OK] Conexión exitosa a la base de datos '$db' en '$host'.\n";
    echo "Versión del servidor: " . $pdo->getAttribute(PDO::ATTR_SERVER_VERSION) . "\n";
} else {
    echo "[ERROR] La variable \$pdo no está definida. Revisa config/db.php.\n";
}
?>