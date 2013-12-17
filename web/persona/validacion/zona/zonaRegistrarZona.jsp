<%-- 
    Document   : zonaRegistrarZona
    Created on : 30/09/2013, 12:23:59 PM
    Author     : Henrri
--%>

<%@page import="personaClases.cZona"%>
<%@page import="tablas.Zona"%>
<%
    String zona = "";
    Boolean estado = true;
    try {
        zona = request.getParameter("zona").toString();
        Zona objZona = new cZona().leer_zona(zona);
        estado = objZona == null ? true : false;
        out.print(estado);
    } catch (Exception e) {
        out.print(estado);
    };
%>