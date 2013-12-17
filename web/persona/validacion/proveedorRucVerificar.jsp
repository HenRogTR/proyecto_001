<%-- 
    Document   : proveedorVerificar
    Created on : 09/11/2012, 12:05:53 PM
    Author     : Henrri
--%>
<%@page import="tablas.Proveedor"%>
<%@page import="personaClases.cProveedor"%>
<%
    String ruc = request.getParameter("ruc").trim();
    boolean est = true;
    cProveedor objcProveedor = new cProveedor();
    Proveedor objProveedor = objcProveedor.leer_ruc(ruc);
    if (objProveedor != null) {
        est = false;//no pasa verficacion pq ya hay uno igual regsitrado
    }
    out.print(est);
%>