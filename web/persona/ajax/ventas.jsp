<%-- 
    Document   : ventas
    Created on : 29/05/2013, 06:56:43 PM
    Author     : Henrri
--%>
<%@page import="tablas.VentasSerieNumero"%>
<%@page import="tablas.VentasDetalle"%>
<%@page import="tablas.VentaCreditoLetra"%>
<%@page import="tablas.VentaCredito"%>
<%@page import="otros.cManejoFechas"%>
<%@page import="otros.cUtilitarios"%>
<%@page import="java.util.Iterator"%>
<%@page import="java.util.ArrayList"%>
<%@page import="java.util.List"%>
<%@page import="tablas.Ventas"%>
<%@page import="ventaClases.cVenta"%>
<%
    boolean estado = true;
    String mensaje = "";
    int codPersona = 0;

    cVenta objcVentas = new cVenta();
    List lVentas = new ArrayList();
    try {
        codPersona = Integer.parseInt(request.getParameter("codPersona"));
        lVentas = objcVentas.leer_codPersona_orderByAsc(codPersona);
        if (lVentas == null) {
            estado = false;
            mensaje = objcVentas.getError();
        }
    } catch (Exception e) {
        estado = false;
        mensaje = "Error codPersona";
    }

    if (!estado) {
        out.print("[{");
        out.print("\"error\":\"" + mensaje + "\"");
        out.print("}]");
        return;
    }

    cManejoFechas objcManejoFechas = new cManejoFechas();
    cUtilitarios objcUtilitarios = new cUtilitarios();
    Iterator iVentas = lVentas.iterator();
    int contador = 0;
    out.print("[");
    while (iVentas.hasNext()) {
        String serie = "";
        Ventas objVentas = (Ventas) iVentas.next();
        for (VentasDetalle objVentasDetalle : objVentas.getVentasDetalles()) {
            for (VentasSerieNumero objVentasSerieNumero : objVentasDetalle.getVentasSerieNumeros()) {
                serie = objcUtilitarios.replace_comillas_comillasD_barraInvertida(objVentasSerieNumero.getSerieNumero() + "<br>" + objVentasSerieNumero.getObservacion());
            }
        }
        Double interesGeneredo = 0.00, montoAmortizado = objVentas.getNeto(), deudaTotal = 0.00;
        String tipoVenta = "Contado";
        int numeroLetras = 0;
        if (objVentas.getVentaCreditos().iterator().hasNext()) {
            montoAmortizado = 0.00;
            VentaCredito objVentaCredito = (VentaCredito) objVentas.getVentaCreditos().iterator().next();
            tipoVenta = "Crédito";
            numeroLetras = objVentaCredito.getCantidadLetras();
            for (VentaCreditoLetra objVentaCreditoLetra : objVentaCredito.getVentaCreditoLetras()) {
                montoAmortizado += objVentaCreditoLetra.getTotalPago();
            }
            deudaTotal = objVentas.getNeto() - montoAmortizado;
        }

        if (contador++ > 0) {
            out.println(",");
        }
        out.print("{"
                + "\"codPersona\":" + codPersona
                + ",\"codVentas\":" + objVentas.getCodVentas()
                + ",\"docSerieNumero\":\"" + objVentas.getDocSerieNumero() + "\""
                + ",\"fecha\":\"" + objcManejoFechas.fechaDateToString(objVentas.getFecha()) + "\""
                + ",\"neto\":\"" + objcUtilitarios.agregarCerosNumeroFormato(objVentas.getNeto(), 2) + "\""
                + ",\"interesGenerado\":\"" + (interesGeneredo == 0 ? "" : objcUtilitarios.agregarCerosNumeroFormato(interesGeneredo, 2)) + "\""
                + ",\"montoAmortizado\":\"" + objcUtilitarios.agregarCerosNumeroFormato(objcUtilitarios.redondearDecimales(montoAmortizado, 2), 2) + "\""
                + ",\"deudaTotal\":\"" + objcUtilitarios.agregarCerosNumeroFormato(objcUtilitarios.redondearDecimales(deudaTotal, 2), 2) + "\""
                + ",\"numeroLetras\":\"" + (numeroLetras == 0 ? "" : numeroLetras) + "\""
                + ",\"tVenta\":\"" + tipoVenta + "\""
                + ",\"tCambio\":" + "\"1.00\"" + ""
                + ",\"observacion\":\"" + objcUtilitarios.replace_comillas_comillasD_barraInvertida(objVentas.getObservacion()).replace("\\n", "<br>") + "\""
                + ",\"serie\":\"" + serie + "\""
                + ",\"registro\":\"" + objVentas.getRegistro() + "\""
                + "}");
    }
    out.print("]");
%>
