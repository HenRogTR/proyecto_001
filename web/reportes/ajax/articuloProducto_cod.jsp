<%-- 
    Document   : articuloProductoLeer
    Created on : 18/10/2013, 05:21:18 PM
    Author     : Henrri
--%>
<%@page import="tablas.KardexArticuloProducto"%>
<%@page import="utilitarios.cOtros"%>
<%@page import="articuloProductoClases.cArticuloProducto"%>
<%@page import="tablas.ArticuloProducto"%>


[
<%
    try {
        int codArticuloProducto = Integer.parseInt(request.getParameter("codArticuloProducto"));
        ArticuloProducto objArticuloProducto = new cArticuloProducto().leer_cod(codArticuloProducto);
        if (objArticuloProducto != null) {
            out.print("{"
                    + " \"codArticuloProducto\" : \"" + new cOtros().agregarCeros_int(objArticuloProducto.getCodArticuloProducto(), 8) + "\""
                    + ",\"descripcion\" : \"" + new cOtros().replace_comillas_comillasD_barraInvertida(objArticuloProducto.getDescripcion()) + "\" "
                    + ",\"unidadMedida\" : \"" + objArticuloProducto.getUnidadMedida().toUpperCase() + "\" "
                    + ",\"usarSerieNumero\" : " + objArticuloProducto.getUsarSerieNumero()
                    + "}");
        }
    } catch (Exception e) {

    }
%>

]