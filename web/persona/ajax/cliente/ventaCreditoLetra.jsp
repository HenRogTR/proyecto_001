<%-- 
    Document   : ventaCreditoLetra
    Created on : 08/01/2014, 10:59:12 AM
    Author     : Henrri
--%>

<%@page import="utilitarios.cOtros"%>
<%@page import="utilitarios.cManejoFechas"%>
<%@page import="tablas.VentaCreditoLetra"%>
<%@page import="java.util.Iterator"%>
<%@page import="java.util.List"%>
<%@page import="ventaClases.cVentaCreditoLetra"%>
<%

    int codVenta = 0;
    List VCLList = null;
    try {
        codVenta = Integer.parseInt(request.getParameter("codVenta"));
        VCLList = new cVentaCreditoLetra().leer_porCodVenta(codVenta);
    } catch (Exception e) {
        out.print("Error en consulta");
        return;
    }
%>
<table class="reporte-tabla-2 anchoTotal" style="font-size: 9px;">
    <tbody>
        <%
            cManejoFechas objcManejoFechas = new cManejoFechas();
            cOtros objcOtros = new cOtros();
            for (Iterator it = VCLList.iterator(); it.hasNext();) {
                VentaCreditoLetra objVCL = (VentaCreditoLetra) it.next();
                double saldo = objVCL.getMonto() - objVCL.getTotalPago();
                String dias = "";
                String estilo = "";
                int diasRetraso = objcManejoFechas.diferenciaDias(objVCL.getFechaVencimiento());
                if (saldo > 0 & diasRetraso > 0) {
                    dias = String.valueOf(diasRetraso);
                    estilo = "tomato";
                }
                if (saldo > 0 & diasRetraso <= 0 & diasRetraso > -7) {
                    estilo = "#ffcccc";
                }
        %>
        <tr>
            <td style="width: 90px; background-color: <%=estilo%> "><span style="padding-left: 2px;"><%=objVCL.getVentas().getDocSerieNumero()%></span></td>
            <td style="width: 90px;background-color: <%=estilo%> "><span style="padding-left: 2px;"><%=objVCL.getDetalleLetra()%></span></td>
            <td style="width: 70px;background-color: <%=estilo%> "><span style="padding-left: 2px;"><%=objcManejoFechas.DateAString(objVCL.getFechaVencimiento())%></span></td>
            <td style="width: 60px;background-color: <%=estilo%> " class="derecha"><span style="padding-right: 2px;"><%=objcOtros.agregarCerosNumeroFormato(objVCL.getMonto(), 2)%></span></td>
            <td style="width: 60px;background-color: <%=estilo%> " class="derecha"><span style="padding-right: 2px;"><%=objcOtros.agregarCerosNumeroFormato(objVCL.getTotalPago(), 2)%></span></td>
            <td style="width: 70px;background-color: <%=estilo%> "><span style="padding-left: 2px;"><%=objcManejoFechas.DateAString(objVCL.getFechaPago())%></span></td>
            <td style="width: 40px;background-color: <%=estilo%> " class="derecha"><span style="padding-left: 2px;"><%=dias%></span></td>
            <td style="width: 60px;background-color: <%=estilo%> " class="derecha"><span style="padding-right: 2px;"><%=objcOtros.agregarCerosNumeroFormato(objVCL.getInteres(), 2)%></span></td>
            <td class="derecha" style="background-color: <%=estilo%> "><span style="padding-right: 2px;"><%=objcOtros.decimalFormato(saldo, 2)%></span></td>
        </tr>
        <%
            }
        %>
    </tbody>
</table>