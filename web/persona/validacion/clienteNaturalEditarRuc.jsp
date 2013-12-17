<%-- 
    Document   : clienteNaturalRegistrarRuc
    Created on : 05/09/2013, 11:25:17 AM
    Author     : Henrri
--%>

<%@page import="personaClases.cDatosCliente"%>
<%@page import="tablas.DatosCliente"%>
<%
    String ruc = "";
    int codPersona = 0;
    try {
        ruc = request.getParameter("ruc").toString();
        codPersona = Integer.parseInt(request.getParameter("codPersona"));
    } catch (Exception e) {
        out.print(true);
        return;
    }
    DatosCliente objCliente = new cDatosCliente().leer_ruc(ruc);
    boolean estado = objCliente == null ? true : (objCliente.getPersona().getCodPersona().equals(codPersona) ? true : false);
    out.print(estado);
%>