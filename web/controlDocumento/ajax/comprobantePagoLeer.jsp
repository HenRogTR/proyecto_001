<%-- 
    Document   : serieCobranzaLeer
    Created on : 02/10/2013, 06:42:19 PM
    Author     : Henrri
--%>

<%@page import="tablas.ComprobantePago"%>
<%@page import="java.util.Iterator"%>
<%@page import="otrasTablasClases.cComprobantePago"%>
<%@page import="java.util.List"%>
<%@page import="personaClases.cEmpresaConvenio"%>
<%@page import="tablas.EmpresaConvenio"%>
<%
    String codCobranza = "";
    try {
        codCobranza = request.getParameter("codCobranza").toString();
    } catch (Exception e) {
        out.print("[]");
        return;
    }
    List serieNumeroList = new cComprobantePago().leer_serieGenerada(codCobranza);
    int cont = 0;
    out.print("[");
    if (serieNumeroList != null) {
        for (Iterator it = serieNumeroList.iterator(); it.hasNext();) {
            ComprobantePago objComprobantePago = (ComprobantePago) it.next();
            if (cont++ > 0) {
                out.print(",");
            }
            out.print("{"
                    + "\"codComprobantePago\":" + objComprobantePago.getCodComprobantePago()
                    + ",\"serie\":\"" + objComprobantePago.getSerie() + "\""
                    + "}");
        }
    }
    out.print("]");
%>