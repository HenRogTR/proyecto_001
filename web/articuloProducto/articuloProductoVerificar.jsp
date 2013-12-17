<%-- 
    Document   : articuloProductoVerificar
    Created on : 08/11/2012, 03:48:46 PM
    Author     : Henrri
--%>
<%@page import="otros.cUtilitarios"%>
<%@page import="articuloProductoClases.cArticuloProducto"%>
<%
    cUtilitarios objcUtilitarios = new cUtilitarios();
    String descripcion = request.getParameter("descripcion").trim();
    cArticuloProducto objcArticuloProducto = new cArticuloProducto();
    out.print(!objcArticuloProducto.verficarArticuloProducto(objcUtilitarios.replace_comillas_comillasD_barraInvertida(descripcion)));
%>