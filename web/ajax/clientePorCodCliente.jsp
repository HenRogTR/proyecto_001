<%-- 
    Document   : clientePorCodCliente
    Created on : 26/05/2014, 10:48:36 AM
    Author     : Henrri
    Descripción: Retorna un cliente sólo si tiene el primer dígito del substrig(0,1)= 1
--%>

<%@page import="tablas.Usuario"%>
<%@page import="personaClases.cDatosCliente"%>
<%@page import="Clase.Fecha"%>
<%@page import="Clase.Utilitarios"%>
<%@page import="java.util.Date"%>
<%@page import="tablas.DatosCliente"%>
<%@page import="Ejb.EjbVentaCreditoLetra"%>
<%@page import="Ejb.EjbCliente"%>
<%
    //evitar el acceso directo por el URL
    if (request.getMethod().equals("GET")) {
        out.print("No tiene permisos para ver este enlace.");
        return;
    }
    //verficar inicio de sesion
    if ((Usuario) session.getAttribute("usuario") == null) {
        out.print("La sesión se ha cerrado.");
        return;
    }
    //actualizamos ultimo acceso
    session.setAttribute("fechaAcceso", new Date());
    String codClienteString = request.getParameter("codCliente");
    //En caso de que el parametro codCliente no se haya enviado
    if (codClienteString == null) {
        out.print("[Parámetro codCliente no encontrado.]");
        return;
    }
    int codClienteI = Integer.parseInt(codClienteString);
    EjbCliente ejbCliente;
    EjbVentaCreditoLetra ejbVentaCreditoLetra;
    //inicializar ejb
    ejbCliente = new EjbCliente();
    DatosCliente objCliente = ejbCliente.leerCodigoCliente(codClienteI, false);
    //si no se encontro con el código dado
    if (objCliente == null) {
        out.print("[]");
        return;
    }
    //si existe y se encuentra anulado o eliminado
    //esto debería de mostrarse?
    if (!"1".equals(objCliente.getRegistro().substring(0, 1))) {
        out.print("[]");
        return;
    }

    //inicializar ejb
    ejbVentaCreditoLetra = new EjbVentaCreditoLetra();
    //actualizamos
    ejbVentaCreditoLetra.actualizarInteresPorCodigoCliente(objCliente.getCodDatosCliente());
    Date interesEvitar = objCliente.getInteresEvitar();
    boolean cobrarInteres = true;
    //si en caso esta con evitar interes permanente
    if (objCliente.getInteresEvitarPermanente()) {
        cobrarInteres = false;
    } else {
        cobrarInteres = interesEvitar == null ? true : interesEvitar.compareTo(new Fecha().fechaHoraAFecha(new Date())) != 0;
    }
    out.print("[{"
            + "\"codCliente\":\"" + new Utilitarios().agregarCerosIzquierda(objCliente.getCodDatosCliente(), 8) + "\""
            + ", \"nombresC\":\"" + new Utilitarios().reemplazarCaracteresEspeciales(objCliente.getPersona().getNombresC()) + "\""
            + ", \"dniPasaporte\":\"" + objCliente.getPersona().getDniPasaporte() + "\""
            + ", \"ruc\":\"" + objCliente.getPersona().getRuc() + "\""
            + ", \"codEmpresaConvenio\":\"" + objCliente.getEmpresaConvenio().getCodEmpresaConvenio() + "\""
            + ", \"empresaConvenio\":\"" + new Utilitarios().reemplazarCaracteresEspeciales(objCliente.getEmpresaConvenio().getNombre()) + "\""
            + ", \"codCobranza\":\"" + objCliente.getEmpresaConvenio().getCodCobranza() + "\""
            + ", \"tipo\":\"" + cDatosCliente.tipoCliente(objCliente.getTipo()).toUpperCase() + "\""
            + ", \"condicion\":\"" + cDatosCliente.condicionCliente(objCliente.getCondicion()).toUpperCase() + "\""
            + ", \"saldoFavor\":\"" + new Utilitarios().decimalFormato(objCliente.getSaldoFavor(), 2) + "\""
            + ", \"interesEvitar\":\"" + new Fecha().dateAString(interesEvitar) + "\""
            + ", \"interesEvitarPermanente\":" + objCliente.getInteresEvitarPermanente()
            + ", \"interesEvitarEstado\":" + cobrarInteres
            + "}]");
%>