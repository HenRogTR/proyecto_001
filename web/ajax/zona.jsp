<%-- 
    Document   : zona
    Created on : 06/10/2014, 10:49:14 AM
    Author     : Henrri
--%>

<%@page import="Clase.Utilitarios"%>
<%@page import="tablas.Zona"%>
<%@page import="java.util.List"%>
<%@page import="Ejb.EjbZona"%>
<%@page import="java.util.Date"%>
<%@page import="tablas.Usuario"%>
<%@page import="Ejb.EjbUsuario"%>
<%
    //Se hace la llamada al archivo desde cobranza.jsp -> cobranza.js

    //****corregir****
    //evitar el acceso directo por el URL
    if (request.getMethod().equals("GET")) {
        out.print("No tiene permisos para ver este enlace.");
        return;
    }
    //verficar inicio de sesión
    EjbUsuario ejbUsuario = new EjbUsuario();
    ejbUsuario.setUsuario((Usuario) session.getAttribute("usuario"));
    if (ejbUsuario.getUsuario() == null) {  //Verificar que haya sesión iniciada.
        out.print("La sesión se ha cerrado.");
        return;
    }
    //actualizamos ultimo ingreso
    session.setAttribute("fechaAcceso", new Date());
    //Inicializar
    EjbZona ejbZona;
    //inicializar ejb
    ejbZona = new EjbZona();
    List<Zona> zonaList = ejbZona.leerActivos(true);
    //obtener tamaño
    int tam = zonaList.size();
    out.print("[");
    //recorrer datos
    for (int i = 0; i < tam; i++) {
        Zona objZona = zonaList.get(i);
        //imprimir <,> separadora
        out.print(i > 0 ? ", " : "");
        out.print("{"
                + "\"codZona\":" + objZona.getCodZona()
                + ", \"codZonaFormato\":\"" + Utilitarios.agregarCerosIzquierda(objZona.getCodZona(), 8) + "\""
                + ", \"zona\":\"" + Utilitarios.reemplazarCaracteresEspeciales(objZona.getZona()) + "\""
                + ", \"descripcion\":\"" + Utilitarios.reemplazarCaracteresEspeciales(objZona.getDescripcion()) + "\""
                + ", \"registro\":\"" + objZona.getRegistro() + "\""
                + "}");
    }
    out.print("]");
%>