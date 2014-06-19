<%-- 
    Document   : clientePorCodCliente
    Created on : 26/05/2014, 10:48:36 AM
    Author     : Henrri
    Descripción: Retorna un cliente sólo si tiene el primer dígito del substrig(0,1)= 1
--%>


<%@page import="personaClases.cDatosCliente"%>
<%@page import="clases.cUtilitarios"%>
<%@page import="utilitarios.cManejoFechas"%>
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
    boolean cobrarInteres = interesEvitar == null ? true : interesEvitar.compareTo(new cManejoFechas().fecha_actual()) != 0;
    out.print("[{"
            + "\"codCliente\":\"" + cUtilitarios.agregarCerosIzquierda(objCliente.getCodDatosCliente(), 8) + "\""
            + ", \"nombresC\":\"" + cUtilitarios.reemplazarCaracteresEspeciales(objCliente.getPersona().getNombresC()) + "\""
            + ", \"dniPasaporte\":\"" + objCliente.getPersona().getDniPasaporte() + "\""
            + ", \"ruc\":\"" + objCliente.getPersona().getRuc() + "\""
            + ", \"codEmpresaConvenio\":\"" + objCliente.getEmpresaConvenio().getCodEmpresaConvenio() + "\""
            + ", \"empresaConvenio\":\"" + cUtilitarios.reemplazarCaracteresEspeciales(objCliente.getEmpresaConvenio().getNombre()) + "\""
            + ", \"codCobranza\":\"" + objCliente.getEmpresaConvenio().getCodCobranza() + "\""
            + ", \"tipo\":\"" + cDatosCliente.tipoCliente(objCliente.getTipo()).toUpperCase() + "\""
            + ", \"condicion\":\"" + cDatosCliente.condicionCliente(objCliente.getCondicion()).toUpperCase() + "\""
            + ", \"saldoFavor\":\"" + cUtilitarios.decimalFormato(objCliente.getSaldoFavor(), 2) + "\""
            + ", \"interesEvitar\":\"" + cManejoFechas.DateAString(interesEvitar) + "\""
            + ", \"interesEvitarEstado\":" + cobrarInteres
            + "}]");
%>