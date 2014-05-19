package tablas;
// Generated 14/05/2014 01:19:00 PM by Hibernate Tools 3.6.0


import java.util.HashSet;
import java.util.Set;

/**
 * EstadoDocumento generated by hbm2java
 */
public class EstadoDocumento  implements java.io.Serializable {


     private Integer codEstadoDocumento;
     private String estadoDocumento;
     private String detalle;
     private String registro;
     private Set<TramiteDocumentario> tramiteDocumentarios = new HashSet<TramiteDocumentario>(0);

    public EstadoDocumento() {
    }

	
    public EstadoDocumento(String estadoDocumento, String registro) {
        this.estadoDocumento = estadoDocumento;
        this.registro = registro;
    }
    public EstadoDocumento(String estadoDocumento, String detalle, String registro, Set<TramiteDocumentario> tramiteDocumentarios) {
       this.estadoDocumento = estadoDocumento;
       this.detalle = detalle;
       this.registro = registro;
       this.tramiteDocumentarios = tramiteDocumentarios;
    }
   
    public Integer getCodEstadoDocumento() {
        return this.codEstadoDocumento;
    }
    
    public void setCodEstadoDocumento(Integer codEstadoDocumento) {
        this.codEstadoDocumento = codEstadoDocumento;
    }
    public String getEstadoDocumento() {
        return this.estadoDocumento;
    }
    
    public void setEstadoDocumento(String estadoDocumento) {
        this.estadoDocumento = estadoDocumento;
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
    public Set<TramiteDocumentario> getTramiteDocumentarios() {
        return this.tramiteDocumentarios;
    }
    
    public void setTramiteDocumentarios(Set<TramiteDocumentario> tramiteDocumentarios) {
        this.tramiteDocumentarios = tramiteDocumentarios;
    }




}


