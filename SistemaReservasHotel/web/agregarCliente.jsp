<%@ page contentType="text/html;charset=UTF-8" %>
<!DOCTYPE html>
<html lang="es">
<head>
    <meta charset="UTF-8">
    <title>Registrar Cliente</title>
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

<!-- 🔹 Formulario -->
<div class="container mt-5">
    <div class="card shadow mx-auto" style="max-width: 600px;">
        <div class="card-header bg-primary text-white">
            <h5 class="mb-0">Registrar Nuevo Cliente</h5>
        </div>
        <div class="card-body">
            <form action="ClienteServlet?action=insertar" method="post">
                <div class="mb-3">
                    <label class="form-label fw-semibold">Nombre:</label>
                    <input type="text" name="nombre" class="form-control" required>
                </div>

                <div class="mb-3">
                    <label class="form-label fw-semibold">Edad:</label>
                    <input type="number" name="edad" class="form-control" required>
                </div>

                <div class="mb-3">
                    <label class="form-label fw-semibold">Sexo:</label>
                    <select name="sexo" class="form-select" required>
                        <option value="M">Masculino</option>
                        <option value="F">Femenino</option>
                    </select>
                </div>

                <div class="mb-3">
                    <label class="form-label fw-semibold">Nacionalidad:</label>
                    <input type="text" name="nacionalidad" class="form-control" required>
                </div>

                <div class="mb-3">
                    <label class="form-label fw-semibold">¿Ha visitado antes?</label>
                    <select name="haVisitado" class="form-select" required>
                        <option value="true">Sí</option>
                        <option value="false">No</option>
                    </select>
                </div>

                <div class="d-grid">
                    <button type="submit" class="btn btn-primary">Registrar Cliente</button>
                </div>
            </form>

            <!-- 🔹 Mensajes -->
            <% if (request.getAttribute("mensaje") != null) { %>
                <div class="alert alert-success mt-4 text-center">
                    <%= request.getAttribute("mensaje") %><br>
                    <small>Redirigiendo al listado...</small>
                </div>
                <script>
                    setTimeout(() => window.location.href = 'ClienteServlet', 2000);
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


