<%-- 
    Document   : reporteArticuloConStockFamilia
    Created on : 17/04/2013, 10:48:59 AM
    Author     : Henrri
--%>

<%@page import="tablas.CompraDetalle"%>
<%@page import="articuloProductoClases.cFamilia"%>
<%@page import="tablas.Familia"%>
<%@page import="tablas.PrecioVenta"%>
<%@page import="tablas.KardexArticuloProducto"%>
<%@page import="tablas.ArticuloProducto"%>
<%@page import="java.util.List"%>
<%@page import="articuloProductoClases.cKardexArticuloProducto"%>
<%@page import="articuloProductoClases.cPrecioVenta"%>
<%@page import="articuloProductoClases.cArticuloProducto"%>
<%@page import="otros.cUtilitarios"%>
<%
    cUtilitarios objcUtilitarios = new cUtilitarios();
    cArticuloProducto objcArticuloProducto = new cArticuloProducto();
%>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <title><%=objcUtilitarios.fechaHoraActualNumerosLineal()%></title>
        <link rel="stylesheet" type="text/css" href="../../lib/propios/css/paginaImprimir/bodyPrint.css" media="screen"/>
        <link rel="stylesheet" type="text/css" href="../../lib/propios/css/paginaImprimir/bodyPrint.css" media="print"/>
        <script type="text/javascript" src="../../lib/jquery/jquery-1.8.1.min.js"></script>
        <script>
            $(document).ready(function() {
//                window.print();
            });
        </script>
    </head>
    <body>
        <%
            String orden = request.getParameter("orden");
            String pCompra = request.getParameter("pCompra");
            String pVenta = request.getParameter("pVenta");
            String codFamilia = request.getParameter("codFamilia");

            Familia objFamilia = new cFamilia().leer_cod(Integer.parseInt(codFamilia));
            List lArticuloProducto = orden.equals("articuloAlfabetico") ? objcArticuloProducto.leer_familia_orderByDescripcion(Integer.parseInt(codFamilia)) : objcArticuloProducto.leer_familia(Integer.parseInt(codFamilia));
            String ordena = orden.equals("articuloAlfabetico") ? "Alfabético" : "Normal";

        %>
        <div id="documento">
            <div id="contenido">
                <table class="tabla-imprimir">
                    <thead>
                        <tr>
                            <th colspan="2">Artículos con estock (<%=ordena%>)</th>
                        </tr>
                        <tr class="top3 bottom2">
                            <th style="width: 80px;"><label>Cod.</label></th>
                            <th><label>Descripción</label></th>
                                <%
                                    if (pCompra != null) {
                                %>
                            <th style="width: 80px;"><label>P. Compra</label></th>
                                <%                                    }
                                    if (pVenta != null) {
                                %>
                            <th style="width: 80px;"><label>P. Venta</label></th>
                                <%                                            }
                                %>
                            <th style="width: 80px;"><label>Stock actual</label></th>
                        </tr>
                    </thead>
                    <tbody>
                        <%
                            for (int i = 0; i < lArticuloProducto.size(); i++) {
                                ArticuloProducto objArticuloProducto = (ArticuloProducto) lArticuloProducto.get(i);
                                KardexArticuloProducto objKardexArticuloProducto = new KardexArticuloProducto();
//                                out.print(objKardexArticuloProducto.getStock());
                                int a = 0;
                                for (KardexArticuloProducto objKardexArticuloProducto1 : objArticuloProducto.getKardexArticuloProductos()) {// para hallar el ultimo kardex
                                    if (a < objKardexArticuloProducto1.getCodKardexArticuloProducto() && objKardexArticuloProducto1.getRegistro().substring(0, 1).equals("1")) {
                                        a = objKardexArticuloProducto1.getCodKardexArticuloProducto();
                                        objKardexArticuloProducto = objKardexArticuloProducto1;
                                    }
                                }
//                                out.print(objKardexArticuloProducto.getStock());
                                if (objKardexArticuloProducto.getStock() > 0) {
                        %>
                        <tr>
                            <td style="text-align: right;padding-right: 15px;"><%=objcUtilitarios.agregarCeros_int(objArticuloProducto.getCodArticuloProducto(), 8)%></td>
                            <td><%=objcUtilitarios.quitar_barrasInvertidasTexto(objArticuloProducto.getDescripcion())%></td>
                            <%
                                if (pCompra != null) {
                                    CompraDetalle objCompraDetalleAux = new CompraDetalle();
                                    int b = 0;
                                    for (CompraDetalle objCompraDetalle : objArticuloProducto.getCompraDetalles()) {
                                        if (objCompraDetalle.getCodCompraDetalle() > b) {
                                            objCompraDetalleAux = objCompraDetalle;
                                        }
                                    }
                            %>
                            <td style="text-align: right;padding-right: 8px;"><%=objCompraDetalleAux.getPrecioUnitario()==null?"0.0000":objcUtilitarios.agregarCerosNumeroFormato(objCompraDetalleAux.getPrecioUnitario(), 4) %></td>
                            <%                                }
                                if (pVenta != null) {
                            %>
                            <td style="text-align: right;padding-right: 8px;"><%=objcUtilitarios.agregarCerosNumeroFormato(objArticuloProducto.getPrecioVenta(), 2) %></td>
                            <%
                                }
                            %>
                            <td style="text-align: right;padding-right: 8px;"><%=objKardexArticuloProducto != null ? objKardexArticuloProducto.getStock() : "0"%></td>
                        </tr>
                        <%

                                }
                            }
                        %>
                    </tbody>
                </table>
            </div>
        </div>
    </body>
</html>
