<%-- 
    Document   : articuloProductoVerificar
    Created on : 08/11/2012, 03:48:46 PM
    Author     : Henrri
--%>

<%@page import="utilitarios.cOtros"%>
<%@page import="articuloProductoClases.cArticuloProducto"%>
<%
    String descripcion = request.getParameter("descripcion").trim();
    cArticuloProducto objcArticuloProducto = new cArticuloProducto();
    out.print(!objcArticuloProducto.verficarArticuloProducto(new cOtros().replace_comillas_comillasD_barraInvertida(descripcion)));
%>