<%-- 
    Document   : ventaLeerUltimo
    Created on : 19/06/2014, 11:12:01 AM
    Author     : Henrri
--%>


<%@page import="clases.cFecha"%>
<%@page import="clases.cUtilitarios"%>
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
            + "\"codVenta\":\"" + cUtilitarios.agregarCerosIzquierda(objVenta.getCodVentas(), 8) + "\""
            + ", \"itemCantidad\":" + objVenta.getItemCantidad()
            + ", \"docSerieNumero\":\"" + objVenta.getDocSerieNumero() + "\""
            + ", \"tipo\":\"" + objVenta.getTipo() + "\""
            + ", \"fecha\":\"" + cFecha.dateAString(objVenta.getFecha()) + "\""
            + ", \"moneda\":\"" + objVenta.getMoneda() + "\""
            + ", \"subTotal\":\"" + cUtilitarios.decimalFormato(objVenta.getSubTotal(), 2) + "\""
            + ", \"descuento\":\"" + cUtilitarios.decimalFormato(objVenta.getDescuento(), 2) + "\""
            + ", \"total\":\"" + cUtilitarios.decimalFormato(objVenta.getTotal(), 2) + "\""
            + ", \"valorIgv\":\"" + cUtilitarios.decimalFormato(objVenta.getValorIgv(), 2) + "\""
            + ", \"neto\":\"" + cUtilitarios.decimalFormato(objVenta.getNeto(), 2) + "\""
            + ", \"son\":\"" + cUtilitarios.reemplazarCaracteresEspeciales(objVenta.getSon()) + "\""
            + ", \"personaCodVendedor\":\"" + cUtilitarios.agregarCerosIzquierda(objVenta.getPersonaCodVendedor(), 8) + "\""
            + ", \"vendedorNombresC\":\"" + cUtilitarios.reemplazarCaracteresEspeciales(objPersonal.getPersona().getNombresC()) + "\""
            + ", \"estado\":" + objVenta.getEstado()
            + ", \"observacion\":\"" + cUtilitarios.reemplazarCaracteresEspeciales(objVenta.getObservacion()) + "\""
            + ", \"codCliente\":\"" + cUtilitarios.agregarCerosIzquierda(objCliente.getCodDatosCliente(), 8) + "\""
            + ", \"cliente\":\"" + cUtilitarios.reemplazarCaracteresEspeciales(objVenta.getCliente()) + "\""
            + ", \"identificacion\":\"" + objVenta.getIdentificacion() + "\""
            + ", \"direccion\":\"" + cUtilitarios.reemplazarCaracteresEspeciales(objVenta.getDireccion()) + "\""
            + ", \"docSerieNumeroGuia\":\"" + cUtilitarios.reemplazarCaracteresEspeciales(objVenta.getDocSerieNumeroGuia()) + "\""
            + ", \"direccion2\":\"" + cUtilitarios.reemplazarCaracteresEspeciales(objVenta.getDireccion2()) + "\""
            + ", \"direccion3\":\"" + cUtilitarios.reemplazarCaracteresEspeciales(objVenta.getDireccion3()) + "\""
            + ", \"registro\":\"" + objVenta.getRegistro() + "\""
            + "}]");
%>