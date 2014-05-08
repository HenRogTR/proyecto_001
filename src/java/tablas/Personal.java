package tablas;
// Generated 08/05/2014 09:52:36 AM by Hibernate Tools 3.6.0


import java.util.Date;

/**
 * Personal generated by hbm2java
 */
public class Personal  implements java.io.Serializable {


     private Integer codPersonal;
     private Area area;
     private Cargo cargo;
     private Persona persona;
     private Date fechaInicioActividades;
     private Date fechaFinActividades;
     private Boolean estado;
     private String observacion;
     private String registro;

    public Personal() {
    }

	
    public Personal(Area area, Cargo cargo, Persona persona, String registro) {
        this.area = area;
        this.cargo = cargo;
        this.persona = persona;
        this.registro = registro;
    }
    public Personal(Area area, Cargo cargo, Persona persona, Date fechaInicioActividades, Date fechaFinActividades, Boolean estado, String observacion, String registro) {
       this.area = area;
       this.cargo = cargo;
       this.persona = persona;
       this.fechaInicioActividades = fechaInicioActividades;
       this.fechaFinActividades = fechaFinActividades;
       this.estado = estado;
       this.observacion = observacion;
       this.registro = registro;
    }
   
    public Integer getCodPersonal() {
        return this.codPersonal;
    }
    
    public void setCodPersonal(Integer codPersonal) {
        this.codPersonal = codPersonal;
    }
    public Area getArea() {
        return this.area;
    }
    
    public void setArea(Area area) {
        this.area = area;
    }
    public Cargo getCargo() {
        return this.cargo;
    }
    
    public void setCargo(Cargo cargo) {
        this.cargo = cargo;
    }
    public Persona getPersona() {
        return this.persona;
    }
    
    public void setPersona(Persona persona) {
        this.persona = persona;
    }
    public Date getFechaInicioActividades() {
        return this.fechaInicioActividades;
    }
    
    public void setFechaInicioActividades(Date fechaInicioActividades) {
        this.fechaInicioActividades = fechaInicioActividades;
    }
    public Date getFechaFinActividades() {
        return this.fechaFinActividades;
    }
    
    public void setFechaFinActividades(Date fechaFinActividades) {
        this.fechaFinActividades = fechaFinActividades;
    }
    public Boolean getEstado() {
        return this.estado;
    }
    
    public void setEstado(Boolean estado) {
        this.estado = estado;
    }
    public String getObservacion() {
        return this.observacion;
    }
    
    public void setObservacion(String observacion) {
        this.observacion = observacion;
    }
    public String getRegistro() {
        return this.registro;
    }
    
    public void setRegistro(String registro) {
        this.registro = registro;
    }




}


