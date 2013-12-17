<%-- 
    Document   : personalEditarRuc
    Created on : 13/06/2013, 08:53:22 AM
    Author     : Henrri*****
--%>

<%@page import="personaClases.cPersona"%>
<%@page import="tablas.Persona"%>
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
    Persona objPersona = new cPersona().leer_ruc(ruc);
    boolean estado = objPersona == null ? true : (objPersona.getCodPersona().equals(codPersona) ? true : false);
    out.print(estado);
%>