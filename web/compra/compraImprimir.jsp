<%-- 
    Document   : compraImprimir
    Created on : 01/04/2013, 07:31:53 PM
    Author     : Henrri
--%>

<%@page import="utilitarios.cOtros"%>
<%@page import="utilitarios.cManejoFechas"%>
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
    int codCompra = 0;
    Compra objCompra = null;
    List CDList = null;
    try {
        codCompra = Integer.parseInt(request.getParameter("codCompra"));
        objCompra = new cCompra().leer_cod(codCompra);
        if (objCompra == null) {
            out.print("Código de compra erroneo.");
            return;
        }
        CDList = new cCompraDetalle().leer_compraDetalle_codCompra(codCompra);
    } catch (Exception e) {
        out.print("Error en parámetros.");
        return;
    }

    cUtilitarios objcUtilitarios = new cUtilitarios();
    cManejoFechas objcManejoFechas = new cManejoFechas();
    cOtros objcOtros = new cOtros();
%>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <title><%=objcUtilitarios.fechaHoraActualNumerosLineal()%></title>
        <link rel="stylesheet" type="text/css" href="../librerias/principal/bodyPrint.css" media="screen"/>
        <link rel="stylesheet" type="text/css" href="../librerias/principal/bodyPrint.css" media="print"/>
    </head>
    <body>        
        <div id="documento">
            <div id="contenido">
                <table class="anchoTotal">
                    <thead>
                        <tr class="bottom2">
                            <th colspan="6" class="centrado"><span class="espaciado5">DETALLE DE COMPRA</span></th>
                        </tr>
                    </thead>
                    <tbody>
                        <tr>
                            <th class="ancho100px"><span>Documento</span></th>
                            <td class="ancho160px"><div><%=objCompra.getDocSerieNumero()%></div></td>
                            <th class="ancho100px"><span>Tipo de compra</span></th>
                            <td class="ancho160px"><div><%=objCompra.getTipo()%></div></td>
                            <th class="ancho100px"><span>Moneda</span></th>
                            <td><div><%=objCompra.getMoneda()%></div></td>
                        </tr>
                        <tr>
                            <th><span>RUC</span></th>
                            <td><div><%=objCompra.getProveedor().getRuc()%></div></td>
                            <th><span>Razón social</span></th>
                            <td colspan="3"><div><%=objCompra.getProveedor().getRazonSocial()%></div></td>
                        </tr>
                        <tr>
                            <th><span>Dirección</span></th>
                            <td colspan="5"><div><%=objCompra.getProveedor().getDireccion()%></div></td>
                        </tr>
                        <tr>
                            <th><span>F. Factura</span></th>
                            <td><div><%=objcManejoFechas.DateAString(objCompra.getFechaFactura())%></div></td>
                            <th><span>F. Vencimiento</span></th>
                            <td><div><%=objcManejoFechas.DateAString(objCompra.getFechaVencimiento())%></div></td>
                            <th><span>F. Llegada</span></th>
                            <td><div><%=objcManejoFechas.DateAString(objCompra.getFechaLlegada())%></div></td>
                        </tr>
                    </tbody>
                </table>
                <div style="padding: 5px;">
                    <table class="anchoTotal">
                        <thead>
                            <tr>
                                <th colspan="6" class="centrado"><span class="espaciado5">DETALLE DE ARTÍCULOS COMPRADOS</span></th>
                            </tr>
                            <tr class="top2 bottom2">
                                <th style="width: 60px;"><span>Código</span></th>
                                <th style="width: 40px;"><span>Cant.</span></th>
                                <th style="width: 60px;"><span>U. Medida</span></th>
                                <th><span>Descripción</span></th>
                                <th style="width: 75px;"><span>P. Unitario</span></th>
                                <th style="width: 75px;"><span>P. Total</span></th>
                            </tr>
                        </thead>
                        <tfoot>
                            <tr class="top2">
                                <th class="derecha"><span>Son</span></th>
                                <th></th>
                                <td colspan="2" rowspan="2"><div ><%=objCompra.getSon()%></div></td>
                                <th><span>Sub total</span></th>
                                <td class="derecha"><div style="margin-right: 5px;"><%=objcOtros.agregarCerosNumeroFormato(objCompra.getSubTotal(), 2)%></div></td>
                            </tr>
                            <tr>
                                <td colspan="3"></td>
                                <th><span>Descuento</span></th>
                                <td class="derecha"><div></div></td>
                            </tr>
                            <tr>
                                <th colspan="2" rowspan="3"><span>Observaciones</span></th>
                                <td colspan="2" rowspan="4"><div style="text-align: justify;"><%=objcOtros.replace_comillas_comillasD_barraInvertida(objCompra.getObservacion())%></div></td>
                                <th><span>Total</span></th>
                                <td class="derecha"><div style="margin-right: 5px;"><%=objcOtros.agregarCerosNumeroFormato(objCompra.getTotal(), 2)%></div></td>
                            </tr>
                            <tr>
                                <th><span>IGV</span></th>
                                <td class="derecha"><div style="margin-right: 5px;"><%=objcOtros.agregarCerosNumeroFormato(objCompra.getMontoIgv(), 2)%></div></td>
                            </tr>
                            <tr>
                                <th><span>Neto</span></th>
                                <td class="derecha"><div style="margin-right: 5px;"><%=objcOtros.agregarCerosNumeroFormato(objCompra.getNeto(), 2)%></div></td>
                            </tr>
                        </tfoot>
                        <tbody>
                            <%
                                for (Iterator it = CDList.iterator(); it.hasNext();) {
                                    CompraDetalle objCD = (CompraDetalle) it.next();
                            %>
                            <tr>
                                <td><div><%=objcOtros.agregarCeros_int(objCD.getArticuloProducto().getCodArticuloProducto(), 8)%></div></td>
                                <td class="derecha"><div><%=objCD.getCantidad()%></div></td>
                                <td class="derecha"><div style="margin-right: 3px;"><%=objCD.getArticuloProducto().getUnidadMedida()%></div></td>
                                <td class="izquierda">
                                    <div style="margin-left: 3px;"><%=objCD.getDescripcion()%></div>
                                    <div style="margin-left: 10px; font-size: 11px;">
                                        <%
                                            int cont = 0;
                                            for (CompraSerieNumero objCSN : objCD.getCompraSerieNumeros()) {
                                                if (cont++ > 0) {
                                                    out.print(" \\ ");
                                                }
                                                out.print("<span>");
                                                out.print(objcOtros.replace_comillas_comillasD_barraInvertida(objCSN.getSerieNumero()));
                                                if (!objCSN.getObservacion().equals("")) {
                                                    out.print("<br>" + objcOtros.replace_comillas_comillasD_barraInvertida(objCSN.getObservacion()));
                                                }
                                                out.print("</span>");
                                            }
                                        %>
                                    </div>
                                </td>
                                <td class="derecha"><div style="margin-right: 5px;"><%=objcOtros.agregarCerosNumeroFormato(objCD.getPrecioUnitario(), 2)%></div></td>
                                <td class="derecha"><div style="margin-right: 5px;"><%=objcOtros.agregarCerosNumeroFormato(objCD.getPrecioTotal(), 2)%></div></td>
                            </tr>
                            <%
                                }
                            %>
                        </tbody>
                    </table>
                </div>
            </div>
        </div>
    </body>
</html>
