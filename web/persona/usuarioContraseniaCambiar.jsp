<%-- 
    Document   : usuarioContraseniaCambiar
    Created on : 31/03/2014, 12:09:36 PM
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
        <script type="text/javascript" src="../librerias/jquery.validate/1.11.1/jquery.validate.min.js"></script>
        <script type="text/javascript" src="../librerias/jquery.validate/1.11.1/localization/messages_es.js"></script>
        <script type="text/javascript" src="../librerias/jquery.validate/1.11.1/additional-methods.min.js"></script>
        <script type="text/javascript" src="../librerias/plugin/md5/md5-min.js"></script>
        <script type="text/javascript" src="../librerias/persona/usuario/contraseniaCambiar.js"></script>
    </head>
    <body>
        <input type="hidden" name="paginaActualPermiso" id="permisoPaginaP1" value="" title=""/>
        <div id="wrap">
            <div id="header">
                <label class="horaCabecera"><%=objcManejoFechas.fechaCabecera()%></label>
            </div>
            <div id="right">
                <div id="rightSub1" class="ocultar">
                    <h3 class="titulo">CAMBIAR CONTRASEÑA </h3>
                    <form id="form_usuarioContraseniaCambiar" action="../sUsuario">
                        <fieldset class="ancho400px anchoTotal">
                            <legend>Contraseña de usuario.</legend>
                            <table class="reporte-tabla-1 anchoTotal">
                                <tr>
                                    <th>Contraseña anterior</th>
                                    <td class="contenedorEntrada">
                                        <input type="password" class="limpiar entrada anchoTotal" name="contraseniaAnterior" id="contraseniaAnterior" value="" />
                                    </td>
                                </tr>
                                <tr>
                                    <th>Contraseña nueva</th>
                                    <td class="contenedorEntrada">
                                        <input type="password" class="limpiar entrada anchoTotal" name="contraseniaNueva" id="contraseniaNueva" value="" />
                                    </td>
                                </tr>
                                <tr>
                                    <th>Repetir contraseña</th>
                                    <td class="contenedorEntrada">
                                        <input type="password" class="limpiar entrada anchoTotal" name="contraseniaNuevaRepetir" id="contraseniaNuevaRepetir" value="" />
                                    </td>
                                </tr>
                            </table>
                            <div class="lineaDivisoria">
                                <button id="bDeshacer" type="button" class="sexybutton botonClic"><span><span><span class="undo">Restaurar</span></span></span></button>
                                <button id="bGuardar" type="submit" class="sexybutton botonClic"><span><span><span class="save">Guardar</span></span></span></button>
                            </div>
                        </fieldset>
                    </form>
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