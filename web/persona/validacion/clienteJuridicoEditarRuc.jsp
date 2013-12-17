<%-- 
    Document   : clienteJuridicoEditarRuc
    Created on : 18/06/2013, 09:49:03 AM
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
