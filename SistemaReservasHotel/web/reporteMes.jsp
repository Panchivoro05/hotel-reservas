<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<!DOCTYPE html>
<html lang="es">
<head>
    <meta charset="UTF-8">
    <title>📅 Reporte por Mes y Nacionalidad</title>
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
    <div class="card shadow">
        <div class="card-header bg-success text-white">
            <h4 class="mb-0">📅 Mes con más clientes por Nacionalidad (Año Pasado)</h4>
        </div>

        <div class="card-body">
            <%
                java.util.List<java.util.Map<String, Object>> reporteMes = 
                    (java.util.List<java.util.Map<String, Object>>) request.getAttribute("reporteMes");

                if (reporteMes != null && !reporteMes.isEmpty()) {
            %>
                <table class="table table-striped table-hover text-center align-middle">
                    <thead class="table-success">
                        <tr>
                            <th>Nacionalidad</th>
                            <th>Mes con más clientes</th>
                            <th>Total de Reservas</th>
                        </tr>
                    </thead>
                    <tbody>
                        <% for (java.util.Map<String, Object> fila : reporteMes) { %>
                            <tr>
                                <td><%= fila.get("nacionalidad") %></td>
                                <td><%= fila.get("mes") %></td>
                                <td><%= fila.get("total") %></td>
                            </tr>
                        <% } %>
                    </tbody>
                </table>
            <% } else { %>
                <div class="alert alert-warning text-center">
                    No se encontraron registros del año pasado.
                </div>
            <% } %>
        </div>
    </div>
</div>

<footer class="text-center text-muted mt-5 mb-3">
    © 2025 - Sistema de Reservación de Hoteles
</footer>
<script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/js/bootstrap.bundle.min.js"></script>
</body>
</html>
