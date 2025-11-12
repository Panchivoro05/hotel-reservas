package controladores;

import dao.ReservacionDAO;
import jakarta.servlet.*;
import jakarta.servlet.http.*;
import jakarta.servlet.annotation.*;
import java.io.IOException;
import java.util.Map;

@WebServlet("/ReporteSexoServlet")
public class ReporteSexoServlet extends HttpServlet {
    private ReservacionDAO reservacionDAO = new ReservacionDAO();

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        String nacionalidad = request.getParameter("nacionalidad");

        if (nacionalidad != null && !nacionalidad.isEmpty()) {
            Map<String, Object> resultado = reservacionDAO.obtenerSexoMasFrecuentePorNacionalidad(nacionalidad);
            request.setAttribute("resultado", resultado);
            request.setAttribute("nacionalidad", nacionalidad);
        }

        RequestDispatcher rd = request.getRequestDispatcher("reporteSexo.jsp");
        rd.forward(request, response);
    }
}
