<%-- 
    Document   : ap
    Created on : 18/12/2013, 11:25:35 AM
    Author     : Henrri
--%>
<%@page import="utilitarios.cOtros"%>
<%@page import="articuloProductoClases.cArticuloProducto"%>
<%@page import="tablas.ArticuloProducto"%>

[
<%
    int codArticuloProducto = 0;
    ArticuloProducto objArticuloProducto = null;
    try {
        codArticuloProducto = Integer.parseInt(request.getParameter("codArticuloProducto"));
        objArticuloProducto = new cArticuloProducto().leer_cod(codArticuloProducto);
    } catch (Exception e) {
    }
    if (objArticuloProducto != null) {
        session.setAttribute("codArticuloProductoKardex", codArticuloProducto);
        cOtros objcOtros = new cOtros();
        out.print("{"
                + " \"codArticuloProducto\" : \"" + objcOtros.agregarCeros_int(objArticuloProducto.getCodArticuloProducto(), 8) + "\""
                + ",\"codReferencia\" : \"" + (objArticuloProducto.getCodReferencia() == null ? "" : objArticuloProducto.getCodReferencia()) + "\" "
                + ",\"descripcion\" : \"" + objcOtros.replace_comillas_comillasD_barraInvertida(objArticuloProducto.getDescripcion()) + "\" "
                + ",\"precioVenta\":\"" + objcOtros.agregarCerosNumeroFormato(objArticuloProducto.getPrecioVenta(), 2) + "\""
                + ",\"familia\" : \"" + objArticuloProducto.getFamilia().getFamilia() + "\" "
                + ",\"marca\" : \"" + objArticuloProducto.getMarca().getDescripcion() + "\" "
                + ",\"unidadMedida\" : \"" + objArticuloProducto.getUnidadMedida() + "\" "
                + ",\"usarSerieNumero\" : " + objArticuloProducto.getUsarSerieNumero()
                + ",\"reintegroTributario\" : \"" + (objArticuloProducto.getReintegroTributario() ? "SI" : "NO") + "\""
                + ",\"observaciones\" : \"" + objArticuloProducto.getObservaciones() + "\""
                + ",\"registro\" : \"" + objArticuloProducto.getRegistro() + "\""
                + "}");
    }
%>
]