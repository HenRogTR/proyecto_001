<%-- 
    Document   : tramoExcel
    Created on : 11/03/2014, 11:14:36 AM
    Author     : Henrri
--%>


<%@page import="personaClases.cEmpresaConvenio"%>
<%@page import="personaClases.cPersonal"%>
<%@page import="utilitarios.cOtros"%>
<%@page import="java.util.Iterator"%>
<%@page import="ventaClases.cVentaCreditoLetraReporte"%>
<%@page import="utilitarios.cManejoFechas"%>
<%@page import="utilitarios.cValidacion"%>
<%@page import="tablas.EmpresaConvenio"%>
<%@page import="tablas.Personal"%>
<%@page import="java.util.Date"%>
<%@page import="java.util.List"%>
<%
    String reporte = "";
    try {
        reporte = request.getParameter("reporte").toString();
    } catch (Exception e) {
        out.print("Reporte no definido.");
        return;
    }
    String titleString = "";
    String cabeceraString = "";
    String nombreArchivoString = "";

    String orden = "";
    String fechaString = "";
    Date fechaDate = null;
    List LVList = null;

    Integer codCobradorInteger = 0;
    Personal objCobrador = null;
    Integer codECInteger = 0;
    EmpresaConvenio objEC = null;

    try {
        fechaString = request.getParameter("fechaVencimiento").toString();
        if (!new cValidacion().validarFecha(fechaString)) {
            out.print("Fecha y/o formato de fecha incorrecta.");
            return;
        }
        fechaDate = new cManejoFechas().StringADate(fechaString);
    } catch (Exception e) {
        out.print("Fecha de vencimiento no encontrada.");
        return;
    }

    //========================== 1 nivel =======================================
    if (reporte.equals("nombresC_todos")) {
        LVList = new cVentaCreditoLetraReporte().letrasVencidasTramos_todos_ordenNombresC_SC();
        orden += "APELLIDOS-NOMBRES/RAZÓN SOCIAL ";
    }
    if (reporte.equals("nombresC_cobrador")) {
        try {
            codCobradorInteger = Integer.parseInt(request.getParameter("codCobrador"));
            objCobrador = new cPersonal().leer_cobradorVendedor(codCobradorInteger);
            if (objCobrador == null) {
                out.print("Cobrador no encontrado.");
                return;
            }
            LVList = new cVentaCreditoLetraReporte().letrasVencidasTramos_cobrador_ordenNombresC_SC(codCobradorInteger);
            orden += "APELLIDOS-NOMBRES/RAZÓN SOCIAL ";
            cabeceraString += "<tr><th colspan=\"5\">COBRADOR: " + objCobrador.getPersona().getNombres() + "</th></tr>";
        } catch (Exception e) {
            out.print("Código de cobrador no encontrado");
            return;
        }
    }
    if (reporte.equals("direccion_todos")) {
        LVList = new cVentaCreditoLetraReporte().letrasVencidasTramos_todos_ordenDireccion_SC();
        orden += "DIRECCIÓN ";
    }
    if (reporte.equals("direccion_cobrador")) {
        try {
            codCobradorInteger = Integer.parseInt(request.getParameter("codCobrador"));
            objCobrador = new cPersonal().leer_cobradorVendedor(codCobradorInteger);
            if (objCobrador == null) {
                out.print("Cobrador no encontrado.");
                return;
            }
            LVList = new cVentaCreditoLetraReporte().letrasVencidasTramos_cobrador_ordenDireccion_SC(codCobradorInteger);
            orden += "DIRECCIÓN ";
            cabeceraString += "<tr><th colspan=\"5\">COBRADOR: " + objCobrador.getPersona().getNombres() + "</th></tr>";
        } catch (Exception e) {
            out.print("Código de cobrador no encontrado");
            return;
        }
    }
    //========================== 2 nivel Empresa/Convenio ======================
    if (reporte.equals("nombresC_EC_todos")) {                                  //2-1
        try {
            codECInteger = Integer.parseInt(request.getParameter("codEC"));
            objEC = new cEmpresaConvenio().leer_cod(codECInteger);
            if (objEC == null) {
                out.print("Empresa no encontrada");
                return;
            }
            LVList = new cVentaCreditoLetraReporte().letrasVencidasTramos_empresaConvenio_todos_ordenNombresC_SC(codECInteger);
            orden += "APELLIDOS-NOMBRES/RAZÓN SOCIAL ";
            cabeceraString = "<tr><th colspan=\"5\">EMPRESA/CONVENIO: " + objEC.getNombre() + "</th></tr>";
        } catch (Exception e) {
            out.print("Código de cobrador y/o empresa no encontrado");
            return;
        }
    }
    if (reporte.equals("direccion_EC_todos")) {                                 //2-1
        try {
            codECInteger = Integer.parseInt(request.getParameter("codEC"));
            objEC = new cEmpresaConvenio().leer_cod(codECInteger);
            if (objEC == null) {
                out.print("Empresa no encontrada");
                return;
            }
            LVList = new cVentaCreditoLetraReporte().letrasVencidasTramos_empresaConvenio_todos_ordenDireccion_SC(codECInteger);
            orden += "DIRECCIÓN ";
            cabeceraString = "<tr><th colspan=\"5\">EMPRESA/CONVENIO: " + objEC.getNombre() + "</th></tr>";
        } catch (Exception e) {
            out.print("Código de cobrador y/o empresa no encontrado");
            return;
        }
    }
    if (reporte.equals("nombresC_EC_cobrador")) {                               //2-2
        try {
            codCobradorInteger = Integer.parseInt(request.getParameter("codCobrador"));
            objCobrador = new cPersonal().leer_cobradorVendedor(codCobradorInteger);
            if (objCobrador == null) {
                out.print("Cobrador no encontrado.");
                return;
            }
            codECInteger = Integer.parseInt(request.getParameter("codEC"));
            objEC = new cEmpresaConvenio().leer_cod(codECInteger);
            if (objEC == null) {
                out.print("Empresa no encontrada");
                return;
            }
            LVList = new cVentaCreditoLetraReporte().letrasVencidasTramos_empresaConvenio_cobrador_ordenNombresC_SC(codECInteger, codCobradorInteger);
            orden += "APELLIDOS-NOMBRES/RAZÓN SOCIAL ";
            cabeceraString = "<tr><th colspan=\"5\">EMPRESA/CONVENIO: " + objEC.getNombre() + "</th></tr>";
            cabeceraString += "<tr><th colspan=\"5\">COBRADOR: " + objCobrador.getPersona().getNombres() + "</th></tr>";
        } catch (Exception e) {
            out.print("Código de cobrador y/o empresa no encontrado");
            return;
        }
    }
    if (reporte.equals("direccion_EC_cobrador")) {                              //2-4
        try {
            codCobradorInteger = Integer.parseInt(request.getParameter("codCobrador"));
            objCobrador = new cPersonal().leer_cobradorVendedor(codCobradorInteger);
            if (objCobrador == null) {
                out.print("Cobrador no encontrado.");
                return;
            }
            codECInteger = Integer.parseInt(request.getParameter("codEC"));
            objEC = new cEmpresaConvenio().leer_cod(codECInteger);
            if (objEC == null) {
                out.print("Empresa no encontrada");
                return;
            }
            LVList = new cVentaCreditoLetraReporte().letrasVencidasTramos_empresaConvenio_cobrador_ordenDireccion_SC(codECInteger, codCobradorInteger);
            orden += "DIRECCIÓN ";
            cabeceraString = "<tr><th colspan=\"5\">EMPRESA/CONVENIO: " + objEC.getNombre() + "</th></tr>";
            cabeceraString += "<tr><th colspan=\"5\">COBRADOR: " + objCobrador.getPersona().getNombres() + "</th></tr>";
        } catch (Exception e) {
            out.print("Código de cobrador y/o empresa no encontrado");
            return;
        }
    }
    response.setContentType("application/vnd.ms-excel"); //Tipo de fichero.
    response.setHeader("Content-Disposition", "attachment;filename=\"LETRAS VENCIDAS - TRAMOS AL " + new cManejoFechas().DateAString2(fechaDate) + " " + nombreArchivoString + " " + new cManejoFechas().fechaHoraActualNumerosLineal() + ".xls\"");
%>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <title>JSP Page</title>
        <link rel="stylesheet" type="text/css" href="../../librerias/principal/bodyPrint.css" media="screen"/>
        <link rel="stylesheet" type="text/css" href="../../librerias/principal/bodyPrint.css" media="print"/>
    </head>
    <body>
        <div id="documento" style="width: 2350px;">
            <div id="contenido">
                <table style="font-size: 14px;width: 2350px;">
                    <thead>
                        <tr>
                            <th colspan="11"><label>REPORTE POR TRAMOS <%=fechaString%> x <%=orden%></label></th>
                        </tr>
                        <%=cabeceraString%>
                        <tr class="top2 bottom1" style="font-size: 11px;">
                            <th style="width: 100px;"><label>Documento</label></th>
                            <th style="width: 80px;"><label>F. Venta</label></th>
                            <th style="width: 100px;"><label>Dni/Ruc</label></th>
                            <th style=""><label>Ape-Nombres/Razón Social</label></th>
                            <th style="width: 550px;"><label>Dirección</label></th>
                            <th style="width: 70px;"><label>M. Crédito</label></th>
                            <th style="width: 90px;"><label>Deuda Actual</label></th>
                            <th style="width: 90px;"><label>151-más(Días)</label></th>
                            <th style="width: 90px;"><label>121-150(Días)</label></th>
                            <th style="width: 80px;"><label>91-120(Días)</label></th>                            
                            <th style="width: 70px;"><label>61-90(Días)</label></th>
                            <th style="width: 70px;"><label>31-60(Días)</label></th>
                            <th style="width: 70px;"><label>1-30(Días)</label></th>
                            <th style="width: 70px;"><label>0-30(Días)</label></th>
                            <th style="width: 70px;"><label>31-60(Días)</label></th>
                            <th style="width: 70px;"><label>61-90(Días)</label></th>
                            <th style="width: 70px;"><label>91-120(Días)</label></th>
                            <th class="ancho80px"><label>121-150(Días)</label></th>
                            <th class="ancho80px"><label>151-más(Días)</label></th>
                        </tr>
                    </thead>
                    <tbody>
                        <%
                            Integer codVenta = 0;
                            String docSerieNumero = "";
                            Date fecha = null;
                            String identificacion = "";
                            String cliente = "";
                            String direccion = "";
                            Double neto = 0.00;
                            Integer codVentaCreditoLetra = 0;
                            Date fechaVencimiento = null;
                            Double monto = 0.00;
                            Double totalPago = 0.00;

                            Integer codVentaAux = 0;

                            Double deudaActual = 0.00;

                            Double aDeber151_mas = 0.00;
                            Double aDeber121_150 = 0.00;
                            Double aDeber91_120 = 0.00;
                            Double aDeber61_90 = 0.00;
                            Double aDeber31_60 = 0.00;
                            Double aDeber1_30 = 0.00;
                            Double deuda0_30 = 0.00;
                            Double deuda31_60 = 0.00;
                            Double deuda61_90 = 0.00;
                            Double deuda91_120 = 0.00;
                            Double deuda121_150 = 0.00;
                            Double deuda151_mas = 0.00;

                            int contador = 0;

                            for (Iterator it = LVList.iterator(); it.hasNext();) {
                                Object dato[] = (Object[]) it.next();

                                codVenta = (Integer) dato[0];

                                if (contador++ == 0) {
                                    codVentaAux = codVenta;
                                }

                                if (!codVentaAux.equals(codVenta)) {
                                    //imprimimos datos anteriores
%>
                        <tr>
                            <td><%=docSerieNumero%></td>
                            <td><%=new cManejoFechas().DateAString(fecha)%></td>
                            <td style="text-align: right; padding-right: 10px; mso-number-format:'@';"><%=identificacion%></td>
                            <td class="izquierda"><%=cliente%></td>
                            <td class="izquierda"><%=direccion%></td>
                            <td style="text-align: right;mso-number-format:'0.00';"><%=new cOtros().decimalFormato(neto, 2)%></td>
                            <td style="text-align: right;mso-number-format:'0.00';"><%=new cOtros().decimalFormato(deudaActual, 2)%></td>
                            <td style="text-align: right;mso-number-format:'0.00'; background-color: #00cc33;"><%=new cOtros().decimalFormato(aDeber151_mas, 2)%></td>
                            <td style="text-align: right;mso-number-format:'0.00'; background-color: #00cc33;"><%=new cOtros().decimalFormato(aDeber121_150, 2)%></td>
                            <td style="text-align: right;mso-number-format:'0.00'; background-color: #00cc33;"><%=new cOtros().decimalFormato(aDeber91_120, 2)%></td>
                            <td style="text-align: right;mso-number-format:'0.00'; background-color: #00cc33;"><%=new cOtros().decimalFormato(aDeber61_90, 2)%></td>
                            <td style="text-align: right;mso-number-format:'0.00'; background-color: #00cc33;"><%=new cOtros().decimalFormato(aDeber31_60, 2)%></td>
                            <td style="text-align: right;mso-number-format:'0.00'; background-color: #00cc33;"><%=new cOtros().decimalFormato(aDeber1_30, 2)%></td>
                            <td style="text-align: right;mso-number-format:'0.00'; background-color: #ff9999"><%=new cOtros().decimalFormato(deuda0_30, 2)%></td>
                            <td style="text-align: right;mso-number-format:'0.00'; background-color: #ff9999"><%=new cOtros().decimalFormato(deuda31_60, 2)%></td>
                            <td style="text-align: right;mso-number-format:'0.00'; background-color: #ff9999"><%=new cOtros().decimalFormato(deuda61_90, 2)%></td>
                            <td style="text-align: right;mso-number-format:'0.00'; background-color: #ff9999"><%=new cOtros().decimalFormato(deuda91_120, 2)%></td>
                            <td style="text-align: right;mso-number-format:'0.00'; background-color: #ff9999"><%=new cOtros().decimalFormato(deuda121_150, 2)%></td>
                            <td style="text-align: right;mso-number-format:'0.00'; background-color: #ff9999"><%=new cOtros().decimalFormato(deuda151_mas, 2)%></td>
                        </tr>
                        <%
                                    codVentaAux = codVenta;

                                    //reiniciamos
                                    deudaActual = 0.00;

                                    aDeber151_mas = 0.00;
                                    aDeber121_150 = 0.00;
                                    aDeber91_120 = 0.00;
                                    aDeber61_90 = 0.00;
                                    aDeber31_60 = 0.00;
                                    aDeber1_30 = 0.00;
                                    deuda0_30 = 0.00;
                                    deuda31_60 = 0.00;
                                    deuda61_90 = 0.00;
                                    deuda91_120 = 0.00;
                                    deuda121_150 = 0.00;
                                    deuda151_mas = 0.00;

                                }
                                docSerieNumero = (String) dato[1];
                                fecha = (Date) dato[2];
                                identificacion = (String) dato[3];
                                cliente = (String) dato[4];
                                direccion = (String) dato[5];
                                neto = (Double) dato[6];
                                codVentaCreditoLetra = (Integer) dato[7];
                                fechaVencimiento = (Date) dato[8];
                                monto = (Double) dato[9];
                                totalPago = (Double) dato[10];
                                deudaActual += monto - totalPago;
                                if (fechaVencimiento.before(fechaDate)) {//inicio letras vencidas
                                    if (new cManejoFechas().StringADate(new cManejoFechas().fechaSumarDias(fechaDate, -31)).before(fechaVencimiento)) {
                                        deuda0_30 += monto - totalPago;
                                    } else {
                                        if (new cManejoFechas().StringADate(new cManejoFechas().fechaSumarDias(fechaDate, -61)).before(fechaVencimiento)) {
                                            deuda31_60 += monto - totalPago;
                                        } else {
                                            if (new cManejoFechas().StringADate(new cManejoFechas().fechaSumarDias(fechaDate, -91)).before(fechaVencimiento)) {
                                                deuda61_90 += monto - totalPago;
                                            } else {
                                                if (new cManejoFechas().StringADate(new cManejoFechas().fechaSumarDias(fechaDate, -121)).before(fechaVencimiento)) {
                                                    deuda91_120 += monto - totalPago;
                                                } else {
                                                    if (new cManejoFechas().StringADate(new cManejoFechas().fechaSumarDias(fechaDate, -151)).before(fechaVencimiento)) {
                                                        deuda121_150 += monto - totalPago;
                                                    } else {
                                                        deuda151_mas += monto - totalPago;
                                                    }
                                                }
                                            }
                                        }
                                    }
                                } else {//fin letras vencidas
                                    if (new cManejoFechas().StringADate(new cManejoFechas().fechaSumarDias(fechaDate, 30)).after(fechaVencimiento)) {
                                        aDeber1_30 += monto - totalPago;
                                    } else {
                                        if (new cManejoFechas().StringADate(new cManejoFechas().fechaSumarDias(fechaDate, 60)).after(fechaVencimiento)) {
                                            aDeber31_60 += monto - totalPago;
                                        } else {
                                            if (new cManejoFechas().StringADate(new cManejoFechas().fechaSumarDias(fechaDate, 90)).after(fechaVencimiento)) {
                                                aDeber61_90 += monto - totalPago;
                                            } else {
                                                if (new cManejoFechas().StringADate(new cManejoFechas().fechaSumarDias(fechaDate, 120)).after(fechaVencimiento)) {
                                                    aDeber91_120 += monto - totalPago;
                                                } else {
                                                    if (new cManejoFechas().StringADate(new cManejoFechas().fechaSumarDias(fechaDate, 150)).after(fechaVencimiento)) {
                                                        aDeber121_150 += monto - totalPago;
                                                    } else {
                                                        aDeber151_mas += monto - totalPago;
                                                    }
                                                }
                                            }
                                        }
                                    }
                                }
                            }
                        %>
                        <tr>
                            <td><%=docSerieNumero%></td>
                            <td><%=new cManejoFechas().DateAString(fecha)%></td>
                            <td style="text-align: right; padding-right: 10px; mso-number-format:'@';"><%=identificacion%></td>
                            <td class="izquierda"><%=cliente%></td>
                            <td class="izquierda"><%=direccion%></td>
                            <td style="text-align: right;mso-number-format:'0.00';"><%=new cOtros().decimalFormato(neto, 2)%></td>
                            <td style="text-align: right;mso-number-format:'0.00';"><%=new cOtros().decimalFormato(deudaActual, 2)%></td>
                            <td style="text-align: right;mso-number-format:'0.00'; background-color: #00cc33;"><%=new cOtros().decimalFormato(aDeber151_mas, 2)%></td>
                            <td style="text-align: right;mso-number-format:'0.00'; background-color: #00cc33;"><%=new cOtros().decimalFormato(aDeber121_150, 2)%></td>
                            <td style="text-align: right;mso-number-format:'0.00'; background-color: #00cc33;"><%=new cOtros().decimalFormato(aDeber91_120, 2)%></td>
                            <td style="text-align: right;mso-number-format:'0.00'; background-color: #00cc33;"><%=new cOtros().decimalFormato(aDeber61_90, 2)%></td>
                            <td style="text-align: right;mso-number-format:'0.00'; background-color: #00cc33;"><%=new cOtros().decimalFormato(aDeber31_60, 2)%></td>
                            <td style="text-align: right;mso-number-format:'0.00'; background-color: #00cc33;"><%=new cOtros().decimalFormato(aDeber1_30, 2)%></td>
                            <td style="text-align: right;mso-number-format:'0.00'; background-color: #ff9999"><%=new cOtros().decimalFormato(deuda0_30, 2)%></td>
                            <td style="text-align: right;mso-number-format:'0.00'; background-color: #ff9999"><%=new cOtros().decimalFormato(deuda31_60, 2)%></td>
                            <td style="text-align: right;mso-number-format:'0.00'; background-color: #ff9999"><%=new cOtros().decimalFormato(deuda61_90, 2)%></td>
                            <td style="text-align: right;mso-number-format:'0.00'; background-color: #ff9999"><%=new cOtros().decimalFormato(deuda91_120, 2)%></td>
                            <td style="text-align: right;mso-number-format:'0.00'; background-color: #ff9999"><%=new cOtros().decimalFormato(deuda121_150, 2)%></td>
                            <td style="text-align: right;mso-number-format:'0.00'; background-color: #ff9999"><%=new cOtros().decimalFormato(deuda151_mas, 2)%></td>
                        </tr>
                    </tbody>
                </table>
            </div>
        </div>
    </body>
</html>
