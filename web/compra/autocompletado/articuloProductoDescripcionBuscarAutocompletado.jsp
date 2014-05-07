<%-- 
    Document   : articuloProductoDescripcionBuscarAutocompletado
    Created on : 12/11/2012, 07:09:24 PM
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
    List lArticuloProducto = objcArticuloProducto.leer_descripcion(new cOtros().replace_comillas_comillasD_barraInvertida(term));
    int contador = 0;
    out.print("[");
    for (int i = 0; i < lArticuloProducto.size(); i++) {
        ArticuloProducto objArticuloProducto = (ArticuloProducto) lArticuloProducto.get(i);
        if (contador++ > 0) {
            out.println(",");
        }
        int codArticuloProducto = objArticuloProducto.getCodArticuloProducto();
        String descripcion = new cOtros().replace_comillas_comillasD_barraInvertida(objArticuloProducto.getDescripcion());
        out.println("{ \"label\" : \"" + descripcion + "\", \"value\" : {"
                + " \"codArticuloProducto\" : " + codArticuloProducto
                + ",\"descripcion\" : \"" + descripcion + "\""
                + ",\"unidadMedida\" : \"" + objArticuloProducto.getUnidadMedida() + "\""
                + ",\"usarSerieNumero\" : " + objArticuloProducto.getUsarSerieNumero() + ""
                + " } }");
    }
    out.print("]");
%>