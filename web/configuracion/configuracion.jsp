<%-- 
    Document   : configuracion
    Created on : 22/04/2014, 06:27:43 PM
    Author     : Henrri
--%>

<%@page import="java.util.Date"%>
<%@page import="utilitarios.cManejoFechas"%>
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
        <script type="text/javascript" src="../librerias/configuracion/configuracion.js"></script>        
        <script type="text/javascript" src="../librerias/plugin/jquery.growl/javascripts/jquery.growl.min.js"></script>
        <link rel="stylesheet" type="text/css" href="../librerias/plugin/jquery.growl/stylesheets/jquery.growl.min.css" media="all"/>
        <script type="text/javascript" src="../librerias/plugin/mask/jquery.mask.min.js"></script>        
        <script type="text/javascript" src="../librerias/utilitarios/validaciones.js"></script>
        <script type="text/javascript" src="../librerias/utilitarios/formatoDecimal.js"></script>
        <script type="text/javascript" src="../librerias/jquery-ui/jquery-ui-1.10.3.custom/js/i18n/jquery.ui.datepicker-es-min.js"></script>
    </head>
    <body>
        <input type="hidden" name="paginaActualPermiso" id="permisoPaginaP60" value="" title="Configuraciones"/>
        <div id="wrap">
            <div id="header">
                <label class="horaCabecera"><%=new cManejoFechas().fechaCabecera()%></label>
            </div>
            <div id="right">
                <div id="rightSub1" class="ocultar">
                    <input type="text" name="fechaActual" id="fechaActual" value="<%=new cManejoFechas().DateAString(new Date())%>" class="ocultar" />
                    <h3 class="titulo">CONFIGURACIONES </h3>
                    <div id="d_configuracion">
                        <h3>Factor de interes</h3>
                        <div>
                            <table class="reporte-tabla-1">
                                <tbody>
                                    <tr>
                                        <th class="ancho140px"><span>Factor Interés M. </span><span id="b_interesCambiar" class="boton iconoSoloPequenio edit">&nbsp;</span></th>
                                        <td class="ancho140px">
                                            <span id="interesFactor" class="vaciar">0.00</span>
                                            <span class="esperando">&nbsp;</span><span>%</span>
                                        </td>
                                    </tr>
                                    <tr>
                                        <th>
                                            <span>Dias de espera.</span>
                                        </th>
                                        <td>
                                            <input type="text" id="esperaDia" value="8" class="derecha entrada ancho100px"/>
                                        </td>
                                    </tr>
                                    <tr>
                                        <th>
                                            <span>Act. Manual (Todos)</span>
                                        </th>
                                        <td>                                            
                                            <input type="text" id="fecha_interesFijar" value="" class="fecha_datepicker entrada ancho80px"/>
                                            <span id="b_interes_actualizar" class="boton iconoSoloPequenio update">&nbsp;</span>
                                        </td>
                                    </tr>
                                </tbody>
                            </table>
                            <table id="t_empresaConvenio" class="reporte-tabla-1 anchoTotal" style="margin-top: 10px;">
                                <thead>
                                    <tr>
                                        <th>EMPRESA</th>
                                        <th class="ancho40px">INT.</th>
                                        <th class="ancho80px">INT. AUTO.</th>
                                    </tr>
                                </thead>
                                <tfoot>
                                    <tr>
                                        <td><span class="esperando">&nbsp;</span></td>
                                        <td><span class="esperando">&nbsp;</span></td>
                                        <td><span class="esperando">&nbsp;</span></td>
                                    </tr>
                                </tfoot>
                                <tbody id="tb_empresaConvenio">

                                </tbody>
                            </table>
                        </div>
                    </div>
                    <div id="d_interesCambiar" title="Cambiar tasa de interés.">
                        <table class="reporte-tabla-1 anchoTotal">
                            <tr>
                                <th class="ancho140px">
                                    <span>INTERÉS ANTERIOR</span>
                                </th>
                                <td class="contenedorEntrada derecha">
                                    <span id="interesAnterior" class="vaciar">0.00</span>
                                </td>
                            </tr>
                            <tr>
                                <th>
                                    <span>NUEVO INTERÉS</span>
                                </th>
                                <td class="contenedorEntrada">
                                    <input type="text" id="interesNuevo" name="interesNuevo" class="anchoTotal entrada derecha limpiar"/>
                                </td>
                            </tr>
                        </table>
                    </div>
                    <div id="d_interesGeneralActualizar" title="Actualización de intereses.">
                        <div class="ui-state-highlight ui-corner-all" style="margin-top: 20px; padding: 0 .7em;">
                            <p><span class="ui-icon ui-icon-info" style="float: left; margin-right: .3em;"></span>
                                <strong>¡Alerta!</strong><br> Actualizar la información solicitada tomara su tiempo, 
                                pedimos no cerrar o recargar la página. Sólo se actualizará de aquellos clientes que
                                pertenecen a una empresa que tengan el check marcado.</p>
                        </div>
                    </div>
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