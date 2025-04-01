<?php
include 'conexion_db.php'; // Incluye el archivo de conexión

if ($_SERVER["REQUEST_METHOD"] == "POST") {
    $nombre = $_POST["nombre"];
    $contacto = $_POST["contacto"];
    $ubicacion = $_POST["ubicacion"];
    $usuario_id = $_POST["usuario_id"] ?? null; // Obtener el valor o null si no se proporciona

    $sql = "INSERT INTO Productores (Nombre, Contacto, Ubicacion, UsuarioID) VALUES (?, ?, ?, ?)";
    $stmt = $conn->prepare($sql);
    $stmt->bind_param("sssi", $nombre, $contacto, $ubicacion, $usuario_id);

    if ($stmt->execute()) {
        echo "Productor agregado correctamente.";
    } else {
        echo "Error al agregar el productor: " . $stmt->error;
    }

    $stmt->close();
    $conn->close();
}
?>