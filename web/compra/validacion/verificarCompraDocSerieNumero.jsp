<%-- 
    Document   : verificarCompraDocSerieNumero
    Created on : 28/01/2013, 10:17:48 PM
    Author     : Henrri
--%>
<%@page import="tablas.Compra"%>
<%@page import="compraClases.cCompra"%>
<%
    String docSerieNumero = request.getParameter("docSerieNumero");
    boolean est = true;
    cCompra objcCompra = new cCompra();
    Compra objCompra = objcCompra.leer_docSerieNumero(docSerieNumero);
    if (objCompra != null) {
        est = false;//no pasa verficacion pq ya hay uno igual regsitrado
    }    
    out.print(est);
%>