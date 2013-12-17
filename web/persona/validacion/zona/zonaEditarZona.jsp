<%-- 
    Document   : zonaRegistrarZona
    Created on : 30/09/2013, 12:23:59 PM
    Author     : Henrri
--%>

<%@page import="personaClases.cZona"%>
<%@page import="tablas.Zona"%>
<%
    String zona = "";
    int codZona = 0;
    Boolean estado = true;
    try {
        zona = request.getParameter("zona").toString();
        codZona = Integer.parseInt(request.getParameter("codZona"));
        Zona objZona = new cZona().leer_zona(zona);
        estado = objZona == null ? true : (objZona.getCodZona().equals(codZona) ? true : false);
        out.print(estado);
    } catch (Exception e) {
        out.print(estado);
    };
%>