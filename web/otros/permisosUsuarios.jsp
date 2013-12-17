<%-- 
    Document   : permisosUsuarios
    Created on : 30/04/2013, 06:15:52 PM
    Author     : Henrri
--%>

<%@page import="tablas.Usuario"%>
<%
    Usuario objUsuario = (Usuario) session.getAttribute("usuario");
    if (objUsuario == null) {
        return;
    }
    int contador = 0;
    out.print("[");
    if (contador++ > 0) {
        out.println(",");
    }
    out.print("{");
    out.print("\"permiso1\" :" + objUsuario.getP1());
    out.print(", \"permiso2\" :" + objUsuario.getP2());
    out.print(", \"permiso3\" :" + objUsuario.getP3());
    out.print(", \"permiso4\" :" + objUsuario.getP4());
    out.print(", \"permiso5\" :" + objUsuario.getP5());
    out.print(", \"permiso6\" :" + objUsuario.getP6());
    out.print(", \"permiso7\" :" + objUsuario.getP7());
    out.print(", \"permiso8\" :" + objUsuario.getP8());
    out.print(", \"permiso9\" :" + objUsuario.getP9());
    out.print(", \"permiso10\" :" + objUsuario.getP10());
    out.print(", \"permiso11\" :" + objUsuario.getP11());
    out.print(", \"permiso12\" :" + objUsuario.getP12());
    out.print(", \"permiso13\" :" + objUsuario.getP13());
    out.print(", \"permiso14\" :" + objUsuario.getP14());
    out.print(", \"permiso15\" :" + objUsuario.getP15());
    out.print(", \"permiso16\" :" + objUsuario.getP16());
    out.print(", \"permiso17\" :" + objUsuario.getP17());
    out.print(", \"permiso18\" :" + objUsuario.getP18());
    out.print(", \"permiso19\" :" + objUsuario.getP19());
    out.print(", \"permiso20\" :" + objUsuario.getP20());
    out.print(", \"permiso21\" :" + objUsuario.getP21());
    out.print(", \"permiso22\" :" + objUsuario.getP22());
    out.print(", \"permiso23\" :" + objUsuario.getP23());
    out.print(", \"permiso24\" :" + objUsuario.getP24());
    out.print(", \"permiso25\" :" + objUsuario.getP25());
    out.print(", \"permiso26\" :" + objUsuario.getP26());
    out.print(", \"permiso27\" :" + objUsuario.getP27());
    out.print(", \"permiso28\" :" + objUsuario.getP28());
    out.print(", \"permiso29\" :" + objUsuario.getP29());
    out.print(", \"permiso30\" :" + objUsuario.getP30());
    out.print("}");
    out.print("]");
%>