<%-- 
    Document   : serieGenerada
    Created on : 01/10/2013, 10:27:35 AM
    Author     : Henrri
--%>

<%@page import="utilitarios.cOtros"%>
<%@page import="tablas.ComprobantePago"%>
<%@page import="java.util.Iterator"%>
<%@page import="otrasTablasClases.cComprobantePago"%>
<%@page import="java.util.List"%>
<%
    String codCobranza = "";
    try {
        codCobranza = request.getParameter("codCobranza");
    } catch (Exception e) {
        out.print("[]");
        return;
    }
    cComprobantePago objcComprobantePago = new cComprobantePago();
    List lSerieGenerada = objcComprobantePago.leer_serieGenerada(codCobranza);

    int cont = 0;
    out.print("[");
    if (lSerieGenerada != null) {
        for (Iterator it = lSerieGenerada.iterator(); it.hasNext();) {
            ComprobantePago objComprobantePago = (ComprobantePago) it.next();
            if (cont++ > 0) {
                out.print(",");
            }
            out.print("{"
                    + "\"codComprobantePago\":" + objComprobantePago.getCodComprobantePago()
                    + ",\"codCobranza\":\"" + codCobranza + "\""
                    + ",\"serie\":\"" + objComprobantePago.getSerie() + "\""
                    + ",\"ultimoGenerado\":\"" + objComprobantePago.getTipo() + "-" + objComprobantePago.getSerie() + "-XXXXXX" + "\""
                    + ",\"ultimoUsado\":\"" + objComprobantePago.getTipo() + "-" + objComprobantePago.getSerie() + "-XXXXXX" + "\""
                    + "}");
        }
    }
    out.print("]");
%>