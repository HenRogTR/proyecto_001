<%-- 
    Document   : clienteJuridicoEditarRuc
    Created on : 18/06/2013, 09:49:03 AM
    Author     : Henrri
--%>

<%@page import="personaClases.cDatosCliente"%>
<%@page import="tablas.DatosCliente"%>
<%
    String ruc = request.getParameter("ruc");
    if (ruc == null) {
        out.print(true);
        return;
    }
    DatosCliente objCliente=new cDatosCliente().leer_ruc(ruc);
    boolean estado = objCliente == null ? true : false;
    out.print(estado);
%>