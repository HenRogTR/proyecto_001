<%-- 
    Document   : cabecera
    Created on : 21/07/2014, 11:43:21 AM
    Author     : Henrri
--%>

<%@page import="Clase.Fecha"%>
<%@page import="java.util.Date"%>
<label class="horaCabecera"><%=new Fecha().fechaCabecera(new Date())%></label>
<label class="usuarioInfo" id="lUsuario">USUARIO: SESIÓN NO INICIADA</label>