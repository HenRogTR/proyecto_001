<%-- 
    Document   : articuloProductoDescripcionBuscar
    Created on : 22/12/2012, 12:08:31 AM
    Author     : Henrri
--%>
<%@page import="utilitarios.cOtros"%>
<%@page import="tablas.ArticuloProducto"%>
<%@page import="articuloProductoClases.cArticuloProducto"%>
<%@page import="java.util.Iterator"%>
<%@page import="java.util.List"%>
<%
    String term = request.getParameter("term");
    if (term == null) {
        return;
    }
    cArticuloProducto objcArticuloProducto = new cArticuloProducto();
    List lArticuloProducto = objcArticuloProducto.leer(term);
    int contador = 0;
    out.print("[");
    for (int i = 0; i < lArticuloProducto.size(); i++) {
        ArticuloProducto objArticuloProducto = (ArticuloProducto) lArticuloProducto.get(i);
        if (contador++ > 0) {
            out.println(",");
        }
        String codArticuloProducto = new cOtros().agregarCeros_int(objArticuloProducto.getCodArticuloProducto(), 8);
        String descripcion = new cOtros().replace_comillas_comillasD_barraInvertida(objArticuloProducto.getDescripcion());
        out.println("{ \"label\" : \"" + descripcion + " ,COD: " + codArticuloProducto + "\", \"value\" : {"
                + " \"codArticuloProducto\" : \"" + codArticuloProducto + "\""
                + ",\"codReferencia\" : \"" + (objArticuloProducto.getCodReferencia() == null ? "" : objArticuloProducto.getCodReferencia()) + "\" "
                + ",\"descripcion\" : \"" + descripcion + "\" "
                + ",\"precioVenta\":\"" + new cOtros().decimalFormato(objArticuloProducto.getPrecioVenta(), 2) + "\""
                + ",\"familia\" : \"" + objArticuloProducto.getFamilia().getFamilia() + "\" "
                + ",\"marca\" : \"" + objArticuloProducto.getMarca().getDescripcion() + "\" "
                + ",\"unidadMedida\" : \"" + objArticuloProducto.getUnidadMedida() + "\" "
                + ",\"usarSerieNumero\" : \"" + (objArticuloProducto.getUsarSerieNumero() ? "HABILITADO" : "DESABILITADO") + "\""
                + ",\"reintegroTributario\" : \"" + (objArticuloProducto.getReintegroTributario() ? "SI" : "NO") + "\""
                + ",\"observaciones\" : \"" + objArticuloProducto.getObservaciones() + "\""
                + ",\"registro\" : \"" + objArticuloProducto.getRegistro() + "\""
                + "} }");
    }
    out.print("]");
%>