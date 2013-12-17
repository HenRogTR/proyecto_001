<%-- 
    Document   : proveedorRucRazonSocialBuscarAutocompletado
    Created on : 15/03/2013, 05:59:03 PM
    Author     : Henrri
--%>
<%@page import="java.util.List"%>
<%@page import="personaClases.cProveedor"%>
<%@page import="tablas.Proveedor"%>
<%
    String term = request.getParameter("term");
    if (term == null) {
        return;
    }
    cProveedor objcProveedor = new cProveedor();
    List lProveedor = objcProveedor.leerRucORazonSocial(term);
    int contador = 0;
    out.print("[");
    for (int i = 0; i < lProveedor.size(); i++) {
        if (contador++ > 0) {
            out.print(",");
        }
        Proveedor objProveedor = (Proveedor) lProveedor.get(i);
        out.println("{ \"label\" : \"" + objProveedor.getRuc() + " " + objProveedor.getRazonSocial() + "\" , \"value\" :{"
                + "\"codProveedor\" : " + objProveedor.getCodProveedor()
                + " , \"ruc\" : \"" + objProveedor.getRuc() + "\""
                + " , \"razonSocial\" : \"" + objProveedor.getRazonSocial() + "\""
                + " , \"direccion\" : \"" + objProveedor.getDireccion()+ "\""
                + "}}");
    }
    out.print("]");
%>