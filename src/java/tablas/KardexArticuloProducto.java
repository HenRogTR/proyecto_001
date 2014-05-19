package tablas;
// Generated 14/05/2014 01:19:00 PM by Hibernate Tools 3.6.0


import java.util.HashSet;
import java.util.Set;

/**
 * KardexArticuloProducto generated by hbm2java
 */
public class KardexArticuloProducto  implements java.io.Serializable {


     private Integer codKardexArticuloProducto;
     private ArticuloProducto articuloProducto;
     private Almacen almacen;
     private int codOperacion;
     private int codOperacionDetalle;
     private int tipoOperacion;
     private String detalle;
     private Integer entrada;
     private Integer salida;
     private Integer stock;
     private Double precio;
     private Double precioPonderado;
     private Double total;
     private String observacion;
     private String registro;
     private Set<KardexSerieNumero> kardexSerieNumeros = new HashSet<KardexSerieNumero>(0);

    public KardexArticuloProducto() {
    }

	
    public KardexArticuloProducto(ArticuloProducto articuloProducto, Almacen almacen, int codOperacion, int codOperacionDetalle, int tipoOperacion, String registro) {
        this.articuloProducto = articuloProducto;
        this.almacen = almacen;
        this.codOperacion = codOperacion;
        this.codOperacionDetalle = codOperacionDetalle;
        this.tipoOperacion = tipoOperacion;
        this.registro = registro;
    }
    public KardexArticuloProducto(ArticuloProducto articuloProducto, Almacen almacen, int codOperacion, int codOperacionDetalle, int tipoOperacion, String detalle, Integer entrada, Integer salida, Integer stock, Double precio, Double precioPonderado, Double total, String observacion, String registro, Set<KardexSerieNumero> kardexSerieNumeros) {
       this.articuloProducto = articuloProducto;
       this.almacen = almacen;
       this.codOperacion = codOperacion;
       this.codOperacionDetalle = codOperacionDetalle;
       this.tipoOperacion = tipoOperacion;
       this.detalle = detalle;
       this.entrada = entrada;
       this.salida = salida;
       this.stock = stock;
       this.precio = precio;
       this.precioPonderado = precioPonderado;
       this.total = total;
       this.observacion = observacion;
       this.registro = registro;
       this.kardexSerieNumeros = kardexSerieNumeros;
    }
   
    public Integer getCodKardexArticuloProducto() {
        return this.codKardexArticuloProducto;
    }
    
    public void setCodKardexArticuloProducto(Integer codKardexArticuloProducto) {
        this.codKardexArticuloProducto = codKardexArticuloProducto;
    }
    public ArticuloProducto getArticuloProducto() {
        return this.articuloProducto;
    }
    
    public void setArticuloProducto(ArticuloProducto articuloProducto) {
        this.articuloProducto = articuloProducto;
    }
    public Almacen getAlmacen() {
        return this.almacen;
    }
    
    public void setAlmacen(Almacen almacen) {
        this.almacen = almacen;
    }
    public int getCodOperacion() {
        return this.codOperacion;
    }
    
    public void setCodOperacion(int codOperacion) {
        this.codOperacion = codOperacion;
    }
    public int getCodOperacionDetalle() {
        return this.codOperacionDetalle;
    }
    
    public void setCodOperacionDetalle(int codOperacionDetalle) {
        this.codOperacionDetalle = codOperacionDetalle;
    }
    public int getTipoOperacion() {
        return this.tipoOperacion;
    }
    
    public void setTipoOperacion(int tipoOperacion) {
        this.tipoOperacion = tipoOperacion;
    }
    public String getDetalle() {
        return this.detalle;
    }
    
    public void setDetalle(String detalle) {
        this.detalle = detalle;
    }
    public Integer getEntrada() {
        return this.entrada;
    }
    
    public void setEntrada(Integer entrada) {
        this.entrada = entrada;
    }
    public Integer getSalida() {
        return this.salida;
    }
    
    public void setSalida(Integer salida) {
        this.salida = salida;
    }
    public Integer getStock() {
        return this.stock;
    }
    
    public void setStock(Integer stock) {
        this.stock = stock;
    }
    public Double getPrecio() {
        return this.precio;
    }
    
    public void setPrecio(Double precio) {
        this.precio = precio;
    }
    public Double getPrecioPonderado() {
        return this.precioPonderado;
    }
    
    public void setPrecioPonderado(Double precioPonderado) {
        this.precioPonderado = precioPonderado;
    }
    public Double getTotal() {
        return this.total;
    }
    
    public void setTotal(Double total) {
        this.total = total;
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
    public Set<KardexSerieNumero> getKardexSerieNumeros() {
        return this.kardexSerieNumeros;
    }
    
    public void setKardexSerieNumeros(Set<KardexSerieNumero> kardexSerieNumeros) {
        this.kardexSerieNumeros = kardexSerieNumeros;
    }




}


