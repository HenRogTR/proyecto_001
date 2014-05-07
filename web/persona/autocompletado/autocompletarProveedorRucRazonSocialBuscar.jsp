<%-- 
    Document   : AutocompletarProveedorRucRazonSocialBuscar
    Created on : 28/01/2013, 09:52:39 AM
    Author     : Henrri
--%>
<%@page import="utilitarios.cOtros"%>
<%@page import="tablas.Proveedor"%>
<%@page import="java.util.List"%>
<%@page import="personaClases.cProveedor"%>
<%
    String criterio = request.getParameter("term");
    if (criterio == null) {
        return;
    }
    cProveedor objcProveedor = new cProveedor();
    List lProveedor = objcProveedor.leerRucRazonSocial(criterio);
    int cont = 0;
    out.print("[");
    for (int i = 0; i < lProveedor.size(); i++) {
        if (cont++ > 0) {
            out.print(",");
        }
        Proveedor objProveedor = (Proveedor) lProveedor.get(i);
        out.print(" { ");
        out.print("\"label\" : \"" + objProveedor.getRuc() + " " + new cOtros().replace_comillas_comillasD_barraInvertida(objProveedor.getRazonSocial()) + "\"");
        out.print(" , \"value\" : { ");
////        out.print("\"\":\""++"\",");
        out.print("\"codProveedor\" :" + objProveedor.getCodProveedor() + "");
        out.print(",\"ruc\" : \"" + objProveedor.getRuc() + "\"");
        out.print(", \"razonSocial\" : \"" + new cOtros().replace_comillas_comillasD_barraInvertida(objProveedor.getRazonSocial()) + "\"");
        out.print(", \"direccion\" : \"" + new cOtros().replace_comillas_comillasD_barraInvertida(objProveedor.getDireccion()) + "\"");
        out.print(", \"telefono\" : \"" + objProveedor.getTelefono() + "\"");
        out.print(", \"email\" : \"" + objProveedor.getEmail() + "\"");
        out.print(", \"paginaWeb\" : \"" + objProveedor.getPaginaWeb() + "\"");
        out.print(", \"observaciones\" : \"" + new cOtros().replace_comillas_comillasD_barraInvertida(objProveedor.getObservaciones()) + "\"");
        out.print(", \"logo\" : \"" + objProveedor.getLogo() + "\"");
        out.print(" } ");
        out.print(" } ");
    }
    out.print("]");
%>