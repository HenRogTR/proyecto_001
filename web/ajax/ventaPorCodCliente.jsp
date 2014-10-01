<%-- 
    Document   : ventaPorCodCliente
    Created on : 11/06/2014, 06:08:29 PM
    Author     : Henrri
--%>

<%@page import="tablas.Usuario"%>
<%@page import="tablas.VentaCreditoLetra"%>
<%@page import="Ejb.EjbVentaCreditoLetra"%>
<%@page import="tablas.Personal"%>
<%@page import="Ejb.EjbPersonal"%>
<%@page import="Clase.Utilitarios"%>
<%@page import="Clase.Fecha"%>
<%@page import="java.util.Date"%>
<%@page import="tablas.Ventas"%>
<%@page import="java.util.List"%>
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
    //siempre se tendrá un dato válido para codigoCliente
    String codClienteString = request.getParameter("codCliente");
    //En caso de que el parametro codCliente no se haya enviado
    if (codClienteString == null) {
        out.print("[Parámetro codCliente no encontrado.]");
        return;
    }
    int codClienteI = Integer.parseInt(codClienteString);
    //definir java bean
    EjbVenta ejbVenta;
    EjbPersonal ejbPersonal;
    //obtener ventas
    ejbVenta = new EjbVenta();
    if (!ejbVenta.actualizarVentaDatosCreditoEInteresCuotas(codClienteI)) {
        out.print(ejbVenta.getError());
        return;
    }
    List<Ventas> ventaList = ejbVenta.leerPorCodigoCliente(codClienteI, true);
    //definimos variables
    Double deudaVenta;
    //deuda que mantiene sin sumar intereses
    Double deudaVentaSinInteres;
    Double pagoVenta;
    Double saldoVenta;
    //saldo que mantiene sin sumar intereses
    Double saldoVentaSinInteres;
    //ventaList no puede tomar valor null
    int tam = ventaList.size();
    out.print("[");
    for (int i = 0; i < tam; i++) {
        Ventas objVenta = ventaList.get(i);
        //obtener datos de vendedor
        ejbPersonal = new EjbPersonal();
        Personal objPersonal = ejbPersonal.leerPorCodigoPersona(objVenta.getPersonaCodVendedor(), false);
        //obtener los totales
        deudaVenta = objVenta.getNeto() + objVenta.getInteres();
        deudaVentaSinInteres = objVenta.getNeto() + objVenta.getInteresPagado();
        pagoVenta = objVenta.getAmortizado() + objVenta.getInteresPagado();
        saldoVenta = deudaVenta - pagoVenta;
        saldoVentaSinInteres = deudaVentaSinInteres - pagoVenta;
        if (i > 0) {
            out.print(", ");
        }
        out.print("{"
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
                + ", \"codCliente\":\"" + new Utilitarios().agregarCerosIzquierda(codClienteI, 8) + "\""
                + ", \"cliente\":\"" + new Utilitarios().reemplazarCaracteresEspeciales(objVenta.getCliente()) + "\""
                + ", \"identificacion\":\"" + objVenta.getIdentificacion() + "\""
                + ", \"direccion\":\"" + new Utilitarios().reemplazarCaracteresEspeciales(objVenta.getDireccion()) + "\""
                + ", \"docSerieNumeroGuia\":\"" + new Utilitarios().reemplazarCaracteresEspeciales(objVenta.getDocSerieNumeroGuia()) + "\""
                + ", \"direccion2\":\"" + new Utilitarios().reemplazarCaracteresEspeciales(objVenta.getDireccion2()) + "\""
                + ", \"direccion3\":\"" + new Utilitarios().reemplazarCaracteresEspeciales(objVenta.getDireccion3()) + "\""
                + ", \"registro\":\"" + objVenta.getRegistro() + "\""
                + ", \"cantidadLetras\":\"" + objVenta.getCantidadLetras() + "\""
                + ", \"monto\":\"" + new Utilitarios().decimalFormato(objVenta.getNeto(), 2) + "\""
                + ", \"interes\":\"" + new Utilitarios().decimalFormato(objVenta.getInteres(), 2) + "\""
                + ", \"totalPago\":\"" + new Utilitarios().decimalFormato(objVenta.getAmortizado(), 2) + "\""
                + ", \"interesPagado\":\"" + new Utilitarios().decimalFormato(objVenta.getInteresPagado(), 2) + "\""
                + ", \"deudaVenta\":\"" + new Utilitarios().decimalFormato(deudaVenta, 2) + "\""
                + ", \"deudaVentaSinInteres\":\"" + new Utilitarios().decimalFormato(deudaVentaSinInteres, 2) + "\""
                + ", \"pagoVenta\":\"" + new Utilitarios().decimalFormato(pagoVenta, 2) + "\""
                + ", \"saldoVenta\":\"" + new Utilitarios().decimalFormato(saldoVenta, 2) + "\""
                + ", \"saldoVentaSinInteres\":\"" + new Utilitarios().decimalFormato(saldoVentaSinInteres, 2) + "\""
                + "}");
    }
    out.print("]");
%>
