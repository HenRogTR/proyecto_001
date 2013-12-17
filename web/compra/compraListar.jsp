<%-- 
    Document   : compraListar
    Created on : 28/02/2013, 03:29:36 PM
    Author     : Henrri
--%>

<%@page import="otros.cUtilitarios"%>
<%@page import="tablas.Compra"%>
<%@page import="compraClases.cCompra"%>
<%@page import="tablas.Usuario"%>
<%
    Usuario objUsuario = (Usuario) session.getAttribute("usuario");
    if (objUsuario == null) {
        session.removeAttribute("direccion");
        session.setAttribute("direccion", "compra/compraListar.jsp");
        response.sendRedirect("../");
    } else {
%>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <title>Compras</title>
        <!--stilo inicio-->
        <link rel="stylesheet" type="text/css" href="../lib/propios/css/inicio/style.css" />
        <!--js query-->
        <script type="text/javascript" src="../lib/jquery/jquery-1.8.1.min.js"></script>
        <!--css js ui-->
        <link rel="stylesheet" type="text/css" href="../lib/jquery-ui/jquery-ui-1.10.0.custom/css/smoothness/jquery-ui-1.10.0.custom.min.css">
        <script type="text/javascript" src="../lib/jquery-ui/jquery-ui-1.9.0/jquery-ui-git.js"></script>
        <!--css botones-->        
        <link rel="stylesheet" type="text/css" href="../lib/botones/sexybuttons.css">
        <!--inicio propios -->
        <link rel="stylesheet" type="text/css" href="../lib/propios/css/tablas/tablas-reportes.css">
        <script type="text/javascript" src="../lib/compra/comprasListar.js?v13.08.06"></script>
        <script type="text/javascript" src="../lib/jquerynumeric/jquery.numeric.js"></script>
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
    </head>
    <body>        
        <div id="wrap">
            <div id="header">
                <%@include file="../cabecera.jsp" %>
            </div>
            <div id="left"> 
                <%@include file="../menu2.jsp" %>
            </div>
            <div id="right">
                <%
                    int codCompra = 0;
                    try {
                        codCompra = (Integer) session.getAttribute("codCompraMantenimiento");
                    } catch (Exception e) {
                    }
                %>
                <h3 class="titulo">CENTRO DE COMPRAS &nbsp; <a href="../sCompra?accionCompra=r" class="sexybutton"><span><span><span class="add">Nueva compra</span></span></span></a></h3>
                <div style="margin-top: 10px;">
                    Buscar: <input type="number" name="codCompraBuscar" id="codCompraBuscar" style="width: 100px; text-align: right;"/> 
                    <input type="text" id="compraDocNumeroSerieBuscar" name="compraDocNumeroSerieBuscar" style="width: 150px" placeholder="Documento"/>
                    <input type="hidden" name="codCompraBuscarAux" id="codCompraBuscarAux" value="<%=codCompra%>" />
                </div>
                <table class="reporte-tabla-1" style="font-size: 12px; margin-top: 10px;">
                    <thead>
                        <tr>
                            <th colspan="6" style="text-align: right;font-size: 14px;">
                                <label class="tituloEspaciado" style="float: left; margin-left: 30px;">CENTRO DE COMPRAS OP:<label id="lCodCompra" style="letter-spacing: 0px;"></label></label> 
                                <input type="hidden" name="codCompra" id="codCompra" value="" />
                                <button class="sexybutton" id="bPrimero"><span><span><span class="first">Primero</span></span></span></button>
                                <button class="sexybutton" id="bAnterior"><span><span><span class="prev">Anterior</span></span></span></button>
                                <button class="sexybutton" id="bSiguiente"><span><span><span class="next">Siguiente</span></span></span></button>
                                <button class="sexybutton" id="bUltimo"><span><span><span class="last">Último</span></span></span></button>
                            </th>
                        </tr>
                    </thead>
                    <tfoot>
                        <tr>
                            <th colspan="6" style="text-align: center;">
                                <a class="sexybutton" id="imprimir"><span><span><span class="print">Imprimir</span></span></span></a>
                                <a class="sexybutton"><span><span><span class="edit">Modificar</span></span></span></a>
                                <a class="sexybutton"><span><span><span class="delete">Anular</span></span></span></a>
                            </th>
                        </tr>
                    </tfoot>
                    <tbody>
                        <tr>
                            <th style="width: 100px;">Documento</th>
                            <td style="width: 160px;">
                                <label id="lDocSerieNumero"></label>
                            </td>
                            <th style="width: 100px;">Tipo de compra</th>
                            <td style="width: 160px;">
                                <label id="lTipo"></label>
                            </td>
                            <th style="width: 100px;">Moneda</th>
                            <td style="width: 160px;">
                                <label id="lMoneda"></label>
                            </td>
                        </tr>
                        <tr>
                            <th><label>RUC</label></th>
                            <td><label id="lRuc"></label></td>
                            <th><label>Razón social</label></th>
                            <td colspan="3"><label id="lRazonSocial"></label></td>
                        </tr>
                        <tr>
                            <th><label>Dirección</label></th>
                            <td colspan="5"><label id="lDireccion"></label></td>
                        </tr>
                        <tr>
                            <th><label>F. Factura</label></th>
                            <td><label id="lFechaFactura"></label></td>
                            <th><label>F. Vencimiento</label></th>
                            <td><label id="lFechaVencimiento"></label></td>
                            <th><label>F. Llegada</label></th>
                            <td><label id="lFechaLlegada"></label></td>
                        </tr>
                        <tr>
                            <td colspan="6">
                                <table style="font-size: 10px; width: 100%;" >
                                    <thead>
                                        <tr>
                                            <th style="width: 22px;"><label>Item</label></th>
                                            <th style="width: 28px;"><label>Cant.</label></th>
                                            <th style="width: 55px;"><label>U. Medida</label></th>
                                            <th><label>Descripción</label></th>
                                            <th style="width: 65px;"><label>P. Unitario</label></th>
                                            <th style="width: 65px;"><label>P. Total</label></th>
                                        </tr>
                                    </thead>
                                    <tfoot>
                                        <tr>
                                            <th colspan="2"><label>Son</label></th>
                                            <td colspan="2" rowspan="2"><label id="lSon"></label></td>
                                            <th><label>Sub total</label></th>
                                            <td style="text-align: right;"><label id="lSubTotal"></label></td>
                                        </tr>
                                        <tr>
                                            <td colspan="2"><label></label></td>
                                            <th><label>Descuento</label></th>
                                            <td style="text-align: right;"><label id="lDescuento"></label></td>
                                        </tr>
                                        <tr>
                                            <th colspan="2" rowspan="3">Observa-<br> ciones</th>
                                            <td colspan="2" rowspan="4"><label style="text-align: justify;" id="lObservacion"></label></td>
                                            <th><label>Total</label></th>
                                            <td style="text-align: right;"><label id="lTotal"></label></td>
                                        </tr>
                                        <tr>
                                            <th><label>IGV</label></th>
                                            <td style="text-align: right;"><label id="lMontoIgv"></label></td>
                                        </tr>
                                        <tr>
                                            <th><label>Neto</label></th>
                                            <td style="text-align: right;"><label id="lNeto"></label></td>
                                        </tr>
                                    </tfoot>
                                    <tbody id="tCompraDetalles">                                        
                                    </tbody>
                                </table>
                            </td>
                        </tr>
                    </tbody>
                </table>
            </div>
            <div style="clear: both;"> </div>
            <div id="footer">
                <%@include file="../piePagina.jsp" %>
            </div>
        </div>
    </body>
</html>
<%    }
%>