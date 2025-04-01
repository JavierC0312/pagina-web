<!DOCTYPE html>
<html lang="es">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Monitoreo Inteligente</title>
    <link rel="stylesheet" href="style.css">
    <script src="https://cdn.jsdelivr.net/npm/chart.js"></script>
    <script src="https://cdn.jsdelivr.net/npm/apexcharts"></script>
    <link href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/5.15.4/css/all.min.css" rel="stylesheet">
</head>
<body>
    <header>
        <a href="index.php#"><h2>CultivaInt</h2></a>
        <nav>
            <a href="index.php?content=porque">¿Por qué contratarlo?</a>
            <a href="index.php?content=planes">Planes</a>
            <a href="index.php?content=ayuda">Ayuda</a>
            <a href="Inicio-sesion.html">Iniciar sesión</a>
            <a href="Registro.html">
                <button class="cta-button">Registrarse</button>
            </a>
            <?php
                if (isset($_SESSION["loggedin"]) && $_SESSION["loggedin"] === true) {
                    echo '<a href="index.php?content=monitoreo">Monitoreo</a>';
                    echo '<a href="logout.php">Cerrar sesión</a>'; // Nuevo enlace
                } else {
                    echo '<a href="Inicio-sesion.html">Iniciar sesión</a>';
                    echo '<a href="Registro.html"><button class="cta-button">Registrarse</button></a>';
                }
            ?>
        </nav>
    </header>

    <?php
        $content = 'index'; // Contenido por defecto

        if (isset($_GET['content'])) {
            $content = $_GET['content'];
        }

        if ($content == 'monitoreo') {
            include 'Monitoreo.php';
        } elseif ($content == 'porque') {
            include 'Porque.php';
        } elseif ($content == 'planes') {
            include 'Planes.php';
        } elseif ($content == 'ayuda') {
            include 'Ayuda.php';
        } else {
            // Contenido por defecto (sección hero)
            echo '
                <section class="hero">
                    <h1>Todo tu sistema en <span class="highlight">una sola plataforma</span></h1>
                    <p>¡Seguro, eficiente y con la mejor tecnología!</p>
                    <button class="cta-button">Empieza ahora</button>
                </section>';
        }
    ?>
<footer>
    <div class="footer-container">
        <div class="company-info">
            <h3>CultivaInt</h3>
            <p>Transformamos digitalmente tu negocio con soluciones innovadoras en tecnología y consultoría. Potenciamos el desarrollo de tu empresa a través de la digitalización.</p>
            <p><strong>Dirección:</strong> Calle Ficticia 123, Ciudad, País</p>
            <p><strong>Email:</strong> contacto@cultivaint.com</p>
            <p><strong>Teléfono:</strong> +123 456 789</p>
        </div>

        <div class="quick-links">
            <h4>Enlaces Rápidos</h4>
            <ul>
                <li><a href="index.html">Inicio</a></li>
                <li><a href="Monitoreo.html">Monitoreo</a></li>
                <li><a href="Planes.html">Planes</a></li>
                <li><a href="Porque.html">¿Por qué elegirnos?</a></li>
                <li><a href="Ayuda.html">Ayuda</a></li>
                <li><a href="Contacto.html">Contacto</a></li>
            </ul>
        </div>

        <div class="legal-links">
            <h4>Información Legal</h4>
            <ul>
                <li><a href="terminos.html">Términos y Condiciones</a></li>
                <li><a href="privacidad.html">Política de Privacidad</a></li>
                <li><a href="cookies.html">Política de Cookies</a></li>
            </ul>
        </div>

        <div class="social-links">
            <h4>Síguenos</h4>
            <a href="#" title="Facebook" aria-label="Facebook">
                <i class="fab fa-facebook"></i> Facebook
            </a>
            <a href="#" title="Twitter" aria-label="Twitter">
                <i class="fab fa-twitter"></i> Twitter
            </a>
            <a href="#" title="LinkedIn" aria-label="LinkedIn">
                <i class="fab fa-linkedin"></i> LinkedIn
            </a>
            <a href="#" title="Instagram" aria-label="Instagram">
                <i class="fab fa-instagram"></i> Instagram
            </a>
        </div>

        <div class="footer-bottom">
            <p class="copyright">© 2025 CultivaInt. Todos los derechos reservados.</p>
        </div>
    </div>
</footer>

</body>
</html>