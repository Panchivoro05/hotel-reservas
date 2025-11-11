<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<%@ page import="java.util.List" %>
<%@ page import="modelo.Reservacion" %>
<!DOCTYPE html>
<html lang="es">
<head>
    <meta charset="UTF-8">
    <title>Listado de Reservaciones</title>
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

<!-- 🔹 Contenido principal -->
<div class="container mt-5">
    <div class="card shadow">
        <div class="card-header bg-primary text-white d-flex justify-content-between align-items-center">
            <h4 class="mb-0">📆 Listado de Reservaciones</h4>
            <a href="ReservaServlet?action=nuevo" class="btn btn-light btn-sm">+ Nueva Reservación</a>
        </div>

        <div class="card-body">
            <%
                List<Reservacion> lista = (List<Reservacion>) request.getAttribute("reservaciones");
                if (lista == null || lista.isEmpty()) {
            %>
                <div class="alert alert-info text-center">No hay reservaciones registradas.</div>
            <%
                } else {
            %>
                <div class="table-responsive">
                    <table class="table table-hover align-middle text-center">
                        <thead class="table-primary">
                            <tr>
                                <th>ID</th>
                                <th>Código</th>
                                <th>Cliente</th>
                                <th>Habitación</th>
                                <th>Fecha Entrada</th>
                                <th>Días</th>
                                <th>Tipo</th>
                                <th>Tour</th>
                                <th>Acciones</th>
                            </tr>
                        </thead>
                        <tbody>
                            <%
                                for (Reservacion r : lista) {
                            %>
                            <tr>
                                <td><%= r.getId() %></td>
                                <td><%= r.getCodigo() %></td>
                                <td><%= r.getCliente() != null ? r.getCliente().getNombre() : "—" %></td>
                                <td>
                                    <% if (r.getHabitacion() != null) { %>
                                        Hab. <%= r.getHabitacion().getNumero() %> - <%= r.getHabitacion().getTipo() %>
                                    <% } else { %>
                                        —
                                    <% } %>
                                </td>
                                <td><%= new java.text.SimpleDateFormat("dd/MM/yyyy").format(r.getFechaEntrada()) %></td>
                                <td><%= r.getDiasEstadia() %></td>
                                <td><%= r.getTipoReservacion() %></td>
                                <td><%= r.isEsTour() ? "Sí" : "No" %></td>
                                <td>
                                    <a href="ReservaServlet?action=editar&id=<%= r.getId() %>" class="btn btn-warning btn-sm text-white">✏️ Editar</a>
                                    <a href="ReservaServlet?action=eliminar&id=<%= r.getId() %>"
                                       class="btn btn-danger btn-sm"
                                       onclick="return confirm('¿Seguro que deseas eliminar esta reservación?');">
                                       🗑️ Eliminar
                                    </a>
                                </td>
                            </tr>
                            <% } %>
                        </tbody>
                    </table>
                </div>
            <% } %>
        </div>
    </div>
</div>

<footer class="text-center text-muted mt-5 mb-3">
    © 2025 - Sistema de Reservación de Hoteles
</footer>

</body>
</html>
