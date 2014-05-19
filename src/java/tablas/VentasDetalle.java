package tablas;
// Generated 14/05/2014 01:19:00 PM by Hibernate Tools 3.6.0


import java.util.HashSet;
import java.util.Set;

/**
 * VentasDetalle generated by hbm2java
 */
public class VentasDetalle  implements java.io.Serializable {


     private Integer codVentasDetalle;
     private ArticuloProducto articuloProducto;
     private Ventas ventas;
     private Integer item;
     private Integer cantidad;
     private String descripcion;
     private double precioReal;
     private double precioProforma;
     private double precioVenta;
     private double valorVenta;
     private String registro;
     private Set<VentasSerieNumero> ventasSerieNumeros = new HashSet<VentasSerieNumero>(0);

    public VentasDetalle() {
    }

	
    public VentasDetalle(ArticuloProducto articuloProducto, Ventas ventas, double precioReal, double precioProforma, double precioVenta, double valorVenta, String registro) {
        this.articuloProducto = articuloProducto;
        this.ventas = ventas;
        this.precioReal = precioReal;
        this.precioProforma = precioProforma;
        this.precioVenta = precioVenta;
        this.valorVenta = valorVenta;
        this.registro = registro;
    }
    public VentasDetalle(ArticuloProducto articuloProducto, Ventas ventas, Integer item, Integer cantidad, String descripcion, double precioReal, double precioProforma, double precioVenta, double valorVenta, String registro, Set<VentasSerieNumero> ventasSerieNumeros) {
       this.articuloProducto = articuloProducto;
       this.ventas = ventas;
       this.item = item;
       this.cantidad = cantidad;
       this.descripcion = descripcion;
       this.precioReal = precioReal;
       this.precioProforma = precioProforma;
       this.precioVenta = precioVenta;
       this.valorVenta = valorVenta;
       this.registro = registro;
       this.ventasSerieNumeros = ventasSerieNumeros;
    }
   
    public Integer getCodVentasDetalle() {
        return this.codVentasDetalle;
    }
    
    public void setCodVentasDetalle(Integer codVentasDetalle) {
        this.codVentasDetalle = codVentasDetalle;
    }
    public ArticuloProducto getArticuloProducto() {
        return this.articuloProducto;
    }
    
    public void setArticuloProducto(ArticuloProducto articuloProducto) {
        this.articuloProducto = articuloProducto;
    }
    public Ventas getVentas() {
        return this.ventas;
    }
    
    public void setVentas(Ventas ventas) {
        this.ventas = ventas;
    }
    public Integer getItem() {
        return this.item;
    }
    
    public void setItem(Integer item) {
        this.item = item;
    }
    public Integer getCantidad() {
        return this.cantidad;
    }
    
    public void setCantidad(Integer cantidad) {
        this.cantidad = cantidad;
    }
    public String getDescripcion() {
        return this.descripcion;
    }
    
    public void setDescripcion(String descripcion) {
        this.descripcion = descripcion;
    }
    public double getPrecioReal() {
        return this.precioReal;
    }
    
    public void setPrecioReal(double precioReal) {
        this.precioReal = precioReal;
    }
    public double getPrecioProforma() {
        return this.precioProforma;
    }
    
    public void setPrecioProforma(double precioProforma) {
        this.precioProforma = precioProforma;
    }
    public double getPrecioVenta() {
        return this.precioVenta;
    }
    
    public void setPrecioVenta(double precioVenta) {
        this.precioVenta = precioVenta;
    }
    public double getValorVenta() {
        return this.valorVenta;
    }
    
    public void setValorVenta(double valorVenta) {
        this.valorVenta = valorVenta;
    }
    public String getRegistro() {
        return this.registro;
    }
    
    public void setRegistro(String registro) {
        this.registro = registro;
    }
    public Set<VentasSerieNumero> getVentasSerieNumeros() {
        return this.ventasSerieNumeros;
    }
    
    public void setVentasSerieNumeros(Set<VentasSerieNumero> ventasSerieNumeros) {
        this.ventasSerieNumeros = ventasSerieNumeros;
    }




}


