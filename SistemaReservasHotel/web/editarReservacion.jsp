<%@ page contentType="text/html; charset=UTF-8" %>
<%@ page import="dao.ReservacionDAO, modelo.Reservacion" %>
<%
    int id = Integer.parseInt(request.getParameter("id"));
    ReservacionDAO dao = new ReservacionDAO();
    Reservacion reserva = null;
    for (Reservacion r : dao.listarPorTipo("RECEPCION")) {
        if (r.getId() == id) { 
            reserva = r; 
            break; 
        }
    }
%>
<!DOCTYPE html>
<html lang="es">
<head>
    <meta charset="UTF-8">
    <title>Editar Reservación</title>
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
                <li class="nav-item"><a class="nav-link" href="HabitacionServlet">Habitaciones</a></li>
                <li class="nav-item"><a class="nav-link active" href="ReservaServlet">Reservaciones</a></li>
            </ul>
        </div>
    </div>
</nav>

<!-- 🔹 Contenido principal -->
<div class="container mt-5">
    <div class="card shadow mx-auto" style="max-width: 600px;">
        <div class="card-header bg-warning text-white">
            <h5 class="mb-0">✏️ Editar Reservación</h5>
        </div>

        <div class="card-body">
            <%
                if (reserva == null) {
            %>
                <div class="alert alert-danger text-center">⚠️ Reservación no encontrada.</div>
            <%
                } else {
            %>
            <form action="EditarReservacionServlet" method="post">
                <input type="hidden" name="id" value="<%= reserva.getId() %>">

                <div class="mb-3">
                    <label class="form-label fw-semibold">Fecha de Entrada:</label>
                    <input type="date" name="nuevaFecha" 
                           value="<%= new java.text.SimpleDateFormat("yyyy-MM-dd").format(reserva.getFechaEntrada()) %>" 
                           class="form-control" required>
                </div>

                <div class="mb-3">
                    <label class="form-label fw-semibold">Días de Estadia:</label>
                    <input type="number" name="nuevosDias" 
                           value="<%= reserva.getDiasEstadia() %>" 
                           class="form-control" min="1" required>
                </div>

                <div class="d-grid">
                    <button type="submit" class="btn btn-warning text-white fw-semibold">💾 Guardar Cambios</button>
                </div>
            </form>
            <%
                }
            %>

            <!-- Mensaje de confirmación -->
            <%
                if (request.getAttribute("mensaje") != null) {
            %>
                <div class="alert alert-success mt-3 text-center">
                    <%= request.getAttribute("mensaje") %>
                </div>
            <%
                }
            %>
        </div>
    </div>
</div>

<!-- 🔹 Footer -->
<footer class="text-center text-muted mt-5 mb-3">
    © 2025 - Sistema de Reservación de Hoteles
</footer>

</body>
</html>
