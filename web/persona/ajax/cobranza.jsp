<%-- 
    Document   : cobranza
    Created on : 04/06/2013, 12:18:14 PM
    Author     : Henrri
--%>


<%@page import="otros.cUtilitarios"%>
<%@page import="otros.cManejoFechas"%>
<%@page import="tablas.Cobranza"%>
<%@page import="java.util.Iterator"%>
<%@page import="java.util.ArrayList"%>
<%@page import="java.util.List"%>
<%@page import="cobranzaClases.cCobranza"%>
<%
    boolean estado = true;
    String mensaje = "";
    int codPersona = 0;
    List lCobranza = new ArrayList();
    cCobranza objcCobranza = new cCobranza();
    try {
        codPersona = Integer.parseInt(request.getParameter("codPersona"));
        lCobranza = objcCobranza.leer_codPersona(codPersona);
    } catch (Exception e) {
        out.print("[{");
        out.print("\"error\":\"Error en codigo de cliente\"");
        out.print("}]");
        return;
    }
    Iterator iCobranza=lCobranza.iterator();
    int cont=0;
    out.print("[");
    while(iCobranza.hasNext()){
        Cobranza objCobranza=(Cobranza)iCobranza.next();
        if(cont++>0){
            out.print(",");
        }
        out.print("{"
                +"\"codCobranza\":"+objCobranza.getCodCobranza()
                +",\"fechaCobranza\":\""+new cManejoFechas().fechaDateToString(objCobranza.getFechaCobranza())+"\""
                +",\"docSerieNumero\":\""+objCobranza.getDocSerieNumero()+"\""
                +",\"importe\":\""+new cUtilitarios().agregarCerosNumeroFormato(objCobranza.getImporte(), 2)+"\""
                +",\"saldo\":\""+new cUtilitarios().agregarCerosNumeroFormato(objCobranza.getSaldo(), 2)+"\""
                +",\"observacion\":\""+new cUtilitarios().replace_comillas_comillasD_barraInvertida(objCobranza.getObservacion())+"\""
                + "}");
    }
    out.print("]");
%>