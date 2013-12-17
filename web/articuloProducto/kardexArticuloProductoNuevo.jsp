<%-- 
    Document   : kardexArticuloProductoNuevo
    Created on : 17/12/2013, 11:16:29 AM
    Author     : Henrri
--%>

<%@page import="utilitarios.cManejoFechas"%>
<%
    cManejoFechas objcManejoFechas = new cManejoFechas();
%>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <title></title>
        <!--todos-->
        <script type="text/javascript" src="../librerias/jquery/jquery-1.9.0-min.js" ></script>
        <script type="text/javascript" src="../librerias/jquery/jquery.timer-min.js" ></script>
        <script type="text/javascript" src="../librerias/jquery-ui/jquery-ui-1.10.3.custom/js/jquery-ui-1.10.3.custom.min.js" ></script>
        <link rel="stylesheet" type="text/css" href="../librerias/principal/todos.css" media="all"/>
        <!--cambios-->
        <%@include file="../principal/inclusiones.jsp" %>
        <!--propio-->
        <script>
            function fPaginaActual() {
            }
            ;
        </script>
    </head>
    <body>
        <input type="hidden" name="paginaActualPermiso" id="permisoPaginaP7" value="" title="KARDEX ARTICULO PRODUCTO"/>
        <div id="wrap">
            <div id="header">
                <label class="horaCabecera"><%=objcManejoFechas.fechaCabecera()%></label>
            </div>
            <div id="right">
                <div id="rightSub1" class="ocultar">
                    <h3 class="titulo">MOVIMIENTO DE PRODUCTOS</h3>
                    <table class="reporte-tabla-1 anchoTotal">
                        <!--<thead>-->
                            <tr>
                                <th class="ancho60px medio">CÓDIGO</th>
                                <td class="ancho120px contenedorEntrada"><input type="search" name="codArticuloProducto" id="codArticuloProducto" value="" class="anchoTotal entrada derecha"/></td>
                                <th class="ancho60px" rowspan="2">DESCRIPCIÓN</th>
                                <td class="contenedorEntrada" rowspan="2"><textarea name="descripcion" id="descripcion" class="anchoTotal entrada mayuscula izquierda" style="height: 50px;"></textarea></td>
                            </tr>
                            <tr>
                                <th>ALMACÉN</th>
                                <td class="contenedorEntrada">
                                    <select name="codAlmacen" id="codAlmacen" class="anchoTotal entrada"></select>
                                </td>
                            </tr>
                        <!--</thead>-->
                    </table>
                </div>
                <%@include file="../principal/div2.jsp" %>
            </div>
            <div id="left">
                <div class="acceso">
                    <h3 class="titulo">INICIE SESIÓN</h3>                    
                    <button class="sexybutton" id="bAccesoAbrir"><span><span><img src="../librerias/botonesIconos/images/icons/silk/key_go.png">Ejecutar SICCI</span></span></button>
                </div>
                <div id="menu" class="ocultar">
                    <%@include file="../principal/menu.jsp" %>
                </div>
            </div>
            <div style="clear: both;"></div>
            <div id="footer">
                <%@include file="../principal/piePagina.jsp" %>
            </div>
        </div>
    </body>
</html>