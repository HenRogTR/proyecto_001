<%-- 
    Document   : articuloProductoSalida
    Created on : 29/08/2013, 05:34:31 PM
    Author     : Henrri*******
--%>

<%@page import="ventaClases.cVentasDetalle"%>
<%@page import="utilitarios.cManejoFechas"%>
<%@page import="tablas.VentasDetalle"%>
<%@page import="java.util.Iterator"%>
<%@page import="utilitarios.cOtros"%>
<%
    int codAP = 0;
    try {
        codAP = Integer.parseInt(request.getParameter("codArticuloProducto"));
    } catch (Exception e) {
        out.print("[]");
        return;
    }
    cVentasDetalle objcVentasDetalle = new cVentasDetalle();
    cOtros objcOtros = new cOtros();
    cManejoFechas objcManejoFechas = new cManejoFechas();
    Iterator iUltimos10 = objcVentasDetalle.leer_ultimoDiez(codAP).iterator();
    out.print("[");
    int cont = 0;
    while (iUltimos10.hasNext()) {
        if (cont++ > 0) {
            out.print(",");
        }
        VentasDetalle objVentasDetalle = (VentasDetalle) iUltimos10.next();
        out.print("{"
                + "\"fecha\":\"" + objcManejoFechas.DateAString(objVentasDetalle.getVentas().getFecha()) + "\""
                + ",\"codVenta\":\"" + objcOtros.agregarCeros_int(objVentasDetalle.getVentas().getCodVentas(), 8) + "\""
                + ",\"docSerieNumero\":\"" + objVentasDetalle.getVentas().getDocSerieNumero() + "\""
                + ",\"tipo\":\"" + objVentasDetalle.getVentas().getTipo() + "\""
                + ",\"precioVenta\":\"" + objcOtros.agregarCerosNumeroFormato(objVentasDetalle.getPrecioVenta(), 2) + "\""
                + ",\"\":\"" + "" + "\""
                + ",\"codPersona\":\"" + objcOtros.agregarCeros_int(objVentasDetalle.getVentas().getPersona().getCodPersona(), 8) + "\""
                + ",\"nombresC\":\"" + objcOtros.replace_comillas_comillasD_barraInvertida(objVentasDetalle.getVentas().getPersona().getNombresC()) + "\""
                + "}");
    }
    out.print("]");
%>