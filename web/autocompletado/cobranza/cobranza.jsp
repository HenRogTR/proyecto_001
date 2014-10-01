<%-- 
    Document   : cobranza_1
    Created on : 09/04/2014, 10:26:52 AM
    Author     : Henrri
--%>

<%@page import="java.util.Date"%>
<%@page import="utilitarios.cManejoFechas"%>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <title>cobranza</title>
        <!--todos-->
        <script type="text/javascript" src="../librerias/jquery/jquery-1.9.0-min.js" ></script>
        <script type="text/javascript" src="../librerias/jquery/jquery.timer-min.js" ></script>
        <script type="text/javascript" src="../librerias/jquery-ui/jquery-ui-1.10.3.custom/js/jquery-ui-1.10.3.custom.min.js" ></script>
        <link rel="stylesheet" type="text/css" href="../librerias/principal/todos.css" media="all"/>
        <!--cambios-->
        <%@include file="../principal/inclusiones.jsp" %>
        <!--propio-->
        <script type="text/javascript" src="../librerias/utilitarios/manejoFecha.js"></script>
        <script type="text/javascript" src="../librerias/utilitarios/formatoDecimal.js"></script>
        <script type="text/javascript" src="../librerias/cobranza/cobranza.js?v.14.07.24"></script>
        <script type="text/javascript" src="../librerias/plugin/mask/jquery.mask.min.js"></script>
        <script type="text/javascript" src="../librerias/utilitarios/validaciones.js"></script>
        <script type="text/javascript" src="../librerias/jquery-ui/jquery-ui-1.10.3.custom/js/i18n/jquery.ui.datepicker-es-min.js"></script>
        <style>
            .ui-autocomplete {
                width: 500px;
                max-height: 200px;
                overflow-y: auto;
                /* prevent horizontal scrollbar */
                overflow-x: hidden;
            }
            /* IE 6 doesn't support max-height
            * we use height instead, but this forces the menu to always be this tall
            */
            * html .ui-autocomplete {
                height: 200px;
            }
        </style>
    </head>
    <body>
        <input type="hidden" name="paginaActualPermiso" id="permisoPaginaP" value="1" title=""/>
        <div id="wrap">
            <div id="header">
                <label class="horaCabecera"><%=new cManejoFechas().fechaCabecera()%></label>
            </div>
            <div id="right" style="width: 1024px;">                
                <div id="rightSub1" class="ocultar">
                    <%
                        String codCliente = request.getParameter("codCliente");
                    %>
                    <h3 class="titulo"><a href="../" class="boton botonNormal home">Inicio</a> MÓDULO COBRANZA</h3>
                    <div id="ayuda"></div>
                    <div id="d_estadoProceso" class="ocultar">

                    </div>
                    <div class="ocultar">
                        <input type="text" name="codCliente" id="codCliente" value="<%=codCliente == null ? "0" : codCliente%>" />
                        <input type="text" name="codPersona" id="codPersona" value="" />
                        <input type="text" name="codVenta" id="codVenta" value="0" />
                        <input type="text" name="codPersonaAux" id="codPersonaAux" value="0" />
                        <input type="text" id="aux" value="0"/>
                        <input type="text" id="auxDocSerieNumero" value=""/>
                        <input type="text" id="auxCodCobranza" value=""/>
                        <input type="text" id="auxSaldoFavor" value="0.00"/>
                        <input type="text" id="marcaSaldoFavor" value="0"/>
                        <input type="text" id="auxCodCobranza2" value="0"/>
                        <input type="text" id="docRecDescFoco" value=""/>
                    </div>
                    <div>                                                       <!--inicio general-->
                        <div style="width: 50%; float: left;">                  <!--inicio panel izquierdo-->
                            <div>
                                <table id="tabla_clienteDato" class="tabla11px anchoTotal">
                                    <thead>
                                        <tr>
                                            <th class="medio" colspan="4">NOMBRE / RAZÓN SOCIAL <a id="bClienteBuscar" class="boton iconoSoloPequenio search">&nbsp;</a></th>
                                        </tr>
                                    </thead>
                                    <tbody>
                                        <tr>
                                            <td style="width: 15%;">
                                                <span id="sCodCliente" class="vaciar">Cod Cliente</span>
                                                <span class="esperando">&nbsp;</span>
                                            </td>
                                            <td colspan="3">
                                                <span id="sNombresC" class="vaciar">Nombres/Razón Social</span><br>
                                                <span id="sInteresEvitarEstado" class="vaciar" style="font-size: 10px; font-weight: bold;">Interés</span>
                                                <span class="esperando">&nbsp;</span>
                                                <a href="#" id="bInteresEvitarEditar" class="boton iconoSoloPequenio edit">&nbsp;</a>
                                            </td>
                                        </tr>
                                        <tr>
                                            <td colspan="4">
                                                <span id="sDireccion" class="vaciar">Dirección</span>
                                                <span class="esperando">&nbsp;</span>
                                            </td>
                                        </tr>
                                        <tr>
                                            <td colspan="2">
                                                <span id="sEmpresaConvenio" class="vaciar">Empresa/Convenio</span>
                                                <span class="esperando">&nbsp;</span>
                                            </td>
                                            <td style="width: 25%;">
                                                <span id="sCodCobranza" class="vaciar">C. Cobranza</span>
                                                <span class="esperando">&nbsp;</span>
                                            </td>
                                            <td style="width: 25%;">
                                                <span id="sCondicion" class="vaciar">Condición</span>
                                                <span class="esperando">&nbsp;</span>
                                            </td>
                                        </tr>
                                    </tbody>
                                </table>
                            </div>
                            <div style="margin-top: 10px;">
                                <table class="tabla9px anchoTotal">
                                    <thead>
                                        <tr>
                                            <th style="width: 75px;"><label>Documento</label></th>
                                            <th style="width: 72px;"><label>Detalle</label></th>
                                            <th style="width: 60px;"><label>F.Vencim.</label></th>
                                            <th style="width: 45px;"><label>Cuota</label></th>
                                            <th style="width: 45px;"><label>Int.</label></th>
                                            <th style="width: 45px;"><label>Pagado</label></th>
                                            <th style="width: 60px;"><label>F.Pago</label></th>
                                            <th style="width: 25px;"><label title="Días atrasados">D.</label></th>
                                            <th><label>Saldo</label></th>
                                        </tr>
                                    </thead>
                                </table>
                            </div>
                            <div id="d_ventaCreditoLetra" class="fondoDivSecundario" style="overflow: auto; height:452px;">
                                <table id="tVentaCreditoLetra" class="tabla9px anchoTotal tabla_dato">

                                </table>
                                <table class="tabla9px anchoTotal esperando_contenedor">
                                    <tbody>
                                        <tr>
                                            <td style="width: 75px;"><span class="esperando">&nbsp;</span></td>
                                            <td style="width: 72px;"><span class="esperando">&nbsp;</span></td>
                                            <td style="width: 60px;"><span class="esperando">&nbsp;</span></td>
                                            <td style="width: 45px;"><span class="esperando">&nbsp;</span></td>
                                            <td style="width: 45px;"><span class="esperando">&nbsp;</span></td>
                                            <td style="width: 45px;"><span class="esperando">&nbsp;</span></td>
                                            <td style="width: 60px;"><span class="esperando">&nbsp;</span></td>
                                            <td style="width: 25px;"><span class="esperando">&nbsp;</span></td>
                                            <td><span class="esperando">&nbsp;</span></td>
                                        </tr>
                                    </tbody>
                                </table>
                            </div>
                            <div style="margin-top: 10px;">
                                <table id="tabla_deudaResumen" class="tabla11px anchoTotal">
                                    <tbody>
                                        <tr>
                                            <th style="width: 15%;"><label>Total</label></th>
                                            <td style="text-align: right;">
                                                <span id="lTotal" class="vaciar">0.00</span>
                                                <span class="esperando">&nbsp;</span>
                                                <!--Cuando se quite el filtro por venta tomará este dato-->
                                                <span id="lTotalAuxiliar" class="ocultar">0.00</span>
                                            </td>
                                            <th style="width: 15%;"><label>Amortizado</label></th>
                                            <td style="text-align: right;">
                                                <span id="lAmortizado" class="vaciar">0.00</span>
                                                <span class="esperando">&nbsp;</span>
                                                <!--Cuando se quite el filtro por venta tomará este dato-->
                                                <span id="lAmortizadoAuxiliar" class="ocultar">0.00</span>
                                            </td>
                                            <th style="width: 15%;"><label>Saldo</label></th>
                                            <td style="text-align: right;">
                                                <span id="lSaldo" class="vaciar">0.00</span>
                                                <span class="esperando">&nbsp;</span>
                                                <!--Cuando se quite el filtro por venta tomará este dato-->
                                                <span id="lSaldoAuxiliar" class="ocultar">0.00</span>
                                            </td>
                                        </tr>
                                        <tr>
                                            <th>Filtro</th>
                                            <td colspan="5" style="color: red;"><label id="lFiltro">No se esta flitrando el pago.</label></td>
                                        </tr>                                
                                    </tbody>
                                </table>
                            </div>
                        </div>                                                  <!--fin panel izquierdo-->
                        <div style="width: 49%; float: right;">                 <!--inicio panel derecho-->
                            <div>                                               <!--inicio tipoCobranza-->
                                <table id="tabla_tipo_saldoFavor" class="tabla11px anchoTotal">
                                    <tbody>
                                        <tr>
                                            <th class="ancho40px">Tipo</th>
                                            <td class="ancho160px medio">
                                                <input type="radio" name="tipoPago" value="normal" checked="checked" id="tipo1" /> <label for="tipo1">Normal</label>
                                                <input type="radio" name="tipoPago" value="anticipo" id="tipo2"/> <label for="tipo2">Anticipo</label> 
                                            </td>
                                            <td class="ancho80px"></td>
                                            <th class="ancho120px">Saldo a favor <a id="bSaldoFavorUsar" class="boton iconoSoloPequenio ok">&nbsp;</a></th>
                                            <td class="derecha ancho100px"><span id="sSaldoFavor" class="vaciar">0.00</span><span class="esperando">&nbsp;</span></td>
                                        </tr>
                                    </tbody>
                                </table>
                            </div>                                              <!--fin tipoCobranza-->
                            <div>                                               <!--inicio ventaDetalle-->
                                <div style="margin-top: 10px;">
                                    <table class="tabla9px anchoTotal">
                                        <thead>
                                            <tr>
                                                <th style="width: 80px;"><label>Documento</label></th>
                                                <th style="width: 25px;"><label>C.</label></th>
                                                <th style="width: 260px;"><label>Descripción</label></th>
                                                <th style="width: 60px;"><label>P. U.</label></th>
                                                <th><label>T. Venta</label></th>
                                            </tr>
                                        </thead>
                                    </table>
                                </div>
                                <div id="d_ventaDetalle" class="fondoDivSecundario" style="overflow: auto;height: 108px;">
                                    <table id="t_ventaDetalle" class="tabla9px anchoTotal tabla_dato">

                                    </table>
                                    <table class="tabla9px anchoTotal esperando_contenedor">
                                        <tbody>
                                            <tr>
                                                <td style="width: 80px;"><span class="esperando">&nbsp;</span></td>
                                                <td style="width: 25px;"><span class="esperando">&nbsp;</span></td>
                                                <td style="width: 260px;"><span class="esperando">&nbsp;</span></td>
                                                <td style="width: 60px;"><span class="esperando">&nbsp;</span></td>
                                                <td><span class="esperando">&nbsp;</span></td>
                                            </tr>
                                        </tbody>
                                    </table>
                                </div>
                            </div>                                              <!--fin ventaDetalle-->
                            <div style="margin-top: 10px;">                     <!--inicio cobranza, cobranzaDetalle, resumenPago-->
                                <div style="float: left;width: 55%;">
                                    <div>
                                        <table class="tabla9px anchoTotal">
                                            <thead>
                                                <tr>
                                                    <th style="width: 65px;"><label>F. Pago</label></th>
                                                    <th style="width: 45px;"><label>Monto</label></th>
                                                    <th style="width: 90px;"><label>Recibo</label></th>
                                                    <th><label>Saldo</label></th>
                                                </tr>
                                            </thead>
                                        </table>
                                    </div>
                                    <div class="fondoDivSecundario" style="overflow: auto;height: 340px;">
                                        <table id="tCobranza" class="tabla9px anchoTotal tabla_dato">

                                        </table>
                                        <table class="tabla9px anchoTotal esperando_contenedor">
                                            <tbody>
                                                <tr>
                                                    <td style="width: 65px;"><span class="esperando">&nbsp;</span></td>
                                                    <td style="width: 45px;"><span class="esperando">&nbsp;</span></td>
                                                    <td style="width: 90px;"><span class="esperando">&nbsp;</span></td>
                                                    <td><span class="esperando">&nbsp;</span></td>
                                                </tr>
                                            </tbody>
                                        </table>
                                    </div>
                                </div>
                                <div style="float: right; width: 44%;">
                                    <div>
                                        <div>
                                            <table class="tabla9px anchoTotal">
                                                <thead>
                                                    <tr>
                                                        <th class="centrado"><label>Detalle de cobranza</label></th>
                                                    </tr>
                                                </thead>
                                            </table>
                                        </div>
                                        <div id="d_cobranzaDetalle" class="fondoDivSecundario" style="overflow: auto;height: 120px;">
                                            <table id="tCobranzaDetalle" class="tabla9px anchoTotal tabla_dato">

                                            </table>
                                            <table class="tabla9px anchoTotal esperando_contenedor">
                                                <tbody>
                                                    <tr>                                                        
                                                        <td><span class="esperando">&nbsp;</span></td>
                                                    </tr>
                                                </tbody>
                                            </table>
                                        </div>
                                    </div>
                                    <div style="margin-top: 10px;">
                                        <div>
                                            <table class="tabla9px anchoTotal">
                                                <thead>
                                                    <tr>
                                                        <th style="width: 45px;"><label>Año/Mes</label></th>
                                                        <th style="width: 55px;"><label>Monto</label></th>
                                                        <th style="width: 45px;"><label>Pagos</label></th>
                                                        <th><label>Saldo</label></th>
                                                    </tr>
                                                </thead>
                                            </table>
                                        </div>
                                        <div id="d_ventaCreditoLetraResumenMensual" class="fondoDivSecundario" style="overflow: auto;height: 190px;">
                                            <table id="t_deudaMes" class="tabla9px anchoTotal tabla_dato">

                                            </table>
                                            <table class="tabla9px anchoTotal esperando_contenedor">
                                                <tbody>
                                                    <tr>                                                        
                                                        <td style="width: 45px;"><span class="esperando">&nbsp;</span></td>
                                                        <td style="width: 55px;"><span class="esperando">&nbsp;</span></td>
                                                        <td style="width: 45px;"><span class="esperando">&nbsp;</span></td>
                                                        <td><span class="esperando">&nbsp;</span></td>
                                                    </tr>
                                                </tbody>
                                            </table>
                                        </div>
                                    </div>
                                </div>
                            </div>                                              <!--fin cobranza, cobranzaDetalle, resumenPago-->
                            <div style="clear: both;"></div>
                            <div style="margin-top: 10px;">
                                <table class="tabla11px anchoTotal">
                                    <thead>
                                        <tr>
                                            <th class="ancho200px"><label>Recibo</label></th>
                                            <th class="ancho100px"><label>Fecha</label></th>
                                            <th class="ancho120px"><label>Monto</label></th>
                                            <th style="text-align: center;"><label>Opciones</label></th>
                                        </tr>
                                    </thead>
                                    <tbody>
                                        <tr>
                                            <td>
                                                <div id="dUsarSaldoFavor" style="font-size: 12px; font-weight: bold;" class="ocultar">
                                                    <span>XXX-111-999999</span>
                                                </div>
                                                <div id="dNoUsarSaldoFavor">
                                                    <div id="dCaja" style="font-size: 12px; font-weight: bold;">
                                                        <select name="docRecCaja" id="docRecCaja" class="entrada" style="padding: 0px;">                                                        
                                                        </select><span>-</span>
                                                        <select name="serieSelect" id="serieSelect" class="entrada" style="padding: 0px;" >                                                        
                                                        </select><span>- XXXXXX</span>
                                                    </div>
                                                    <div id="dDescuento" class="ocultar" style="font-size: 12px; font-weight: bold;">                                                    
                                                        <select name="docRecDesc" id="docRecDesc" class="entrada" style="padding: 0px;">
                                                        </select>
                                                        <span>-</span>
                                                        <input type="text" name="serie" id="serie" value="" class="ancho40px entrada" style=" font-size: 18px;" /><span>-XXXXXX</span>
                                                    </div>
                                                    <div id="dManual" class="ocultar contenedorEntrada" style="font-size: 12px;font-weight: bold;">
                                                        <input type="text" name="docSerieNumero" id="docSerieNumero" class="anchoTotal limpiar entrada mayuscula"/>
                                                    </div>
                                                </div>
                                            </td>
                                            <td class="contenedorEntrada">
                                                <input type="text" name="fechaCobranza" id="fechaCobranza" value="<%=new cManejoFechas().DateAString(new Date())%>" class="anchoTotal entrada" style="font-size: 16px;" />
                                                <input type="hidden" name="auxFecha" id="auxFecha" value="<%=new cManejoFechas().DateAString(new Date())%>" />
                                            </td>
                                            <td class="contenedorEntrada">
                                                <input type="text" name="montoAmortizar" value="" id="montoAmortizar" class="anchoTotal derecha entrada" style="font-size: 16px;" /> 
                                            </td>
                                            <td class="centrado medio">                                                
                                                <a id="bAmortizar" href="#" class="boton iconoSoloPequenio save">&nbsp;</a>
                                            </td>
                                        </tr>
                                        <tr>
                                            <th class="izquierda medio">
                                                <input type="radio" name="tipoCobro" id="rdCaja" value="caja" checked="checked" /><label for="rdCaja">Caja</label>
                                                <input type="radio" name="tipoCobro" id="rdDescuento" value="descuento" /><label for="rdDescuento">Descuento</label>
                                                <input type="radio" name="tipoCobro" id="rdManual" value="manual"/><label for="rdManual">Manual</label>
                                            </th>
                                            <td colspan="3">
                                                <a id="cobranzaImprimir" class="boton botonNormal print">Matricial</a>
                                                <a id="bImprimirTicket" href="#" class="boton botonNormal print">Ticket</a>
                                            </td>
                                        </tr>
                                    </tbody>
                                </table>
                            </div>
                        </div>                                                  <!--fin panel derecho-->
                    </div>                                                      <!--fin general-->

                    <div id="dClienteBuscar" title="BUSCAR CLIENTE" style="padding: 20px;">
                        <table class="reporte-tabla-1 anchoTotal" >
                            <thead>
                                <tr>
                                    <th style=""><label>DNI-PASPORTE/RUC APELLIDOS-NOMBRES/RAZÓN SOCIAL</label></th>
                                    <th class="ancho120px"><label>COD. CLIENTE</label></th>
                                </tr>
                            </thead>
                            <tbody>
                                <tr>
                                    <td class="contenedorEntrada">
                                        <input type="text" name="nombresCDniPasaporteRucBuscar" id="nombresCDniPasaporteRucBuscar" value="" class="entrada anchoTotal"/>
                                    </td>
                                    <td class="contenedorEntrada">
                                        <input type="text" name="codClienteBuscar" id="codClienteBuscar" value="" class="entrada anchoTotal derecha" />
                                    </td>
                                </tr>
                            </tbody>
                        </table>
                    </div>

                    <div id="d_filtroConfirmar" title="Confirmar Filtro" style="font-size: 16px;">
                        <strong>¡Confirmar!</strong> Se va a filtrar solo por este <b>DOCUMENTO</b><br>
                        ¿Está seguro de continuar?
                    </div>
                    <!--confirmar saldo a favor-->
                    <div id="dConfirmarSaldoFavor" title="Saldo a favor">
                        <strong>!Confirmar¡</strong> El monto a pagar supera la deuda mantenida, se activará <b>SALDO A FAVOR</b><br>
                        (Pago)<label></label> - (Deuda)<label></label> = (Diferencia)<label></label><br>
                        <b>Saldo a favor:</b> <label></label><br>
                        ¿Confirma operación? Despues no se podrá borrar este pago.
                    </div>
                    <!--confirmar grabacion-->
                    <div id="dAmortizarConfirmar" title="Confirmar cobranza" style="font-size: 13px; text-align: justify;">
                        <strong>¡Confirmar!</strong> Esta a un clic de realizar el pago, 
                        tenga en cuenta que no se podra anular esta operación, 
                        antes de ello verifique los datos nuevamente.
                        <b>¿Está ud. seguro de continuar?</b><br>
                        <b>Tipo de operacion: </b><label id="lTipoOperacion" style="font-size: 14px;color: red;"></label>
                    </div>
                    <!--confirmar eliminar-->
                    <div id="dCobranzaEliminar" title="Eliminar conbraza">
                        Se eliminara definitivamente el pago correspondiente seleccionado<br>
                        ¿Desea continuar?
                    </div>
                    <div id="dSaldoFavorConfirmar" title="Saldo a favor">
                        Se va a utilizar <b>SALDO A FAVOR</b> del cliente, ¿está seguro de continuar?
                    </div>
                    <!--actualizar interes evitar-->
                    <div id="dInteresAsignadoEditar">
                        <div class="ui-state-highlight ui-corner-all" style="margin-top: 20px; padding: 0 .7em; text-align: justify">
                            <p><span class="ui-icon ui-icon-info" style="float: left; margin-right: .3em;"></span>
                                <strong>¡Alerta!</strong><br><br> 
                                <span><strong>Deshabilitar intereses:</strong> 
                                    Indica que toda pago/amortización realizada 
                                    no se cobrarán intereses (afectado a día actual). 
                                    Al culminar el día se cobrarán interes.</span>
                                <br>
                                <br>
                                <span><strong>Habilitar intereses:</strong> 
                                    El pago/amortización estará afectado por intereses.</span></p>
                        </div>
                    </div>
                </div>
                <%@include file="../principal/div2.jsp" %>
            </div>
            <div id="left" class="ocultar">
                <div class="acceso">
                    <h3 class="titulo">INICIE SESIÓN</h3>                    
                    <button class="sexybutton" id="bAccesoAbrir" type="button"><span><span><img src="../librerias/botonesIconos/images/icons/silk/key_go.png">Ejecutar SICCI</span></span></button>
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
