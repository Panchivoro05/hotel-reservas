<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<!DOCTYPE html>
<html lang="es">
<head>
    <meta charset="UTF-8">
    <title>Registrar Turoperador</title>
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
<div class="container mt-5 col-md-6">
    <div class="card shadow border-0">
        <div class="card-header bg-primary text-white text-center">
            <h4 class="mb-0">Registrar Nuevo Turoperador</h4>
        </div>
        <div class="card-body">
            <form action="TuroperadorServlet" method="post">
                <input type="hidden" name="action" value="insertar">

                <div class="mb-3">
                    <label class="form-label fw-semibold">Código:</label>
                    <input type="text" name="codigo" class="form-control" required>
                </div>

                <div class="mb-3">
                    <label class="form-label fw-semibold">Nombre:</label>
                    <input type="text" name="nombre" class="form-control" required>
                </div>

                <div class="mb-3">
                    <label class="form-label fw-semibold">Nacionalidad:</label>
                    <input type="text" name="nacionalidad" class="form-control" required>
                </div>

                <div class="text-center">
                    <button type="submit" class="btn btn-success">💾 Guardar</button>
                    <a href="TuroperadorServlet" class="btn btn-secondary">↩ Volver</a>
                </div>
            </form>

            <% if (request.getAttribute("mensaje") != null) { %>
                <div class="alert alert-success mt-3 text-center"><%= request.getAttribute("mensaje") %></div>
            <% } else if (request.getAttribute("error") != null) { %>
                <div class="alert alert-danger mt-3 text-center"><%= request.getAttribute("error") %></div>
            <% } %>
        </div>
    </div>
</div>

<footer class="text-center text-muted mt-5 mb-3">
    © 2025 - Sistema de Reservación de Hoteles
</footer>

</body>
</html>

