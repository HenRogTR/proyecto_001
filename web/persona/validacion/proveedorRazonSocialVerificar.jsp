<%-- 
    Document   : proveedorRazonSocialVerificar
    Created on : 26/01/2013, 12:46:51 AM
    Author     : Henrri
--%>
<%@page import="tablas.Proveedor"%>
<%@page import="personaClases.cProveedor"%>
<%
    String razonSocial = request.getParameter("razonSocial").trim();
    boolean est = true;
    cProveedor objcProveedor = new cProveedor();
    Proveedor objProveedor = objcProveedor.leer_razonSocial(razonSocial);
    if (objProveedor != null) {
        est = false;//no pasa verficacion pq ya hay uno igual regsitrado
    }
    out.print(est);
%>