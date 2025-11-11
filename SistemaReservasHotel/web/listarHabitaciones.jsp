<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ page import="java.util.*, modelo.Habitacion" %>
<!DOCTYPE html>
<html lang="es">
<head>
    <meta charset="UTF-8">
    <title>Listado de Habitaciones</title>
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
                <li class="nav-item"><a class="nav-link active" href="HabitacionServlet">Habitaciones</a></li>
                <li class="nav-item"><a class="nav-link" href="ReservaServlet">Reservaciones</a></li>
            </ul>
        </div>
    </div>
</nav>

<!-- 🔹 Contenido principal -->
<div class="container mt-5">
    <div class="card shadow">
        <div class="card-header bg-primary text-white d-flex justify-content-between align-items-center">
            <h4 class="mb-0">🛏️ Listado de Habitaciones</h4>
            <a href="HabitacionServlet?action=nuevo" class="btn btn-light btn-sm">+ Nueva Habitación</a>
        </div>

        <div class="card-body">
            <%
                List<Habitacion> lista = (List<Habitacion>) request.getAttribute("habitaciones");
                if (lista == null || lista.isEmpty()) {
            %>
                <div class="alert alert-info text-center">No hay habitaciones registradas.</div>
            <%
                } else {
            %>
                <div class="table-responsive">
                    <table class="table table-hover align-middle text-center">
                        <thead class="table-primary">
                            <tr>
                                <th>Número</th>
                                <th>Tipo</th>
                                <th>Precio</th>
                                <th>Estado</th>
                                <th>Acciones</th>
                            </tr>
                        </thead>
                        <tbody>
                            <%
                                for (Habitacion h : lista) {
                            %>
                            <tr>
                                <td><%= h.getNumero() %></td>
                                <td><%= h.getTipo() %></td>
                                <td>S/. <%= h.getPrecio() %></td>
                                <td>
                                    <span class="badge <%= h.getEstado().equals("DISPONIBLE") ? "bg-success" : "bg-danger" %>">
                                        <%= h.getEstado() %>
                                    </span>
                                </td>
                                <td>
                                    <a href="HabitacionServlet?action=editar&id=<%= h.getId() %>" class="btn btn-warning btn-sm text-white">✏️ Editar</a>
                                    <a href="HabitacionServlet?action=eliminar&id=<%= h.getId() %>" class="btn btn-danger btn-sm"
                                       onclick="return confirm('¿Eliminar habitación?');">🗑️ Eliminar</a>
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
