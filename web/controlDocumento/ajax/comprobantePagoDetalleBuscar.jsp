<%-- 
    Document   : comprobantePagoDetalleBuscar
    Created on : 04/10/2013, 11:44:42 AM
    Author     : Henrri
--%>

<%@page import="tablas.ComprobantePagoDetalle"%>
<%@page import="java.util.Iterator"%>
<%@page import="otrasTablasClases.cComprobantePagoDetalle"%>
<%@page import="java.util.List"%>
<%
    String docSerieNumero = "";
    ComprobantePagoDetalle objCPDDisponible = null;
    cComprobantePagoDetalle objcComprobantePagoDetalle = new cComprobantePagoDetalle();
    try {
        docSerieNumero = request.getParameter("docSerieNumero").toString();
        objCPDDisponible = objcComprobantePagoDetalle.leer_docSerieNumero(docSerieNumero);
        if (objCPDDisponible == null) {
            out.print("[]");
            return;
        }
    } catch (Exception e) {
        out.print("[]");
        return;
    }
    //antes y despues
    List anteriorList = objcComprobantePagoDetalle.leer_anterior(objCPDDisponible.getComprobantePago().getCodComprobantePago(), objCPDDisponible.getCodComprobantePagoDetalle(), 100);
    List siguienteList = objcComprobantePagoDetalle.leer_siguiente(objCPDDisponible.getComprobantePago().getCodComprobantePago(), objCPDDisponible.getCodComprobantePagoDetalle(), 100);
    //antes
    out.print("[");
    int contAnt = 0;
    if (anteriorList != null) {
        for (int i = anteriorList.size() - 1; i >= 0; i--) {
            if (contAnt++ > 0) {
                out.print(",");
            }
            ComprobantePagoDetalle objAnterior = (ComprobantePagoDetalle) anteriorList.get(i);
            out.print("{"
                    + "\"codComprobantePagoDetalle\":" + objAnterior.getCodComprobantePagoDetalle()
                    + ",\"docSerieNumero\":\"" + objAnterior.getDocSerieNumero() + "\""
                    + ",\"estado\":" + objAnterior.getEstado()
                    + ",\"tipo\":\"" + objAnterior.getComprobantePago().getTipo() + "\""
                    + ",\"serie\":\"" + objAnterior.getComprobantePago().getSerie() + "\""
                    + ",\"numero\":\"" + objAnterior.getNumero() + "\""
                    + "}");
        }
    }
    //actual
    if (contAnt > 0) {
        out.print(",");
    }
    out.print("{"
            + "\"codComprobantePagoDetalle\":" + objCPDDisponible.getCodComprobantePagoDetalle()
            + ",\"docSerieNumero\":\"" + objCPDDisponible.getDocSerieNumero() + "\""
            + ",\"estado\":" + objCPDDisponible.getEstado()
            + ",\"tipo\":\"" + objCPDDisponible.getComprobantePago().getTipo() + "\""
            + ",\"serie\":\"" + objCPDDisponible.getComprobantePago().getSerie() + "\""
            + ",\"numero\":\"" + objCPDDisponible.getNumero() + "\""
            + "}");
    //siguiente
    if (siguienteList != null) {
        for (Iterator it = siguienteList.iterator(); it.hasNext();) {
            ComprobantePagoDetalle objSiguiente = (ComprobantePagoDetalle) it.next();
            out.print(",{"
                    + "\"codComprobantePagoDetalle\":" + objSiguiente.getCodComprobantePagoDetalle()
                    + ",\"docSerieNumero\":\"" + objSiguiente.getDocSerieNumero() + "\""
                    + ",\"estado\":" + objSiguiente.getEstado()
                    + ",\"tipo\":\"" + objSiguiente.getComprobantePago().getTipo() + "\""
                    + ",\"serie\":\"" + objSiguiente.getComprobantePago().getSerie() + "\""
                    + ",\"numero\":\"" + objSiguiente.getNumero() + "\""
                    + "}");
        }
    }
    out.print("]");
%>