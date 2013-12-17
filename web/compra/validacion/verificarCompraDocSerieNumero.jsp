<%-- 
    Document   : verificarCompraDocSerieNumero
    Created on : 28/01/2013, 10:17:48 PM
    Author     : Henrri
--%>
<%@page import="tablas.Compra"%>
<%@page import="compraClases.cCompra"%>
<%
    String docSerieNumero = request.getParameter("docSerieNumero");
    String accion = session.getAttribute("accionCompra").toString();
    boolean est = true;
    cCompra objcCompra = new cCompra();
    Compra objCompra = objcCompra.leer_docSerieNumero(docSerieNumero);
    if (objCompra != null) {
        est = false;//no pasa verficacion pq ya hay uno igual regsitrado
    }
    if (accion.equals("a") && objCompra != null) {
        est = true;//pasa la verficiacaion pq se esta editando y no importa si hay o no un dato igual
    }
    out.print(est);
%>