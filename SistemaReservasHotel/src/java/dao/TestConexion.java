package dao;

import java.sql.Connection;
import java.sql.DriverManager;

public class TestConexion {
    public static void main(String[] args) {
        String url = "jdbc:mysql://localhost:3306/hotel_reservas";
        String user = "root";
        String pass = "123456";

        try {
            Connection con = DriverManager.getConnection(url, user, pass);
            System.out.println("✅ Conexión exitosa a MySQL");
        } catch (Exception e) {
            System.out.println("❌ Error: " + e.getMessage());
        }
    }
}

