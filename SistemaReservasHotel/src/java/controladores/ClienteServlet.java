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
                request.setAttribute("cliente", cliente);
                RequestDispatcher rdEditar = request.getRequestDispatcher("editarCliente.jsp");
                rdEditar.forward(request, response);
                break;

            case "eliminar":
                // Eliminar cliente
                int idEliminar = Integer.parseInt(request.getParameter("id"));
                clienteDAO.eliminarCliente(idEliminar);
                response.sendRedirect("ClienteServlet");
                break;

            default:
                // Listar todos los clientes
                List<Cliente> lista = clienteDAO.listarClientes();
                request.setAttribute("listaClientes", lista);
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

            clienteDAO.agregarCliente(c);
            response.sendRedirect("ClienteServlet");

        } else if ("actualizar".equals(action)) {
            // Actualizar cliente existente
            Cliente c = new Cliente();
            c.setId(Integer.parseInt(request.getParameter("id")));
            c.setNombre(request.getParameter("nombre"));
            c.setEdad(Integer.parseInt(request.getParameter("edad")));
            c.setSexo(request.getParameter("sexo"));
            c.setNacionalidad(request.getParameter("nacionalidad"));
            c.setHaVisitado(Boolean.parseBoolean(request.getParameter("haVisitado")));

            clienteDAO.actualizarCliente(c);
            response.sendRedirect("ClienteServlet");
        }
    }
}
