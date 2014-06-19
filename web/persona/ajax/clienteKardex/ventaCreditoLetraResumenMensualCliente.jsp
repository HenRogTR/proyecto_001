<%-- 
    Document   : ventaCreditoLetraResumenMensualCliente
    Created on : 08/01/2014, 12:37:56 PM
    Author     : Henrri
--%>

<%@page import="otrasTablasClases.cDatosExtras"%>
<%@page import="utilitarios.cOtros"%>
<%@page import="java.util.Date"%>
<%@page import="utilitarios.cManejoFechas"%>
<%@page import="java.util.Iterator"%>
<%@page import="personaClases.cDatosCliente"%>
<%@page import="java.util.List"%>
<%@page import="ventaClases.cVentaCreditoLetra"%>
<%
    int codCliente = Integer.parseInt(request.getParameter("codCliente"));
    //actualizamos letras pendientes interes.
    Date fechaBase = new Date();
    int diaEspera = new cDatosExtras().leer_diaEspera().getEntero();
    Date fechaVencimientoEspera = new cManejoFechas().StringADate(new cManejoFechas().fechaSumarDias(fechaBase, -diaEspera));
    List VCLetra = new cVentaCreditoLetra().leer_cliente_interesSinActualizar(fechaVencimientoEspera, fechaBase, true, codCliente);
    new cVentaCreditoLetra().actualizar_interes(VCLetra, fechaBase);
    
    List VCLRMList = new cVentaCreditoLetra().leer_resumenPagos(new cDatosCliente().leer_cod(codCliente).getPersona().getCodPersona());
%>
<table class="reporte-tabla-2 anchoTotal" style="font-size: 9px;">
    <tbody>
        <%
            cManejoFechas objcManejoFechas = new cManejoFechas();
            cOtros objcOtros = new cOtros();
            for (Iterator it = VCLRMList.iterator(); it.hasNext();) {
                Object[] temRP = (Object[]) it.next();
        %>
        <tr>
            <td style="width: 70px;"><span><%=cManejoFechas.mesNombreCorto((Date) temRP[6]).toUpperCase() + "-" + temRP[1].toString().substring(2, 4)%></span></td>
            <td style="width: 70px;" class="derecha"><span style="padding-right: 2px"><%=objcOtros.agregarCerosNumeroFormato(Double.parseDouble(temRP[2].toString()), 2)%></span></td>
            <td style="width: 70px;" class="derecha"><span style="padding-right: 2px"><%=objcOtros.agregarCerosNumeroFormato(Double.parseDouble(temRP[3].toString()), 2)%></span></td>
            <td style="width: 70px;" class="derecha"><span style="padding-right: 2px"><%=objcOtros.agregarCerosNumeroFormato(Double.parseDouble(temRP[4].toString()), 2)%></span></td>
            <td class="derecha"><span style="padding-right: 2px"><%=objcOtros.agregarCerosNumeroFormato(Double.parseDouble(temRP[5].toString()), 2)%></span></td>
        </tr>
        <%
            }
        %>
    </tbody>
</table>