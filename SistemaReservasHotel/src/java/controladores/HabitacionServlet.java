package controladores;

import dao.HabitacionDAO;
import modelo.Habitacion;
import jakarta.servlet.*;
import jakarta.servlet.http.*;
import java.io.IOException;
import java.util.List;

public class HabitacionServlet extends HttpServlet {

    private HabitacionDAO dao = new HabitacionDAO();

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        String action = request.getParameter("action");
        if (action == null) action = "listar";

        switch (action) {
            case "nuevo":
                request.getRequestDispatcher("agregarHabitacion.jsp").forward(request, response);
                break;

            case "editar":
                int id = Integer.parseInt(request.getParameter("id"));
                Habitacion h = dao.obtenerPorId(id);
                request.setAttribute("habitacion", h);
                request.getRequestDispatcher("editarHabitacion.jsp").forward(request, response);
                break;

            case "eliminar":
                dao.eliminarHabitacion(Integer.parseInt(request.getParameter("id")));
                response.sendRedirect("HabitacionServlet");
                break;

            default:
                List<Habitacion> lista = dao.listarTodas();
                request.setAttribute("habitaciones", lista);
                request.getRequestDispatcher("listarHabitaciones.jsp").forward(request, response);
                break;
        }
    }

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        String action = request.getParameter("action");

        if ("insertar".equals(action)) {
            Habitacion h = new Habitacion();
            h.setNumero(Integer.parseInt(request.getParameter("numero")));
            h.setTipo(request.getParameter("tipo"));
            h.setPrecio(Double.parseDouble(request.getParameter("precio")));
            h.setEstado("DISPONIBLE");

            dao.agregarHabitacion(h);
            response.sendRedirect("HabitacionServlet");
        }

        if ("actualizar".equals(action)) {
            Habitacion h = new Habitacion();
            h.setId(Integer.parseInt(request.getParameter("id")));
            h.setNumero(Integer.parseInt(request.getParameter("numero")));
            h.setTipo(request.getParameter("tipo"));
            h.setPrecio(Double.parseDouble(request.getParameter("precio")));
            h.setEstado(request.getParameter("estado"));

            dao.actualizarHabitacion(h);
            response.sendRedirect("HabitacionServlet");
        }
    }
}
