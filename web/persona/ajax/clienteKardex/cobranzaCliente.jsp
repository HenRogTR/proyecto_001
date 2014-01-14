<%-- 
    Document   : cobranzaCliente
    Created on : 08/01/2014, 12:08:05 PM
    Author     : Henrri
--%>

<%@page import="utilitarios.cManejoFechas"%>
<%@page import="utilitarios.cOtros"%>
<%@page import="tablas.Cobranza"%>
<%@page import="java.util.Iterator"%>
<%@page import="personaClases.cDatosCliente"%>
<%@page import="cobranzaClases.cCobranza"%>
<%@page import="java.util.List"%>
<%
    int codCliente = Integer.parseInt(request.getParameter("codCliente"));
    List CList = new cCobranza().leer_codPersona_SC(new cDatosCliente().leer_cod(codCliente).getPersona().getCodPersona());
%>
<table class="reporte-tabla-2 anchoTotal" style="font-size: 9px;">
    <thead>
        <%
            cOtros objcOtros = new cOtros();
            for (Iterator it = CList.iterator(); it.hasNext();) {
                Cobranza objCobranza = (Cobranza) it.next();
        %>
        <tr class="trCodCobranza=<%=objCobranza.getCodCobranza()%>" title="<%=objCobranza.getObservacion()%>">
            <td style="width: 110px;"><span style="padding-left: 2px;"><%=objCobranza.getDocSerieNumero()%></span></td>
            <td style="width: 70px;" class="derecha"><span style="padding-right: 2px;"><%=objcOtros.decimalFormato(objCobranza.getImporte(), 2)%></span></td>
            <td style="width: 70px;"><span style="padding-left: 2px;"><%=new cManejoFechas().DateAString(objCobranza.getFechaCobranza())%></span></td>
            <td class="derecha"><span style="padding-right: 2px;"><%=objcOtros.decimalFormato(objCobranza.getSaldo(), 2)%></span></td>
        </tr>
        <%
            }
        %>
    </thead>
</table>