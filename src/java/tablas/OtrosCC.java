package tablas;
// Generated 14/05/2014 01:19:00 PM by Hibernate Tools 3.6.0



/**
 * OtrosCC generated by hbm2java
 */
public class OtrosCC  implements java.io.Serializable {


     private Integer codOtrosCC;
     private EmpresaConvenio empresaConvenio;
     private String tipo;
     private String registro;

    public OtrosCC() {
    }

    public OtrosCC(EmpresaConvenio empresaConvenio, String tipo, String registro) {
       this.empresaConvenio = empresaConvenio;
       this.tipo = tipo;
       this.registro = registro;
    }
   
    public Integer getCodOtrosCC() {
        return this.codOtrosCC;
    }
    
    public void setCodOtrosCC(Integer codOtrosCC) {
        this.codOtrosCC = codOtrosCC;
    }
    public EmpresaConvenio getEmpresaConvenio() {
        return this.empresaConvenio;
    }
    
    public void setEmpresaConvenio(EmpresaConvenio empresaConvenio) {
        this.empresaConvenio = empresaConvenio;
    }
    public String getTipo() {
        return this.tipo;
    }
    
    public void setTipo(String tipo) {
        this.tipo = tipo;
    }
    public String getRegistro() {
        return this.registro;
    }
    
    public void setRegistro(String registro) {
        this.registro = registro;
    }




}


