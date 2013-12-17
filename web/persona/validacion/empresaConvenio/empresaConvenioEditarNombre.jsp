<%-- 
    Document   : empresaConvenioEditarNombre
    Created on : 10/10/2013, 12:07:41 PM
    Author     : Henrri
--%>

<%@page import="tablas.EmpresaConvenio"%>
<%@page import="personaClases.cEmpresaConvenio"%>
<%
    try {
        int codEmpresaConvenio = Integer.parseInt(request.getParameter("codEmpresaConvenio"));
        EmpresaConvenio objEmpresaConvenio = new cEmpresaConvenio().leer_nombre(request.getParameter("nombre").toString());
        out.print(objEmpresaConvenio.getCodEmpresaConvenio().equals(codEmpresaConvenio) ? true : false);
    } catch (Exception e) {
        out.print(true);
    }
%>