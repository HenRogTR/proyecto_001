<%-- 
    Document   : ventasVendedor
    Created on : 27/06/2013, 06:10:14 PM
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
    String ventaTipo = null;
    Date fechaInicio = null;
    Date fechaFin = null;
    int codVendedor = 0;
    cUtilitarios objcUtilitarios = new cUtilitarios();
    cManejoFechas objcManejoFechas = new cManejoFechas();
    List lVentas = null;
    try {
        ventaTipo = request.getParameter("ventaTipo").toString();
        fechaInicio = objcManejoFechas.caracterADate(request.getParameter("fechaInicio"));
        fechaFin = objcManejoFechas.caracterADate(request.getParameter("fechaFin"));
        cVenta objcVentas = new cVenta();
        codVendedor = Integer.parseInt(request.getParameter("codVendedor"));

        if (ventaTipo.equals("todo")) {
            lVentas = objcVentas.leer_fechaInicio_fechaFin_vendedor(fechaInicio, fechaFin, codVendedor);
        }
        if (ventaTipo.equals("contado")) {
            lVentas = objcVentas.leer_contado_fechaInicio_fechaFin_vendedor(fechaInicio, fechaFin, codVendedor);
        }
        if (ventaTipo.equals("credito")) {
            lVentas = objcVentas.leer_credito_fechaInicio_fechaFin_vendedor(fechaInicio, fechaFin, codVendedor);
        }
        if (lVentas == null) {
            estado = false;
            mensaje = "Erorr en parámetros enviados";
        }
    } catch (Exception e) {
        estado = false;
        mensaje = "Error en datos";
    }

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
                <table style="width: 100%;">
                    <thead>
                        <tr class="bottom2">
                            <th colspan="4">REPORTE GENERAL DE VENTAS: <%=ventaTipo.toUpperCase()%></th>
                            <th colspan="4" style="text-align: right;"> <%=objcUtilitarios.fechaHoraActual()%></th>
                        </tr>
                        <tr class="bottom2" style="font-size: 10px;">                            
                            <th style="width: 90px;">COMPROBANTE</th>
                            <th style="width: 70px;">C. CLIENTE</th>
                            <th>NOMBRE/RAZÓN SOCIAL</th>
                            <th style="width: 60px;">P. REAL</th>
                            <th style="width: 60px;">CONTADO</th>
                            <th style="width: 60px;">CRÉDITO</th>
                            <th style="width: 60px;">INICIAL</th>
                            <th style="width: 60px;">N° LETRAS</th>
                        </tr>
                    </thead>
                    <tbody>
                        <%
                            int contDias = 0;
                            Date temp = objcManejoFechas.caracterADate(objcManejoFechas.fechaSumarDias(fechaInicio, -1));
                            Double precioRealDia = 0.00, precioContadoDia = 0.00, creditoDia = 0.00, inicialDia = 0.00;//precios acumulados diarios
                            Double precioRealPeriodo = 0.00, precioContadoPeriodo = 0.00, creditoPeriodo = 0.00, inicialPeriodo = 0.00;//precios acumulados periodos
                            Iterator iVentas = lVentas.iterator();
                            while (iVentas.hasNext()) {
                                Ventas objVentas = (Ventas) iVentas.next();
                                if (contDias == 0) {
                                    temp = objVentas.getFecha();
                        %>
                        <tr class="top2">
                            <th><%=objcManejoFechas.fechaDateToString(objVentas.getFecha())%></th>
                        </tr>
                        <%
                        } else {
                            if (temp.before(objVentas.getFecha())) {
                                temp = objVentas.getFecha();
                        %>
                        <tr class="top3">
                            <td></td>
                            <td></td>
                            <td></td>
                            <th style="text-align: right;"><%=objcUtilitarios.agregarCerosNumeroFormato(objcUtilitarios.redondearDecimales(precioRealDia, 2), 2)%></th>
                            <th style="text-align: right;"><%=objcUtilitarios.agregarCerosNumeroFormato(objcUtilitarios.redondearDecimales(precioContadoDia, 2), 2)%></th>
                            <th style="text-align: right;"><%=objcUtilitarios.agregarCerosNumeroFormato(objcUtilitarios.redondearDecimales(creditoDia, 2), 2)%></th>
                            <th style="text-align: right;"><%=objcUtilitarios.agregarCerosNumeroFormato(objcUtilitarios.redondearDecimales(inicialDia, 2), 2)%></th>
                            <td></td>                    
                        </tr>
                        <tr class="top2">
                            <th><%=objcManejoFechas.fechaDateToString(objVentas.getFecha())%></th>
                        </tr>
                        <%
                                    precioRealPeriodo += precioRealDia;
                                    precioContadoPeriodo += precioContadoDia;
                                    creditoPeriodo += creditoDia;
                                    inicialPeriodo += inicialDia;

                                    precioRealDia = 0.00;
                                    precioContadoDia = 0.00;
                                    creditoDia = 0.00;
                                    inicialDia = 0.00;
                                }
                            }
                        %>
                        <tr>
                            <td><%=objVentas.getDocSerieNumero()%></td>
                            <%
                                if (objVentas.getRegistro().substring(0, 1).equals("1")) {
                            %>
                            <td><%=objcUtilitarios.agregarCeros_int(objVentas.getPersona().getCodPersona(), 8)%></td>
                            <td><%=objVentas.getCliente()%></td>
                            <td style="text-align: right;">
                                <%
                                    Double precioReal = 0.00;
                                    for (VentasDetalle objVentasDetalle : objVentas.getVentasDetalles()) {
                                        if (objVentasDetalle.getRegistro().substring(0, 1).equals("1")) {//para sumar solo los articulos en venta, ya que la venta puede haber sido editada.
                                            if (objVentasDetalle.getPrecioReal() <= objVentasDetalle.getPrecioVenta()) {
                                                precioReal += objVentasDetalle.getPrecioReal() * objVentasDetalle.getCantidad();
                                            } else {
                                                precioReal += objVentasDetalle.getPrecioVenta() * objVentasDetalle.getCantidad();
                                            }
                                        }
                                    }
                                    out.print(objcUtilitarios.agregarCerosNumeroFormato(objcUtilitarios.redondearDecimales(precioReal, 2), 2));
                                    precioRealDia += precioReal;
                                %>
                            </td>
                            <%
                                if (objVentas.getTipo().equals("CREDITO")) {
                                    VentaCredito objVentaCredito = null;
                                    for (VentaCredito objVentaCreditoTemp : objVentas.getVentaCreditos()) {
                                        if (objVentaCreditoTemp.getRegistro().substring(0, 1).equals("1")) {
                                            objVentaCredito = objVentaCreditoTemp;
                                        }
                                    }
                            %>
                            <td style="text-align: right;"></td>
                            <td style="text-align: right;"><%=objcUtilitarios.agregarCerosNumeroFormato(objVentas.getNeto(), 2)%></td>
                            <td style="text-align: right;"><%=objcUtilitarios.agregarCerosNumeroFormato(objVentaCredito.getMontoInicial(), 2)%></td>
                            <td style="text-align: right; padding-right: 5px;"><%=objVentaCredito.getCantidadLetras()%></td>
                            <%
                                creditoDia += objVentas.getNeto();
                                inicialDia += objVentaCredito.getMontoInicial();
                            } else {
                            %>
                            <td style="text-align: right;"><%=objcUtilitarios.agregarCerosNumeroFormato(objVentas.getNeto(), 2)%></td>
                            <td style="text-align: right;"></td>
                            <td style="text-align: right;"></td>
                            <td style="text-align: right;"></td>
                            <%
                                    precioContadoDia += objVentas.getNeto();
                                }
                            } else {
                            %>
                            <td colspan="7" style="font-weight: bold;">*********** DOCUMENTO ANULADO *********</td>
                            <%                                        }
                            %>
                        </tr>
                        <%

                                contDias++;
                            }
                            precioRealPeriodo += precioRealDia;
                            precioContadoPeriodo += precioContadoDia;
                            creditoPeriodo += creditoDia;
                            inicialPeriodo += inicialDia;
                        %>
                        <tr class="top3">
                            <td></td>
                            <td></td>
                            <td></td>
                            <th style="text-align: right;"><%=objcUtilitarios.agregarCerosNumeroFormato(objcUtilitarios.redondearDecimales(precioRealDia, 2), 2)%></th>
                            <th style="text-align: right;"><%=objcUtilitarios.agregarCerosNumeroFormato(objcUtilitarios.redondearDecimales(precioContadoDia, 2), 2)%></th>
                            <th style="text-align: right;"><%=objcUtilitarios.agregarCerosNumeroFormato(objcUtilitarios.redondearDecimales(creditoDia, 2), 2)%></th>
                            <th style="text-align: right;"><%=objcUtilitarios.agregarCerosNumeroFormato(objcUtilitarios.redondearDecimales(inicialDia, 2), 2)%></th>
                            <td style="height: 40px;"></td>
                        </tr>                        
                        <tr class="top3">
                            <td></td>
                            <td></td>
                            <th>TOTAL GENERAL</th>
                            <th style="text-align: right;"><%=objcUtilitarios.agregarCerosNumeroFormato(objcUtilitarios.redondearDecimales(precioRealPeriodo, 2), 2)%></th>
                            <th style="text-align: right;"><%=objcUtilitarios.agregarCerosNumeroFormato(objcUtilitarios.redondearDecimales(precioContadoPeriodo, 2), 2)%></th>
                            <th style="text-align: right;"><%=objcUtilitarios.agregarCerosNumeroFormato(objcUtilitarios.redondearDecimales(creditoPeriodo, 2), 2)%></th>
                            <th style="text-align: right;"><%=objcUtilitarios.agregarCerosNumeroFormato(objcUtilitarios.redondearDecimales(inicialPeriodo, 2), 2)%></th>
                            <td></td>
                        </tr>
                    </tbody>
                </table>
            </div>
        </div>
    </body>
</html>