package tablas;
// Generated 01/10/2014 04:51:32 PM by Hibernate Tools 3.6.0


import java.util.HashSet;
import java.util.Set;

/**
 * Cargo generated by hbm2java
 */
public class Cargo  implements java.io.Serializable {


     private Integer codCargo;
     private String cargo;
     private String detalle;
     private String registro;
     private Set<Personal> personals = new HashSet<Personal>(0);

    public Cargo() {
    }

	
    public Cargo(String cargo, String registro) {
        this.cargo = cargo;
        this.registro = registro;
    }
    public Cargo(String cargo, String detalle, String registro, Set<Personal> personals) {
       this.cargo = cargo;
       this.detalle = detalle;
       this.registro = registro;
       this.personals = personals;
    }
   
    public Integer getCodCargo() {
        return this.codCargo;
    }
    
    public void setCodCargo(Integer codCargo) {
        this.codCargo = codCargo;
    }
    public String getCargo() {
        return this.cargo;
    }
    
    public void setCargo(String cargo) {
        this.cargo = cargo;
    }
    public String getDetalle() {
        return this.detalle;
    }
    
    public void setDetalle(String detalle) {
        this.detalle = detalle;
    }
    public String getRegistro() {
        return this.registro;
    }
    
    public void setRegistro(String registro) {
        this.registro = registro;
    }
    public Set<Personal> getPersonals() {
        return this.personals;
    }
    
    public void setPersonals(Set<Personal> personals) {
        this.personals = personals;
    }




}


