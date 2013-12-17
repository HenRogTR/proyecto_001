<%-- 
    Document   : personal
    Created on : 22/08/2013, 11:11:38 PM
    Author     : Henrri
--%>

<%@page import="tablas.PNatural"%>
<%@page import="utilitarios.cManejoFechas"%>
<%@page import="utilitarios.cOtros"%>
<%@page import="tablas.Personal"%>
<%@page import="personaClases.cPersonal"%>
<%@page import="tablas.Persona"%>
<%
    int codPersonal = 0;
    String parametro = "";
    try {
        codPersonal = Integer.parseInt(request.getParameter("codPersonal"));
        parametro = request.getParameter("parametro").toString();
    } catch (Exception e) {
        out.print("[]");
        return;
    };
    Personal objPersonal = null;
    cPersonal objcPersonal = new cPersonal();
    switch (codPersonal) {
        case -1:
            objPersonal = objcPersonal.leer_primero();
            break;
        case 0:
            objPersonal = objcPersonal.leer_ultimo();
            break;
        default:
            objPersonal = objcPersonal.leer_cod(codPersonal);
            while (objPersonal == null) {
                if (parametro.equals("siguiente")) {
                    Personal objPersonal1 = objcPersonal.leer_ultimo();
                    codPersonal++;
                    if (codPersonal > objPersonal1.getCodPersonal()) {//para ver que no haya pasado al final
                        objPersonal = objPersonal1;
                    }
                }
                if (parametro.equals("anterior")) {
                    Personal objPersonal1 = objcPersonal.leer_primero();
                    codPersonal++;
                    if (codPersonal < objPersonal1.getCodPersonal()) {//para ver que no haya pasado al final
                        objPersonal = objPersonal1;
                    }
                }
                if (parametro.equals("")) {
                    break;
                }
            }
            break;
    }
    out.print("[");
    if (objPersonal != null) {
        cOtros objcOtros = new cOtros();
        cManejoFechas objcManejoFechas = new cManejoFechas();
        session.removeAttribute("codPersonalMantenimiento");//para mantener siempre
        session.setAttribute("codPersonalMantenimiento", objPersonal.getCodPersonal());
        session.removeAttribute("codPersonalEditar");
        session.setAttribute("codPersonalEditar", objPersonal.getCodPersonal());//para editar
        //Persona
        out.print("{"
                + "\"codPersona\":\"" + objcOtros.agregarCeros_int(objPersonal.getPersona().getCodPersona(), 8) + "\""
                + ",\"nombres\":\"" + objcOtros.replace_comillas_comillasD_barraInvertida(objPersonal.getPersona().getNombres()) + "\""
                + ",\"direccion\":\"" + objcOtros.replace_comillas_comillasD_barraInvertida(objPersonal.getPersona().getDireccion()) + "\""
                + ",\"dniPasaporte\":\"" + objPersonal.getPersona().getDniPasaporte() + "\""
                + ",\"ruc\":\"" + objPersonal.getPersona().getRuc() + "\""
                + ",\"telefono1P\":\"" + objPersonal.getPersona().getTelefono1() + "\""
                + ",\"telefono2P\":\"" + objPersonal.getPersona().getTelefono2() + "\""
                + ",\"email\":\"" + objPersonal.getPersona().getEmail() + "\""
                + ",\"fechaNacimiento\":\"" + objcManejoFechas.DateAString(objPersonal.getPersona().getFechaNacimiento()) + "\""
                + ",\"paginaWeb\":\"" + objPersonal.getPersona().getPaginaWeb() + "\""
                + ",\"observacionPersona\":\"" + objcOtros.replace_comillas_comillasD_barraInvertida(objPersonal.getPersona().getObservaciones()) + "\""
                + ",\"zona\":\"" + objPersonal.getPersona().getZona().getZona() + "\""
                + "}");
        //natural
        PNatural objNatural = null;
        for (PNatural objNatural1 : objPersonal.getPersona().getPNaturals()) {
            if (objNatural1.getRegistro().substring(0, 1).equals("1")) {
                objNatural = objNatural1;
            }
        }
        out.print(",{"
                + "\"codNatural\":\"" + objcOtros.agregarCeros_int(objNatural.getCodNatural(), 8) + "\""
                + ",\"codModular\":\"" + objNatural.getCodModular() + "\""
                + ",\"cargo\":\"" + objNatural.getCargo() + "\""
                + ",\"carben\":\"" + objNatural.getCarben() + "\""
                + ",\"apePaterno\":\"" + objcOtros.replace_comillas_comillasD_barraInvertida(objNatural.getApePaterno()) + "\""
                + ",\"apeMaterno\":\"" + objcOtros.replace_comillas_comillasD_barraInvertida(objNatural.getApeMaterno()) + "\""
                + ",\"sexo\":\"" + (objNatural.getSexo() ? "FEMENINO" : "MASCULINO") + "\""
                + ",\"estadoCivil\":\"" + objNatural.getEstadoCivil().toUpperCase() + "\""
                + ",\"conyuge\":\"" + "" + "\""
                + "}");

        out.print(",{"
                + "\"codPersonal\":\"" + objcOtros.agregarCeros_int(objPersonal.getCodPersonal(), 8) + "\""
                + ",\"fechaInicioActividades\":\"" + objcManejoFechas.DateAString(objPersonal.getFechaInicioActividades()) + "\""
                + ",\"fechaFinActividades\":\"" + objcManejoFechas.DateAString(objPersonal.getFechaFinActividades()) + "\""
                + ",\"estado\":\"" + (objPersonal.getEstado() ? "HABILITADO" : "DESHABILITADO") + "\""
                + ",\"observacionPersonal\":\"" + objcOtros.replace_comillas_comillasD_barraInvertida(objPersonal.getObservacion()) + "\""
                + ",\"cargo\":\"" + objPersonal.getCargo().getCargo() + "\""
                + ",\"area\":\"" + objPersonal.getArea().getArea() + "\""
                + "}");
    }
    out.print("]");
%>
