package dao;

import modelo.Habitacion;
import java.sql.*;
import java.util.ArrayList;
import java.util.List;

public class HabitacionDAO {

    public List<Habitacion> listarTodas() {
        List<Habitacion> lista = new ArrayList<>();
        String sql = "SELECT * FROM habitacion ORDER BY numero";
        try (Connection con = Conexion.getConexion();
             Statement st = con.createStatement();
             ResultSet rs = st.executeQuery(sql)) {
            while (rs.next()) {
                Habitacion h = new Habitacion(
                    rs.getInt("id"),
                    rs.getInt("numero"),
                    rs.getString("tipo"),
                    rs.getDouble("precio"),
                    rs.getString("estado")
                );
                lista.add(h);
            }
        } catch (SQLException e) {
            System.out.println("Error al listar habitaciones: " + e.getMessage());
        }
        return lista;
    }

    public Habitacion obtenerPorId(int id) {
        String sql = "SELECT * FROM habitacion WHERE id = ?";
        try (Connection con = Conexion.getConexion();
             PreparedStatement ps = con.prepareStatement(sql)) {
            ps.setInt(1, id);
            ResultSet rs = ps.executeQuery();
            if (rs.next()) {
                return new Habitacion(
                    rs.getInt("id"),
                    rs.getInt("numero"),
                    rs.getString("tipo"),
                    rs.getDouble("precio"),
                    rs.getString("estado")
                );
            }
        } catch (SQLException e) {
            System.out.println("Error al obtener habitación: " + e.getMessage());
        }
        return null;
    }

    public boolean agregarHabitacion(Habitacion h) {
        String sql = "INSERT INTO habitacion (numero, tipo, precio, estado) VALUES (?, ?, ?, ?)";
        try (Connection con = Conexion.getConexion();
             PreparedStatement ps = con.prepareStatement(sql)) {
            ps.setInt(1, h.getNumero());
            ps.setString(2, h.getTipo());
            ps.setDouble(3, h.getPrecio());
            ps.setString(4, h.getEstado());
            return ps.executeUpdate() > 0;
        } catch (SQLException e) {
            System.out.println("Error al agregar habitación: " + e.getMessage());
        }
        return false;
    }

    public boolean actualizarHabitacion(Habitacion h) {
        String sql = "UPDATE habitacion SET numero=?, tipo=?, precio=?, estado=? WHERE id=?";
        try (Connection con = Conexion.getConexion();
             PreparedStatement ps = con.prepareStatement(sql)) {
            ps.setInt(1, h.getNumero());
            ps.setString(2, h.getTipo());
            ps.setDouble(3, h.getPrecio());
            ps.setString(4, h.getEstado());
            ps.setInt(5, h.getId());
            return ps.executeUpdate() > 0;
        } catch (SQLException e) {
            System.out.println("Error al actualizar habitación: " + e.getMessage());
        }
        return false;
    }

    public boolean eliminarHabitacion(int id) {
        String sql = "DELETE FROM habitacion WHERE id = ?";
        try (Connection con = Conexion.getConexion();
             PreparedStatement ps = con.prepareStatement(sql)) {
            ps.setInt(1, id);
            return ps.executeUpdate() > 0;
        } catch (SQLException e) {
            System.out.println("Error al eliminar habitación: " + e.getMessage());
        }
        return false;
    }

    public List<Habitacion> listarDisponibles() {
        List<Habitacion> lista = new ArrayList<>();
        String sql = "SELECT * FROM habitacion WHERE estado = 'DISPONIBLE'";
        try (Connection con = Conexion.getConexion();
             Statement st = con.createStatement();
             ResultSet rs = st.executeQuery(sql)) {
            while (rs.next()) {
                Habitacion h = new Habitacion(
                    rs.getInt("id"),
                    rs.getInt("numero"),
                    rs.getString("tipo"),
                    rs.getDouble("precio"),
                    rs.getString("estado")
                );
                lista.add(h);
            }
        } catch (SQLException e) {
            System.out.println("Error al listar habitaciones disponibles: " + e.getMessage());
        }
        return lista;
    }

    public boolean actualizarEstado(int id, String estado) {
        String sql = "UPDATE habitacion SET estado = ? WHERE id = ?";
        try (Connection con = Conexion.getConexion();
             PreparedStatement ps = con.prepareStatement(sql)) {
            ps.setString(1, estado);
            ps.setInt(2, id);
            return ps.executeUpdate() > 0;
        } catch (SQLException e) {
            System.out.println("Error al actualizar estado: " + e.getMessage());
        }
        return false;
    }
}
