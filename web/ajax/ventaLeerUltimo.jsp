<%-- 
    Document   : ventaLeerUltimo
    Created on : 19/06/2014, 11:12:01 AM
    Author     : Henrri
--%>

<%@page import="java.util.Date"%>
<%@page import="tablas.Usuario"%>
<%@page import="Clase.Utilitarios"%>
<%@page import="Clase.Fecha"%>
<%@page import="tablas.Personal"%>
<%@page import="tablas.DatosCliente"%>
<%@page import="tablas.Ventas"%>
<%@page import="Ejb.EjbCliente"%>
<%@page import="Ejb.EjbPersonal"%>
<%@page import="Ejb.EjbVenta"%>
<%
    //evitar el acceso directo por el URL
    if (request.getMethod().equals("GET")) {
        out.print("No tiene permisos para ver este enlace.");
        return;
    }
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
    //definir java bean
    EjbVenta ejbVenta;
    EjbPersonal ejbPersonal;
    EjbCliente ejbCliente;
    //obtener venta
    ejbVenta = new EjbVenta();
    Ventas objVenta = ejbVenta.leerUltimaVenta(false);
    //si en caso no hay retornamos vacio
    if (objVenta == null) {
        out.print("[]");
        return;
    }
    //obtener datos de cliente
    ejbCliente = new EjbCliente();
    DatosCliente objCliente = ejbCliente.leerPorCodigoPersona(objVenta.getPersona().getCodPersona(), false);
    //obtener datos de vendedor
    ejbPersonal = new EjbPersonal();
    Personal objPersonal = ejbPersonal.leerPorCodigoPersona(objVenta.getPersonaCodVendedor(), false);
    //imprimir
    out.print("[{"
            + "\"codVenta\":\"" + new Utilitarios().agregarCerosIzquierda(objVenta.getCodVentas(), 8) + "\""
            + ", \"itemCantidad\":" + objVenta.getItemCantidad()
            + ", \"docSerieNumero\":\"" + objVenta.getDocSerieNumero() + "\""
            + ", \"tipo\":\"" + objVenta.getTipo() + "\""
            + ", \"fecha\":\"" + new Fecha().dateAString(objVenta.getFecha()) + "\""
            + ", \"moneda\":\"" + objVenta.getMoneda() + "\""
            + ", \"subTotal\":\"" + new Utilitarios().decimalFormato(objVenta.getSubTotal(), 2) + "\""
            + ", \"descuento\":\"" + new Utilitarios().decimalFormato(objVenta.getDescuento(), 2) + "\""
            + ", \"total\":\"" + new Utilitarios().decimalFormato(objVenta.getTotal(), 2) + "\""
            + ", \"valorIgv\":\"" + new Utilitarios().decimalFormato(objVenta.getValorIgv(), 2) + "\""
            + ", \"neto\":\"" + new Utilitarios().decimalFormato(objVenta.getNeto(), 2) + "\""
            + ", \"son\":\"" + new Utilitarios().reemplazarCaracteresEspeciales(objVenta.getSon()) + "\""
            + ", \"personaCodVendedor\":\"" + new Utilitarios().agregarCerosIzquierda(objVenta.getPersonaCodVendedor(), 8) + "\""
            + ", \"vendedorNombresC\":\"" + new Utilitarios().reemplazarCaracteresEspeciales(objPersonal.getPersona().getNombresC()) + "\""
            + ", \"estado\":" + objVenta.getEstado()
            + ", \"observacion\":\"" + new Utilitarios().reemplazarCaracteresEspeciales(objVenta.getObservacion()) + "\""
            + ", \"codCliente\":\"" + new Utilitarios().agregarCerosIzquierda(objCliente.getCodDatosCliente(), 8) + "\""
            + ", \"cliente\":\"" + new Utilitarios().reemplazarCaracteresEspeciales(objVenta.getCliente()) + "\""
            + ", \"identificacion\":\"" + objVenta.getIdentificacion() + "\""
            + ", \"direccion\":\"" + new Utilitarios().reemplazarCaracteresEspeciales(objVenta.getDireccion()) + "\""
            + ", \"docSerieNumeroGuia\":\"" + new Utilitarios().reemplazarCaracteresEspeciales(objVenta.getDocSerieNumeroGuia()) + "\""
            + ", \"direccion2\":\"" + new Utilitarios().reemplazarCaracteresEspeciales(objVenta.getDireccion2()) + "\""
            + ", \"direccion3\":\"" + new Utilitarios().reemplazarCaracteresEspeciales(objVenta.getDireccion3()) + "\""
            + ", \"registro\":\"" + objVenta.getRegistro() + "\""
            + "}]");
%>