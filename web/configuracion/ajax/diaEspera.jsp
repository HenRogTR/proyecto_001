<%-- 
    Document   : diaEspera
        Created on : 09/05/2014, 05:32:41 PM
    Author     : Henrri
--%>

<%@page import="otrasTablasClases.cDatosExtras"%>
<%    
    out.print(new cDatosExtras().leer_diaEspera().getEntero());
%>
