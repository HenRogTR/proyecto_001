<%-- 
    Document   : ventaExcel
    Created on : 12/03/2014, 05:43:44 PM
    Author     : Henrri
--%>
<%@page import="utilitarios.cOtros"%>
<%@page import="java.util.Iterator"%>
<%@page import="personaClases.cPersonal"%>
<%@page import="ventaClases.cVenta"%>
<%@page import="tablas.Personal"%>
<%@page import="utilitarios.cManejoFechas"%>
<%@page import="utilitarios.cValidacion"%>
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

    String fechaInicioString = "";
    String fechaFinString = "";
    Date fechaInicioDate = null;
    Date fechaFinDate = null;
    List VList = null;
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

    String tituloString = " r. venta ";
    String cabeceraString = "";
    String tipo_ = "";
    String tipoSerie = "";
    Integer codVendedorInteger = 0;
    Personal objVendedor = null;
    // ============================= nivel 1 ===================================
    if (reporte.equals("todo_fechas")) {
        VList = new cVenta().leer_todos_fechas_SC(fechaInicioDate, fechaFinDate);
        tipo_ += "GENERAL";
    }
    if (reporte.equals("contado_fechas")) {
        VList = new cVenta().leer_contado_fechas_SC(fechaInicioDate, fechaFinDate);
        tipo_ += "CONTADO";
    }
    if (reporte.equals("credito_fechas")) {
        VList = new cVenta().leer_credito_fechas_SC(fechaInicioDate, fechaFinDate);
        tipo_ += "CRÉDITO";
    }
    // ============================= nivel 2 ===================================
    if (reporte.equals("todo_documento_fechas")) {
        try {
            tipoSerie = request.getParameter("tipoSerie").toString();
        } catch (Exception e) {
            out.print("Tipo y serie no encontradas");
            return;
        }
        VList = new cVenta().leer_documento_todos_fechas_SC(fechaInicioDate, fechaFinDate, tipoSerie);
        tipo_ += "GENERAL : " + tipoSerie;
    }
    if (reporte.equals("contado_documento_fechas")) {
        try {
            tipoSerie = request.getParameter("tipoSerie").toString();
        } catch (Exception e) {
            out.print("Tipo y serie no encontradas");
            return;
        }
        VList = new cVenta().leer_documento_contado_fechas_SC(fechaInicioDate, fechaFinDate, tipoSerie);
        tipo_ += "CONTADO : " + tipoSerie;
    }
    if (reporte.equals("credito_documento_fechas")) {
        try {
            tipoSerie = request.getParameter("tipoSerie").toString();
        } catch (Exception e) {
            out.print("Tipo y serie no encontradas");
            return;
        }
        VList = new cVenta().leer_documento_credito_fechas_SC(fechaInicioDate, fechaFinDate, tipoSerie);
        tipo_ += "CRÉDITO: " + tipoSerie;
    }
    // ============================= nivel 3 ===================================
    if (reporte.equals("todo_vendedor_fechas")) {
        try {
            codVendedorInteger = Integer.parseInt(request.getParameter("codVendedor"));
            objVendedor = new cPersonal().leer_cobradorVendedor(codVendedorInteger);
            if (objVendedor == null) {
                out.print("Vendedor no encontrado.");
                return;
            }
            VList = new cVenta().leer_todos_vendedor_fechas_SC(fechaInicioDate, fechaFinDate, codVendedorInteger);
            tipo_ += " EN GENERAL";
            cabeceraString += "<tr><th colspan=\"4\">VENDEDOR: " + objVendedor.getPersona().getNombres() + "</th></tr>";
        } catch (Exception e) {
            out.print("Código de vendedor no encontrado");
            return;
        }
    }
    if (reporte.equals("contado_vendedor_fechas")) {
        try {
            codVendedorInteger = Integer.parseInt(request.getParameter("codVendedor"));
            objVendedor = new cPersonal().leer_cobradorVendedor(codVendedorInteger);
            if (objVendedor == null) {
                out.print("Vendedor no encontrado.");
                return;
            }
            VList = new cVenta().leer_contado_vendedor_fechas_SC(fechaInicioDate, fechaFinDate, codVendedorInteger);
            cabeceraString += "<tr><th colspan=\"4\">VENDEDOR: " + objVendedor.getPersona().getNombres() + "</th></tr>";
        } catch (Exception e) {
            out.print("Código de vendedor no encontrado");
            return;
        }
    }
    if (reporte.equals("credito_vendedor_fechas")) {
        try {
            codVendedorInteger = Integer.parseInt(request.getParameter("codVendedor"));
            objVendedor = new cPersonal().leer_cobradorVendedor(codVendedorInteger);
            if (objVendedor == null) {
                out.print("Vendedor no encontrado.");
                return;
            }
            VList = new cVenta().leer_credito_vendedor_fechas_SC(fechaInicioDate, fechaFinDate, codVendedorInteger);
            cabeceraString += "<tr><th colspan=\"4\">VENDEDOR: " + objVendedor.getPersona().getNombres() + "</th></tr>";
        } catch (Exception e) {
            out.print("Código de vendedor no encontrado");
            return;
        }
    }
    // ============================= nivel 4 ===================================
    if (reporte.equals("todo_anulado_fechas")) {
        VList = new cVenta().leer_todos_anulado_fechas_SC(fechaInicioDate, fechaFinDate);
        tipo_ += "GENERAL : ANULADOS";
    }
    if (reporte.equals("contado_anulado_fechas")) {
        VList = new cVenta().leer_contado_anulado_fechas_SC(fechaInicioDate, fechaFinDate);
        tipo_ += "CONTADO : ANULADOS";
    }
    if (reporte.equals("credito_anulado_fechas")) {
        VList = new cVenta().leer_credito_anulado_fechas_SC(fechaInicioDate, fechaFinDate);
        tipo_ += "CRÉDITO : ANULADOS";
    }
    if (VList == null) {
        out.print(reporte + " list -> null.");
        return;
    }
    response.setContentType("application/vnd.ms-excel"); //Tipo de fichero.
    response.setHeader("Content-Disposition", "attachment;filename=\"REPORTE VENTA PERIODO " + new cManejoFechas().DateAString2(fechaInicioDate) + " " + new cManejoFechas().DateAString2(fechaFinDate) + " " + new cManejoFechas().fechaHoraActualNumerosLineal() + ".xls\"");
%>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <title>JSP Page</title>
    </head>
    <body>
        <div id="documento">
            <div id="contenido">
                <table style="width: 800px;font-size: 14px;">
                    <thead>
                        <tr>
                            <th colspan="2">REPORTE GENERAL DE VENTAS (<%=tipo_%>) PERIODO <%=fechaInicioString%> - <%=fechaFinString%></th>
                            <th colspan="4" style="text-align: right;"> <%=new cManejoFechas().fechaHoraActual()%></th>
                        </tr>
                        <%=cabeceraString%>
                        <tr class="bottom2" style="font-size: 12px;">                            
                            <th style="width: 90px;">COMPROBANTE</th>
                            <th>NOMBRE/RAZÓN SOCIAL</th>
                            <th style="width: 60px;">IMPORTE</th>
                            <th style="width: 60px;">LETRAS</th>
                            <th style="width: 80px;">OBSERVACIÓN</th>
                        </tr>
                        <%
                            //                          * 0:codCliente, 1:nombresC, 2:codVenta, 3:docSerieNumero, 4:fecha, 5:tipo,
                            //                          * 6:neto, 7:registro, 8:precioReal, 9:montoInicial, 10:cantidadLetras
                            Integer codCliente = 0;
                            String nombresC = "";
                            Integer codVenta = 0;
                            String docSerieNumero = "";
                            Date fecha = null;
                            String tipo = "";
                            Double neto = 0.00;
                            String registro = "";
                            Double precioReal = 0.00;
                            Double montoInicial = 0.00;
                            Object cantidadLetras = "";

                            for (Iterator it = VList.iterator(); it.hasNext();) {
                                Object dato[] = (Object[]) it.next();

                                codCliente = (Integer) dato[0];
                                nombresC = (String) dato[1];
                                codVenta = (Integer) dato[2];
                                docSerieNumero = (String) dato[3];
                                fecha = (Date) dato[4];
                                tipo = (String) dato[5];
                                neto = (Double) dato[6];
                                registro = (String) dato[7];
                                precioReal = (Double) dato[8] == null ? 0.0 : (Double) dato[8];
                                montoInicial = (Double) dato[9];
                                cantidadLetras = dato[10];
                        %>
                        <tr>
                            <td><%=docSerieNumero%></td>
                            <td><%=nombresC%></td>
                            <td style="text-align: right; mso-number-format:'0.00';"><%=new cOtros().decimalFormato(neto, 2)%></td>
                            <td style="text-align: right;"><%=cantidadLetras == null ? "" : cantidadLetras%></td>
                            <td style="text-align: right;"><%=registro.substring(0, 1).equals("0") ? "ANULADO" : ""%></td>
                        </tr>
                        <%
                            }
                        %>
                    </thead>
                </table>
            </div>
        </div>
    </body>
</html>
