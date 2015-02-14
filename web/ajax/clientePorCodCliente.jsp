<%-- 
    Document   : clientePorCodCliente
    Created on : 26/05/2014, 10:48:36 AM
    Author     : Henrri
    Descripción: Retorna un cliente sólo si tiene el primer dígito del substrig(0,1)= 1
--%>

<%@page import="Ejb.EjbVenta"%>
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
//    if (request.getMethod().equals("GET")) {
//        out.print("No tiene permisos para ver este enlace.");
//        return;
//    }
    // ============================ sesión =====================================
    //verficar inicio de sesión        
    Usuario objUsuario = (Usuario) session.getAttribute("usuario");
    if (objUsuario == null) {
        out.print("La sesión se ha cerrado.");
        return;
    }
    //actualizamos ultimo ingreso
    session.setAttribute("fechaAcceso", new Date());
    // ============================ sesión =====================================
    String codClienteString = request.getParameter("codCliente");
    //En caso de que el parámetro codCliente no se haya enviado
    if (codClienteString == null) {
        out.print("[Parámetro codCliente no encontrado.]");
        return;
    }
    int codClienteI = Integer.parseInt(codClienteString);
    EjbCliente ejbCliente;
    EjbVenta ejbVenta;
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
    //actualizamos los datos de la venta y letras de credito
    ejbVenta = new EjbVenta();
    if (!ejbVenta.actualizarVentaDatosCreditoEInteresCuotas(objCliente.getCodDatosCliente())) {
        out.print(ejbVenta.getError());
        return;
    }
    Date interesEvitar = objCliente.getInteresEvitar();
    boolean cobrarInteres = true;
    //si en caso esta con evitar interes permanente
    if (objCliente.isInteresEvitarPermanente()) {
        cobrarInteres = false;
    } else {
        cobrarInteres = interesEvitar == null ? true : interesEvitar.compareTo(new Fecha().fechaHoraAFecha(new Date())) != 0;
    }
    out.print("[{"
            + "\"codCliente\":\"" + Utilitarios.agregarCerosIzquierda(objCliente.getCodDatosCliente(), 8) + "\""
            + ", \"nombresC\":\"" + Utilitarios.reemplazarCaracteresEspeciales(objCliente.getPersona().getNombresC()) + "\""
            + ", \"dniPasaporte\":\"" + objCliente.getPersona().getDniPasaporte() + "\""
            + ", \"ruc\":\"" + objCliente.getPersona().getRuc() + "\""
            + ", \"direccion\":\"" + Utilitarios.reemplazarCaracteresEspeciales(objCliente.getPersona().getDireccion()) + "\""
            + ", \"telefono1\":\"" + Utilitarios.reemplazarCaracteresEspeciales(objCliente.getPersona().getTelefono1()) + "\""
            + ", \"telefono2\":\"" + Utilitarios.reemplazarCaracteresEspeciales(objCliente.getPersona().getTelefono2()) + "\""
            + ", \"centroTrabajo\":\"" + Utilitarios.reemplazarCaracteresEspeciales(objCliente.getCentroTrabajo()) + "\""
            + ", \"telefonoTrabajo\":\"" + Utilitarios.reemplazarCaracteresEspeciales(objCliente.getTelefono()) + "\""
            + ", \"creditoMaximo\":\"" + Utilitarios.decimalFormato(objCliente.getCreditoMax(), 2) + "\""
            + ", \"codEmpresaConvenio\":\"" + objCliente.getEmpresaConvenio().getCodEmpresaConvenio() + "\""
            + ", \"empresaConvenio\":\"" + Utilitarios.reemplazarCaracteresEspeciales(objCliente.getEmpresaConvenio().getNombre()) + "\""
            + ", \"codCobranza\":\"" + objCliente.getEmpresaConvenio().getCodCobranza() + "\""
            + ", \"tipo\":\"" + cDatosCliente.tipoCliente(objCliente.getTipo()).toUpperCase() + "\""
            + ", \"condicion\":\"" + cDatosCliente.condicionCliente(objCliente.getCondicion()).toUpperCase() + "\""
            + ", \"saldoFavor\":\"" + Utilitarios.decimalFormato(objCliente.getSaldoFavor(), 2) + "\""
            + ", \"interesEvitar\":\"" + new Fecha().dateAString(interesEvitar) + "\""
            + ", \"interesEvitarPermanente\":" + objCliente.isInteresEvitarPermanente()
            + ", \"interesEvitarEstado\":" + cobrarInteres
            + "}]");
%>