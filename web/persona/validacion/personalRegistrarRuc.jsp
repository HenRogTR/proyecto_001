<%-- 
    Document   : personalRegistrarRuc
    Created on : 05/09/2013, 11:25:17 AM
    Author     : Henrri
--%>

<%@page import="personaClases.cPersonal"%>
<%@page import="tablas.Personal"%>
<%
    String ruc = request.getParameter("ruc");
    if (ruc == null) {
        out.print(true);
        return;
    }
    Personal objPersonal = new cPersonal().leer_ruc(ruc);
    boolean estado = objPersonal == null ? true : false;
    out.print(estado);
%>