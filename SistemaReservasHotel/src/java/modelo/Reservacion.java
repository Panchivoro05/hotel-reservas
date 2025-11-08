package modelo;

import java.sql.Date;

public class Reservacion {
    private int id;
    private String codigo;
    private Cliente cliente;
    private Habitacion habitacion;
    private Turoperador turoperador;
    private Date fechaEntrada;
    private int diasEstadia;
    private boolean esTour;
    private String tipoReservacion;

    public Reservacion() {}

    public Reservacion(int id, String codigo, Cliente cliente, Habitacion habitacion, 
                       Turoperador turoperador, Date fechaEntrada, int diasEstadia, 
                       boolean esTour, String tipoReservacion) {
        this.id = id;
        this.codigo = codigo;
        this.cliente = cliente;
        this.habitacion = habitacion;
        this.turoperador = turoperador;
        this.fechaEntrada = fechaEntrada;
        this.diasEstadia = diasEstadia;
        this.esTour = esTour;
        this.tipoReservacion = tipoReservacion;
    }

    // Getters y Setters
    public int getId() { return id; }
    public void setId(int id) { this.id = id; }

    public String getCodigo() { return codigo; }
    public void setCodigo(String codigo) { this.codigo = codigo; }

    public Cliente getCliente() { return cliente; }
    public void setCliente(Cliente cliente) { this.cliente = cliente; }

    public Habitacion getHabitacion() { return habitacion; }
    public void setHabitacion(Habitacion habitacion) { this.habitacion = habitacion; }

    public Turoperador getTuroperador() { return turoperador; }
    public void setTuroperador(Turoperador turoperador) { this.turoperador = turoperador; }

    public Date getFechaEntrada() { return fechaEntrada; }
    public void setFechaEntrada(Date fechaEntrada) { this.fechaEntrada = fechaEntrada; }

    public int getDiasEstadia() { return diasEstadia; }
    public void setDiasEstadia(int diasEstadia) { this.diasEstadia = diasEstadia; }

    public boolean isEsTour() { return esTour; }
    public void setEsTour(boolean esTour) { this.esTour = esTour; }

    public String getTipoReservacion() { return tipoReservacion; }
    public void setTipoReservacion(String tipoReservacion) { this.tipoReservacion = tipoReservacion; }
}
