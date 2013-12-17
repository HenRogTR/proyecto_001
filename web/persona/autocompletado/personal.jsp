<%-- 
    Document   : personal
    Created on : 26/09/2013, 04:45:14 PM
    Author     : Henrri
--%>

<%@page import="utilitarios.cOtros"%>
<%@page import="tablas.Personal"%>
<%@page import="java.util.Iterator"%>
<%@page import="personaClases.cPersonal"%>
<%@page import="java.util.List"%>
<%
    String termString = "";
    try {
        termString = request.getParameter("term").toString();
    } catch (Exception e) {
        out.print("[]");
        return;
    }
    cPersonal objcPersonal = new cPersonal();
    cOtros objcOtros = new cOtros();
    List personalList = objcPersonal.leer_personal(termString);
    Iterator personalIt = personalList.iterator();
    int cont = 0;

    out.print("[");
    while (personalIt.hasNext()) {
        Personal objPersonal = (Personal) personalIt.next();
        if (cont++ > 0) {
            out.print(",");
        }
        String nombresC = objcOtros.replace_comillas_comillasD_barraInvertida(objPersonal.getPersona().getNombresC());
        String dni = objPersonal.getPersona().getDniPasaporte().equals("") ? "" : "DNI " + objPersonal.getPersona().getDniPasaporte();
        String ruc = objPersonal.getPersona().getRuc().equals("") ? "" : "RUC " + objPersonal.getPersona().getRuc();
        out.println("{ "
                + "\"label\" : \"" + dni + " " + ruc + " " + nombresC + "\", "
                + "\"value\" : { "
                + "\"codPersona\" : " + objPersonal.getPersona().getCodPersona()
                + ",\"nombresC\" : \"" + objPersonal.getPersona().getNombresC() + "\""
                + "} "
                + "}");
    }

    out.print("]");
%>