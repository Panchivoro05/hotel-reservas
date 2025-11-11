<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ page import="java.sql.*" %>
<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <title>Registrar Nuevo Cliente</title>
    <link rel="stylesheet"
          href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/css/bootstrap.min.css">
</head>
<body class="bg-light">

<div class="container mt-5">
    <div class="card shadow-lg p-4">
        <h2 class="text-center mb-4">🧾 Registrar Nuevo Cliente</h2>

        <form action="registrarCliente.jsp" method="post">
            <div class="mb-3">
                <label class="form-label">Nombre:</label>
                <input type="text" class="form-control" name="nombre" required>
            </div>

            <div class="mb-3">
                <label class="form-label">Edad:</label>
                <input type="number" class="form-control" name="edad" required>
            </div>

            <div class="mb-3">
                <label class="form-label">Sexo:</label>
                <select class="form-select" name="sexo" required>
                    <option value="">Seleccionar...</option>
                    <option value="Masculino">Masculino</option>
                    <option value="Femenino">Femenino</option>
                </select>
            </div>

            <div class="mb-3">
                <label class="form-label">Nacionalidad:</label>
                <input type="text" class="form-control" name="nacionalidad" required>
            </div>

            <div class="mb-3">
                <label class="form-label">¿Ha visitado antes?</label>
                <select class="form-select" name="visitado_antes" required>
                    <option value="">Seleccionar...</option>
                    <option value="Sí">Sí</option>
                    <option value="No">No</option>
                </select>
            </div>

            <div class="text-center">
                <button type="submit" class="btn btn-success px-4">Guardar Cliente</button>
                <a href="listarClientes.jsp" class="btn btn-secondary px-4">Volver</a>
            </div>
        </form>
    </div>
</div>

</body>
</html>
