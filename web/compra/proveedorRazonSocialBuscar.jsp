<%-- 
    Document   : proveedorRazonSocialBuscar
    Created on : 13/12/2012, 04:15:29 PM
    Author     : Henrri
--%>

<%@page import="otros.cUtilitarios"%>
<%@page import="tablas.Proveedor"%>
<%@page import="java.util.List"%>
<%@page import="personaClases.cProveedor"%>
<%
    String criterio = request.getParameter("term");
    cProveedor objcProveedor = new cProveedor();
    cUtilitarios objcUtilitarios = new cUtilitarios();
    if (criterio == null) {
        return;
    }
%>
[<%

    List lProveedor = objcProveedor.leer();
    int contador = 0;
    for (int i = 0; i < lProveedor.size(); i++) {
        Proveedor objProveedor = (Proveedor) lProveedor.get(i);
        if (objProveedor.getRazonSocial().toLowerCase().indexOf(criterio.toLowerCase()) != -1) {
            if (contador++ > 0) {
                out.println(",");
            }
            int codProveedor = objProveedor.getCodProveedor();
            String ruc = objProveedor.getRuc();
            String razonSocial = objcUtilitarios.replace_comillas_comillasD_barraInvertida(objProveedor.getRazonSocial());
            String direccion = objcUtilitarios.replace_comillas_comillasD_barraInvertida(objProveedor.getDireccion());
            out.println("{ \"label\" : \"" + razonSocial + " " + ruc + "\", \"value\" : { \"codProveedor\" : " + codProveedor + ", \"ruc\" : \"" + ruc + "\", \"razonSocial\" : \"" + razonSocial + "\", \"direccion\" : \"" + direccion + "\" } }");
        }
    }
%>]