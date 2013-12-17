<%-- 
    Document   : articuloProductoDescripcionBuscar
    Created on : 22/12/2012, 12:08:31 AM
    Author     : Henrri
--%>

<%@page import="articuloProductoClases.cArticuloProducto"%>
<%@page import="utilitarios.cOtros"%>
<%@page import="java.util.List"%>
<%@page import="java.util.Iterator"%>
<%@page import="tablas.ArticuloProducto"%>
<%
    String term = request.getParameter("term");
    if (term == null) {
        return;
    }
    cArticuloProducto objcArticuloProducto = new cArticuloProducto();
    cOtros objcOtros = new cOtros();
    List lAP = objcArticuloProducto.leer(term);
    Iterator iAP = lAP.iterator();
    int contador = 0;
    out.print("[");
    while (iAP.hasNext()) {
        ArticuloProducto objAP = (ArticuloProducto) iAP.next();
        if (contador++ > 0) {
            out.println(",");
        }
        out.print("{\"label\" : \"" + objcOtros.replace_comillas_comillasD_barraInvertida(objAP.getDescripcion()) + "\",\"value\":{"
                + "\"codArticuloProducto\" : \"" + objcOtros.agregarCeros_int(objAP.getCodArticuloProducto(), 8) + "\""
                + ",\"descripcion\":\"" + objcOtros.replace_comillas_comillasD_barraInvertida(objAP.getDescripcion()) + "\""
                + "} }");
    }
    out.print("]");
%>