<%-- 
    Document   : ventasDocumentoExcel
    Created on : 04/07/2013, 06:58:38 PM
    Author     : Henrri
--%>

<%@page import="tablas.VentaCredito"%>
<%@page import="tablas.VentasDetalle"%>
<%@page import="otros.cManejoFechas"%>
<%@page import="otros.cUtilitarios"%>
<%@page import="tablas.Ventas"%>
<%@page import="java.util.Iterator"%>
<%@page import="ventaClases.cVenta"%>
<%@page import="java.util.List"%>
<%@page import="java.util.Date"%>
<%
    boolean estado = true;
    String mensaje = "";
    String serie = null, ventaTipo = null;
    Date fechaInicio = null, fechaFin = null;
    cUtilitarios objcUtilitarios = new cUtilitarios();
    cManejoFechas objcManejoFechas = new cManejoFechas();
    List lVentas = null;
    try {
        ventaTipo = request.getParameter("ventaTipo").toString();
        serie = request.getParameter("serie").toString();
        fechaInicio = objcManejoFechas.caracterADate(request.getParameter("fechaInicio"));
        fechaFin = objcManejoFechas.caracterADate(request.getParameter("fechaFin"));
        cVenta objcVentas = new cVenta();

        if (ventaTipo.equals("todo")) {
            lVentas = objcVentas.leer_fechaInicio_fechaFin_serie(fechaInicio, fechaFin, serie);
        }
        if (ventaTipo.equals("contado")) {
            lVentas = objcVentas.leer_contado_fechaInicio_fechaFin(fechaInicio, fechaFin);
        }
        if (ventaTipo.equals("credito")) {
            lVentas = objcVentas.leer_credito_fechaInicio_fechaFin(fechaInicio, fechaFin);
        }
        if (lVentas == null) {
            estado = false;
            mensaje = "Erorr en parámetros enviados";
        }
    } catch (Exception e) {
        estado = false;
        mensaje = "Error en datos";
    }
response.setContentType("application/vnd.ms-excel"); //Tipo de fichero.
    response.setHeader("Content-Disposition", "attachment;filename=\"" + objcUtilitarios.fechaHoraActualNumerosLineal() + ".xls\"");
%>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <title></title>
        <link rel="stylesheet" type="text/css" href="../../lib/propios/css/paginaImprimir/bodyPrint.css" media="screen"/>
        <link rel="stylesheet" type="text/css" href="../../lib/propios/css/paginaImprimir/bodyPrint.css" media="print"/>
        <style>
            td,th{
                /*border: 1px solid #000;*/
            }
            tr:hover td
            {
                background: #d0dafd;
            }
        </style>
    </head>
    <body>
        <div id="documento">
            <div id="contenido">
                <%
                    if (!estado) {
                        out.print(mensaje);
                        return;
                    }
                %>
                <table style="width: 800px; font-size: 14px; ">
                    <thead>
                        <tr class="bottom2">
                            <th colspan="5">REPORTE GENERAL DE VENTAS: <%=ventaTipo.toUpperCase()%></th>
                        </tr>
                        <tr class="bottom2" style="font-size: 10px;">                            
                            <th style="width: 90px;">COMPROBANTE</th>
                            <th>NOMBRE/RAZÓN SOCIAL</th>
                            <th style="width: 60px;">IMPORTE</th>
                            <th style="width: 60px;">LETRAS</th>
                            <th style="width: 80px;">OBSERVACIÓN</th>
                        </tr>
                    </thead>
                    <tbody>
                        <%
                            Double total = 0.00;
                            Iterator iVentas = lVentas.iterator();
                            while (iVentas.hasNext()) {
                                Ventas objVentas = (Ventas) iVentas.next();
                                total += objVentas.getNeto();
                        %>
                        <tr>
                            <td><%=objVentas.getDocSerieNumero()%></td>
                            <td><%=objVentas.getCliente()%></td>
                            <td style="text-align: right; mso-number-format:'0.00';"><%=objcUtilitarios.agregarCerosNumeroFormato(objcUtilitarios.redondearDecimales(objVentas.getNeto(), 2), 2)%></td>
                            <td style="text-align: right;">
                                <%
                                    if (objVentas.getTipo().equals("CREDITO")) {
                                        VentaCredito objVentaCredito = null;
                                        for (VentaCredito objVentaCreditoTemp : objVentas.getVentaCreditos()) {
                                            if (objVentaCreditoTemp.getRegistro().substring(0, 1).equals("1")) {
                                                objVentaCredito = objVentaCreditoTemp;
                                            }
                                        }
                                        out.print(objVentaCredito.getCantidadLetras());
                                    }
                                %>
                            </td>
                            <td style="text-align: right;"><%=objVentas.getRegistro().substring(0, 1).equals("0") ? "Anulado" : ""%></td>
                        </tr>
                        <%
                            }
                        %>                                              
                        <tr class="top3">
                            <td></td>
                            <th style="text-align: right;">TOTAL GENERAL</th>
                            <th style="text-align: right; mso-number-format:'0.00';"><%=objcUtilitarios.agregarCerosNumeroFormato(objcUtilitarios.redondearDecimales(total, 2), 2)%></th>
                            <td></td>
                            <td></td>
                        </tr>
                    </tbody>
                </table>
            </div>
        </div>
    </body>
</html>