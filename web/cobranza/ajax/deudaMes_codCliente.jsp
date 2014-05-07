<%-- 
    Document   : deudaMes_codCliente
    Created on : 16/04/2014, 04:06:34 PM
    Author     : Henrri
--%>
<%@page import="utilitarios.cOtros"%>
<%@page import="utilitarios.cManejoFechas"%>
<%@page import="java.util.Date"%>
<%@page import="java.util.Iterator"%>
<%@page import="java.util.List"%>
<%@page import="ventaClases.cVentaCreditoLetra"%>

[
<%
    try {
        int codCliente = Integer.parseInt(request.getParameter("codCliente"));
        List lDeudaMes = new cVentaCreditoLetra().leer_deudaMes(codCliente);
        int cont = 0;
        Double monto = 0.00;
        Double interes = 0.00;
        Double totalPago = 0.00;
        Double saldo = 0.00;
        Date fechaVencimiento = null;
        for (Iterator it = lDeudaMes.iterator(); it.hasNext();) {
            Object dato[] = (Object[]) it.next();
            monto = (Double) dato[0];
            interes = (Double) dato[1];
            totalPago = (Double) dato[2];
            saldo = (Double) dato[3];
            fechaVencimiento = (Date) dato[4];
            if (cont++ > 0) {
                out.print(", ");
            }
            out.print("{"
                    + "\"anioMes\":\"" + new cManejoFechas().mesNombreCorto(fechaVencimiento).toUpperCase() + "-" + new cManejoFechas().anioCorto(fechaVencimiento) + "\""
                    + ", \"monto\":\"" + new cOtros().decimalFormato(monto, 2) + "\""
                    + ", \"interes\":\"" + new cOtros().decimalFormato(interes, 2) + "\""
                    + ", \"totalPago\":\"" + new cOtros().decimalFormato(totalPago, 2) + "\""
                    + ", \"saldo\":\"" + new cOtros().decimalFormato(saldo, 2) + "\""
                    + ", \"fechaVencimiento\":\"" + new cManejoFechas().DateAString(fechaVencimiento) + "\""
                    + "}");
        }
    } catch (Exception e) {

    }
%>
]