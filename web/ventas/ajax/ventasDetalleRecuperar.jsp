<%-- 
    Document   : ventasDetalleRecuperar
    Created on : 19/05/2013, 04:58:42 PM
    Author     : Henrri
--%>

<%@page import="utilitarios.cOtros"%>
<%@page import="tablas.VentasSerieNumero"%>
<%@page import="tablas.VentasDetalle"%>
<%@page import="java.util.Iterator"%>
<%@page import="ventaClases.cVentasDetalle"%>
<%@page import="java.util.ArrayList"%>
<%@page import="java.util.List"%>
<%
    int codVentas = 0;
    List lVentasDetalle = new ArrayList();
    try {
        codVentas = Integer.parseInt(request.getParameter("codVentas"));
        lVentasDetalle = new cVentasDetalle().leer_ventasDetalle_porCodVentas(codVentas);


    } catch (Exception e) {
        out.print("[]");
        return;
    }
    cOtros objcOtros=new cOtros();
    int cont = 0;
    Iterator iVentasDetalle = lVentasDetalle.iterator();
    out.print("[");
    while (iVentasDetalle.hasNext()) {
        VentasDetalle objVentasDetalle = (VentasDetalle) iVentasDetalle.next();
        if (cont++ > 0) {
            out.print(",");
        }
        String serie = "";
        for (VentasSerieNumero objVentasSerieNumero : objVentasDetalle.getVentasSerieNumeros()) {
            serie += "&nbsp;&nbsp;" + objcOtros.replace_comillas_comillasD_barraInvertida(objVentasSerieNumero.getSerieNumero() + "<br>");
            if (!objVentasSerieNumero.getObservacion().equals("")) {
                serie += "&nbsp;&nbsp;"+  objcOtros.replace_comillas_comillasD_barraInvertida(objVentasSerieNumero.getObservacion()) + "<br>";
            }
        }
        out.print("{"
                + "\"item\":" + objVentasDetalle.getItem()
                + ",\"codArticuloProducto\":\"" + objcOtros.agregarCeros_int(objVentasDetalle.getArticuloProducto().getCodArticuloProducto(), 8) + "\""
                + ",\"cantidad\":" + objVentasDetalle.getCantidad()
                + ",\"unidadMedida\":\"" + objVentasDetalle.getArticuloProducto().getUnidadMedida() + "\""
                + ",\"descripcion\":\"" + objcOtros.replace_comillas_comillasD_barraInvertida(objVentasDetalle.getDescripcion()) + "<br>\""
                + ",\"serie\":\"" + serie + "\""
                + ",\"precioVenta\":\"" + objcOtros.agregarCerosNumeroFormato(objVentasDetalle.getPrecioVenta(), 2) + "\""
                + ",\"valorVenta\":\"" + objcOtros.agregarCerosNumeroFormato(objVentasDetalle.getValorVenta(), 2) + "\""
                + "}");
    }
    out.print("]");
%>
