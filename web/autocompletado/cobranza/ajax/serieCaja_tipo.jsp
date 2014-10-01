<%-- 
    Document   : serieCaja_tipo
    Created on : 17/04/2014, 10:17:17 AM
    Author     : Henrri
--%>

<%@page import="tablas.ComprobantePago"%>
<%@page import="java.util.Iterator"%>
<%@page import="otrasTablasClases.cComprobantePago"%>
<%@page import="java.util.List"%>
[
<%
    try {
        String tipoRecCaja = request.getParameter("tipo").toString();
        List comPagoList = new cComprobantePago().leer_serieGenerada(tipoRecCaja);
        int cont = 0;
        for (Iterator it = comPagoList.iterator(); it.hasNext();) {
            ComprobantePago objComprobantePago = (ComprobantePago) it.next();
            if (cont++ > 0) {
                out.print(",");
            }
            out.print("{\"serie\":\"" + objComprobantePago.getSerie() + "\"}");
        }
    } catch (Exception e) {
    }

%>                                                  
]