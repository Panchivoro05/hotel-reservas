<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<!DOCTYPE html>
<html lang="es">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Sistema de Reservación de Hoteles</title>
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/css/bootstrap.min.css" rel="stylesheet">
</head>
<body class="bg-light">

    <!-- 🔹 Barra de navegación -->
    <nav class="navbar navbar-expand-lg navbar-dark bg-primary">
        <div class="container-fluid">
            <a class="navbar-brand fw-bold" href="#">🏨 Sistema de Reservación</a>
            <button class="navbar-toggler" type="button" data-bs-toggle="collapse" data-bs-target="#navbarNav">
                <span class="navbar-toggler-icon"></span>
            </button>
            <div class="collapse navbar-collapse" id="navbarNav">
                <ul class="navbar-nav ms-auto">
                    <li class="nav-item"><a class="nav-link" href="ClienteServlet">Clientes</a></li>
                    <li class="nav-item"><a class="nav-link" href="HabitacionServlet">Habitaciones</a></li>
                    <li class="nav-item"><a class="nav-link" href="ReservaServlet?tipo=RECEPCION">Reservas Recepción</a></li>
                    <li class="nav-item"><a class="nav-link" href="ReservaServlet?tipo=TUROPERADOR">Reservas Turoperador</a></li>
                    <li class="nav-item"><a class="nav-link" href="ReservaServlet?action=nuevo">Nueva Reservación</a></li>
                </ul>
            </div>
        </div>
    </nav>

    <!-- 🔹 Contenido principal -->
    <div class="container mt-5 text-center">
        <h1 class="fw-bold text-primary mb-4">Bienvenido al Sistema de Reservación de Hoteles</h1>
        <p class="lead text-muted mb-5">
            Administra clientes, habitaciones y reservaciones desde un solo lugar.
        </p>

        <!-- 🔹 Tarjetas de acceso rápido -->
        <div class="row justify-content-center g-4">
            <div class="col-md-3">
                <div class="card shadow border-0 h-100">
                    <div class="card-body">
                        <h4 class="fw-semibold mb-3">👤 Clientes</h4>
                        <p>Gestiona el registro y la información de los clientes.</p>
                        <a href="ClienteServlet" class="btn btn-primary w-100">Ir a Clientes</a>
                    </div>
                </div>
            </div>

            <div class="col-md-3">
                <div class="card shadow border-0 h-100">
                    <div class="card-body">
                        <h4 class="fw-semibold mb-3">🏠 Habitaciones</h4>
                        <p>Administra las habitaciones disponibles y ocupadas.</p>
                        <a href="HabitacionServlet" class="btn btn-warning text-white w-100">Ir a Habitaciones</a>
                    </div>
                </div>
            </div>

            <div class="col-md-3">
                <div class="card shadow border-0 h-100">
                    <div class="card-body">
                        <h4 class="fw-semibold mb-3">📅 Reservaciones</h4>
                        <p>Controla y registra las reservaciones activas del hotel.</p>
                        <a href="ReservaServlet" class="btn btn-success w-100">Ir a Reservaciones</a>
                    </div>
                </div>
            </div>
        </div>
    </div>

    <!-- 🔹 Pie de página -->
    <footer class="text-center text-muted mt-5 mb-3">
        © 2025 - Sistema de Reservación de Hoteles
    </footer>

    <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/js/bootstrap.bundle.min.js"></script>
</body>
</html>
