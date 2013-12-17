<%-- 
    Document   : familiaVerificar
    Created on : 08/11/2012, 01:41:37 PM
    Author     : Henrri
--%>
<%@page import="articuloProductoClases.cFamilia"%>
<%
    String familia = request.getParameter("familia").trim();
    cFamilia objcFamilia = new cFamilia();
    out.print(!objcFamilia.verficarFamilia(familia));
%>
