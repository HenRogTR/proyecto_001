<%-- 
    Document   : nombresCLetrasVencidas
    Created on : 17/05/2013, 06:24:59 PM
    Author     : Henrri
--%>

<%@page import="personaClases.cPersona"%>
<%@page import="tablas.Persona"%>
<%@page import="tablas.VentasDetalle"%>
<%@page import="otros.cManejoFechas"%>
<%@page import="tablas.VentaCreditoLetra"%>
<%@page import="ventaClases.cVentaCreditoLetra"%>
<%@page import="java.util.Iterator"%>
<%@page import="java.util.List"%>
<%@page import="personaClases.cDatosCliente"%>
<%@page import="otros.cUtilitarios"%>
<%@page import="java.util.Date"%>
<%
    boolean estado = true;
    String mensaje = "";
    Date fechaVencimiento = new Date();
    Persona objCobrador = null;
    cPersona objcPersona = new cPersona();
    int codCobrador = 0;
    try {
        codCobrador = Integer.parseInt(request.getParameter("codCobrador"));
        objCobrador = objcPersona.leer_cod(codCobrador);
        if (objCobrador == null) {
            out.print("No hay cobrador con ese codigo");
            return;
        }
        fechaVencimiento = new cManejoFechas().caracterADate(request.getParameter("fechaVencimiento"));
    } catch (Exception e) {
        estado = false;
        mensaje = "Fecha incorrecta";
    }
    cUtilitarios objcUtilitarios = new cUtilitarios();
    List lLetrasVencidas = new cVentaCreditoLetra().letras_codCobrador_ordenNombresC(codCobrador);
    cManejoFechas objcManejoFechas = new cManejoFechas();
    response.setContentType("application/vnd.ms-excel"); //Tipo de fichero.
    response.setHeader("Content-Disposition", "attachment;filename=\"" + objcUtilitarios.fechaHoraActualNumerosLineal() + ".xls\"");
%>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <title></title>
        <!--        <link rel="stylesheet" type="text/css" href="../../lib/propios/css/paginaImprimir/bodyPrint.css" media="screen"/>
                <link rel="stylesheet" type="text/css" href="../../lib/propios/css/paginaImprimir/bodyPrint.css" media="print"/>-->
        <style>
            td,th{
                /*border: 1px solid #3366ff;*/
                text-align: left;
                vertical-align: top;
            }

            @media print {
                a:link, a:visited {
                    text-decoration: none;
                    color: black;
                }
            }
            tbody tr:hover td            {
                background: #d0dafd;
            }
        </style>
    </head>
    <body>
        <div id="documento">
            <div id="contenido">
                <%
                    if (estado) {
                %>
                <table style="font-size: 14px;width: 2000px;">
                    <thead>
                        <tr class="bottom2">
                            <th colspan="11"><label>Letras X cobrar : Clientes en general :: C. <%=objCobrador.getNombres()%></label></th>
                        </tr>
                        <tr class="bottom1">
                            <th style="width: 100px;"><label>Documento</label></th>
                            <th style="width: 80px;"><label>F. Venta</label></th>
                            <th style="width: 100px;"><label>Dni/Ruc</label></th>
                            <th style=""><label>Ape-Nombres/Razon Social</label></th>
                            <th style="width: 400px;"><label>Dirección</label></th>
                            <th style="width: 70px;"><label>M. Crédito</label></th>
                            <th style="width: 90px;"><label>Deuda Actual</label></th>
                            <th style="width: 90px;"><label>151-mas(Dias)</label></th>
                            <th style="width: 90px;"><label>121-150(Dias)</label></th>
                            <th style="width: 80px;"><label>91-120(Dias)</label></th>                            
                            <th style="width: 70px;"><label>61-90(Dias)</label></th>
                            <th style="width: 70px;"><label>31-60(Dias)</label></th>
                            <th style="width: 70px;"><label>1-30(Dias)</label></th>
                            <th style="width: 70px;"><label>0-30(Dias)</label></th>
                            <th style="width: 70px;"><label>31-60(Dias)</label></th>
                            <th style="width: 70px;"><label>61-90(Dias)</label></th>
                            <th style="width: 90px;"><label>91-mas(Dias)</label></th>
                        </tr>
                    </thead>
                    <tbody>
                        <%
                            Double deudaActual = 0.00, deuda0_30 = 0.00, deuda31_60 = 0.00, deuda61_91 = 0.00, deuda91_mas = 0.00;
                            Double aDeber1_30 = 0.00, aDeber31_60 = 0.00, aDeber61_90 = 0.00, aDeber91_120 = 0.00, aDeber121_150 = 0.00, aDeber151_mas = 0.00;
                            Iterator iLetrasVencidas = lLetrasVencidas.iterator();
                            VentaCreditoLetra objVentaCreditoLetraAux = null;

                            while (iLetrasVencidas.hasNext()) {
                                VentaCreditoLetra objVentaCreditoLetra = (VentaCreditoLetra) iLetrasVencidas.next();
                                if (objVentaCreditoLetraAux == null) {
                                    objVentaCreditoLetraAux = objVentaCreditoLetra;
                                    deudaActual += objVentaCreditoLetraAux.getMonto() - objVentaCreditoLetraAux.getTotalPago();
                                    if (objVentaCreditoLetraAux.getFechaVencimiento().before(fechaVencimiento)) {//inicio letras vencidas
                                        if (objcManejoFechas.caracterADate(objcManejoFechas.fechaSumarDias(fechaVencimiento, -31)).before(objVentaCreditoLetraAux.getFechaVencimiento())) {
                                            deuda0_30 += objVentaCreditoLetraAux.getMonto() - objVentaCreditoLetraAux.getTotalPago();
                                        } else {
                                            if (objcManejoFechas.caracterADate(objcManejoFechas.fechaSumarDias(fechaVencimiento, -61)).before(objVentaCreditoLetraAux.getFechaVencimiento())) {
                                                deuda31_60 += objVentaCreditoLetraAux.getMonto() - objVentaCreditoLetraAux.getTotalPago();
                                            } else {
                                                if (objcManejoFechas.caracterADate(objcManejoFechas.fechaSumarDias(fechaVencimiento, -91)).before(objVentaCreditoLetraAux.getFechaVencimiento())) {
                                                    deuda61_91 += objVentaCreditoLetraAux.getMonto() - objVentaCreditoLetraAux.getTotalPago();
                                                } else {
                                                    deuda91_mas += objVentaCreditoLetraAux.getMonto() - objVentaCreditoLetraAux.getTotalPago();
                                                }
                                            }
                                        }
                                    } else {//inicio letras vencidas
                                        if (objcManejoFechas.caracterADate(objcManejoFechas.fechaSumarDias(fechaVencimiento, +30)).after(objVentaCreditoLetraAux.getFechaVencimiento())) {
                                            aDeber1_30 += objVentaCreditoLetraAux.getMonto() - objVentaCreditoLetraAux.getTotalPago();
                                        } else {
                                            if (objcManejoFechas.caracterADate(objcManejoFechas.fechaSumarDias(fechaVencimiento, +60)).after(objVentaCreditoLetraAux.getFechaVencimiento())) {
                                                aDeber31_60 += objVentaCreditoLetraAux.getMonto() - objVentaCreditoLetraAux.getTotalPago();
                                            } else {
                                                if (objcManejoFechas.caracterADate(objcManejoFechas.fechaSumarDias(fechaVencimiento, +90)).after(objVentaCreditoLetraAux.getFechaVencimiento())) {
                                                    aDeber61_90 += objVentaCreditoLetraAux.getMonto() - objVentaCreditoLetraAux.getTotalPago();
                                                } else {
                                                    if (objcManejoFechas.caracterADate(objcManejoFechas.fechaSumarDias(fechaVencimiento, +120)).after(objVentaCreditoLetraAux.getFechaVencimiento())) {
                                                        aDeber91_120 += objVentaCreditoLetraAux.getMonto() - objVentaCreditoLetraAux.getTotalPago();
                                                    } else {
                                                        if (objcManejoFechas.caracterADate(objcManejoFechas.fechaSumarDias(fechaVencimiento, +150)).after(objVentaCreditoLetraAux.getFechaVencimiento())) {
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
                            <td><%=objcUtilitarios.fechaDateToString(objVentaCreditoLetraAux.getVentaCredito().getVentas().getFecha())%></td>
                            <td style="text-align: right;mso-number-format:'@';"><%=objVentaCreditoLetraAux.getVentaCredito().getVentas().getIdentificacion()%></td>
                            <td><%=objVentaCreditoLetraAux.getVentaCredito().getVentas().getCliente()%></td>
                            <td><%=objVentaCreditoLetraAux.getVentaCredito().getVentas().getDireccion()%></td>
                            <td style="text-align: right;mso-number-format:'0.00';"><%=objcUtilitarios.agregarCerosNumeroFormato(objVentaCreditoLetraAux.getVentaCredito().getVentas().getNeto(), 2)%></td>
                            <td style="text-align: right;mso-number-format:'0.00';"><%=objcUtilitarios.agregarCerosNumeroFormato(objcUtilitarios.redondearDecimales(deudaActual, 2), 2)%></td>
                            <td style="text-align: right;mso-number-format:'0.00'; background-color: #00cc33;"><%=objcUtilitarios.agregarCerosNumeroFormato(objcUtilitarios.redondearDecimales(aDeber151_mas, 2), 2)%></td>
                            <td style="text-align: right;mso-number-format:'0.00'; background-color: #00cc33;"><%=objcUtilitarios.agregarCerosNumeroFormato(objcUtilitarios.redondearDecimales(aDeber121_150, 2), 2)%></td>
                            <td style="text-align: right;mso-number-format:'0.00'; background-color: #00cc33;"><%=objcUtilitarios.agregarCerosNumeroFormato(objcUtilitarios.redondearDecimales(aDeber91_120, 2), 2)%></td>
                            <td style="text-align: right;mso-number-format:'0.00'; background-color: #00cc33;"><%=objcUtilitarios.agregarCerosNumeroFormato(objcUtilitarios.redondearDecimales(aDeber61_90, 2), 2)%></td>
                            <td style="text-align: right;mso-number-format:'0.00'; background-color: #00cc33;"><%=objcUtilitarios.agregarCerosNumeroFormato(objcUtilitarios.redondearDecimales(aDeber31_60, 2), 2)%></td>
                            <td style="text-align: right;mso-number-format:'0.00'; background-color: #00cc33;"><%=objcUtilitarios.agregarCerosNumeroFormato(objcUtilitarios.redondearDecimales(aDeber1_30, 2), 2)%></td>
                            <td style="text-align: right;mso-number-format:'0.00'; background-color: #ff9999"><%=objcUtilitarios.agregarCerosNumeroFormato(objcUtilitarios.redondearDecimales(deuda0_30, 2), 2)%></td>
                            <td style="text-align: right;mso-number-format:'0.00'; background-color: #ff9999"><%=objcUtilitarios.agregarCerosNumeroFormato(objcUtilitarios.redondearDecimales(deuda31_60, 2), 2)%></td>
                            <td style="text-align: right;mso-number-format:'0.00'; background-color: #ff9999"><%=objcUtilitarios.agregarCerosNumeroFormato(objcUtilitarios.redondearDecimales(deuda61_91, 2), 2)%></td>
                            <td style="text-align: right;mso-number-format:'0.00'; background-color: #ff9999"><%=objcUtilitarios.agregarCerosNumeroFormato(objcUtilitarios.redondearDecimales(deuda91_mas, 2), 2)%></td>
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
                                        if (objcManejoFechas.caracterADate(objcManejoFechas.fechaSumarDias(fechaVencimiento, -31)).before(objVentaCreditoLetraAux.getFechaVencimiento())) {
                                            deuda0_30 += objVentaCreditoLetraAux.getMonto() - objVentaCreditoLetraAux.getTotalPago();
                                        } else {
                                            if (objcManejoFechas.caracterADate(objcManejoFechas.fechaSumarDias(fechaVencimiento, -61)).before(objVentaCreditoLetraAux.getFechaVencimiento())) {
                                                deuda31_60 += objVentaCreditoLetraAux.getMonto() - objVentaCreditoLetraAux.getTotalPago();
                                            } else {
                                                if (objcManejoFechas.caracterADate(objcManejoFechas.fechaSumarDias(fechaVencimiento, -91)).before(objVentaCreditoLetraAux.getFechaVencimiento())) {
                                                    deuda61_91 += objVentaCreditoLetraAux.getMonto() - objVentaCreditoLetraAux.getTotalPago();
                                                } else {
                                                    deuda91_mas += objVentaCreditoLetraAux.getMonto() - objVentaCreditoLetraAux.getTotalPago();
                                                }
                                            }
                                        }
                                    } else {//fin letras vencidas
                                        if (objcManejoFechas.caracterADate(objcManejoFechas.fechaSumarDias(fechaVencimiento, +30)).after(objVentaCreditoLetraAux.getFechaVencimiento())) {
                                            aDeber1_30 += objVentaCreditoLetraAux.getMonto() - objVentaCreditoLetraAux.getTotalPago();
                                        } else {
                                            if (objcManejoFechas.caracterADate(objcManejoFechas.fechaSumarDias(fechaVencimiento, +60)).after(objVentaCreditoLetraAux.getFechaVencimiento())) {
                                                aDeber31_60 += objVentaCreditoLetraAux.getMonto() - objVentaCreditoLetraAux.getTotalPago();
                                            } else {
                                                if (objcManejoFechas.caracterADate(objcManejoFechas.fechaSumarDias(fechaVencimiento, +90)).after(objVentaCreditoLetraAux.getFechaVencimiento())) {
                                                    aDeber61_90 += objVentaCreditoLetraAux.getMonto() - objVentaCreditoLetraAux.getTotalPago();
                                                } else {
                                                    if (objcManejoFechas.caracterADate(objcManejoFechas.fechaSumarDias(fechaVencimiento, +120)).after(objVentaCreditoLetraAux.getFechaVencimiento())) {
                                                        aDeber91_120 += objVentaCreditoLetraAux.getMonto() - objVentaCreditoLetraAux.getTotalPago();
                                                    } else {
                                                        if (objcManejoFechas.caracterADate(objcManejoFechas.fechaSumarDias(fechaVencimiento, +150)).after(objVentaCreditoLetraAux.getFechaVencimiento())) {
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
                            <td><%=objcUtilitarios.fechaDateToString(objVentaCreditoLetraAux.getVentaCredito().getVentas().getFecha())%></td>
                            <td style="text-align: right;mso-number-format:'@';"><%=objVentaCreditoLetraAux.getVentaCredito().getVentas().getIdentificacion()%></td>
                            <td><%=objVentaCreditoLetraAux.getVentaCredito().getVentas().getCliente()%></td>
                            <td><%=objVentaCreditoLetraAux.getVentaCredito().getVentas().getDireccion()%></td>
                            <td style="text-align: right;mso-number-format:'0.00';"><%=objcUtilitarios.agregarCerosNumeroFormato(objVentaCreditoLetraAux.getVentaCredito().getVentas().getNeto(), 2)%></td>
                            <td style="text-align: right;mso-number-format:'0.00';"><%=objcUtilitarios.agregarCerosNumeroFormato(objcUtilitarios.redondearDecimales(deudaActual, 2), 2)%></td>
                            <td style="text-align: right;mso-number-format:'0.00'; background-color: #00cc33;"><%=objcUtilitarios.agregarCerosNumeroFormato(objcUtilitarios.redondearDecimales(aDeber151_mas, 2), 2)%></td>
                            <td style="text-align: right;mso-number-format:'0.00'; background-color: #00cc33;"><%=objcUtilitarios.agregarCerosNumeroFormato(objcUtilitarios.redondearDecimales(aDeber121_150, 2), 2)%></td>
                            <td style="text-align: right;mso-number-format:'0.00'; background-color: #00cc33;"><%=objcUtilitarios.agregarCerosNumeroFormato(objcUtilitarios.redondearDecimales(aDeber91_120, 2), 2)%></td>
                            <td style="text-align: right;mso-number-format:'0.00'; background-color: #00cc33;"><%=objcUtilitarios.agregarCerosNumeroFormato(objcUtilitarios.redondearDecimales(aDeber61_90, 2), 2)%></td>
                            <td style="text-align: right;mso-number-format:'0.00'; background-color: #00cc33;"><%=objcUtilitarios.agregarCerosNumeroFormato(objcUtilitarios.redondearDecimales(aDeber31_60, 2), 2)%></td>
                            <td style="text-align: right;mso-number-format:'0.00'; background-color: #00cc33;"><%=objcUtilitarios.agregarCerosNumeroFormato(objcUtilitarios.redondearDecimales(aDeber1_30, 2), 2)%></td>
                            <td style="text-align: right;mso-number-format:'0.00'; background-color: #ff9999"><%=objcUtilitarios.agregarCerosNumeroFormato(objcUtilitarios.redondearDecimales(deuda0_30, 2), 2)%></td>
                            <td style="text-align: right;mso-number-format:'0.00'; background-color: #ff9999"><%=objcUtilitarios.agregarCerosNumeroFormato(objcUtilitarios.redondearDecimales(deuda31_60, 2), 2)%></td>
                            <td style="text-align: right;mso-number-format:'0.00'; background-color: #ff9999"><%=objcUtilitarios.agregarCerosNumeroFormato(objcUtilitarios.redondearDecimales(deuda61_91, 2), 2)%></td>
                            <td style="text-align: right;mso-number-format:'0.00'; background-color: #ff9999"><%=objcUtilitarios.agregarCerosNumeroFormato(objcUtilitarios.redondearDecimales(deuda91_mas, 2), 2)%></td>
                        </tr>
                    </tbody>
                </table>
                <%
                    } else {
                        out.print(mensaje);
                    }

                %>
            </div>
        </div>
    </body>
</html>
