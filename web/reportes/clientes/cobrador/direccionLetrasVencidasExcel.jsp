<%-- 
    Document   : direccionLetrasVencidasExcel
    Created on : 10/07/2013, 04:37:51 PM
    Author     : Henrri
--%>

<%@page import="personaClases.cPersona"%>
<%@page import="tablas.Persona"%>
<%@page import="javax.xml.bind.ParseConversionEvent"%>
<%@page import="java.util.Iterator"%>
<%@page import="ventaClases.cVentaCreditoLetra"%>
<%@page import="java.util.List"%>
<%@page import="otros.cUtilitarios"%>
<%@page import="otros.cManejoFechas"%>
<%@page import="java.util.Date"%>
<%
    boolean estado = true;
    String mensaje = "";
    Date fechaVencimiento = new Date();
    Persona objCobrador = null;
    cPersona objcPersona = new cPersona();
    int codCobrador = 0;
    try {
        codCobrador = Integer.parseInt(request.getParameter("codCobrador"));
        objCobrador = objcPersona.leer_cod(codCobrador);
        if (objCobrador == null) {
            out.print("No hay cobrador con ese codigo");
            return;
        }
        fechaVencimiento = new cManejoFechas().caracterADate(request.getParameter("fechaVencimiento"));
    } catch (Exception e) {
        estado = false;
        mensaje = "Fecha incorrecta";
    }
    cUtilitarios objcUtilitarios = new cUtilitarios();
    List lLetrasVencidas = new cVentaCreditoLetra().leer_codCobrador_letrasVencidas_orderByDireccion(fechaVencimiento, codCobrador);
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
                            <th colspan="3"><label>Letras X cobrar : Clientes en general (Direccion) - Vencimiento <%=objcUtilitarios.fechaDateToString(fechaVencimiento)%></label></th>
                        </tr>
                        <tr class="bottom1">
                            <th><label>Nombre/Razón Social</label></th>
                            <th style="width: 120px;"><label>DNI / Ruc</label></th>
                            <th style="width: 80px;"><label>Monto</label></th>
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
