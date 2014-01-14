<%-- 
    Document   : cobranzaResumen
    Created on : 05/10/2013, 12:29:46 PM
    Author     : Henrri
--%><%@page import="tablas.DatosCliente"%>
<%@page import="utilitarios.cManejoFechas"%>
<%@page import="utilitarios.cOtros"%>
<%@page import="tablas.Cobranza"%>
<%@page import="java.util.Iterator"%>
<%@page import="personaClases.cDatosCliente"%>
<%@page import="personaClases.cPersona"%>
<%@page import="cobranzaClases.cCobranza"%>
<%@page import="java.util.List"%>


[
<%
    List l = new cCobranza().leer_codPersona_SC(1);    
    List lCobranza = new cCobranza().leer_codPersona(new cDatosCliente().leer_cod(Integer.parseInt(request.getParameter("codCliente"))).getPersona().getCodPersona());
    if (lCobranza != null) {
        cOtros objcOtros = new cOtros();
        int cont = 0;
        for (Iterator it = lCobranza.iterator(); it.hasNext();) {
            Cobranza objCobranza = (Cobranza) it.next();
            if (cont++ > 0) {
                out.print(",");
            }
            out.print("{"
                    + "\"codCobranza\":" + objCobranza.getCodCobranza()
                    + ",\"fechaCobranza\":\"" + new cManejoFechas().DateAString(objCobranza.getFechaCobranza()) + "\""
                    + ",\"docSerieNumero\":\"" + objCobranza.getDocSerieNumero() + "\""
                    + ",\"importe\":\"" + objcOtros.agregarCerosNumeroFormato(objCobranza.getImporte(), 2) + "\""
                    + ",\"saldo\":\"" + objcOtros.agregarCerosNumeroFormato(objCobranza.getSaldo(), 2) + "\""
                    + ",\"observacion\":\"" + objcOtros.replace_comillas_comillasD_barraInvertida(objCobranza.getObservacion()) + "\""
                    + "}");
        }
    }
%>
]