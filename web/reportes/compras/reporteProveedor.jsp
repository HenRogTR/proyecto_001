<%-- 
    Document   : reporteProveedor
    Created on : 25/03/2013, 09:41:02 AM
    Author     : Henrri
--%>

<%@page import="java.text.DecimalFormat"%>
<%@page import="tablas.CompraDetalle"%>
<%@page import="tablas.*"%>
<%@page import="compraClases.*"%>
<%@page import="java.util.List"%>
<%@page import="otros.cUtilitarios"%>
<%@page import="java.util.Date"%>
<%
    String codP = request.getParameter("codProveedor");
    /*sea una fecha 09/06/2009 en string es 09 de junio del 2009
     *  pero si eso le hacemos new Date("09/06/2009") nuestra fecha obtenida es 06 de setiembre del 2009, mucho cuidado con ello
     * de manera que la fecha viene con el primer formato
     */
    String fechaI = request.getParameter("fechaInicio");
    String fechaF = request.getParameter("fechaFin");
    if (codP != null & fechaI != null & fechaF != null) {
        Date fechaInicio = new Date(fechaI.substring(3, 5) + "/" + fechaI.substring(0, 3) + "/" + fechaI.substring(5));
        Date fechaFin = new Date(fechaF.substring(3, 5) + "/" + fechaF.substring(0, 3) + "/" + fechaF.substring(5));
        int codProveedor = Integer.parseInt(codP);
        cCompra objcCompra = new cCompra();
        cCompraDetalle objcCompraDetalle = new cCompraDetalle();
        cUtilitarios objcUtilitarios = new cUtilitarios();
%>

<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <title><%=objcUtilitarios.fechaHoraActualNumerosLineal() + " por proveedor "%></title>
        <link rel="stylesheet" type="text/css" href="../../lib/propios/css/paginaImprimir/bodyPrint.css" media="screen"/>
        <link rel="stylesheet" type="text/css" href="../../lib/propios/css/paginaImprimir/bodyPrint.css" media="print"/>
        <script type="text/javascript" src="../../lib/jquery/jquery-1.8.1.min.js"></script>
        <script>
            $(document).ready(function() {
                window.print();
            });
        </script>
    </head>
    <body>
        <div id="documento">            
            <div id="contenido">
                <table style="width: 100%">
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
                            <th style="width: 90px; border-top: 3px solid #000;">Documento</th>
                            <th style="width: 60px; border-top: 3px solid #000;">Tipo</th>
                        </tr>
                    </thead>
                    <thead>
                        <%
                            double totalGeneral = 0;
                            List lCompra = objcCompra.leer_fechaInicio_fechafin_codProveedor_orderByFechaCompra(fechaInicio, fechaFin, codProveedor);
                            for (int i = 0; i < lCompra.size(); i++) {
                                Compra objCompra = (Compra) lCompra.get(i);
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
                            List lCompraDetalle = objcCompraDetalle.leer_compraDetalle_codCompra(objCompra.getCodCompra());
                            for (int j = 0; j < lCompraDetalle.size(); j++) {
                                CompraDetalle objCompraDetalle = (CompraDetalle) lCompraDetalle.get(j);
                        %>
                        <tr>
                            <td style="text-align: right;padding-right: 10px;"><%=objCompraDetalle.getCantidad()%></td>
                            <td><%=objCompraDetalle.getDescripcion()%></td>
                            <td style="text-align: right;"><%=objcUtilitarios.agregarCerosNumeroFormato(objcUtilitarios.redondearDecimales(objCompraDetalle.getPrecioUnitario(), 4), 4)%></td>
                            <td style="text-align: right;"><%=objcUtilitarios.agregarCerosNumeroFormato(objcUtilitarios.redondearDecimales(objCompraDetalle.getPrecioTotal(), 2), 2)%></td>
                        </tr>
                        <%
                            }
                        %>
                        <tr>
                            <th></th>
                            <th></th>                    
                        </tr>
                        <tr>
                            <th></th>
                            <th></th>
                            <th  style="border-top: 1px solid #000; ">Sub total</th>
                            <th style="text-align: right;border-top: 1px solid #000;"><%=objcUtilitarios.agregarCerosNumeroFormato(objcUtilitarios.redondearDecimales(objCompra.getNeto(), 2), 2)%></th>
                            <th style="border-top: 1px solid #000; "></th>
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
                    </thead>
                </table>
            </div>
        </div>
    </body>
</html>
<%    }
%>