<%@ page contentType="text/html; charset=UTF-8" %>
<!DOCTYPE html>
<html lang="es">
<head>
    <meta charset="UTF-8">
    <title>Reporte por Nacionalidad</title>
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/css/bootstrap.min.css" rel="stylesheet">
</head>
<body class="bg-light">

<!-- 🔹 Barra de navegación -->
    <nav class="navbar navbar-expand-lg navbar-dark bg-primary shadow-sm">
        <div class="container-fluid">
            <a class="navbar-brand fw-bold text-white" href="index.jsp">🏨 Sistema de Reservación</a>
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

<div class="container mt-5">
    <div class="card shadow-lg mx-auto" style="max-width: 600px;">
        <div class="card-body">
            <form method="get" action="ReporteServlet">
                <div class="mb-3">
                    <label class="form-label fw-semibold">Ingrese una nacionalidad:</label>
                    <input type="text" name="nacionalidad" class="form-control" placeholder="Ej: Perú" required>
                </div>
                <div class="d-grid">
                    <button type="submit" class="btn btn-primary">Calcular Porcentaje</button>
                </div>
            </form>

            <%
                String nacionalidad = (String) request.getAttribute("nacionalidad");
                Double porcentaje = (Double) request.getAttribute("porcentaje");
                if (nacionalidad != null) {
            %>
                <div class="alert alert-info mt-4 text-center">
                    En lo que va del mes, el <strong><%= String.format("%.2f", porcentaje) %>%</strong> 
                    de las reservaciones de recepción fueron hechas por clientes de 
                    <strong><%= nacionalidad %></strong>.
                </div>
            <%
                }
            %>
        </div>
    </div>
</div>

<footer class="text-center text-muted mt-5 mb-3">
    © 2025 - Sistema de Reservación de Hoteles
</footer>
<script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/js/bootstrap.bundle.min.js"></script>
</body>
</html>
