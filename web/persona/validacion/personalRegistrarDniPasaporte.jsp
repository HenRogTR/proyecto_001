<%-- 
    Document   : personalRegistrarDniPasaporte
    Created on : 05/09/2013, 10:53:56 AM
    Author     : Henrri
--%>

<%@page import="personaClases.cPersonal"%>
<%@page import="tablas.Personal"%>
<%
    String dniPasaporte = request.getParameter("dniPasaporte");
    if (dniPasaporte == null) {
        out.print(true);
        return;
    }
    Personal objPersonal = new cPersonal().leer_dniPasaporte(dniPasaporte);
    boolean estado = objPersonal == null ? true : false;
    out.print(estado);
%>