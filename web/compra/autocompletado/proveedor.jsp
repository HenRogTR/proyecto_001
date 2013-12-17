<%-- 
    Document   : proveedor
    Created on : 15/03/2013, 05:59:03 PM
    Author     : Henrri
--%>
<%@page import="tablas.Proveedor"%>
<%@page import="java.util.Iterator"%>
<%@page import="utilitarios.cOtros"%>
<%@page import="personaClases.cProveedor"%>
<%@page import="java.util.List"%>

[
<%
    try {
        String term = request.getParameter("term").toString();
        List proveedorList = new cProveedor().leerRucORazonSocial(term);
        if (proveedorList != null) {
            cOtros objcOtros = new cOtros();
            int cont = 0;
            for (Iterator it = proveedorList.iterator(); it.hasNext();) {
                if (cont++ > 0) {
                    out.print(",");
                }
                Proveedor objProveedor = (Proveedor) it.next();
                out.print("{ "
                        + "\"label\":\"" + objProveedor.getRuc() + " " + objcOtros.replace_comillas_comillasD_barraInvertida(objProveedor.getRazonSocial()) + "\", "
                        + "\"value\":{"
                        + "\"codProveedor\":" + objProveedor.getCodProveedor()
                        + ",\"ruc\":\"" + objProveedor.getRuc() + "\""
                        + ",\"razonSocial\":\"" + objcOtros.replace_comillas_comillasD_barraInvertida(objProveedor.getRazonSocial()) + "\""
                        + ",\"direccion\":\"" + objcOtros.replace_comillas_comillasD_barraInvertida(objProveedor.getDireccion()) + "\""
                        + "}}");
            }
        }
    } catch (Exception e) {

    }
%>
]