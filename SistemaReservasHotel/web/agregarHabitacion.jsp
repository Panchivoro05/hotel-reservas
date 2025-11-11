<%@ page contentType="text/html;charset=UTF-8" %>
<!DOCTYPE html>
<html lang="es">
<head>
    <meta charset="UTF-8">
    <title>Registrar Habitación</title>
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
                <li class="nav-item"><a class="nav-link active" href="HabitacionServlet">Habitaciones</a></li>
                <li class="nav-item"><a class="nav-link" href="ReservaServlet">Reservaciones</a></li>
            </ul>
        </div>
    </div>
</nav>

<!-- 🔹 Formulario -->
<div class="container mt-5">
    <div class="card shadow mx-auto" style="max-width: 600px;">
        <div class="card-header bg-primary text-white">
            <h5 class="mb-0">Registrar Nueva Habitación</h5>
        </div>
        <div class="card-body">
            <form action="HabitacionServlet?action=insertar" method="post">
                <div class="mb-3">
                    <label class="form-label fw-semibold">Número:</label>
                    <input type="number" name="numero" class="form-control" required>
                </div>

                <div class="mb-3">
                    <label class="form-label fw-semibold">Tipo:</label>
                    <input type="text" name="tipo" class="form-control" required>
                </div>

                <div class="mb-3">
                    <label class="form-label fw-semibold">Precio:</label>
                    <input type="number" step="0.01" name="precio" class="form-control" required>
                </div>

                <div class="d-grid">
                    <button type="submit" class="btn btn-primary">Registrar Habitación</button>
                </div>
            </form>

            <!-- 🔹 Mensajes -->
            <% if (request.getAttribute("mensaje") != null) { %>
                <div class="alert alert-success mt-4 text-center">
                    <%= request.getAttribute("mensaje") %><br>
                    <small>Redirigiendo al listado...</small>
                </div>
                <script>
                    setTimeout(() => window.location.href = 'HabitacionServlet', 2000);
                </script>
            <% } else if (request.getAttribute("error") != null) { %>
                <div class="alert alert-danger mt-4 text-center">
                    <%= request.getAttribute("error") %>
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
