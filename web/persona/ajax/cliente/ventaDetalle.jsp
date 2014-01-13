<%-- 
    Document   : ventaDetalle
    Created on : 08/01/2014, 10:10:14 AM
    Author     : Henrri
--%>

<%@page import="utilitarios.cOtros"%>
<%@page import="tablas.VentasDetalle"%>
<%@page import="java.util.Iterator"%>
<%@page import="ventaClases.cVentasDetalle"%>
<%@page import="java.util.List"%>
<%
    int codVenta = 0;
    List VDList = null;
    try {
        codVenta = Integer.parseInt(request.getParameter("codVenta"));
        VDList = new cVentasDetalle().leer_ventasDetalle_porCodVentas(codVenta);
    } catch (Exception e) {
        out.print("Error en consulta");
        return;
    }
%>
<table class="reporte-tabla-2 anchoTotal" style="font-size: 9px;">
    <tbody>
        <%
            cOtros objcOtros = new cOtros();
            for (Iterator it = VDList.iterator(); it.hasNext();) {
                VentasDetalle objVD = (VentasDetalle) it.next();
        %>
        <tr>
            <td style="width: 90px;"><span style="padding-left: 2px;"><%=objVD.getVentas().getDocSerieNumero()%></span></td>
            <td style="width: 40px;"><span style="padding-left: 2px;"><%=objVD.getCantidad()%></span></td>
            <td style="width: 350px;"><span style="padding-left: 2px;"><%=objVD.getDescripcion()%></span></td>
            <td style="width: 70px;" class="derecha"><span style="padding-right: 2px"><%=objcOtros.agregarCerosNumeroFormato(objVD.getPrecioVenta(), 2) %></span></td>
            <td class="derecha"><span style="padding-right: 2px"><%=objcOtros.agregarCerosNumeroFormato(objVD.getValorVenta(), 2) %></span></td>
        </tr>
        <%
            }
        %>
    </tbody>
</table>