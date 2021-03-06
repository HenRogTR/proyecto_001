package tablas;
// Generated 01/10/2014 04:51:32 PM by Hibernate Tools 3.6.0


import java.util.Date;
import java.util.HashSet;
import java.util.Set;

/**
 * Ventas generated by hbm2java
 */
public class Ventas  implements java.io.Serializable {


     private Integer codVentas;
     private Persona persona;
     private Integer itemCantidad;
     private String docSerieNumero;
     private String tipo;
     private Date fecha;
     private String moneda;
     private double subTotal;
     private double descuento;
     private double total;
     private double valorIgv;
     private double neto;
     private String son;
     private int personaCodVendedor;
     private Boolean estado;
     private String observacion;
     private int codCliente;
     private String cliente;
     private String identificacion;
     private String direccion;
     private String docSerieNumeroGuia;
     private String direccion2;
     private String direccion3;
     private String duracion;
     private double montoInicial;
     private Date fechaInicialVencimiento;
     private int cantidadLetras;
     private double montoLetra;
     private Date fechaVencimientoLetraDeuda;
     private double interes;
     private double amortizado;
     private double interesPagado;
     private double saldo;
     private String registro;
     private Set<VentaCreditoLetra> ventaCreditoLetras = new HashSet<VentaCreditoLetra>(0);
     private Set<VentasDetalle> ventasDetalles = new HashSet<VentasDetalle>(0);
     private Set<TramiteDocumentario> tramiteDocumentarios = new HashSet<TramiteDocumentario>(0);

    public Ventas() {
    }

	
    public Ventas(Persona persona, String tipo, double subTotal, double descuento, double total, double valorIgv, double neto, String son, int personaCodVendedor, int codCliente, double montoInicial, int cantidadLetras, double montoLetra, double interes, double amortizado, double interesPagado, double saldo, String registro) {
        this.persona = persona;
        this.tipo = tipo;
        this.subTotal = subTotal;
        this.descuento = descuento;
        this.total = total;
        this.valorIgv = valorIgv;
        this.neto = neto;
        this.son = son;
        this.personaCodVendedor = personaCodVendedor;
        this.codCliente = codCliente;
        this.montoInicial = montoInicial;
        this.cantidadLetras = cantidadLetras;
        this.montoLetra = montoLetra;
        this.interes = interes;
        this.amortizado = amortizado;
        this.interesPagado = interesPagado;
        this.saldo = saldo;
        this.registro = registro;
    }
    public Ventas(Persona persona, Integer itemCantidad, String docSerieNumero, String tipo, Date fecha, String moneda, double subTotal, double descuento, double total, double valorIgv, double neto, String son, int personaCodVendedor, Boolean estado, String observacion, int codCliente, String cliente, String identificacion, String direccion, String docSerieNumeroGuia, String direccion2, String direccion3, String duracion, double montoInicial, Date fechaInicialVencimiento, int cantidadLetras, double montoLetra, Date fechaVencimientoLetraDeuda, double interes, double amortizado, double interesPagado, double saldo, String registro, Set<VentaCreditoLetra> ventaCreditoLetras, Set<VentasDetalle> ventasDetalles, Set<TramiteDocumentario> tramiteDocumentarios) {
       this.persona = persona;
       this.itemCantidad = itemCantidad;
       this.docSerieNumero = docSerieNumero;
       this.tipo = tipo;
       this.fecha = fecha;
       this.moneda = moneda;
       this.subTotal = subTotal;
       this.descuento = descuento;
       this.total = total;
       this.valorIgv = valorIgv;
       this.neto = neto;
       this.son = son;
       this.personaCodVendedor = personaCodVendedor;
       this.estado = estado;
       this.observacion = observacion;
       this.codCliente = codCliente;
       this.cliente = cliente;
       this.identificacion = identificacion;
       this.direccion = direccion;
       this.docSerieNumeroGuia = docSerieNumeroGuia;
       this.direccion2 = direccion2;
       this.direccion3 = direccion3;
       this.duracion = duracion;
       this.montoInicial = montoInicial;
       this.fechaInicialVencimiento = fechaInicialVencimiento;
       this.cantidadLetras = cantidadLetras;
       this.montoLetra = montoLetra;
       this.fechaVencimientoLetraDeuda = fechaVencimientoLetraDeuda;
       this.interes = interes;
       this.amortizado = amortizado;
       this.interesPagado = interesPagado;
       this.saldo = saldo;
       this.registro = registro;
       this.ventaCreditoLetras = ventaCreditoLetras;
       this.ventasDetalles = ventasDetalles;
       this.tramiteDocumentarios = tramiteDocumentarios;
    }
   
    public Integer getCodVentas() {
        return this.codVentas;
    }
    
    public void setCodVentas(Integer codVentas) {
        this.codVentas = codVentas;
    }
    public Persona getPersona() {
        return this.persona;
    }
    
    public void setPersona(Persona persona) {
        this.persona = persona;
    }
    public Integer getItemCantidad() {
        return this.itemCantidad;
    }
    
    public void setItemCantidad(Integer itemCantidad) {
        this.itemCantidad = itemCantidad;
    }
    public String getDocSerieNumero() {
        return this.docSerieNumero;
    }
    
    public void setDocSerieNumero(String docSerieNumero) {
        this.docSerieNumero = docSerieNumero;
    }
    public String getTipo() {
        return this.tipo;
    }
    
    public void setTipo(String tipo) {
        this.tipo = tipo;
    }
    public Date getFecha() {
        return this.fecha;
    }
    
    public void setFecha(Date fecha) {
        this.fecha = fecha;
    }
    public String getMoneda() {
        return this.moneda;
    }
    
    public void setMoneda(String moneda) {
        this.moneda = moneda;
    }
    public double getSubTotal() {
        return this.subTotal;
    }
    
    public void setSubTotal(double subTotal) {
        this.subTotal = subTotal;
    }
    public double getDescuento() {
        return this.descuento;
    }
    
    public void setDescuento(double descuento) {
        this.descuento = descuento;
    }
    public double getTotal() {
        return this.total;
    }
    
    public void setTotal(double total) {
        this.total = total;
    }
    public double getValorIgv() {
        return this.valorIgv;
    }
    
    public void setValorIgv(double valorIgv) {
        this.valorIgv = valorIgv;
    }
    public double getNeto() {
        return this.neto;
    }
    
    public void setNeto(double neto) {
        this.neto = neto;
    }
    public String getSon() {
        return this.son;
    }
    
    public void setSon(String son) {
        this.son = son;
    }
    public int getPersonaCodVendedor() {
        return this.personaCodVendedor;
    }
    
    public void setPersonaCodVendedor(int personaCodVendedor) {
        this.personaCodVendedor = personaCodVendedor;
    }
    public Boolean getEstado() {
        return this.estado;
    }
    
    public void setEstado(Boolean estado) {
        this.estado = estado;
    }
    public String getObservacion() {
        return this.observacion;
    }
    
    public void setObservacion(String observacion) {
        this.observacion = observacion;
    }
    public int getCodCliente() {
        return this.codCliente;
    }
    
    public void setCodCliente(int codCliente) {
        this.codCliente = codCliente;
    }
    public String getCliente() {
        return this.cliente;
    }
    
    public void setCliente(String cliente) {
        this.cliente = cliente;
    }
    public String getIdentificacion() {
        return this.identificacion;
    }
    
    public void setIdentificacion(String identificacion) {
        this.identificacion = identificacion;
    }
    public String getDireccion() {
        return this.direccion;
    }
    
    public void setDireccion(String direccion) {
        this.direccion = direccion;
    }
    public String getDocSerieNumeroGuia() {
        return this.docSerieNumeroGuia;
    }
    
    public void setDocSerieNumeroGuia(String docSerieNumeroGuia) {
        this.docSerieNumeroGuia = docSerieNumeroGuia;
    }
    public String getDireccion2() {
        return this.direccion2;
    }
    
    public void setDireccion2(String direccion2) {
        this.direccion2 = direccion2;
    }
    public String getDireccion3() {
        return this.direccion3;
    }
    
    public void setDireccion3(String direccion3) {
        this.direccion3 = direccion3;
    }
    public String getDuracion() {
        return this.duracion;
    }
    
    public void setDuracion(String duracion) {
        this.duracion = duracion;
    }
    public double getMontoInicial() {
        return this.montoInicial;
    }
    
    public void setMontoInicial(double montoInicial) {
        this.montoInicial = montoInicial;
    }
    public Date getFechaInicialVencimiento() {
        return this.fechaInicialVencimiento;
    }
    
    public void setFechaInicialVencimiento(Date fechaInicialVencimiento) {
        this.fechaInicialVencimiento = fechaInicialVencimiento;
    }
    public int getCantidadLetras() {
        return this.cantidadLetras;
    }
    
    public void setCantidadLetras(int cantidadLetras) {
        this.cantidadLetras = cantidadLetras;
    }
    public double getMontoLetra() {
        return this.montoLetra;
    }
    
    public void setMontoLetra(double montoLetra) {
        this.montoLetra = montoLetra;
    }
    public Date getFechaVencimientoLetraDeuda() {
        return this.fechaVencimientoLetraDeuda;
    }
    
    public void setFechaVencimientoLetraDeuda(Date fechaVencimientoLetraDeuda) {
        this.fechaVencimientoLetraDeuda = fechaVencimientoLetraDeuda;
    }
    public double getInteres() {
        return this.interes;
    }
    
    public void setInteres(double interes) {
        this.interes = interes;
    }
    public double getAmortizado() {
        return this.amortizado;
    }
    
    public void setAmortizado(double amortizado) {
        this.amortizado = amortizado;
    }
    public double getInteresPagado() {
        return this.interesPagado;
    }
    
    public void setInteresPagado(double interesPagado) {
        this.interesPagado = interesPagado;
    }
    public double getSaldo() {
        return this.saldo;
    }
    
    public void setSaldo(double saldo) {
        this.saldo = saldo;
    }
    public String getRegistro() {
        return this.registro;
    }
    
    public void setRegistro(String registro) {
        this.registro = registro;
    }
    public Set<VentaCreditoLetra> getVentaCreditoLetras() {
        return this.ventaCreditoLetras;
    }
    
    public void setVentaCreditoLetras(Set<VentaCreditoLetra> ventaCreditoLetras) {
        this.ventaCreditoLetras = ventaCreditoLetras;
    }
    public Set<VentasDetalle> getVentasDetalles() {
        return this.ventasDetalles;
    }
    
    public void setVentasDetalles(Set<VentasDetalle> ventasDetalles) {
        this.ventasDetalles = ventasDetalles;
    }
    public Set<TramiteDocumentario> getTramiteDocumentarios() {
        return this.tramiteDocumentarios;
    }
    
    public void setTramiteDocumentarios(Set<TramiteDocumentario> tramiteDocumentarios) {
        this.tramiteDocumentarios = tramiteDocumentarios;
    }




}


