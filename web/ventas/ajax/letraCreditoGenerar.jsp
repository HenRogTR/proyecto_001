<%-- 
    Document   : letraCreditoGenerar
    Created on : 10/05/2013, 06:56:22 PM
    Author     : Henrri
--%>
<%@page import="otros.cUtilitarios"%>
<%@page import="otros.cManejoFechas"%>
<%@page import="java.util.Date"%>
<%
    cManejoFechas objcManejoFechas = new cManejoFechas();
    cUtilitarios objcUtilitarios = new cUtilitarios();
    Double neto = 0.00;
    Double inicial = 0.00;
    int numeroCuotas = 0;
    Date fechaInicio = null;
    Date fechaVencimiento = null;
    String periodoLetra = "";
    try {
        neto = Double.parseDouble(request.getParameter("neto"));
        inicial = Double.parseDouble(request.getParameter("inicial"));
        numeroCuotas = Integer.parseInt(request.getParameter("numeroCuotas"));
        fechaInicio = objcManejoFechas.caracterADate(request.getParameter("fechaInicio").toString());
        fechaVencimiento = objcManejoFechas.caracterADate(request.getParameter("fechaVencimiento").toString());
        periodoLetra = request.getParameter("periodoLetra").toString();
    } catch (Exception e) {
        out.print("Error en par�metros: " + e.getMessage());
        return;
    }

    int cont = 0;
    Double montoLetra = objcUtilitarios.redondearDecimales((neto - inicial) / numeroCuotas, 1);
    Double acumulado = 0.0;
    out.print("[");
    for (int i = 0; i <= numeroCuotas; i++) {
        if (cont++ > 0) {
            out.print(" , ");
        }
        out.print("{");
        if (i == 0) {
            out.print("\"letra\":\"Pago inicial\"");
            out.print(" , \"fechaVencimiento\":\"" + objcUtilitarios.fechaDateToString(fechaVencimiento) + "\"");
            out.print(" , \"monto\":\"" + objcUtilitarios.agregarCerosNumeroFormato(inicial, 2) + "\"");
        } else {
            if (periodoLetra.equals("mensual")) {
                out.print("\"letra\":\"Letra N� " + i + "\"");
                out.print(" , \"fechaVencimiento\":\"" + objcManejoFechas.fechaSumarMes(fechaInicio, i - 1) + "\"");
            }
            if (periodoLetra.equals("quincenal")) {
                out.print("\"letra\":\"Letra N� " + i + " (Q)\"");
                out.print(" , \"fechaVencimiento\":\"" + objcManejoFechas.fechaSumarDias(fechaInicio, (i * 14) - 14) + "\"");
            }
            if (periodoLetra.equals("semanal")) {
                out.print("\"letra\":\"Letra N� " + i + " (S)\"");
                out.print(" , \"fechaVencimiento\":\"" + objcManejoFechas.fechaSumarDias(fechaInicio, (i * 7) - 7) + "\"");
            }
            if (i == numeroCuotas) {
                Double ultimaLetra = neto - inicial - acumulado;
                out.print(" , \"monto\":\"" + objcUtilitarios.agregarCerosNumeroFormato(objcUtilitarios.redondearDecimales(ultimaLetra, 2), 2) + "\"");
            } else {
                out.print(" , \"monto\":\"" + objcUtilitarios.agregarCerosNumeroFormato(montoLetra, 2) + "\"");
            }
            acumulado += montoLetra;
        }
        out.print("}");
    }
    out.print("]");
%>