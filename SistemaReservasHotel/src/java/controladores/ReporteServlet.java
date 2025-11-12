package controladores;

import dao.ReservacionDAO;
import java.io.IOException;
import jakarta.servlet.*;
import jakarta.servlet.http.*;

public class ReporteServlet extends HttpServlet {

    private ReservacionDAO reservacionDAO = new ReservacionDAO();

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        String nacionalidad = request.getParameter("nacionalidad");
        if (nacionalidad != null && !nacionalidad.isEmpty()) {
            double porcentaje = reservacionDAO.porcentajeReservasPorNacionalidad(nacionalidad);
            request.setAttribute("nacionalidad", nacionalidad);
            request.setAttribute("porcentaje", porcentaje);
        }

        RequestDispatcher rd = request.getRequestDispatcher("reporteNacionalidad.jsp");
        rd.forward(request, response);
    }
}
