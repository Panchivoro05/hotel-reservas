package controladores;

import dao.TuroperadorDAO;
import modelo.Turoperador;
import jakarta.servlet.*;
import jakarta.servlet.http.*;
import java.io.IOException;
import java.util.List;

public class TuroperadorServlet extends HttpServlet {

    private final TuroperadorDAO turoperadorDAO = new TuroperadorDAO();

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        String action = request.getParameter("action");
        if (action == null) action = "listar";

        switch (action) {
            case "nuevo":
                RequestDispatcher rdNuevo = request.getRequestDispatcher("agregarTuroperador.jsp");
                rdNuevo.forward(request, response);
                break;

            case "editar":
                int idEditar = Integer.parseInt(request.getParameter("id"));
                Turoperador turoperador = turoperadorDAO.obtenerTuroperadorPorId(idEditar);

                if (turoperador == null) {
                    request.setAttribute("error", "⚠️ No se encontró el turoperador con ID: " + idEditar);
                    listar(request, response);
                    return;
                }

                request.setAttribute("turoperador", turoperador);
                RequestDispatcher rdEditar = request.getRequestDispatcher("editarTuroperador.jsp");
                rdEditar.forward(request, response);
                break;

            case "eliminar":
                int idEliminar = Integer.parseInt(request.getParameter("id"));
                boolean eliminado = turoperadorDAO.eliminarTuroperador(idEliminar);

                request.setAttribute(eliminado ? "mensaje" : "error",
                        eliminado ? "✅ Turoperador eliminado correctamente."
                                : "❌ No se pudo eliminar el turoperador.");

                listar(request, response);
                break;

            default:
                listar(request, response);
                break;
        }
    }

    private void listar(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        List<Turoperador> lista = turoperadorDAO.listarTuroperadores();
        request.setAttribute("turoperadores", lista);
        RequestDispatcher rdListar = request.getRequestDispatcher("listarTuroperadores.jsp");
        rdListar.forward(request, response);
    }

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        String action = request.getParameter("action");

        if ("insertar".equals(action)) {
            Turoperador t = new Turoperador();
            t.setCodigo(request.getParameter("codigo"));
            t.setNombre(request.getParameter("nombre"));
            t.setNacionalidad(request.getParameter("nacionalidad"));

            boolean exito = turoperadorDAO.agregarTuroperador(t);
            request.setAttribute(exito ? "mensaje" : "error",
                    exito ? "✅ Turoperador agregado correctamente."
                            : "❌ Error al registrar turoperador.");

            RequestDispatcher rd = request.getRequestDispatcher("agregarTuroperador.jsp");
            rd.forward(request, response);

        } else if ("actualizar".equals(action)) {
            Turoperador t = new Turoperador();
            t.setId(Integer.parseInt(request.getParameter("id")));
            t.setCodigo(request.getParameter("codigo"));
            t.setNombre(request.getParameter("nombre"));
            t.setNacionalidad(request.getParameter("nacionalidad"));

            boolean actualizado = turoperadorDAO.actualizarTuroperador(t);

            if (actualizado) {
                request.setAttribute("mensaje", "✅ Turoperador actualizado correctamente.");
                request.setAttribute("turoperador", turoperadorDAO.obtenerTuroperadorPorId(t.getId())); // 🔹 recarga datos
            } else {
                request.setAttribute("error", "❌ No se pudo actualizar el turoperador.");
                request.setAttribute("turoperador", t); // mantiene los valores introducidos
            }

            RequestDispatcher rd = request.getRequestDispatcher("editarTuroperador.jsp");
            rd.forward(request, response);
        }
    }
}
