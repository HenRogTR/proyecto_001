<%-- 
    Document   : datoClienteNombresC
    Created on : 28/05/2013, 11:12:53 PM
    Author     : Henrri******
--%>

<%@page import="utilitarios.cOtros"%>
<%@page import="tablas.DatosCliente"%>
<%@page import="java.util.Iterator"%>
<%@page import="personaClases.cDatosCliente"%>
<%@page import="java.util.ArrayList"%>
<%@page import="java.util.List"%>
<%
    String nombresC = "";
    List lDatoCliente = null;
    try {
        nombresC = request.getParameter("term").toString().trim();
        lDatoCliente = new cDatosCliente().leer_nombresC_autocompletado_ordenadoNombresCAsc(nombresC);
        if (lDatoCliente == null) {
            out.print("[]");
            return;
        }
    } catch (Exception e) {
        out.print("[]");
        return;
    }
    cOtros objcOtros = new cOtros();
    Iterator iDatoCliente = lDatoCliente.iterator();
    int contador = 0;
    out.print("[");
    while (iDatoCliente.hasNext()) {
        DatosCliente objDatoCliente = (DatosCliente) iDatoCliente.next();
        if (contador++ > 0) {
            out.print(",");
        }
        out.print("{ "
                + "\"label\":\"" + objcOtros.replace_comillas_comillasD_barraInvertida(objDatoCliente.getPersona().getNombresC()) + " " + objDatoCliente.getPersona().getDniPasaporte() + " " + objDatoCliente.getPersona().getRuc() + "\""
                + ",\"value\":{"
                + "\"codDatoCliente\":\"" + objcOtros.agregarCeros_int(objDatoCliente.getCodDatosCliente(), 8) + "\""
                + ",\"codPersona\":\"" + objcOtros.agregarCeros_int(objDatoCliente.getPersona().getCodPersona(), 8) + "\""
                + ",\"nombresC\":\"" + objcOtros.replace_comillas_comillasD_barraInvertida(objDatoCliente.getPersona().getNombresC()) + "\""
                + ",\"dniPasaporte\":\"" + objDatoCliente.getPersona().getDniPasaporte() + "\""
                + ",\"ruc\":\"" + objDatoCliente.getPersona().getRuc() + "\""
                + " }}");
    }
    out.print("]");

%>