<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ page import="java.util.*, modelo.Turoperador" %>
<!DOCTYPE html>
<html lang="es">
<head>
    <meta charset="UTF-8">
    <title>Listado de Turoperadores</title>
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/css/bootstrap.min.css" rel="stylesheet">
</head>
<body class="bg-light">

<!-- 🔹 Navbar -->
<nav class="navbar navbar-expand-lg navbar-dark bg-primary">
    <div class="container-fluid">
        <a class="navbar-brand fw-bold" href="index.jsp">🏨 Sistema de Reservación</a>
        <div class="collapse navbar-collapse">
            <ul class="navbar-nav ms-auto">
                <li class="nav-item"><a class="nav-link" href="ClienteServlet">Clientes</a></li>
                <li class="nav-item"><a class="nav-link" href="HabitacionServlet">Habitaciones</a></li>
                <li class="nav-item"><a class="nav-link" href="ReservaServlet">Reservaciones</a></li>
                <li class="nav-item"><a class="nav-link active" href="TuroperadorServlet">Turoperadores</a></li>
            </ul>
        </div>
    </div>
</nav>

<!-- 🔹 Contenido principal -->
<div class="container mt-5">
    <div class="card shadow">
        <div class="card-header bg-primary text-white d-flex justify-content-between align-items-center">
            <h4 class="mb-0">🌍 Listado de Turoperadores</h4>
            <a href="TuroperadorServlet?action=nuevo" class="btn btn-light btn-sm">+ Nuevo Turoperador</a>
        </div>

        <div class="card-body">
            <%
                List<Turoperador> lista = (List<Turoperador>) request.getAttribute("turoperadores");
                if (lista == null || lista.isEmpty()) {
            %>
                <div class="alert alert-info text-center">No hay turoperadores registrados.</div>
            <%
                } else {
            %>
                <div class="table-responsive">
                    <table class="table table-hover align-middle text-center">
                        <thead class="table-primary">
                            <tr>
                                <th>ID</th>
                                <th>Código</th>
                                <th>Nombre</th>
                                <th>Nacionalidad</th>
                                <th>Acciones</th>
                            </tr>
                        </thead>
                        <tbody>
                            <%
                                for (Turoperador t : lista) {
                            %>
                            <tr>
                                <td><%= t.getId() %></td>
                                <td><%= t.getCodigo() %></td>
                                <td><%= t.getNombre() %></td>
                                <td><%= t.getNacionalidad() %></td>
                                <td>
                                    <a href="TuroperadorServlet?action=editar&id=<%= t.getId() %>" class="btn btn-warning btn-sm text-white">✏️ Editar</a>
                                    <a href="TuroperadorServlet?action=eliminar&id=<%= t.getId() %>" class="btn btn-danger btn-sm" onclick="return confirm('¿Eliminar turoperador?');">🗑️ Eliminar</a>
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
