<%-- 
    Document   : compraImprimir
    Created on : 01/04/2013, 07:31:53 PM
    Author     : Henrri
--%>

<%@page import="java.util.Iterator"%>
<%@page import="tablas.CompraSerieNumero"%>
<%@page import="otros.cNumeroLetra"%>
<%@page import="tablas.CompraDetalle"%>
<%@page import="compraClases.cCompraDetalle"%>
<%@page import="java.util.List"%>
<%@page import="otros.cUtilitarios"%>
<%@page import="tablas.Compra"%>
<%@page import="compraClases.cCompra"%>
<%
    String codCompra = request.getParameter("codCompra");
    if (codCompra != null) {
        cUtilitarios objcUtilitarios = new cUtilitarios();
        cNumeroLetra objcNumeroLetra = new cNumeroLetra();
%>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <title><%=objcUtilitarios.fechaHoraActualNumerosLineal()%></title>
        <link rel="stylesheet" type="text/css" href="../lib/propios/css/paginaImprimir/bodyPrint.css" media="screen"/>
        <link rel="stylesheet" type="text/css" href="../lib/propios/css/paginaImprimir/bodyPrint.css" media="print"/>
        <script type="text/javascript" src="../lib/jquery/jquery-1.8.1.min.js"></script>
        <script>
            $(document).ready(function() {
                window.print();
            });
        </script>
    </head>
    <body>        
        <div id="documento">
            <div id="contenido">
                <%
                    cCompra objcCompra = new cCompra();
                    Compra objCompra = objcCompra.leer_cod(Integer.parseInt(codCompra));
                    if (objCompra != null) {

                %>
                <table class="tabla-imprimir" >
                    <thead>
                        <tr class="bottom2">
                            <th colspan="6" style="text-align: center;"><label style="font-weight: bold;">D E T A L L E &nbsp;&nbsp;&nbsp;&nbsp;D E &nbsp;&nbsp;&nbsp;&nbsp;C O M P R A</label></th>
                        </tr>
                    </thead>
                    <tbody>
                        <tr>
                            <th style="width: 14%;"><label>Documento</label></th>
                            <td style="width: 19%;">
                                <label id="lDocSerieNumero"><%=objCompra.getDocSerieNumero()%></label>
                                <input type="hidden" name="codCompra" id="codCompra" value="<%=objCompra.getCodCompra()%>" />
                            </td>
                            <th style="width: 14%;"><label>Tipo de compra</label></th>
                            <td style="width: 19%;"><label id="lTipo"><%=objCompra.getTipo()%></label></td>
                            <th style="width: 14%;"><label>Moneda</label></th>
                            <td style="width: 20%;"><label id="lMoneda"><%=objCompra.getMoneda()%></label></td>
                        </tr>
                        <tr>
                            <th><label>RUC</label></th>
                            <td><label id="lRuc"><%=objCompra != null ? objCompra.getProveedor().getRuc() : ""%></label></td>
                            <th><label>Razón social</label></th>
                            <td colspan="3"><label id="lRazonSocial"><%=objCompra != null ? objCompra.getProveedor().getRazonSocial() : ""%></label></td>
                        </tr>
                        <tr>
                            <th><label>Dirección</label></th>
                            <td colspan="5"><label id="lDireccion"><%=objCompra != null ? objCompra.getProveedor().getDireccion() : ""%></label></td>
                        </tr>
                        <tr>
                            <th><label>F. Factura</label></th>
                            <td><label id="lFechaFactura"><%=objCompra != null ? objcUtilitarios.fechaDateToString(objCompra.getFechaFactura()) : ""%></label></td>
                            <th><label>F. Vencimiento</label></th>
                            <td><label id="lFechaVencimiento"><%=objCompra != null ? objcUtilitarios.fechaDateToString(objCompra.getFechaVencimiento()) : ""%></label></td>
                            <th><label>F. Llegada</label></th>
                            <td><label id="lFechaLlegada"><%=objCompra != null ? objcUtilitarios.fechaDateToString(objCompra.getFechaLlegada()) : ""%></label></td>
                        </tr>
                        <tr class="bottom2">
                            <th colspan="6" style="text-align: center;"><label style="font-weight: bold;">D E T A L L E &nbsp;&nbsp;&nbsp;&nbsp;D E &nbsp;&nbsp;&nbsp;&nbsp;A R T Í C U L O S &nbsp;&nbsp;&nbsp;&nbsp;C O M P R A D O S</label></th>
                        </tr>
                        <tr>
                            <td colspan="6">
                                <table class="tabla-imprimir">
                                    <thead>
                                        <tr class="bottom2">
                                            <!--<th style="width: 30px;"><label>Item</label></th>-->
                                            <th style="width: 25px;"><label>Cod</label></th>
                                            <th style="width: 28px;"><label>Cant.</label></th>
                                            <th style="width: 55px;"><label>U. Medida</label></th>
                                            <th><label>Descripción</label></th>
                                            <th style="width: 65px;"><label>P. Unitario</label></th>
                                            <th style="width: 65px;"><label>P. Total</label></th>
                                        </tr>
                                    </thead>                                    
                                    <tfoot>
                                        <tr class="top2">
                                            <th colspan="2"><label>Son</label></th>
                                            <td colspan="2" rowspan="2"><label id="lSon"><%=objcNumeroLetra.importeNumeroALetra(String.valueOf(objcUtilitarios.redondearDecimales(objCompra.getNeto(), 2)), true)%></label></td>
                                            <th><label>Sub total</label></th>
                                            <td style="text-align: right;padding-right: 5px;"><label id="lSubTotal"><%=objcUtilitarios.agregarCerosNumeroFormato(objcUtilitarios.redondearDecimales(objCompra.getSubTotal(), 2), 2)%></label></td>
                                        </tr>
                                        <tr>
                                            <td colspan="3"><label></label></td>
                                            <th><label>Descuento</label></th>
                                            <td style="text-align: right;"><label id="lDescuento"></label></td>
                                        </tr>
                                        <tr>
                                            <th colspan="2" rowspan="3"><label>Observaciones</label></th>
                                            <td colspan="2" rowspan="4"><label style="text-align: justify;" id="lObservacion"><%=objCompra.getObservacion().replace("\n", "<br>").replace("\r", "  ").replace("/", " - ")%></label></td>
                                            <th><label>Total</label></th>
                                            <td  style="text-align: right;padding-right: 5px;"><label id="lTotal"><%=objcUtilitarios.agregarCerosNumeroFormato(objcUtilitarios.redondearDecimales(objCompra.getTotal(), 2), 2)%></label></td>
                                        </tr>
                                        <tr>
                                            <!--<td><label></label></td>-->
                                            <th><label>IGV</label></th>
                                            <td style="text-align: right;padding-right: 5px;"><label id="lMontoIgv"><%=objcUtilitarios.agregarCerosNumeroFormato(objCompra.getMontoIgv(), 2)%></label></td>
                                        </tr>
                                        <tr>
                                            <th><label>Neto</label></th>
                                            <td style="text-align: right;padding-right: 5px;"><label id="lNeto"><%=objcUtilitarios.agregarCerosNumeroFormato(objcUtilitarios.redondearDecimales(objCompra.getNeto(), 2), 2)%></label></td>
                                        </tr>
                                    </tfoot>
                                    <tbody>
                                        <%
                                            List lCDList = new cCompraDetalle().leer_compraDetalle_codCompra(objCompra.getCodCompra());
                                            for (Iterator it = lCDList.iterator(); it.hasNext();) {
                                                CompraDetalle objCompraDetalle = (CompraDetalle) it.next();
                                        %>

                                        <tr class="top3">
                                            <!--<td style="text-align: right;padding-right: 5px;"></td>-->
                                            <td><%=objcUtilitarios.agregarCeros_int(objCompraDetalle.getArticuloProducto().getCodArticuloProducto(), 8)%></td>
                                            <td style="text-align: right;padding-right: 5px;"><%=objCompraDetalle.getCantidad()%></td>
                                            <td>Unid.</td>
                                            <td style="padding-left: 8px;"><%=objCompraDetalle.getDescripcion()%></td>
                                            <td style="text-align: right;padding-right: 5px;"><%=objcUtilitarios.agregarCerosNumeroFormato(objcUtilitarios.redondearDecimales(objCompraDetalle.getPrecioUnitario(), 4), 4)%></td>
                                            <td style="text-align: right;padding-right: 5px;"><%=objcUtilitarios.agregarCerosNumeroFormato(objcUtilitarios.redondearDecimales(objCompraDetalle.getPrecioTotal(), 2), 2)%></td>
                                        </tr>
                                        <%
                                            if (objCompraDetalle.getArticuloProducto().getUsarSerieNumero()) {
                                        %>
                                        <tr>
                                            <!--<td></td>-->
                                            <td></td>
                                            <td></td>
                                            <td></td>
                                            <td style="font-size: 10px;">
                                                <div style="padding-left: 20px;">
                                                    <b></b>
                                                    <%
                                                        for (CompraSerieNumero objCompraSerieNumero : objCompraDetalle.getCompraSerieNumeros()) {
                                                            out.print(" - " + objCompraSerieNumero.getSerieNumero().replace("\n", "<br>"));
                                                            if (objCompraSerieNumero.getObservacion().trim() != "") {
                                                                out.print("<br>" + objCompraSerieNumero.getObservacion().replace("\n", "<br>"));
                                                            }
                                                        }
                                                    %>
                                                </div>
                                            </td>
                                        </tr>
                                        <%                                            }
                                            }
                                        %>

                                    </tbody>
                                </table>
                            </td>
                        </tr>
                    </tbody>
                </table>
                <%
                    }
                %>

            </div>
        </div>
    </body>
</html>
<%
    }
%>
