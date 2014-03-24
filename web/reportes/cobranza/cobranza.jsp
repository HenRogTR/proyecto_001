<%-- 
    Document   : cobranza
    Created on : 14/03/2014, 07:57:18 PM
    Author     : Henrri
--%>

<%@page import="personaClases.cPersonal"%>
<%@page import="tablas.Personal"%>
<%@page import="utilitarios.cOtros"%>
<%@page import="java.util.Iterator"%>
<%@page import="cobranzaClases.cCobranza"%>
<%@page import="utilitarios.cManejoFechas"%>
<%@page import="utilitarios.cValidacion"%>
<%@page import="java.util.Date"%>
<%@page import="java.util.List"%>
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
    List cobranzaList = null;
    cCobranza objcCobranza = new cCobranza();
    Integer codCobradorInteger = 0;
    Personal objCobrador = null;
    String tipoSerieString = "";

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

    //nivel 1
    if (reporte.equals("todo_todos")) {
        cobranzaList = objcCobranza.leer_todo_todos_fechas_SC(fechaInicioDate, fechaFinDate);
    }
    if (reporte.equals("iniciales_todos")) {
        cobranzaList = objcCobranza.leer_inicial_todos_fechas_SC(fechaInicioDate, fechaFinDate);
    }
    if (reporte.equals("cobranza_todos")) {
        cobranzaList = objcCobranza.leer_cobranza_todos_fechas_SC(fechaInicioDate, fechaFinDate);
    }
    if (reporte.equals("anticipo_todos")) {
        cobranzaList = objcCobranza.leer_anticipo_todos_fechas_SC(fechaInicioDate, fechaFinDate);
    }
    if (reporte.equals("todo_cobrador")) {
        try {
            codCobradorInteger = Integer.parseInt(request.getParameter("codCobrador"));
            objCobrador = new cPersonal().leer_cobradorVendedor(codCobradorInteger);
            if (objCobrador == null) {
                out.print("Cobrador no encontrado.");
                return;
            }
        } catch (Exception e) {
            out.print("Código de cobrador no encontrado");
            return;
        }
        cobranzaList = objcCobranza.leer_todo_cobrador_fechas_SC(fechaInicioDate, fechaFinDate, codCobradorInteger);
        cabeceraString += "<tr><th colspan=\"3\">COBRADOR: " + objCobrador.getPersona().getNombres() + "</th></tr>";
    }
    if (reporte.equals("iniciales_cobrador")) {
        try {
            codCobradorInteger = Integer.parseInt(request.getParameter("codCobrador"));
            objCobrador = new cPersonal().leer_cobradorVendedor(codCobradorInteger);
            if (objCobrador == null) {
                out.print("Cobrador no encontrado.");
                return;
            }
        } catch (Exception e) {
            out.print("Código de cobrador no encontrado");
            return;
        }
        cobranzaList = objcCobranza.leer_inicial_cobrador_fechas_SC(fechaInicioDate, fechaFinDate, codCobradorInteger);
        cabeceraString += "<tr><th colspan=\"3\">COBRADOR: " + objCobrador.getPersona().getNombres() + "</th></tr>";
    }
    if (reporte.equals("cobranza_cobrador")) {
        try {
            codCobradorInteger = Integer.parseInt(request.getParameter("codCobrador"));
            objCobrador = new cPersonal().leer_cobradorVendedor(codCobradorInteger);
            if (objCobrador == null) {
                out.print("Cobrador no encontrado.");
                return;
            }
        } catch (Exception e) {
            out.print("Código de cobrador no encontrado");
            return;
        }
        cobranzaList = objcCobranza.leer_cobranza_cobrador_fechas_SC(fechaInicioDate, fechaFinDate, codCobradorInteger);
        cabeceraString += "<tr><th colspan=\"3\">COBRADOR: " + objCobrador.getPersona().getNombres() + "</th></tr>";
    }
    if (reporte.equals("anticipo_cobrador")) {
        try {
            codCobradorInteger = Integer.parseInt(request.getParameter("codCobrador"));
            objCobrador = new cPersonal().leer_cobradorVendedor(codCobradorInteger);
            if (objCobrador == null) {
                out.print("Cobrador no encontrado.");
                return;
            }
        } catch (Exception e) {
            out.print("Código de cobrador no encontrado");
            return;
        }
        cobranzaList = objcCobranza.leer_anticipo_cobrador_fechas_SC(fechaInicioDate, fechaFinDate, codCobradorInteger);
        cabeceraString += "<tr><th colspan=\"3\">COBRADOR: " + objCobrador.getPersona().getNombres() + "</th></tr>";
    }

    //nivel 2
    if (reporte.equals("todo_documento_todos")) {
        try {
            tipoSerieString = request.getParameter("documento").toString();
        } catch (Exception e) {
            out.print("Tipo y/o serie no encontrada.");
            return;
        }
        cobranzaList = objcCobranza.leer_todo_documento_todos_fechas_SC(fechaInicioDate, fechaFinDate, tipoSerieString);
    }
    if (reporte.equals("todo_documento_cobrador")) {
        try {
            tipoSerieString = request.getParameter("documento").toString();
            codCobradorInteger = Integer.parseInt(request.getParameter("codCobrador"));
            objCobrador = new cPersonal().leer_cobradorVendedor(codCobradorInteger);
            if (objCobrador == null) {
                out.print("Cobrador no encontrado.");
                return;
            }
            cobranzaList = objcCobranza.leer_todo_documento_cobrador_fechas_SC(fechaInicioDate, fechaFinDate, tipoSerieString, codCobradorInteger);
        } catch (Exception e) {
            out.print("Tipo y/o serie no encontrada - código de cobrador no encontrado.");
            return;
        }
    }
    //nivel 3
    if (reporte.equals("todo_anulado_todos")) {
        cobranzaList = objcCobranza.leer_todo_anulado_todos_fechas_SC(fechaInicioDate, fechaFinDate);
    }
    if (reporte.equals("todo_anulado_cobrador")) {
        try {
            codCobradorInteger = Integer.parseInt(request.getParameter("codCobrador"));
            objCobrador = new cPersonal().leer_cobradorVendedor(codCobradorInteger);
            if (objCobrador == null) {
                out.print("Cobrador no encontrado.");
                return;
            }
        } catch (Exception e) {
            out.print("Código de cobrador no encontrado");
            return;
        }
        cobranzaList = objcCobranza.leer_todo_anulado_cobrador_fechas_SC(fechaInicioDate, fechaFinDate, codCobradorInteger);
        cabeceraString += "<tr><th colspan=\"3\">COBRADOR: " + objCobrador.getPersona().getNombres() + "</th></tr>";
    }

    if (cobranzaList == null) {
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
                        <tr>
                            <th style="text-align: left;" colspan="3">REPORTE DE COBRANZA PERIODO <%=fechaInicioString%> / <%=fechaFinString%></th>                
                            <th style="text-align: right;" colspan="3"><%=new cManejoFechas().fechaHoraActual()%></th>
                        </tr>
                        <%=cabeceraString%>
                        <tr class="top2 bottom2">
                            <th style="width: 80px;">Fecha</th>
                            <th style="width: 70px;">Código</th>
                            <th>Nombre/Razón Social</th>
                            <th style="width: 100px;">Recibo</th>
                            <th style="width: 70px;">Importe</th>
                            <th style="width: 80px;">Observación</th>
                        </tr>
                        <%
                            //variables
                            Integer codCliente = 0;
                            String nombresC = "";
                            Integer codCobranza = 0;
                            Date fechaCobranza = null;
                            String docSerieNumero = "";
                            Double total = 0.00;
                            String registro = "";

                            Date fechaAuxDate = null;

                            Double cobranzaDiariaTotal = 0.00;
                            Double cobranzaPeriodoTotal = 0.00;

                            for (Iterator it = cobranzaList.iterator(); it.hasNext();) {
                                Object dato[] = (Object[]) it.next();
                                codCliente = (Integer) dato[0];
                                nombresC = (String) dato[1];
                                codCobranza = (Integer) dato[2];
                                fechaCobranza = (Date) dato[3];
                                docSerieNumero = (String) dato[4];
                                total = (Double) dato[5];
                                registro = (String) dato[6];

                                if (fechaAuxDate == null || fechaAuxDate.compareTo(fechaCobranza) < 0) {//para imprimir la cabecera de inicio de un nuevo periodo
                                    if (fechaAuxDate != null) {//si es primera vez
%>
                        <tr class="top3">
                            <td></td>
                            <td></td>
                            <td></td>
                            <th colspan="2" class="derecha" style="padding-right: 5px;"><%=new cOtros().decimalFormato(cobranzaDiariaTotal, 2)%></th>
                        </tr>
                        <%
                            }
                            fechaAuxDate = fechaCobranza;

                            cobranzaPeriodoTotal += cobranzaDiariaTotal;
                            cobranzaDiariaTotal = 0.00;

                        %>
                        <tr class="top2">
                            <td style="font-weight:bold;"><%=new cManejoFechas().DateAString(fechaCobranza)%></td>
                        </tr>
                        <%
                            }
                        %>
                        <tr>
                            <td></td>
                            <td class="centrado"><%=new cOtros().agregarCeros_int(codCliente, 8)%></td>
                            <td><%=nombresC%></td>
                            <td class="izquierda" style="padding-left: 5px;"><%=docSerieNumero%> </td>
                            <td class="derecha" style="padding-right: 5px;"><%=new cOtros().decimalFormato(total, 2)%></td>
                            <td class="izquierda"><%=registro.substring(0, 1).equals("0") ? "ANULADO" : ""%></td>
                        </tr>
                        <%
                            cobranzaDiariaTotal += total;
                            if (!it.hasNext()) {                                //si ya no hay mas elementos por recorrer
                        %>
                        <tr class="top3">
                            <td></td>
                            <td></td>
                            <td></td>
                            <th colspan="2" class="derecha" style="padding-right: 5px;"><%=new cOtros().decimalFormato(cobranzaDiariaTotal, 2)%></th>
                        </tr>
                        <%
                                    cobranzaPeriodoTotal += cobranzaDiariaTotal;
                                }
                            }
                        %>
                        <tr class="top3">
                            <td></td>
                            <td></td>
                            <td class="derecha" style="font-weight: bold;">TOTAL GENERAL</td>
                            <th colspan="2" class="derecha" style="padding-right: 5px;"><%=new cOtros().decimalFormato(cobranzaPeriodoTotal, 2)%></th>
                        </tr>
                    </tbody>
                </table>
            </div>
        </div>
    </body>
</html>
