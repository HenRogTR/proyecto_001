<%-- 
    Document   : ventasVerificarDocSerieNumero
    Created on : 16/05/2013, 06:19:44 PM
    Author     : Henrri
--%>

<%@page import="ventaClases.cVenta"%>
<%@page import="tablas.Ventas"%>
<%
    String docSerieNumero = request.getParameter("docSerieNumero");
    if (docSerieNumero == null) {
        return;
    }
    boolean est = true;
    cVenta objcVentas = new cVenta();
    Ventas objVentas = objcVentas.leer_docSerieNumero(docSerieNumero);
    if (objVentas != null) {
        est = false;
    }
    out.print(est);
%>
