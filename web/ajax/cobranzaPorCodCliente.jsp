<%-- 
    Document   : cobranzaPorCodCliente
    Created on : 14/06/2014, 10:24:18 AM
    Author     : Henrri
--%>

<%@page import="clases.cFecha"%>
<%@page import="clases.cUtilitarios"%>
<%@page import="tablas.Cobranza"%>
<%@page import="java.util.List"%>
<%@page import="Ejb.EjbCobranza"%>
<%
    //evitar el acceso directo por el URL
    if (request.getMethod().equals("GET")) {
        out.print("No tiene permisos para ver este enlace.");
        return;
    }
    //siempre se tendrá un dato válido para codigoCliente
    String codClienteString = request.getParameter("codCliente");
    //En caso de que el parametro codCliente no se haya enviado
    if (codClienteString == null) {
        out.print("[Parámetro codCliente no encontrado.]");
        return;
    }
    int codCliente = Integer.parseInt(codClienteString);
    //iniciando interface
    EjbCobranza ejbCobranza = new EjbCobranza();
    //obtener lista
    List<Cobranza> cobranzaList = ejbCobranza.leerActivoPorCodigoCliente(codCliente, true);
    //obtener tamaño
    int tam = cobranzaList.size();
    out.print("[");
    //recorrer datos
    for (int i = 0; i < tam; i++) {
        Cobranza objCobranza = cobranzaList.get(i);
        //imprimri <,> separadora
        if (i > 0) {
            out.print(",");
        }
        out.print("{"
                + "\"codCobranza\":\"" + cUtilitarios.agregarCerosIzquierda(objCobranza.getCodCobranza(), 8) + "\""
                + ", \"fechaCobranza\":\"" + cFecha.dateAString(objCobranza.getFechaCobranza()) + "\""
                + ", \"docSerieNumero\":\"" + objCobranza.getDocSerieNumero() + "\""
                + ", \"saldoAnterior\":\"" + cUtilitarios.decimalFormato(objCobranza.getSaldoAnterior(), 2) + "\""
                + ", \"importe\":\"" + cUtilitarios.decimalFormato(objCobranza.getImporte(), 2) + "\""
                + ", \"saldo\":\"" + cUtilitarios.decimalFormato(objCobranza.getSaldo(), 2) + "\""
                + ", \"montoPagado\":\"" + cUtilitarios.decimalFormato(objCobranza.getMontoPagado(), 2) + "\""
                + ", \"observacion\":\"" + cUtilitarios.reemplazarCaracteresEspeciales(objCobranza.getObservacion()) + "\""
                + ", \"registro\":\"" + cUtilitarios.reemplazarCaracteresEspeciales(objCobranza.getRegistro()) + "\""
                + "}");
    }
    out.print("]");
%>