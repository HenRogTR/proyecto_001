<%-- 
    Document   : vclrm
    Created on : 26/08/2013, 10:01:58 AM
    Author     : Henrri
--%>


<%@page import="personaClases.cDatosCliente"%>
<%@page import="java.util.Date"%>
<%@page import="java.util.Iterator"%>
<%@page import="otros.cUtilitarios"%>
<%@page import="personaClases.cPersona"%>
<%@page import="ventaClases.cVentaCreditoLetra"%>
<%@page import="tablas.Persona"%>
<%@page import="java.util.List"%>
<%
    int codCliente = 0;
    try {
        codCliente = Integer.parseInt(request.getParameter("codCliente"));
    } catch (Exception e) {
        out.print("Error en parámteros");
        return;
    }
    cUtilitarios objcUtilitarios = new cUtilitarios();
    Persona objPersona = new cPersona().leer_cod(new cDatosCliente().leer_cod(codCliente).getPersona().getCodPersona());

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
                <table class="tabla-imprimir" style="width: 650px;">
                    <thead>
                        <tr class="bottom2">
                            <th colspan="5"><%=objPersona.getNombresC()%> <label style="float: right;"><%=objcUtilitarios.fechaHoraActual()%></label></th>
                        </tr>
                        <tr class="bottom2">
                            <th style="width: 120px;" class="centrado">MES/AÑO</th>
                            <th style="width: 120px;" class="centrado">TOTAL MES</th>
                            <th style="" class="centrado">TOTAL INTERES</th>
                            <th style="width: 120px;" class="centrado">TOTAL PAGOS</th>
                            <th style="width: 120px;" class="centrado">TOTAL SALDO</th>
                        </tr>
                    </thead>
                    <tbody>
                        <%
                            List lVentaCreditoLetraRP = new cVentaCreditoLetra().leer_resumenPagos(objPersona.getCodPersona());
                            Double mTotalMes = 0.00, mTotalInteres = 0.00, mTotalPago = 0.00, mTotalSaldo = 0.00;
                            Iterator iVentaCreditoLetraRP = lVentaCreditoLetraRP.iterator();
                            while (iVentaCreditoLetraRP.hasNext()) {
                                Object[] temRP = (Object[]) iVentaCreditoLetraRP.next();
                                mTotalMes += (Double) temRP[2];
                                mTotalInteres += (Double) temRP[3];
                                mTotalPago += (Double) temRP[4];
                                mTotalSaldo += (Double) temRP[5];
                        %>
                        <tr>
                            <td style="text-align: right;padding-right: 20px;"><%=objcUtilitarios.mesNombreCorto((Date) temRP[6]).toUpperCase() + "-" + temRP[1].toString().substring(2, 4)%></td>
                            <td style="text-align: right;padding-right: 20px;"><%=objcUtilitarios.agregarCerosNumeroFormato(Double.parseDouble(temRP[2].toString()), 2)%></td>
                            <td style="text-align: right;padding-right: 20px;"><%=objcUtilitarios.agregarCerosNumeroFormato(Double.parseDouble(temRP[3].toString()), 2)%></td>
                            <td style="text-align: right;padding-right: 20px;"><%=objcUtilitarios.agregarCerosNumeroFormato(Double.parseDouble(temRP[4].toString()), 2)%></td>
                            <td style="text-align: right;padding-right: 20px;"><%=objcUtilitarios.agregarCerosNumeroFormato(Double.parseDouble(temRP[5].toString()), 2)%></td>
                        </tr>
                        <%
                            }
                        %>
                        <tr class="top2 bottom2">
                            <th class="centrado">T. GENERAL</th>
                            <th style="text-align: right;padding-right: 20px;"><%=objcUtilitarios.agregarCerosNumeroFormato(objcUtilitarios.redondearDecimales(mTotalMes, 2), 2)%></th>
                            <th style="text-align: right;padding-right: 20px;"><%=objcUtilitarios.agregarCerosNumeroFormato(objcUtilitarios.redondearDecimales(mTotalInteres, 2), 2)%></th>
                            <th style="text-align: right;padding-right: 20px;"><%=objcUtilitarios.agregarCerosNumeroFormato(objcUtilitarios.redondearDecimales(mTotalPago, 2), 2)%></th>
                            <th style="text-align: right;padding-right: 20px;"><%=objcUtilitarios.agregarCerosNumeroFormato(objcUtilitarios.redondearDecimales(mTotalSaldo, 2), 2)%></th>
                        </tr>
                    </tbody>
                </table>
            </div>
        </div>
    </body>
</html>
