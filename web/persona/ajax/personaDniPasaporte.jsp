<%-- 
    Document   : personaDniPasaporte
    Created on : 05/09/2013, 04:36:58 PM
    Author     : Henrri
--%>

<%@page import="tablas.PNatural"%>
<%@page import="utilitarios.cManejoFechas"%>
<%@page import="utilitarios.cOtros"%>
<%@page import="personaClases.cPersona"%>
<%@page import="tablas.Persona"%>
<%
    String dniPasaporte = "";
    try {
        dniPasaporte = request.getParameter("dniPasaporte").toString();
    } catch (Exception e) {
        out.print("[]");
        return;
    }
    if (dniPasaporte.length() < 8) {
        out.print("[]");
        return;
    }
    Persona objPersona = new cPersona().leer_dniPasaporte(dniPasaporte);
    cOtros objcOtros = new cOtros();
    cManejoFechas objcManejoFechas = new cManejoFechas();
    out.print("[");
    if (objPersona != null) {
        PNatural objNatural = objPersona.getPNaturals().iterator().next();
        out.print("{"
                + "\"codPersona\":\"" + objcOtros.agregarCeros_int(objPersona.getCodPersona(), 8) + "\""
                + ",\"nombres\":\"" + objcOtros.replace_comillas_comillasD_barraInvertida(objPersona.getNombres()) + "\""
                + ",\"direccion\":\"" + objcOtros.replace_comillas_comillasD_barraInvertida(objPersona.getDireccion()) + "\""
                + ",\"dniPasaporte\":\"" + objPersona.getDniPasaporte() + "\""
                + ",\"ruc\":\"" + objPersona.getRuc() + "\""
                + ",\"telefono1P\":\"" + objPersona.getTelefono1() + "\""
                + ",\"telefono2P\":\"" + objPersona.getTelefono2() + "\""
                + ",\"email\":\"" + objPersona.getEmail() + "\""
                + ",\"fechaNacimiento\":\"" + objcManejoFechas.DateAString(objPersona.getFechaNacimiento()) + "\""
                + ",\"paginaWeb\":\"" + objPersona.getPaginaWeb() + "\""
                + ",\"observacionPersona\":\"" + objcOtros.replace_comillas_comillasD_barraInvertida(objPersona.getObservaciones()) + "\""
                + ",\"codZona\":" + objPersona.getZona().getCodZona()
                + ",\"zona\":\"" + objPersona.getZona().getZona() + "\""                
                + ",\"codNatural\":" + objNatural.getCodNatural()
                + ",\"apePaterno\":\"" + objcOtros.replace_comillas_comillasD_barraInvertida(objNatural.getApePaterno()) + "\""
                + ",\"apeMaterno\":\"" + objcOtros.replace_comillas_comillasD_barraInvertida(objNatural.getApeMaterno()) + "\""
                + ",\"sexo\":" + (objNatural.getSexo() ? 1 : 0)
                + ",\"estadoCivil\":\"" + objNatural.getEstadoCivil().toUpperCase() + "\""
                + "}");
    }
    out.print("]");
%>