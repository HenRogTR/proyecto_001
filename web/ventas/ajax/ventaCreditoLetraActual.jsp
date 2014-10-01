<%-- 
    Document   : ventaCreditoLetraActual
    Created on : 21/11/2013, 03:01:13 PM
    Author     : Henrri
--%>

<%@page import="utilitarios.cOtros"%>
<%@page import="utilitarios.cManejoFechas"%>
<%@page import="java.util.Iterator"%>
<%@page import="java.util.List"%>
<%@page import="ventaClases.cVentaCreditoLetra"%>
<%@page import="tablas.VentaCreditoLetra"%>
<%@page import="ventaClases.cVenta"%>
<%@page import="tablas.Ventas"%>
<%
    try {
        int codVenta = Integer.parseInt(request.getParameter("codVenta"));
        List l = new cVentaCreditoLetra().leer_porCodVenta(codVenta);
        if (l != null) {
%>
<table class="reporte-tabla-1 anchoTotal">
    <thead>
        <tr>
            <th class="ancho120px">Detalles</th>
            <th class="ancho120px">F. Venci.</th>
            <th class="ancho120px">Monto</th>
            <th class="ancho120px">Pagado</th>
            <th class="ancho120px">F. Pago(*)</th>
            <th>Saldo</th>
        </tr>
    </thead>
</table>
<div style="height: 400px; overflow: auto; width: 100%;">
    <table class="reporte-tabla-1 anchoTotal">
        <%
            cManejoFechas objcManejoFechas = new cManejoFechas();
            cOtros objcOtros = new cOtros();
            for (Iterator it = l.iterator(); it.hasNext();) {
                VentaCreditoLetra obj = (VentaCreditoLetra) it.next();
        %>
        <tr>
            <td class="ancho120px">&nbsp;&nbsp;&nbsp;<%=obj.getDetalleLetra()%></td>
            <td class="ancho120px centrado"><%=objcManejoFechas.DateAString(obj.getFechaVencimiento())%></td>
            <td class="ancho120px derecha"><%=objcOtros.agregarCerosNumeroFormato(obj.getMonto(), 2)%>&nbsp;&nbsp;&nbsp;</td>
            <td class="ancho120px derecha"><%=objcOtros.agregarCerosNumeroFormato(obj.getTotalPago(), 2)%>&nbsp;&nbsp;&nbsp;</td>
            <td class="ancho120px centrado"><%=objcManejoFechas.DateAString(obj.getFechaPago())%></td>
            <td class="derecha"><%=objcOtros.decimalFormato(obj.getMonto() - obj.getTotalPago(), 2)%>&nbsp;&nbsp;&nbsp;</td>
        </tr>
        <%
            }
        %>
    </table>
</div>
<%
        }
    } catch (Exception e) {
        out.print("Error en parametros");
    }
%>