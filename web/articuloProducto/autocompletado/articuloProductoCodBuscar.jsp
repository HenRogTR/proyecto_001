<%-- 
    Document   : articuloProductoCodBuscar
    Created on : 15/04/2013, 12:38:52 PM
    Author     : Henrri
--%>

<%@page import="utilitarios.cOtros"%>
<%@page import="articuloProductoClases.cArticuloProducto"%>
<%@page import="tablas.ArticuloProducto"%>
<%
    String term = request.getParameter("term");
    if (term == null) {
        return;
    }
    cArticuloProducto objcArticuloProducto = new cArticuloProducto();
    ArticuloProducto objArticuloProducto = objcArticuloProducto.leer_cod(Integer.parseInt(term));
    out.print("[");
    if (objArticuloProducto != null) {
        String codArticuloProducto = new cOtros().agregarCeros_int(objArticuloProducto.getCodArticuloProducto(), 8);
        String descripcion = new cOtros().replace_comillas_comillasD_barraInvertida(objArticuloProducto.getDescripcion());
        out.println("{ \"label\" : \"" + codArticuloProducto + " " + descripcion + "\", \"value\" : {"
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
