<%-- 
    Document   : buscarRuc
    Created on : 12/11/2012, 06:22:21 AM
    Author     : Henrri
--%>
<%@page import="tablas.Proveedor"%>
<%@page import="java.util.Iterator"%>
<%@page import="personaClases.cProveedor"%>
<%@page import="java.util.List"%>
<%
    String criterio = request.getParameter("term");
    cProveedor objcProveedor = new cProveedor();
    if (criterio == null) {
        return;
    }
%>
[<%

    List lProveedor = objcProveedor.leer();
    int contador = 0;
    for (int i = 0; i < lProveedor.size(); i++) {
        Proveedor objProveedor = (Proveedor) lProveedor.get(i);
        if (objProveedor.getRuc().toLowerCase().indexOf(criterio) != -1) {
            if (contador++ > 0) {
                out.println(",");
            }            
            int codProveedor = objProveedor.getCodProveedor();
            String ruc = objProveedor.getRuc();
            String razonSocial = objProveedor.getRazonSocial();
            String direccion = objProveedor.getDireccion();
            out.println("{ \"label\" : \"" + ruc +" "+ razonSocial+"\", \"value\" : { \"codProveedor\" : " + codProveedor + ", \"ruc\" : \"" + ruc + "\", \"razonSocial\" : \"" + razonSocial + "\", \"direccion\" : \"" + direccion + "\" } }");
        }
    }
%>]
