<%@ page contentType="text/html; charset=UTF-8" %>
<!DOCTYPE html>
<html lang="es">
<head>
    <meta charset="UTF-8">
    <title>Reporte por Nacionalidad</title>
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/css/bootstrap.min.css" rel="stylesheet">
</head>
<body class="bg-light">

<nav class="navbar navbar-dark bg-primary">
    <div class="container-fluid">
        <span class="navbar-brand">📊 Reporte por Nacionalidad</span>
        <a href="index.jsp" class="text-white text-decoration-none">← Volver al Inicio</a>
    </div>
</nav>

<div class="container mt-5">
    <div class="card shadow-lg mx-auto" style="max-width: 600px;">
        <div class="card-body">
            <form method="get" action="ReporteServlet">
                <div class="mb-3">
                    <label class="form-label fw-semibold">Ingrese una nacionalidad:</label>
                    <input type="text" name="nacionalidad" class="form-control" placeholder="Ej: Perú" required>
                </div>
                <div class="d-grid">
                    <button type="submit" class="btn btn-primary">Calcular Porcentaje</button>
                </div>
            </form>

            <%
                String nacionalidad = (String) request.getAttribute("nacionalidad");
                Double porcentaje = (Double) request.getAttribute("porcentaje");
                if (nacionalidad != null) {
            %>
                <div class="alert alert-info mt-4 text-center">
                    En lo que va del mes, el <strong><%= String.format("%.2f", porcentaje) %>%</strong> 
                    de las reservaciones de recepción fueron hechas por clientes de 
                    <strong><%= nacionalidad %></strong>.
                </div>
            <%
                }
            %>
        </div>
    </div>
</div>

<footer class="text-center text-muted mt-5 mb-3">
    © 2025 - Sistema de Reservación de Hoteles
</footer>

</body>
</html>
