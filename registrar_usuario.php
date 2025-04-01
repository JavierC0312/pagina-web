<?php
include 'conexion_db.php'; // Incluye el archivo de conexión a la base de datos

if ($_SERVER["REQUEST_METHOD"] == "POST") {
    $nombre = $_POST["nombre"];
    $correo = $_POST["email"];
    $contraseña = $_POST["password"];
    $confirmar_contraseña = $_POST["confirm-password"];

    // Validar que las contraseñas coincidan (esto es una validación adicional en el backend)
    if ($contraseña !== $confirmar_contraseña) {
        echo "Las contraseñas no coinciden. <a href='Registro.html'>Volver al registro</a>";
        exit();
    }

    // Verificar si el correo ya existe en la base de datos
    $stmt_check = $conn->prepare("SELECT Correo FROM Usuarios WHERE Correo = ?");
    $stmt_check->bind_param("s", $correo);
    $stmt_check->execute();
    $stmt_check->store_result();

    if ($stmt_check->num_rows > 0) {
        echo "Este correo electrónico ya está registrado. <a href='Inicio-sesion.html'>Iniciar sesión</a>";
        $stmt_check->close();
        $conn->close();
        exit();
    }
    $stmt_check->close();

    // Hashear la contraseña por seguridad
    $contraseña_hasheada = password_hash($contraseña, PASSWORD_DEFAULT);

    // Insertar el nuevo usuario en la base de datos (asumiendo que todos los nuevos usuarios tienen RolID = 1 y PlanID = 1 por defecto)
    $rol_id_default = 1; // Puedes cambiar esto según tu lógica
    $plan_id_default = 1; // Puedes cambiar esto según tu lógica

    $stmt_insert = $conn->prepare("INSERT INTO Usuarios (Nombre, Correo, Contraseña, RolID, PlanID) VALUES (?, ?, ?, ?, ?)");
    $stmt_insert->bind_param("sssii", $nombre, $correo, $contraseña_hasheada, $rol_id_default, $plan_id_default);

    if ($stmt_insert->execute()) {
        echo "Registro exitoso. <a href='Inicio-sesion.html'>Ir a la página de inicio de sesión</a>";
    } else {
        echo "Error al registrar el usuario: " . $stmt_insert->error . " <a href='Registro.html'>Volver al registro</a>";
    }

    $stmt_insert->close();
    $conn->close();
} else {
    // Si se intenta acceder a este script directamente sin enviar el formulario
    header("Location: Registro.html");
    exit();
}
?>