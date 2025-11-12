package dao;

import modelo.Turoperador;
import java.sql.*;
import java.util.ArrayList;
import java.util.List;

public class TuroperadorDAO {

    public boolean agregarTuroperador(Turoperador t) {
        String sql = "INSERT INTO turoperador (codigo, nombre, nacionalidad) VALUES (?, ?, ?)";
        try (Connection con = Conexion.getConexion();
             PreparedStatement ps = con.prepareStatement(sql)) {
            ps.setString(1, t.getCodigo());
            ps.setString(2, t.getNombre());
            ps.setString(3, t.getNacionalidad());
            ps.executeUpdate();
            return true;
        } catch (SQLException e) {
            System.out.println("Error al agregar turoperador: " + e.getMessage());
        }
        return false;
    }

    public List<Turoperador> listarTuroperadores() {
        List<Turoperador> lista = new ArrayList<>();
        String sql = "SELECT * FROM turoperador";
        try (Connection con = Conexion.getConexion();
             Statement st = con.createStatement();
             ResultSet rs = st.executeQuery(sql)) {
            while (rs.next()) {
                Turoperador t = new Turoperador(
                    rs.getInt("id"),
                    rs.getString("codigo"),
                    rs.getString("nombre"),
                    rs.getString("nacionalidad")
                );
                lista.add(t);
            }
        } catch (SQLException e) {
            System.out.println("Error al listar turoperadores: " + e.getMessage());
        }
        return lista;
    }
    
    public boolean eliminarTuroperador(int id) {
    String sql = "DELETE FROM turoperador WHERE id=?";
    try (Connection con = Conexion.getConexion();
         PreparedStatement ps = con.prepareStatement(sql)) {
        ps.setInt(1, id);
        return ps.executeUpdate() > 0;
    } catch (SQLException e) {
        System.out.println("Error al eliminar turoperador: " + e.getMessage());
    }
    return false;
}

    public boolean actualizarTuroperador(Turoperador t) {
        String sql = "UPDATE turoperador SET codigo=?, nombre=?, nacionalidad=? WHERE id=?";
        try (Connection con = Conexion.getConexion();
             PreparedStatement ps = con.prepareStatement(sql)) {
            ps.setString(1, t.getCodigo());
            ps.setString(2, t.getNombre());
            ps.setString(3, t.getNacionalidad());
            ps.setInt(4, t.getId());
            return ps.executeUpdate() > 0;
        } catch (SQLException e) {
            System.out.println("Error al actualizar turoperador: " + e.getMessage());
        }
        return false;
    }
    
    public Turoperador obtenerTuroperadorPorId(int id) {
        String sql = "SELECT * FROM turoperador WHERE id = ?";
        try (Connection con = Conexion.getConexion();
             PreparedStatement ps = con.prepareStatement(sql)) {
            ps.setInt(1, id);
            ResultSet rs = ps.executeQuery();
            if (rs.next()) {
                return new Turoperador(
                    rs.getInt("id"),
                    rs.getString("codigo"),
                    rs.getString("nombre"),
                    rs.getString("nacionalidad")
                );
            }
        } catch (SQLException e) {
            System.out.println("Error al obtener turoperador por ID: " + e.getMessage());
        }
        return null;
    }


}

