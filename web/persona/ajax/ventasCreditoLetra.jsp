<%-- 
    Document   : ventasCreditoLetra
    Created on : 30/05/2013, 05:10:24 PM
    Author     : Henrri
--%>

<%@page import="utilitarios.cOtros"%>
<%@page import="utilitarios.cManejoFechas"%>
<%@page import="tablas.VentaCreditoLetra"%>
<%@page import="java.util.Iterator"%>
<%@page import="java.util.ArrayList"%>
<%@page import="ventaClases.cVentaCreditoLetra"%>
<%@page import="java.util.List"%>
<%
    boolean estado = true;
    String mensaje = "";
    int codVentas = 0;
    int codPersona = 0;
    List lVentaCreditoLetra = new ArrayList();
    cVentaCreditoLetra objcVentaCreditoLetra = new cVentaCreditoLetra();
    try {
        codVentas = Integer.parseInt(request.getParameter("codVentas"));
        codPersona = Integer.parseInt(request.getParameter("codPersona"));
        lVentaCreditoLetra = objcVentaCreditoLetra.leer_porCodVenta(codVentas);
        if (lVentaCreditoLetra == null) {
            estado = false;
            mensaje = "Error en consulta de letras";
        }
    } catch (Exception e) {
        estado = false;
        mensaje = "Error codigo";
    }
    if (!estado) {
        out.print(mensaje);
    }
    Iterator iVentaCreditoLetra = lVentaCreditoLetra.iterator();
    int contador = 0;
    out.println("[");
    while (iVentaCreditoLetra.hasNext()) {
        VentaCreditoLetra objVentaCreditoLetra = (VentaCreditoLetra) iVentaCreditoLetra.next();
        if (contador++ > 0) {
            out.println(",");
        }
        String dias = "";
        String estilo = "";
        double saldo = objVentaCreditoLetra.getMonto() - objVentaCreditoLetra.getTotalPago();
        int diasRetraso = new cManejoFechas().diferenciaDias(objVentaCreditoLetra.getFechaVencimiento());
        if (saldo > 0 & diasRetraso >= 0) {
            dias = String.valueOf(diasRetraso);
            estilo = "tomato";
        }
        if (saldo > 0 & diasRetraso < 0 & diasRetraso > -6) {
            estilo = "#ffcccc";
        }
        out.println("{"
                + "\"codVentaCreditoLetras\":" + objVentaCreditoLetra.getCodVentaCreditoLetra()
                + ",\"moneda\":\"" + objcVentaCreditoLetra.moneda(objVentaCreditoLetra.getMoneda()) + "\""
                + ",\"numeroLetras\":\"" + objVentaCreditoLetra.getNumeroLetra() + "\""
                + ",\"detalleLetra\":\"" + objVentaCreditoLetra.getDetalleLetra() + "\""
                + ",\"fechaVencimiento\":\"" + new cManejoFechas().DateAString(objVentaCreditoLetra.getFechaVencimiento()) + "\""
                + ",\"monto\":\"" + new cOtros().decimalFormato(objVentaCreditoLetra.getMonto(), 2) + "\""
                + ",\"interes\":\"" + new cOtros().decimalFormato(objVentaCreditoLetra.getInteres(), 2) + "\""
                + ",\"totalPago\":\"" + new cOtros().decimalFormato(objVentaCreditoLetra.getTotalPago(), 2) + "\""
                + ",\"fechaPago\":\"" + new cManejoFechas().DateAString(objVentaCreditoLetra.getFechaPago()) + "\""
                + ",\"saldo\":\"" + new cOtros().decimalFormato(saldo, 2) + "\""
                + ",\"diasRetraso\":\"" + dias + "\""
                + ",\"estilo\":\"" + estilo + "\""
                //datos de venta
                + ",\"codVentas\":" + objVentaCreditoLetra.getVentas().getCodVentas()
                + ",\"docNumeroSerie\":\"" + objVentaCreditoLetra.getVentas().getDocSerieNumero() + "\""
                + "}"
                //                + ","
                + "");

    }
    if (lVentaCreditoLetra.size() > 0) {
        out.print(",");
    }
    Object tem[] = objcVentaCreditoLetra.leer_resumen(codPersona);
    out.print("{"
            + "\"mTotal\":\"" + new cOtros().decimalFormato((Double) (tem[0] == null ? 0.00 : tem[0]), 2) + "\""
            + ",\"mAmortizado\":\"" + new cOtros().decimalFormato((Double) (tem[1] == null ? 0.00 : tem[1]), 2) + "\""
            + ",\"mSaldo\":\"" + new cOtros().decimalFormato((Double) (tem[2] == null ? 0.00 : tem[2]), 2) + "\""
            + "}");

    out.println("]");
%>
