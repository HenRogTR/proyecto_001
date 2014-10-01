<%-- 
    Document   : ventaCliente
    Created on : 06/01/2014, 11:23:04 AM
    Author     : Henrri
--%>


<%@page import="utilitarios.cManejoFechas"%>
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
<table class="reporte-tabla-2 anchoTotal" style="font-size: 9px;">
    <%
        if (a == 0) {
    %>
    <tr>
        <td>No se ha realizado ninguna venta.</td>
    </tr>
    <%
    } else {
        cOtros objcOtros = new cOtros();
        for (Iterator it = ventaList.iterator(); it.hasNext();) {
            Ventas objVenta = (Ventas) it.next();
            String numeroLetra = "";
            String amortizado = "";
            String deuda = "";
            if (objVenta.getTipo().equals("CREDITO")) {
                numeroLetra = objVenta.getCantidadLetras() + "";
            }
    %>
    <tr class="tr_venta" id="codVenta_<%=objVenta.getCodVentas()%>" title="<%=objVenta.getDocSerieNumero()%>">
        <td style="width: 80px;"><span><a href="../sVenta?accionVenta=mantenimiento&codVenta=<%=objVenta.getCodVentas()%>" target="_blank"><%=objVenta.getDocSerieNumero()%></span></a></td>
        <td style="width: 80px;"><span><%=new cManejoFechas().DateAString(objVenta.getFecha())%></span></td>
        <td style="width: 60px;" class="derecha"><span style="padding-right: 2px"><%=objcOtros.agregarCerosNumeroFormato(objVenta.getNeto(), 2)%></span></td>
        <td style="width: 60px;" class="derecha"><span style="padding-right: 2px">0.00</span></td>
        <td style="width: 60px;" class="derecha"><span style="padding-right: 2px"><%=amortizado%></span></td>
        <td style="width: 60px;" class="derecha"><span style="padding-right: 2px"><%=deuda%></span></td>
        <td style="width: 50px;" class="derecha"><span style="padding-right: 2px"><%=numeroLetra%></span></td>
        <td style="width: 50px;"><span style="padding-left: 2px;"><%=objVenta.getTipo()%></span></td>
        <td class="derecha"><span style="padding-right: 2px;">1.00</span></td>
    </tr>
    <%
            }
        }

    %>
</table>