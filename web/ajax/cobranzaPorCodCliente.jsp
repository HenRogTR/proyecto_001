<%-- 
    Document   : cobranzaPorCodCliente
    Created on : 14/06/2014, 10:24:18 AM
    Author     : Henrri
--%>

<%@page import="java.util.Date"%>
<%@page import="tablas.Usuario"%>
<%@page import="Clase.Utilitarios"%>
<%@page import="Clase.Fecha"%>
<%@page import="tablas.Cobranza"%>
<%@page import="java.util.List"%>
<%@page import="Ejb.EjbCobranza"%>
<%
    //evitar el acceso directo por el URL
    if (request.getMethod().equals("GET")) {
        out.print("No tiene permisos para ver este enlace.");
        return;
    }
    // ============================ sesión =====================================
    //verficar inicio de sesión        
    Usuario objUsuario = (Usuario) session.getAttribute("usuario");
    if (objUsuario == null) {
        out.print("La sesión se ha cerrado.");
        return;
    }
    //actualizamos ultimo ingreso
    session.setAttribute("fechaAcceso", new Date());
    // ============================ sesión =====================================
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
                + "\"codCobranza\":\"" + new Utilitarios().agregarCerosIzquierda(objCobranza.getCodCobranza(), 8) + "\""
                + ", \"fechaCobranza\":\"" + new Fecha().dateAString(objCobranza.getFechaCobranza()) + "\""
                + ", \"docSerieNumero\":\"" + objCobranza.getDocSerieNumero() + "\""
                + ", \"saldoAnterior\":\"" + new Utilitarios().decimalFormato(objCobranza.getSaldoAnterior(), 2) + "\""
                + ", \"importe\":\"" + new Utilitarios().decimalFormato(objCobranza.getImporte(), 2) + "\""
                + ", \"saldo\":\"" + new Utilitarios().decimalFormato(objCobranza.getSaldo(), 2) + "\""
                + ", \"montoPagado\":\"" + new Utilitarios().decimalFormato(objCobranza.getMontoPagado(), 2) + "\""
                + ", \"observacion\":\"" + new Utilitarios().reemplazarCaracteresEspeciales(objCobranza.getObservacion()) + "\""
                + ", \"registro\":\"" + new Utilitarios().reemplazarCaracteresEspeciales(objCobranza.getRegistro()) + "\""
                + "}");
    }
    out.print("]");
%>