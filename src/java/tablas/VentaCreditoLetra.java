package tablas;
// Generated 01/10/2014 04:51:32 PM by Hibernate Tools 3.6.0


import java.util.Date;
import java.util.HashSet;
import java.util.Set;

/**
 * VentaCreditoLetra generated by hbm2java
 */
public class VentaCreditoLetra  implements java.io.Serializable {


     private Integer codVentaCreditoLetra;
     private Ventas ventas;
     private Integer moneda;
     private Integer numeroLetra;
     private String detalleLetra;
     private Date fechaVencimiento;
     private Double monto;
     private Double interes;
     private Date fechaPago;
     private Double totalPago;
     private Double interesPagado;
     private Double interesPendiente;
     private Date interesUltimoCalculo;
     private String registro;
     private Set<CobranzaDetalle> cobranzaDetalles = new HashSet<CobranzaDetalle>(0);

    public VentaCreditoLetra() {
    }

	
    public VentaCreditoLetra(Ventas ventas, String registro) {
        this.ventas = ventas;
        this.registro = registro;
    }
    public VentaCreditoLetra(Ventas ventas, Integer moneda, Integer numeroLetra, String detalleLetra, Date fechaVencimiento, Double monto, Double interes, Date fechaPago, Double totalPago, Double interesPagado, Double interesPendiente, Date interesUltimoCalculo, String registro, Set<CobranzaDetalle> cobranzaDetalles) {
       this.ventas = ventas;
       this.moneda = moneda;
       this.numeroLetra = numeroLetra;
       this.detalleLetra = detalleLetra;
       this.fechaVencimiento = fechaVencimiento;
       this.monto = monto;
       this.interes = interes;
       this.fechaPago = fechaPago;
       this.totalPago = totalPago;
       this.interesPagado = interesPagado;
       this.interesPendiente = interesPendiente;
       this.interesUltimoCalculo = interesUltimoCalculo;
       this.registro = registro;
       this.cobranzaDetalles = cobranzaDetalles;
    }
   
    public Integer getCodVentaCreditoLetra() {
        return this.codVentaCreditoLetra;
    }
    
    public void setCodVentaCreditoLetra(Integer codVentaCreditoLetra) {
        this.codVentaCreditoLetra = codVentaCreditoLetra;
    }
    public Ventas getVentas() {
        return this.ventas;
    }
    
    public void setVentas(Ventas ventas) {
        this.ventas = ventas;
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
    public Double getInteresPagado() {
        return this.interesPagado;
    }
    
    public void setInteresPagado(Double interesPagado) {
        this.interesPagado = interesPagado;
    }
    public Double getInteresPendiente() {
        return this.interesPendiente;
    }
    
    public void setInteresPendiente(Double interesPendiente) {
        this.interesPendiente = interesPendiente;
    }
    public Date getInteresUltimoCalculo() {
        return this.interesUltimoCalculo;
    }
    
    public void setInteresUltimoCalculo(Date interesUltimoCalculo) {
        this.interesUltimoCalculo = interesUltimoCalculo;
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


