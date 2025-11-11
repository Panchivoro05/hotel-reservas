<%@ page contentType="text/html;charset=UTF-8" %>
<%@ page import="modelo.Habitacion" %>
<%
Habitacion h = (Habitacion) request.getAttribute("habitacion");
%>
<!DOCTYPE html>
<html lang="es">
<head>
    <meta charset="UTF-8">
    <title>Editar Habitación</title>
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

<!-- 🔹 Formulario centrado -->
<div class="container mt-5">
    <div class="card shadow mx-auto" style="max-width: 600px;">
        <div class="card-header bg-warning text-white">
            <h5 class="mb-0">✏️ Editar Habitación</h5>
        </div>
        <div class="card-body">
            <form action="HabitacionServlet" method="post">
                <input type="hidden" name="action" value="actualizar">
                <input type="hidden" name="id" value="<%= h.getId() %>">

                <div class="mb-3">
                    <label class="form-label">Número</label>
                    <input type="number" name="numero" class="form-control" value="<%= h.getNumero() %>" required>
                </div>

                <div class="mb-3">
                    <label class="form-label">Tipo</label>
                    <input type="text" name="tipo" class="form-control" value="<%= h.getTipo() %>" required>
                </div>

                <div class="mb-3">
                    <label class="form-label">Precio</label>
                    <input type="number" step="0.01" name="precio" class="form-control" value="<%= h.getPrecio() %>" required>
                </div>

                <div class="mb-3">
                    <label class="form-label">Estado</label>
                    <select name="estado" class="form-select">
                        <option value="DISPONIBLE" <%= h.getEstado().equals("DISPONIBLE") ? "selected" : "" %>>DISPONIBLE</option>
                        <option value="OCUPADA" <%= h.getEstado().equals("OCUPADA") ? "selected" : "" %>>OCUPADA</option>
                    </select>
                </div>

                <div class="d-grid">
                    <button type="submit" class="btn btn-warning text-white fw-semibold">Actualizar</button>
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

