<%-- 
    Document   : clienteNaturalRegistrarDniPasaporte
    Created on : 05/09/2013, 10:53:56 AM
    Author     : Henrri
--%>

<%@page import="personaClases.cDatosCliente"%>
<%@page import="tablas.DatosCliente"%>
<%
    String dniPasaporte = request.getParameter("dniPasaporte");
    if (dniPasaporte == null) {
        out.print(true);
        return;
    }
    DatosCliente objCliente=new cDatosCliente().leer_dniPasaporte(dniPasaporte);
    boolean estado = objCliente == null ? true : false;
    out.print(estado);
%>