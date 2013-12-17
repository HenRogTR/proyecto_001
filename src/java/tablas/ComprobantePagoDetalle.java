package tablas;
// Generated 17/12/2013 10:15:59 AM by Hibernate Tools 3.6.0



/**
 * ComprobantePagoDetalle generated by hbm2java
 */
public class ComprobantePagoDetalle  implements java.io.Serializable {


     private Integer codComprobantePagoDetalle;
     private ComprobantePago comprobantePago;
     private String docSerieNumero;
     private Boolean estado;
     private String numero;
     private String registro;

    public ComprobantePagoDetalle() {
    }

	
    public ComprobantePagoDetalle(ComprobantePago comprobantePago, String docSerieNumero, String numero, String registro) {
        this.comprobantePago = comprobantePago;
        this.docSerieNumero = docSerieNumero;
        this.numero = numero;
        this.registro = registro;
    }
    public ComprobantePagoDetalle(ComprobantePago comprobantePago, String docSerieNumero, Boolean estado, String numero, String registro) {
       this.comprobantePago = comprobantePago;
       this.docSerieNumero = docSerieNumero;
       this.estado = estado;
       this.numero = numero;
       this.registro = registro;
    }
   
    public Integer getCodComprobantePagoDetalle() {
        return this.codComprobantePagoDetalle;
    }
    
    public void setCodComprobantePagoDetalle(Integer codComprobantePagoDetalle) {
        this.codComprobantePagoDetalle = codComprobantePagoDetalle;
    }
    public ComprobantePago getComprobantePago() {
        return this.comprobantePago;
    }
    
    public void setComprobantePago(ComprobantePago comprobantePago) {
        this.comprobantePago = comprobantePago;
    }
    public String getDocSerieNumero() {
        return this.docSerieNumero;
    }
    
    public void setDocSerieNumero(String docSerieNumero) {
        this.docSerieNumero = docSerieNumero;
    }
    public Boolean getEstado() {
        return this.estado;
    }
    
    public void setEstado(Boolean estado) {
        this.estado = estado;
    }
    public String getNumero() {
        return this.numero;
    }
    
    public void setNumero(String numero) {
        this.numero = numero;
    }
    public String getRegistro() {
        return this.registro;
    }
    
    public void setRegistro(String registro) {
        this.registro = registro;
    }




}


