<%-- 
    Document   : interesFactor
    Created on : 28/04/2014, 11:59:00 AM
    Author     : Henrri
--%>

<%@page import="otrasTablasClases.cDatosExtras"%>
<%@page import="utilitarios.cOtros"%>
<%
    out.print(new cOtros().decimalFormato(new cDatosExtras().leer_interesFactor().getDecimalDato(), 2));
%>