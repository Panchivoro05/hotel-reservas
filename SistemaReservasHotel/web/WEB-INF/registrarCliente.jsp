<%@ page import="java.sql.*" %>
<%
    String nombre = request.getParameter("nombre");
    String edad = request.getParameter("edad");
    String sexo = request.getParameter("sexo");
    String nacionalidad = request.getParameter("nacionalidad");
    String visitadoAntes = request.getParameter("visitado_antes");

    Connection con = null;
    PreparedStatement ps = null;

    try {
        Class.forName("com.mysql.cj.jdbc.Driver");
        con = DriverManager.getConnection("jdbc:mysql://localhost:3306/hotel", "root", ""); // ajusta tu BD y usuario

        String sql = "INSERT INTO cliente (nombre, edad, sexo, nacionalidad, visitado_antes) VALUES (?, ?, ?, ?, ?)";
        ps = con.prepareStatement(sql);
        ps.setString(1, nombre);
        ps.setInt(2, Integer.parseInt(edad));
        ps.setString(3, sexo);
        ps.setString(4, nacionalidad);
        ps.setString(5, visitadoAntes);

        ps.executeUpdate();

        // Redirigir al listado
        response.sendRedirect("listarClientes.jsp");

    } catch (Exception e) {
        out.println("<h3 style='color:red;'>Error al registrar cliente: " + e.getMessage() + "</h3>");
        e.printStackTrace();
    } finally {
        if (ps != null) ps.close();
        if (con != null) con.close();
    }
%>
