package tablas;
// Generated 08/05/2014 09:52:36 AM by Hibernate Tools 3.6.0



/**
 * KardexSerieNumero generated by hbm2java
 */
public class KardexSerieNumero  implements java.io.Serializable {


     private Integer codKardexSerieNumero;
     private KardexArticuloProducto kardexArticuloProducto;
     private String serieNumero;
     private String observacion;
     private int compraSerieNumeroCodCompraSerieNumero;
     private String registro;

    public KardexSerieNumero() {
    }

	
    public KardexSerieNumero(KardexArticuloProducto kardexArticuloProducto, int compraSerieNumeroCodCompraSerieNumero, String registro) {
        this.kardexArticuloProducto = kardexArticuloProducto;
        this.compraSerieNumeroCodCompraSerieNumero = compraSerieNumeroCodCompraSerieNumero;
        this.registro = registro;
    }
    public KardexSerieNumero(KardexArticuloProducto kardexArticuloProducto, String serieNumero, String observacion, int compraSerieNumeroCodCompraSerieNumero, String registro) {
       this.kardexArticuloProducto = kardexArticuloProducto;
       this.serieNumero = serieNumero;
       this.observacion = observacion;
       this.compraSerieNumeroCodCompraSerieNumero = compraSerieNumeroCodCompraSerieNumero;
       this.registro = registro;
    }
   
    public Integer getCodKardexSerieNumero() {
        return this.codKardexSerieNumero;
    }
    
    public void setCodKardexSerieNumero(Integer codKardexSerieNumero) {
        this.codKardexSerieNumero = codKardexSerieNumero;
    }
    public KardexArticuloProducto getKardexArticuloProducto() {
        return this.kardexArticuloProducto;
    }
    
    public void setKardexArticuloProducto(KardexArticuloProducto kardexArticuloProducto) {
        this.kardexArticuloProducto = kardexArticuloProducto;
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
    public int getCompraSerieNumeroCodCompraSerieNumero() {
        return this.compraSerieNumeroCodCompraSerieNumero;
    }
    
    public void setCompraSerieNumeroCodCompraSerieNumero(int compraSerieNumeroCodCompraSerieNumero) {
        this.compraSerieNumeroCodCompraSerieNumero = compraSerieNumeroCodCompraSerieNumero;
    }
    public String getRegistro() {
        return this.registro;
    }
    
    public void setRegistro(String registro) {
        this.registro = registro;
    }




}


