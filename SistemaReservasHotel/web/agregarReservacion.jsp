<%@page import="java.util.List"%>
<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<!DOCTYPE html>
<html lang="es">
<head>
    <meta charset="UTF-8">
    <title>Registrar Nueva Reservación</title>
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/css/bootstrap.min.css" rel="stylesheet">
</head>
<body class="bg-light">

<!-- 🔹 Navbar unificada -->
<nav class="navbar navbar-expand-lg navbar-dark bg-primary">
    <div class="container-fluid">
        <a class="navbar-brand fw-bold" href="index.jsp">🏨 Sistema de Reservación</a>
        <div class="collapse navbar-collapse">
            <ul class="navbar-nav ms-auto">
                <li class="nav-item"><a class="nav-link" href="ClienteServlet">Clientes</a></li>
                <li class="nav-item"><a class="nav-link" href="HabitacionServlet">Habitaciones</a></li>
                <li class="nav-item"><a class="nav-link active" href="ReservaServlet">Reservaciones</a></li>
            </ul>
        </div>
    </div>
</nav>

<!-- 🔹 Formulario centrado -->
<div class="container mt-5">
    <div class="card shadow-lg mx-auto" style="max-width: 700px; border-radius: 12px;">
        <div class="card-header bg-primary text-white text-center fw-semibold">
            🧾 Registrar Nueva Reservación
        </div>
        <div class="card-body p-4">

            <form action="ReservaServlet?action=insertar" method="post">

                <div class="mb-3">
                    <label class="form-label fw-semibold">Código de Reservación:</label>
                    <input type="text" name="codigo" class="form-control" required>
                </div>

                <div class="mb-3">
                    <label class="form-label fw-semibold">Cliente:</label>
                    <select name="idCliente" class="form-select" required>
                        <option value="">-- Selecciona un cliente --</option>
                        <% 
                            List<modelo.Cliente> clientes = (List<modelo.Cliente>) request.getAttribute("clientes");
                            if (clientes != null) {
                                for (modelo.Cliente cli : clientes) {
                        %>
                            <option value="<%= cli.getId() %>"><%= cli.getNombre() %></option>
                        <% 
                                }
                            } 
                        %>
                    </select>
                </div>

                <div class="mb-3">
                    <label class="form-label fw-semibold">Habitación:</label>
                    <select name="idHabitacion" class="form-select" required>
                        <option value="">-- Selecciona una habitación --</option>
                        <% 
                            List<modelo.Habitacion> habitaciones = (List<modelo.Habitacion>) request.getAttribute("habitaciones");
                            if (habitaciones != null) {
                                for (modelo.Habitacion hab : habitaciones) {
                        %>
                            <option value="<%= hab.getId() %>">Habitación <%= hab.getNumero() %> - <%= hab.getTipo() %></option>
                        <% 
                                }
                            } 
                        %>
                    </select>
                </div>

                <div class="mb-3">
                    <label class="form-label fw-semibold">ID Turoperador (opcional):</label>
                    <input type="number" name="idTuroperador" class="form-control">
                </div>

                <div class="mb-3">
                    <label class="form-label fw-semibold">Fecha de Entrada:</label>
                    <input type="date" name="fechaEntrada" class="form-control" required>
                </div>

                <div class="mb-3">
                    <label class="form-label fw-semibold">Días de Estadía:</label>
                    <input type="number" name="diasEstadia" class="form-control" min="1" required>
                </div>

                <div class="form-check mb-3">
                    <input type="checkbox" name="esTour" class="form-check-input" id="esTour">
                    <label for="esTour" class="form-check-label fw-semibold">¿Es Tour?</label>
                </div>

                <div class="mb-4">
                    <label class="form-label fw-semibold">Tipo de Reservación:</label>
                    <select name="tipoReservacion" class="form-select" required>
                        <option value="RECEPCION">Recepción</option>
                        <option value="TUROPERADOR">Turoperador</option>
                    </select>
                </div>

                <div class="d-grid">
                    <button type="submit" class="btn btn-primary btn-lg fw-semibold">
                        💾 Registrar Reservación
                    </button>
                </div>
            </form>

            <!-- 🔹 Mensajes dinámicos -->
            <%
                String mensaje = (String) request.getAttribute("mensaje");
                String error = (String) request.getAttribute("error");
                if (mensaje != null) {
            %>
                <div class="alert alert-success mt-3 text-center"><%= mensaje %></div>
            <% } else if (error != null) { %>
                <div class="alert alert-danger mt-3 text-center"><%= error %></div>
            <% } %>

        </div>
    </div>
</div>

<!-- 🔹 Footer -->
<footer class="text-center text-muted mt-5 mb-3">
    © 2025 - Sistema de Reservación de Hoteles
</footer>

</body>
</html>
