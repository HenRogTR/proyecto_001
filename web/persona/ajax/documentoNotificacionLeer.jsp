<%-- 
    Document   : documentoNotificacionLeer
    Created on : 29/10/2013, 12:33:04 PM
    Author     : Henrri
--%>
<%@page import="utilitarios.cManejoFechas"%>
<%@page import="utilitarios.cOtros"%>
<%@page import="tablas.DocumentoNotificacion"%>
<%@page import="java.util.Iterator"%>
<%@page import="personaClases.cDocumentoNotificacion"%>
<%@page import="java.util.List"%>

[
<%
    try {
        int codCliente = Integer.parseInt(request.getParameter("codCliente"));
        List docNotList = new cDocumentoNotificacion().leer_codCliente(codCliente);
        if (docNotList != null) {
            int cont = 0;
            for (Iterator it = docNotList.iterator(); it.hasNext();) {
                if (cont++ > 0) {
                    out.print(",");
                }
                cOtros objcOtros = new cOtros();
                cManejoFechas objcManejoFechas = new cManejoFechas();
                DocumentoNotificacion objDocumentoNotificacion = (DocumentoNotificacion) it.next();
                out.print("{"
                        + "\"codDocumentoNotificacion\":" + objDocumentoNotificacion.getCodDocumentoNotificacion()
                        + ",\"fech1\":\"" + objcManejoFechas.DateAString(objDocumentoNotificacion.getFech1()) + "\""
                        + ",\"fech2\":\"" + objcManejoFechas.DateAString(objDocumentoNotificacion.getFech2()) + "\""
                        + ",\"fech3\":\"" + objcManejoFechas.DateAString(objDocumentoNotificacion.getFech3()) + "\""
                        + ",\"varchar1\":\"" + objcOtros.replace_comillas_comillasD_barraInvertida(objDocumentoNotificacion.getVarchar1()) + "\""
                        + ",\"varchar2\":\"" + objcOtros.replace_comillas_comillasD_barraInvertida(objDocumentoNotificacion.getVarchar2()) + "\""
                        + ",\"text1\":\"" + objcOtros.replace_comillas_comillasD_barraInvertida(objDocumentoNotificacion.getText1()) + "\""
                        + ",\"text2\":\"" + objcOtros.replace_comillas_comillasD_barraInvertida(objDocumentoNotificacion.getText2()) + "\""
                        + ",\"text3\":\"" + objcOtros.replace_comillas_comillasD_barraInvertida(objDocumentoNotificacion.getText3()) + "\""
                        + ",\"registro\":\"" + objDocumentoNotificacion.getRegistro() + "\""
                        + "}");
            }
        }
    } catch (Exception e) {

    }
%>
]
