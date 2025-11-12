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

<nav class="navbar navbar-dark bg-primary">
    <div class="container-fluid">
        <a class="navbar-brand" href="index.jsp">Sistema de Reservación</a>
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

</body>
</html>

