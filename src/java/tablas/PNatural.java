package tablas;
// Generated 14/05/2014 01:19:00 PM by Hibernate Tools 3.6.0



/**
 * PNatural generated by hbm2java
 */
public class PNatural  implements java.io.Serializable {


     private Integer codNatural;
     private Persona persona;
     private String codModular;
     private String cargo;
     private String carben;
     private String apePaterno;
     private String apeMaterno;
     private Boolean sexo;
     private String estadoCivil;
     private String detalle;
     private String registro;

    public PNatural() {
    }

	
    public PNatural(Persona persona, String apePaterno, String apeMaterno, String registro) {
        this.persona = persona;
        this.apePaterno = apePaterno;
        this.apeMaterno = apeMaterno;
        this.registro = registro;
    }
    public PNatural(Persona persona, String codModular, String cargo, String carben, String apePaterno, String apeMaterno, Boolean sexo, String estadoCivil, String detalle, String registro) {
       this.persona = persona;
       this.codModular = codModular;
       this.cargo = cargo;
       this.carben = carben;
       this.apePaterno = apePaterno;
       this.apeMaterno = apeMaterno;
       this.sexo = sexo;
       this.estadoCivil = estadoCivil;
       this.detalle = detalle;
       this.registro = registro;
    }
   
    public Integer getCodNatural() {
        return this.codNatural;
    }
    
    public void setCodNatural(Integer codNatural) {
        this.codNatural = codNatural;
    }
    public Persona getPersona() {
        return this.persona;
    }
    
    public void setPersona(Persona persona) {
        this.persona = persona;
    }
    public String getCodModular() {
        return this.codModular;
    }
    
    public void setCodModular(String codModular) {
        this.codModular = codModular;
    }
    public String getCargo() {
        return this.cargo;
    }
    
    public void setCargo(String cargo) {
        this.cargo = cargo;
    }
    public String getCarben() {
        return this.carben;
    }
    
    public void setCarben(String carben) {
        this.carben = carben;
    }
    public String getApePaterno() {
        return this.apePaterno;
    }
    
    public void setApePaterno(String apePaterno) {
        this.apePaterno = apePaterno;
    }
    public String getApeMaterno() {
        return this.apeMaterno;
    }
    
    public void setApeMaterno(String apeMaterno) {
        this.apeMaterno = apeMaterno;
    }
    public Boolean getSexo() {
        return this.sexo;
    }
    
    public void setSexo(Boolean sexo) {
        this.sexo = sexo;
    }
    public String getEstadoCivil() {
        return this.estadoCivil;
    }
    
    public void setEstadoCivil(String estadoCivil) {
        this.estadoCivil = estadoCivil;
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




}


