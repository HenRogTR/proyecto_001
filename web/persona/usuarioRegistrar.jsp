<%-- 
    Document   : usuarioRegistrar
    Created on : 26/09/2013, 10:28:20 AM
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
        <title>I.Y. Usuario registrar</title>
        <!--todos-->
        <script type="text/javascript" src="../librerias/jquery/jquery-1.9.0-min.js" ></script>
        <script type="text/javascript" src="../librerias/jquery/jquery.timer-min.js" ></script>
        <script type="text/javascript" src="../librerias/jquery-ui/jquery-ui-1.10.3.custom/js/jquery-ui-1.10.3.custom.min.js" ></script>
        <link rel="stylesheet" type="text/css" href="../librerias/principal/todos.css" media="all"/>
        <!--cambios-->
        <%@include file="../principal/inclusiones.jsp" %>
        <!--propio-->
        <script type="text/javascript" src="../librerias/persona/usuario/usuarioRegistrar.js"></script>
        <script type="text/javascript" src="../librerias/jquery.validate/1.11.1/jquery.validate.min.js"></script>
        <script type="text/javascript" src="../librerias/jquery.validate/1.11.1/localization/messages_es.js"></script>
        <script type="text/javascript" src="../librerias/jquery.validate/1.11.1/additional-methods.min.js"></script>
    </head>
    <body>
        <input type="hidden" name="paginaActualPermiso" id="permisoPaginaP44" value="" title="REGISTRAR USUARIO"/>
        <div id="wrap">
            <div id="header">
                <label class="horaCabecera"><%=objcManejoFechas.fechaCabecera()%></label>
            </div>
            <div id="right">
                <div id="rightSub1" class="ocultar">
                    <h3 class="titulo">REGISTRAR USUARIO</h3>
                    <form id="formUsuarioRegistrar" action="../sUsuario" autocomplete="off">
                        <input type="hidden" name="accionUsuario" id="accionUsuario" value="registrar" />
                        <div id="accordionUsuario">
                            <h3>USUARIO NUEVO</h3>
                            <div>
                                <table class="reporte-tabla-1">
                                    <tfoot>
                                        <tr id="trBotones">
                                            <th colspan="4">
                                                <button class="sexybutton" type="button" id="cancelar"><span><span><span class="cancel">Cancelar</span></span></span></button>
                                                <button class="sexybutton" type="reset" id="restaurar"><span><span><span class="redo">Restaurar</span></span></span></button>
                                                <button class="sexybutton" type="submit" id="accion"><span><span><span class="save">Guardar</span></span></span></button>
                                            </th>
                                        </tr>
                                    </tfoot>
                                    <tbody>
                                        <tr>
                                            <th style="width: 120px;">CÓDIGO</th>
                                            <td id="lCodUsuario" class="vaciar" style="width: 240px;">AUTOGENERADO</td>
                                            <th>ESTADO</th>
                                            <td id="lEstado" class="vaciar" style="width: 240px;">
                                                <select name="estado" id="estado" class="limpiar">
                                                    <option value="">SELECCIONE</option>
                                                    <option value="true">HABILITADO</option>
                                                    <option value="false">DESABILITADO</option>
                                                </select>
                                            </td>
                                        </tr>
                                        <tr>
                                            <th>PERSONAL <button class="sexybutton sexyicononly sexysimple sexysmall sexypropio" id="bPersonalSeleccionar" type="button"><span class="search"></span></button></th>
                                            <td id="lPersonal" class="vaciar" colspan="3">
                                                <input type="hidden" name="codPersona" id="codPersona" value="" class="limpiar"/>
                                                <label id="lPersonalNombresC"></label>
                                            </td>
                                        </tr>
                                        <tr>
                                            <th>USUARIO</th>
                                            <td id="lUsuario" class="vaciar" colspan="3"><input type="text" name="usuarioNuevo" id="usuarioNuevo" value="" style="width: 98%;" class="limpiar mayuscula"/></td>
                                        </tr>
                                        <tr>
                                            <th>CONTRASEÑA</th>
                                            <td colspan="3"><input type="password" name="contraseniaNueva" id="contraseniaNueva" value="" style="width: 98%;" class="limpiar"/></td>
                                        </tr>
                                        <tr>
                                            <th>REP. CONTRASEÑA</th>
                                            <td colspan="3"><input type="password" name="repetirContraseniaNueva" id="repetirContraseniaNueva" value="" style="width: 98%;" class="limpiar"/></td>
                                        </tr>
                                        <tr>
                                            <th colspan="4" style="text-align: center;">PERMISOS</th>
                                        </tr>
                                        <tr>
                                            <td colspan="4" style="padding: 10px;">
                                                <!--div 1 cliente-->
                                                <div class="ui-widget-content" style="width: 30%; float: left; margin: 10px;" >
                                                    <table class="reporte-tabla-1" style="width: 100%;">
                                                        <tr>
                                                            <th colspan="2" style="text-align: center;" class="medio">CLIENTE</th>
                                                        </tr>
                                                        <tr>
                                                            <th><input type="checkbox" name="p29" id="p29" value="true"/></th>
                                                            <td><label for="p29">REGISTRAR, EDITAR</label></td>                            
                                                        </tr>
                                                        <tr>
                                                            <th style="width: 30px;"><input type="checkbox" name="p1" id="p1" value="true"/></th>
                                                            <td><label for="p1">CONSULTAR</label></td>
                                                        </tr>
                                                        <tr>
                                                            <th><input type="checkbox" name="p2" id="p2" value="true"/></th>
                                                            <td><label for="p2">KARDEX</label></td>                            
                                                        </tr>
                                                    </table>
                                                </div>
                                                <!--div 2 venta-->
                                                <div class="ui-widget-content" style="width: 30%; float: left; margin: 10px;">
                                                    <table class="reporte-tabla-1" style="width: 100%;">
                                                        <tr>
                                                            <th colspan="2" style="text-align: center;" class="medio">VENTA</th>
                                                        </tr>
                                                        <tr>
                                                            <th><input type="checkbox" name="p31" id="p31" value="true" /></th>
                                                            <td><label for="p31">REGISTRAR, EDITAR</label></td>                            
                                                        </tr>
                                                        <tr>
                                                            <th style="width: 30px;"><input type="checkbox" name="p18" id="p18" value="true" /></th>
                                                            <td><label for="p18">CONSULTAR</label></td>
                                                        </tr>
                                                        <tr>
                                                            <th><input type="checkbox" name="p23" id="p23" value="true" /></th>
                                                            <td><label for="p23">ANULAR</label></td>                            
                                                        </tr>
                                                        <tr>
                                                            <th><input type="checkbox" name="p34" id="p34" value="true" /></th>
                                                            <td><label for="p34">IMPRIMIR</label></td>
                                                        </tr>
                                                        <tr>
                                                            <th><input type="checkbox" name="p33" id="p33" value="true" /></th>
                                                            <td><label for="p33">MODIFICAR LETRA CRÉDITO</label></td>
                                                        </tr>
                                                    </table>
                                                </div>
                                                <!--div 3 cobranza-->
                                                <div class="ui-widget-content" style="width: 30%; float: right; margin: 10px;">
                                                    <table class="reporte-tabla-1" style="width: 100%;">
                                                        <tr>
                                                            <th colspan="2" style="text-align: center;">COBRANZA</th>
                                                        </tr>
                                                        <tr>
                                                            <th style="width: 30px;"><input type="checkbox" name="p22" id="p22" value="true" /></th>
                                                            <td><label for="p22">ACCEDER</label></td>
                                                        </tr>
                                                        <tr>
                                                            <th><input type="checkbox" name="p35" id="p35" value="true" /></th>
                                                            <td><label for="p35">REGISTRAR RECIBO</label></td>                            
                                                        </tr>
                                                        <tr>
                                                            <th><input type="checkbox" name="p24" id="p24" value="true" /></th>
                                                            <td><label for="p24">ANULAR RECIBO</label></td>                            
                                                        </tr>
                                                        <tr>
                                                            <th><input type="checkbox" name="p36" id="p36" value="true" /></th>
                                                            <td><label for="p36">IMPRIMIR RECIBO</label></td>                            
                                                        </tr>
                                                        <tr>
                                                            <th><input type="checkbox" name="p49" id="p49" value="true" /></th>
                                                            <td><label for="p49">IMPRIMIR COPIA RECIBO</label></td>                            
                                                        </tr>
                                                        <tr>
                                                            <th><input type="checkbox" name="p37" id="p37" value="true" /></th>
                                                            <td><label for="p37">UTILIZAR SALDO A FAVOR</label></td>                            
                                                        </tr>
                                                    </table>
                                                </div>
                                                <div style="clear: both;"></div>
                                                <!--div 4 empresaconvenio-->
                                                <div class="ui-widget-content" style="width: 30%; float: left; margin: 10px;">
                                                    <table class="reporte-tabla-1" style="width: 100%;">
                                                        <tr>
                                                            <th colspan="2" style="text-align: center;">EMPRESA/CONVENIO</th>
                                                        </tr>
                                                        <tr>
                                                            <th style="width: 30px;"><input type="checkbox" name="p41" id="p41" value="true" /></th>
                                                            <td><label for="p41">REGISTRAR, EDITAR, BORRAR</label></td>
                                                        </tr>
                                                        <tr>
                                                            <th><input type="checkbox" name="p12" id="p12" value="true" /></th>
                                                            <td><label for="p12">CONSULTAR</label></td>                            
                                                        </tr>
                                                    </table>
                                                </div>
                                                <!--div 5 almacén-->
                                                <div class="ui-widget-content" style="width: 30%; float: left; margin: 10px;">
                                                    <table class="reporte-tabla-1" style="width: 100%;">
                                                        <tr>
                                                            <th colspan="2" style="text-align: center;">ALMACÉN</th>
                                                        </tr>
                                                        <tr>
                                                            <th style="width: 30px;"><input type="checkbox" name="p38" id="p38" value="true" /></th>
                                                            <td><label for="p38">REGISTRAR, EDITAR, BORRAR</label></td>
                                                        </tr>
                                                        <tr>
                                                            <th><input type="checkbox" name="p8" id="p8" value="true" /></th>
                                                            <td><label for="p8">CONSULTAR</label></td>                            
                                                        </tr>
                                                    </table>
                                                </div>
                                                <!--div 6 artículo-->
                                                <div class="ui-widget-content" style="width: 30%; float: right; margin: 10px;">
                                                    <table class="reporte-tabla-1" style="width: 100%;">
                                                        <tr>
                                                            <th colspan="2" style="text-align: center;">ARTÍCULOS</th>
                                                        </tr>
                                                        <tr>
                                                            <th style="width: 30px;"><input type="checkbox" name="p15" id="p15" value="true"/></th>
                                                            <td><label for="p15">REGISTRAR, EDITAR, BORRAR</label></td>
                                                        </tr>
                                                        <tr>
                                                            <th><input type="checkbox" name="p4" id="p4" value="true" /></th>
                                                            <td><label for="p4">LISTAR</label></td>
                                                        </tr>
                                                        <tr>
                                                            <th><input type="checkbox" name="p7" id="p7" value="true"/></th>
                                                            <td><label for="p7">KARDEX</label></td>
                                                        </tr>
                                                        <tr>
                                                            <th><input type="checkbox" name="p6" id="p6" value="true"/></th>
                                                            <td><label for="p6">ACTUALIZACION MANUAL</label></td>
                                                        </tr>
                                                        <tr>
                                                            <th><input type="checkbox" name="p21" id="p21" value="true"/></th>
                                                            <td><label for="p21">KARDEX S/N</label></td>
                                                        </tr>
                                                        <tr>
                                                            <th><input type="checkbox" name="p27" id="p27" value="true"/></th>
                                                            <td><label for="p27">EDITAR PRECIO VENTA</label></td>
                                                        </tr>
                                                    </table>
                                                </div>
                                                <div style="clear: both;"></div>
                                                <!--div 7 garante-->
                                                <div class="ui-widget-content" style="width: 30%; float: left; margin: 10px;" >
                                                    <table class="reporte-tabla-1" style="width: 100%;">
                                                        <tr>
                                                            <th colspan="2" style="text-align: center;">GARANTE</th>
                                                        </tr>
                                                        <tr>
                                                            <th style="width: 30px;"><input type="checkbox" name="p48" id="p48" value="true" /></th>
                                                            <td><label for="p48">REGISTRAR, EDITAR, BORRAR</label></td>
                                                        </tr>
                                                        <tr>
                                                            <th><input type="checkbox" name="p25" id="p25" value="true" /></th>
                                                            <td><label for="p25">CONSULTAR</label></td>                            
                                                        </tr>
                                                    </table>
                                                </div>
                                                <!--div 8 marca-->
                                                <div class="ui-widget-content" style="width: 30%; float: left; margin: 10px;">
                                                    <table class="reporte-tabla-1" style="width: 100%;">
                                                        <tr>
                                                            <th colspan="2" style="text-align: center;">MARCA</th>
                                                        </tr>
                                                        <tr>
                                                            <th style="width: 30px;"><input type="checkbox" name="p45" id="p45" value="true" /></th>
                                                            <td><label for="p45">REGISTRAR, EDITAR, BORRAR</label></td>
                                                        </tr>
                                                        <tr>
                                                            <th><input type="checkbox" name="p13" id="p13" value="true" /></th>
                                                            <td><label for="p13">CONSULTAR</label></td>                            
                                                        </tr>
                                                    </table>
                                                </div>
                                                <!--div 9 familia-->
                                                <div class="ui-widget-content" style="width: 30%; float: right; margin: 10px;">
                                                    <table class="reporte-tabla-1" style="width: 100%;">
                                                        <tr>
                                                            <th colspan="2" style="text-align: center;">FAMILIA</th>
                                                        </tr>
                                                        <tr>
                                                            <th style="width: 30px;"><input type="checkbox" name="p43" id="p43" value="true"/></th>
                                                            <td><label for="p43">REGISTRAR, EDITAR, BORRAR</label></td>
                                                        </tr>
                                                        <tr>
                                                            <th><input type="checkbox" name="p14" id="p14" value="true" /></th>
                                                            <td><label for="p14">LISTAR</label></td>
                                                        </tr>
                                                    </table>
                                                </div>                                        
                                                <div style="clear: both;"></div>
                                                <!--div 10 zona-->
                                                <div class="ui-widget-content" style="width: 30%; float: left; margin: 10px;" >
                                                    <table class="reporte-tabla-1" style="width: 100%;">
                                                        <tr>
                                                            <th colspan="2" style="text-align: center;">ZONA</th>
                                                        </tr>
                                                        <tr>
                                                            <th style="width: 30px;"><input type="checkbox" name="p46" id="p46" value="true" /></th>
                                                            <td><label for="p46">REGISTRAR, EDITAR, BORRAR</label></td>
                                                        </tr>
                                                        <tr>
                                                            <th><input type="checkbox" name="p16" id="p16" value="true" /></th>
                                                            <td><label for="p16">LISTAR</label></td>
                                                        </tr>
                                                    </table>
                                                </div>
                                                <!--DIV 11 COMPRA-->
                                                <div class="ui-widget-content" style="width: 30%; float: left; margin: 10px;" >
                                                    <table class="reporte-tabla-1" style="width: 100%;">
                                                        <tr>
                                                            <th colspan="2" style="text-align: center;">COMPRA</th>
                                                        </tr>
                                                        <tr>
                                                            <th style="width: 30px;"><input type="checkbox" name="p39" id="p39" value="true" /></th>
                                                            <td><label for="p39">REGISTRAR, EDITAR</label></td>
                                                        </tr>
                                                        <tr>
                                                            <th><input type="checkbox" name="p3" id="p3" value="true" /></th>
                                                            <td><label for="p3">LISTAR</label></td>
                                                        </tr>
                                                        <tr>
                                                            <th><input type="checkbox" name="p40" id="p40" value="true"/></th>
                                                            <td><label for="p40">ANULAR</label></td>
                                                        </tr>
                                                    </table>
                                                </div>
                                                <!--DIV 12 PROVEEDOR-->
                                                <div class="ui-widget-content" style="width: 30%; float: right; margin: 10px;" >
                                                    <table class="reporte-tabla-1" style="width: 100%;">
                                                        <tr>
                                                            <th colspan="2" style="text-align: center;">PROVEEDOR</th>
                                                        </tr>
                                                        <tr>
                                                            <th style="width: 30px;"><input type="checkbox" name="p17" id="p17" value="true" /></th>
                                                            <td><label for="p17">REGISTRAR, EDITAR, BORRAR</label></td>
                                                        </tr>
                                                        <tr>
                                                            <th><input type="checkbox" name="p5" id="p5" value="true" /></th>
                                                            <td><label for="p5">LISTAR</label></td>
                                                        </tr>
                                                    </table>
                                                </div>
                                                <div style="clear: both;"></div>
                                                <!--div 13 PERSONAL-->
                                                <div class="ui-widget-content" style="width: 30%; float: left; margin: 10px;" >
                                                    <table class="reporte-tabla-1" style="width: 100%;">
                                                        <tr>
                                                            <th colspan="2" style="text-align: center;">PERSONAL</th>
                                                        </tr>
                                                        <tr>
                                                            <th style="width: 30px;"><input type="checkbox" name="p30" id="p30" value="true" /></th>
                                                            <td><label for="p30">REGISTRAR, EDITAR, BORRAR</label></td>
                                                        </tr>
                                                        <tr>
                                                            <th><input type="checkbox" name="p9" id="p9" value="true" /></th>
                                                            <td><label for="p9">LISTAR</label></td>
                                                        </tr>
                                                    </table>
                                                </div>
                                                <!--DIV 14 REPORTE-->
                                                <div class="ui-widget-content" style="width: 30%; float: left; margin: 10px;" >
                                                    <table class="reporte-tabla-1" style="width: 100%;">
                                                        <tr>
                                                            <th colspan="2" style="text-align: center;">REPORTE</th>
                                                        </tr>
                                                        <tr>
                                                            <th style="width: 30px;"><input type="checkbox" name="p19" id="p19" value="true"/></th>
                                                            <td><label for="p19">ACCEDER</label></td>
                                                        </tr>
                                                    </table>
                                                </div>
                                                <!--DIV 15 PROPIETARIO-->
                                                <div class="ui-widget-content" style="width: 30%; float: right; margin: 10px;" >
                                                    <table class="reporte-tabla-1" style="width: 100%;">
                                                        <tr>
                                                            <th colspan="2" style="text-align: center;">PROPIETARIO</th>
                                                        </tr>
                                                        <tr>
                                                            <th style="width: 30px;"><input type="checkbox" name="p47" id="p47" value="true" /></th>
                                                            <td><label for="p47">REGISTRAR, EDITAR, BORRAR</label></td>
                                                        </tr>
                                                        <tr>
                                                            <th><input type="checkbox" name="p26" id="p26" value="true" /></th>
                                                            <td><label for="p26">LISTAR</label></td>
                                                        </tr>
                                                    </table>
                                                </div>
                                                <div style="clear: both;"></div>
                                                <!--div 16 USUARIO-->
                                                <div class="ui-widget-content" style="width: 30%; float: left; margin: 10px;" >
                                                    <table class="reporte-tabla-1" style="width: 100%;">
                                                        <tr>
                                                            <th colspan="2" style="text-align: center;">USUARIO</th>
                                                        </tr>
                                                        <tr>
                                                            <th style="width: 30px;"><input type="checkbox" name="p44" id="p44" value="true" /></th>
                                                            <td><label for="p44">REGISTRAR, EDITAR, BORRAR</label></td>
                                                        </tr>
                                                        <tr>
                                                            <th><input type="checkbox" name="p20" id="p20" value="true" /></th>
                                                            <td><label for="p20">LISTAR</label></td>
                                                        </tr>
                                                    </table>
                                                </div>
                                                <!--DIV 17 CARGO-->
                                                <div class="ui-widget-content" style="width: 30%; float: left; margin: 10px;" >
                                                    <table class="reporte-tabla-1" style="width: 100%;">
                                                        <tr>
                                                            <th colspan="2" style="text-align: center;">CARGO</th>
                                                        </tr>
                                                        <tr>
                                                            <th style="width: 30px;"><input type="checkbox" name="p42" id="p42" value="true" /></th>
                                                            <td><label for="p42">REGISTRAR, EDITAR, BORRAR</label></td>
                                                        </tr>
                                                        <tr>
                                                            <th><input type="checkbox" name="p10" id="p10" value="true" /></th>
                                                            <td><label for="p10">LISTAR</label></td>
                                                        </tr>
                                                    </table>
                                                </div>
                                                <!--DIV 18 Area-->
                                                <div class="ui-widget-content" style="width: 30%; float: right; margin: 10px;" >
                                                    <table class="reporte-tabla-1" style="width: 100%;">
                                                        <tr>
                                                            <th colspan="2" style="text-align: center;">ÁREA</th>
                                                        </tr>
                                                        <tr>
                                                            <th style="width: 30px;"><input type="checkbox" name="p32" id="p32" value="true" /></th>
                                                            <td><label for="p32">REGISTRAR, EDITAR, BORRAR</label></td>
                                                        </tr>
                                                        <tr>
                                                            <th><input type="checkbox" name="p11" id="p11" value="true" /></th>
                                                            <td><label for="p11">LISTAR</label></td>
                                                        </tr>
                                                    </table>
                                                </div>
                                            </td>
                                        </tr>
                                    </tbody>
                                </table>
                            </div>
                        </div>
                    </form>
                    <div id="dPersonalSeleccionar" title="SELECCIONA PERSONAL">
                        <table class="reporte-tabla-1" style="width: 100%;">
                            <tr>
                                <th style="width: 80px;">ACTUAL</th>
                                <td><label id="lPersonalActual"></label></td>
                            </tr>
                            <tr>
                                <th>NUEVO</th>
                                <td>
                                    <input type="hidden" name="codPersonaAux" id="codPersonaAux" value="" />
                                    <input type="text" name="nombresCPersonal" id="nombresCPersonal" value="" style="width: 98%;" />
                                </td>
                            </tr>
                        </table>
                    </div>
                </div>
                <div id="rightSub2" class="ocultar">
                    <div>
                        <h3 class="titulo">INPORTADORA YUCRA S.A.C.</h3>
                        <div class="articles" style="font-size: 12px;padding: 10px;text-align: justify;">
                            Como llegar a Yucra desde el óvalo Saenz Peña.
                            <br /><br />
                            <img src="../librerias/imagenes/ruta_yucra.PNG" alt="Example pic" style="border: 3px solid #ccc;" />
                            <br/><br />
                            Yucra se basa en 5 pilares:<br>
                            Calidad de servicio<br>
                            Responsabilidad<br>
                            Puntualidad<br>
                            Honestidad<br>
                            Respeto
                        </div>
                    </div>
                    <div>
                        <div style="width: 48%; float: left;">
                            <h3 class="titulo">MISIÓN</h3>
                            <div class="articles" style="font-size: 12px;padding: 10px;text-align: justify;">
                                Somos la empresa comercial que brinda servicio personalizado con una amplia gama de productos de calidada través de una cultura de valores.
                            </div>
                        </div>
                        <div style="width: 48%; float: right;">
                            <h3 class="titulo">VISIÓN</h3>
                            <div class="articles" style="font-size: 12px;padding: 10px;text-align: justify;">
                                Ser la empresa comercial con productos de calidad para la exigencia de cada necesidad brindando un servicio de excelencia.
                            </div>
                        </div>
                    </div>
                </div>
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