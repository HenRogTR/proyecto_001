<%-- 
    Document   : cliente
    Created on : 23/08/2013, 05:07:44 PM
    Author     : Henrri***
--%>

<%@page import="personaClases.cPersona"%>
<%@page import="tablas.PNatural"%>
<%@page import="utilitarios.cOtros"%>
<%@page import="utilitarios.cManejoFechas"%>
<%@page import="tablas.DatosCliente"%>
<%@page import="personaClases.cDatosCliente"%>
<%
    int codDatoCliente;
    String parametro;
    try {
        codDatoCliente = Integer.parseInt(request.getParameter("codDatoCliente"));
        parametro = (String) request.getParameter("parametro");
    } catch (Exception e) {
        out.print("[]");
        return;
    }

    cDatosCliente objcDatosCliente = new cDatosCliente();
    cOtros objcOtros = new cOtros();
    cManejoFechas objcManejoFechas = new cManejoFechas();
    DatosCliente objDatosCliente = null;
    switch (codDatoCliente) {
        case -1:
            objDatosCliente = objcDatosCliente.leer_primero();
            break;
        case 0:
            objDatosCliente = objcDatosCliente.leer_ultimo();
            break;
        default:
            objDatosCliente = objcDatosCliente.leer_cod(codDatoCliente);
            while (objDatosCliente == null) {
                if (parametro.equals("siguiente")) {
                    DatosCliente objDatosCliente1 = objcDatosCliente.leer_ultimo();
                    codDatoCliente++;
                    if (codDatoCliente > objDatosCliente1.getCodDatosCliente()) {//para ver que no haya pasado al final
                        objDatosCliente = objDatosCliente1;
                    }
                }
                if (parametro.equals("anterior")) {
                    DatosCliente objDatosCliente1 = objcDatosCliente.leer_primero();
                    codDatoCliente--;
                    if (codDatoCliente < objDatosCliente1.getCodDatosCliente()) {//para ver que no haya pasado al final
                        objDatosCliente = objDatosCliente1;
                    }
                }
                if (parametro.equals("")) {
                    break;
                }
            }
            break;
    }
    out.print("[");
    if (objDatosCliente != null) {
        session.removeAttribute("codDatoClienteMantenimiento");
        session.setAttribute("codDatoClienteMantenimiento", objDatosCliente.getCodDatosCliente());
//                + ",\"\":\"" + "" + "\""
        //Persona
        out.print("{"
                + "\"codPersona\":\"" + objcOtros.agregarCeros_int(objDatosCliente.getPersona().getCodPersona(), 8) + "\""
                + ",\"nombres\":\"" + objcOtros.replace_comillas_comillasD_barraInvertida(objDatosCliente.getPersona().getNombres()) + "\""
                + ",\"direccion\":\"" + objcOtros.replace_comillas_comillasD_barraInvertida(objDatosCliente.getPersona().getDireccion()) + "\""
                + ",\"dni\":\"" + objDatosCliente.getPersona().getDniPasaporte() + "\""
                + ",\"ruc\":\"" + objDatosCliente.getPersona().getRuc() + "\""
                + ",\"telefono1P\":\"" + objDatosCliente.getPersona().getTelefono1() + "\""
                + ",\"telefono2P\":\"" + objDatosCliente.getPersona().getTelefono2() + "\""
                + ",\"email\":\"" + objDatosCliente.getPersona().getEmail() + "\""
                + ",\"fechaNacimiento\":\"" + objcManejoFechas.DateAString(objDatosCliente.getPersona().getFechaNacimiento()) + "\""
                + ",\"paginaWeb\":\"" + objDatosCliente.getPersona().getPaginaWeb() + "\""
                + ",\"observacionPersona\":\"" + objcOtros.replace_comillas_comillasD_barraInvertida(objDatosCliente.getPersona().getObservaciones()) + "\""
                + ",\"zona\":\"" + objDatosCliente.getPersona().getZona().getZona() + "\""
                + "}");
//        DatosCliente
        out.print(",{"
                + "\"codDatoCliente\":\"" + objcOtros.agregarCeros_int(objDatosCliente.getCodDatosCliente(), 8) + "\""
                + ",\"tipoCliente\":\"" + objDatosCliente.getTipoCliente() + "\""
                + ",\"empresaConvenio\":\"" + objcOtros.replace_comillas_comillasD_barraInvertida(objDatosCliente.getEmpresaConvenio().getNombre()) + "\""
                + ",\"centroTrabajo\":\"" + objcOtros.replace_comillas_comillasD_barraInvertida(objDatosCliente.getCentroTrabajo()) + "\""
                + ",\"telefonoT1\":\"" + objDatosCliente.getTelefono() + "\""
                + ",\"telefonoT2\":\"" + "" + "\""
                + ",\"tipo\":\"" + objcDatosCliente.tipoCliente(objDatosCliente.getTipo()) + "\""
                + ",\"condicion\":\"" + objcDatosCliente.condicionCliente(objDatosCliente.getCondicion()) + "\""
                + ",\"creditoMax\":\"" + objcOtros.decimalFormato(objDatosCliente.getCreditoMax(), 2) + "\""
                + ",\"saldoFavor\":\"" + objcOtros.decimalFormato(objDatosCliente.getSaldoFavor(), 2) + "\""
                + ",\"observacionCliente\":\"" + objcOtros.replace_comillas_comillasD_barraInvertida(objDatosCliente.getObservaciones()) + "\""
                + ",\"cobrador\":\"" + (new cPersona().leer_cod(objDatosCliente.getCodCobrador())).getNombres() + "\""
                + ",\"registro\":\"" + objDatosCliente.getRegistro() + "\""
                + "}");
        if (objDatosCliente.getTipoCliente().equals(1)) {
            PNatural objNatural = new PNatural();
            for (PNatural objNaturalTemp : objDatosCliente.getPersona().getPNaturals()) {
//                if (objNaturalTemp.getRegistro().substring(0, 1).equals("1")) {
                    objNatural = objNaturalTemp;
//                }
            }
            session.removeAttribute("codDatoClienteNaturalMantenimiento");
            session.setAttribute("codDatoClienteNaturalMantenimiento", objDatosCliente.getCodDatosCliente());
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
        } else {
            session.removeAttribute("codDatoClienteJuridicoMantenimiento");
            session.setAttribute("codDatoClienteJuridicoMantenimiento", objDatosCliente.getCodDatosCliente());
        }
    }
    out.print("]");
%>
