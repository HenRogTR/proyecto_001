<%-- 
    Document   : imprimirCronograma
    Created on : 13/05/2013, 10:27:48 AM
    Author     : Henrri
--%>



<%@page import="utilitarios.cManejoFechas"%>
<%@page import="utilitarios.cOtros"%>
<%@page import="tablas.Usuario"%>
<%@page import="tablas.VentaCreditoLetra"%>
<%@page import="java.util.Iterator"%>
<%@page import="ventaClases.cVentaCreditoLetra"%>
<%@page import="java.util.ArrayList"%>
<%@page import="java.util.List"%>
<%
    boolean estado = true;
    String mensaje = "";
    int codVenta = 0;
    List lVentaCreditoLetra = new ArrayList();
    cVentaCreditoLetra objcVentaCreditoLetra = new cVentaCreditoLetra();
    try {
        codVenta = Integer.parseInt(request.getParameter("codVenta"));
        lVentaCreditoLetra = objcVentaCreditoLetra.leer_porCodVenta(codVenta);
        if (lVentaCreditoLetra == null) {
            estado = false;
            mensaje = "Error en la consulta: " + objcVentaCreditoLetra.getError() + "<br>";
        } else {
            if (lVentaCreditoLetra.size() == 0) {
                estado = false;
                mensaje = "No hay cronograma de pagos para esta venta, verifique la venta.<br>";
            }
        }

    } catch (NumberFormatException e) {
        estado = false;
        mensaje = "CodVenta erroneo<br>";
    };
    Usuario objUsuario = (Usuario) session.getAttribute("usuario");
    if (objUsuario == null) {
        estado = false;
        mensaje += "Tiene que logearse antes<br>";
    } else {
        if (!objUsuario.getP1() || !objUsuario.getP34()) {
            estado = false;
            mensaje += "No tiene permisos suficientes para acceder a esta pagina<br>";
        }
    }

%>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <title>JSP Page</title>
        <link rel="stylesheet" type="text/css" href="cronogramaImprimir.css" media="print"/>
        <link rel="stylesheet" type="text/css" href="cronogramaImprimir.css" media="screen"/>
        <script type="text/javascript" src="../../librerias/jquery/jquery-1.8.1.min.js"></script>
    </head>
    <body>
        <script>
            $(document).ready(function() {
                if ($('#marca').val() == '1') {
                    print();
                }
                if ($.browser.chrome) {
                    $('#contenido').css('font-size', 14);
                }
                ;
            });
        </script>
        <div id="documento">
            <div id="contenido">
                <%                    if (estado) {
                        cOtros objcOtros = new cOtros();
                        cManejoFechas objcManejoFechas = new cManejoFechas();
                        Iterator iVentaCreditoLetra = lVentaCreditoLetra.iterator();
                        VentaCreditoLetra objVentaCreditoLetra0 = (VentaCreditoLetra) lVentaCreditoLetra.iterator().next();
                        Double pagado = 0.00;
                        Double saldo = 0.00;
                %>
                <input type="hidden" id="marca" value="1"/>
                <table class="tabla-imprimir">
                    <thead>
                        <tr class="bottom2">
                            <th colspan="7"><label>Reporte letras del cliente: <%=objVentaCreditoLetra0.getVentaCredito().getVentas().getPersona().getNombresC()%></label></th>
                        </tr>
                        <tr class="bottom2">
                            <th><label>Doc. Serie N°:</label></th>
                            <th><label>Detalles</label></th>
                            <th><label>F. Vencimiento</label></th>
                            <th><label>Monto S/.</label></th>
                            <th><label>Pagado</label></th>
                            <th><label>F. Pago</label></th>
                            <th><label>Saldo</label></th>
                        </tr>
                        <tr>
                            <td colspan="7">
                                <label><%=objVentaCreditoLetra0.getVentaCredito().getVentas().getDocSerieNumero()%>&nbsp;&nbsp;&nbsp;<%=objcManejoFechas.DateAString(objVentaCreditoLetra0.getVentaCredito().getVentas().getFecha())%></label>
                            </td>
                        </tr>
                    </thead>
                    <tbody>
                        <%
                            while (iVentaCreditoLetra.hasNext()) {
                                VentaCreditoLetra objVentaCreditoLetra = (VentaCreditoLetra) iVentaCreditoLetra.next();
                        %>
                        <tr>
                            <td></td>
                            <td><%=objVentaCreditoLetra.getDetalleLetra()%></td>
                            <td><%=objcManejoFechas.DateAString(objVentaCreditoLetra.getFechaVencimiento())%></td>
                            <td style="text-align: right;padding-right: 10px;"><%=objcOtros.agregarCerosNumeroFormato(objVentaCreditoLetra.getMonto(), 2)%></td>
                            <td style="text-align: right;padding-right: 10px;"><%=objcOtros.agregarCerosNumeroFormato(objVentaCreditoLetra.getTotalPago(), 2)%></td>
                            <td><%=objVentaCreditoLetra.getFechaPago() == null ? "" : objcManejoFechas.DateAString(objVentaCreditoLetra.getFechaPago())%></td>
                            <td style="text-align: right;padding-right: 10px;"><%=objcOtros.agregarCerosNumeroFormato(objcOtros.redondearDecimales(objVentaCreditoLetra.getMonto() - objVentaCreditoLetra.getTotalPago(), 2), 2)%></td>
                        </tr>
                        <%
                                pagado += objVentaCreditoLetra.getTotalPago();
                            }
                        %>
                        <tr class="top2">
                            <th colspan="7"></th>
                        </tr>
                        <tr class="top3">
                            <td></td>
                            <td><label style="font-weight: bold">Total general</label></td>
                            <td></td>
                            <td style="text-align: right;padding-right: 10px;"><%=objcOtros.agregarCerosNumeroFormato(objVentaCreditoLetra0.getVentaCredito().getVentas().getNeto(), 2)%></td>
                            <td style="text-align: right;padding-right: 10px;"><%=objcOtros.agregarCerosNumeroFormato(objcOtros.redondearDecimales(pagado, 2), 2)%></td>
                            <td></td>
                            <td style="text-align: right;padding-right: 10px;"><%=objcOtros.agregarCerosNumeroFormato(objcOtros.redondearDecimales(objVentaCreditoLetra0.getVentaCredito().getVentas().getNeto() - pagado, 2), 2)%></td>
                        </tr>
                    </tbody>
                </table>
                <%                    } else {
                        out.print(mensaje);
                    }
                %>
            </div>
        </div>
    </body>
</html>
