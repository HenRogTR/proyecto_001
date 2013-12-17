<%-- 
    Document   : clienteNaturalRegistrarDniPasaporte
    Created on : 05/09/2013, 10:53:56 AM
    Author     : Henrri
--%>

<%@page import="personaClases.cDatosCliente"%>
<%@page import="tablas.DatosCliente"%>
<%
    String dniPasaporte = "";
    int codPersona = 0;
    try {
        dniPasaporte = request.getParameter("dniPasaporte").toString();
        codPersona = Integer.parseInt(request.getParameter("codPersona"));
    } catch (Exception e) {
        out.print(true);
        return;
    }
    DatosCliente objCliente = new cDatosCliente().leer_dniPasaporte(dniPasaporte);
    boolean estado = objCliente == null ? true : (objCliente.getPersona().getCodPersona().equals(codPersona) ? true : false);
    out.print(estado);
%>