<%@page import="java.util.Map"%>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<!DOCTYPE html>
<html lang="es">
<head>
    <meta charset="UTF-8">
    <title>📈 Reporte por Sexo</title>
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
    <div class="card shadow-lg">
        <div class="card-header bg-info text-white">
            <h4 class="mb-0">📊 Reporte por Sexo y Nacionalidad</h4>
        </div>
        <div class="card-body">

            <!-- Formulario de selección -->
            <form method="get" action="ReporteSexoServlet" class="mb-4">
                <label class="form-label fw-semibold">Selecciona la nacionalidad:</label>
                <input type="text" name="nacionalidad" class="form-control mb-3" placeholder="Ejemplo: Peru" required>
                <button type="submit" class="btn btn-info text-white w-100">Generar Reporte</button>
            </form>

            <!-- Resultados -->
            <%
                Map<String, Object> resultado = (Map<String, Object>) request.getAttribute("resultado");
                String nacionalidad = (String) request.getAttribute("nacionalidad");

                if (resultado != null && !resultado.isEmpty()) {
            %>
                <div class="alert alert-success text-center">
                    En <strong><%= nacionalidad %></strong>, el sexo que más ha visitado el hotel en lo que va del año es:
                    <h4 class="mt-3">
                        <span class="badge bg-primary">
                            <%= resultado.get("sexo").equals("M") ? "Masculino" : "Femenino" %>
                        </span>
                    </h4>
                    <p class="mt-2">Con un total de <strong><%= resultado.get("total") %></strong> reservaciones.</p>
                </div>
            <%
                } else if (nacionalidad != null) {
            %>
                <div class="alert alert-warning text-center">
                    No se encontraron reservas este año para la nacionalidad <strong><%= nacionalidad %></strong>.
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

