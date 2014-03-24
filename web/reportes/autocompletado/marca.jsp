<%-- 
    Document   : marca
    Created on : 20/03/2014, 11:18:29 AM
    Author     : Henrri
--%>

<%@page import="tablas.Marca"%>
<%@page import="java.util.Iterator"%>
<%@page import="java.util.List"%>
<%@page import="utilitarios.cOtros"%>
<%@page import="articuloProductoClases.cMarca"%>
<%
    String term = request.getParameter("term");
    if (term == null) {
        return;
    }
    List marcaList = new cMarca().leer_coincidencia_SC(term);
    cOtros objcOtros = new cOtros();
    int contador = 0;
    out.print("[");
    for (Iterator it = marcaList.iterator(); it.hasNext();) {
        Marca objMarca = (Marca) it.next();
        if (contador++ > 0) {
            out.println(", ");
        }
        out.print("{\"label\" : \"" + objcOtros.replace_comillas_comillasD_barraInvertida(objMarca.getDescripcion()) + "\""
                + ",\"value\":{"
                + "\"codMarca\" :" + objMarca.getCodMarca()
                + ",\"descripcion\":\"" + objMarca.getDescripcion() + "\""
                + "} }");
    }
    out.print("]");
%>