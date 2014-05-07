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
        <script type="text/javascript" src="../librerias/persona/usuario/usuarioMantenimiento_1.js"></script>
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
                                    <td id="lUsuario" class="vaciar" colspan="3"></td>
                                </tr>
                                <tr>
                                    <th>PERSONAL</th>
                                    <td id="lPersonal" class="vaciar" colspan="3"></td>
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
                                                    <th colspan="2" style="text-align: center;" class="medio">CLIENTE <a class="sexybutton sexyicononly sexysimple sexysmall sexypropio" id="bClienteEditar"><span class="edit"></span></a></th>
                                                </tr>
                                                <tr>
                                                    <th><input type="checkbox" name="p29" id="p29" value="ON"/></th>
                                                    <td><label for="p29">REGISTRAR, EDITAR</label></td>
                                                </tr>
                                                <tr>
                                                    <th style="width: 30px;"><input type="checkbox" name="p1" id="p1" value="ON"/></th>
                                                    <td><label for="p1">CONSULTAR</label></td>
                                                </tr>
                                                <tr>
                                                    <th><input type="checkbox" name="p2" id="p2" value="ON"/></th>
                                                    <td><label for="p2">KARDEX</label></td>                            
                                                </tr>
                                            </table>
                                        </div>
                                        <!--div 2 venta-->
                                        <div class="ui-widget-content" style="width: 30%; float: left; margin: 10px;">
                                            <table class="reporte-tabla-1" style="width: 100%;">
                                                <tr>
                                                    <th colspan="2" style="text-align: center;" class="medio">VENTA <a class="sexybutton sexyicononly sexysimple sexysmall sexypropio" id="bVentaEditar"><span class="edit"></span></a></th>
                                                </tr>
                                                <tr>
                                                    <th><input type="checkbox" name="p31" id="p31" value="ON" /></th>
                                                    <td><label for="p31">REGISTRAR, EDITAR</label></td>                            
                                                </tr>
                                                <tr>
                                                    <th style="width: 30px;"><input type="checkbox" name="p18" id="p18" value="ON" /></th>
                                                    <td><label for="p18">CONSULTAR</label></td>
                                                </tr>
                                                <tr>
                                                    <th><input type="checkbox" name="p23" id="p23" value="ON" /></th>
                                                    <td><label for="p23">ANULAR</label></td>                            
                                                </tr>
                                                <tr>
                                                    <th><input type="checkbox" name="p34" id="p34" value="ON" /></th>
                                                    <td><label for="p34">IMPRIMIR</label></td>
                                                </tr>
                                                <tr>
                                                    <th><input type="checkbox" name="p33" id="p33" value="ON" /></th>
                                                    <td><label for="p33">MODIFICAR LETRA CRÉDITO</label></td>
                                                </tr>
                                            </table>
                                        </div>
                                        <!--div 3 cobranza-->
                                        <div class="ui-widget-content" style="width: 30%; float: right; margin: 10px;">
                                            <table class="reporte-tabla-1" style="width: 100%;">
                                                <tr>
                                                    <th colspan="2" style="text-align: center;">COBRANZA <a class="sexybutton sexyicononly sexysimple sexysmall sexypropio" id="bCobranzaEditar"><span class="edit"></span></a></th>
                                                </tr>
                                                <tr>
                                                    <th style="width: 30px;"><input type="checkbox" name="p22" id="p22" value="ON" /></th>
                                                    <td><label for="p22">ACCEDER</label></td>
                                                </tr>
                                                <tr>
                                                    <th><input type="checkbox" name="p35" id="p35" value="ON" /></th>
                                                    <td><label for="p35">REGISTRAR RECIBO</label></td>                            
                                                </tr>
                                                <tr>
                                                    <th><input type="checkbox" name="p24" id="p24" value="ON" /></th>
                                                    <td><label for="p24">ANULAR RECIBO</label></td>                            
                                                </tr>
                                                <tr>
                                                    <th><input type="checkbox" name="p36" id="p36" value="ON" /></th>
                                                    <td><label for="p36">IMPRIMIR RECIBO</label></td>                            
                                                </tr>
                                                <tr>
                                                    <th><input type="checkbox" name="p49" id="p49" value="ON" /></th>
                                                    <td><label for="p49">IMPRIMIR COPIA RECIBO</label></td>                            
                                                </tr>
                                                <tr>
                                                    <th><input type="checkbox" name="p37" id="p37" value="ON" /></th>
                                                    <td><label for="p37">UTILIZAR SALDO A FAVOR</label></td>                            
                                                </tr>
                                            </table>
                                        </div>
                                        <div style="clear: both;"></div>
                                        <!--div 4 empresaconvenio-->
                                        <div class="ui-widget-content" style="width: 30%; float: left; margin: 10px;">
                                            <table class="reporte-tabla-1" style="width: 100%;">
                                                <tr>
                                                    <th colspan="2" style="text-align: center;">EMPRESA/CONVENIO <a class="sexybutton sexyicononly sexysimple sexysmall sexypropio" id="bEmpresaConvenioEditar"><span class="edit"></span></a></th>
                                                </tr>
                                                <tr>
                                                    <th style="width: 30px;"><input type="checkbox" name="p41" id="p41" value="ON" /></th>
                                                    <td><label for="p41">REGISTRAR, EDITAR, BORRAR</label></td>
                                                </tr>
                                                <tr>
                                                    <th><input type="checkbox" name="p12" id="p12" value="ON" /></th>
                                                    <td><label for="p12">CONSULTAR</label></td>                            
                                                </tr>
                                            </table>
                                        </div>
                                        <!--div 5 almacén-->
                                        <div class="ui-widget-content" style="width: 30%; float: left; margin: 10px;">
                                            <table class="reporte-tabla-1" style="width: 100%;">
                                                <tr>
                                                    <th colspan="2" style="text-align: center;">ALMACÉN <a class="sexybutton sexyicononly sexysimple sexysmall sexypropio" id="bAlmacenEditar"><span class="edit"></span></a></th>
                                                </tr>
                                                <tr>
                                                    <th style="width: 30px;"><input type="checkbox" name="p38" id="p38" value="ON" /></th>
                                                    <td><label for="p38">REGISTRAR, EDITAR, BORRAR</label></td>
                                                </tr>
                                                <tr>
                                                    <th><input type="checkbox" name="p8" id="p8" value="ON" /></th>
                                                    <td><label for="p8">CONSULTAR</label></td>                            
                                                </tr>
                                            </table>
                                        </div>
                                        <!--div 6 artículo-->
                                        <div class="ui-widget-content" style="width: 30%; float: right; margin: 10px;">
                                            <table class="reporte-tabla-1" style="width: 100%;">
                                                <tr>
                                                    <th colspan="2" style="text-align: center;">ARTÍCULOS <a class="sexybutton sexyicononly sexysimple sexysmall sexypropio" id="bArticuloProductoEditar"><span class="edit"></span></a></th>
                                                </tr>
                                                <tr>
                                                    <th style="width: 30px;"><input type="checkbox" name="p15" id="p15" value="ON"/></th>
                                                    <td><label for="p15">REGISTRAR, EDITAR, BORRAR</label></td>
                                                </tr>
                                                <tr>
                                                    <th><input type="checkbox" name="p4" id="p4" value="ON" /></th>
                                                    <td><label for="p4">LISTAR</label></td>
                                                </tr>
                                                <tr>
                                                    <th><input type="checkbox" name="p7" id="p7" value="ON"/></th>
                                                    <td><label for="p7">KARDEX</label></td>
                                                </tr>
                                                <tr>
                                                    <th><input type="checkbox" name="p6" id="p6" value="ON"/></th>
                                                    <td><label for="p6">ACTUALIZACION MANUAL</label></td>
                                                </tr>
                                                <tr>
                                                    <th><input type="checkbox" name="p21" id="p21" value="ON"/></th>
                                                    <td><label for="p21">KARDEX S/N</label></td>
                                                </tr>
                                                <tr>
                                                    <th><input type="checkbox" name="p27" id="p27" value="ON"/></th>
                                                    <td><label for="p27">EDITAR PRECIO VENTA</label></td>
                                                </tr>
                                            </table>
                                        </div>
                                        <div style="clear: both;"></div>
                                        <!--div 7 garante-->
                                        <div class="ui-widget-content" style="width: 30%; float: left; margin: 10px;" >
                                            <table class="reporte-tabla-1" style="width: 100%;">
                                                <tr>
                                                    <th colspan="2" style="text-align: center;">GARANTE <a class="sexybutton sexyicononly sexysimple sexysmall sexypropio" id="bGaranteEditar"><span class="edit"></span></a></th>
                                                </tr>
                                                <tr>
                                                    <th style="width: 30px;"><input type="checkbox" name="p48" id="p48" value="ON" /></th>
                                                    <td><label for="p48">REGISTRAR, EDITAR, BORRAR</label></td>
                                                </tr>
                                                <tr>
                                                    <th><input type="checkbox" name="p25" id="p25" value="ON" /></th>
                                                    <td><label for="p25">CONSULTAR</label></td>                            
                                                </tr>
                                            </table>
                                        </div>
                                        <!--div 8 marca-->
                                        <div class="ui-widget-content" style="width: 30%; float: left; margin: 10px;">
                                            <table class="reporte-tabla-1" style="width: 100%;">
                                                <tr>
                                                    <th colspan="2" style="text-align: center;">MARCA <a class="sexybutton sexyicononly sexysimple sexysmall sexypropio" id="bMarcaEditar"><span class="edit"></span></a></th>
                                                </tr>
                                                <tr>
                                                    <th style="width: 30px;"><input type="checkbox" name="p45" id="p45" value="ON" /></th>
                                                    <td><label for="p45">REGISTRAR, EDITAR, BORRAR</label></td>
                                                </tr>
                                                <tr>
                                                    <th><input type="checkbox" name="p13" id="p13" value="ON" /></th>
                                                    <td><label for="p13">CONSULTAR</label></td>                            
                                                </tr>
                                            </table>
                                        </div>
                                        <!--div 9 familia-->
                                        <div class="ui-widget-content" style="width: 30%; float: right; margin: 10px;">
                                            <table class="reporte-tabla-1" style="width: 100%;">
                                                <tr>
                                                    <th colspan="2" style="text-align: center;">FAMILIA <a class="sexybutton sexyicononly sexysimple sexysmall sexypropio" id="bFamiliaEditar"><span class="edit"></span></a></th>
                                                </tr>
                                                <tr>
                                                    <th style="width: 30px;"><input type="checkbox" name="p43" id="p43" value="ON"/></th>
                                                    <td><label for="p43">REGISTRAR, EDITAR, BORRAR</label></td>
                                                </tr>
                                                <tr>
                                                    <th><input type="checkbox" name="p14" id="p14" value="ON" /></th>
                                                    <td><label for="p14">LISTAR</label></td>
                                                </tr>
                                            </table>
                                        </div>                                        
                                        <div style="clear: both;"></div>
                                        <!--div 10 zona-->
                                        <div class="ui-widget-content" style="width: 30%; float: left; margin: 10px;" >
                                            <table class="reporte-tabla-1" style="width: 100%;">
                                                <tr>
                                                    <th colspan="2" style="text-align: center;">ZONA <a class="sexybutton sexyicononly sexysimple sexysmall sexypropio" id="bZonaEditar"><span class="edit"></span></a></th>
                                                </tr>
                                                <tr>
                                                    <th style="width: 30px;"><input type="checkbox" name="p46" id="p46" value="ON" /></th>
                                                    <td><label for="p46">REGISTRAR, EDITAR, BORRAR</label></td>
                                                </tr>
                                                <tr>
                                                    <th><input type="checkbox" name="p16" id="p16" value="ON" /></th>
                                                    <td><label for="p16">LISTAR</label></td>
                                                </tr>
                                            </table>
                                        </div>
                                        <!--DIV 11 COMPRA-->
                                        <div class="ui-widget-content" style="width: 30%; float: left; margin: 10px;" >
                                            <table class="reporte-tabla-1" style="width: 100%;">
                                                <tr>
                                                    <th colspan="2" style="text-align: center;">COMPRA <a class="sexybutton sexyicononly sexysimple sexysmall sexypropio" id="bCompraEditar"><span class="edit"></span></a></th>
                                                </tr>
                                                <tr>
                                                    <th style="width: 30px;"><input type="checkbox" name="p39" id="p39" value="ON" /></th>
                                                    <td><label for="p39">REGISTRAR, EDITAR</label></td>
                                                </tr>
                                                <tr>
                                                    <th><input type="checkbox" name="p3" id="p3" value="ON" /></th>
                                                    <td><label for="p3">LISTAR</label></td>
                                                </tr>
                                                <tr>
                                                    <th><input type="checkbox" name="p40" id="p40" value="ON"/></th>
                                                    <td><label for="p40">ANULAR</label></td>
                                                </tr>
                                            </table>
                                        </div>
                                        <!--DIV 12 PROVEEDOR-->
                                        <div class="ui-widget-content" style="width: 30%; float: right; margin: 10px;" >
                                            <table class="reporte-tabla-1" style="width: 100%;">
                                                <tr>
                                                    <th colspan="2" style="text-align: center;">PROVEEDOR <a class="sexybutton sexyicononly sexysimple sexysmall sexypropio" id="bProveedorEditar"><span class="edit"></span></a></th>
                                                </tr>
                                                <tr>
                                                    <th style="width: 30px;"><input type="checkbox" name="p17" id="p17" value="ON" /></th>
                                                    <td><label for="p17">REGISTRAR, EDITAR, BORRAR</label></td>
                                                </tr>
                                                <tr>
                                                    <th><input type="checkbox" name="p5" id="p5" value="ON" /></th>
                                                    <td><label for="p5">LISTAR</label></td>
                                                </tr>
                                            </table>
                                        </div>
                                        <div style="clear: both;"></div>
                                        <!--div 13 PERSONAL-->
                                        <div class="ui-widget-content" style="width: 30%; float: left; margin: 10px;" >
                                            <table class="reporte-tabla-1" style="width: 100%;">
                                                <tr>
                                                    <th colspan="2" style="text-align: center;">PERSONAL <a class="sexybutton sexyicononly sexysimple sexysmall sexypropio" id="bPersonalEditar"><span class="edit"></span></a></th>
                                                </tr>
                                                <tr>
                                                    <th style="width: 30px;"><input type="checkbox" name="p30" id="p30" value="ON" /></th>
                                                    <td><label for="p30">REGISTRAR, EDITAR, BORRAR</label></td>
                                                </tr>
                                                <tr>
                                                    <th><input type="checkbox" name="p9" id="p9" value="ON" /></th>
                                                    <td><label for="p9">LISTAR</label></td>
                                                </tr>
                                            </table>
                                        </div>
                                        <!--DIV 14 REPORTE-->
                                        <div class="ui-widget-content" style="width: 30%; float: left; margin: 10px;" >
                                            <table class="reporte-tabla-1" style="width: 100%;">
                                                <tr>
                                                    <th colspan="2" style="text-align: center;">REPORTE <a class="sexybutton sexyicononly sexysimple sexysmall sexypropio" id="bReporteEditar"><span class="edit"></span></a></th>
                                                </tr>
                                                <tr>
                                                    <th style="width: 30px;"><input type="checkbox" name="p19" id="p19" value="ON"/></th>
                                                    <td><label for="p19">ACCEDER</label></td>
                                                </tr>
                                            </table>
                                        </div>
                                        <!--DIV 15 PROPIETARIO-->
                                        <div class="ui-widget-content" style="width: 30%; float: right; margin: 10px;" >
                                            <table class="reporte-tabla-1" style="width: 100%;">
                                                <tr>
                                                    <th colspan="2" style="text-align: center;">PROPIETARIO <a class="sexybutton sexyicononly sexysimple sexysmall sexypropio" id="bPropietarioEditar"><span class="edit"></span></a></th>
                                                </tr>
                                                <tr>
                                                    <th style="width: 30px;"><input type="checkbox" name="p47" id="p47" value="ON" /></th>
                                                    <td><label for="p47">REGISTRAR, EDITAR, BORRAR</label></td>
                                                </tr>
                                                <tr>
                                                    <th><input type="checkbox" name="p26" id="p26" value="ON" /></th>
                                                    <td><label for="p26">LISTAR</label></td>
                                                </tr>
                                            </table>
                                        </div>
                                        <div style="clear: both;"></div>
                                        <!--div 16 USUARIO-->
                                        <div class="ui-widget-content" style="width: 30%; float: left; margin: 10px;" >
                                            <table class="reporte-tabla-1" style="width: 100%;">
                                                <tr>
                                                    <th colspan="2" style="text-align: center;">USUARIO <a class="sexybutton sexyicononly sexysimple sexysmall sexypropio" id="bUsuarioEditar"><span class="edit"></span></a></th>
                                                </tr>
                                                <tr>
                                                    <th style="width: 30px;"><input type="checkbox" name="p44" id="p44" value="ON" /></th>
                                                    <td><label for="p44">REGISTRAR, EDITAR, BORRAR</label></td>
                                                </tr>
                                                <tr>
                                                    <th><input type="checkbox" name="p20" id="p20" value="ON" /></th>
                                                    <td><label for="p20">LISTAR</label></td>
                                                </tr>
                                            </table>
                                        </div>
                                        <!--DIV 17 CARGO-->
                                        <div class="ui-widget-content" style="width: 30%; float: left; margin: 10px;" >
                                            <table class="reporte-tabla-1" style="width: 100%;">
                                                <tr>
                                                    <th colspan="2" style="text-align: center;">CARGO <a class="sexybutton sexyicononly sexysimple sexysmall sexypropio" id="bCargoEditar"><span class="edit"></span></a></th>
                                                </tr>
                                                <tr>
                                                    <th style="width: 30px;"><input type="checkbox" name="p42" id="p42" value="ON" /></th>
                                                    <td><label for="p42">REGISTRAR, EDITAR, BORRAR</label></td>
                                                </tr>
                                                <tr>
                                                    <th><input type="checkbox" name="p10" id="p10" value="ON" /></th>
                                                    <td><label for="p10">LISTAR</label></td>
                                                </tr>
                                            </table>
                                        </div>
                                        <!--DIV 18 Area-->
                                        <div class="ui-widget-content" style="width: 30%; float: right; margin: 10px;" >
                                            <table class="reporte-tabla-1" style="width: 100%;">
                                                <tr>
                                                    <th colspan="2" style="text-align: center;">ÁREA <a class="sexybutton sexyicononly sexysimple sexysmall sexypropio" id="bAreaEditar"><span class="edit"></span></a></th>
                                                </tr>
                                                <tr>
                                                    <th style="width: 30px;"><input type="checkbox" name="p32" id="p32" value="ON" /></th>
                                                    <td><label for="p32">REGISTRAR, EDITAR, BORRAR</label></td>
                                                </tr>
                                                <tr>
                                                    <th><input type="checkbox" name="p11" id="p11" value="ON" /></th>
                                                    <td><label for="p11">LISTAR</label></td>
                                                </tr>
                                            </table>
                                        </div>
                                    </td>
                                </tr>
                            </table>                            
                        </div>
                    </div>
                    <!--dialog-->
                    <!--d cliente-->
                    <div id="dClienteEditar" title="EDITAR PERMISOS CLIENTE" style="padding: 20px;">
                        <form action="../sUsuario" method="get" id="formClienteEditar">
                            <input type="hidden" name="accionUsuario" value="editarPermisoCliente" />
                            <table class="reporte-tabla-1" style="width: 100%;">
                                <tr>
                                    <th style="width: 30px;"><input type="checkbox" name="p29"  class="p29" value="ON"/></th>
                                    <td><label for="p29">REGISTRAR, EDITAR</label></td>                            
                                </tr>
                                <tr>
                                    <th><input type="checkbox" name="p1" class="p1" value="ON"/></th>
                                    <td><label for="p1">CONSULTAR</label></td>
                                </tr>
                                <tr>
                                    <th><input type="checkbox" name="p2" class="p2" value="ON"/></th>
                                    <td><label for="p3">KARDEX</label></td>                            
                                </tr>
                            </table>
                        </form>
                    </div>
                    <!--d venta-->
                    <div id="dVentaEditar" title="EDITAR PERMISOS VENTA" style="padding: 20px;">
                        <form action="../sUsuario" method="get" id="formVentaEditar">
                            <input type="hidden" name="accionUsuario" value="editarPermisoVenta" />
                            <table class="reporte-tabla-1" style="width: 100%;">                            
                                <tr>
                                    <th><input type="checkbox" name="p31" value="ON" /></th>
                                    <td><label for="p31">REGISTRAR, EDITAR</label></td>                            
                                </tr>
                                <tr>
                                    <th style="width: 30px;"><input type="checkbox" name="p18" value="ON" /></th>
                                    <td><label for="p18">CONSULTAR</label></td>
                                </tr>
                                <tr>
                                    <th><input type="checkbox" name="p23" value="ON" /></th>
                                    <td><label for="p23">ANULAR</label></td>                            
                                </tr>
                                <tr>
                                    <th><input type="checkbox" name="p34" value="ON" /></th>
                                    <td><label for="p34">IMPRIMIR</label></td>
                                </tr>
                                <tr>
                                    <th><input type="checkbox" name="p33" value="ON" /></th>
                                    <td><label for="p33">MODIFICAR LETRA CRÉDITO</label></td>
                                </tr>
                            </table>
                        </form>
                    </div>
                    <!--d cobranza-->
                    <div id="dCobranzaEditar" style="padding: 20px;" title="EDITAR PERMISOS COBRANZA">
                        <form action="../sUsuario" method="get" id="formCobranzaEditar">
                            <input type="hidden" name="accionUsuario" value="editarPermisoCobranza" />
                            <table class="reporte-tabla-1" style="width: 100%;">                            
                                <tr>
                                    <th style="width: 30px;"><input type="checkbox" name="p22" value="ON" /></th>
                                    <td><label for="p22">ACCEDER</label></td>
                                </tr>
                                <tr>
                                    <th><input type="checkbox" name="p35" value="ON" /></th>
                                    <td><label for="p35">REGISTRAR RECIBO</label></td>                            
                                </tr>
                                <tr>
                                    <th><input type="checkbox" name="p24" value="ON" /></th>
                                    <td><label for="p24">ANULAR RECIBO</label></td>                            
                                </tr>
                                <tr>
                                    <th><input type="checkbox" name="p36" value="ON" /></th>
                                    <td><label for="p36">IMPRIMIR RECIBO</label></td>                            
                                </tr>
                                <tr>
                                    <th><input type="checkbox" name="p49" value="ON" /></th>
                                    <td><label for="p49">IMPRIMIR COPIA RECIBO</label></td>                            
                                </tr>
                                <tr>
                                    <th><input type="checkbox" name="p37" value="ON" /></th>
                                    <td><label for="p37">UTILIZAR SALDO A FAVOR</label></td>                            
                                </tr>
                            </table>
                        </form>
                    </div>
                    <!--d empresaConvenio-->
                    <div  style="padding: 20px;" id="dEmpresaConvenioEditar" title="EDITAR PERMISO EMPRESA/CONVENIO">
                        <form action="../sUsuario" method="get" id="formEmpresaConvenioEditar">
                            <input type="hidden" name="accionUsuario" value="editarPermisoEmpresaConvenio" />
                            <table class="reporte-tabla-1" style="width: 100%;">
                                <tr>
                                    <th style="width: 30px;"><input type="checkbox" name="p41" value="ON" /></th>
                                    <td><label for="p41">REGISTRAR, EDITAR, BORRAR</label></td>
                                </tr>
                                <tr>
                                    <th><input type="checkbox" name="p12" value="ON" /></th>
                                    <td><label for="p12">CONSULTAR</label></td>                            
                                </tr>
                            </table>
                        </form>
                    </div>
                    <!--d Alamcen-->
                    <div  style="padding: 20px;" id="dAlmacenEditar" title="EDITAR PERMISO ALMACÉN">
                        <form action="../sUsuario" method="get" id="formAlmacenEditar">
                            <input type="hidden" name="accionUsuario" value="editarPermisoAlmacen" />
                            <table class="reporte-tabla-1" style="width: 100%;">
                                <tr>
                                    <th style="width: 30px;"><input type="checkbox" name="p38" value="ON" /></th>
                                    <td><label for="p38">REGISTRAR, EDITAR, BORRAR</label></td>
                                </tr>
                                <tr>
                                    <th><input type="checkbox" name="p8" value="ON" /></th>
                                    <td><label for="p8">CONSULTAR</label></td>                            
                                </tr>
                            </table>
                        </form>
                    </div>
                    <!--d articuloProducto-->
                    <div  style="padding: 20px;" id="dArticuloProductoEditar" title="EDITAR PERMISO ARTÍCULO PRODUCTO">
                        <form action="../sUsuario" method="get" id="formArticuloProductoEditar">
                            <input type="hidden" name="accionUsuario" value="editarPermisoArticuloProducto" />
                            <table class="reporte-tabla-1" style="width: 100%;">                                
                                <tr>
                                    <th style="width: 30px;"><input type="checkbox" name="p15" value="ON"/></th>
                                    <td><label for="p15">REGISTRAR, EDITAR, BORRAR</label></td>
                                </tr>
                                <tr>
                                    <th><input type="checkbox" name="p4" value="ON" /></th>
                                    <td><label for="p4">LISTAR</label></td>
                                </tr>
                                <tr>
                                    <th><input type="checkbox" name="p7" value="ON"/></th>
                                    <td><label for="p7">KARDEX</label></td>
                                </tr>
                                <tr>
                                    <th><input type="checkbox" name="p6" value="ON"/></th>
                                    <td><label for="p6">ACTUALIZACION MANUAL</label></td>
                                </tr>
                                <tr>
                                    <th><input type="checkbox" name="p21" value="ON"/></th>
                                    <td><label for="p21">KARDEX S/N</label></td>
                                </tr>
                                <tr>
                                    <th><input type="checkbox" name="p27" value="ON"/></th>
                                    <td><label for="p27">EDITAR PRECIO VENTA</label></td>
                                </tr>
                            </table>
                        </form>
                    </div>
                    <!--d Garante-->
                    <div  style="padding: 20px;" id="dGaranteEditar" title="EDITAR PERMISO GARANTE">
                        <form action="../sUsuario" method="get" id="formGaranteEditar">
                            <input type="hidden" name="accionUsuario" value="editarPermisoGarante" />
                            <table class="reporte-tabla-1" style="width: 100%;">
                                <tr>
                                    <th style="width: 30px;"><input type="checkbox" name="p48" value="ON" /></th>
                                    <td><label for="p48">REGISTRAR, EDITAR, BORRAR</label></td>
                                </tr>
                                <tr>
                                    <th><input type="checkbox" name="p25" value="ON" /></th>
                                    <td><label for="p25">CONSULTAR</label></td>                            
                                </tr>
                            </table>
                        </form>
                    </div>
                    <!--d marca-->
                    <div  style="padding: 20px;" id="dMarcaEditar" title="EDITAR PERMISO MARCA">
                        <form action="../sUsuario" method="get" id="formMarcaEditar">
                            <input type="hidden" name="accionUsuario" value="editarPermisoMarca" />
                            <table class="reporte-tabla-1" style="width: 100%;">
                                <tr>
                                    <th style="width: 30px;"><input type="checkbox" name="p45" value="ON" /></th>
                                    <td><label for="p45">REGISTRAR, EDITAR, BORRAR</label></td>
                                </tr>
                                <tr>
                                    <th><input type="checkbox" name="p13" value="ON" /></th>
                                    <td><label for="p13">CONSULTAR</label></td>                            
                                </tr>
                            </table>
                        </form>
                    </div>
                    <!--d Familia-->
                    <div  style="padding: 20px;" id="dFamiliaEditar" title="EDITAR PERMISO FAMILIA">
                        <form action="../sUsuario" method="get" id="formFamiliaEditar">
                            <input type="hidden" name="accionUsuario" value="editarPermisoFamilia" />
                            <table class="reporte-tabla-1" style="width: 100%;">
                                <tr>
                                    <th style="width: 30px;"><input type="checkbox" name="p43" value="ON"/></th>
                                    <td><label for="p43">REGISTRAR, EDITAR, BORRAR</label></td>
                                </tr>
                                <tr>
                                    <th><input type="checkbox" name="p14" value="ON" /></th>
                                    <td><label for="p14">LISTAR</label></td>
                                </tr>
                            </table>
                        </form>
                    </div>
                    <!--d Zona-->
                    <div  style="padding: 20px;" id="dZonaEditar" title="EDITAR PERMISO ZONA">
                        <form action="../sUsuario" method="get" id="formZonaEditar">
                            <input type="hidden" name="accionUsuario" value="editarPermisoZona" />
                            <table class="reporte-tabla-1" style="width: 100%;">
                                <tr>
                                    <th style="width: 30px;"><input type="checkbox" name="p46" value="ON" /></th>
                                    <td><label for="p46">REGISTRAR, EDITAR, BORRAR</label></td>
                                </tr>
                                <tr>
                                    <th><input type="checkbox" name="p16" value="ON" /></th>
                                    <td><label for="p16">LISTAR</label></td>
                                </tr>
                            </table>
                        </form>
                    </div>
                    <!--d Compra-->
                    <div  style="padding: 20px;" id="dCompraEditar" title="EDITAR PERMISO COMPRA">
                        <form action="../sUsuario" method="get" id="formCompraEditar">
                            <input type="hidden" name="accionUsuario" value="editarPermisoCompra" />
                            <table class="reporte-tabla-1" style="width: 100%;">
                                <tr>
                                    <th style="width: 30px;"><input type="checkbox" name="p39" value="ON" /></th>
                                    <td><label for="p39">REGISTRAR, EDITAR</label></td>
                                </tr>
                                <tr>
                                    <th><input type="checkbox" name="p3" value="ON" /></th>
                                    <td><label for="p3">LISTAR</label></td>
                                </tr>
                                <tr>
                                    <th><input type="checkbox" name="p40" value="ON"/></th>
                                    <td><label for="p40">ANULAR</label></td>
                                </tr>
                            </table>
                        </form>
                    </div>
                    <!--d Proveedor-->
                    <div  style="padding: 20px;" id="dProveedorEditar" title="EDITAR PERMISO COMPRA">
                        <form action="../sUsuario" method="get" id="formProveedorEditar">
                            <input type="hidden" name="accionUsuario" value="editarPermisoProveedor" />
                            <table class="reporte-tabla-1" style="width: 100%;">
                                <tr>
                                    <th style="width: 30px;"><input type="checkbox" name="p17" value="ON" /></th>
                                    <td><label for="p17">REGISTRAR, EDITAR, BORRAR</label></td>
                                </tr>
                                <tr>
                                    <th><input type="checkbox" name="p5" value="ON" /></th>
                                    <td><label for="p5">LISTAR</label></td>
                                </tr>
                            </table>
                        </form>
                    </div>
                    <!--d Personal-->
                    <div  style="padding: 20px;" id="dPersonalEditar" title="EDITAR PERMISO PERSONAL">
                        <form action="../sUsuario" method="get" id="formPersonalEditar">
                            <input type="hidden" name="accionUsuario" value="editarPermisoPersonal" />
                            <table class="reporte-tabla-1" style="width: 100%;">
                                <tr>
                                    <th style="width: 30px;"><input type="checkbox" name="p30" value="ON" /></th>
                                    <td><label for="p30">REGISTRAR, EDITAR, BORRAR</label></td>
                                </tr>
                                <tr>
                                    <th><input type="checkbox" name="p9" value="ON" /></th>
                                    <td><label for="p9">LISTAR</label></td>
                                </tr>
                            </table>
                        </form>
                    </div>
                    <!--d Reporte-->
                    <div  style="padding: 20px;" id="dReporteEditar" title="EDITAR PERMISO REPORTE">
                        <form action="../sUsuario" method="get" id="formReporteEditar">
                            <input type="hidden" name="accionUsuario" value="editarPermisoReporte" />
                            <table class="reporte-tabla-1" style="width: 100%;">
                                <tr>
                                    <th style="width: 30px;"><input type="checkbox" name="p19" value="ON"/></th>
                                    <td><label for="p19">ACCEDER</label></td>
                                </tr>
                            </table>
                        </form>
                    </div>
                    <!--d Propietario-->
                    <div  style="padding: 20px;" id="dPropietarioEditar" title="EDITAR PERMISO PROPIETARIO">
                        <form action="../sUsuario" method="get" id="formPropietarioEditar">
                            <input type="hidden" name="accionUsuario" value="editarPermisoPropietario" />
                            <table class="reporte-tabla-1" style="width: 100%;">
                                <tr>
                                    <th style="width: 30px;"><input type="checkbox" name="p47" value="ON" /></th>
                                    <td><label for="p47">REGISTRAR, EDITAR, BORRAR</label></td>
                                </tr>
                                <tr>
                                    <th><input type="checkbox" name="p26" value="ON" /></th>
                                    <td><label for="p26">LISTAR</label></td>
                                </tr>
                            </table>
                        </form>
                    </div>
                    <!--d Usuario-->
                    <div  style="padding: 20px;" id="dUsuarioEditar" title="EDITAR PERMISO USUARIO">
                        <form action="../sUsuario" method="get" id="formUsuarioEditar">
                            <input type="hidden" name="accionUsuario" value="editarPermisoUsuario" />
                            <table class="reporte-tabla-1" style="width: 100%;">
                                <tr>
                                    <th style="width: 30px;"><input type="checkbox" name="p44" value="ON" /></th>
                                    <td><label for="p44">REGISTRAR, EDITAR, BORRAR</label></td>
                                </tr>
                                <tr>
                                    <th><input type="checkbox" name="p20" value="ON" /></th>
                                    <td><label for="p20">LISTAR</label></td>
                                </tr>
                            </table>
                        </form>
                    </div>
                    <!--d Cargo-->
                    <div  style="padding: 20px;" id="dCargoEditar" title="EDITAR PERMISO CARGO">
                        <form action="../sUsuario" method="get" id="formCargoEditar">
                            <input type="hidden" name="accionUsuario" value="editarPermisoCargo" />
                            <table class="reporte-tabla-1" style="width: 100%;">
                                <tr>
                                    <th style="width: 30px;"><input type="checkbox" name="p42" id="p42" value="ON" /></th>
                                    <td><label for="p42">REGISTRAR, EDITAR, BORRAR</label></td>
                                </tr>
                                <tr>
                                    <th><input type="checkbox" name="p10" id="p10" value="ON" /></th>
                                    <td><label for="p10">LISTAR</label></td>
                                </tr>
                            </table>
                        </form>
                    </div>
                    <!--d Area-->
                    <div  style="padding: 20px;" id="dAreaEditar" title="EDITAR PERMISO ÁREA">
                        <form action="../sUsuario" method="get" id="formAreaEditar">
                            <input type="hidden" name="accionUsuario" value="editarPermisoArea" />
                            <table class="reporte-tabla-1" style="width: 100%;">
                                <tr>
                                    <th style="width: 30px;"><input type="checkbox" name="p32" id="p32" value="ON" /></th>
                                    <td><label for="p32">REGISTRAR, EDITAR, BORRAR</label></td>
                                </tr>
                                <tr>
                                    <th><input type="checkbox" name="p11" id="p11" value="ON" /></th>
                                    <td><label for="p11">LISTAR</label></td>
                                </tr>
                            </table>
                        </form>
                    </div>
                </div>
                <!--fin dialogos-->
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