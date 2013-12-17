<%-- 
    Document   : personalEditarDniPasaporte
    Created on : 05/09/2013, 10:53:56 AM
    Author     : Henrri
--%>


<%@page import="personaClases.cPersona"%>
<%@page import="tablas.Persona"%>
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
    Persona objPersona = new cPersona().leer_dniPasaporte(dniPasaporte);
    boolean estado = objPersona == null ? true : (objPersona.getCodPersona().equals(codPersona) ? true : false);
    out.print(estado);
%>