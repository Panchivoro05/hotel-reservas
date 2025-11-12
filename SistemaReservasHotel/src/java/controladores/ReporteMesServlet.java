package controladores;

import dao.ReservacionDAO;
import jakarta.servlet.*;
import jakarta.servlet.http.*;
import jakarta.servlet.annotation.*;
import java.io.IOException;
import java.util.List;
import java.util.Map;

@WebServlet("/ReporteMesServlet")
public class ReporteMesServlet extends HttpServlet {
    private ReservacionDAO reservacionDAO = new ReservacionDAO();

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        // Obtener los datos: nacionalidad, mes con más clientes y total
        List<Map<String, Object>> reporteMes = reservacionDAO.obtenerMesMayorPorNacionalidad();

        request.setAttribute("reporteMes", reporteMes);

        RequestDispatcher rd = request.getRequestDispatcher("reporteMes.jsp");
        rd.forward(request, response);
    }
}
