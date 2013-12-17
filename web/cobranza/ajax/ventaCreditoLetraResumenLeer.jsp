<%-- 
    Document   : ventaCreditoLetraResumenLeer
    Created on : 05/10/2013, 11:09:42 AM
    Author     : Henrri
--%><%@page import="utilitarios.cManejoFechas"%>
<%@page import="utilitarios.cOtros"%>
<%@page import="tablas.VentaCreditoLetra"%>
<%@page import="java.util.Iterator"%>
<%@page import="personaClases.cPersona"%>
<%@page import="personaClases.cDatosCliente"%>
<%@page import="ventaClases.cVentaCreditoLetra"%>
<%@page import="java.util.List"%>


[
<%
    int codCliente = 0;
    int codVentaCredito = 0;
    String margen = "";
    try {
        codCliente = Integer.parseInt(request.getParameter("codCliente"));
        List lVentaCreditoLetra = new cVentaCreditoLetra().leer_porCodCliente(new cDatosCliente().leer_cod(codCliente).getPersona().getCodPersona());
        cOtros objcOtros = new cOtros();
        cManejoFechas objcManejoFechas = new cManejoFechas();
        if (lVentaCreditoLetra != null) {
            int cont = 0;
            for (Iterator it = lVentaCreditoLetra.iterator(); it.hasNext();) {
                VentaCreditoLetra objVentaCreditoLetra = (VentaCreditoLetra) it.next();
                if (cont++ > 0) {
                    out.print(",");
                }
                String dias = "";
                String estilo = "";
                if (codVentaCredito != objVentaCreditoLetra.getVentaCredito().getCodVentaCredito()) {
                    codVentaCredito = objVentaCreditoLetra.getVentaCredito().getCodVentaCredito();
                    margen = "finalVenta";
                } else {
                    margen = "";
                }
                double saldo = objVentaCreditoLetra.getMonto() - objVentaCreditoLetra.getTotalPago();
                int diasRetraso = objcManejoFechas.diferenciaDias(objVentaCreditoLetra.getFechaVencimiento());
                if (saldo > 0 & diasRetraso > 0) {
                    dias = String.valueOf(diasRetraso);
                    estilo = "tomato";
                }
                if (saldo > 0 & objVentaCreditoLetra.getNumeroLetra() == 0) {
                    estilo = "tomato";
                }
                if (saldo > 0 & diasRetraso < 0 & diasRetraso > -6) {
                    estilo = "#ffcccc";
                }
                out.print("{"
                        + "\"codVentaCreditoLetra\":" + objVentaCreditoLetra.getCodVentaCreditoLetra()
                        + ",\"moneda\":\"" + new cVentaCreditoLetra().moneda(objVentaCreditoLetra.getMoneda()) + "\""
                        + ",\"numeroLetras\":\"" + objVentaCreditoLetra.getNumeroLetra() + "\""
                        + ",\"detalleLetra\":\"" + objVentaCreditoLetra.getDetalleLetra() + "\""
                        + ",\"fechaVencimiento\":\"" + objcManejoFechas.DateAString(objVentaCreditoLetra.getFechaVencimiento()) + "\""
                        + ",\"monto\":\"" + objcOtros.agregarCerosNumeroFormato(objVentaCreditoLetra.getMonto(), 2) + "\""
                        + ",\"interes\":\"" + objcOtros.agregarCerosNumeroFormato(objVentaCreditoLetra.getInteres(), 2) + "\""
                        + ",\"totalPago\":\"" + objcOtros.agregarCerosNumeroFormato(objVentaCreditoLetra.getTotalPago(), 2) + "\""
                        + ",\"fechaPago\":\"" + objcManejoFechas.DateAString(objVentaCreditoLetra.getFechaPago()) + "\""
                        //                + ",\"saldo\":\"" + objcUtilitarios.agregarCerosNumeroFormato(objcUtilitarios.redondearDecimales(objVentaCreditoLetra.getMonto() - objVentaCreditoLetra.getTotalPago(), 2), 2) + "\""
                        + ",\"saldo\":\"" + objcOtros.agregarCerosNumeroFormato(objcOtros.redondearDecimales(saldo, 2), 2) + "\""
                        + ",\"diasRetraso\":\"" + dias + "\""
                        + ",\"estilo\":\"" + estilo + "\""
                        + ",\"finalVenta\":\"" + margen + "\""
                        //datos de venta
                        + ",\"codVenta\":" + objVentaCreditoLetra.getVentaCredito().getVentas().getCodVentas()
                        + ",\"docNumeroSerie\":\"" + objVentaCreditoLetra.getVentaCredito().getVentas().getDocSerieNumero() + "\""
                        + "}");
            }
        }
    } catch (Exception e) {
    }
%>
]