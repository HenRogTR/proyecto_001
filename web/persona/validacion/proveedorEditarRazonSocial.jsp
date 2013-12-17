<%-- 
    Document   : proveedorEditarRazonSocial
    Created on : 19/08/2013, 12:30:04 PM
    Author     : Henrri
--%>

<%@page import="java.util.List"%>
<%@page import="personaClases.cProveedor"%>
<%@page import="tablas.Proveedor"%>
<%
    //variables
    String razonSocial = request.getParameter("razonSocial").trim();
    boolean est = true;
    //clases
    cProveedor objcProveedor = new cProveedor();
    try {
        int codProveedor = (Integer) session.getAttribute("codProveedorEditar");
        est = objcProveedor.verificarRazonSocial(codProveedor, razonSocial);
    } catch (Exception e) {
        out.print("error");
        est = true;
    }
    out.print(est);
%>
