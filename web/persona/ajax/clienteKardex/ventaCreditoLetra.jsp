<%-- 
    Document   : ventaCreditoLetra
    Created on : 08/01/2014, 10:59:12 AM
    Author     : Henrri
--%>

<%@page import="otrasTablasClases.cDatosExtras"%>
<%@page import="java.util.Date"%>
<%@page import="utilitarios.cOtros"%>
<%@page import="utilitarios.cManejoFechas"%>
<%@page import="tablas.VentaCreditoLetra"%>
<%@page import="java.util.Iterator"%>
<%@page import="java.util.List"%>
<%@page import="ventaClases.cVentaCreditoLetra"%>
<%

    int codVenta = 0;
    int codCliente = 0;
    List VCLList = null;
    try {
        codVenta = Integer.parseInt(request.getParameter("codVenta"));
        codCliente = Integer.parseInt(request.getParameter("codCliente"));
        //actualizamos letras pendientes interes
        Date fechaVencimiento = new Date();
        int diaEspera = new cDatosExtras().leer_diaEspera().getEntero();
        Date fechaVencimientoEspera = new cManejoFechas().StringADate(new cManejoFechas().fechaSumarDias(fechaVencimiento, -diaEspera));
        List VCLetra = new cVentaCreditoLetra().leer_cliente_interesSinActualizar(fechaVencimientoEspera, fechaVencimiento, true, codCliente);
        new cVentaCreditoLetra().actualizar_interes(VCLetra, fechaVencimiento);
        
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
                double saldo = objVCL.getMonto() - objVCL.getTotalPago() + objVCL.getInteres() - objVCL.getInteresPagado();
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
            <td style="width: 90px; background-color: <%=estilo%> "><span style="padding-left: 2px;"><%=objVCL.getVentaCredito().getVentas().getDocSerieNumero()%></span></td>
            <td style="width: 90px;background-color: <%=estilo%> "><span style="padding-left: 2px;"><%=objVCL.getDetalleLetra()%></span></td>
            <td style="width: 70px;background-color: <%=estilo%> "><span style="padding-left: 2px;"><%=objcManejoFechas.DateAString(objVCL.getFechaVencimiento())%></span></td>
            <td style="width: 60px;background-color: <%=estilo%> " class="derecha"><span style="padding-right: 2px;"><%=objcOtros.decimalFormato(objVCL.getMonto(), 2)%></span></td>
            <td style="width: 60px;background-color: <%=estilo%> " class="derecha"><span style="padding-right: 2px;"><%=objcOtros.decimalFormato(objVCL.getInteres(), 2)%></span></td>
            <td style="width: 60px;background-color: <%=estilo%> " class="derecha"><span style="padding-right: 2px;"><%=objcOtros.decimalFormato(objVCL.getTotalPago() + objVCL.getInteresPagado(), 2)%></span></td>
            <td style="width: 70px;background-color: <%=estilo%> "><span style="padding-left: 2px;"><%=objcManejoFechas.DateAString(objVCL.getFechaPago())%></span></td>
            <td style="width: 40px;background-color: <%=estilo%> " class="derecha"><span style="padding-left: 2px;"><%=dias%></span></td>
            <td class="derecha" style="background-color: <%=estilo%> "><span style="padding-right: 2px;"><%=objcOtros.decimalFormato(saldo, 2)%></span></td>
        </tr>
        <%
            }
        %>
    </tbody>
</table>