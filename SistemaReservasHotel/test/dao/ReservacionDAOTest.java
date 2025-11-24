package dao;

import dao.ReservacionDAO;
import java.util.Date;
import modelo.Reservacion;
import java.util.List;
import java.util.Map;
import modelo.Cliente;
import modelo.Habitacion;
import org.junit.Test;
import static org.junit.Assert.*;

public class ReservacionDAOTest {

    /*@Test
    public void testListarReservas() {
        System.out.println("Probando listar reservaciones...");

        ReservacionDAO dao = new ReservacionDAO();
        List<Reservacion> lista = dao.listar();

        assertNotNull("La lista no debe ser nula", lista);
        assertTrue("Debe existir al menos una reservación en la BD", lista.size() > 0);

        System.out.println("Listado OK. Total reservaciones: " + lista.size());
    }*/
    
    /*@Test
    public void testAgregarReservacion() {
        System.out.println("\nTEST Agregar reservación");

        ReservacionDAO dao = new ReservacionDAO();

        Cliente cli = new Cliente();
        cli.setId(9);  // EXISTE

        Habitacion hab = new Habitacion();
        hab.setId(6);  // DISPONIBLE

        Reservacion r = new Reservacion();
        r.setCodigo("TEST" + System.currentTimeMillis()); // Evita duplicados
        r.setCliente(cli);
        r.setHabitacion(hab);
        r.setTuroperador(null);
        r.setFechaEntrada(java.sql.Date.valueOf("2025-12-20"));
        r.setDiasEstadia(2);
        r.setEsTour(false);
        r.setTipoReservacion("Recepcion");

        System.out.println("Reservación agregada");
    }*/
    
    /*@Test
    public void testActualizarFechaYDuracion() {
        System.out.println("\nTEST Actualizar fecha y duración");

        ReservacionDAO dao = new ReservacionDAO();

        int idReserva = 28; 
        java.sql.Date nuevaFecha = java.sql.Date.valueOf("2026-03-01");
        int nuevosDias = 4;


        System.out.println("Reservación actualizada");
    }*/
    
    /*@Test
    public void testEliminarReservacion() {
        System.out.println("\nTEST Eliminar reservación");

        ReservacionDAO dao = new ReservacionDAO();

        int idEliminar = 31; 

        System.out.println("Reservación eliminada");
    }*/
    
    /*@Test
    public void testListarPorTipo() {
        System.out.println("\nTEST Listar por tipo");

        ReservacionDAO dao = new ReservacionDAO();

        List<Reservacion> lista = dao.listarPorTipo("Recepcion");

        assertNotNull("La lista no debe ser nula", lista);
        assertTrue("Debe existir al menos una reserva tipo Recepcion", lista.size() > 0);

        System.out.println("Total reservas tipo Recepcion: " + lista.size());
    }*/
    
    /*@Test
    public void testPorcentajeReservasPorNacionalidad() {
        System.out.println("\nTEST Porcentaje por nacionalidad");

        ReservacionDAO dao = new ReservacionDAO();

        double porcentaje = dao.porcentajeReservasPorNacionalidad("Peru");

        assertTrue("El porcentaje debe ser válido", porcentaje >= 0);

        System.out.println("Porcentaje calculado: " + porcentaje);
    }*/
    
    /*@Test
    public void testSexoMasFrecuente() {
        System.out.println("\nTEST Sexo más frecuente por nacionalidad");

        ReservacionDAO dao = new ReservacionDAO();

        Map<String, Object> resultado = dao.obtenerSexoMasFrecuentePorNacionalidad("Peru");

        assertNotNull("El resultado no debe ser nulo", resultado);
        assertTrue("Debe contener el campo 'sexo'", resultado.containsKey("sexo"));
        assertTrue("Debe contener el campo 'total'", resultado.containsKey("total"));

        System.out.println("Sexo más frecuente: " + resultado.get("sexo"));
    }*/
    
    /*@Test
    public void testClientesFrecuentes() {
        System.out.println("\nTEST Clientes frecuentes");

        ReservacionDAO dao = new ReservacionDAO();

        List<Map<String, Object>> lista = dao.obtenerClientesFrecuentes();

        assertNotNull("La lista no debe ser nula", lista);
        assertTrue("Debe haber clientes frecuentes", lista.size() > 0);

        System.out.println("Total clientes frecuentes: " + lista.size());
    }*/
    
    /*@Test
    public void testListarClientesPorTuroperador() {
        System.out.println("\nTEST Clientes por turoperador");

        ReservacionDAO dao = new ReservacionDAO();

        List<Map<String, Object>> lista = dao.listarClientesPorTuroperador("TURO002");

        assertNotNull("La lista no debe ser nula", lista);
        assertTrue("Resultado válido", lista.size() >= 0);

        System.out.println("Resultados obtenidos: " + lista.size());
    }*/
    
    /*@Test
    public void testIntegracionRegistrarYListar() {
        System.out.println("\nINTEGRACION Registrar y luego listar");

        ReservacionDAO dao = new ReservacionDAO();

        // --- Registrar reserva nueva ---
        Cliente cli = new Cliente();
        cli.setId(9);  

        Habitacion hab = new Habitacion();
        hab.setId(6);  

        Reservacion r = new Reservacion();
        r.setCodigo("INT");
        r.setCliente(cli);
        r.setHabitacion(hab);
        r.setTuroperador(null);
        r.setFechaEntrada(java.sql.Date.valueOf("2026-04-10"));
        r.setDiasEstadia(2);
        r.setEsTour(false);
        r.setTipoReservacion("Recepcion");

        boolean ok = dao.agregarReservacion(r);

        assertTrue("La reserva debe registrarse correctamente", ok);

        // --- Listar reservas ---
        List<Reservacion> lista = dao.listar();

        assertNotNull("Lista no debe ser nula", lista);
        assertTrue("Debe existir al menos una reserva registrada", lista.size() > 0);

        System.out.println("Integracion Registrar Listar OK");
    }*/
    
    /*@Test
    public void testIntegracionRegistrarYActualizar() {
        System.out.println("\nINTEGRACION Registrar y luego actualizar");

        ReservacionDAO dao = new ReservacionDAO();

        // Registrar reserva
        Cliente cli = new Cliente();
        cli.setId(9);

        Habitacion hab = new Habitacion();
        hab.setId(6);

        Reservacion r = new Reservacion();
        r.setCodigo("INT-UPD");
        r.setCliente(cli);
        r.setHabitacion(hab);
        r.setTuroperador(null);
        r.setFechaEntrada(java.sql.Date.valueOf("2026-05-10"));
        r.setDiasEstadia(2);
        r.setEsTour(false);
        r.setTipoReservacion("Recepcion");

        boolean ok = dao.agregarReservacion(r);
        assertTrue("La reservación debe agregarse", ok);

        // Obtener ID recién insertado
        List<Reservacion> lista = dao.listar();
        int idInsertado = lista.get(0).getId();

        // Actualizar la reserva
        boolean actualizado = dao.actualizarFechaYDuracion(
                idInsertado,
                java.sql.Date.valueOf("2026-05-15"),
                3
        );

        assertTrue("La reservación debe actualizarse", actualizado);

        System.out.println("Integración Registrar Actualizar OK");
    }*/
    
    @Test
    public void testIntegracionRegistrarYEliminar() {
        System.out.println("\nINTEGRACION Registrar y luego eliminar");

        ReservacionDAO dao = new ReservacionDAO();

        Cliente cli = new Cliente();
        cli.setId(9);

        Habitacion hab = new Habitacion();
        hab.setId(6);

        Reservacion r = new Reservacion();
        r.setCodigo("INT-DEL");
        r.setCliente(cli);
        r.setHabitacion(hab);
        r.setTuroperador(null);
        r.setFechaEntrada(java.sql.Date.valueOf("2026-07-10"));
        r.setDiasEstadia(2);
        r.setEsTour(false);
        r.setTipoReservacion("Recepcion");

        boolean ok = dao.agregarReservacion(r);
        assertTrue("La reserva debe agregarse", ok);

        List<Reservacion> lista = dao.listar();
        int idInsertado = lista.get(0).getId();

        boolean eliminado = dao.eliminarReservacion(idInsertado);
        assertTrue("La reserva debe eliminarse", eliminado);

        System.out.println("Integración Registrar Eliminar OK");
    }

}


