package tablas;
// Generated 08/05/2014 09:52:36 AM by Hibernate Tools 3.6.0


import java.util.HashSet;
import java.util.Set;

/**
 * ComprobantePago generated by hbm2java
 */
public class ComprobantePago  implements java.io.Serializable {


     private Integer codComprobantePago;
     private String tipo;
     private String serie;
     private String registro;
     private Set<ComprobantePagoDetalle> comprobantePagoDetalles = new HashSet<ComprobantePagoDetalle>(0);

    public ComprobantePago() {
    }

	
    public ComprobantePago(String tipo, String serie, String registro) {
        this.tipo = tipo;
        this.serie = serie;
        this.registro = registro;
    }
    public ComprobantePago(String tipo, String serie, String registro, Set<ComprobantePagoDetalle> comprobantePagoDetalles) {
       this.tipo = tipo;
       this.serie = serie;
       this.registro = registro;
       this.comprobantePagoDetalles = comprobantePagoDetalles;
    }
   
    public Integer getCodComprobantePago() {
        return this.codComprobantePago;
    }
    
    public void setCodComprobantePago(Integer codComprobantePago) {
        this.codComprobantePago = codComprobantePago;
    }
    public String getTipo() {
        return this.tipo;
    }
    
    public void setTipo(String tipo) {
        this.tipo = tipo;
    }
    public String getSerie() {
        return this.serie;
    }
    
    public void setSerie(String serie) {
        this.serie = serie;
    }
    public String getRegistro() {
        return this.registro;
    }
    
    public void setRegistro(String registro) {
        this.registro = registro;
    }
    public Set<ComprobantePagoDetalle> getComprobantePagoDetalles() {
        return this.comprobantePagoDetalles;
    }
    
    public void setComprobantePagoDetalles(Set<ComprobantePagoDetalle> comprobantePagoDetalles) {
        this.comprobantePagoDetalles = comprobantePagoDetalles;
    }




}


