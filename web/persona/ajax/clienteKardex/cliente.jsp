<%-- 
    Document   : cliente
    Created on : 14/01/2014, 06:50:39 PM
    Author     : Henrri
--%>

<%@page import="personaClases.cDatosCliente"%>
<%@page import="tablas.DatosCliente"%>
<%
    int codCliente = 0;
    DatosCliente objCliente = null;
    try {
        codCliente = Integer.parseInt(request.getParameter("codCliente"));
        objCliente = new cDatosCliente().leer_cod(codCliente);
        if (objCliente != null) {
            out.print(objCliente.getPersona().getNombresC());
        }
    } catch (Exception e) {

    }
%>