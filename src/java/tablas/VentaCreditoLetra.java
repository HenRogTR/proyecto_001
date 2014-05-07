package tablas;
// Generated 29/04/2014 10:30:26 AM by Hibernate Tools 3.6.0


import java.util.Date;
import java.util.HashSet;
import java.util.Set;

/**
 * VentaCreditoLetra generated by hbm2java
 */
public class VentaCreditoLetra  implements java.io.Serializable {


     private Integer codVentaCreditoLetra;
     private VentaCredito ventaCredito;
     private Integer moneda;
     private Integer numeroLetra;
     private String detalleLetra;
     private Date fechaVencimiento;
     private Double monto;
     private Double interes;
     private Date fechaPago;
     private Double totalPago;
     private String registro;
     private Set<CobranzaDetalle> cobranzaDetalles = new HashSet<CobranzaDetalle>(0);

    public VentaCreditoLetra() {
    }

	
    public VentaCreditoLetra(VentaCredito ventaCredito, String registro) {
        this.ventaCredito = ventaCredito;
        this.registro = registro;
    }
    public VentaCreditoLetra(VentaCredito ventaCredito, Integer moneda, Integer numeroLetra, String detalleLetra, Date fechaVencimiento, Double monto, Double interes, Date fechaPago, Double totalPago, String registro, Set<CobranzaDetalle> cobranzaDetalles) {
       this.ventaCredito = ventaCredito;
       this.moneda = moneda;
       this.numeroLetra = numeroLetra;
       this.detalleLetra = detalleLetra;
       this.fechaVencimiento = fechaVencimiento;
       this.monto = monto;
       this.interes = interes;
       this.fechaPago = fechaPago;
       this.totalPago = totalPago;
       this.registro = registro;
       this.cobranzaDetalles = cobranzaDetalles;
    }
   
    public Integer getCodVentaCreditoLetra() {
        return this.codVentaCreditoLetra;
    }
    
    public void setCodVentaCreditoLetra(Integer codVentaCreditoLetra) {
        this.codVentaCreditoLetra = codVentaCreditoLetra;
    }
    public VentaCredito getVentaCredito() {
        return this.ventaCredito;
    }
    
    public void setVentaCredito(VentaCredito ventaCredito) {
        this.ventaCredito = ventaCredito;
    }
    public Integer getMoneda() {
        return this.moneda;
    }
    
    public void setMoneda(Integer moneda) {
        this.moneda = moneda;
    }
    public Integer getNumeroLetra() {
        return this.numeroLetra;
    }
    
    public void setNumeroLetra(Integer numeroLetra) {
        this.numeroLetra = numeroLetra;
    }
    public String getDetalleLetra() {
        return this.detalleLetra;
    }
    
    public void setDetalleLetra(String detalleLetra) {
        this.detalleLetra = detalleLetra;
    }
    public Date getFechaVencimiento() {
        return this.fechaVencimiento;
    }
    
    public void setFechaVencimiento(Date fechaVencimiento) {
        this.fechaVencimiento = fechaVencimiento;
    }
    public Double getMonto() {
        return this.monto;
    }
    
    public void setMonto(Double monto) {
        this.monto = monto;
    }
    public Double getInteres() {
        return this.interes;
    }
    
    public void setInteres(Double interes) {
        this.interes = interes;
    }
    public Date getFechaPago() {
        return this.fechaPago;
    }
    
    public void setFechaPago(Date fechaPago) {
        this.fechaPago = fechaPago;
    }
    public Double getTotalPago() {
        return this.totalPago;
    }
    
    public void setTotalPago(Double totalPago) {
        this.totalPago = totalPago;
    }
    public String getRegistro() {
        return this.registro;
    }
    
    public void setRegistro(String registro) {
        this.registro = registro;
    }
    public Set<CobranzaDetalle> getCobranzaDetalles() {
        return this.cobranzaDetalles;
    }
    
    public void setCobranzaDetalles(Set<CobranzaDetalle> cobranzaDetalles) {
        this.cobranzaDetalles = cobranzaDetalles;
    }




}


