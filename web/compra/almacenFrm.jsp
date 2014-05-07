<%-- 
    Document   : almacenFrm
    Created on : 01/03/2013, 11:09:50 AM
    Author     : Henrri
--%>

<%@page import="utilitarios.cOtros"%>
<%@page import="java.lang.String"%>
<%@page import="tablas.Usuario"%>
<%
    Usuario objUsuario = (Usuario) session.getAttribute("usuario");
    if (objUsuario == null) {
        session.removeAttribute("direccion");
        session.setAttribute("direccion", "");
        response.sendRedirect("../");
    } else {
        String accion = (String) session.getAttribute("accionAlmacen");
        if (accion == null) {
            response.sendRedirect("almacenListar.jsp");
        } else {
            String accion2 = new cOtros().accion2(accion);
%>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <title><%=accion2 %> almacén</title>
        <!--stilo inicio-->
        <link rel="stylesheet" type="text/css" href="../lib/propios/css/inicio/style.css" />
        <!--js query-->
        <script type="text/javascript" src="../lib/jquery/jquery-1.8.1.min.js"></script>
        <!--css js ui-->
        <link rel="stylesheet" type="text/css" href="../lib/jquery-ui/jquery-ui-1.10.0.custom/css/smoothness/jquery-ui-1.10.0.custom.min.css">
        <script type="text/javascript" src="../lib/jquery-ui/jquery-ui-1.9.0/jquery-ui-git.js"></script>
        <!--css frm-->
        <link rel="stylesheet" type="text/css" href="../lib/propios/css/formulario/detalles.css" />        
        <!--css iconos-->
        <link rel="stylesheet" type="text/css" href="../librerias/botonesIconos/sexybuttons.css" media="screen">
    </head>
    <body>        
        <div id="wrap">
            <div id="header">
                <%@include file="../cabecera.jsp" %>
            </div>
            <div id="left"> 
                <%@include file="../menu2.jsp" %>
            </div>
            <div id="right">                
                <h3 class="titulo"><%=accion2.toUpperCase() %> ALMACÉN</h3>
                <br>
                <br>
                <br>
                <br>
                <br>
                <br>
                <br>
                <br>
                <br>
                <br>
                <br>
                <br>
                <br>
                <br>
                <br>
                <br>
                <br>
                <br>
                <br>
                <br>
            </div>
            <div style="clear: both;"> </div>
            <div id="footer">
                <%@include file="../piePagina.jsp" %>
            </div>
        </div>
    </body>
</html>
<%        }
    }
%>