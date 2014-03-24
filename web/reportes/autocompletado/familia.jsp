<%-- 
    Document   : familia
    Created on : 20/03/2014, 10:06:04 AM
    Author     : Henrri
--%>

<%@page import="utilitarios.cOtros"%>
<%@page import="tablas.Familia"%>
<%@page import="java.util.Iterator"%>
<%@page import="articuloProductoClases.cFamilia"%>
<%@page import="java.util.List"%>
<%
    String term = request.getParameter("term");
    if (term == null) {
        return;
    }
    List familiaList = new cFamilia().leer_coincidencia_SC(term);
    cOtros objcOtros = new cOtros();
    int contador = 0;
    out.print("[");
    for (Iterator it = familiaList.iterator(); it.hasNext();) {
        Familia objFamilia = (Familia) it.next();
        if (contador++ > 0) {
            out.println(", ");
        }
        out.print("{\"label\" : \"" + objcOtros.replace_comillas_comillasD_barraInvertida(objFamilia.getFamilia()) + "\""
                + ",\"value\":{"
                + "\"codFamilia\" :" + objFamilia.getCodFamilia()
                + ",\"familia\":\"" + objFamilia.getFamilia() + "\""
                + "} }");
    }
    out.print("]");
%>