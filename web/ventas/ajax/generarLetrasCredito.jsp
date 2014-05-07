<%-- 
    Document   : generarLetrasCredito
    Created on : 10/05/2013, 06:56:22 PM
    Author     : Henrri
--%>

<%@page import="utilitarios.cOtros"%>
<%@page import="utilitarios.cManejoFechas"%>
<%@page import="java.util.Date"%>
<%

    Double neto = Double.parseDouble(request.getParameter("neto"));
    Double inicial = Double.parseDouble(request.getParameter("inicial"));
    int numeroCuotas = Integer.parseInt(request.getParameter("numeroCuotas"));
    Date fechaInicio = new cManejoFechas().StringADate(request.getParameter("fechaInicio"));
    Date fechaVencimiento = new cManejoFechas().StringADate(request.getParameter("fechaVencimiento"));
    String periodoLetra = request.getParameter("periodoLetra");
    int cont = 0;
    Double montoLetra = new cOtros().redondearDecimales((neto - inicial) / numeroCuotas, 1);
    Double acumulado = 0.0;
    out.print("[");
    for (int i = 0; i <= numeroCuotas; i++) {
        if (cont++ > 0) {
            out.print(" , ");
        }
        out.print("{");
        if (i == 0) {
            out.print("\"letra\":\"Pago inicial\"");
            out.print(" , \"fechaVencimiento\":\"" + new cManejoFechas().DateAString(fechaVencimiento) + "\"");
            out.print(" , \"monto\":\"" + new cOtros().decimalFormato(inicial, 2) + "\"");
        } else {
            if (periodoLetra.equals("mensual")) {
                out.print("\"letra\":\"Letra N° " + i + "\"");
                out.print(" , \"fechaVencimiento\":\"" + new cManejoFechas().fechaSumarMes(fechaInicio, i - 1) + "\"");
            }
            if (periodoLetra.equals("quincenal")) {
                out.print("\"letra\":\"Letra N° " + i + " (Q)\"");
                out.print(" , \"fechaVencimiento\":\"" + new cManejoFechas().fechaSumarDias(fechaInicio, (i * 14) - 14) + "\"");
            }
            if (periodoLetra.equals("semanal")) {
                out.print("\"letra\":\"Letra N° " + i + " (S)\"");
                out.print(" , \"fechaVencimiento\":\"" + new cManejoFechas().fechaSumarDias(fechaInicio, (i * 7) - 7) + "\"");
            }
            if (i == numeroCuotas) {
                Double ultimaLetra = neto - inicial - acumulado;
                out.print(" , \"monto\":\"" + new cOtros().decimalFormato(ultimaLetra, 2) + "\"");
            } else {
                out.print(" , \"monto\":\"" + new cOtros().decimalFormato(montoLetra, 2) + "\"");
            }
            acumulado += montoLetra;
            System.out.println(acumulado);
        }
        out.print("}");
    }
    out.print("]");
%>