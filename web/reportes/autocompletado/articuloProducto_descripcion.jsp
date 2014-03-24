<%-- 
    Document   : articuloProductoDescripcion
    Created on : 22/12/2012, 12:08:31 AM
    Author     : Henrri
--%>


<%@page import="tablas.ArticuloProducto"%>
<%@page import="java.util.List"%>
<%@page import="java.util.Iterator"%>
<%@page import="utilitarios.cOtros"%>
<%@page import="articuloProductoClases.cArticuloProducto"%>
<%
    String term = request.getParameter("term");
    if (term == null) {
        return;
    }
    cArticuloProducto objcArticuloProducto = new cArticuloProducto();
    cOtros objcOtros = new cOtros();
    List aPList = objcArticuloProducto.leer_SC(term);
    int contador = 0;
    out.print("[");
    for (Iterator it = aPList.iterator(); it.hasNext();) {
        ArticuloProducto objAP = (ArticuloProducto) it.next();
        if (contador++ > 0) {
            out.println(", ");
        }
        out.print("{\"label\" : \"" + objcOtros.replace_comillas_comillasD_barraInvertida(objAP.getDescripcion()) + "\""
                + ",\"value\":{"
                + "\"codArticuloProducto\" : \"" + objcOtros.agregarCeros_int(objAP.getCodArticuloProducto(), 8) + "\""
                + ",\"descripcion\":\"" + objcOtros.replace_comillas_comillasD_barraInvertida(objAP.getDescripcion()) + "\""
                + "} }");
    }
    out.print("]");
%>