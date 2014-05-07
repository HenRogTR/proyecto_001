<%-- 
    Document   : compraDetalleBuscarAjax
    Created on : 12/03/2013, 03:23:05 AM
    Author     : Henrri
--%>
<%@page import="utilitarios.cOtros"%>
<%@page import="tablas.CompraSerieNumero"%>
<%@page import="tablas.CompraDetalle"%>
<%@page import="java.util.List"%>
<%@page import="compraClases.cCompraDetalle"%>
<%
    String codCompra = request.getParameter("codCompra");
    if (codCompra == null) {
        return;
    }
    cCompraDetalle objcCompraDetalle = new cCompraDetalle();
    List lCompraDetalle = objcCompraDetalle.leer_compraDetalle_codCompra(Integer.parseInt(codCompra));
    int contador = 0;
    out.print("[");
    for (int i = 0; i < lCompraDetalle.size(); i++) {
        if (contador++ > 0) {
            out.println(",");
        }
        CompraDetalle objCompraDetalle = (CompraDetalle) lCompraDetalle.get(i);
        String serieNumero = "";
        int cont2 = 0;
        for (CompraSerieNumero objCompraSerieNumero : objCompraDetalle.getCompraSerieNumeros()) {
            if (cont2++ > 0) {
                serieNumero += "\\ ";
            }
            serieNumero += objCompraSerieNumero.getSerieNumero();
            if (!objCompraSerieNumero.getObservacion().equals("")) {
                serieNumero += "<br>"+objCompraSerieNumero.getObservacion();
            }
        }
        out.print("{"
                + "\"codCompraDetalle\":" + objCompraDetalle.getCodCompraDetalle() + ","
                + "\"cantidad\":" + objCompraDetalle.getCantidad() + ","
                + "\"precioUnitario\":\"" + new cOtros().decimalFormato(objCompraDetalle.getPrecioUnitario(), 4) + "\","
                + "\"precioTotal\":\"" + new cOtros().decimalFormato(objCompraDetalle.getPrecioTotal(),  2) + "\","
                + "\"item\":" + objCompraDetalle.getItem() + " ,"
                + "\"descripcion\":\"" + new cOtros().replace_comillas_comillasD_barraInvertida(objCompraDetalle.getDescripcion()) + "<br>" + new cOtros().replace_comillas_comillasD_barraInvertida(serieNumero) + "\" ,"
                + "\"unidadMedida\":\"" + "UNID." + "\""
                + "}");
    }
    out.print("]");
%>