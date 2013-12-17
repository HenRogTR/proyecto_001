<%-- 
    Document   : AutocompletarProveedorRucRazonSocialBuscar
    Created on : 28/01/2013, 09:52:39 AM
    Author     : Henrri
--%>
<%@page import="otros.cUtilitarios"%>
<%@page import="tablas.Proveedor"%>
<%@page import="java.util.List"%>
<%@page import="personaClases.cProveedor"%>
<%
    String criterio = request.getParameter("term");
    if (criterio == null) {
        return;
    }
    cProveedor objcProveedor = new cProveedor();
    cUtilitarios objcUtilitarios = new cUtilitarios();
    List lProveedor = objcProveedor.leerRucRazonSocial(criterio);
    int cont = 0;
    out.print("[");
    for (int i = 0; i < lProveedor.size(); i++) {
        if (cont++ > 0) {
            out.print(",");
        }
        Proveedor objProveedor = (Proveedor) lProveedor.get(i);
        out.print(" { ");
        out.print("\"label\" : \"" + objProveedor.getRuc() + " " + objcUtilitarios.replace_comillas_comillasD_barraInvertida(objProveedor.getRazonSocial()) + "\"");
        out.print(" , \"value\" : { ");
////        out.print("\"\":\""++"\",");
        out.print("\"codProveedor\" :" + objProveedor.getCodProveedor() + "");
        out.print(",\"ruc\" : \"" + objProveedor.getRuc() + "\"");
        out.print(", \"razonSocial\" : \"" + objcUtilitarios.replace_comillas_comillasD_barraInvertida(objProveedor.getRazonSocial()) + "\"");
        out.print(", \"direccion\" : \"" + objcUtilitarios.replace_comillas_comillasD_barraInvertida(objProveedor.getDireccion()) + "\"");
        out.print(", \"telefono\" : \"" + objProveedor.getTelefono() + "\"");
        out.print(", \"email\" : \"" + objProveedor.getEmail() + "\"");
        out.print(", \"paginaWeb\" : \"" + objProveedor.getPaginaWeb() + "\"");
        out.print(", \"observaciones\" : \"" + objcUtilitarios.replace_comillas_comillasD_barraInvertida(objProveedor.getObservaciones()) + "\"");
        out.print(", \"logo\" : \"" + objProveedor.getLogo() + "\"");
        out.print(" } ");
        out.print(" } ");
    }
    out.print("]");
%>