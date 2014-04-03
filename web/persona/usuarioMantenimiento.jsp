<%-- 
    Document   : usuarioMantenimiento
    Created on : 14/09/2013, 04:46:50 PM
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
        <title>IY Usuario mantenimiento</title>
        <!--todos-->
        <script type="text/javascript" src="../librerias/jquery/jquery-1.9.0-min.js" ></script>
        <script type="text/javascript" src="../librerias/jquery/jquery.timer-min.js" ></script>
        <script type="text/javascript" src="../librerias/jquery-ui/jquery-ui-1.10.3.custom/js/jquery-ui-1.10.3.custom.min.js" ></script>
        <link rel="stylesheet" type="text/css" href="../librerias/principal/todos.css" media="all"/>
        <!--cambios-->
        <%@include file="../principal/inclusiones.jsp" %>
        <!--propio-->
        <script type="text/javascript" src="../librerias/persona/usuario/usuarioMantenimiento.js?v14.04.03"></script>
    </head>
    <body>
        <input type="hidden" name="paginaActualPermiso" id="permisoPaginaP20" value="" title="MANTENIMIENTO DE USUARIOS"/>
        <div id="wrap">
            <div id="header">
                <label class="horaCabecera"><%=objcManejoFechas.fechaCabecera()%></label>
            </div>
            <div id="right">
                <div id="rightSub1" class="ocultar">                    
                    <h3 class="titulo">MANTENIMIENTO USUARIO</h3>
                    <%
                        int codUsuario = 0;
                        try {
                            codUsuario = (Integer) session.getAttribute("codUsuarioMantenimiento");
                        } catch (Exception e) {
                            codUsuario = 0;
                        }
                    %>
                    <input type="hidden" name="codUsuario" id="codUsuario" value="<%=codUsuario%>" />
                    <input type="hidden" name="temporal" id="temporal" value="" />
                    <div id="accordion">
                        <h3>DATOS USUARIO</h3>
                        <div>
                            <table class="reporte-tabla-1">
                                <tr>
                                    <th colspan="3" style="text-align: center;">
                                        <button class="sexybutton" id="bPrimero"><span><span><span class="first">Primero</span></span></span></button>
                                        <button class="sexybutton" id="bAnterior"><span><span><span class="prev">Anterior</span></span></span></button>
                                        <button class="sexybutton" id="bSiguiente"><span><span><span class="next">Siguiente</span></span></span></button>
                                        <button class="sexybutton" id="bUltimo"><span><span><span class="last">Último</span></span></span></button>
                                    </th>
                                    <th style="text-align: center;">                                                
                                        <a class="sexybutton sexyicononly sexysimple sexysmall sexypropio" id="bNuevoTabla" href="usuarioRegistrar.jsp"><span class="add"></span></a>
                                        <a class="sexybutton sexyicononly sexysimple sexysmall sexypropio" id="bEditar" href="usuarioPrivilegios.jsp"><span class="edit"></span></a>
                                        <button class="sexybutton sexyicononly sexysimple sexysmall sexypropio" id="bEliminar"><span class="delete"></span></button>
                                    </th>
                                </tr>
                                <tr>
                                    <th style="width: 120px;">CÓDIGO</th>
                                    <td id="lCodUsuario" class="vaciar" style="width: 240px;"></td>
                                    <th>ESTADO</th>
                                    <td id="lEstado" class="vaciar" style="width: 240px;"></td>
                                </tr>
                                <tr>
                                    <th>USUARIO</th>
                                    <td id="lUsuario" class="vaciar"></td>
                                    <th>CONTRASEÑA</th>
                                    <td><a id="bContraseniaResetear" href="#">resetear</a></td>
                                </tr>
                                <tr>
                                    <th>PERSONAL</th>
                                    <td id="lPersonal" class="vaciar" colspan="3"></td>
                                </tr>
                            </table>                            
                        </div>
                    </div>
                </div>
                <!--fin dialogos-->
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