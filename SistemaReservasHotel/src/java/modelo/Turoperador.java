package modelo;

public class Turoperador {
    private int id;
    private String codigo;
    private String nombre;
    private String nacionalidad;

    public Turoperador() {}

    public Turoperador(int id, String codigo, String nombre, String nacionalidad) {
        this.id = id;
        this.codigo = codigo;
        this.nombre = nombre;
        this.nacionalidad = nacionalidad;
    }

    // Getters y Setters
    public int getId() { return id; }
    public void setId(int id) { this.id = id; }

    public String getCodigo() { return codigo; }
    public void setCodigo(String codigo) { this.codigo = codigo; }

    public String getNombre() { return nombre; }
    public void setNombre(String nombre) { this.nombre = nombre; }

    public String getNacionalidad() { return nacionalidad; }
    public void setNacionalidad(String nacionalidad) { this.nacionalidad = nacionalidad; }
}

