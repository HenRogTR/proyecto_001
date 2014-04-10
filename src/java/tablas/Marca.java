package tablas;
// Generated 10/04/2014 10:20:20 AM by Hibernate Tools 3.6.0


import java.util.HashSet;
import java.util.Set;

/**
 * Marca generated by hbm2java
 */
public class Marca  implements java.io.Serializable {


     private Integer codMarca;
     private String descripcion;
     private String registro;
     private Set<ArticuloProducto> articuloProductos = new HashSet<ArticuloProducto>(0);

    public Marca() {
    }

	
    public Marca(String registro) {
        this.registro = registro;
    }
    public Marca(String descripcion, String registro, Set<ArticuloProducto> articuloProductos) {
       this.descripcion = descripcion;
       this.registro = registro;
       this.articuloProductos = articuloProductos;
    }
   
    public Integer getCodMarca() {
        return this.codMarca;
    }
    
    public void setCodMarca(Integer codMarca) {
        this.codMarca = codMarca;
    }
    public String getDescripcion() {
        return this.descripcion;
    }
    
    public void setDescripcion(String descripcion) {
        this.descripcion = descripcion;
    }
    public String getRegistro() {
        return this.registro;
    }
    
    public void setRegistro(String registro) {
        this.registro = registro;
    }
    public Set<ArticuloProducto> getArticuloProductos() {
        return this.articuloProductos;
    }
    
    public void setArticuloProductos(Set<ArticuloProducto> articuloProductos) {
        this.articuloProductos = articuloProductos;
    }




}


