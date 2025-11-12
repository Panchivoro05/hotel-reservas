<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ page import="java.util.*, modelo.Cliente" %>
<!DOCTYPE html>
<html lang="es">
<head>
    <meta charset="UTF-8">
    <title>Listado de Clientes</title>
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/css/bootstrap.min.css" rel="stylesheet">
</head>
<body class="bg-light">

<!-- 🔹 Navbar -->
<nav class="navbar navbar-expand-lg navbar-dark bg-primary">
    <div class="container-fluid">
        <a class="navbar-brand fw-bold" href="index.jsp">🏨 Sistema de Reservación</a>
        <div class="collapse navbar-collapse">
            <ul class="navbar-nav ms-auto">
                <li class="nav-item"><a class="nav-link active" href="ClienteServlet">Clientes</a></li>
                <li class="nav-item"><a class="nav-link" href="HabitacionServlet">Habitaciones</a></li>
                <li class="nav-item"><a class="nav-link" href="ReservaServlet">Reservaciones</a></li>
            </ul>
        </div>
    </div>
</nav>

<!-- 🔹 Contenido principal -->
<div class="container mt-5">
    <div class="card shadow">
        <div class="card-header bg-primary text-white d-flex justify-content-between align-items-center">
            <h4 class="mb-0">📋 Listado de Clientes</h4>
            <a href="ClienteServlet?action=nuevo" class="btn btn-light btn-sm">+ Nuevo Cliente</a>
        </div>

        <div class="card-body">
            <%
                List<Cliente> lista = (List<Cliente>) request.getAttribute("listaClientes");
                if (lista == null || lista.isEmpty()) {
            %>
                <div class="alert alert-info text-center">No hay clientes registrados.</div>
            <%
                } else {
            %>
                <div class="table-responsive">
                    <table class="table table-hover align-middle text-center">
                        <thead class="table-primary">
                            <tr>
                                <th>ID</th>
                                <th>Nombre</th>
                                <th>Edad</th>
                                <th>Sexo</th>
                                <th>Nacionalidad</th>
                                <th>¿Ha visitado antes?</th>
                                <th>Acciones</th>
                            </tr>
                        </thead>
                        <tbody>
                            <%
                                for (Cliente c : lista) {
                            %>
                            <tr>
                                <td><%= c.getId() %></td>
                                <td><%= c.getNombre() %></td>
                                <td><%= c.getEdad() %></td>
                                <td><%= c.getSexo() %></td>
                                <td><%= c.getNacionalidad() %></td>
                                <td><%= c.isHaVisitado() ? "Sí" : "No" %></td>
                                <td>
                                    <a href="ClienteServlet?action=editar&id=<%= c.getId() %>" class="btn btn-warning btn-sm text-white">✏️ Editar</a>
                                    <a href="ClienteServlet?action=eliminar&id=<%= c.getId() %>" class="btn btn-danger btn-sm" onclick="return confirm('¿Eliminar cliente?');">🗑️ Eliminar</a>
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
