<%-- 
    Document   : articuloProducto
    Created on : 02/07/2014, 07:16:39 PM
    Author     : Henrri
--%>

<%@page import="tablas.Usuario"%>
<%
    //evitar el acceso directo por el URL
    if (request.getMethod().equals("GET")) {
        out.print("No tiene permisos para ver este enlace.");
        return;
    }
    //si no se ha iniciado session
    Usuario objUsuario = (Usuario) session.getAttribute("usuario");
    if (objUsuario == null) {
        out.print("Sesión no iniciada.");
        return;
    }
//    EjbArticuloProducto ejbArticuloProducto;
%>