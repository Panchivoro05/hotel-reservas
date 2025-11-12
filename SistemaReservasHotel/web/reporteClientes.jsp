<%@ page contentType="text/html; charset=UTF-8" %>
<%@ page import="java.util.*" %>
<%
    List<Map<String, Object>> clientesFrecuentes = 
        (List<Map<String, Object>>) request.getAttribute("clientesFrecuentes");
%>
<!DOCTYPE html>
<html lang="es">
<head>
    <meta charset="UTF-8">
    <title>Reporte de Clientes Frecuentes</title>
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/css/bootstrap.min.css" rel="stylesheet">
</head>
<body class="bg-light">

<nav class="navbar navbar-expand-lg navbar-dark bg-primary">
    <div class="container-fluid">
        <a class="navbar-brand fw-bold" href="index.jsp">🏨 Sistema de Reservación</a>
    </div>
</nav>

<div class="container mt-5">
    <div class="card shadow">
        <div class="card-header bg-primary text-white">
            <h4 class="mb-0">📊 Clientes Más Frecuentes</h4>
        </div>
        <div class="card-body">
            <% if (clientesFrecuentes == null || clientesFrecuentes.isEmpty()) { %>
                <div class="alert alert-warning text-center">⚠️ No se encontraron registros.</div>
            <% } else { %>
                <table class="table table-bordered table-striped">
                    <thead class="table-primary">
                        <tr class="text-center">
                            <th>#</th>
                            <th>Cliente</th>
                            <th>Total de Reservas</th>
                        </tr>
                    </thead>
                    <tbody>
                        <% 
                            int i = 1;
                            for (Map<String, Object> fila : clientesFrecuentes) {
                        %>
                        <tr class="text-center">
                            <td><%= i++ %></td>
                            <td><%= fila.get("cliente") %></td>
                            <td><%= fila.get("total_reservas") %></td>
                        </tr>
                        <% } %>
                    </tbody>
                </table>
            <% } %>
        </div>
    </div>
</div>

<footer class="text-center text-muted mt-4 mb-3">
    © 2025 - Sistema de Reservación de Hoteles
</footer>

</body>
</html>
