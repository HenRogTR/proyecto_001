<%-- 
    Document   : usuarioRegistrarUsuario
    Created on : 27/09/2013, 10:46:29 AM
    Author     : Henrri
--%>

<%@page import="personaClases.cUsuario"%>
<%@page import="tablas.Usuario"%>
<%

    Boolean estado = false;
    try {
        String usuarioString = request.getParameter("usuarioNuevo").toString();
        Usuario objUsuario = new cUsuario().leer_usuario(usuarioString);
        estado = objUsuario == null ? true : false;
    } catch (Exception e) {
        estado = false;
    }
    out.print(estado);
%>
