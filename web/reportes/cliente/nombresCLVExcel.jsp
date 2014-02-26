<%-- 
    Document   : nombresCLVExcel
    Created on : 21/02/2014, 05:52:46 PM
    Author     : Henrri
--%>
<%@page import="java.util.Iterator"%>
<%@page import="utilitarios.cOtros"%>
<%@page import="ventaClases.cVentaCreditoLetraReporte"%>
<%@page import="utilitarios.cManejoFechas"%>
<%@page import="utilitarios.cValidacion"%>
<%@page import="java.util.List"%>

<%
    String fecha = "";
    List LVList = null;
    try {
        fecha = request.getParameter("fechaVencimiento").toString();
        if (!new cValidacion().validarFecha(fecha)) {
            out.print("Fecha y/o formato de fecha incorrecta.");
            return;
        }
        LVList = new cVentaCreditoLetraReporte().letrasVencidas_total_ordenNombresC(new cManejoFechas().StringADate(fecha));
        if (LVList == null) {
            out.print("Error en consulta lista->null)");
            return;
        }
    } catch (Exception e) {
        out.print("Error en parámetros.");
        return;
    }
    cOtros objcOtros = new cOtros();
    cManejoFechas objcManejoFechas = new cManejoFechas();
    response.setContentType("application/vnd.ms-excel"); //Tipo de fichero.
    response.setHeader("Content-Disposition", "attachment;filename=\"LETRAS VENCIDAS (APE/NOM) " + fecha + " " + objcManejoFechas.fechaHoraActualNumerosLineal() + ".xls\"");
%>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <title> letras por cobrar (ape/nom) <%=fecha%> <%=objcManejoFechas.fechaHoraActualNumerosLineal()%></title>
    </head>
    <body>
        <div id="documento">
            <div id="contenido">
                <table style="width: 700px;font-size: 14px;">
                    <thead>
                        <tr class="bottom2">
                            <th colspan="3"><label>Letras X cobrar : Clientes en general(Apellidos/Nombres) - Vencimiento <%=fecha%></label></th>
                        </tr>
                        <tr class="bottom1">
                            <th><label>Nombre/Razón Social</label></th>
                            <th style="width: 120px;"><label>DNI / Ruc</label></th>
                            <th style="width: 80px;"><label>Monto</label></th>
                        </tr>
                    </thead>
                    <tbody>
                        <%
                            for (Iterator it = LVList.iterator(); it.hasNext();) {
                                Object[] tem = (Object[]) it.next();
                        %>
                        <tr>
                            <td><%=tem[0]%></td>
                            <td style="text-align: right; mso-number-format:'@';"><%=tem[1].toString().equals("") ? tem[2] : tem[1]%></td>
                            <td style="text-align: right; mso-number-format:'0.00';"><%=objcOtros.agregarCerosNumeroFormato(Double.parseDouble(tem[3].toString()), 2)%></td>
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
