<%-- 
    Document   : vclrm
    Created on : 26/08/2013, 10:01:58 AM
    Author     : Henrri
--%>

<%@page import="clases.cUtilitarios"%>
<%@page import="clases.cFecha"%>
<%@page import="java.util.Date"%>
<%@page import="utilitarios.cManejoFechas"%>
<%@page import="java.util.List"%>
<%@page import="tablas.DatosCliente"%>
<%@page import="Ejb.EjbCliente"%>
<%@page import="Ejb.EjbVentaCreditoLetra"%>
<%
    int codCliente = 0;
    try {
        codCliente = Integer.parseInt(request.getParameter("codCliente"));
    } catch (Exception e) {
        out.print("Error en parámteros");
        return;
    }
    //definir java bean
    EjbVentaCreditoLetra ejbVentaCreditoLetra;
    EjbCliente ejbCliente;
    //obteniendo lista
    ejbVentaCreditoLetra = new EjbVentaCreditoLetra();
    List<Object[]> ventaCreditoLetraObjects = ejbVentaCreditoLetra.leerResumenPorCodigoCliente(codCliente);
    //obtneiendo cliente
    ejbCliente = new EjbCliente();
    DatosCliente objCliente = ejbCliente.leerCodigoCliente(codCliente, false);
%>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <title>Resumen pagos</title>
        <link rel="stylesheet" type="text/css" href="../../librerias/principal/bodyPrint.css" media="screen"/>
        <link rel="stylesheet" type="text/css" href="../../librerias/principal/bodyPrint.css" media="print"/>
    </head>
    <body>
        <div id="documento">
            <div id="contenido">
                <table class="tabla-imprimir" style="width: 600px;">
                    <thead>
                        <tr class="bottom2">
                            <th class="izquierda" colspan="5" style="padding-left: 20px;"><%=cUtilitarios.agregarCerosIzquierda(codCliente, 8)%> - <%=objCliente.getPersona().getNombresC()%></th>
                        </tr>
                        <tr class="bottom2">
                            <th class="centrado ancho120px">MES/AÑO</th>
                            <th class="centrado ancho120px">TOTAL MES</th>
                            <th style="" class="centrado">TOTAL INTERÉS</th>
                            <th class="centrado ancho120px">TOTAL PAGOS</th>
                            <th class="centrado ancho120px">TOTAL SALDO</th>
                        </tr>
                    </thead>
                    <tbody>
                        <%
                            //definir variables (por año/mes)
                            Date fechaVencimiento = null;
                            Double monto = 0.00;
                            Double interes = 0.00;
                            Double totalPago = 0.00;
                            Double interesPagado = 0.00;
                            //calcular totales (por año/mes)
                            Double deudaCliente = 0.00;
                            Double pagoCliente = 0.00;
                            Double saldoCliente = 0.00;
                            //para calcular el totoal general
                            Double deudaClienteTotal = 0.00;
                            Double interesClienteTotal = 0.00;
                            Double pagoClienteTotal = 0.00;
                            Double saldoClienteTotal = 0.00;
                            int tam = ventaCreditoLetraObjects.size();
                            for (int i = 0; i < tam; i++) {
                                Object[] VCLResumen = ventaCreditoLetraObjects.get(i);
                                fechaVencimiento = (Date) VCLResumen[0];
                                monto = (Double) VCLResumen[1];
                                interes = (Double) VCLResumen[2];
                                totalPago = (Double) VCLResumen[3];
                                interesPagado = (Double) VCLResumen[4];
                                deudaCliente = monto + interes;
                                pagoCliente = totalPago + interesPagado;
                                saldoCliente = deudaCliente - pagoCliente;
                                //sumando totales
                                deudaClienteTotal += monto;
                                interesClienteTotal += interes;
                                pagoClienteTotal += pagoCliente;
                                saldoClienteTotal += saldoCliente;
                        %>
                        <tr>
                            <td style="text-align: right;padding-right: 20px;"><%=cFecha.mesNombreCorto(fechaVencimiento).toUpperCase() + "-" + cFecha.anioCorto(fechaVencimiento)%></td>
                            <td style="text-align: right;padding-right: 20px;"><%=cUtilitarios.decimalFormato(monto, 2)%></td>
                            <td style="text-align: right;padding-right: 20px;"><%=cUtilitarios.decimalFormato(interes, 2)%></td>
                            <td style="text-align: right;padding-right: 20px;"><%=cUtilitarios.decimalFormato(pagoCliente, 2)%></td>
                            <td style="text-align: right;padding-right: 20px;"><%=cUtilitarios.decimalFormato(saldoCliente, 2)%></td>
                        </tr>
                        <%
                            }
                        %>
                        <tr class="top2 bottom2">
                            <th class="centrado">T. GENERAL</th>
                            <th style="text-align: right;padding-right: 20px;"><%=cUtilitarios.decimalFormato(deudaClienteTotal, 2)%></th>
                            <th style="text-align: right;padding-right: 20px;"><%=cUtilitarios.decimalFormato(interesClienteTotal, 2)%></th>
                            <th style="text-align: right;padding-right: 20px;"><%=cUtilitarios.decimalFormato(pagoClienteTotal, 2)%></th>
                            <th style="text-align: right;padding-right: 20px;"><%=cUtilitarios.decimalFormato(saldoClienteTotal, 2)%></th>
                        </tr>
                        <tr>
                            <td colspan="5" class="derecha" style="font-size: 10px; padding-right: 20px;"><%=cFecha.fechaHora(new Date()).toUpperCase()%></td>
                        </tr>
                    </tbody>
                </table>
            </div>
        </div>
    </body>
</html>
