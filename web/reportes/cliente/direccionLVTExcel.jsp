<%-- 
    Document   : nombresCLVTExcel
    Created on : 21/02/2014, 06:26:33 PM
    Author     : Henrri
--%>
<%@page import="ventaClases.cVentaCreditoLetra"%>
<%@page import="java.util.Date"%>
<%@page import="tablas.VentaCreditoLetra"%>
<%@page import="java.util.Iterator"%>
<%@page import="utilitarios.cOtros"%>
<%@page import="ventaClases.cVentaCreditoLetraReporte"%>
<%@page import="utilitarios.cManejoFechas"%>
<%@page import="utilitarios.cValidacion"%>
<%@page import="java.util.List"%>
<%
    String fecha = "";
    Date fechaVencimiento = null;
    List LVList = null;
    try {
        fecha = request.getParameter("fechaVencimiento").toString();
        if (!new cValidacion().validarFecha(fecha)) {
            out.print("Fecha y/o formato de fecha incorrecta.");
            return;
        }
        LVList = new cVentaCreditoLetra().letras_ordenDireccion();
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
    response.setContentType("application/vnd.ms-excel"); //Tipo de fichero.
    response.setHeader("Content-Disposition", "attachment;filename=\"TRAMOS (DIRECCION) " + fecha + " " + objcManejoFechas.fechaHoraActualNumerosLineal() + ".xls\"");
%>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <title>TRAMOS (DIRECCIÓN) <%=fecha%> <%=objcManejoFechas.fechaHoraActualNumerosLineal()%></title>
        <style>
            td,th{
                text-align: left;
                vertical-align: top;
            }
        </style>
    </head>
    <body>
        <table style="font-size: 14px;width: 2000px;">
            <thead>
                <tr class="bottom2">
                    <th colspan="11"><label>Letras X cobrar : Clientes en general (dirección)</label></th>
                </tr>
                <tr class="bottom1" style="font-size: 9px !important;">
                    <th style="width: 100px;"><label>Documento</label></th>
                    <th style="width: 80px;"><label>F. Venta</label></th>
                    <th style="width: 100px;"><label>Dni/Ruc</label></th>
                    <th style=""><label>Ape-Nombres/Razon Social</label></th>
                    <th style="width: 450px;"><label>Dirección</label></th>
                    <th style="width: 70px;"><label>M. Crédito</label></th>
                    <th style="width: 90px;"><label>Deuda Actual</label></th>
                    <th style="width: 90px;"><label>151-mas(Días)</label></th>
                    <th style="width: 90px;"><label>121-150(Días)</label></th>
                    <th style="width: 80px;"><label>91-120(Días)</label></th>                            
                    <th style="width: 70px;"><label>61-90(Días)</label></th>
                    <th style="width: 70px;"><label>31-60(Días)</label></th>
                    <th style="width: 70px;"><label>1-30(Días)</label></th>
                    <th style="width: 70px;"><label>0-30(Días)</label></th>
                    <th style="width: 70px;"><label>31-60(Días)</label></th>
                    <th style="width: 70px;"><label>61-90(Días)</label></th>
                    <th style="width: 90px;"><label>91-más(Días)</label></th>
                </tr>
            </thead>
            <tbody>
                <%
                    Double deudaActual = 0.00, deuda0_30 = 0.00, deuda31_60 = 0.00, deuda61_91 = 0.00, deuda91_mas = 0.00;
                    Double aDeber1_30 = 0.00, aDeber31_60 = 0.00, aDeber61_90 = 0.00, aDeber91_120 = 0.00, aDeber121_150 = 0.00, aDeber151_mas = 0.00;
                    VentaCreditoLetra objVentaCreditoLetraAux = null;
                    fechaVencimiento = objcManejoFechas.StringADate(fecha);

                    for (Iterator it = LVList.iterator(); it.hasNext();) {
                        VentaCreditoLetra objVentaCreditoLetra = (VentaCreditoLetra) it.next();
                        if (objVentaCreditoLetraAux == null) {
                            objVentaCreditoLetraAux = objVentaCreditoLetra;
                            deudaActual += objVentaCreditoLetraAux.getMonto() - objVentaCreditoLetraAux.getTotalPago();
                            if (objVentaCreditoLetraAux.getFechaVencimiento().before(fechaVencimiento)) {//inicio letras vencidas
                                if (objcManejoFechas.StringADate(objcManejoFechas.fechaSumarDias(fechaVencimiento, -31)).before(objVentaCreditoLetraAux.getFechaVencimiento())) {
                                    deuda0_30 += objVentaCreditoLetraAux.getMonto() - objVentaCreditoLetraAux.getTotalPago();
                                } else {
                                    if (objcManejoFechas.StringADate(objcManejoFechas.fechaSumarDias(fechaVencimiento, -61)).before(objVentaCreditoLetraAux.getFechaVencimiento())) {
                                        deuda31_60 += objVentaCreditoLetraAux.getMonto() - objVentaCreditoLetraAux.getTotalPago();
                                    } else {
                                        if (objcManejoFechas.StringADate(objcManejoFechas.fechaSumarDias(fechaVencimiento, -91)).before(objVentaCreditoLetraAux.getFechaVencimiento())) {
                                            deuda61_91 += objVentaCreditoLetraAux.getMonto() - objVentaCreditoLetraAux.getTotalPago();
                                        } else {
                                            deuda91_mas += objVentaCreditoLetraAux.getMonto() - objVentaCreditoLetraAux.getTotalPago();
                                        }
                                    }
                                }
                            } else {//inicio letras vencidas
                                if (objcManejoFechas.StringADate(objcManejoFechas.fechaSumarDias(fechaVencimiento, +30)).after(objVentaCreditoLetraAux.getFechaVencimiento())) {
                                    aDeber1_30 += objVentaCreditoLetraAux.getMonto() - objVentaCreditoLetraAux.getTotalPago();
                                } else {
                                    if (objcManejoFechas.StringADate(objcManejoFechas.fechaSumarDias(fechaVencimiento, +60)).after(objVentaCreditoLetraAux.getFechaVencimiento())) {
                                        aDeber31_60 += objVentaCreditoLetraAux.getMonto() - objVentaCreditoLetraAux.getTotalPago();
                                    } else {
                                        if (objcManejoFechas.StringADate(objcManejoFechas.fechaSumarDias(fechaVencimiento, +90)).after(objVentaCreditoLetraAux.getFechaVencimiento())) {
                                            aDeber61_90 += objVentaCreditoLetraAux.getMonto() - objVentaCreditoLetraAux.getTotalPago();
                                        } else {
                                            if (objcManejoFechas.StringADate(objcManejoFechas.fechaSumarDias(fechaVencimiento, +120)).after(objVentaCreditoLetraAux.getFechaVencimiento())) {
                                                aDeber91_120 += objVentaCreditoLetraAux.getMonto() - objVentaCreditoLetraAux.getTotalPago();
                                            } else {
                                                if (objcManejoFechas.StringADate(objcManejoFechas.fechaSumarDias(fechaVencimiento, +150)).after(objVentaCreditoLetraAux.getFechaVencimiento())) {
                                                    aDeber121_150 += objVentaCreditoLetraAux.getMonto() - objVentaCreditoLetraAux.getTotalPago();
                                                } else {
                                                    aDeber151_mas += objVentaCreditoLetraAux.getMonto() - objVentaCreditoLetraAux.getTotalPago();
                                                }
                                            }
                                        }
                                    }
                                }
                            }
                        } else {
                            if (objVentaCreditoLetraAux.getVentaCredito().getVentas().getCodVentas() != objVentaCreditoLetra.getVentaCredito().getVentas().getCodVentas()) {
                %>
                <tr>
                    <td><%=objVentaCreditoLetraAux.getVentaCredito().getVentas().getDocSerieNumero()%></td>
                    <td><%=objcManejoFechas.DateAString(objVentaCreditoLetraAux.getVentaCredito().getVentas().getFecha())%></td>
                    <td style="text-align: right;mso-number-format:'@'; padding-right: 5px;"><%=objVentaCreditoLetraAux.getVentaCredito().getVentas().getIdentificacion()%></td>
                    <td><%=objVentaCreditoLetraAux.getVentaCredito().getVentas().getCliente()%></td>
                    <td><%=objVentaCreditoLetraAux.getVentaCredito().getVentas().getDireccion()%></td>
                    <td style="text-align: right;mso-number-format:'0.00';"><%=objcOtros.agregarCerosNumeroFormato(objVentaCreditoLetraAux.getVentaCredito().getVentas().getNeto(), 2)%></td>
                    <td style="text-align: right;mso-number-format:'0.00';"><%=objcOtros.agregarCerosNumeroFormato(objcOtros.redondearDecimales(deudaActual, 2), 2)%></td>
                    <td style="text-align: right;mso-number-format:'0.00'; background-color: #00cc33;"><%=objcOtros.agregarCerosNumeroFormato(objcOtros.redondearDecimales(aDeber151_mas, 2), 2)%></td>
                    <td style="text-align: right;mso-number-format:'0.00'; background-color: #00cc33;"><%=objcOtros.agregarCerosNumeroFormato(objcOtros.redondearDecimales(aDeber121_150, 2), 2)%></td>
                    <td style="text-align: right;mso-number-format:'0.00'; background-color: #00cc33;"><%=objcOtros.agregarCerosNumeroFormato(objcOtros.redondearDecimales(aDeber91_120, 2), 2)%></td>
                    <td style="text-align: right;mso-number-format:'0.00'; background-color: #00cc33;"><%=objcOtros.agregarCerosNumeroFormato(objcOtros.redondearDecimales(aDeber61_90, 2), 2)%></td>
                    <td style="text-align: right;mso-number-format:'0.00'; background-color: #00cc33;"><%=objcOtros.agregarCerosNumeroFormato(objcOtros.redondearDecimales(aDeber31_60, 2), 2)%></td>
                    <td style="text-align: right;mso-number-format:'0.00'; background-color: #00cc33;"><%=objcOtros.agregarCerosNumeroFormato(objcOtros.redondearDecimales(aDeber1_30, 2), 2)%></td>
                    <td style="text-align: right;mso-number-format:'0.00'; background-color: #ff9999"><%=objcOtros.agregarCerosNumeroFormato(objcOtros.redondearDecimales(deuda0_30, 2), 2)%></td>
                    <td style="text-align: right;mso-number-format:'0.00'; background-color: #ff9999"><%=objcOtros.agregarCerosNumeroFormato(objcOtros.redondearDecimales(deuda31_60, 2), 2)%></td>
                    <td style="text-align: right;mso-number-format:'0.00'; background-color: #ff9999"><%=objcOtros.agregarCerosNumeroFormato(objcOtros.redondearDecimales(deuda61_91, 2), 2)%></td>
                    <td style="text-align: right;mso-number-format:'0.00'; background-color: #ff9999"><%=objcOtros.agregarCerosNumeroFormato(objcOtros.redondearDecimales(deuda91_mas, 2), 2)%></td>
                </tr>
                <%
                                aDeber151_mas = 0.00;
                                aDeber121_150 = 0.00;
                                aDeber91_120 = 0.00;
                                aDeber61_90 = 0.00;
                                aDeber31_60 = 0.00;
                                aDeber1_30 = 0.00;
                                deudaActual = 0.00;
                                deuda0_30 = 0.00;
                                deuda31_60 = 0.00;
                                deuda61_91 = 0.00;
                                deuda91_mas = 0.00;
                            }
                            objVentaCreditoLetraAux = objVentaCreditoLetra;
                            deudaActual += objVentaCreditoLetraAux.getMonto() - objVentaCreditoLetraAux.getTotalPago();
                            if (objVentaCreditoLetraAux.getFechaVencimiento().before(fechaVencimiento)) {//inicio letras vencidas
                                if (objcManejoFechas.StringADate(objcManejoFechas.fechaSumarDias(fechaVencimiento, -31)).before(objVentaCreditoLetraAux.getFechaVencimiento())) {
                                    deuda0_30 += objVentaCreditoLetraAux.getMonto() - objVentaCreditoLetraAux.getTotalPago();
                                } else {
                                    if (objcManejoFechas.StringADate(objcManejoFechas.fechaSumarDias(fechaVencimiento, -61)).before(objVentaCreditoLetraAux.getFechaVencimiento())) {
                                        deuda31_60 += objVentaCreditoLetraAux.getMonto() - objVentaCreditoLetraAux.getTotalPago();
                                    } else {
                                        if (objcManejoFechas.StringADate(objcManejoFechas.fechaSumarDias(fechaVencimiento, -91)).before(objVentaCreditoLetraAux.getFechaVencimiento())) {
                                            deuda61_91 += objVentaCreditoLetraAux.getMonto() - objVentaCreditoLetraAux.getTotalPago();
                                        } else {
                                            deuda91_mas += objVentaCreditoLetraAux.getMonto() - objVentaCreditoLetraAux.getTotalPago();
                                        }
                                    }
                                }
                            } else {//fin letras vencidas
                                if (objcManejoFechas.StringADate(objcManejoFechas.fechaSumarDias(fechaVencimiento, +30)).after(objVentaCreditoLetraAux.getFechaVencimiento())) {
                                    aDeber1_30 += objVentaCreditoLetraAux.getMonto() - objVentaCreditoLetraAux.getTotalPago();
                                } else {
                                    if (objcManejoFechas.StringADate(objcManejoFechas.fechaSumarDias(fechaVencimiento, +60)).after(objVentaCreditoLetraAux.getFechaVencimiento())) {
                                        aDeber31_60 += objVentaCreditoLetraAux.getMonto() - objVentaCreditoLetraAux.getTotalPago();
                                    } else {
                                        if (objcManejoFechas.StringADate(objcManejoFechas.fechaSumarDias(fechaVencimiento, +90)).after(objVentaCreditoLetraAux.getFechaVencimiento())) {
                                            aDeber61_90 += objVentaCreditoLetraAux.getMonto() - objVentaCreditoLetraAux.getTotalPago();
                                        } else {
                                            if (objcManejoFechas.StringADate(objcManejoFechas.fechaSumarDias(fechaVencimiento, +120)).after(objVentaCreditoLetraAux.getFechaVencimiento())) {
                                                aDeber91_120 += objVentaCreditoLetraAux.getMonto() - objVentaCreditoLetraAux.getTotalPago();
                                            } else {
                                                if (objcManejoFechas.StringADate(objcManejoFechas.fechaSumarDias(fechaVencimiento, +150)).after(objVentaCreditoLetraAux.getFechaVencimiento())) {
                                                    aDeber121_150 += objVentaCreditoLetraAux.getMonto() - objVentaCreditoLetraAux.getTotalPago();
                                                } else {
                                                    aDeber151_mas += objVentaCreditoLetraAux.getMonto() - objVentaCreditoLetraAux.getTotalPago();
                                                }
                                            }
                                        }
                                    }
                                }
                            }
                        }
                    }
                %>
                <tr>
                    <td><%=objVentaCreditoLetraAux.getVentaCredito().getVentas().getDocSerieNumero()%></td>
                    <td><%=objcManejoFechas.DateAString(objVentaCreditoLetraAux.getVentaCredito().getVentas().getFecha())%></td>
                    <td style="text-align: right;mso-number-format:'@'; padding-right: 5px;"><%=objVentaCreditoLetraAux.getVentaCredito().getVentas().getIdentificacion()%></td>
                    <td><%=objVentaCreditoLetraAux.getVentaCredito().getVentas().getCliente()%></td>
                    <td><%=objVentaCreditoLetraAux.getVentaCredito().getVentas().getDireccion()%></td>
                    <td style="text-align: right;mso-number-format:'0.00';"><%=objcOtros.agregarCerosNumeroFormato(objVentaCreditoLetraAux.getVentaCredito().getVentas().getNeto(), 2)%></td>
                    <td style="text-align: right;mso-number-format:'0.00';"><%=objcOtros.agregarCerosNumeroFormato(objcOtros.redondearDecimales(deudaActual, 2), 2)%></td>
                    <td style="text-align: right;mso-number-format:'0.00'; background-color: #00cc33;"><%=objcOtros.agregarCerosNumeroFormato(objcOtros.redondearDecimales(aDeber151_mas, 2), 2)%></td>
                    <td style="text-align: right;mso-number-format:'0.00'; background-color: #00cc33;"><%=objcOtros.agregarCerosNumeroFormato(objcOtros.redondearDecimales(aDeber121_150, 2), 2)%></td>
                    <td style="text-align: right;mso-number-format:'0.00'; background-color: #00cc33;"><%=objcOtros.agregarCerosNumeroFormato(objcOtros.redondearDecimales(aDeber91_120, 2), 2)%></td>
                    <td style="text-align: right;mso-number-format:'0.00'; background-color: #00cc33;"><%=objcOtros.agregarCerosNumeroFormato(objcOtros.redondearDecimales(aDeber61_90, 2), 2)%></td>
                    <td style="text-align: right;mso-number-format:'0.00'; background-color: #00cc33;"><%=objcOtros.agregarCerosNumeroFormato(objcOtros.redondearDecimales(aDeber31_60, 2), 2)%></td>
                    <td style="text-align: right;mso-number-format:'0.00'; background-color: #00cc33;"><%=objcOtros.agregarCerosNumeroFormato(objcOtros.redondearDecimales(aDeber1_30, 2), 2)%></td>
                    <td style="text-align: right;mso-number-format:'0.00'; background-color: #ff9999"><%=objcOtros.agregarCerosNumeroFormato(objcOtros.redondearDecimales(deuda0_30, 2), 2)%></td>
                    <td style="text-align: right;mso-number-format:'0.00'; background-color: #ff9999"><%=objcOtros.agregarCerosNumeroFormato(objcOtros.redondearDecimales(deuda31_60, 2), 2)%></td>
                    <td style="text-align: right;mso-number-format:'0.00'; background-color: #ff9999"><%=objcOtros.agregarCerosNumeroFormato(objcOtros.redondearDecimales(deuda61_91, 2), 2)%></td>
                    <td style="text-align: right;mso-number-format:'0.00'; background-color: #ff9999"><%=objcOtros.agregarCerosNumeroFormato(objcOtros.redondearDecimales(deuda91_mas, 2), 2)%></td>
                </tr>
            </tbody>
        </table>
    </body>
</html>
