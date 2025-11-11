package controladores;

import dao.ReservacionDAO;
import modelo.Reservacion;
import java.io.IOException;
import java.sql.Date;
import jakarta.servlet.*;
import jakarta.servlet.http.*;

public class EditarReservacionServlet extends HttpServlet {

    private ReservacionDAO reservacionDAO = new ReservacionDAO();

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        try {
            int idReserva = Integer.parseInt(request.getParameter("id"));
            Date nuevaFecha = Date.valueOf(request.getParameter("nuevaFecha"));
            int nuevosDias = Integer.parseInt(request.getParameter("nuevosDias"));

            // 🔹 Intentar actualizar
            boolean exito = reservacionDAO.actualizarFechaYDuracion(idReserva, nuevaFecha, nuevosDias);

            if (exito) {
                // ✅ Éxito
                request.setAttribute("mensaje", "✅ Reservación actualizada correctamente.");
            } else {
                // ⚠️ Error por conflicto
                request.setAttribute("error", "⚠️ No se puede actualizar: la habitación está ocupada en ese rango de fechas.");
            }

        } catch (Exception e) {
            request.setAttribute("error", "❌ Error inesperado: " + e.getMessage());
        }

        // 🔹 Volver al formulario con mensajes Bootstrap
        RequestDispatcher rd = request.getRequestDispatcher("editarReservacion.jsp");
        rd.forward(request, response);
    }
}


