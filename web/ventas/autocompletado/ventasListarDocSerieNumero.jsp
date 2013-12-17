<%-- 
    Document   : ventasListarDocSerieNumero
    Created on : 15/05/2013, 05:38:51 PM
    Author     : Henrri
--%>
<%@page import="java.util.Iterator"%>
<%@page import="java.util.List"%>
<%@page import="ventaClases.cVenta"%>
<%@page import="tablas.Ventas"%>
<%
    String docSerieNumero = request.getParameter("term");
    if (docSerieNumero == null) {
        return;
    }
    cVenta objcVentas = new cVenta();
    List lVentas = objcVentas.leer_docNumeroSerie_like(docSerieNumero);
    Iterator iVentas = lVentas.iterator();
    int cont = 0;
    out.print("[ ");
    while (iVentas.hasNext()) {
        Ventas objVentas = (Ventas) iVentas.next();
        if (cont++ > 0) {
            out.print(" , ");
        }
        out.print("{ "
                + " \"label\" : \"" + objVentas.getDocSerieNumero() + "\""
                + ",\"value\" : { "
                + "\"codVenta\" :" + objVentas.getCodVentas()
                + ",\"docSerieNumero\" : \"" + objVentas.getDocSerieNumero() + "\""
                + " }"
                + " }");
    }
    out.print(" ]");
%>