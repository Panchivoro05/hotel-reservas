<%-- 
    Document   : editarReservacion
    Created on : 9 nov. 2025, 17:32:29
    Author     : Rodrigo
--%>

<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <title>JSP Page</title>
    </head>
    <body>
        <h2>Editar Reservación</h2>
        <form action="EditarReservacionServlet" method="post">
            ID Reservación: <input type="number" name="idReservacion"><br>
            Nueva Fecha Entrada: <input type="date" name="fechaEntrada"><br>
            Nuevos Días Estadia: <input type="number" name="diasEstadia"><br>
            <input type="submit" value="Actualizar">
        </form>

        <p>${mensaje}</p>
    </body>
</html>
