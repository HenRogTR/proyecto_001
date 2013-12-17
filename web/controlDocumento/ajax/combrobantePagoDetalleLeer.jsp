<%-- 
    Document   : combrobantePagoDetalleLeer
    Created on : 02/10/2013, 07:45:22 PM
    Author     : Henrri
--%>

<%@page import="tablas.ComprobantePagoDetalle"%>
<%@page import="java.util.Iterator"%>
<%@page import="otrasTablasClases.cComprobantePagoDetalle"%>
<%@page import="java.util.List"%>
<%
    int codComprobantePago = 0;
    ComprobantePagoDetalle objCPDDisponible = null;
    cComprobantePagoDetalle objcComprobantePagoDetalle = new cComprobantePagoDetalle();
    try {
        codComprobantePago = Integer.parseInt(request.getParameter("codComprobantePago"));
        objCPDDisponible = objcComprobantePagoDetalle.leer_disponible(codComprobantePago);
        if (objCPDDisponible == null) {
            out.print("[]");
            return;
        }
    } catch (Exception e) {
        out.print("[]");
        return;
    }
    //antes y despues
    List anteriorList = objcComprobantePagoDetalle.leer_anterior(codComprobantePago, objCPDDisponible.getCodComprobantePagoDetalle(), 100);
    List siguienteList = objcComprobantePagoDetalle.leer_siguiente(codComprobantePago, objCPDDisponible.getCodComprobantePagoDetalle(), 100);
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