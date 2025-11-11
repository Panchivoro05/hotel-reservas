<%-- 
    Document   : listarReservaciones
    Created on : 9 nov. 2025, 17:33:21
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
        <h2>Lista de Reservaciones (${param.tipo})</h2>
        <table border="1">
            <tr>
                <th>ID</th>
                <th>Código</th>
                <th>Fecha Entrada</th>
                <th>Días</th>
                <th>Tipo</th>
            </tr>
            <c:forEach var="r" items="${reservaciones}">
                <tr>
                    <td>${r.id}</td>
                    <td>${r.codigo}</td>
                    <td>${r.fechaEntrada}</td>
                    <td>${r.diasEstadia}</td>
                    <td>${r.tipoReservacion}</td>
                </tr>
            </c:forEach>
        </table>

    </body>
</html>
