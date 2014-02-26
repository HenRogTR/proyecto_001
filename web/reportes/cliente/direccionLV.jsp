<%-- 
    Document   : direccionLV
    Created on : 21/02/2014, 10:14:07 AM
    Author     : Henrri
--%>

<%@page import="utilitarios.cOtros"%>
<%@page import="personaClases.cDatosCliente"%>
<%@page import="ventaClases.cVentaCreditoLetraReporte"%>
<%@page import="tablas.VentasDetalle"%>
<%@page import="tablas.VentaCreditoLetra"%>
<%@page import="java.util.Iterator"%>
<%@page import="utilitarios.cManejoFechas"%>
<%@page import="utilitarios.cValidacion"%>
<%@page import="java.util.List"%>
<%
    String fecha = "";
    List LVList = null;
    try {
        fecha = request.getParameter("fechaVencimiento").toString();
        if (!new cValidacion().validarFecha(fecha)) {
            out.print("Fecha y/o formato de fecha incorrecta.");
            return;
        }
        LVList = new cVentaCreditoLetraReporte().letrasVencidas_ordenDireccion(new cManejoFechas().StringADate(fecha));
        if (LVList == null) {
            out.print("Error en consulta lista->null)");
            return;
        }
    } catch (Exception e) {
        out.print("Error en parámetros.");
        return;
    }

    cOtros objcOtros = new cOtros();
    cManejoFechas objcManejoFechas = new cManejoFechas();
%>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <title> letras por cobrar (dirección) <%=fecha%> <%=objcManejoFechas.fechaHoraActualNumerosLineal()%></title>
        <link rel="stylesheet" type="text/css" href="../../librerias/principal/bodyPrint.css" media="screen"/>
        <link rel="stylesheet" type="text/css" href="../../librerias/principal/bodyPrint.css" media="print"/>
    </head>
    <body>
        <div id="documento">
            <div id="contenido">
                <table style="font-size: 11px;" class="anchoTotal">
                    <thead>
                        <tr class="bottom2">
                            <th colspan="8" style="font-size: 14px;">
                                <span>Letras X cobrar (ape/nom) F.V. <%=fecha%> - <%=objcManejoFechas.fechaHoraActual()%></span>
                            </th>
                        </tr>
                        <tr class="bottom1"  style="font-size: 12px;" >
                            <th style="width: 80px;"><span>Número</span></th>
                            <th><span>Nombre/Razón Social</span></th>
                            <th style="width: 60px;"><span>Vencimiento</span></th>
                            <th style="width: 60px;"><span>Monto</span></th>
                            <th style="width: 60px;"><span>Interés</span></th>
                            <th style="width: 60px;"><span>Pagos</span></th>
                            <th style="width: 60px;"><span>Saldo</span></th>
                            <th style="width: 80px;"><span>F. Ultimo Pago</span></th>
                        </tr>
                    </thead>
                    <tbody>
                        <%
                            Integer contPersona = 0;
                            Integer codPersona = 0;
                            Integer contVentas = 0;
                            Integer codVentas = 0;
                            Double totalDedua = 0.00;
                            Integer cont = 1;//------
                            for (Iterator it = LVList.iterator(); it.hasNext();) {
                                VentaCreditoLetra objVentaCreditoLetra = (VentaCreditoLetra) it.next();
                                if (contPersona == 0) {//primera persona de la lista ** siempre se ejecuta
                                    codPersona = objVentaCreditoLetra.getVentaCredito().getVentas().getPersona().getCodPersona();
                        %>
                        <tr style="font-size: 11px;">
                            <td><%=objcOtros.agregarCeros_int(cont, 8)%></td>
                            <td colspan="2">
                                <a href="../../sDatoCliente?accionDatoCliente=mantenimiento&codDatoCliente=<%=new cDatosCliente().leer_codPersona(objVentaCreditoLetra.getVentaCredito().getVentas().getPersona().getCodPersona()).getCodDatosCliente()%>" target="_blank"><%=objVentaCreditoLetra.getVentaCredito().getVentas().getPersona().getNombresC() + (objVentaCreditoLetra.getVentaCredito().getVentas().getPersona().getTelefono1() == null ? "" : (" - ") + objVentaCreditoLetra.getVentaCredito().getVentas().getPersona().getTelefono1()) + (objVentaCreditoLetra.getVentaCredito().getVentas().getPersona().getTelefono2() == null ? "" : (" - ") + objVentaCreditoLetra.getVentaCredito().getVentas().getPersona().getTelefono2())%></a>
                            </td>
                            <td colspan="5"><%=objVentaCreditoLetra.getVentaCredito().getVentas().getPersona().getDireccion()%></td>
                        </tr>
                        <%
                            cont++;
                        } else {
                            if (codPersona != objVentaCreditoLetra.getVentaCredito().getVentas().getPersona().getCodPersona()) {//si la persona es diferente al anterior
                                codPersona = objVentaCreditoLetra.getVentaCredito().getVentas().getPersona().getCodPersona();
                        %>
                        <tr class="bottom1">
                            <th colspan="8"></th>
                        </tr>
                        <tr style="font-size: 11px;">
                            <td><%=objcOtros.agregarCeros_int(cont, 8)%></td>
                            <td colspan="2">
                                <a href="../../sDatoCliente?accionDatoCliente=mantenimiento&codDatoCliente=<%=new cDatosCliente().leer_codPersona(objVentaCreditoLetra.getVentaCredito().getVentas().getPersona().getCodPersona()).getCodDatosCliente()%>" target="_blank"><%=objVentaCreditoLetra.getVentaCredito().getVentas().getPersona().getNombresC() + (objVentaCreditoLetra.getVentaCredito().getVentas().getPersona().getTelefono1() == null ? "" : (" - ") + objVentaCreditoLetra.getVentaCredito().getVentas().getPersona().getTelefono1()) + (objVentaCreditoLetra.getVentaCredito().getVentas().getPersona().getTelefono2() == null ? "" : (" - ") + objVentaCreditoLetra.getVentaCredito().getVentas().getPersona().getTelefono2())%></a>
                            </td>
                            <td colspan="5"><%=objVentaCreditoLetra.getVentaCredito().getVentas().getPersona().getDireccion()%></td>
                        </tr>
                        <%
                                    cont++;
                                }
                            }
                            //detalle de venta
                            if (contVentas == 0) {
                                codVentas = objVentaCreditoLetra.getVentaCredito().getVentas().getCodVentas();
                        %>
                        <tr>
                            <td class="derecha">
                                <div style="padding-right: 5px;"><%=objcManejoFechas.DateAString(objVentaCreditoLetra.getVentaCredito().getVentas().getFecha())%></div>
                            </td>
                            <td colspan="5">
                                <div style="padding-left: 20px;">
                                    <a target="_blank" href="../../sVenta?accionVenta=mantenimiento&codVenta=<%=objVentaCreditoLetra.getVentaCredito().getVentas().getCodVentas()%>"><%=objVentaCreditoLetra.getVentaCredito().getVentas().getDocSerieNumero()%></a> ***
                                    <%
                                        for (VentasDetalle objVentasDetalle : objVentaCreditoLetra.getVentaCredito().getVentas().getVentasDetalles()) {
                                            if (objVentasDetalle.getItem().equals(1)) {
                                                out.print(objVentasDetalle.getDescripcion());
                                            }
                                        }

                                    %>
                                </div>
                            </td>
                            <td>
                                <div style="margin-left: 5px;">N° Item: <%=objVentaCreditoLetra.getVentaCredito().getVentas().getItemCantidad()%></div>
                            </td>
                            <td>
                                <div style="margin-left: 5px;">N° Letras: <%=objVentaCreditoLetra.getVentaCredito().getCantidadLetras()%></div>
                            </td>
                        </tr>
                        <%
                        } else {
                            if (codVentas != objVentaCreditoLetra.getVentaCredito().getVentas().getCodVentas()) {
                                codVentas = objVentaCreditoLetra.getVentaCredito().getVentas().getCodVentas();
                        %>
                        <tr>
                            <td class="derecha">
                                <div style="padding-right: 5px;"><%=objcManejoFechas.DateAString(objVentaCreditoLetra.getVentaCredito().getVentas().getFecha())%></div>
                            </td>
                            <td colspan="5">
                                <div style="padding-left: 20px;">
                                    <a target="_blank" href="../../sVenta?accionVenta=mantenimiento&codVenta=<%=objVentaCreditoLetra.getVentaCredito().getVentas().getCodVentas()%>"><%=objVentaCreditoLetra.getVentaCredito().getVentas().getDocSerieNumero()%></a> ***
                                    <%
                                        for (VentasDetalle objVentasDetalle : objVentaCreditoLetra.getVentaCredito().getVentas().getVentasDetalles()) {
                                            if (objVentasDetalle.getItem().equals(1)) {
                                                out.print(objVentasDetalle.getDescripcion());
                                            }
                                        }

                                    %>
                                </div>
                            </td>
                            <td>
                                <div style="margin-left: 5px;">N° Item: <%=objVentaCreditoLetra.getVentaCredito().getVentas().getItemCantidad()%></div>
                            </td>
                            <td>
                                <div style="margin-left: 5px;">N° Letras: <%=objVentaCreditoLetra.getVentaCredito().getCantidadLetras()%></div>
                            </td>
                        </tr>
                        <%
                                }
                            }
                            Double saldoTemp = objVentaCreditoLetra.getMonto() - objVentaCreditoLetra.getTotalPago();
                            totalDedua += saldoTemp;
                        %>
                        <tr style="font-size: 11px;">
                            <td></td>
                            <td><div style="padding-left: 20px;"><%=objVentaCreditoLetra.getDetalleLetra()%></div></td>
                            <td><%=objcManejoFechas.DateAString(objVentaCreditoLetra.getFechaVencimiento())%></td>
                            <td class="derecha"><div style="padding-right: 5px;"><%=objcOtros.agregarCerosNumeroFormato(objVentaCreditoLetra.getMonto(), 2)%></div></td>
                            <td class="derecha"><div style="padding-right: 5px;"><%=objcOtros.agregarCerosNumeroFormato(objVentaCreditoLetra.getInteres(), 2)%></div></td>
                            <td class="derecha"><div style="padding-right: 5px;"><%=objcOtros.agregarCerosNumeroFormato(objVentaCreditoLetra.getTotalPago(), 2)%></div></td>
                            <td class="derecha"><div style="padding-right: 5px;"><%=objcOtros.agregarCerosNumeroFormato(objcOtros.redondearDecimales(objVentaCreditoLetra.getMonto() - objVentaCreditoLetra.getTotalPago(), 2), 2)%></div></td>
                            <td><%=objVentaCreditoLetra.getFechaPago() == null ? "" : objcManejoFechas.DateAString(objVentaCreditoLetra.getFechaPago())%></td>
                        </tr>
                        <%
                                contPersona++;
                                contVentas++;
                            }
                        %>
                        <tr class="bottom2">
                            <td style="height: 50px;"></td>
                            <td></td>
                            <th colspan="3" style="font-weight: bold; font-size: 14px; vertical-align: bottom;">TOTAL GENERAL</th>
                            <th colspan="2" style="font-weight: bold; font-size: 14px; vertical-align: bottom;" class="derecha">
                                <span style="padding-right: 5px;">
                                    <%=objcOtros.agregarCerosNumeroFormato(objcOtros.redondearDecimales(totalDedua, 2), 2)%>
                                </span>
                            </th>
                            <td></td>
                        </tr>
                    </tbody>
                </table>
            </div>
        </div>
    </body>
</html>