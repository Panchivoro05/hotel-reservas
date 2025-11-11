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

    private ReservacionDAO reservacionDAO = new ReservacionDAO();

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        String action = request.getParameter("action");
        if (action == null) action = "listar";

        switch (action) {
            case "nuevo":
                // 🔹 Cargar datos de clientes y habitaciones disponibles
                ClienteDAO clienteDAO = new ClienteDAO();
                HabitacionDAO habitacionDAO = new HabitacionDAO();

                request.setAttribute("clientes", clienteDAO.listarClientes());
                request.setAttribute("habitaciones", habitacionDAO.listarDisponibles());

                RequestDispatcher rdNuevo = request.getRequestDispatcher("agregarReservacion.jsp");
                rdNuevo.forward(request, response);
                break;

            case "editar":
                int id = Integer.parseInt(request.getParameter("id"));
                Reservacion reserva = reservacionDAO.obtenerPorId(id);
                request.setAttribute("reservacion", reserva);
                RequestDispatcher rdEditar = request.getRequestDispatcher("editarReservacion.jsp");
                rdEditar.forward(request, response);
                break;

            case "eliminar":
                int idEliminar = Integer.parseInt(request.getParameter("id"));
                boolean eliminado = reservacionDAO.eliminarReservacion(idEliminar);

                if (eliminado) {
                    request.setAttribute("mensaje", "✅ Reservación eliminada correctamente.");
                } else {
                    request.setAttribute("error", "⚠️ No se pudo eliminar la reservación.");
                }

                // 🔹 Volver a listar
                List<Reservacion> listaDespues = reservacionDAO.listar();
                request.setAttribute("reservaciones", listaDespues);
                RequestDispatcher rdListar = request.getRequestDispatcher("listarReservaciones.jsp");
                rdListar.forward(request, response);
                break;

            default:
                // 🔹 Listar todas las reservaciones
                List<Reservacion> lista = reservacionDAO.listar();
                request.setAttribute("reservaciones", lista);
                RequestDispatcher rdListarDefault = request.getRequestDispatcher("listarReservaciones.jsp");
                rdListarDefault.forward(request, response);
                break;
        }
    }

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        String action = request.getParameter("action");

        if ("insertar".equals(action)) {
            // 🔹 Crear nueva reservación
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

            Date fechaEntrada = Date.valueOf(request.getParameter("fechaEntrada"));
            r.setFechaEntrada(fechaEntrada);
            r.setDiasEstadia(Integer.parseInt(request.getParameter("diasEstadia")));
            r.setEsTour("on".equals(request.getParameter("esTour")));
            r.setTipoReservacion(request.getParameter("tipoReservacion"));

            boolean exito = reservacionDAO.agregarReservacion(r);

            if (exito) {
                request.setAttribute("mensaje", "✅ Reservación registrada correctamente.");
            } else {
                request.setAttribute("error", "⚠️ No se pudo registrar la reservación. La habitación ya está ocupada en ese período.");
            }

            // Volver al formulario con feedback
            ClienteDAO clienteDAO = new ClienteDAO();
            HabitacionDAO habitacionDAO = new HabitacionDAO();
            request.setAttribute("clientes", clienteDAO.listarClientes());
            request.setAttribute("habitaciones", habitacionDAO.listarDisponibles());
            RequestDispatcher rd = request.getRequestDispatcher("agregarReservacion.jsp");
            rd.forward(request, response);

        } else if ("actualizar".equals(action)) {
            // 🔹 Actualizar reservación existente
            Reservacion r = new Reservacion();
            r.setId(Integer.parseInt(request.getParameter("id")));

            Date nuevaFecha = Date.valueOf(request.getParameter("fechaEntrada"));
            int nuevosDias = Integer.parseInt(request.getParameter("diasEstadia"));

            // 🔸 Llamada al método con validación de solapamiento
            boolean actualizado = reservacionDAO.actualizarFechaYDuracion(r.getId(), nuevaFecha, nuevosDias);

            if (actualizado) {
                request.setAttribute("mensaje", "✅ Reservación actualizada correctamente.");
            } else {
                request.setAttribute("error", "⚠️ No se pudo actualizar: la habitación ya está reservada en ese período.");
            }

            RequestDispatcher rd = request.getRequestDispatcher("editarReservacion.jsp");
            rd.forward(request, response);
        }
    }
}

