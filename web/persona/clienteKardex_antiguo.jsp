<%-- 
    Document   : clienteKardex
    Created on : 27/11/2012, 10:52:52 AM
    Author     : Henrri
--%>

<%@page import="tablas.Usuario"%>
<%
    Usuario objUsuario = (Usuario) session.getAttribute("usuario");
    if (objUsuario == null) {
        session.removeAttribute("direccion");
        session.setAttribute("direccion", "");
        response.sendRedirect("../");
    } else {
%>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <title>Kardex de clientes</title>
        <!--stilo inicio-->
        <link rel="stylesheet" type="text/css" href="../lib/propios/css/inicio/style.css"/>
        <!--js query-->
        <script type="text/javascript" src="../lib/jquery/jquery-1.8.1.min.js"></script>
        <!--css js ui-->
        <link rel="stylesheet" type="text/css" href="../lib/jquery-ui/jquery-ui-1.10.0.custom/css/smoothness/jquery-ui-1.10.0.custom.min.css">
        <script type="text/javascript" src="../lib/jquery-ui/jquery-ui-1.9.0/jquery-ui-git.js"></script>
        <!--css iconos-->
        <link rel="stylesheet" type="text/css" href="../lib/botones/sexybuttons.css">
        <!--propio pagina-->
        <style>
            .ui-autocomplete {
                width: 400px;
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
        <script type="text/javascript" src="../lib/persona/cliente-kardex.js?v13.09.14"></script>
        <link type="text/css" rel="stylesheet" href="../lib/propios/css/tablas/tablas-reportes.css">
    </head>
    <body>        
        <div id="wrap">
            <div id="header">
                <%@include file="../cabecera.jsp" %>
            </div>
            <div style="margin-top: 5px;">
                <h3 class="titulo">
                    <a href="../index.jsp" class="sexybutton"><span><span><span class="home">Inicio</span></span></span></a>
                    KARDEX DE CLIENTES
                    <button class="sexybutton sexyicononly" id="bClienteBuscar"><span><span><span class="search"></span></span></span></button>
                    <a class="sexybutton" id="bDatosCliente" href="" target="_blank"><span><span><span class="ok">Ver datos del cliente</span></span></span></a>
                </h3>
                <br>
                
                <label id="lNombresC" style="font-size: 16px;font-weight: bold; margin-top: 5px;"></label>
                <!--inicio 1 div superior contenedor-->
                <div>
                    <div style="width: 60%;float: left;">
                        <table class="reporte-tabla-2" style="width: 100%;">
                            <thead>
                                <tr>
                                    <th colspan="9" style="text-align: center;font-size: 14px;"><label>VENTAS</label></th>
                                </tr>
                                <tr>
                                    <th style="width: 80px;background-color: #ff6666"><label>Documento</label></th>
                                    <th style="width: 80px;"><label>Fecha</label></th>
                                    <th style="width: 60px;"><label>Total</label></th>
                                    <th style="width: 60px;"><label>INT %</label></th>
                                    <th style="width: 60px;"><label>Amort.</label></th>
                                    <th style="width: 60px;"><label>Deuda</label></th>
                                    <th style="width: 50px;"><label>N° Letras</label></th>
                                    <th style="width: 50px;"><label>T. Venta</label></th>
                                    <th><label>T. Cambio</label></th>
                                </tr>
                            </thead>
                        </table>
                        <div style="overflow: auto; height: 100px;background-color:#cccccc; ">
                            <table class="reporte-tabla-2" style="width: 100%;">                                
                                <tbody id="ventasCuerpo">
                                </tbody>
                            </table>
                        </div>
                        <div style="background-color: #cccccc; width: 100%;">
                            <table class="reporte-tabla-2" style="float: left;">
                                <tr>
                                    <th style="text-align: center;font-size: 12px;height: 45px; vertical-align: middle;"><label>DETALLE</label></th>
                                </tr>
                            </table>
                            <div style="overflow: auto;border: 1px solid #3366ff; height: 47px;" id="dVentasDetalle">
                                <table id="tVentasDetalle">                                    
                                </table>
                            </div>
                        </div>
                    </div>
                    <div style="width:39%; margin-left: 6px; float: left">
                        <table class="reporte-tabla-2" style="width: 100%;">
                            <tr>
                                <th style="text-align: center;font-size: 12px;" colspan="5">
                                    <label>RESUMEN DE PAGOS</label>
                                    <a class="sexybutton sexysimple sexysmall sexypropio" href="#" id="bResumenPagosImprimir"><span class="print">Imprimir</span></a>
                                </th>
                            </tr>
                            <tr>
                                <th style="width: 70px;"><label>Mes/Año</label></th>
                                <th style="width: 70px;"><label>Monto</label></th>
                                <th style="width: 70px;"><label>Inter.</label></th>
                                <th style="width: 70px;"><label>M. Pago</label></th>
                                <th><label>Saldo</label></th>
                            </tr>
                        </table>
                        <div style="overflow: auto;height: 150px; background-color:#cccccc; ">
                            <table class="reporte-tabla-2" id="tResumenPagos" style="width: 100%;">                                
                                <!--                                <tr>
                                                                    <td style="width: 70px;">Mar-13</td>
                                                                    <td style="width: 70px;text-align: right;">145.12</td>
                                                                    <td style="width: 70px;text-align: right;">0.00</td>
                                                                    <td style="width: 70px;text-align: right;">145.12</td>
                                                                    <td style="text-align: right;">145.33</td>
                                                                </tr>-->
                            </table>
                        </div>
                    </div>
                </div>
                <div style="clear: both;"></div>
                <!--fin 1 div superior contenedor-->
                <!--<div style="clear: both;"></div>-->
                <!--inicio 2 div superior contenedor-->
                <div style="margin-top: 5px;">
                    <div style="width: 65%;float: left;height: 100px;">
                        <table style="width: 100%;" class="reporte-tabla-2">
                            <thead>
                                <tr>
                                    <th colspan="9" style="font-size: 12px;text-align: center;"><label>LETRAS POR COBRAR</label></th>
                                </tr>
                                <tr>
                                    <th style="width: 90px;"><label>Documento</label></th>
                                    <th style="width: 90px;"><label>Detalle</label></th>
                                    <th style="width: 70px;"><label>F. Vencimiento</label></th>
                                    <th style="width: 60px;"><label>Cuota</label></th>
                                    <th style="width: 60px;"><label>Pagado</label></th>
                                    <th style="width: 70px;"><label>F. Pago</label></th>
                                    <th style="width: 40px;"><label>Días A.</label></th>
                                    <th style="width: 60px;"><label>I(%)</label></th>
                                    <th><label>Saldo</label></th>
                                </tr>
                            </thead>
                        </table>
                        <div style="overflow: auto;height: 150px;background-color:#cccccc;">
                            <table class="reporte-tabla-2" style="width: 100%;">
                                <tbody id="tbVentasCreditoLetras">

                                </tbody>
                            </table>
                        </div>
                        <table style="width: 100%" class="reporte-tabla-2">
                            <thead>
                                <tr>
                                    <th style="width: 80px;">Total</th>
                                    <td style="width: 120px; text-align: right;padding-right: 10px;"><label id="lTotal"></label></td>
                                    <th style="width: 80px;">Amortizado</th>
                                    <td style="width: 120px; text-align: right;padding-right: 10px;"><label id="lAmortizado"></label></td>
                                    <th style="width: 80px;">Saldo</th>
                                    <td style="text-align: right;padding-right: 10px;"><label id="lSaldo"></label></td>
                                </tr>
                            </thead>
                        </table>
                        <table style="width: 100%; margin-top: 5px;" class="reporte-tabla-2">
                            <thead>
                                <tr>
                                    <th style="font-size: 12px;text-align: center;" colspan="5"><label>ARTÍCULOS</label></th>
                                </tr>
                                <tr>
                                    <th style="width: 100px;"><label>Documento</label></th>
                                    <th style="width: 40px;"><label>Cant.</label></th>
                                    <th style="width: 370px;"><label>Producto</label></th>
                                    <th style="width: 60px;"><label>P.U.</label></th>
                                    <th><label>Total</label></th>
                                </tr>
                            </thead>
                        </table>
                        <div style="overflow: auto;height: 120px;background-color:#cccccc;">
                            <table class="reporte-tabla-2" style="width: 100%;">
                                <tbody id="tbVentasDetalle">
                                    <!--                                    <tr>
                                                                            <td style="width: 100px;">F-004-000123</td>
                                                                            <td style="width: 40px;text-align: right;">1</td>
                                                                            <td style="width: 370px;">TV LED 32"SONY MOD KDL-32EX340</td>
                                                                            <td style="width: 60px;text-align: right;">136.02</td>
                                                                            <td style="text-align: right;">136.02</td>
                                                                        </tr>-->
                                </tbody>
                            </table>
                        </div>
                    </div>
                    <div style="width: 34%;float: left;margin-left: 5px; height: 370px;">
                        <table style="width: 100%;" class="reporte-tabla-2">
                            <thead>
                                <tr>
                                    <th style="font-size: 12px;text-align: center;" colspan="4"><label>PAGOS REALIZADOS</label></th>
                                </tr>
                                <tr>
                                    <th style="width: 100px;"><label>Documento</label></th>
                                    <th style="width: 70px;"><label>Monto</label></th>
                                    <th style="width: 70px;"><label>Fecha</label></th>
                                    <th><label>Anticipo</label></th>
                                </tr>
                            </thead>
                        </table>
                        <div style="overflow: auto;height: 250px; background-color:#cccccc; ">
                            <table class="reporte-tabla-2" style="width: 100%;" id="tCobranza">
                                <!--                                <tr>
                                                                    <td style="width: 100px;">R-004-001121</td>
                                                                    <td style="width: 70px;text-align: right;">1589.50</td>
                                                                    <td style="width: 70px;">03/05/2013</td>
                                                                    <td style="text-align: right;">0.00</td>
                                                                </tr>-->
                            </table>
                        </div>
                        <table style="width: 100%; margin-top: 5px;" class="reporte-tabla-2">
                            <thead>
                                <tr>
                                    <th style="font-size: 12px; text-align: center;"><label>Detalle de recibo</label></th>
                                </tr>                                
                            </thead>
                        </table>
                        <div style="overflow: auto;height: 56px; background-color:#cccccc; ">
                            <table style="width: 100%;" class="reporte-tabla-2" id="tCobranzaDetalle">
                                <tr>
                                    <td>ANTICIPO</td>
                                </tr>
                            </table>
                        </div>
                    </div>
                </div>

                <!--fin 2 div superior contenedor-->
                <!--dialogos-->     
                <div id="dClienteBuscar" title="Buscar cliente">
                    <table class="reporte-tabla-1">
                        <tbody>
                            <tr>
                                <th style="width: 100px;"><label>Cod Cliente</label></th>
                                <th style="width: 170px;"><label>Dni/Pasaporte - Ruc</label></th>
                                <th style="width: 500px;"><label>Apellidos/Nombres</label></th>
                            </tr>
                            <tr>
                                <td>
                                    <input type="text" name="codPersona" id="codPersona" value="" />
                                </td>
                                <td>
                                    <input type="text" name="dniPasaporteRuc" id="dniPasaporteRuc" value="" style="width: 98%;"/>
                                </td>
                                <td>
                                    <input type="text" name="nombresC" value="" id="nombresC" style="width: 99%;"/>
                                </td>
                            </tr>
                        </tbody>
                    </table>
                    <label id="lMensajeBuscarCliente" style="color: red; font-size: 10px;"></label>
                </div>
                <div id="dDatosCliente" title="Datos del cliente">
                    <table class="reporte-tabla-1">
                        <thead>
                            <tr>
                                <th>Nombres:</th>
                                <td>En construcción</td>
                            </tr>
                        </thead>
                        <tbody>
                            <tr>
                                <td></td>
                            </tr>
                        </tbody>
                    </table>
                </div>
                <div style="clear: both;">
                </div>
                <div id="footer">
                    <%@include file="../piePagina.jsp" %>
                </div>
            </div>
    </body>
</html>
<%    }
%>