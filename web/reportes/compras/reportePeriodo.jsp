<%-- 
    Document   : reportePeriodo
    Created on : 20/03/2013, 11:16:23 AM
    Author     : Henrri
--%>

<%@page import="tablas.CompraSerieNumero"%>
<%@page import="java.util.Iterator"%>
<%@page import="tablas.ArticuloProducto"%>
<%@page import="articuloProductoClases.cArticuloProducto"%>
<%@page import="java.io.FileOutputStream"%>
<%@page import="tablas.CompraDetalle"%>
<%@page import="compraClases.cCompraDetalle"%>
<%@page import="tablas.Compra"%>
<%@page import="otros.cUtilitarios"%>
<%@page import="java.util.List"%>
<%@page import="compraClases.cCompra"%>
<%@page import="java.util.Date"%>
<%
    String tipoReporte = request.getParameter("tipoReporte");
    /*sea una fecha 09/06/2009 en string es 09 de junio del 2009
     *  pero si eso le hacemos new Date("09/06/2009") nuestra fecha obtenida es 06 de setiembre del 2009, mucho cuidado con ello
     * de manera que la fecha viene con el primer formato
     */
    String fechaI = request.getParameter("fechaInicio");
    String fechaF = request.getParameter("fechaFin");
    if (tipoReporte != null & fechaI != null & fechaF != null) {
        Date fechaInicio = new Date(fechaI.substring(3, 5) + "/" + fechaI.substring(0, 3) + "/" + fechaI.substring(5));
        Date fechaFin = new Date(fechaF.substring(3, 5) + "/" + fechaF.substring(0, 3) + "/" + fechaF.substring(5));

        cArticuloProducto objcArticuloProducto = new cArticuloProducto();
        cCompra objcCompra = new cCompra();
        cUtilitarios objcUtilitarios = new cUtilitarios();

%>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <title><%=objcUtilitarios.fechaHoraActualNumerosLineal() + " reporte por " + tipoReporte%></title>
        <link rel="stylesheet" type="text/css" href="../../lib/propios/css/tablas/tablas-reportes.css" media="screen" />
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
        <div id="documento">
            <div id="contenido">
                <%
                    if (tipoReporte.equals("documento")) {
                %>
                <table style="width: 100%;">
                    <thead>                    
                        <tr>
                            <th colspan="2" style="text-align: left;">
                                Registro de compras // Periodo <%=fechaI + " a " + fechaF%>
                            </th>
                            <th colspan="3" style="font-size: 10px;text-align: left;">
                                <%=objcUtilitarios.fechaHoraActual() + " horas"%>
                            </th>
                        </tr>
                        <tr>
                            <th style="width: 70px; border-top: 3px solid #000;">Proveedor</th>
                            <th style="border-top: 3px solid #000;"></th>
                            <th style="width: 80px; border-top: 3px solid #000;">Fecha</th>
                            <th style="width: 100px; border-top: 3px solid #000;">Documento</th>
                            <th style="width: 60px; border-top: 3px solid #000;">Tipo</th>
                        </tr>
                    </thead>
                    <tbody>
                        <%
                            List lCompra = objcCompra.leer_fechaInicio_fechafin_orderByFechaCompra(fechaInicio, fechaFin);  //listamos todas las compras hechas en un periodo dado
                            Iterator iCompra = lCompra.iterator();
                            double totalGeneral = 0;
                            while (iCompra.hasNext()) {
                                Compra objCompra = (Compra) iCompra.next();
                                totalGeneral += objCompra.getNeto();
                        %>
                        <tr>
                            <td colspan="5">
                                <br>
                            </td>
                        </tr>
                        <tr style="font-weight: bold;">
                            <td style="border-top: 1px solid #000;">
                                <%=objCompra.getProveedor().getRuc()%>
                            </td>
                            <td style="border-top: 1px solid #000;">
                                <%=objCompra.getProveedor().getRazonSocial()%>
                            </td>
                            <td style="border-top: 1px solid #000;">
                                <%=objcUtilitarios.fechaDateToString(objCompra.getFechaFactura())%>
                            </td>
                            <td style="border-top: 1px solid #000;text-align: center;">
                                <%=objCompra.getDocSerieNumero()%>
                            </td>
                            <td style="border-top: 1px solid #000;text-align: center;">
                                <%=objCompra.getTipo()%>
                            </td>
                        </tr>
                        <%
                            for (CompraDetalle objCompraDetalle : objCompra.getCompraDetalles()) {

                        %>
                        <tr>
                            <td style="text-align: right;padding-right: 10px;"><%=objCompraDetalle.getCantidad()%></td>
                            <td>
                                <%=objCompraDetalle.getArticuloProducto().getCodArticuloProducto()%>
                                <%=objCompraDetalle.getDescripcion()%>
                            </td>
                            <td style="text-align: right;"><%=objcUtilitarios.agregarCerosNumeroFormato(objcUtilitarios.redondearDecimales(objCompraDetalle.getPrecioUnitario(), 4), 4)%></td>
                            <td style="text-align: right;"><%=objcUtilitarios.agregarCerosNumeroFormato(objcUtilitarios.redondearDecimales(objCompraDetalle.getPrecioTotal(), 2), 2)%></td>
                        </tr>
                        <%
                            if (objCompraDetalle.getArticuloProducto().getUsarSerieNumero()) {
                        %>
                        <tr>
                            <td></td>
                            <td style="font-size: 10px;">
                                <b>S/N:</b>
                                <%
                                    for (CompraSerieNumero objCompraSerieNumero : objCompraDetalle.getCompraSerieNumeros()) {
                                        out.print(" - " + objCompraSerieNumero.getSerieNumero());
                                        if (objCompraSerieNumero.getObservacion() != null) {
                                            if (objCompraSerieNumero.getObservacion().trim() != "") {
                                                out.print("<br>" + objCompraSerieNumero.getObservacion().replace("\n", "<br>"));
                                            }
                                        }
                                    }
                                %>
                            </td>
                        </tr>
                        <%                                            }
                            }
                        %>
                        <tr>
                            <th></th>
                            <th></th>                    
                        </tr>
                        <tr>
                            <th style="text-align: right">Obs:</th>
                            <th></th>
                            <th  style="border-top: 1px solid #000; ">Sub total</th>
                            <th style="text-align: right;border-top: 1px solid #000;"><%=objcUtilitarios.agregarCerosNumeroFormato(objcUtilitarios.redondearDecimales(objCompra.getNeto(), 2), 2)%></th>
                            <th style="border-top: 1px solid #000; "></th>
                        </tr>                        
                        <tr>
                            <th></th>
                            <td><%=objCompra.getObservacion().replace("\n", "<br>").replace("\r", "  ").replace("-", " - ").replace("/", " - ")%></td>
                        </tr>
                        <%
                            }
                        %>
                        <tr>
                            <td><br><br></td>
                        </tr>
                        <tr>
                            <td></td>
                            <th style="border-top: 2px solid #000;text-align: right;padding-right: 20px;">TOTAL GENERAL</th>
                            <th style="border-top: 2px solid #000;"><%=objcUtilitarios.agregarCerosNumeroFormato(objcUtilitarios.redondearDecimales(totalGeneral, 2), 2)%></th>
                            <td style="border-top: 2px solid #000;"></td>
                            <td></td>
                        </tr>
                    </tbody>
                </table>
                <%
                } else {
                %>
                <table style="width: 100%;">
                    <thead>
                        <tr style="font-weight: bold;">
                            <td colspan="3">
                                REGISTRO DE COMPRAS x PRODUCTOS // Periodo <%=fechaI + " a " + fechaF%>
                            </td>
                            <td colspan="2" style="font-size: 10px;">
                                <%=objcUtilitarios.fechaHoraActual() + " horas"%>
                            </td>
                        </tr>
                        <tr>
                            <th style="width: 60px; border-top: 3px solid #000;">Código</th>
                            <th style="width: 40px; border-top: 3px solid #000;">Artículo</th>
                            <th style="border-top: 3px solid #000;"></th>
                            <th style="width: 150px ;border-top: 3px solid #000;">Fecha de compra</th>
                            <th style="width: 70px; border-top: 3px solid #000;">Cantidad</th>
                        </tr>
                    </thead>
                    <tbody>
                        <%
                            double totalGeneral = 0;
                            List lArticuloProducto = objcArticuloProducto.leer();
                            Iterator iArticuloProducto = lArticuloProducto.iterator();
                            while (iArticuloProducto.hasNext()) {
                                ArticuloProducto objArticuloProducto = (ArticuloProducto) iArticuloProducto.next();
                        %>
                        <tr>
                            <td>
                                <br>
                            </td>
                        </tr>
                        <tr>
                            <td style="border-top: 1px solid #000;font-weight: bold;text-align: right;padding-right: 10px;"><%=objcUtilitarios.agregarCeros_int(objArticuloProducto.getCodArticuloProducto(), 8)%></td>
                            <th colspan="4" style="border-top: 1px solid #000"><%=objArticuloProducto.getDescripcion()%></th>
                        </tr>
                        <%
                            for (CompraDetalle objCompraDetalle : objArticuloProducto.getCompraDetalles()) {
                                if (objCompraDetalle.getCompra().getFechaFactura().before(fechaInicio) || objCompraDetalle.getCompra().getFechaFactura().after(fechaFin)) {
                                    break;
                                }
                                totalGeneral += objCompraDetalle.getPrecioTotal();
                        %>
                        <tr>
                            <td></td>
                            <td></td>
                            <td style="padding-left: 100px;">Doc: <%=objCompraDetalle.getCompra().getDocSerieNumero()%></td>
                            <td><%=objcUtilitarios.fechaDateToString(objCompraDetalle.getCompra().getFechaFactura())%></td>
                            <td style="text-align: right;padding-right: 15px;"><%=objCompraDetalle.getCantidad()%></td>
                        </tr>
                        <%
                                }

                            }
                        %>
                        <tr>
                            <td colspan="5">
                                <br><br>
                            </td>
                        </tr>
                        <tr>
                            <td></td>
                            <td></td>
                            <th style="border-top: 2px solid #000;text-align: right;padding-right: 20px;">TOTAL GENERAL</th>
                            <th style="border-top: 2px solid #000;"><%=objcUtilitarios.agregarCerosNumeroFormato(objcUtilitarios.redondearDecimales(totalGeneral, 2), 2)%></th>
                            <td></td>
                        </tr>
                    </tbody>
                </table>

                <%            }

                %>
            </div>
        </div>
    </body>
</html>
<%

} else {
%>
<script>
//    alert("Sin datos, se cerrará la ventana.");
    window.close();
</script>
<%    }
%>
