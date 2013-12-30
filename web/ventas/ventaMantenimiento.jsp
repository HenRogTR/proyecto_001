<%-- 
    Document   : ventaMantenimiento
    Created on : 24/08/2013, 11:54:26 AM
    Author     : Henrri***
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
        <title>:.SICCI Importadora Yucra. S.A.C.</title>
        <!--todos-->
        <script type="text/javascript" src="../librerias/jquery/jquery-1.9.0-min.js" ></script>
        <script type="text/javascript" src="../librerias/jquery/jquery.timer-min.js" ></script>
        <script type="text/javascript" src="../librerias/jquery-ui/jquery-ui-1.10.3.custom/js/jquery-ui-1.10.3.custom.min.js" ></script>
        <link rel="stylesheet" type="text/css" href="../librerias/principal/todos.css" media="all"/>
        <!--cambios-->
        <%@include file="../principal/inclusiones.jsp" %>
        <!--propio-->
        <script type="text/javascript" src="../librerias/utilitarios/formatoDecimal.js"></script>
        <script type="text/javascript" src="../librerias/utilitarios/manejoFecha.js"></script>
        <script type="text/javascript" src="../librerias/plugin/mask/jquery.mask.min.js"></script>
        <script type="text/javascript" src="../librerias/venta/ventaMantenimiento.js?v13.12.26"></script>
        <script type="text/javascript" src="../librerias/jquery-ui/jquery-ui-1.10.3.custom/js/i18n/jquery.ui.datepicker-es-min.js"></script>
        <style>
            .ui-autocomplete {
                /*width: 400px;*/
                max-height: 300px;
                overflow-y: auto;
                /* prevent horizontal scrollbar */
                overflow-x: hidden;
            }
            /* IE 6 doesn't support max-height
            * we use height instead, but this forces the menu to always be this tall
            */
            * html .ui-autocomplete {
                height: 300px;
            }
        </style>
    </head>
    <body>
        <input type="hidden" name="paginaActualPermiso" id="permisoPaginaP18" value="" title="MANTENIMIENTO DE VENTAS"/>
        <div id="wrap">
            <div id="header">
                <label class="horaCabecera"><%=objcManejoFechas.fechaCabecera()%></label>
            </div>
            <div id="right">
                <div id="rightSub1" class="ocultar">                    
                    <h3 class="titulo">
                        <button class="sexybutton sexyicononly sexysimple sexypropio sexysmall" id="bVentaBuscar"><span class="search"></span></button>
                        VENTA MANTENIMIENTO
                        <a href="#" class="sexybutton" id="bVentaRegistrar"><span><span><span class="add">Nueva Venta</span></span></span></a>                        
                    </h3>
                    <%
                        int codVenta = 0;
                        try {
                            codVenta = (Integer) session.getAttribute("codVentaMantenimiento");
                        } catch (Exception e) {
                            codVenta = 0;
                        }
                    %>
                    <div class="ocultar">
                        <input type="text" name="codVenta" id="codVenta" value="<%=codVenta%>" />
                        <input type="text" name="fecha" id="fecha" value="" />
                    </div>
                    <table class="reporte-tabla-1">
                        <thead>
                            <tr>
                                <th colspan="5" style="text-align: center;">
                                    <button class="sexybutton" id="bPrimero"><span><span><span class="first">Primero</span></span></span></button>
                                    <button class="sexybutton" id="bAnterior"><span><span><span class="prev">Anterior</span></span></span></button>
                                    <button class="sexybutton" id="bSiguiente"><span><span><span class="next">Siguiente</span></span></span></button>
                                    <button class="sexybutton" id="bUltimo"><span><span><span class="last">Último</span></span></span></button>
                                </th>
                                <th style="text-align: center;">                                                
                                    <a class="sexybutton sexyicononly sexysimple sexysmall sexypropio" href="#" id="bImprimir"><span class="print"></span></a>
                                    <a class="sexybutton sexyicononly sexysimple sexysmall sexypropio" id="bEditar" href="ventaEditar.jsp"><span class="edit"></span></a>
                                    <button class="sexybutton sexyicononly sexysimple sexysmall sexypropio" id="bAnular"><span class="delete"></span></button>
                                </th>
                            </tr>
                        </thead>
                        <tbody>
                            <tr>
                                <th>COD. OPERACIÓN</th>
                                <td><span id="lCodVenta" class="vaciar"></span></td>
                                <th>DET. REGISTRO</th>
                                <td colspan="3"><span id="lRegistroDetalle" class="vaciar"></span></td>
                            </tr>
                            <tr>
                                <th style="width: 120px;">DOCUMENTO</th>
                                <td style="width: 140px;" id="lDocSerieNumero" class="vaciar"></td>
                                <th style="width: 120px;">T. VENTA</th>
                                <td style="width: 140px;" id="lTipo" class="vaciar"></td>
                                <th style="width: 120px;">F. VENTA</th>
                                <td style="width: 124px;" id="lFecha" class="vaciar"></td>
                            </tr>                            
                            <tr>
                                <th>CLIENTE</th>
                                <td colspan="3" id="lCliente" class="vaciar"></td>                                
                                <th>MONEDA</th>
                                <td id="lMoneda" class="vaciar"></td>
                            <tr>
                                <th>DIRECCIÓN</th>
                                <td colspan="3" id="lDireccion" class="vaciar"></td>
                                <td colspan="2" rowspan="4" class="centrado medio">
                                    <div id="ventaSinAnular">
                                        <button class="sexybutton" id="bGuia"><span><span><span class="info">Guía de remisión</span></span></span></button><br>
                                        <div class="ocultar" id="cronograma">
                                            <a class="sexybutton" id="cronogramaOpcion" href="#" target="_blank"><span><span><span class="info">Letra(s) de crédito</span></span></span></a>
                                        </div>
                                        <a class="sexybutton" id="contratoImprimir" href="#" target="_blank"><span><span><span class="print">Imprimir contrato</span></span></span></a>
                                        <a class="sexybutton" id="clausulaImprimir" href="#" target="_blank"><span><span><span class="print">Imprimir clausula</span></span></span></a>
                                    </div>
                                    <div id="ventaAnulada" style="color: red;font-size: 40px;" class="ocultar">
                                        ANULADO
                                    </div>
                                </td>
                            </tr>
                            <tr>
                                <th><label>DNI</label></th>
                                <td id="lDniPasaporte" class="vaciar"></td>
                                <th>RUC</th>
                                <td id="lRuc" class="vaciar"></td>
                            </tr>
                            <tr>
                                <th>EMPRESA</th>
                                <td colspan="3" id="lEmpresaConvenio" class="vaciar"></td>
                            </tr>
                            <tr>
                                <th>VENDEDOR</th>
                                <td colspan="3" id="lVendedor" class="vaciar"></td>
                            </tr>
                            <tr>
                                <td colspan="6" class="tdFondoTh">
                                    <table style="font-size: 10px; width: 100%;">          
                                        <tr>
                                            <th style="width: 25px;">Item</th>
                                            <th style="width: 35px;">Código</th>
                                            <th style="width: 30px;">Cant.</th>
                                            <th style="width: 35px;">U.M.</th>
                                            <th>Descripción</th>
                                            <th style="width: 55px;">P. U.</th>
                                            <th style="width: 50px;">P. Total</th>
                                        </tr>
                                        <tfoot>
                                            <tr>
                                                <th>Son:</label></th>
                                                <td colspan="4" id="lSon" class="vaciar"></td>
                                                <th>Sub Total</th>
                                                <td style="text-align: right;" id="lSubTotal" class="vaciar"></td>
                                            </tr>
                                            <tr>
                                                <th colspan="2">Observación</th>
                                                <td colspan="3" rowspan="4" id="lObservacion" class="vaciar"></td>
                                                <th>Descuento</th>
                                                <td style="text-align: right;" id="lDescuento" class="vaciar"></td>
                                            </tr>
                                            <tr>
                                                <td colspan="2">
                                                </td>
                                                <th>Total</th>
                                                <td style="text-align: right;" id="lTotal" class="vaciar"></td>
                                            </tr>
                                            <tr>
                                                <td colspan="2"></td>
                                                <th>IGV</th>
                                                <td style="text-align: right;" id="lMontoIgv" class="vaciar"></td>
                                            </tr>
                                            <tr>
                                                <td colspan="2"></td>
                                                <th>Neto</th>
                                                <td style="text-align: right;" id="lNeto" class="vaciar"></td>
                                            </tr>
                                        </tfoot>
                                        <tbody id="tbVentaDetalle">

                                        </tbody>
                                    </table>
                                </td>
                            </tr>
                        </tbody>
                    </table>
                </div>
                <%@include file="../principal/div2.jsp" %>
                <!--dialogos-->
                <div id="dVentaAnularConfirmar" title="" style="font-size: 14px;">
                    <div class="ui-state-error ui-corner-all" style="margin-top: 20px; padding: 0 .7em;">
                        <p><span class="ui-icon ui-icon-info" style="float: left; margin-right: .3em;"></span>
                            <strong>¡Alerta!</strong> Sr. Usuario ¿confirma anular la Venta <b><label id="lVentaDocSerieNumeroAnular"></label></b>? Este proceso no podrá deshacerse.</p>
                    </div>                        
                </div>
                <div id="dVentaBuscar" title="BUSCAR VENTA" style="padding: 20px">
                    <table class="reporte-tabla-1" style="width: 100%;">
                        <thead>
                            <tr>
                                <th>DOCUMENTO</th>
                                <th class="ancho120px">CÓDIGO</th>
                            </tr>
                        </thead>
                        <tbody>
                            <tr>
                                <td class="contenedorEntrada">
                                    <input type="search" name="docSerieNumeroBuscar" id="docSerieNumeroBuscar" value="" class="entrada anchoTotal"/>
                                </td>
                                <td class="contenedorEntrada">
                                    <input type="text" name="codVentaBuscar" id="codVentaBuscar" value="" class="entrada anchoTotal"/>
                                </td>
                            </tr>
                        </tbody>
                    </table>
                </div>
                <div id="dVentaCreditoLetraOpcion" title="Letra(s) de crédito" >
                    <div id="dVentaCreditoLetraActual">

                    </div>
                    <div class="ui-state-highlight ui-corner-all" style="margin-top: 20px; padding: 0 .7em;">
                        <p><span class="ui-icon ui-icon-info" style="float: left; margin-right: .3em;"></span>
                            <strong>¡Atención!</strong> Seleccione la opción necesaria.</p>
                    </div>
                </div>
                <div id="dLetrasCreditoModificar" title="Modificar letras de pago">
                    <div class="ocultar">
                        <input type="text" name="codVentaCredito" id="codVentaCredito" value="" />
                    </div>
                    <table class="reporte-tabla-1" style="width: 100%;font-size: 11px;">
                        <thead>
                            <tr>
                                <th style="width: 33%; text-align: center;" colspan="2"><label>LETRAS</label></th>
                                <th style="text-align: center;" colspan="2"><label>VENCIMIENTO</label></th>
                                <th colspan="2" style="width: 33%; text-align: center;"><label>MONTO</label></th>
                            </tr>
                        </thead>
                        <tfoot>
                            <tr>
                                <th style="width: 70px;"><label>Neto</label></th>
                                <td style="width: 80px;text-align: right;"><label id="lNetoLetras">0.00</label></td>
                                <th style="width: 70px;"><label>N° Cuotas</label></th>
                                <td style="width: 80px;">
                                    <input type="text" name="numeroLetras" id="numeroLetras" value="1" style="width: 95%;text-align: right"/>
                                </td>
                                <th style="width: 70px;"><label>F. Inicio</label></th>
                                <td style="width: 80px;">
                                    <input type="text" name="fechaInicio" id="fechaInicio" value="" style="width: 95%;" />
                                </td>
                            </tr>
                            <tr>
                                <th><label>Inicial</label></th>
                                <td>
                                    <input type="text" name="montoInicial" id="montoInicial" value="0" style="width: 95%;text-align: right;"/>
                                </td>
                                <th><label>Vencimiento</label></th>
                                <td>
                                    <input type="text" name="fechaVencimiento" id="fechaVencimiento" value="" style="width: 95%;" readonly=""/>
                                </td>
                                <th><label>Monto Cuota</label> <label style="color: red;">*</label></th>
                                <td style="text-align: right;">
                                    <label id="lMontoCuota">0.00</label>
                                </td>
                            </tr>
                            <tr>
                                <th colspan="2"><label>Periodo (Letras)</label></th>
                                <td colspan="4">
                                    <input type="radio" name="periodoLetra" value="mensual" id="mensual" checked="checked"/><label for="mensual">Mensual</label>&nbsp;&nbsp;
                                    <input type="radio" name="periodoLetra" value="quincenal" id="quincenal"/><label for="quincenal">Quincenal</label>&nbsp;&nbsp;
                                    <input type="radio" name="periodoLetra" value="semanal" id="semanal"/><label for="semanal">Semanal</label>
                                </td>
                            </tr>
                            <tr>
                                <td colspan="6" style="font-size: 10px; color: red;">(*) Monto referencial</td>
                            </tr>
                        </tfoot>
                        <tbody>
                            <tr>
                                <td colspan="6">
                                    <div style="width: 100%;height: 300px;overflow: auto;">
                                        <table style="width: 100%;">
                                            <thead>
                                            </thead>
                                            <tbody id="tbDetalleLetras">

                                            </tbody>
                                        </table>
                                    </div>
                                </td>
                            </tr>
                        </tbody>
                    </table>
                </div>
                <div id="dGuiaRemision" title="Guía de remisión" style="padding: 20px;">
                    <table class="reporte-tabla-1 anchoTotal">
                        <thead>
                        </thead>
                        <tfoot></tfoot>
                        <tbody>
                            <tr>
                                <th class="ancho160px">DOCUMENTO</th>
                                <td><span id="lDocSerieNumero2" class="vaciar" style="font-size: 14px;"></span></td>
                            </tr>
                            <tr>
                                <th>CLIENTE</th>
                                <td><span id="lClienteNombresCGuia" class="vaciar"></span></td>
                            </tr>
                            <tr>
                                <th>PUNTO DE PARTIDA</th>
                                <td class="contenedorEntrada"><textarea name="direccion2" id="direccion2" class="limpiar anchoTotal entrada" style="height: 45px;"></textarea></td>
                            </tr>
                            <tr>
                                <th>PUNTO DE LLEGADA</th>
                                <td class="contenedorEntrada"><textarea name="direccion3" id="direccion3" class="limpiar anchoTotal entrada" style="height: 45px;"></textarea></td>
                            </tr>
                            <tr>
                                <th>DOCUMENTO GUÍA</th>
                                <td class="contenedorEntrada">
                                    <input type="text" name="docSerieNumeroGuia" id="docSerieNumeroGuia" value="" class="limpiar entrada mayuscula" placeholder="G-002-000001"/>
                                    <input type="text" name="docSerieNumeroGuiaAux" id="docSerieNumeroGuiaAux" value="" class="limpiar entrada mayuscula ocultar"/>
                                </td>
                            </tr>
                        </tbody>
                    </table>
                </div>              
                
                <div id="dVentaCreditoLetraConfirmar" title="Confirmar cambios">
                    <div class="ui-state-highlight ui-corner-all" style="margin-top: 20px; padding: 0 .7em;">
                        <p><span class="ui-icon ui-icon-info" style="float: left; margin-right: .3em;"></span>
                            <strong>¡Atención!</strong> Esta seguro que desea modificar las letras de crédito.</p>
                    </div>
                </div>
                <!--fin de dialog's-->
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
