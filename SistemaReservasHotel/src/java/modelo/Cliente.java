package modelo;

public class Cliente {
    private int id;
    private String nombre;
    private int edad;
    private String sexo;
    private String nacionalidad;
    private boolean haVisitado;

    public Cliente() {}

    public Cliente(int id, String nombre, int edad, String sexo, String nacionalidad, boolean haVisitado) {
        this.id = id;
        this.nombre = nombre;
        this.edad = edad;
        this.sexo = sexo;
        this.nacionalidad = nacionalidad;
        this.haVisitado = haVisitado;
    }

    // Getters y Setters
    public int getId() { return id; }
    public void setId(int id) { this.id = id; }

    public String getNombre() { return nombre; }
    public void setNombre(String nombre) { this.nombre = nombre; }

    public int getEdad() { return edad; }
    public void setEdad(int edad) { this.edad = edad; }

    public String getSexo() { return sexo; }
    public void setSexo(String sexo) { this.sexo = sexo; }

    public String getNacionalidad() { return nacionalidad; }
    public void setNacionalidad(String nacionalidad) { this.nacionalidad = nacionalidad; }

    public boolean isHaVisitado() { return haVisitado; }
    public void setHaVisitado(boolean haVisitado) { this.haVisitado = haVisitado; }
}

