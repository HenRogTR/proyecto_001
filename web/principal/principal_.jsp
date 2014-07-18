<%-- 
    Document   : principal_
    Created on : 15/07/2014, 05:32:20 PM
    Author     : Henrri
--%>

<%@page import="java.util.Date"%>
<%@page import="Clase.Fecha"%>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <title>JSP Page</title>
        <!--importando script-->
        <%@include file="scriptImportar.jsp" %>
        <link rel="stylesheet" type="text/css" href="../librerias/css/cssImportar.css" media="all"/>

    </head>
    <body>        
        <%@include file="menu_.jsp" %>
        <div id="wrap">
            <div id="header">
                <label class="horaCabecera"><%=new Fecha().fechaCabecera(new Date())%></label>
                <label class="usuarioInfo" id="lUsuario">USUARIO: INVITADO</label>
            </div>
            <div id="dMenu">
                <div class="titulo">                    
                    PÁGINA PRINCIPAL
                </div>
            </div>
            <div id="finMenu" class="lineaDivisoria"></div>
            <div id="contenido">
                sadws
            </div>
            <div id="finContenido" class="lineaDivisoria"></div>
        </div>
    </body>
</html>
