package controladores;

import dao.ReservacionDAO;
import dao.TuroperadorDAO;
import jakarta.servlet.*;
import jakarta.servlet.http.*;
import java.io.IOException;
import java.util.List;
import java.util.Map;
import modelo.Turoperador;

public class ReporteTuroperadorServlet extends HttpServlet {

    private ReservacionDAO reservacionDAO = new ReservacionDAO();
    private TuroperadorDAO turoperadorDAO = new TuroperadorDAO();

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        // 🔹 Cargar lista de turoperadores para el selector
        List<Turoperador> listaTurops = turoperadorDAO.listarTuroperadores();
        request.setAttribute("turoperadores", listaTurops);

        // Si viene un código de turoperador, genera el reporte
        String codigoTuro = request.getParameter("codigoTuroperador");
        if (codigoTuro != null && !codigoTuro.isEmpty()) {
            List<Map<String, Object>> reporte = reservacionDAO.listarClientesPorTuroperador(codigoTuro);
            request.setAttribute("reporte", reporte);
            request.setAttribute("codigoTuroperador", codigoTuro);
        }

        RequestDispatcher rd = request.getRequestDispatcher("reporteTuroperador.jsp");
        rd.forward(request, response);
    }
}


