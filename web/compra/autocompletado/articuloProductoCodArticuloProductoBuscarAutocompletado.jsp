<%-- 
    Document   : articuloProductoCodArticuloProductoBuscarAutocompletado
    Created on : 01/04/2013, 12:20:52 PM
    Author     : Henrri
--%>
<%@page import="otros.cUtilitarios"%>
<%@page import="tablas.ArticuloProducto"%>
<%@page import="articuloProductoClases.cArticuloProducto"%>
<%
    String term = request.getParameter("term");
    if (term == null) {
        return;
    }
    cArticuloProducto objcArticuloProducto = new cArticuloProducto();
    cUtilitarios objcUtilitarios=new cUtilitarios();
    ArticuloProducto objArticuloProducto = objcArticuloProducto.leer_cod(Integer.parseInt(term));
    out.print("[");
    if (objArticuloProducto != null) {
        String descripcion=objcUtilitarios.replace_comillas_comillasD_barraInvertida(objArticuloProducto.getDescripcion());
        out.println("{ \"label\" : \""+objArticuloProducto.getCodArticuloProducto()+" " + descripcion + "\", \"value\" : {"
                + " \"codArticuloProducto\" : " + objArticuloProducto.getCodArticuloProducto()
                + ",\"descripcion\" : \"" + descripcion + "\""
                + ",\"unidadMedida\" : \"" + objArticuloProducto.getUnidadMedida() + "\""
                + ",\"usarSerieNumero\" : " + objArticuloProducto.getUsarSerieNumero() + ""
                + " } }");
    }
    out.print("]");
%>
