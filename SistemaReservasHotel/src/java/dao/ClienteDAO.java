package dao;

import modelo.Cliente;
import java.sql.*;
import java.util.ArrayList;
import java.util.List;

public class ClienteDAO {
    
    public boolean agregarCliente(Cliente c) {
        String sql = "INSERT INTO cliente (nombre, edad, sexo, nacionalidad, ha_visitado) VALUES (?, ?, ?, ?, ?)";
        try (Connection con = Conexion.getConexion();
             PreparedStatement ps = con.prepareStatement(sql)) {
            ps.setString(1, c.getNombre());
            ps.setInt(2, c.getEdad());
            ps.setString(3, c.getSexo());
            ps.setString(4, c.getNacionalidad());
            ps.setBoolean(5, c.isHaVisitado());
            ps.executeUpdate();
            return true;
        } catch (SQLException e) {
            System.out.println("Error al agregar cliente: " + e.getMessage());
        }
        return false;
    }

    public List<Cliente> listarClientes() {
        List<Cliente> lista = new ArrayList<>();
        String sql = "SELECT * FROM cliente";
        try (Connection con = Conexion.getConexion();
             Statement st = con.createStatement();
             ResultSet rs = st.executeQuery(sql)) {
            while (rs.next()) {
                Cliente c = new Cliente(
                    rs.getInt("id"),
                    rs.getString("nombre"),
                    rs.getInt("edad"),
                    rs.getString("sexo"),
                    rs.getString("nacionalidad"),
                    rs.getBoolean("ha_visitado")
                );
                lista.add(c);
            }
        } catch (SQLException e) {
            System.out.println("Error al listar clientes: " + e.getMessage());
        }
        return lista;
    }
}
