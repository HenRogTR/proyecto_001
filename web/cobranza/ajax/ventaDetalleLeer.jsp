<%-- 
    Document   : ventaDetalleLeer
    Created on : 05/10/2013, 11:48:54 AM
    Author     : Henrri
--%><%@page import="utilitarios.cOtros"%>
<%@page import="tablas.VentasDetalle"%>
<%@page import="java.util.Iterator"%>
<%@page import="ventaClases.cVentasDetalle"%>
<%@page import="java.util.List"%>

[
<%
    try {
        int codVenta = Integer.parseInt(request.getParameter("codVenta"));
        List lVD = new cVentasDetalle().leer_ventas_porCodVentas(codVenta);
        if (lVD != null) {
            cOtros objcOtros = new cOtros();
            int cont = 0;
            for (Iterator it = lVD.iterator(); it.hasNext();) {
                VentasDetalle objVentasDetalle = (VentasDetalle) it.next();
                if (cont++ > 0) {
                    out.print(",");
                }
                out.print("{"
                        + "\"docSerieNumero\":\"" + objVentasDetalle.getVentas().getDocSerieNumero() + "\""
                        + ",\"cantidad\":" + objVentasDetalle.getCantidad()
                        + ",\"descripcion\":\"" + objcOtros.replace_comillas_comillasD_barraInvertida(objVentasDetalle.getDescripcion()) + "\""
                        + ",\"precioVenta\":\"" + objcOtros.agregarCerosNumeroFormato(objVentasDetalle.getPrecioVenta(), 2) + "\""
                        + ",\"valorVenta\":\"" + objcOtros.agregarCerosNumeroFormato(objVentasDetalle.getValorVenta(), 2) + "\""
                        + "}");
            }
        }
    } catch (Exception e) {
    }
%>
]