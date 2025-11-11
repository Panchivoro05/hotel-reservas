<%@ page contentType="text/html; charset=UTF-8" %>
<%@ page import="modelo.Cliente" %>
<%
    Cliente cliente = (Cliente) request.getAttribute("cliente");
%>
<!DOCTYPE html>
<html lang="es">
<head>
    <meta charset="UTF-8">
    <title>Editar Cliente</title>
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/css/bootstrap.min.css" rel="stylesheet">
</head>
<body class="bg-light">

<!-- 🔹 Navbar unificada -->
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

<!-- 🔹 Formulario centrado -->
<div class="container mt-5">
    <div class="card shadow mx-auto" style="max-width: 600px;">
        <div class="card-header bg-warning text-white">
            <h5 class="mb-0">✏️ Editar Cliente</h5>
        </div>
        <div class="card-body">
            <form action="ClienteServlet" method="post">
                <input type="hidden" name="action" value="actualizar">
                <input type="hidden" name="id" value="<%= cliente.getId() %>">

                <div class="mb-3">
                    <label class="form-label fw-semibold">Nombre:</label>
                    <input type="text" name="nombre" class="form-control" value="<%= cliente.getNombre() %>" required>
                </div>

                <div class="mb-3">
                    <label class="form-label fw-semibold">Edad:</label>
                    <input type="number" name="edad" class="form-control" value="<%= cliente.getEdad() %>" required>
                </div>

                <div class="mb-3">
                    <label class="form-label fw-semibold">Sexo:</label>
                    <select name="sexo" class="form-select" required>
                        <option value="M" <%= cliente.getSexo().equals("M") ? "selected" : "" %>>Masculino</option>
                        <option value="F" <%= cliente.getSexo().equals("F") ? "selected" : "" %>>Femenino</option>
                    </select>
                </div>

                <div class="mb-3">
                    <label class="form-label fw-semibold">Nacionalidad:</label>
                    <input type="text" name="nacionalidad" class="form-control" value="<%= cliente.getNacionalidad() %>" required>
                </div>

                <div class="mb-3">
                    <label class="form-label fw-semibold">¿Ha visitado antes?</label>
                    <select name="haVisitado" class="form-select" required>
                        <option value="true" <%= cliente.isHaVisitado() ? "selected" : "" %>>Sí</option>
                        <option value="false" <%= !cliente.isHaVisitado() ? "selected" : "" %>>No</option>
                    </select>
                </div>

                <div class="d-grid">
                    <button type="submit" class="btn btn-warning text-white fw-semibold">Actualizar Cliente</button>
                </div>
            </form>
        </div>
    </div>
</div>

<!-- 🔹 Footer -->
<footer class="text-center text-muted mt-5 mb-3">
    © 2025 - Sistema de Reservación de Hoteles
</footer>

</body>
</html>
