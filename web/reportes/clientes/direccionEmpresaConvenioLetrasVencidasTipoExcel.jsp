<%-- 
    Document   : direccionEmpresaConvenioLetrasVencidasExcel
    Created on : 10/07/2013, 06:56:07 PM
    Author     : Henrri
--%>

<%@page import="personaClases.cDatosCliente"%>
<%@page import="personaClases.cEmpresaConvenio"%>
<%@page import="tablas.EmpresaConvenio"%>
<%@page import="javax.xml.bind.ParseConversionEvent"%>
<%@page import="java.util.Iterator"%>
<%@page import="ventaClases.cVentaCreditoLetra"%>
<%@page import="java.util.List"%>
<%@page import="otros.cUtilitarios"%>
<%@page import="otros.cManejoFechas"%>
<%@page import="java.util.Date"%>
<%
    //variables
    boolean estado = true;
    String mensaje = "";
    Date fechaVencimiento = null;
    int codEmpresaConvenio = 0, tipo = 0;
    List lLetrasVencidas = null;
    //clases
    cVentaCreditoLetra objcVentaCreditoLetra = new cVentaCreditoLetra();
    cManejoFechas objcManejoFechas = new cManejoFechas();
    cDatosCliente objcDatosCliente = new cDatosCliente();
    try {
        fechaVencimiento = objcManejoFechas.caracterADate(request.getParameter("fechaVencimiento"));
        codEmpresaConvenio = Integer.parseInt(request.getParameter("codEmpresaConvenio"));
        tipo = Integer.parseInt(request.getParameter("tipo"));
        lLetrasVencidas = objcVentaCreditoLetra.leer_deudaPendiente_tipo_orderDireccion_empresaConvenio(fechaVencimiento, codEmpresaConvenio, tipo);
        if (lLetrasVencidas == null) {
            estado = false;
            mensaje = objcVentaCreditoLetra.getError();
        }
    } catch (Exception e) {
        estado = false;
        mensaje = "Parametros incorrectos";
    }
    if (!estado) {
        out.print(mensaje);
        return;
    }
    cUtilitarios objcUtilitarios = new cUtilitarios();
    EmpresaConvenio objEmpresaConvenio = new cEmpresaConvenio().leer_cod(codEmpresaConvenio);
    response.setContentType("application/vnd.ms-excel"); //Tipo de fichero.
    response.setHeader("Content-Disposition", "attachment;filename=\"" + objcUtilitarios.fechaHoraActualNumerosLineal() + ".xls\"");
%>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <title>JSP Page</title>
        <link rel="stylesheet" type="text/css" href="../../lib/propios/css/paginaImprimir/bodyPrint.css" media="screen"/>
        <link rel="stylesheet" type="text/css" href="../../lib/propios/css/paginaImprimir/bodyPrint.css" media="print"/>
        <link rel="stylesheet" type="text/css" href="../../lib/propios/css/tablas/tablas-reportes.css" media="print"/>
        <link rel="stylesheet" type="text/css" href="../../lib/propios/css/tablas/tablas-reportes.css" media="screen"/>
    </head>
    <body>
        <div id="documento">
            <div id="contenido">
                <%
                    if (estado) {
                %>
                <table style="width: 700px;font-size: 14px;">
                    <thead>
                        <tr class="bottom2">
                            <th colspan="3"><label>DEUDA PENDIENTE DE PAGO / <%=objEmpresaConvenio.getNombre()%> / <%=objcDatosCliente.tipoCliente(tipo)%> (Dirección) - V. <%=objcUtilitarios.fechaDateToString(fechaVencimiento)%></label></th>
                        </tr>
                        <tr class="bottom1">
                            <th><label>Nombre/Razón Social</label></th>
                            <th style="width: 120px; text-align: center;"><label>DNI / Ruc</label></th>
                            <th style="width: 80px; text-align: center;"><label>Monto</label></th>
                        </tr>
                    </thead>
                    <tbody>
                        <%
                            for (int i = 0; i < lLetrasVencidas.size(); i++) {
                                Object[] tem = (Object[]) lLetrasVencidas.get(i);
                        %>
                        <tr>
                            <td><%=tem[0]%></td>
                            <td style="text-align: right; mso-number-format:'@';"><%=tem[1].toString().equals("") ? tem[2] : tem[1]%></td>
                            <td style="text-align: right; mso-number-format:'0.00';"><%=objcUtilitarios.agregarCerosNumeroFormato(Double.parseDouble(tem[3].toString()), 2)%></td>
                        </tr>
                        <%
                            }
                        %>
                    </tbody>
                </table>
                <%
                    } else {
                        out.print(mensaje);
                    }
                %>
            </div>
        </div>
    </body>
</html>