package tablas;
// Generated 22/05/2014 10:20:56 AM by Hibernate Tools 3.6.0


import java.util.Date;
import java.util.HashSet;
import java.util.Set;

/**
 * Persona generated by hbm2java
 */
public class Persona  implements java.io.Serializable {


     private Integer codPersona;
     private Zona zona;
     private String nombres;
     private String nombresC;
     private String direccion;
     private String dniPasaporte;
     private String telefono1;
     private String telefono2;
     private String ruc;
     private String email;
     private String foto;
     private Boolean estado;
     private Date fechaNacimiento;
     private String paginaWeb;
     private String observaciones;
     private String logo;
     private String registro;
     private Set<Personal> personals = new HashSet<Personal>(0);
     private Set<PNatural> PNaturals = new HashSet<PNatural>(0);
     private Set<Usuario> usuarios = new HashSet<Usuario>(0);
     private Set<Ventas> ventases = new HashSet<Ventas>(0);
     private Set<Cobranza> cobranzas = new HashSet<Cobranza>(0);
     private Set<DatosCliente> datosClientes = new HashSet<DatosCliente>(0);

    public Persona() {
    }

	
    public Persona(Zona zona, String nombres, String nombresC, String direccion, String dniPasaporte, String registro) {
        this.zona = zona;
        this.nombres = nombres;
        this.nombresC = nombresC;
        this.direccion = direccion;
        this.dniPasaporte = dniPasaporte;
        this.registro = registro;
    }
    public Persona(Zona zona, String nombres, String nombresC, String direccion, String dniPasaporte, String telefono1, String telefono2, String ruc, String email, String foto, Boolean estado, Date fechaNacimiento, String paginaWeb, String observaciones, String logo, String registro, Set<Personal> personals, Set<PNatural> PNaturals, Set<Usuario> usuarios, Set<Ventas> ventases, Set<Cobranza> cobranzas, Set<DatosCliente> datosClientes) {
       this.zona = zona;
       this.nombres = nombres;
       this.nombresC = nombresC;
       this.direccion = direccion;
       this.dniPasaporte = dniPasaporte;
       this.telefono1 = telefono1;
       this.telefono2 = telefono2;
       this.ruc = ruc;
       this.email = email;
       this.foto = foto;
       this.estado = estado;
       this.fechaNacimiento = fechaNacimiento;
       this.paginaWeb = paginaWeb;
       this.observaciones = observaciones;
       this.logo = logo;
       this.registro = registro;
       this.personals = personals;
       this.PNaturals = PNaturals;
       this.usuarios = usuarios;
       this.ventases = ventases;
       this.cobranzas = cobranzas;
       this.datosClientes = datosClientes;
    }
   
    public Integer getCodPersona() {
        return this.codPersona;
    }
    
    public void setCodPersona(Integer codPersona) {
        this.codPersona = codPersona;
    }
    public Zona getZona() {
        return this.zona;
    }
    
    public void setZona(Zona zona) {
        this.zona = zona;
    }
    public String getNombres() {
        return this.nombres;
    }
    
    public void setNombres(String nombres) {
        this.nombres = nombres;
    }
    public String getNombresC() {
        return this.nombresC;
    }
    
    public void setNombresC(String nombresC) {
        this.nombresC = nombresC;
    }
    public String getDireccion() {
        return this.direccion;
    }
    
    public void setDireccion(String direccion) {
        this.direccion = direccion;
    }
    public String getDniPasaporte() {
        return this.dniPasaporte;
    }
    
    public void setDniPasaporte(String dniPasaporte) {
        this.dniPasaporte = dniPasaporte;
    }
    public String getTelefono1() {
        return this.telefono1;
    }
    
    public void setTelefono1(String telefono1) {
        this.telefono1 = telefono1;
    }
    public String getTelefono2() {
        return this.telefono2;
    }
    
    public void setTelefono2(String telefono2) {
        this.telefono2 = telefono2;
    }
    public String getRuc() {
        return this.ruc;
    }
    
    public void setRuc(String ruc) {
        this.ruc = ruc;
    }
    public String getEmail() {
        return this.email;
    }
    
    public void setEmail(String email) {
        this.email = email;
    }
    public String getFoto() {
        return this.foto;
    }
    
    public void setFoto(String foto) {
        this.foto = foto;
    }
    public Boolean getEstado() {
        return this.estado;
    }
    
    public void setEstado(Boolean estado) {
        this.estado = estado;
    }
    public Date getFechaNacimiento() {
        return this.fechaNacimiento;
    }
    
    public void setFechaNacimiento(Date fechaNacimiento) {
        this.fechaNacimiento = fechaNacimiento;
    }
    public String getPaginaWeb() {
        return this.paginaWeb;
    }
    
    public void setPaginaWeb(String paginaWeb) {
        this.paginaWeb = paginaWeb;
    }
    public String getObservaciones() {
        return this.observaciones;
    }
    
    public void setObservaciones(String observaciones) {
        this.observaciones = observaciones;
    }
    public String getLogo() {
        return this.logo;
    }
    
    public void setLogo(String logo) {
        this.logo = logo;
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
    public Set<PNatural> getPNaturals() {
        return this.PNaturals;
    }
    
    public void setPNaturals(Set<PNatural> PNaturals) {
        this.PNaturals = PNaturals;
    }
    public Set<Usuario> getUsuarios() {
        return this.usuarios;
    }
    
    public void setUsuarios(Set<Usuario> usuarios) {
        this.usuarios = usuarios;
    }
    public Set<Ventas> getVentases() {
        return this.ventases;
    }
    
    public void setVentases(Set<Ventas> ventases) {
        this.ventases = ventases;
    }
    public Set<Cobranza> getCobranzas() {
        return this.cobranzas;
    }
    
    public void setCobranzas(Set<Cobranza> cobranzas) {
        this.cobranzas = cobranzas;
    }
    public Set<DatosCliente> getDatosClientes() {
        return this.datosClientes;
    }
    
    public void setDatosClientes(Set<DatosCliente> datosClientes) {
        this.datosClientes = datosClientes;
    }




}


