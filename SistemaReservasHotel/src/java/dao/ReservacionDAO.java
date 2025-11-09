package dao;

import modelo.*;
import java.sql.*;
import java.util.ArrayList;
import java.util.List;

public class ReservacionDAO {

    // Verifica si la habitación está ocupada en las fechas solicitadas
    private boolean habitacionOcupada(int idHabitacion, Date fechaEntrada, int dias) {
        String sql = "SELECT * FROM reservacion WHERE id_habitacion = ? " +
                     "AND (fecha_entrada BETWEEN ? AND DATE_ADD(?, INTERVAL ? DAY))";
        try (Connection con = Conexion.getConexion();
             PreparedStatement ps = con.prepareStatement(sql)) {
            ps.setInt(1, idHabitacion);
            ps.setDate(2, fechaEntrada);
            ps.setDate(3, fechaEntrada);
            ps.setInt(4, dias);
            ResultSet rs = ps.executeQuery();
            return rs.next(); // Si devuelve algo, está ocupada
        } catch (SQLException e) {
            System.out.println("Error al verificar habitación: " + e.getMessage());
        }
        return false;
    }

    // Inserta una nueva reservación validando disponibilidad
    public boolean agregarReservacion(Reservacion r) {
        if (habitacionOcupada(r.getHabitacion().getId(), r.getFechaEntrada(), r.getDiasEstadia())) {
            System.out.println("La habitación ya está ocupada en ese período.");
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
            return true;
        } catch (SQLException e) {
            System.out.println("Error al agregar reservación: " + e.getMessage());
        }
        return false;
    }

    // Listar reservaciones por tipo (RECEPCION o TUROPERADOR)
    public List<Reservacion> listarPorTipo(String tipo) {
        List<Reservacion> lista = new ArrayList<>();
        String sql = "SELECT * FROM reservacion WHERE tipo_reservacion = ?";
        try (Connection con = Conexion.getConexion();
             PreparedStatement ps = con.prepareStatement(sql)) {
            ps.setString(1, tipo);
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
            System.out.println("Error al listar reservaciones: " + e.getMessage());
        }
        return lista;
    }
}

