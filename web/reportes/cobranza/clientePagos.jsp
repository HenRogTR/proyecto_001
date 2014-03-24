<%-- 
    Document   : clientePagos
    Created on : 17/03/2014, 11:33:29 PM
    Author     : Henrri
--%>

<%@page import="utilitarios.cOtros"%>
<%@page import="java.util.Iterator"%>
<%@page import="utilitarios.cManejoFechas"%>
<%@page import="utilitarios.cValidacion"%>
<%@page import="tablas.Personal"%>
<%@page import="cobranzaClases.cCobranza"%>
<%@page import="java.util.List"%>
<%@page import="java.util.Date"%>
<%
    String reporte = "";
    try {
        reporte = request.getParameter("reporte").toString();
    } catch (Exception e) {
        out.print("Parámetro reporte no encontrado.");
        return;
    }
    String tituloString = " r. cobranza ";
    String cabeceraString = "";
    String orden = "";

    String fechaInicioString = "";
    String fechaFinString = "";
    Date fechaInicioDate = null;
    Date fechaFinDate = null;
    List clientePagosList = null;
    cCobranza objcCobranza = new cCobranza();
    Integer codCobradorInteger = 0;
    Personal objCobrador = null;

    try {
        fechaInicioString = request.getParameter("fechaInicio").toString();
        fechaFinString = request.getParameter("fechaFin").toString();
        if (!(new cValidacion().validarFecha(fechaInicioString)) || !(new cValidacion().validarFecha(fechaFinString))) {
            out.print("Fecha y/o formato de fecha incorrecta.");
            return;
        }
        fechaInicioDate = new cManejoFechas().StringADate(fechaInicioString);
        fechaFinDate = new cManejoFechas().StringADate(fechaFinString);
        if (fechaInicioDate.compareTo(fechaFinDate) > 0) {
            out.print("Las fechas estan fuera de rango.");
            return;
        }
    } catch (Exception e) {
        out.print("Fechas no encontradas.");
        return;
    }
    if (reporte.equals("todo_pago_todos")) {
        clientePagosList = objcCobranza.leer_cobranzaPagos_todos(fechaInicioDate, fechaFinDate);
    }

    if (clientePagosList == null) {
        out.print(reporte + " list -> null. <br>Error -> " + objcCobranza.getError());
        return;
    }
%>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <title><%=tituloString%></title>
        <link rel="stylesheet" type="text/css" href="../../librerias/principal/bodyPrint.css" media="screen"/>
        <link rel="stylesheet" type="text/css" href="../../librerias/principal/bodyPrint.css" media="print"/>
    </head>
    <body>
        <div id="documento">
            <div id="contenido">
                <table class="anchoTotal" style="font-size: 11px;">
                    <tbody>
                        <tr class="bottom2">
                            <th class="izquierda" colspan="3">REPORTE DE COBRANZA - <%=fechaInicioString%> a <%=fechaFinString%></th>                
                            <th class="derecha" colspan="3"><%=new cManejoFechas().fechaHoraActual()%></th>
                        </tr>
                        <tr>
                            <th class="ancho80px">Cod. Cliente</th>
                            <th class="ancho100px">Fecha</th>
                            <th>Cliente/Doc. Serie Número</th>
                            <th class="ancho80px">Monto</th>
                            <th class="ancho320px">Observación</th>
                        </tr>
                        <%
                            Integer codCliente = 0;
                            String nombresC = "";
                            Integer codCobranza = 0;
                            Date fechaCobranza = null;
                            String docSerieNumero = "";
                            Double total = 0.00;
                            String registro = "";
                            String observacion = "";

                            Integer codClienteAux = 0;

                            for (Iterator it = clientePagosList.iterator(); it.hasNext();) {
                                Object dato[] = (Object[]) it.next();
                                codCliente = (Integer) dato[0];
                                nombresC = (String) dato[1];
                                codCobranza = (Integer) dato[2];
                                fechaCobranza = (Date) dato[3];
                                docSerieNumero = (String) dato[4];
                                total = (Double) dato[5];
                                registro = (String) dato[6];
                                observacion = (String) dato[7];
                                if (!codClienteAux.equals(codCliente)) {
                        %>
                        <tr class="top1">
                            <th style="padding-left: 10px;"><%=new cOtros().agregarCeros_int(codCliente, 8)%></th>                            
                            <th></th>
                            <th colspan="3"><%=nombresC%></th>
                        </tr>
                        <%
                                codClienteAux = codCliente;
                            }
                        %>
                        <tr>
                            <td></td>
                            <td class="derecha" style="padding-right: 10px;"><%=new cManejoFechas().DateAString(fechaCobranza)%></td>
                            <td style="padding-left: 20px;" ><%=docSerieNumero%></td>
                            <td class="derecha" style="padding-right: 10px;"><%=new cOtros().decimalFormato(total, 2)%></td>
                            <td><%=registro.substring(0, 1).equals("1") ? new cOtros().replace_comillas_comillasD_barraInvertida(observacion.toUpperCase()) : "*****ANULADO*****"%></td>
                        </tr>
                        <%                                    }
                        %>
                    </tbody>
                </table>
            </div>
        </div>
    </body>
</html>
