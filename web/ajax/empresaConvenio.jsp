<%-- 
    Document   : empresaConvenio
    Created on : 26/06/2014, 11:49:31 AM
    Author     : Henrri
--%>

<%@page import="java.util.Date"%>
<%@page import="tablas.Usuario"%>
<%@page import="Clase.Utilitarios"%>
<%@page import="java.util.List"%>
<%@page import="tablas.EmpresaConvenio"%>
<%@page import="Ejb.EjbEmpresaConvenio"%>
<%
    //evitar el acceso directo por el URL
    if (request.getMethod().equals("GET")) {
        out.print("No tiene permisos para ver este enlace.");
        return;
    }
    // ============================ sesi�n =====================================
    //verficar inicio de sesi�n        
    Usuario objUsuario = (Usuario) session.getAttribute("usuario");
    if (objUsuario == null) {
        out.print("La sesi�n se ha cerrado.");
        return;
    }
    //actualizamos ultimo ingreso
    session.setAttribute("fechaAcceso", new Date());
    // ============================ sesi�n =====================================
    EjbEmpresaConvenio ejbEmpresaConvenio;
    //inicializar ejb
    ejbEmpresaConvenio = new EjbEmpresaConvenio();
    List<EmpresaConvenio> empresaConvenioList = ejbEmpresaConvenio.leerActivos(true);
    //obtener tama�o
    int tam = empresaConvenioList.size();
    out.print("[");
    //recorrer datos
    for (int i = 0; i < tam; i++) {
        EmpresaConvenio objEmpresaConvenio = empresaConvenioList.get(i);
        //imprimir <,> separadora
        if (i > 0) {
            out.print(",");
        }
        out.print("{"
                + "\"codEmpresaConvenio\":\"" + new Utilitarios().agregarCerosIzquierda(objEmpresaConvenio.getCodEmpresaConvenio(), 8) + "\""
                + ", \"nombre\":\"" + new Utilitarios().reemplazarCaracteresEspeciales(objEmpresaConvenio.getNombre()) + "\""
                + ", \"abreviatura\":\"" + objEmpresaConvenio.getAbreviatura() + "\""
                + ", \"codCobranza\":\"" + objEmpresaConvenio.getCodCobranza() + "\""
                + ", \"interesAsigando\":" + objEmpresaConvenio.isInteresAsigando()
                + ", \"interesAutom�tico\":" + objEmpresaConvenio.isInteresAutomatico()
                + ", \"registro\":\"" + objEmpresaConvenio.getRegistro() + "\""
                + "}");
    }
    out.print("]");
%>