<%-- 
    Document   : articuloProductoLeer
    Created on : 18/10/2013, 05:21:18 PM
    Author     : Henrri
--%><%@page import="tablas.KardexArticuloProducto"%>
<%@page import="utilitarios.cOtros"%>
<%@page import="articuloProductoClases.cArticuloProducto"%>
<%@page import="tablas.ArticuloProducto"%>


[
<%
    try {
        int codArticuloProducto = Integer.parseInt(request.getParameter("codArticuloProducto"));
        ArticuloProducto objArticuloProducto = new cArticuloProducto().leer_cod(codArticuloProducto);
        if (objArticuloProducto != null) {
            cOtros objcOtros = new cOtros();
            int stock = 0, codKAP = 0;
            for (KardexArticuloProducto objKardexArticuloProducto : objArticuloProducto.getKardexArticuloProductos()) {
                if (objKardexArticuloProducto.getCodKardexArticuloProducto() > codKAP) {
                    codKAP = objKardexArticuloProducto.getCodKardexArticuloProducto();
                    stock = objKardexArticuloProducto.getStock();
                }
            }
            out.println("{"
                    + " \"codArticuloProducto\" : \"" + objArticuloProducto.getCodArticuloProducto() + "\""
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
                    + ",\"stock\" : \"" + stock + "\""
                    + "}");
        }
    } catch (Exception e) {

    }
%>

]