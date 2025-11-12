package controladores;

import dao.ClienteDAO;
import modelo.Cliente;
import java.io.IOException;
import java.util.List;
import jakarta.servlet.*;
import jakarta.servlet.http.*;

public class ClienteServlet extends HttpServlet {

    private ClienteDAO clienteDAO = new ClienteDAO();

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        String action = request.getParameter("action");
        if (action == null) action = "listar";

        switch (action) {
            case "nuevo":
                // Mostrar formulario para nuevo cliente
                RequestDispatcher rdNuevo = request.getRequestDispatcher("agregarCliente.jsp");
                rdNuevo.forward(request, response);
                break;

            case "editar":
                // Mostrar formulario de edición con los datos del cliente
                int idEditar = Integer.parseInt(request.getParameter("id"));
                Cliente cliente = clienteDAO.obtenerClientePorId(idEditar);

                if (cliente == null) {
                    request.setAttribute("error", "⚠️ El cliente con ID " + idEditar + " no existe.");
                    RequestDispatcher rdError = request.getRequestDispatcher("listarClientes.jsp");
                    rdError.forward(request, response);
                    return;
                }

                request.setAttribute("cliente", cliente);
                RequestDispatcher rdEditar = request.getRequestDispatcher("editarCliente.jsp");
                rdEditar.forward(request, response);
                break;

            case "eliminar":
                // Eliminar cliente
                int idEliminar = Integer.parseInt(request.getParameter("id"));
                boolean eliminado = clienteDAO.eliminarCliente(idEliminar);

                if (eliminado) {
                    request.setAttribute("mensaje", "✅ Cliente eliminado correctamente.");
                } else {
                    request.setAttribute("error", "⚠️ No se pudo eliminar el cliente. Verifique que no tenga reservaciones activas.");
                }

                // 🔹 Volver a listar los clientes después de eliminar
                List<Cliente> lista = clienteDAO.listarClientes();
                request.setAttribute("listaClientes", lista);
                RequestDispatcher rdListarDespues = request.getRequestDispatcher("listarClientes.jsp");
                rdListarDespues.forward(request, response);
                break;

            default:
                // Listar todos los clientes
                List<Cliente> listaClientes = clienteDAO.listarClientes();
                request.setAttribute("listaClientes", listaClientes);
                RequestDispatcher rdListar = request.getRequestDispatcher("listarClientes.jsp");
                rdListar.forward(request, response);
                break;
        }
    }

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        String action = request.getParameter("action");

        if ("insertar".equals(action)) {
            // Registrar nuevo cliente
            Cliente c = new Cliente();
            c.setNombre(request.getParameter("nombre"));
            c.setEdad(Integer.parseInt(request.getParameter("edad")));
            c.setSexo(request.getParameter("sexo"));
            c.setNacionalidad(request.getParameter("nacionalidad"));
            c.setHaVisitado(Boolean.parseBoolean(request.getParameter("haVisitado")));

            boolean exito = clienteDAO.agregarCliente(c);
            if (exito) {
                request.setAttribute("mensaje", "✅ Cliente registrado correctamente.");
            } else {
                request.setAttribute("error", "❌ Error al registrar cliente.");
            }

            RequestDispatcher rd = request.getRequestDispatcher("agregarCliente.jsp");
            rd.forward(request, response);

        } else if ("actualizar".equals(action)) {
            // Actualizar cliente existente
            Cliente c = new Cliente();
            c.setId(Integer.parseInt(request.getParameter("id")));
            c.setNombre(request.getParameter("nombre"));
            c.setEdad(Integer.parseInt(request.getParameter("edad")));
            c.setSexo(request.getParameter("sexo"));
            c.setNacionalidad(request.getParameter("nacionalidad"));
            c.setHaVisitado(Boolean.parseBoolean(request.getParameter("haVisitado")));

            boolean actualizado = clienteDAO.actualizarCliente(c);
            if (actualizado) {
                // 🔹 Redirigir al listado para evitar error y recargar datos
                response.sendRedirect("ClienteServlet");
            } else {
                request.setAttribute("error", "❌ Error al actualizar cliente.");
                request.setAttribute("cliente", c); // Evita que sea null en el JSP
                RequestDispatcher rd = request.getRequestDispatcher("editarCliente.jsp");
                rd.forward(request, response);
            }
        }
    }
}
