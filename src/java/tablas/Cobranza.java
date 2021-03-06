package tablas;
// Generated 01/10/2014 04:51:32 PM by Hibernate Tools 3.6.0


import java.util.Date;
import java.util.HashSet;
import java.util.Set;

/**
 * Cobranza generated by hbm2java
 */
public class Cobranza  implements java.io.Serializable {


     private Integer codCobranza;
     private Persona persona;
     private Date fechaCobranza;
     private String docSerieNumero;
     private double saldoAnterior;
     private double importe;
     private double saldo;
     private Double montoPagado;
     private String observacion;
     private String registro;
     private Set<CobranzaDetalle> cobranzaDetalles = new HashSet<CobranzaDetalle>(0);

    public Cobranza() {
    }

	
    public Cobranza(Persona persona, String docSerieNumero, double saldoAnterior, double importe, double saldo, String registro) {
        this.persona = persona;
        this.docSerieNumero = docSerieNumero;
        this.saldoAnterior = saldoAnterior;
        this.importe = importe;
        this.saldo = saldo;
        this.registro = registro;
    }
    public Cobranza(Persona persona, Date fechaCobranza, String docSerieNumero, double saldoAnterior, double importe, double saldo, Double montoPagado, String observacion, String registro, Set<CobranzaDetalle> cobranzaDetalles) {
       this.persona = persona;
       this.fechaCobranza = fechaCobranza;
       this.docSerieNumero = docSerieNumero;
       this.saldoAnterior = saldoAnterior;
       this.importe = importe;
       this.saldo = saldo;
       this.montoPagado = montoPagado;
       this.observacion = observacion;
       this.registro = registro;
       this.cobranzaDetalles = cobranzaDetalles;
    }
   
    public Integer getCodCobranza() {
        return this.codCobranza;
    }
    
    public void setCodCobranza(Integer codCobranza) {
        this.codCobranza = codCobranza;
    }
    public Persona getPersona() {
        return this.persona;
    }
    
    public void setPersona(Persona persona) {
        this.persona = persona;
    }
    public Date getFechaCobranza() {
        return this.fechaCobranza;
    }
    
    public void setFechaCobranza(Date fechaCobranza) {
        this.fechaCobranza = fechaCobranza;
    }
    public String getDocSerieNumero() {
        return this.docSerieNumero;
    }
    
    public void setDocSerieNumero(String docSerieNumero) {
        this.docSerieNumero = docSerieNumero;
    }
    public double getSaldoAnterior() {
        return this.saldoAnterior;
    }
    
    public void setSaldoAnterior(double saldoAnterior) {
        this.saldoAnterior = saldoAnterior;
    }
    public double getImporte() {
        return this.importe;
    }
    
    public void setImporte(double importe) {
        this.importe = importe;
    }
    public double getSaldo() {
        return this.saldo;
    }
    
    public void setSaldo(double saldo) {
        this.saldo = saldo;
    }
    public Double getMontoPagado() {
        return this.montoPagado;
    }
    
    public void setMontoPagado(Double montoPagado) {
        this.montoPagado = montoPagado;
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
    public Set<CobranzaDetalle> getCobranzaDetalles() {
        return this.cobranzaDetalles;
    }
    
    public void setCobranzaDetalles(Set<CobranzaDetalle> cobranzaDetalles) {
        this.cobranzaDetalles = cobranzaDetalles;
    }




}


