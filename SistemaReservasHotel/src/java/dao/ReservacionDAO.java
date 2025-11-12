package dao;

import modelo.*;
import java.sql.*;
import java.util.ArrayList;
import java.util.HashMap;
import java.util.HashSet;
import java.util.LinkedHashMap;
import java.util.List;
import java.util.Map;
import java.util.Set;

public class ReservacionDAO {

    // 🔹 Verifica si una habitación está ocupada en un rango de fechas
    private boolean habitacionOcupada(int idHabitacion, Date fechaEntrada, int dias) {
        String sql = "SELECT * FROM reservacion WHERE id_habitacion = ? " +
                     "AND (fecha_entrada <= DATE_ADD(?, INTERVAL ? DAY) " +
                     "AND DATE_ADD(fecha_entrada, INTERVAL dias_estadia DAY) >= ?)";
        try (Connection con = Conexion.getConexion();
             PreparedStatement ps = con.prepareStatement(sql)) {
            ps.setInt(1, idHabitacion);
            ps.setDate(2, fechaEntrada);
            ps.setInt(3, dias);
            ps.setDate(4, fechaEntrada);
            ResultSet rs = ps.executeQuery();
            return rs.next();
        } catch (SQLException e) {
            System.out.println("Error al verificar habitación: " + e.getMessage());
        }
        return false;
    }

    // 🔹 Verifica si una habitación está ocupada al actualizar (excluye la reserva actual)
    private boolean habitacionOcupadaEnRango(int idHabitacion, Date nuevaFecha, int nuevosDias, int idReservacionActual) {
        String sql = "SELECT * FROM reservacion WHERE id_habitacion = ? AND id <> ? " +
                     "AND (fecha_entrada <= DATE_ADD(?, INTERVAL ? DAY) " +
                     "AND DATE_ADD(fecha_entrada, INTERVAL dias_estadia DAY) >= ?)";
        try (Connection con = Conexion.getConexion();
             PreparedStatement ps = con.prepareStatement(sql)) {
            ps.setInt(1, idHabitacion);
            ps.setInt(2, idReservacionActual);
            ps.setDate(3, nuevaFecha);
            ps.setInt(4, nuevosDias);
            ps.setDate(5, nuevaFecha);
            ResultSet rs = ps.executeQuery();
            return rs.next();
        } catch (SQLException e) {
            System.out.println("Error al verificar habitación (actualización): " + e.getMessage());
        }
        return false;
    }

    // 🔹 Agregar una nueva reservación
    public boolean agregarReservacion(Reservacion r) {
        if (habitacionOcupada(r.getHabitacion().getId(), r.getFechaEntrada(), r.getDiasEstadia())) {
            return false;
        }

        String sql = "INSERT INTO reservacion (codigo, id_cliente, id_habitacion, id_turoperador, fecha_entrada, dias_estadia, es_tour, tipo_reservacion) " +
                     "VALUES (?, ?, ?, ?, ?, ?, ?, ?)";
        try (Connection con = Conexion.getConexion();
             PreparedStatement ps = con.prepareStatement(sql)) {

            ps.setString(1, r.getCodigo());
            ps.setInt(2, r.getCliente().getId());
            ps.setInt(3, r.getHabitacion().getId());

            if (r.getTuroperador() != null) {
                ps.setInt(4, r.getTuroperador().getId());
            } else {
                ps.setNull(4, java.sql.Types.INTEGER);
            }

            ps.setDate(5, r.getFechaEntrada());
            ps.setInt(6, r.getDiasEstadia());
            ps.setBoolean(7, r.isEsTour());
            ps.setString(8, r.getTipoReservacion());
            ps.executeUpdate();

            // 🔹 Marcar habitación como ocupada
            new HabitacionDAO().actualizarEstado(r.getHabitacion().getId(), "OCUPADA");

            return true;
        } catch (SQLException e) {
            System.out.println("Error al agregar reservación: " + e.getMessage());
        }
        return false;
    }

    // 🔹 Listar todas las reservaciones
    public List<Reservacion> listar() {
        List<Reservacion> lista = new ArrayList<>();
        String sql = """
            SELECT 
                r.id, r.codigo, r.fecha_entrada, r.dias_estadia, 
                r.es_tour, r.tipo_reservacion,
                c.id AS id_cliente, c.nombre AS nombre_cliente,
                h.id AS id_habitacion, h.numero AS numero_habitacion, h.tipo AS tipo_habitacion
            FROM reservacion r
            INNER JOIN cliente c ON r.id_cliente = c.id
            INNER JOIN habitacion h ON r.id_habitacion = h.id
            ORDER BY r.id DESC
        """;

        try (Connection con = Conexion.getConexion();
             PreparedStatement ps = con.prepareStatement(sql);
             ResultSet rs = ps.executeQuery()) {

            while (rs.next()) {
                Cliente cliente = new Cliente();
                cliente.setId(rs.getInt("id_cliente"));
                cliente.setNombre(rs.getString("nombre_cliente"));

                Habitacion habitacion = new Habitacion();
                habitacion.setId(rs.getInt("id_habitacion"));
                habitacion.setNumero(rs.getInt("numero_habitacion"));
                habitacion.setTipo(rs.getString("tipo_habitacion"));

                Reservacion r = new Reservacion();

                r.setId(rs.getInt("id"));
                r.setCodigo(rs.getString("codigo"));
                r.setFechaEntrada(rs.getDate("fecha_entrada"));
                r.setDiasEstadia(rs.getInt("dias_estadia"));
                r.setEsTour(rs.getBoolean("es_tour"));
                r.setTipoReservacion(rs.getString("tipo_reservacion"));
                r.setCliente(cliente);
                r.setHabitacion(habitacion);
                lista.add(r);
            }
        } catch (SQLException e) {
            System.out.println("Error al listar reservaciones: " + e.getMessage());
        }
        return lista;
    }

    // 🔹 Obtener reservación por ID
    public Reservacion obtenerPorId(int id) {
        String sql = "SELECT * FROM reservacion WHERE id = ?";
        try (Connection con = Conexion.getConexion();
             PreparedStatement ps = con.prepareStatement(sql)) {
            ps.setInt(1, id);
            ResultSet rs = ps.executeQuery();
            if (rs.next()) {
                Reservacion r = new Reservacion();
                r.setId(rs.getInt("id"));
                r.setCodigo(rs.getString("codigo"));
                r.setFechaEntrada(rs.getDate("fecha_entrada"));
                r.setDiasEstadia(rs.getInt("dias_estadia"));
                r.setEsTour(rs.getBoolean("es_tour"));
                r.setTipoReservacion(rs.getString("tipo_reservacion"));
                return r;
            }
        } catch (SQLException e) {
            System.out.println("Error al obtener reservación: " + e.getMessage());
        }
        return null;
    }

    // 🔹 Actualizar fecha y duración con validación (punto b)
    public boolean actualizarFechaYDuracion(int idReservacion, Date nuevaFecha, int nuevosDias) {
        int idHabitacion = obtenerIdHabitacionPorReserva(idReservacion);
        if (idHabitacion == 0) {
            System.out.println("⚠️ No se encontró habitación asociada a la reserva ID: " + idReservacion);
            return false;
        }

        // Validar conflicto
        if (habitacionOcupadaEnRango(idHabitacion, nuevaFecha, nuevosDias, idReservacion)) {
            System.out.println("🚫 La habitación ya está ocupada en ese nuevo rango de fechas.");
            return false;
        }

        String sql = "UPDATE reservacion SET fecha_entrada = ?, dias_estadia = ? WHERE id = ?";
        try (Connection con = Conexion.getConexion();
             PreparedStatement ps = con.prepareStatement(sql)) {
            ps.setDate(1, nuevaFecha);
            ps.setInt(2, nuevosDias);
            ps.setInt(3, idReservacion);

            int filas = ps.executeUpdate();
            System.out.println("✅ Reservación actualizada. Filas afectadas: " + filas);
            return filas > 0;
        } catch (SQLException e) {
            System.out.println("Error al actualizar reservación: " + e.getMessage());
        }
        return false;
    }

    // 🔹 Eliminar reservación
    public boolean eliminarReservacion(int id) {
        String sql = "DELETE FROM reservacion WHERE id=?";
        try (Connection con = Conexion.getConexion();
             PreparedStatement ps = con.prepareStatement(sql)) {

            int idHabitacion = obtenerIdHabitacionPorReserva(id);
            ps.setInt(1, id);
            boolean eliminado = ps.executeUpdate() > 0;

            if (eliminado && idHabitacion > 0) {
                new HabitacionDAO().actualizarEstado(idHabitacion, "DISPONIBLE");
            }
            return eliminado;
        } catch (SQLException e) {
            System.out.println("Error al eliminar reservación: " + e.getMessage());
        }
        return false;
    }

    // 🔹 Obtener ID de habitación de una reservación
    private int obtenerIdHabitacionPorReserva(int idReserva) {
        String sql = "SELECT id_habitacion FROM reservacion WHERE id = ?";
        try (Connection con = Conexion.getConexion();
             PreparedStatement ps = con.prepareStatement(sql)) {
            ps.setInt(1, idReserva);
            ResultSet rs = ps.executeQuery();
            if (rs.next()) {
                return rs.getInt("id_habitacion");
            }
        } catch (SQLException e) {
            System.out.println("Error al obtener habitación: " + e.getMessage());
        }
        return 0;
    }

    // 🔹 Listar por tipo de reservación (Recepción / Turoperador)
    public List<Reservacion> listarPorTipo(String tipoReservacion) {
        List<Reservacion> lista = new ArrayList<>();
        String sql = "SELECT * FROM reservacion WHERE tipo_reservacion = ?";
        try (Connection con = Conexion.getConexion();
             PreparedStatement ps = con.prepareStatement(sql)) {
            ps.setString(1, tipoReservacion);
            ResultSet rs = ps.executeQuery();
            while (rs.next()) {
                Reservacion r = new Reservacion();
                r.setId(rs.getInt("id"));
                r.setCodigo(rs.getString("codigo"));
                r.setFechaEntrada(rs.getDate("fecha_entrada"));
                r.setDiasEstadia(rs.getInt("dias_estadia"));
                r.setEsTour(rs.getBoolean("es_tour"));
                r.setTipoReservacion(rs.getString("tipo_reservacion"));
                lista.add(r);
            }
        } catch (SQLException e) {
            System.out.println("Error al listar reservaciones por tipo: " + e.getMessage());
        }
        return lista;
    }
    public double porcentajeReservasPorNacionalidad(String nacionalidad) {
        String sql = """
            SELECT 
                COUNT(*) AS total_nacionalidad,
                (SELECT COUNT(*) 
                 FROM reservacion r2 
                 INNER JOIN cliente c2 ON r2.id_cliente = c2.id
                 WHERE r2.tipo_reservacion = 'Recepcion'
                 AND MONTH(r2.fecha_entrada) = MONTH(CURDATE())
                 AND YEAR(r2.fecha_entrada) = YEAR(CURDATE())) AS total_mes
            FROM reservacion r
            INNER JOIN cliente c ON r.id_cliente = c.id
            WHERE c.nacionalidad = ? 
            AND r.tipo_reservacion = 'Recepcion'
            AND MONTH(r.fecha_entrada) = MONTH(CURDATE())
            AND YEAR(r.fecha_entrada) = YEAR(CURDATE());
        """;

        try (Connection con = Conexion.getConexion();
             PreparedStatement ps = con.prepareStatement(sql)) {
            ps.setString(1, nacionalidad);
            ResultSet rs = ps.executeQuery();

            if (rs.next()) {
                int totalNacionalidad = rs.getInt("total_nacionalidad");
                int totalMes = rs.getInt("total_mes");

                if (totalMes > 0) {
                    return (totalNacionalidad * 100.0) / totalMes;
                }
            }
        } catch (SQLException e) {
            System.out.println("Error al calcular porcentaje: " + e.getMessage());
        }
        return 0;
    }
    
    public List<Map<String, Object>> obtenerMesMayorPorNacionalidad() {
        List<Map<String, Object>> resultado = new ArrayList<>();

        String sql = """
            SELECT c.nacionalidad,
                   MONTHNAME(r.fecha_entrada) AS mes,
                   COUNT(*) AS total
            FROM reservacion r
            INNER JOIN cliente c ON r.id_cliente = c.id
            WHERE YEAR(r.fecha_entrada) = YEAR(CURDATE()) - 1
            GROUP BY c.nacionalidad, MONTH(r.fecha_entrada)
            ORDER BY c.nacionalidad, total DESC;
        """;

        try (Connection con = Conexion.getConexion();
             PreparedStatement ps = con.prepareStatement(sql);
             ResultSet rs = ps.executeQuery()) {

            // Registrar solo el primer (mayor) mes por nacionalidad
            Set<String> nacionalidadesProcesadas = new HashSet<>();

            while (rs.next()) {
                String nacionalidad = rs.getString("nacionalidad");
                if (!nacionalidadesProcesadas.contains(nacionalidad)) {
                    Map<String, Object> fila = new HashMap<>();
                    fila.put("nacionalidad", nacionalidad);
                    fila.put("mes", rs.getString("mes"));
                    fila.put("total", rs.getInt("total"));

                    resultado.add(fila);
                    nacionalidadesProcesadas.add(nacionalidad);
                }
            }

        } catch (SQLException e) {
            System.out.println("Error al obtener reporte de mes mayor por nacionalidad: " + e.getMessage());
        }

        return resultado;
    }
    
    public Map<String, Object> obtenerSexoMasFrecuentePorNacionalidad(String nacionalidad) {
        Map<String, Object> resultado = new HashMap<>();

        String sql = """
            SELECT c.sexo, COUNT(*) AS total
            FROM reservacion r
            INNER JOIN cliente c ON r.id_cliente = c.id
            WHERE c.nacionalidad = ? AND YEAR(r.fecha_entrada) = YEAR(CURDATE())
            GROUP BY c.sexo
            ORDER BY total DESC
            LIMIT 1;
        """;

        try (Connection con = Conexion.getConexion();
             PreparedStatement ps = con.prepareStatement(sql)) {

            ps.setString(1, nacionalidad);
            ResultSet rs = ps.executeQuery();

            if (rs.next()) {
                resultado.put("sexo", rs.getString("sexo"));
                resultado.put("total", rs.getInt("total"));
            }

        } catch (SQLException e) {
            System.out.println("Error al obtener sexo más frecuente: " + e.getMessage());
        }

        return resultado;
    }
    
    public List<Map<String, Object>> obtenerClientesFrecuentes() {
        List<Map<String, Object>> lista = new ArrayList<>();
        String sql = """
            SELECT c.nombre AS cliente, COUNT(r.id) AS total_reservas
            FROM reservacion r
            INNER JOIN cliente c ON r.id_cliente = c.id
            GROUP BY c.nombre
            ORDER BY total_reservas DESC
            LIMIT 10
        """;

        try (Connection con = Conexion.getConexion();
             PreparedStatement ps = con.prepareStatement(sql);
             ResultSet rs = ps.executeQuery()) {

            while (rs.next()) {
                Map<String, Object> fila = new HashMap<>();
                fila.put("cliente", rs.getString("cliente"));
                fila.put("total_reservas", rs.getInt("total_reservas"));
                lista.add(fila);
            }

        } catch (SQLException e) {
            System.out.println("Error al obtener clientes frecuentes: " + e.getMessage());
        }
        return lista;
    }
    
    public List<Map<String, Object>> listarClientesPorTuroperador(String codigoTuroperador) {
        List<Map<String, Object>> lista = new ArrayList<>();

        String sql = """
            SELECT c.nombre AS cliente, c.nacionalidad, r.fecha_entrada, h.numero AS habitacion
            FROM reservacion r
            INNER JOIN cliente c ON r.id_cliente = c.id
            INNER JOIN habitacion h ON r.id_habitacion = h.id
            INNER JOIN turoperador t ON r.id_turoperador = t.id
            WHERE t.codigo = ?
            ORDER BY r.fecha_entrada ASC
        """;

        try (Connection con = Conexion.getConexion();
             PreparedStatement ps = con.prepareStatement(sql)) {

            ps.setString(1, codigoTuroperador);
            ResultSet rs = ps.executeQuery();

            while (rs.next()) {
                Map<String, Object> fila = new HashMap<>();
                fila.put("cliente", rs.getString("cliente"));
                fila.put("nacionalidad", rs.getString("nacionalidad"));
                fila.put("fecha_entrada", rs.getDate("fecha_entrada"));
                fila.put("habitacion", rs.getString("habitacion"));
                lista.add(fila);
            }

        } catch (SQLException e) {
            System.out.println("Error al listar clientes por turoperador: " + e.getMessage());
        }

        return lista;
    }

}
