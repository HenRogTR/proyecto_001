<%-- 
    Document   : empresaConvenioRegistrarNombre
    Created on : 10/10/2013, 12:07:41 PM
    Author     : Henrri
--%>

<%@page import="personaClases.cEmpresaConvenio"%>
<%
    try {
        out.print(new cEmpresaConvenio().leer_nombre(request.getParameter("nombre").toString())==null ? true : false);
    } catch (Exception e) {
        out.print(true);
    }
%>