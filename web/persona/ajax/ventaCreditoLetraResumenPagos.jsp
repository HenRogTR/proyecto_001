<%-- 
    Document   : ventaCreditoLetraResumenPagos
    Created on : 20/08/2013, 06:41:22 AM
    Author     : Henrri
--%>
<%@page import="utilitarios.cOtros"%>
<%@page import="utilitarios.cManejoFechas"%>
<%@page import="java.util.Date"%>
<%@page import="java.util.Iterator"%>
<%@page import="java.util.ArrayList"%>
<%@page import="ventaClases.cVentaCreditoLetra"%>
<%@page import="java.util.List"%>
<%
    int codPersona = 0;
    List lVentaCreditoLetraRP = new ArrayList();
    cVentaCreditoLetra objcVentaCreditoLetra = new cVentaCreditoLetra();
    try {
        codPersona = Integer.parseInt(request.getParameter("codPersona"));
        lVentaCreditoLetraRP = objcVentaCreditoLetra.leer_resumenPagos(codPersona);
        if (lVentaCreditoLetraRP == null) {
            out.print(objcVentaCreditoLetra.getError());
            return;
        }
    } catch (Exception e) {
        out.print("error");
        return;
    }
    Iterator iVentaCreditoLetraRP = lVentaCreditoLetraRP.iterator();
    int contador = 0;
    out.print("[");
    while (iVentaCreditoLetraRP.hasNext()) {
        Object[] temRP = (Object[]) iVentaCreditoLetraRP.next();
        if (contador++ > 0) {
            out.print(",");
        }
        out.print(" {"
                + "\"mesAnio\":\"" + cManejoFechas.mesNombreCorto((Date) temRP[6]).toUpperCase() + "-" + temRP[1].toString().substring(2, 4) + "\""
                + ",\"monto\":\"" + new cOtros().decimalFormato(Double.parseDouble(temRP[2].toString()), 2) + "\""
                + ",\"interes\":\"" + new cOtros().decimalFormato(Double.parseDouble(temRP[3].toString()), 2) + "\""
                + ",\"pagos\":\"" + new cOtros().decimalFormato(Double.parseDouble(temRP[4].toString()), 2) + "\""
                + ",\"saldo\":\"" + new cOtros().decimalFormato(Double.parseDouble(temRP[5].toString()), 2) + "\""
                + "}");
    }
    out.print("]");
%>