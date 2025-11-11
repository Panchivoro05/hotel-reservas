package controladores;

import dao.ClienteDAO;
import dao.HabitacionDAO;
import dao.ReservacionDAO;
import modelo.*;
import jakarta.servlet.*;
import jakarta.servlet.http.*;
import java.io.IOException;
import java.sql.Date;
import java.util.List;

public class ReservaServlet extends HttpServlet {

    private ReservacionDAO dao = new ReservacionDAO();

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        String action = request.getParameter("action");
        if (action == null) action = "listar";

        switch (action) {
            case "nuevo":
                 // Cargar datos de clientes y habitaciones
                ClienteDAO clienteDAO = new ClienteDAO();
                HabitacionDAO habitacionDAO = new HabitacionDAO();

                request.setAttribute("clientes", clienteDAO.listarClientes());
                request.setAttribute("habitaciones", habitacionDAO.listarDisponibles());

                request.getRequestDispatcher("agregarReservacion.jsp").forward(request, response);
                break;

            case "editar":
                int id = Integer.parseInt(request.getParameter("id"));
                Reservacion reservacion = dao.obtenerPorId(id);
                request.setAttribute("reservacion", reservacion);
                request.getRequestDispatcher("editarReservacion.jsp").forward(request, response);
                break;

            case "eliminar":
                dao.eliminarReservacion(Integer.parseInt(request.getParameter("id")));
                response.sendRedirect("ReservaServlet");
                break;

            default:
                List<Reservacion> lista = dao.listar();
                request.setAttribute("reservaciones", lista);
                request.getRequestDispatcher("listarReservaciones.jsp").forward(request, response);
                break;
        }
    }

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        String action = request.getParameter("action");

        if ("insertar".equals(action)) {
            Reservacion r = new Reservacion();
            r.setCodigo(request.getParameter("codigo"));

            Cliente c = new Cliente();
            c.setId(Integer.parseInt(request.getParameter("idCliente")));
            r.setCliente(c);

            Habitacion h = new Habitacion();
            h.setId(Integer.parseInt(request.getParameter("idHabitacion")));
            r.setHabitacion(h);

            String idTuro = request.getParameter("idTuroperador");
            if (idTuro != null && !idTuro.isEmpty()) {
                Turoperador t = new Turoperador();
                t.setId(Integer.parseInt(idTuro));
                r.setTuroperador(t);
            }

            String fechaStr = request.getParameter("fechaEntrada");
            Date fechaEntrada = null;

            try {
                // Si el formato viene como yyyy-MM-dd (correcto)
                fechaEntrada = Date.valueOf(fechaStr);
            } catch (IllegalArgumentException e) {
                try {
                    // Si viene en formato dd/MM/yyyy (caso regional)
                    String[] partes = fechaStr.split("/");
                    fechaEntrada = Date.valueOf(partes[2] + "-" + partes[1] + "-" + partes[0]);
                } catch (Exception ex) {
                    throw new ServletException("Formato de fecha inválido: " + fechaStr);
                }
            }

            r.setFechaEntrada(fechaEntrada);

            r.setDiasEstadia(Integer.parseInt(request.getParameter("diasEstadia")));
            r.setEsTour("on".equals(request.getParameter("esTour")));
            r.setTipoReservacion(request.getParameter("tipoReservacion"));

            boolean exito = dao.agregarReservacion(r);

            if (exito) {
                response.sendRedirect("ReservaServlet");
            } else {
                request.setAttribute("error", "❌ La habitación seleccionada ya está ocupada.");
                request.getRequestDispatcher("agregarReservacion.jsp").forward(request, response);
            }
        }

        if ("actualizar".equals(action)) {
            Reservacion r = new Reservacion();
            r.setId(Integer.parseInt(request.getParameter("id")));
            String fechaStr = request.getParameter("fechaEntrada");
            Date fechaEntrada = null;

            try {
                // Si el formato viene como yyyy-MM-dd (correcto)
                fechaEntrada = Date.valueOf(fechaStr);
            } catch (IllegalArgumentException e) {
                try {
                    // Si viene en formato dd/MM/yyyy (caso regional)
                    String[] partes = fechaStr.split("/");
                    fechaEntrada = Date.valueOf(partes[2] + "-" + partes[1] + "-" + partes[0]);
                } catch (Exception ex) {
                    throw new ServletException("Formato de fecha inválido: " + fechaStr);
                }
            }
            r.setFechaEntrada(fechaEntrada);

            r.setDiasEstadia(Integer.parseInt(request.getParameter("diasEstadia")));

            dao.actualizarReservacion(r);
            response.sendRedirect("ReservaServlet");
        }
    }
}

