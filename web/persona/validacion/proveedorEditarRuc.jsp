<%-- 
    Document   : proveedorEditarRuc
    Created on : 17/08/2013, 12:26:14 PM
    Author     : Henrri
--%>

<%@page import="java.util.List"%>
<%@page import="personaClases.cProveedor"%>
<%@page import="tablas.Proveedor"%>
<%
    //variables
    String ruc = request.getParameter("ruc").trim();
    boolean est = true;
    //clases
    cProveedor objcProveedor = new cProveedor();
    try {
        int codProveedor = (Integer) session.getAttribute("codProveedorEditar");
        est = objcProveedor.verificarRuc(codProveedor, ruc);
    } catch (Exception e) {
        out.print("error");
        est = true;
    }
    out.print(est);
%>
