package tablas;
// Generated 14/05/2014 01:19:00 PM by Hibernate Tools 3.6.0


import java.util.Date;
import java.util.HashSet;
import java.util.Set;

/**
 * Compra generated by hbm2java
 */
public class Compra  implements java.io.Serializable {


     private Integer codCompra;
     private Proveedor proveedor;
     private String tipo;
     private int itemCantidad;
     private String docSerieNumero;
     private Date fechaFactura;
     private Date fechaVencimiento;
     private Date fechaLlegada;
     private double subTotal;
     private double total;
     private Double montoIgv;
     private Double neto;
     private String son;
     private String moneda;
     private String observacion;
     private String registro;
     private Set<CompraDetalle> compraDetalles = new HashSet<CompraDetalle>(0);

    public Compra() {
    }

	
    public Compra(Proveedor proveedor, int itemCantidad, String docSerieNumero, double subTotal, double total, String son, String registro) {
        this.proveedor = proveedor;
        this.itemCantidad = itemCantidad;
        this.docSerieNumero = docSerieNumero;
        this.subTotal = subTotal;
        this.total = total;
        this.son = son;
        this.registro = registro;
    }
    public Compra(Proveedor proveedor, String tipo, int itemCantidad, String docSerieNumero, Date fechaFactura, Date fechaVencimiento, Date fechaLlegada, double subTotal, double total, Double montoIgv, Double neto, String son, String moneda, String observacion, String registro, Set<CompraDetalle> compraDetalles) {
       this.proveedor = proveedor;
       this.tipo = tipo;
       this.itemCantidad = itemCantidad;
       this.docSerieNumero = docSerieNumero;
       this.fechaFactura = fechaFactura;
       this.fechaVencimiento = fechaVencimiento;
       this.fechaLlegada = fechaLlegada;
       this.subTotal = subTotal;
       this.total = total;
       this.montoIgv = montoIgv;
       this.neto = neto;
       this.son = son;
       this.moneda = moneda;
       this.observacion = observacion;
       this.registro = registro;
       this.compraDetalles = compraDetalles;
    }
   
    public Integer getCodCompra() {
        return this.codCompra;
    }
    
    public void setCodCompra(Integer codCompra) {
        this.codCompra = codCompra;
    }
    public Proveedor getProveedor() {
        return this.proveedor;
    }
    
    public void setProveedor(Proveedor proveedor) {
        this.proveedor = proveedor;
    }
    public String getTipo() {
        return this.tipo;
    }
    
    public void setTipo(String tipo) {
        this.tipo = tipo;
    }
    public int getItemCantidad() {
        return this.itemCantidad;
    }
    
    public void setItemCantidad(int itemCantidad) {
        this.itemCantidad = itemCantidad;
    }
    public String getDocSerieNumero() {
        return this.docSerieNumero;
    }
    
    public void setDocSerieNumero(String docSerieNumero) {
        this.docSerieNumero = docSerieNumero;
    }
    public Date getFechaFactura() {
        return this.fechaFactura;
    }
    
    public void setFechaFactura(Date fechaFactura) {
        this.fechaFactura = fechaFactura;
    }
    public Date getFechaVencimiento() {
        return this.fechaVencimiento;
    }
    
    public void setFechaVencimiento(Date fechaVencimiento) {
        this.fechaVencimiento = fechaVencimiento;
    }
    public Date getFechaLlegada() {
        return this.fechaLlegada;
    }
    
    public void setFechaLlegada(Date fechaLlegada) {
        this.fechaLlegada = fechaLlegada;
    }
    public double getSubTotal() {
        return this.subTotal;
    }
    
    public void setSubTotal(double subTotal) {
        this.subTotal = subTotal;
    }
    public double getTotal() {
        return this.total;
    }
    
    public void setTotal(double total) {
        this.total = total;
    }
    public Double getMontoIgv() {
        return this.montoIgv;
    }
    
    public void setMontoIgv(Double montoIgv) {
        this.montoIgv = montoIgv;
    }
    public Double getNeto() {
        return this.neto;
    }
    
    public void setNeto(Double neto) {
        this.neto = neto;
    }
    public String getSon() {
        return this.son;
    }
    
    public void setSon(String son) {
        this.son = son;
    }
    public String getMoneda() {
        return this.moneda;
    }
    
    public void setMoneda(String moneda) {
        this.moneda = moneda;
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
    public Set<CompraDetalle> getCompraDetalles() {
        return this.compraDetalles;
    }
    
    public void setCompraDetalles(Set<CompraDetalle> compraDetalles) {
        this.compraDetalles = compraDetalles;
    }




}


