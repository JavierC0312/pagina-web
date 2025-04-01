<?php
session_start(); // Iniciar la sesión para mantener al usuario logueado

include 'conexion_db.php';

if ($_SERVER["REQUEST_METHOD"] == "POST") {
    $correo = $_POST["email"];
    $contraseña = $_POST["password"];

    // Buscar el usuario en la base de datos por su correo electrónico
    $stmt = $conn->prepare("SELECT UsuarioID, Nombre, Contraseña FROM Usuarios WHERE Correo = ?");
    $stmt->bind_param("s", $correo);
    $stmt->execute();
    $stmt->store_result();

    if ($stmt->num_rows == 1) {
        $stmt->bind_result($usuario_id, $nombre_usuario, $contraseña_hasheada);
        $stmt->fetch();

        // Verificar si la contraseña proporcionada coincide con la contraseña hasheada
        if (password_verify($contraseña, $contraseña_hasheada)) {
            // La contraseña es correcta, iniciar sesión
            $_SESSION["loggedin"] = true;
            $_SESSION["usuario_id"] = $usuario_id;
            $_SESSION["nombre_usuario"] = $nombre_usuario;

            // Redirigir al usuario a la página principal o a su panel de control
            header("Location: index.php"); // Puedes cambiar esto a la página que desees
        } else {
            // Contraseña incorrecta
            echo "Contraseña incorrecta. <a href='Inicio-sesion.html'>Volver a intentar</a>";
        }
    } else {
        // No se encontró ningún usuario con ese correo electrónico
        echo "No se encontró ningún usuario con este correo electrónico. <a href='Registro.html'>¿No tienes cuenta? Regístrate</a>";
    }

    $stmt->close();
    $conn->close();
} else {
    // Si se intenta acceder a este script directamente sin enviar el formulario
    header("Location: Inicio-sesion.html");
    exit();
}
?>