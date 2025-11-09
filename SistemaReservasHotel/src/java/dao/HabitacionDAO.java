package dao;

import modelo.Habitacion;
import java.sql.*;
import java.util.ArrayList;
import java.util.List;

public class HabitacionDAO {

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
            System.out.println("Error al listar habitaciones: " + e.getMessage());
        }
        return lista;
    }

    public boolean actualizarEstado(int id, String estado) {
        String sql = "UPDATE habitacion SET estado = ? WHERE id = ?";
        try (Connection con = Conexion.getConexion();
             PreparedStatement ps = con.prepareStatement(sql)) {
            ps.setString(1, estado);
            ps.setInt(2, id);
            ps.executeUpdate();
            return true;
        } catch (SQLException e) {
            System.out.println("Error al actualizar estado: " + e.getMessage());
        }
        return false;
    }
}
