<%-- 
    Document   : comprobantePagoDetalleUltimo
    Created on : 04/10/2013, 12:46:07 PM
    Author     : Henrri
--%>

<%@page import="otrasTablasClases.cComprobantePagoDetalle"%>
<%@page import="tablas.ComprobantePagoDetalle"%>
<%
    int codComprobantePago = 0;
    try {
        codComprobantePago = Integer.parseInt(request.getParameter("codComprobantePago"));
        ComprobantePagoDetalle objComprobantePagoDetalle = new cComprobantePagoDetalle().leer_ultimo(codComprobantePago);
        out.print("[");
        if (objComprobantePagoDetalle != null) {
            out.print("{"
                    + "\"codComprobantePagoDetalle\":" + objComprobantePagoDetalle.getCodComprobantePagoDetalle()
                    + ",\"docSerieNumero\":\"" + objComprobantePagoDetalle.getDocSerieNumero() + "\""
                    + ",\"estado\":" + objComprobantePagoDetalle.getEstado()
                    + ",\"tipo\":\"" + objComprobantePagoDetalle.getComprobantePago().getTipo() + "\""
                    + ",\"serie\":\"" + objComprobantePagoDetalle.getComprobantePago().getSerie() + "\""
                    + ",\"numero\":\"" + objComprobantePagoDetalle.getNumero() + "\""
                    + "}");
        }
        out.print("]");
    } catch (Exception e) {
        out.print("[]");
        return;
    }
%>