<%-- 
    Document   : datoCliente
    Created on : 11/09/2013, 06:57:10 PM
    Author     : Henrri
--%>

<%@page import="tablas.DatosCliente"%>
<%@page import="java.util.Iterator"%>
<%@page import="utilitarios.cOtros"%>
<%@page import="personaClases.cDatosCliente"%>
<%@page import="java.util.ArrayList"%>
<%@page import="java.util.List"%>
<%
    String term = "";
    List lDatoCliente = null;
    try {
        term = request.getParameter("term").toString().trim();
        lDatoCliente = new cDatosCliente().leer_dniPasaporteRucNombresC_ordenado(term);
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
                + "\"label\":\"" + objDatoCliente.getPersona().getDniPasaporte() + " " + objDatoCliente.getPersona().getRuc() + " " + objcOtros.replace_comillas_comillasD_barraInvertida(objDatoCliente.getPersona().getNombresC()) + "\""
                + ",\"value\":{"
                + "\"codDatoCliente\":\"" + objcOtros.agregarCeros_int(objDatoCliente.getCodDatosCliente(), 8) + "\""
                + ",\"nombresC\":\"" + objcOtros.replace_comillas_comillasD_barraInvertida(objDatoCliente.getPersona().getNombresC()) + "\""
                + ",\"codPersona\" : " + objDatoCliente.getPersona().getCodPersona() + " "
                + ",\"direccion\" : \"" + objcOtros.replace_comillas_comillasD_barraInvertida(objDatoCliente.getPersona().getDireccion()) + "\""
                + ",\"dniPasaporte\" : \"" + objDatoCliente.getPersona().getDniPasaporte() + "\""
                + ",\"ruc\" : \"" + objDatoCliente.getPersona().getRuc() + "\""
                + ",\"nombresC\" : \"" + objDatoCliente.getPersona().getNombresC() + "\""
                + ",\"empresaConvenio\":\"" + objcOtros.replace_comillas_comillasD_barraInvertida(objDatoCliente.getEmpresaConvenio().getNombre()) + "\""
                + ",\"condicion\":\"" + (new cDatosCliente().condicionCliente(objDatoCliente.getCondicion())) + "\""
                + " }}");
    }
    out.print("]");

%>