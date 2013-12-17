<%-- 
    Document   : clienteNaturalRuc
    Created on : 13/06/2013, 08:53:22 AM
    Author     : Henrri
--%>

<%@page import="personaClases.cPersona"%>
<%@page import="tablas.Persona"%>
<%
    String term = request.getParameter("ruc");
    if (term == null) {
        return;
    }
    cPersona objcPersona=new cPersona();
    Persona objPersona = objcPersona.leer_ruc(term);
    if (objPersona != null) {
        out.print(false);
    } else {
        out.print(true);
    }
%>
