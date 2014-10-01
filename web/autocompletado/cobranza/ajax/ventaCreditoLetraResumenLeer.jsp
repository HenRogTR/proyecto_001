<%-- 
    Document   : ventaCreditoLetraResumenLeer
    Created on : 05/10/2013, 11:09:42 AM
    Author     : Henrri
--%>

<%@page import="Ejb.EjbVentaCreditoLetra"%>
<%@page import="otrasTablasClases.cDatosExtras"%>
<%@page import="java.util.Date"%>
<%@page import="utilitarios.cManejoFechas"%>
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
    int codVenta = 0;
    String margen = "";
    try {
        codCliente = Integer.parseInt(request.getParameter("codCliente"));
        //actualizamos letras pendientes interes
//        Date fechaVencimiento = new Date();
//        int diaEspera = new cDatosExtras().leer_diaEspera().getEntero();
//        Date fechaVencimientoEspera = new cManejoFechas().StringADate(new cManejoFechas().fechaSumarDias(fechaVencimiento, -diaEspera));
//        List VCLetra = new cVentaCreditoLetra().leer_cliente_interesSinActualizar(fechaVencimientoEspera, fechaVencimiento, true, codCliente);
//        new cVentaCreditoLetra().actualizar_interes(VCLetra, fechaVencimiento);

        EjbVentaCreditoLetra ejbVentaCreditoLetra = new EjbVentaCreditoLetra();
        if (!ejbVentaCreditoLetra.actualizarInteresPorCodigoCliente(codCliente)) {
            out.print("Error en ejecución de operación.");
            return;
        }

        List lVentaCreditoLetra = new cVentaCreditoLetra().leer_codCliente(codCliente);
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
                if (codVenta != objVentaCreditoLetra.getVentas().getCodVentas()) {
                    codVenta = objVentaCreditoLetra.getVentas().getCodVentas();
                    margen = "finalVenta";
                } else {
                    margen = "";
                }
                double saldo = objVentaCreditoLetra.getMonto() - objVentaCreditoLetra.getTotalPago() + objVentaCreditoLetra.getInteres() - objVentaCreditoLetra.getInteresPagado();
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
                        + ",\"monto\":\"" + objcOtros.decimalFormato(objVentaCreditoLetra.getMonto(), 2) + "\""
                        + ",\"interes\":\"" + objcOtros.decimalFormato(objVentaCreditoLetra.getInteres(), 2) + "\""
                        + ",\"totalPago\":\"" + objcOtros.decimalFormato(objVentaCreditoLetra.getTotalPago() + objVentaCreditoLetra.getInteresPagado(), 2) + "\""
                        + ",\"fechaPago\":\"" + objcManejoFechas.DateAString(objVentaCreditoLetra.getFechaPago()) + "\""
                        + ",\"saldo\":\"" + new cOtros().decimalFormato(saldo, 2) + "\""
                        + ",\"diasRetraso\":\"" + dias + "\""
                        + ",\"estilo\":\"" + estilo + "\""
                        + ",\"finalVenta\":\"" + margen + "\""
                        + ",\"codVenta\":" + objVentaCreditoLetra.getVentas().getCodVentas()
                        + ",\"docNumeroSerie\":\"" + objVentaCreditoLetra.getVentas().getDocSerieNumero() + "\""
                        + "}");
            }
        }
    } catch (Exception e) {
    }
%>
]