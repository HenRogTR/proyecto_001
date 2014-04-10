<%-- 
    Document   : anulados
    Created on : 07/06/2013, 10:11:03 PM
    Author     : Henrri
--%>

<%@page import="tablas.Cobranza"%>
<%@page import="java.util.Iterator"%>
<%@page import="cobranzaClases.cCobranza"%>
<%@page import="java.util.ArrayList"%>
<%@page import="java.util.List"%>
<%@page import="otros.cManejoFechas"%>
<%@page import="java.util.Date"%>
<%@page import="otros.cUtilitarios"%>
<%
//    String tipo = "";
    Date fechaInicio = new Date();
    Date fechaFin = new Date();
    List lCobranza = new ArrayList();
    try {
        fechaInicio = new cManejoFechas().caracterADate(request.getParameter("fecha1"));
        fechaFin = new cManejoFechas().caracterADate(request.getParameter("fecha2"));
        if (fechaInicio.after(fechaFin)) {
            out.print("El peridodo esta mal");
            return;
        }
        cCobranza objcCobranza = new cCobranza();
        lCobranza = objcCobranza.leer_anulados_fechaInicio_fechaFin(fechaInicio, fechaFin);
        if (lCobranza == null) {
            out.print("Error en consulta de cobranza:" + objcCobranza.getError());
            return;
        }
    } catch (Exception e) {
        out.print("Error");
        return;
    }
    cUtilitarios objcUtilitarios = new cUtilitarios();
%>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <title><%=objcUtilitarios.fechaHoraActualNumerosLineal()%> reporte cobranza</title>
        <link rel="stylesheet" type="text/css" href="../../lib/propios/css/paginaImprimir/bodyPrint.css" media="screen"/>
        <link rel="stylesheet" type="text/css" href="../../lib/propios/css/paginaImprimir/bodyPrint.css" media="print"/>
    </head>
    <body>
        <div id="documento">
            <div id="contenido">
                <table style="font-size: 11px; width: 800px;">
                    <tr class="bottom2">
                        <th style="text-align: left;" colspan="3">REPORTE DE COBRANZA - <%=objcUtilitarios.fechaDateToString(fechaInicio)%> a <%=objcUtilitarios.fechaDateToString(fechaFin)%> - ANULADOS</th>                
                        <th style="text-align: right;" colspan="3"><%=objcUtilitarios.fechaHoraActual()%></th>
                    </tr>
                    <tr class="bottom2">
                        <th style="width: 80px;">Fecha</th>
                        <th style="width: 70px;">Código</th>
                        <th>Nombre/Razon Social</th>
                        <th style="width: 80px;">Recibo</th>
                        <th style="width: 70px;">Importe</th>
                        <th style="width: 80px;">Obs.</th>
                    </tr>
                    <%
                        Iterator i = lCobranza.iterator();
                        Date aux = new Date();
                        int con = 0;
                        Double montodiario = 0.00;
                        Double montoGeneral = 0.00;
                        while (i.hasNext()) {
                            Cobranza objCobranza = (Cobranza) i.next();
                            if (con++ == 0) {
                                aux = objCobranza.getFechaCobranza();
                    %>
                    <tr>
                        <td style="font-weight: bold;"><%=new cManejoFechas().fechaDateToString(objCobranza.getFechaCobranza())%></td>
                    </tr>
                    <%
                        }
                        if (objCobranza.getFechaCobranza().after(aux)) {
                            aux = objCobranza.getFechaCobranza();
                    %>
                    <tr class="top3">
                        <td></td>
                        <td></td>
                        <td></td>
                        <th colspan="2"  style="text-align: right;"><%=objcUtilitarios.agregarCerosNumeroFormato(objcUtilitarios.redondearDecimales(montodiario, 2), 2)%></th>
                    </tr>
                    <tr>
                        <td style="font-weight:bold; "><%=new cManejoFechas().fechaDateToString(objCobranza.getFechaCobranza())%></td>
                    </tr>
                    <%
                            montodiario = 0.00;
                        }
                    %>
                    <tr>
                        <td></td>
                        <td style="text-align: center;"><%=objcUtilitarios.agregarCeros_int(objCobranza.getPersona().getCodPersona(), 8)%></td>
                        <td><%=objCobranza.getPersona().getNombresC()%></td>
                        <td style="text-align: center;"><%=objCobranza.getDocSerieNumero()%></td>
                        <td style="text-align: right;"><%=objcUtilitarios.agregarCerosNumeroFormato(objcUtilitarios.redondearDecimales(objCobranza.getImporte() + objCobranza.getSaldo(), 2), 2)%></td>
                        <td style="text-align: center;">
                            <%
                                if (objCobranza.getRegistro().substring(0, 1).equals("0")) {
                            %>
                            //Anulado
                            <%                            }
                            %>
                        </td>
                    </tr>
                    <%
                            montodiario += objCobranza.getImporte() + objCobranza.getSaldo();
                            montoGeneral += objCobranza.getImporte() + objCobranza.getSaldo();
                        }
                    %>
                    <tr class="top3">
                        <td></td>
                        <td></td>
                        <td></td>
                        <th colspan="2" style="text-align: right;"><%=objcUtilitarios.agregarCerosNumeroFormato(objcUtilitarios.redondearDecimales(montodiario, 2), 2)%></th>
                    </tr>
                    <tr class="top3">
                        <td></td>
                        <td></td>
                        <td style="text-align: right;font-weight: bold;">TOTAL GENERAL</td>
                        <th colspan="2" style="text-align: right;"><%=objcUtilitarios.agregarCerosNumeroFormato(objcUtilitarios.redondearDecimales(montoGeneral, 2), 2)%></th>
                    </tr>
                </table>
            </div>
        </div>
    </body>
</html>
