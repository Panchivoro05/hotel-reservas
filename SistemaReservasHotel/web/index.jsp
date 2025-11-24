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
    <nav class="navbar navbar-expand-lg navbar-dark bg-primary shadow-sm">
        <div class="container-fluid">
            <a class="navbar-brand fw-bold text-white" href="index.jsp">Sistema de Reservación</a>
            <button class="navbar-toggler" type="button" data-bs-toggle="collapse" data-bs-target="#navbarNav">
                <span class="navbar-toggler-icon"></span>
            </button>

            <div class="collapse navbar-collapse" id="navbarNav">
                <ul class="navbar-nav ms-auto">
                    <li class="nav-item"><a class="nav-link text-white" href="ClienteServlet">Clientes</a></li>
                    <li class="nav-item"><a class="nav-link text-white" href="HabitacionServlet">Habitaciones</a></li>

                    <li class="nav-item dropdown">
                        <a class="nav-link dropdown-toggle text-white" href="#" id="reservasDropdown" role="button" data-bs-toggle="dropdown">
                            Reservas
                        </a>
                        <ul class="dropdown-menu dropdown-menu-end">
                            <li><a class="dropdown-item" href="ReservaServlet?tipo=RECEPCION">Recepción</a></li>
                            <li><a class="dropdown-item" href="ReservaServlet?tipo=TUROPERADOR">Turoperador</a></li>
                            <li><a class="dropdown-item" href="ReservaServlet?action=nuevo">Nueva Reservación</a></li>
                        </ul>
                    </li>

                    <li class="nav-item"><a class="nav-link text-white" href="TuroperadorServlet">Turoperadores</a></li>

                    <li class="nav-item dropdown">
                        <a class="nav-link dropdown-toggle text-white" href="#" id="reportesDropdown" role="button" data-bs-toggle="dropdown">
                            Reportes
                        </a>
                        <ul class="dropdown-menu dropdown-menu-end">
                            <li><a class="dropdown-item" href="ReporteServlet">Por Nacionalidad</a></li>
                            <li><a class="dropdown-item" href="ReporteMesServlet">Por Mes</a></li>
                            <li><a class="dropdown-item" href="ReporteSexoServlet">Por Sexo</a></li>
                            <li><a class="dropdown-item" href="ReporteClientesServlet">Clientes Frecuentes</a></li>
                            <li><a class="dropdown-item" href="ReporteTuroperadorServlet">Clientes por Turoperador</a></li>
                        </ul>
                    </li>
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
            <div class="col-md-3 d-flex">
                <div class="card shadow border-0 flex-fill">
                    <div class="card-body d-flex flex-column">
                        <h4 class="fw-semibold mb-3">👤 Clientes</h4>
                        <p class="flex-grow-1">Gestiona el registro y la información de los clientes.</p>
                        <a href="ClienteServlet" class="btn btn-primary w-100 mt-auto">Ir a Clientes</a>
                    </div>
                </div>
            </div>

            <div class="col-md-3 d-flex">
                <div class="card shadow border-0 flex-fill">
                    <div class="card-body d-flex flex-column">
                        <h4 class="fw-semibold mb-3">🏠 Habitaciones</h4>
                        <p class="flex-grow-1">Administra las habitaciones disponibles y ocupadas.</p>
                        <a href="HabitacionServlet" class="btn btn-warning text-white w-100 mt-auto">Ir a Habitaciones</a>
                    </div>
                </div>
            </div>

            <div class="col-md-3 d-flex">
                <div class="card shadow border-0 flex-fill">
                    <div class="card-body d-flex flex-column">
                        <h4 class="fw-semibold mb-3">📅 Reservaciones</h4>
                        <p class="flex-grow-1">Controla y registra las reservaciones activas del hotel.</p>
                        <a href="ReservaServlet" class="btn btn-success w-100 mt-auto">Ir a Reservaciones</a>
                    </div>
                </div>
            </div>

            <div class="col-md-3 d-flex">
                <div class="card shadow border-0 flex-fill">
                    <div class="card-body d-flex flex-column">
                        <h4 class="fw-semibold mb-3">🌍 Turoperadores</h4>
                        <p class="flex-grow-1">Gestiona las agencias asociadas y sus reservas.</p>
                        <a href="TuroperadorServlet" class="btn btn-info text-white w-100 mt-auto">Ir a Turoperadores</a>
                    </div>
                </div>
            </div>

            <div class="col-md-3 d-flex">
                <div class="card shadow border-0 flex-fill">
                    <div class="card-body d-flex flex-column">
                        <h4 class="fw-semibold mb-3">📊 Reportes</h4>
                        <p class="flex-grow-1">Consulta los reportes detallados de desempeño del hotel.</p>
                        <a href="ReporteServlet" class="btn btn-secondary w-100 mt-auto">Ver Reportes</a>
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

