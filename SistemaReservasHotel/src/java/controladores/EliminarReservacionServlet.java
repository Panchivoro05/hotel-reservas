package controladores;

import dao.ReservacionDAO;
import java.io.IOException;
import jakarta.servlet.*;
import jakarta.servlet.http.*;

public class EliminarReservacionServlet extends HttpServlet {

    private ReservacionDAO reservacionDAO = new ReservacionDAO();

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        try {
            int id = Integer.parseInt(request.getParameter("id"));
            boolean exito = reservacionDAO.eliminarReservacion(id);

            if (exito) {
                request.setAttribute("mensaje", "Reservación eliminada correctamente.");
            } else {
                request.setAttribute("mensaje", "Error al eliminar la reservación.");
            }
        } catch (Exception e) {
            request.setAttribute("mensaje", "Error: " + e.getMessage());
        }

        RequestDispatcher rd = request.getRequestDispatcher("ReservaServlet");
        rd.forward(request, response);
    }
}
