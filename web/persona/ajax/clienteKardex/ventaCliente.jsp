<%-- 
    Document   : ventaCliente
    Created on : 06/01/2014, 11:23:04 AM
    Author     : Henrri
--%>


<%@page import="tablas.VentasSerieNumero"%>
<%@page import="tablas.VentasDetalle"%>
<%@page import="tablas.VentaCreditoLetra"%>
<%@page import="utilitarios.cManejoFechas"%>
<%@page import="ventaClases.cVentaCredito"%>
<%@page import="tablas.VentaCredito"%>
<%@page import="tablas.Ventas"%>
<%@page import="java.util.Iterator"%>
<%@page import="utilitarios.cOtros"%>
<%@page import="ventaClases.cVenta"%>
<%@page import="personaClases.cDatosCliente"%>
<%@page import="java.util.List"%>
<%
    int codCliente = 0;
    List ventaList = null;
    try {
        codCliente = Integer.parseInt(request.getParameter("codCliente"));
        ventaList = new cVenta().leer_codPersona_orderByAsc(new cDatosCliente().leer_cod(codCliente).getPersona().getCodPersona());
    } catch (Exception e) {
        return;
    }
    int a = ventaList.size();
%>
<%
    if (a != 0) {
%>            
<table class="reporte-tabla-2 anchoTotal" style="font-size: 9px;">
    <%
        cOtros objcOtros = new cOtros();
        for (Iterator it = ventaList.iterator(); it.hasNext();) {
            Ventas objVenta = (Ventas) it.next();
            String numeroLetra = "";
            String amortizado = "";
            String deuda = "";
            String fondoAnulado = objVenta.getRegistro().substring(0, 1).equals("0") ? "#ff6666" : "";//estilo a las ventas anuladas
            if (objVenta.getTipo().equals("CREDITO")) {
                VentaCredito objVentaCredito = new cVentaCredito().leer_codVenta_01(objVenta.getCodVentas());
                numeroLetra = objVentaCredito.getCantidadLetras().toString();
                Double montoAmortizado = 0.00;
                for (VentaCreditoLetra objVentaCreditoLetra : objVentaCredito.getVentaCreditoLetras()) {
                    montoAmortizado += objVentaCreditoLetra.getTotalPago();
                }
                Double deudaTotal = objVenta.getNeto() - montoAmortizado;
                amortizado = objcOtros.decimalFormato(montoAmortizado, 2);
                deuda = objcOtros.decimalFormato(deudaTotal, 2);
            }
            String serie = "";
            for (VentasDetalle objVentasDetalle : objVenta.getVentasDetalles()) {
                for (VentasSerieNumero objVentasSerieNumero : objVentasDetalle.getVentasSerieNumeros()) {
                    serie += "<div>" + objcOtros.replace_comillas_comillasD_barraInvertida(objVentasSerieNumero.getSerieNumero() + "<br>" + objVentasSerieNumero.getObservacion()) + "</div>";
                }
            }
    %>
    <tr class="tr_venta primero <%=serie%>" id="codVenta_<%=objVenta.getCodVentas()%>" title="<%=objVenta.getDocSerieNumero()%>">
        <td style="width: 80px; background-color: <%=fondoAnulado%>"><span><a href="../sVenta?accionVenta=mantenimiento&codVenta=<%=objVenta.getCodVentas()%>" target="_blank"><%=objVenta.getDocSerieNumero()%></span></a></td>
        <td style="width: 80px; background-color: <%=fondoAnulado%>"><span><%=new cManejoFechas().DateAString(objVenta.getFecha())%></span></td>
        <td style="width: 60px; background-color: <%=fondoAnulado%>" class="derecha"><span style="padding-right: 2px"><%=objcOtros.agregarCerosNumeroFormato(objVenta.getNeto(), 2)%></span></td>
        <td style="width: 60px; background-color: <%=fondoAnulado%>" class="derecha"><span style="padding-right: 2px">0.00</span></td>
        <td style="width: 60px; background-color: <%=fondoAnulado%>" class="derecha"><span style="padding-right: 2px"><%=amortizado%></span></td>
        <td style="width: 60px; background-color: <%=fondoAnulado%>" class="derecha"><span style="padding-right: 2px"><%=deuda%></span></td>
        <td style="width: 50px; background-color: <%=fondoAnulado%>" class="derecha"><span style="padding-right: 2px"><%=numeroLetra%></span></td>
        <td style="width: 50px; background-color: <%=fondoAnulado%>"><span style="padding-left: 2px;"><%=objVenta.getTipo()%></span></td>
        <td class="derecha" style=" background-color: <%=fondoAnulado%>"><span style="padding-right: 2px;">1.00</span><div class="info_serieNumero" title="<%=serie%>"></div></td>
    </tr>
    <%
        }
    %>

</table>
<%
    }
%>