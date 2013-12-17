<%-- 
    Document   : cobradorVendedorLeer
    Created on : 12/09/2013, 10:32:23 AM
    Author     : Henrri
--%>

<%@page import="utilitarios.cOtros"%>
<%@page import="tablas.Personal"%>
<%@page import="java.util.Iterator"%>
<%@page import="personaClases.cPersonal"%>
<%@page import="java.util.List"%>
<%
    String term = "";
    List lPersonal = null;
    try {
        term = request.getParameter("term").toString();
        lPersonal = new cPersonal().leer_cobradorVendedor(term);
        if (lPersonal == null) {
            out.print("[]");
            return;
        }
    } catch (Exception e) {
        out.print("[]");
        return;
    }
    Iterator iPersonal = lPersonal.iterator();
    cOtros objcOtros = new cOtros();
    int contador = 0;
    out.print("[");
    while (iPersonal.hasNext()) {
        Personal objPersonal = (Personal) iPersonal.next();
        if (contador++ > 0) {
            out.println(",");
        }
        String nombresC = objcOtros.replace_comillas_comillasD_barraInvertida(objPersonal.getPersona().getNombresC());
        String dni = objPersonal.getPersona().getDniPasaporte().equals("") ? "" : "DNI " + objPersonal.getPersona().getDniPasaporte();
        String ruc = objPersonal.getPersona().getRuc().equals("") ? "" : "RUC " + objPersonal.getPersona().getRuc();
        out.println("{ "
                + "\"label\" : \"" + dni + " " + ruc + " " + nombresC + "\", "
                + "\"value\" : { "
                + "\"codPersona\" : " + objPersonal.getPersona().getCodPersona()
                + ",\"nombresC\" : \"" + objPersonal.getPersona().getNombresC() + "\""
                + "}}");
    }
    out.print("]");
%>
