package tablas;
// Generated 01/10/2014 04:51:32 PM by Hibernate Tools 3.6.0



/**
 * VentasSerieNumero generated by hbm2java
 */
public class VentasSerieNumero  implements java.io.Serializable {


     private Integer codVentasSerieNumero;
     private VentasDetalle ventasDetalle;
     private String serieNumero;
     private String observacion;
     private String registro;

    public VentasSerieNumero() {
    }

	
    public VentasSerieNumero(VentasDetalle ventasDetalle, String registro) {
        this.ventasDetalle = ventasDetalle;
        this.registro = registro;
    }
    public VentasSerieNumero(VentasDetalle ventasDetalle, String serieNumero, String observacion, String registro) {
       this.ventasDetalle = ventasDetalle;
       this.serieNumero = serieNumero;
       this.observacion = observacion;
       this.registro = registro;
    }
   
    public Integer getCodVentasSerieNumero() {
        return this.codVentasSerieNumero;
    }
    
    public void setCodVentasSerieNumero(Integer codVentasSerieNumero) {
        this.codVentasSerieNumero = codVentasSerieNumero;
    }
    public VentasDetalle getVentasDetalle() {
        return this.ventasDetalle;
    }
    
    public void setVentasDetalle(VentasDetalle ventasDetalle) {
        this.ventasDetalle = ventasDetalle;
    }
    public String getSerieNumero() {
        return this.serieNumero;
    }
    
    public void setSerieNumero(String serieNumero) {
        this.serieNumero = serieNumero;
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


