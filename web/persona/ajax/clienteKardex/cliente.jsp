<%-- 
    Document   : cliente
    Created on : 14/01/2014, 06:50:39 PM
    Author     : Henrri
--%>

<%@page import="utilitarios.cManejoFechas"%>
<%@page import="personaClases.cDatosCliente"%>
<%@page import="tablas.DatosCliente"%>
<%
    int codCliente = 0;
    DatosCliente objCliente = null;
    try {
        codCliente = Integer.parseInt(request.getParameter("codCliente"));
        objCliente = new cDatosCliente().leer_cod(codCliente);
        if (objCliente != null) {
            boolean cobrarInteres = objCliente.getInteresEvitar() == null ? true : objCliente.getInteresEvitar().compareTo(new cManejoFechas().fecha_actual()) != 0;
            out.print(objCliente.getPersona().getNombresC() + ":" + (cobrarInteres ? "HABILITADO" : "DESHABILITADO"));
        }
    } catch (Exception e) {

    }
%>