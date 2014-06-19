<%-- 
    Document   : clienteKardex
    Created on : 06/01/2014, 09:28:23 AM
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
        <script type="text/javascript" src="../librerias/jquery-ui/jquery-ui-1.10.3.custom/js/i18n/jquery.ui.datepicker-es-min.js"></script>
        <script type="text/javascript" src="../librerias/persona/cliente/clienteKardex.js?v14.05.22"></script>
        <script type="text/javascript" src="../librerias/plugin/mask/jquery.mask.min.js"></script>
        <script type="text/javascript" src="../librerias/utilitarios/validaciones.js"></script>
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
                        <a href="../index.jsp" class="sexybutton"><span><span><span class="home">Inicio</span></span></span></a>
                        <span>KARDEX DE CLIENTES</span>
                        <button class="sexybutton sexyicononly sexysimple sexypropio sexysmall" id="bClienteBuscar" type="button"><span class="search"></span></button>
                        <a id="bClienteInfo" class="sexybutton" href="#"><span><span><span class="info">Cliente</span></span></span></a>
                        <span id="lNombresC" style="font-size: 16px;font-weight: bold; margin-top: 5px;"></span> | Interés: <span id="interesEvitar_estado">No definido</span>
                        <a id="b_interesEvitarEditar" class="boton iconoSoloPequenio edit" disabled="">&nbsp;</a>
                    </h3>                    
                    <!--Inicio de div general-->
                    <div class="ocultar">
                        <input type="text" name="fechaActual" id="fechaActual" value="<%=new cManejoFechas().DateAString(new Date())%>" class="ocultar" />
                        <input type="text" name="codCliente" id="codCliente" value="" />
                    </div>                    
                    <div>
                        <div><!--Inicio div superior-->
                            <div style="width: 60%; float: left;">
                                <table class="reporte-tabla-2 anchoTotal" style="font-size: 9px;">
                                    <thead>
                                        <tr>
                                            <th colspan="9"><span>VENTAS</span> <a id="" href="#"><img src="../librerias/botonesIconos/images/icons/silk/printer.png"/></a></th>
                                        </tr>
                                        <tr>
                                            <th style="width: 80px;"><span>Documento</span></th>
                                            <th style="width: 80px;"><span>Fecha</span></th>
                                            <th style="width: 60px;"><span>Total</span></th>
                                            <th style="width: 60px;"><span>INT %</span></th>
                                            <th style="width: 60px;"><span>Amort.</span></th>
                                            <th style="width: 60px;"><span>Deuda</span></th>
                                            <th style="width: 50px;"><span>N° Letras</span></th>
                                            <th style="width: 50px;"><span>T. Venta</span></th>
                                            <th><span>T. Cambio</span></th>
                                        </tr>
                                    </thead>
                                </table>
                                <div id="dVenta" style="width: 100%;height: 150px; overflow: auto;">

                                </div>
                            </div>
                            <div style="width: 39%; float: right;">
                                <table class="reporte-tabla-2 anchoTotal" style="font-size: 9px;">
                                    <thead>
                                        <tr>
                                            <th colspan="5"><span>RESUMEN DE PAGOS</span> <a id="bVCLRM" href="#"><img src="../librerias/botonesIconos/images/icons/silk/printer.png"/></a></th>
                                        </tr>
                                        <tr>
                                            <th style="width: 70px;"><span>Mes/Año</span></th>
                                            <th style="width: 70px;"><span>Monto</span></th>
                                            <th style="width: 70px;"><span>Inter.</span></th>
                                            <th style="width: 70px;"><span>M. Pago</span></th>
                                            <th><span>Saldo</span></th>
                                        </tr>
                                    </thead>
                                </table>
                                <div id="dVentaCreditoLetraResumenMensual" style="width: 100%;height: 150px; overflow: auto;">

                                </div>
                            </div>
                        </div>
                        <div style="clear: both; padding-top: 10px;"></div>
                        <div><!--Inicio div inferior-->
                            <div style="width: 65%; float: left;"><!--Inicio div izquierdo-->
                                <table class="reporte-tabla-2 anchoTotal" style="font-size: 9px;">
                                    <thead>
                                        <tr>
                                            <th colspan="9"><span>CUOTAS DE PAGOS</span> <a id="" href="#"><img src="../librerias/botonesIconos/images/icons/silk/printer.png"/></a></th>
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
                                <div id="dVentaCreditoLetra" style="width: 100%;height: 150px; overflow: auto;">

                                </div>
                                <table class="reporte-tabla-2 anchoTotal">
                                    <tbody>
                                        <tr>
                                            <th class="ancho120px derecha"><span>TOTAL</span></th>
                                            <td class="derecha"><span id="lTotal" style="padding-right: 2px;" class="vaciar"></span></td>
                                            <th class="ancho120px derecha"><span>AMORTIZADO</span></th>
                                            <td class="derecha"><span id="lAmortizado" style="padding-right: 2px;" class="vaciar"></span></td>
                                            <th class="ancho120px derecha"><span>SALDO</span></th>
                                            <td class="derecha"><span id="lSaldo" style="padding-right: 2px;" class="vaciar"></span></td>
                                        </tr>
                                    </tbody>
                                </table>
                                <div style="clear: both; padding-top: 10px;"></div>
                                <table class="reporte-tabla-2 anchoTotal" style="font-size: 9px;">
                                    <thead>
                                        <tr>
                                            <th colspan="5"><span>DETALLE DE VENTAS</span> <a id="" href="#"><img src="../librerias/botonesIconos/images/icons/silk/printer.png"/></a></th>
                                        </tr>
                                        <tr>
                                            <th style="width: 90px;"><span>Documento</span></th>
                                            <th style="width: 40px;"><span>Cant.</span></th>
                                            <th style="width: 350px;"><span>Producto</span></th>
                                            <th style="width: 70px;"><span>P.U.</span></th>
                                            <th><span>Total</label></th>
                                        </tr>
                                    </thead>
                                </table>                                
                                <div id="dVentaDetalle" style="width: 100%;height: 150px; overflow: auto;">

                                </div>
                            </div><!--Fin div izquierdo-->
                            <div style="width: 34%; float: right;"><!--Inicio div derecho-->
                                <table class="reporte-tabla-2 anchoTotal" style="font-size: 9px;">
                                    <thead>
                                        <tr>
                                            <th colspan="4"><span>PAGOS REALIZADOS</span> <a id="" href="#"><img src="../librerias/botonesIconos/images/icons/silk/printer.png"/></a></th>
                                        </tr>
                                        <tr>
                                            <th style="width: 110px;"><span>Documento</span></th>
                                            <th style="width: 70px;"><span>Monto</span></th>
                                            <th style="width: 70px;"><span>Fecha</span></th>
                                            <th><span>Anticipo</span></th>
                                        </tr>
                                    </thead>
                                </table>
                                <div id="dCobranza" style="width: 100%;height: 270px; overflow: auto;">

                                </div>
                                <div style="clear: both; padding-top: 5px;"></div>
                                <table class="reporte-tabla-2 anchoTotal" style="font-size: 9px;">
                                    <thead>
                                        <tr>
                                            <th colspan="4"><span>DETALLE RECIBO</span></th>
                                        </tr>
                                    </thead>
                                </table>
                                <div style="width: 100%;height: 70px; overflow: auto;">
                                    <table id="tCobranzaDetalle" class="reporte-tabla-2 anchoTotal"  style="font-size: 9px;">

                                    </table>
                                </div>
                            </div><!--Fin div derecho-->
                        </div>
                    </div>
                    <!--Fin de div general-->
                    <div style="clear: both;"></div>
                    <!--inicio dialog's-->
                    <div id="dClienteBuscar" title="Buscar cliente">
                        <table class="reporte-tabla-1 anchoTotal">
                            <thead>
                                <tr>
                                    <th class="ancho120px"><span>Cod Cliente</span></th>
                                    <th><span>Dni-Pasaporte/Ruc Apellidos y nombres</span></th>
                                </tr>
                            </thead>
                            <tbody
                                <tr>
                                    <td class="contenedorEntrada">
                                        <input type="text" name="codClienteBuscar" id="codClienteBuscar" value="" class="anchoTotal entrada derecha"/>
                                    </td>
                                    <td class="contenedorEntrada">
                                        <input type="text" name="dniPasaporteRucNombresCBuscar" id="dniPasaporteRucNombresCBuscar" value="" class="anchoTotal entrada mayuscula"/>
                                    </td>
                                </tr>
                            </tbody>
                        </table>
                        <label id="lMensajeBuscarCliente" style="color: red; font-size: 10px;"></label>
                    </div>                    
                    <div id="d_interesEvitar_editar" style="padding: 20px;" title="Buscar">
                        <table class="reporte-tabla-1 anchoTotal">
                            <thead>
                                <tr>
                                    <th>Fecha donde no se cobrará intereses.</th>
                                </tr>
                            </thead>
                            <tr>
                                <td class="contenedorEntrada">
                                    <input type="text" name="fechaEvitar" id="fechaEvitar" value="" class="anchoTotal entrada fechaEntrada"/>
                                </td>
                            </tr>
                        </table>
                    </div>
                    <!--fin dialog's-->
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