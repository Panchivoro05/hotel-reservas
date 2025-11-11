<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <title>JSP Page</title>
    </head>
    <body>
        <h2>Agregar Reservación</h2>
        <form action="ReservaServlet" method="post">
            Código: <input type="text" name="codigo"><br>
            ID Cliente: <input type="number" name="idCliente"><br>
            ID Habitación: <input type="number" name="idHabitacion"><br>
            ID Turoperador (opcional): <input type="number" name="idTuroperador"><br>
            Fecha Entrada: <input type="date" name="fechaEntrada"><br>
            Días Estadia: <input type="number" name="diasEstadia"><br>
            Es Tour: <input type="checkbox" name="esTour" value="true"><br>
            Tipo Reservación:
            <select name="tipoReservacion">
                <option value="RECEPCION">Recepción</option>
                <option value="TUROPERADOR">Turoperador</option>
            </select><br>
            <input type="submit" value="Registrar">
        </form>

        <p>${mensaje}</p>
    </body>
</html>
