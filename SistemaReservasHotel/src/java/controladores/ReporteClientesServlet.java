package controladores;

import dao.ReservacionDAO;
import jakarta.servlet.*;
import jakarta.servlet.http.*;
import jakarta.servlet.annotation.*;
import java.io.IOException;
import java.util.List;
import java.util.Map;

@WebServlet("/ReporteClientesServlet")
public class ReporteClientesServlet extends HttpServlet {
    private ReservacionDAO reservacionDAO = new ReservacionDAO();

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        List<Map<String, Object>> clientesFrecuentes = reservacionDAO.obtenerClientesFrecuentes();
        request.setAttribute("clientesFrecuentes", clientesFrecuentes);

        RequestDispatcher rd = request.getRequestDispatcher("reporteClientes.jsp");
        rd.forward(request, response);
    }
}
