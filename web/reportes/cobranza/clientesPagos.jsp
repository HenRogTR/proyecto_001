<%-- 
    Document   : clientesPagos
    Created on : 07/06/2013, 10:11:15 PM
    Author     : Henrri
--%>

<%@page import="tablas.Cobranza"%>
<%@page import="cobranzaClases.cCobranza"%>
<%@page import="otros.cManejoFechas"%>
<%@page import="java.util.*"%>
<%@page import="otros.cUtilitarios"%>
<%
    Date fechaInicio = null;
    Date fechaFin = null;
    List lCobranza = null;
    cUtilitarios objcUtilitarios = new cUtilitarios();
    cManejoFechas objcManejoFechas = new cManejoFechas();
    cCobranza objcCobranza = new cCobranza();
    try {
        fechaInicio = objcManejoFechas.caracterADate(request.getParameter("fecha1"));
        fechaFin = objcManejoFechas.caracterADate(request.getParameter("fecha2"));
        lCobranza = objcCobranza.leer_cobranzaGeneral(fechaInicio, fechaFin);
        if (lCobranza == null) {
            out.print("Error en consulta de cobranza: " + objcCobranza.getError());
            return;
        }
    } catch (Exception e) {
        out.print("Error en parametros: " + e.getMessage());
        return;
    }
%>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <title><%=objcUtilitarios.fechaHoraActualNumerosLineal()%> letras de pagos.</title>
        <link rel="stylesheet" type="text/css" href="../../lib/propios/css/paginaImprimir/bodyPrint.css" media="screen"/>
        <link rel="stylesheet" type="text/css" href="../../lib/propios/css/paginaImprimir/bodyPrint.css" media="print"/>
    </head>
    <body>
        <div id="documento">
            <div id="contenido">
                <table style="font-size: 11px; width: 800px;">
                    <thead>
                        <tr class="bottom2">
                            <th style="text-align: left;" colspan="3">REPORTE DE COBRANZA - <%=objcUtilitarios.fechaDateToString(fechaInicio)%> a <%=objcUtilitarios.fechaDateToString(fechaFin)%></th>                
                            <th style="text-align: right;" colspan="3"><%=objcUtilitarios.fechaHoraActual()%></th>
                        </tr>
                        <tr>
                            <th style="width: 120px;">Cod. Cliente/ Fecha</th>
                            <th colspan="2">Cliente/Doc. Serie Número - Monto</th>
                        </tr>
                    </thead>
                    <tbody>
                        <%
                            int codCliente = 0;
                            Iterator iCobranza = lCobranza.iterator();
                            while (iCobranza.hasNext()) {
                                Cobranza objCobranza = (Cobranza) iCobranza.next();
                                if (codCliente != objCobranza.getPersona().getCodPersona()) {
                        %>
                        <tr class="top1">
                            <th><%=objcUtilitarios.agregarCeros_int(objCobranza.getPersona().getCodPersona(), 8)%></th>
                            <th colspan="3"><%=objCobranza.getPersona().getNombresC()%></th>
                        </tr>
                        <%
                                codCliente = objCobranza.getPersona().getCodPersona();
                            }
                        %>
                        <tr>
                            <td style="text-align: right; "><%=objcManejoFechas.fechaDateToString(objCobranza.getFechaCobranza())%></td>
                            <td style="padding-left: 20px; width: 150px;"><%=objCobranza.getDocSerieNumero()%></td>
                            <td style="text-align: right; padding-right: 10px; width: 100px; "><%=objcUtilitarios.agregarCerosNumeroFormato(objcUtilitarios.redondearDecimales(objCobranza.getImporte() + objCobranza.getSaldo(), 2), 2)%></td>
                            <td><%=objCobranza.getRegistro().substring(0, 1).equals("1") ? objCobranza.getObservacion().replace("\n", "<br>").toUpperCase() : "*****ANULADO*****"%></td>
                        </tr>
                        <%
                            }
                        %>
                    </tbody>
                </table>
            </div>
        </div>
    </body>
</html>
