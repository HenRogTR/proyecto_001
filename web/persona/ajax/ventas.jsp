<%-- 
    Document   : ventas
    Created on : 29/05/2013, 06:56:43 PM
    Author     : Henrri
--%>
<%@page import="utilitarios.cManejoFechas"%>
<%@page import="utilitarios.cOtros"%>
<%@page import="tablas.VentasSerieNumero"%>
<%@page import="tablas.VentasDetalle"%>
<%@page import="tablas.VentaCreditoLetra"%>
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

    Iterator iVentas = lVentas.iterator();
    int contador = 0;
    out.print("[");
    while (iVentas.hasNext()) {
        String serie = "";
        Ventas objVentas = (Ventas) iVentas.next();
        for (VentasDetalle objVentasDetalle : objVentas.getVentasDetalles()) {
            for (VentasSerieNumero objVentasSerieNumero : objVentasDetalle.getVentasSerieNumeros()) {
                serie = new cOtros().replace_comillas_comillasD_barraInvertida(objVentasSerieNumero.getSerieNumero() + "<br>" + objVentasSerieNumero.getObservacion());
            }
        }
        Double interesGeneredo = 0.00, montoAmortizado = objVentas.getNeto(), deudaTotal = 0.00;
        String tipoVenta = "Contado";
        int numeroLetras = 0;
        if (objVentas.getTipo().equals("credito")) {
            montoAmortizado = 0.00;
            tipoVenta = "Cr�dito";
            numeroLetras = objVentas.getCantidadLetras();
            for (VentaCreditoLetra objVentaCreditoLetra : objVentas.getVentaCreditoLetras()) {
                //evitar que considere letras eliminadas
                if (objVentaCreditoLetra.getRegistro().substring(0, 1).equals("1")) {
                    montoAmortizado += objVentaCreditoLetra.getTotalPago();
                }
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
                + ",\"fecha\":\"" + new cManejoFechas().DateAString(objVentas.getFecha()) + "\""
                + ",\"neto\":\"" + new cOtros().decimalFormato(objVentas.getNeto(), 2) + "\""
                + ",\"interesGenerado\":\"" + (interesGeneredo == 0 ? "" : new cOtros().decimalFormato(interesGeneredo, 2)) + "\""
                + ",\"montoAmortizado\":\"" + new cOtros().decimalFormato(montoAmortizado, 2) + "\""
                + ",\"deudaTotal\":\"" + new cOtros().decimalFormato(deudaTotal, 2) + "\""
                + ",\"numeroLetras\":\"" + (numeroLetras == 0 ? "" : numeroLetras) + "\""
                + ",\"tVenta\":\"" + tipoVenta + "\""
                + ",\"tCambio\":" + "\"1.00\"" + ""
                + ",\"observacion\":\"" + new cOtros().replace_comillas_comillasD_barraInvertida(objVentas.getObservacion()).replace("\\n", "<br>") + "\""
                + ",\"serie\":\"" + serie + "\""
                + ",\"registro\":\"" + objVentas.getRegistro() + "\""
                + "}");
    }
    out.print("]");
%>
