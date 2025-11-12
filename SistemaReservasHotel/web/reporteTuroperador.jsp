<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@page import="java.util.*, modelo.*"%>
<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <title>Reporte de Reservaciones por Turoperador</title>
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.2/dist/css/bootstrap.min.css" rel="stylesheet">
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
        <h2 class="text-center mb-4">📋 Reporte de Clientes por Turoperador</h2>

        <form method="get" action="ReporteTuroperadorServlet" class="mb-4">
            <div class="row">
                <div class="col-md-8">
                    <label class="form-label fw-semibold">Seleccionar Turoperador:</label>
                    <select name="codigoTuroperador" class="form-select" required>
                        <option value="">-- Seleccione un turoperador --</option>
                        <%
                            List<Turoperador> turops = (List<Turoperador>) request.getAttribute("turoperadores");
                            if (turops != null) {
                                String selectedCodigo = (String) request.getAttribute("codigoTuroperador");
                                for (Turoperador t : turops) {
                        %>
                            <option value="<%= t.getCodigo() %>" <%= (selectedCodigo != null && selectedCodigo.equals(t.getCodigo())) ? "selected" : "" %>>
                                <%= t.getNombre() %> (<%= t.getCodigo() %>)
                            </option>
                        <%
                                }
                            }
                        %>
                    </select>
                </div>
                <div class="col-md-4 d-flex align-items-end">
                    <button type="submit" class="btn btn-primary w-100">🔍 Generar Reporte</button>
                </div>
            </div>
        </form>

        <%
            List<Map<String, Object>> reporte = (List<Map<String, Object>>) request.getAttribute("reporte");
            if (reporte != null && !reporte.isEmpty()) {
        %>
        <div class="card shadow">
            <div class="card-header bg-primary text-white fw-semibold">
                Resultados del Turoperador: <%= request.getAttribute("codigoTuroperador") %>
            </div>
            <div class="card-body">
                <table class="table table-bordered table-hover">
                    <thead class="table-secondary">
                        <tr>
                            <th>Cliente</th>
                            <th>Nacionalidad</th>
                            <th>Habitación</th>
                            <th>Fecha de Entrada</th>
                        </tr>
                    </thead>
                    <tbody>
                        <% for (Map<String, Object> fila : reporte) { %>
                        <tr>
                            <td><%= fila.get("cliente") %></td>
                            <td><%= fila.get("nacionalidad") %></td>
                            <td><%= fila.get("habitacion") %></td>
                            <td><%= fila.get("fecha_entrada") %></td>
                        </tr>
                        <% } %>
                    </tbody>
                </table>
            </div>
        </div>
        <% } else if (request.getAttribute("codigoTuroperador") != null) { %>
            <div class="alert alert-warning mt-4 text-center">
                ⚠️ No se encontraron reservaciones para este turoperador.
            </div>
        <% } %>
    </div>
    <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/js/bootstrap.bundle.min.js"></script>
</body>
</html>
