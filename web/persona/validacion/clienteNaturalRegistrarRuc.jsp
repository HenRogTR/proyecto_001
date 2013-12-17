<%-- 
    Document   : clienteNaturalRegistrarRuc
    Created on : 05/09/2013, 11:25:17 AM
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