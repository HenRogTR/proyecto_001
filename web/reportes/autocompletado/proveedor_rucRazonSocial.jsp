<%-- 
    Document   : proveedor_rucRazonSocial
    Created on : 27/03/2014, 03:58:13 PM
    Author     : Henrri
--%>

<%@page import="tablas.Proveedor"%>
<%@page import="java.util.Iterator"%>
<%@page import="utilitarios.cOtros"%>
<%@page import="personaClases.cProveedor"%>
<%@page import="java.util.List"%>
<%
    String term = request.getParameter("term");
    if (term == null) {
        return;
    }
    List proveedorList = new cProveedor().leer_coincidencia_SC(term);
    cOtros objcOtros = new cOtros();
    int contador = 0;
    out.print("[");
    for (Iterator it = proveedorList.iterator(); it.hasNext();) {
        Proveedor objProveedor = (Proveedor) it.next();
        if (contador++ > 0) {
            out.println(", ");
        }
        out.print("{\"label\" : \"" + objProveedor.getRuc() + " " + objcOtros.replace_comillas_comillasD_barraInvertida(objProveedor.getRazonSocial()) + "\""
                + ",\"value\":{"
                + "\"codProveedor\" :" + objProveedor.getCodProveedor()
                + ",\"ruc\":\"" + objProveedor.getRuc() + "\""
                + ",\"razonSocial\":\"" + objcOtros.replace_comillas_comillasD_barraInvertida(objProveedor.getRazonSocial()) + "\""
                + "} }");
    }
    out.print("]");
%>