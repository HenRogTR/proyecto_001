<%-- 
    Document   : clienteKardex_
    Created on : 19/05/2014, 08:44:43 PM
    Author     : Henrri
--%>

<%@page import="utilitarios.cManejoFechas"%>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <title> kardex cliente</title>
        <!--todos-->
        <script type="text/javascript" src="../librerias/jquery/jquery-1.9.0-min.js" ></script>
        <script type="text/javascript" src="../librerias/jquery/jquery.timer-min.js" ></script>
        <script type="text/javascript" src="../librerias/jquery-ui/jquery-ui-1.10.3.custom/js/jquery-ui-1.10.3.custom.min.js" ></script>
        <link rel="stylesheet" type="text/css" href="../librerias/principal/todos.css" media="all"/>
        <!--cambios-->
        <%@include file="../principal/inclusiones.jsp" %>
        <!--propio-->
        <script type="text/javascript" src="../librerias/utilitarios/validaciones.js"></script>
        <script type="text/javascript" src="../librerias/utilitarios/formatoDecimal.js"></script>
        <script type="text/javascript" src="../librerias/plugin/jquery.growl/javascripts/jquery.growl.min.js"></script>
        <link rel="stylesheet" type="text/css" href="../librerias/plugin/jquery.growl/stylesheets/jquery.growl.min.css" media="all"/>
        <script type="text/javascript" src="../librerias/persona/cliente/clienteKardex.js?v14.09.30"></script>
        <script type="text/javascript" src="../librerias/plugin/mask/jquery.mask.min.js"></script>
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
        <input type="hidden" name="paginaActualPermiso" id="permisoPaginaP2" value="" title="KARDEX DE CLIENTES"/>
        <div id="wrap">
            <div id="header">
                <label class="horaCabecera"><%=new cManejoFechas().fechaCabecera()%></label>
            </div>
            <div id="right" style="width: 1024px;">
                <div id="rightSub1" class="ocultar">
                    <h3 class="titulo">
                        <a href="../" class="boton botonNormal home">Inicio</a> <span>KARDEX DE CLIENTES</span> 
                        <a href="#" id="bClienteBuscar" class="boton iconoSoloPequenio search">&nbsp;</a>
                        <span id="sCodCliente" class="datoMostrar ocultar">00000000</span>
                        <span class="esperando">&nbsp;</span> : 
                        <span id="sNombresC" class="datoMostrar ocultar">APELLIDOS Y NOMBRES</span>
                        <span class="esperando">&nbsp;</span> (
                        <span id="sInteresEvitarEstado" class="datoMostrar ocultar" style="font-size: 11px; font-weight: bold;">Detalle de afecto de interés</span>
                        <span class="esperando">&nbsp;</span> <a href="#" id="bInteresEvitarEditar" class="boton iconoSoloPequenio edit">&nbsp;</a>)
                    </h3>
                    <div class="ocultar">
                        <input type="text" name="codCliente" id="codCliente" value="" />
                        <input type="text" name="codVentaAux" id="codVentaAux"/>
                        <input type="text" name="interesEvitarEstado" id="interesEvitarEstado" value=""/>
                    </div>
                    <div class="contenedorGeneral">
                        <div class="divSuperior">
                            <div class="divIzquierdo" style="width: 60%; float: left;">
                                <div>
                                    <table class="tabla9px anchoTotal">
                                        <thead>
                                            <tr>
                                                <th colspan="9" class="centrado"><span>VENTAS</span> <a id="bVentaImprimir" href="#" class="boton iconoSoloPequenio print">&nbsp;</a></th>
                                            </tr>
                                            <tr>
                                                <th style="width: 80px;"><span>Documento</span></th>
                                                <th style="width: 80px;"><span>Fecha</span></th>
                                                <th style="width: 60px;"><span>Total</span></th>
                                                <th style="width: 60px;"><span>INT %</span></th>
                                                <th style="width: 60px;"><span>Amort.</span></th>
                                                <th style="width: 60px;"><span>Deuda</span></th>
                                                <th style="width: 40px;"><span>N° Let</span></th>
                                                <th style="width: 60px;"><span>T. Venta</span></th>
                                                <th><span>T. Cambio</span></th>
                                            </tr>
                                        </thead>
                                    </table>
                                </div>
                                <div class="fondoDivSecundario" style="overflow: auto;height: 150px;">
                                    <table id="tVenta" class="tabla9px anchoTotal">
                                        <tbody class="tbDato">                                            
                                        </tbody>
                                        <tfoot class="thFondoTd tfContenedor">
                                            <tr>
                                                <th style="width: 80px;"><span class="esperando">&nbsp;</span></th>
                                                <th style="width: 80px;"><span class="esperando">&nbsp;</span></th>
                                                <th style="width: 60px;"><span class="esperando">&nbsp;</span></th>
                                                <th style="width: 60px;"><span class="esperando">&nbsp;</span></th>
                                                <th style="width: 60px;"><span class="esperando">&nbsp;</span></th>
                                                <th style="width: 60px;"><span class="esperando">&nbsp;</span></th>
                                                <th style="width: 40px;"><span class="esperando">&nbsp;</span></th>
                                                <th style="width: 60px;"><span class="esperando">&nbsp;</span></th>
                                                <th><span class="esperando">&nbsp;</span></th>
                                            </tr>
                                        </tfoot>
                                    </table>
                                </div>
                            </div>
                            <div class="divDerecho" style="width: 39%; float: right;">
                                <div>
                                    <table class="tabla9px anchoTotal">
                                        <thead>
                                            <tr>
                                                <th colspan="5"><span>RESUMEN DE DEUDA</span> <a id="bVentaCreditoLetraResumen" href="#" class="boton iconoSoloPequenio print">&nbsp;</a></th>
                                            </tr>
                                            <tr>
                                                <th style="width: 70px;"><span>Mes/Año</span></th>
                                                <th style="width: 70px;"><span>Monto</span></th>
                                                <th style="width: 70px;"><span>Inter.</span></th>
                                                <th style="width: 70px;"><span>M. Pagado</span></th>
                                                <th><span>Saldo</span></th>
                                            </tr>
                                        </thead>
                                    </table>
                                </div>
                                <div class="fondoDivSecundario" style="overflow: auto;height: 150px;">
                                    <table id="tVentaCreditoLetraResumen" class="tabla9px anchoTotal">
                                        <tbody class="tbDato">

                                        </tbody>
                                        <tfoot class="thFondoTd tfContenedor">
                                            <tr>
                                                <th style="width: 70px;"><span class="esperando">&nbsp;</span></th>
                                                <th style="width: 70px;"><span class="esperando">&nbsp;</span></th>
                                                <th style="width: 70px;"><span class="esperando">&nbsp;</span></th>
                                                <th style="width: 70px;"><span class="esperando">&nbsp;</span></th>
                                                <th><span class="esperando">&nbsp;</span></th>
                                            </tr>
                                        </tfoot>
                                    </table>
                                </div>
                            </div>
                        </div>
                        <div style="clear: both; padding-top: 10px;"></div>
                        <div class="divInferior">
                            <div class="divIzquierdo" style="width: 65%; float: left;">
                                <div>
                                    <table class="tabla9px anchoTotal">
                                        <thead>
                                            <tr>
                                                <th colspan="9"><span>CUOTAS DE PAGOS</span> <a id="bVentaCreditoLetra" class="boton iconoSoloPequenio print">&nbsp;</a></th>
                                            </tr>
                                            <tr>
                                                <th style="width: 90px;"><span>Documento</span></th>
                                                <th style="width: 90px;"><span>Detalle</span></th>
                                                <th style="width: 70px;"><span>F. Venc.</span></th>
                                                <th style="width: 60px;"><span>Cuota</span></th>
                                                <th style="width: 60px;"><span>I(%)</span></th>
                                                <th style="width: 60px;"><span>Pagado</span></th>
                                                <th style="width: 70px;"><span>F. Pago</span></th>
                                                <th style="width: 40px;"><span>Días A.</span></th>
                                                <th><span>Saldo</span></th>
                                            </tr>
                                        </thead>
                                    </table>
                                </div>
                                <div class="fondoDivSecundario" style="overflow: auto; height: 150px;">
                                    <table id="tVentaCreditoLetra" class="tabla9px anchoTotal">
                                        <tbody class="tbDato">

                                        </tbody>
                                        <tfoot class="thFondoTd tfContenedor">
                                            <tr>
                                                <th style="width: 90px;"><span class="esperando">&nbsp;</span></th>
                                                <th style="width: 90px;"><span class="esperando">&nbsp;</span></th>
                                                <th style="width: 70px;"><span class="esperando">&nbsp;</span></th>
                                                <th style="width: 60px;"><span class="esperando">&nbsp;</span></th>
                                                <th style="width: 60px;"><span class="esperando">&nbsp;</span></th>
                                                <th style="width: 60px;"><span class="esperando">&nbsp;</span></th>
                                                <th style="width: 70px;"><span class="esperando">&nbsp;</span></th>
                                                <th style="width: 40px;"><span class="esperando">&nbsp;</span></th>
                                                <th><span class="esperando">&nbsp;</span></th>
                                            </tr>
                                        </tfoot>
                                    </table>
                                </div>
                                <div>
                                    <table id="tTotales" class="tabla11px anchoTotal">
                                        <tbody>
                                            <tr>
                                                <th class="ancho60px derecha">
                                                    <span>TOTAL</span>
                                                </th>
                                                <td class="derecha ancho80px">
                                                    <div id="dTotal" class="datoMostrar ocultar">
                                                        <span id="lTotal"  style="padding-right: 2px;"></span>
                                                    </div>
                                                    <span class="esperando">&nbsp;</span>
                                                </td>
                                                <th class="ancho80px">
                                                    <span>INTERÉS</span>
                                                </th>
                                                <td class="derecha ancho80px">
                                                    <div id="dInteres" class="datoMostrar ocultar">
                                                        <span id="lInteres"  style="padding-right: 2px;" class="ocultar interesAfectado"></span>
                                                        <span id="lInteresInteresNoAfectado"  style="padding-right: 2px;" class="ocultar interesNoAfectado"></span>
                                                    </div>
                                                    <span class="esperando">&nbsp;</span>
                                                </td>
                                                <th class="ancho80px derecha">
                                                    <span>AMORTIZADO</span>
                                                </th>
                                                <td class="derecha ancho80px">
                                                    <div id="dAmortizado" class="datoMostrar ocultar">
                                                        <span id="lAmortizado" style="padding-right: 2px;"></span>
                                                    </div>
                                                    <span class="esperando">&nbsp;</span>
                                                </td>
                                                <th class="ancho80px derecha">
                                                    <span>SALDO</span>
                                                </th>
                                                <td class="derecha">
                                                    <div id="dSaldo" class="datoMostrar ocultar">
                                                        <span id="lSaldo" style="padding-right: 2px;" class="ocultar interesAfectado"></span>
                                                        <span id="lSaldoInteresNoAfectado" style="padding-right: 2px;" class="ocultar interesNoAfectado"></span>
                                                    </div>
                                                    <span class="esperando">&nbsp;</span>
                                                </td>
                                            </tr>
                                        </tbody>
                                    </table>
                                </div>
                                <div style="clear: both; padding-top: 10px;"></div>
                                <div>
                                    <table class="tabla9px anchoTotal">
                                        <thead>
                                            <tr>
                                                <th colspan="5"><span>DETALLE DE VENTAS</span> <a id="" class="boton iconoSoloPequenio print">&nbsp;</a></th>
                                            </tr>
                                            <tr>
                                                <th style="width: 80px;"><span>Documento</span></th>
                                                <th style="width: 40px;"><span>Cant.</span></th>
                                                <th style="width: 380px;"><span>Producto</span></th>
                                                <th style="width: 70px;"><span>P.U.</span></th>
                                                <th><span>Total</label></th>
                                            </tr>
                                        </thead>
                                    </table>    
                                </div>
                                <div class="fondoDivSecundario" style="overflow: auto; height: 150px;">
                                    <table id="tVentaDetalle" class="tabla9px anchoTotal">
                                        <tbody class="tbDato">

                                        </tbody>
                                        <tfoot class="thFondoTd tfContenedor">
                                            <tr>
                                                <th style="width: 80px;"><span class="esperando">&nbsp;</span></th>
                                                <th style="width: 40px;"><span class="esperando">&nbsp;</span></th>
                                                <th style="width: 380px;"><span class="esperando">&nbsp;</span></th>
                                                <th style="width: 70px;"><span class="esperando">&nbsp;</span></th>
                                                <th><span class="esperando">&nbsp;</span></th>
                                            </tr>
                                        </tfoot>
                                    </table>
                                </div>
                            </div>
                            <div class="divDerecho" style="width: 34%; float: right;">
                                <div>
                                    <table class="tabla9px anchoTotal">
                                        <thead>
                                            <tr>
                                                <th colspan="4"><span>PAGOS REALIZADOS</span> <a id="bCobranza" class="boton iconoSoloPequenio print">&nbsp;</a></th>
                                            </tr>
                                            <tr>
                                                <th style="width: 110px;"><span>Documento</span></th>
                                                <th style="width: 70px;"><span>Monto</span></th>
                                                <th style="width: 70px;"><span>Fecha</span></th>
                                                <th><span>Anticipo</span></th>
                                            </tr>
                                        </thead>
                                    </table>
                                </div>
                                <div class="fondoDivSecundario" style="overflow: auto; height: 270px;">
                                    <table id="tCobranza" class="tabla9px anchoTotal">
                                        <tbody class="tbDato">

                                        </tbody>
                                        <tfoot class="thFondoTd tfContenedor">
                                            <tr>
                                                <th style="width: 110px;"><span class="esperando">&nbsp;</span></th>
                                                <th style="width: 70px;"><span class="esperando">&nbsp;</span></th>
                                                <th style="width: 70px;"><span class="esperando">&nbsp;</span></th>
                                                <th><span class="esperando">&nbsp;</span></th>
                                            </tr>
                                        </tfoot>
                                    </table>
                                </div>
                                <div style="clear: both; padding-top: 10px;"></div>
                                <div>
                                    <table class="tabla9px anchoTotal">
                                        <thead>
                                            <tr>
                                                <th colspan="2"><span>DETALLE RECIBO</span></th>
                                            </tr>
                                        </thead>
                                    </table>
                                </div>
                                <div class="fondoDivSecundario" style="overflow: auto; height: 70px;">
                                    <table id="tCobranzaDetalle" class="tabla9px anchoTotal">
                                        <tbody class="tbDato">

                                        </tbody>
                                        <tfoot class="thFondoTd">
                                            <tr>
                                                <th style="width: 110px;"><span class="esperando">&nbsp;</span></th>
                                                <th><span class="esperando">&nbsp;</span></th>
                                            </tr>
                                        </tfoot>
                                    </table>
                                </div>
                            </div>
                        </div>
                    </div>
                    <div style="clear: both;"></div>
                    <!--dialog d_clienteBuscar-->
                    <div id="dClienteBuscar" title="BUSCAR CLIENTE" style="padding: 20px;">
                        <table class="reporte-tabla-1 anchoTotal" >
                            <thead>
                                <tr>                                    
                                    <th><a id="bClienteActualizar" href="#" class="boton iconoSoloPequenio update">&nbsp;</a> <label>DNI-PASPORTE/RUC APELLIDOS-NOMBRES/RAZÓN SOCIAL</label></th>
                                    <th class="ancho120px"><label>COD. CLIENTE</label></th>
                                </tr>
                            </thead>
                            <tbody>
                                <tr>
                                    <td class="contenedorEntrada">
                                        <input type="text" name="dniPasaporteRucNombresCBuscar" id="dniPasaporteRucNombresCBuscar" value="" class="entrada anchoTotal"/>
                                    </td>
                                    <td class="contenedorEntrada">
                                        <input type="text" name="codClienteBuscar" id="codClienteBuscar" value="" class="entrada anchoTotal derecha" />
                                    </td>
                                </tr>
                            </tbody>
                        </table>
                    </div>
                    <!-- Asignar interes -->
                    <div id="dInteresAsignadoEditar">
                        <div class="ui-state-highlight ui-corner-all" style="margin-top: 20px; padding: 0 .7em; text-align: justify">
                            <p><span class="ui-icon ui-icon-info" style="float: left; margin-right: .3em;"></span>
                                <strong>¡Alerta!</strong><br><br> 
                                <span><strong>Deshabilitar intereses (Solo hoy):</strong> 
                                    Indica que toda pago/amortización realizada 
                                    no se cobrarán intereses (afectado a día actual). 
                                    Al culminar el día se cobrarán interes.</span>
                                <br><br>
                                <span><strong>Deshabilitar intereses (Permanente):</strong> 
                                    Indica que toda pago/amortización realizada 
                                    no se cobrarán intereses para todas las letras durante  
                                    un tiempo indeterminado.</span>
                                <br><br>
                                <span><strong>Habilitar intereses:</strong> 
                                    El pago/amortización estará afectado por intereses.</span></p>
                        </div>
                    </div>
                    <!-- Escoger las VCL a imprimir -->
                    <div id="dVentaCreditoLetraSeleccionar" title="Opciones de impresión Cuotas de pago">
                        <div class="dDatos" style="">
                            <div>
                                <input type="radio" id="VCLActual" name="ventaCreditoLetraImprimirOpcion" value="ventaActual" checked="checked" /> 
                                <label for="VCLActual">Cuotas de pago de venta actual</label>
                            </div>
                            <div>                            
                                <input type="radio" id="VCLTodos" name="ventaCreditoLetraImprimirOpcion" value="ventaTodos" />
                                <label for="VCLTodos">Todas las cuotas de pago</label>
                            </div>
                        </div>
                    </div>
                    <!-- Escoger las Cobranzas a imprimir -->
                    <div id="dCobranzaSeleccionar" title="Opciones de impresión de Cobranza">
                        <div class="dDatos" style="">
                            <div>
                                <input type="radio" id="cobranzaActual" name="cobranzaImprimirOpcion" value="ventaActual"  checked="checked"/> 
                                <label for="cobranzaActual">Pagos de venta actual</label>
                            </div>
                            <div>                            
                                <input type="radio" id="cobranzaTodos" name="cobranzaImprimirOpcion" value="ventaTodos" />
                                <label for="cobranzaTodos">Todas los pagos</label>
                            </div>
                        </div>
                    </div>
                </div>
                <%@include file="../principal/div2.jsp" %>
            </div>
            <div id="left" class="ocultar">
                <div class="acceso">
                    <h3 class="titulo">INICIE SESIÓN</h3>                    
                    <a id="bAccesoAbrir" class="boton botonNormal key">Ejecutar SICCI</a>
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