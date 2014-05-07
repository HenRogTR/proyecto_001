<%-- 
    Document   : ventaCreditoLetraLeer
    Created on : 20/11/2013, 11:01:49 AM
    Author     : Henrri
--%>

<%@page import="utilitarios.cOtros"%>
<%@page import="utilitarios.cManejoFechas"%>
<%@page import="tablas.VentaCreditoLetra"%>
<%@page import="java.util.Iterator"%>
<%@page import="tablas.DatosCliente"%>
<%@page import="ventaClases.cVentaCreditoLetra"%>
<%@page import="java.util.List"%>
<%
    try {
        int codVenta = Integer.parseInt(request.getParameter("codVenta"));
        List VCLList = new cVentaCreditoLetra().leer_porCodVenta(codVenta);
        if (VCLList != null) {
            for (Iterator it = VCLList.iterator(); it.hasNext();) {
                VentaCreditoLetra objVentaCreditoLetra = (VentaCreditoLetra) it.next();
%>
<tr>
    <td style="width: 33%;"><%=objVentaCreditoLetra.getDetalleLetra()%></td>
    <td style="width: 34%; padding-left: 20px;"><%=new cManejoFechas().DateAString(objVentaCreditoLetra.getFechaVencimiento())%></td>    
    <td class="derecha" style="padding-right: 20px;"><%=new cOtros().decimalFormato(objVentaCreditoLetra.getMonto(), 2)%></td>
</tr>
<%
            }
        }
    } catch (Exception e) {

    }
%>