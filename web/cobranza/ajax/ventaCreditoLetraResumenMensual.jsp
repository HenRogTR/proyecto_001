<%-- 
    Document   : ventaCreditoLetraResumenMensual
    Created on : 23/11/2013, 10:45:25 AM
    Author     : Henrri
--%>

<%@page import="java.util.Date"%>
<%@page import="java.util.Iterator"%>
<%@page import="otros.cUtilitarios"%>
<%@page import="ventaClases.cVentaCreditoLetra"%>
<%@page import="personaClases.cDatosCliente"%>
<%@page import="java.util.List"%>
<%@page import="tablas.DatosCliente"%>
<%
    try {
%>
<table class="reporte-tabla-2 anchoTotal" style="font-size: 9px;">
    <%
        int codClienteI = Integer.parseInt(request.getParameter("codCliente"));
        DatosCliente objCliente = new cDatosCliente().leer_cod(codClienteI);
        List lVCLResumenMensual = new cVentaCreditoLetra().leer_resumenPagos(objCliente.getPersona().getCodPersona());
        if (lVCLResumenMensual != null) {
            cUtilitarios objcUtilitarios = new cUtilitarios();
            for (Iterator it = lVCLResumenMensual.iterator(); it.hasNext();) {
                Object[] temRP = (Object[]) it.next();
    %>

    <tr>
        <td style="width: 45px;height: 14px;"><%=objcUtilitarios.mesNombreCorto((Date) temRP[6]).toUpperCase() + "-" + temRP[1].toString().substring(2, 4)%></td>
        <td style="width: 50px;" class="derecha"> <%=objcUtilitarios.agregarCerosNumeroFormato(Double.parseDouble(temRP[2].toString()), 2)%></td>
        <td class="derecha"><%=objcUtilitarios.agregarCerosNumeroFormato(Double.parseDouble(temRP[4].toString()), 2)%></td>
        <td class="derecha"><%=objcUtilitarios.agregarCerosNumeroFormato(Double.parseDouble(temRP[5].toString()), 2)%></td>
    </tr>
    <%
            }
        }
    %>

</table>
<%
    } catch (Exception e) {

    }

%>