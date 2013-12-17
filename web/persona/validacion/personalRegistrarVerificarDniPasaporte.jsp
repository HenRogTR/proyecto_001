<%-- 
    Document   : personalRegistrarVerificarDniPasaporte
    Created on : 06/05/2013, 09:01:58 AM
    Author     : Henrri
--%>

<%@page import="personaClases.cPersona"%>
<%    
    String dniPasaporte = request.getParameter("dniPasaporte");
    if (dniPasaporte == null) {
        return;
    }
    String accion = (String) session.getAttribute("accionPersonal");
    if (accion.equals("u")) {
        out.print(true);
    } else {
        cPersona objcPersona = new cPersona();
        out.print(objcPersona.verficarDniPasaporte(dniPasaporte));
    }
%>
