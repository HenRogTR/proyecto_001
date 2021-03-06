package tablas;
// Generated 01/10/2014 04:51:32 PM by Hibernate Tools 3.6.0



/**
 * PrecioVenta generated by hbm2java
 */
public class PrecioVenta  implements java.io.Serializable {


     private Integer codPrecioVenta;
     private ArticuloProducto articuloProducto;
     private double precioVenta;
     private String observacion;
     private int codCompraDetalle;
     private String registro;

    public PrecioVenta() {
    }

	
    public PrecioVenta(ArticuloProducto articuloProducto, double precioVenta, int codCompraDetalle, String registro) {
        this.articuloProducto = articuloProducto;
        this.precioVenta = precioVenta;
        this.codCompraDetalle = codCompraDetalle;
        this.registro = registro;
    }
    public PrecioVenta(ArticuloProducto articuloProducto, double precioVenta, String observacion, int codCompraDetalle, String registro) {
       this.articuloProducto = articuloProducto;
       this.precioVenta = precioVenta;
       this.observacion = observacion;
       this.codCompraDetalle = codCompraDetalle;
       this.registro = registro;
    }
   
    public Integer getCodPrecioVenta() {
        return this.codPrecioVenta;
    }
    
    public void setCodPrecioVenta(Integer codPrecioVenta) {
        this.codPrecioVenta = codPrecioVenta;
    }
    public ArticuloProducto getArticuloProducto() {
        return this.articuloProducto;
    }
    
    public void setArticuloProducto(ArticuloProducto articuloProducto) {
        this.articuloProducto = articuloProducto;
    }
    public double getPrecioVenta() {
        return this.precioVenta;
    }
    
    public void setPrecioVenta(double precioVenta) {
        this.precioVenta = precioVenta;
    }
    public String getObservacion() {
        return this.observacion;
    }
    
    public void setObservacion(String observacion) {
        this.observacion = observacion;
    }
    public int getCodCompraDetalle() {
        return this.codCompraDetalle;
    }
    
    public void setCodCompraDetalle(int codCompraDetalle) {
        this.codCompraDetalle = codCompraDetalle;
    }
    public String getRegistro() {
        return this.registro;
    }
    
    public void setRegistro(String registro) {
        this.registro = registro;
    }




}


