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
        <title></title>
        <!--todos-->
        <script type="text/javascript" src="../librerias/jquery/jquery-1.9.0-min.js" ></script>
        <script type="text/javascript" src="../librerias/jquery/jquery.timer-min.js" ></script>
        <script type="text/javascript" src="../librerias/jquery-ui/jquery-ui-1.10.3.custom/js/jquery-ui-1.10.3.custom.min.js" ></script>
        <link rel="stylesheet" type="text/css" href="../librerias/principal/todos.css" media="all"/>
        <!--cambios-->
        <%@include file="../principal/inclusiones.jsp" %>
        <!--propio-->
        <script type="text/javascript" src="../librerias/persona/cliente/clienteKardex_.js?v14.05.15"></script>
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
                        <a id="b_clienteBuscar" class="boton iconoSoloPequenio search">&nbsp;</a>
                    </h3>
                    <div class="d_variables ocultar">
                        <input type="text" name="codCliente" id="codCliente" value="" />
                    </div>
                    <div class="contenedorGeneral">
                        <div class="divSuperior">
                            <div class="divIzquierdo" style="width: 60%; float: left;">
                                <div>
                                    <table class="tabla9px anchoTotal">
                                        <thead>
                                            <tr>
                                                <th colspan="9" class="centrado"><span>VENTAS</span> <a id="" class="boton iconoSoloPequenio print">&nbsp;</a></th>
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
                                </div>
                                <div class="fondoDivSecundario" style="overflow: auto;height: 150px;">
                                    <table class="tabla9px anchoTotal">
                                        <tbody>

                                        </tbody>
                                        <tfoot class="thFondoTd">
                                            <tr>
                                                <th style="width: 80px;"><span class="esperando">&nbsp;</span></th>
                                                <th style="width: 80px;"><span class="esperando">&nbsp;</span></th>
                                                <th style="width: 60px;"><span class="esperando">&nbsp;</span></th>
                                                <th style="width: 60px;"><span class="esperando">&nbsp;</span></th>
                                                <th style="width: 60px;"><span class="esperando">&nbsp;</span></th>
                                                <th style="width: 60px;"><span class="esperando">&nbsp;</span></th>
                                                <th style="width: 50px;"><span class="esperando">&nbsp;</span></th>
                                                <th style="width: 50px;"><span class="esperando">&nbsp;</span></th>
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
                                                <th colspan="5"><span>RESUMEN DE DEUDA</span> <a id="b_VCLRM" class="boton iconoSoloPequenio print">&nbsp;</a></th>
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
                                </div>
                                <div class="fondoDivSecundario" style="overflow: auto;height: 150px;">
                                    <table class="tabla9px anchoTotal">
                                        <tbody>

                                        </tbody>
                                        <tfoot class="thFondoTd">
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
                                                <th colspan="9"><span>CUOTAS DE PAGOS</span> <a id="" class="boton iconoSoloPequenio print">&nbsp;</a></th>
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
                                    <table class="tabla9px anchoTotal">
                                        <tbody>

                                        </tbody>
                                        <tfoot class="thFondoTd">
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
                                    <table class="tabla11px anchoTotal">
                                        <tbody>
                                            <tr>
                                                <th class="ancho120px derecha">
                                                    <span>TOTAL</span>
                                                </th>
                                                <td class="derecha">
                                                    <span id="lTotal"  style="padding-right: 2px;" class="vaciar"></span><span class="esperando">&nbsp;</span>
                                                </td>
                                                <th class="ancho120px derecha">
                                                    <span>AMORTIZADO</span>
                                                </th>
                                                <td class="derecha">
                                                    <span id="lAmortizado" style="padding-right: 2px;" class="vaciar"></span><span class="esperando">&nbsp;</span>
                                                </td>
                                                <th class="ancho120px derecha">
                                                    <span>SALDO</span>
                                                </th>
                                                <td class="derecha">
                                                    <span id="lSaldo" style="padding-right: 2px;" class="vaciar"></span><span class="esperando">&nbsp;</span>
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
                                                <th style="width: 90px;"><span>Documento</span></th>
                                                <th style="width: 40px;"><span>Cant.</span></th>
                                                <th style="width: 350px;"><span>Producto</span></th>
                                                <th style="width: 70px;"><span>P.U.</span></th>
                                                <th><span>Total</label></th>
                                            </tr>
                                        </thead>
                                    </table>    
                                </div>
                                <div class="fondoDivSecundario" style="overflow: auto; height: 150px;">
                                    <table class="tabla9px anchoTotal">
                                        <tbody>

                                        </tbody>
                                        <tfoot class="thFondoTd">
                                            <tr>
                                                <th style="width: 90px;"><span class="esperando">&nbsp;</span></th>
                                                <th style="width: 40px;"><span class="esperando">&nbsp;</span></th>
                                                <th style="width: 350px;"><span class="esperando">&nbsp;</span></th>
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
                                                <th colspan="4"><span>PAGOS REALIZADOS</span> <a id="" class="boton iconoSoloPequenio print">&nbsp;</a></th>
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
                                    <table class="tabla9px anchoTotal">
                                        <tbody>

                                        </tbody>
                                        <tfoot class="thFondoTd">
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
                                                <th colspan="4"><span>DETALLE RECIBO</span></th>
                                            </tr>
                                        </thead>
                                    </table>
                                </div>
                                <div class="fondoDivSecundario" style="overflow: auto; height: 70px;">
                                    <table class="tabla9px anchoTotal">
                                        <tbody>

                                        </tbody>
                                        <tfoot class="thFondoTd">
                                            <tr>                                                
                                                <th><span class="esperando">&nbsp;</span></th>
                                            </tr>
                                        </tfoot>
                                    </table>
                                </div>
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