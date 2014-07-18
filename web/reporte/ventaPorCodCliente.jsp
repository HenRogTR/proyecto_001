<%-- 
    Document   : ventaPorCodCliente
    Created on : 04/07/2014, 05:38:24 PM
    Author     : Henrri
--%>

<%@page import="tablas.Usuario"%>
<%
    //validar que haya session
    Usuario objUsuario = (Usuario) session.getAttribute("usuario");
    if (objUsuario == null) {
        out.print("Sesión no iniciada o caducada.");
        return;
    }
    //verificar permisos
    //
    String codClienteString = request.getParameter("codCliente");
%>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <title>JSP Page</title>
    </head>
    <body>
        <h1>Hello World!</h1>
    </body>
</html>
