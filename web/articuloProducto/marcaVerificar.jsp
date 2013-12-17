<%-- 
    Document   : marcaVerificar
    Created on : 08/11/2012, 11:19:28 AM
    Author     : Henrri
--%>
<%@page import="articuloProductoClases.cMarca"%>
<%
    String descripcion = request.getParameter("descripcion").trim();
    cMarca objcMarca = new cMarca();
    out.print(!objcMarca.verficarMarca(descripcion));
%>