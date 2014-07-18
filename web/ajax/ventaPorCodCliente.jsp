<%-- 
    Document   : ventaPorCodCliente
    Created on : 11/06/2014, 06:08:29 PM
    Author     : Henrri
--%>

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
    EjbVentaCreditoLetra ejbVentaCreditoLetra;
    //obtener ventas
    ejbVenta = new EjbVenta();
    List<Ventas> ventaList = ejbVenta.leerPorCodigoCliente(codClienteI, true);
    //definimos variables
    Integer cantidadLetras;
    Double monto;
    Double interes;
    Double totalPago;
    Double interesPagado;

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
        //inicializar datos
        cantidadLetras = 0;
        monto = 0.00;
        interes = 0.00;
        totalPago = 0.00;
        interesPagado = 0.00;

        deudaVenta = 0.00;
        deudaVentaSinInteres = 0.00;
        pagoVenta = 0.00;
        saldoVenta = 0.00;
        saldoVentaSinInteres = 0.00;
        //obtener los totales
        ejbVentaCreditoLetra = new EjbVentaCreditoLetra();
        List<VentaCreditoLetra> ventaCreditoLetraList = ejbVentaCreditoLetra.leerActivoPorCodigoVenta(objVenta.getCodVentas(), true);
        int tam2 = ventaCreditoLetraList.size();
        //si en caso no tiene ventas al credito activo, tam=0, por ende será menos 1
        cantidadLetras = tam2 - 1;
        //corregir
        cantidadLetras = cantidadLetras < 0 ? 0 : cantidadLetras;
        for (int j = 0; j < tam2; j++) {
            VentaCreditoLetra objVentaCreditoLetra = ventaCreditoLetraList.get(j);
            monto += objVentaCreditoLetra.getMonto();
            interes += objVentaCreditoLetra.getInteres();
            totalPago += objVentaCreditoLetra.getTotalPago();
            interesPagado += objVentaCreditoLetra.getInteresPagado();
        }
        deudaVenta = monto + interes;
        deudaVentaSinInteres = monto + interesPagado;
        pagoVenta = totalPago + interesPagado;
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
                + ", \"cantidadLetras\":\"" + cantidadLetras + "\""
                + ", \"monto\":\"" + new Utilitarios().decimalFormato(monto, 2) + "\""
                + ", \"interes\":\"" + new Utilitarios().decimalFormato(interes, 2) + "\""
                + ", \"totalPago\":\"" + new Utilitarios().decimalFormato(totalPago, 2) + "\""
                + ", \"interesPagado\":\"" + new Utilitarios().decimalFormato(interesPagado, 2) + "\""
                + ", \"deudaVenta\":\"" + new Utilitarios().decimalFormato(deudaVenta, 2) + "\""
                + ", \"deudaVentaSinInteres\":\"" + new Utilitarios().decimalFormato(deudaVentaSinInteres, 2) + "\""
                + ", \"pagoVenta\":\"" + new Utilitarios().decimalFormato(pagoVenta, 2) + "\""
                + ", \"saldoVenta\":\"" + new Utilitarios().decimalFormato(saldoVenta, 2) + "\""
                + ", \"saldoVentaSinInteres\":\"" + new Utilitarios().decimalFormato(saldoVentaSinInteres, 2) + "\""
                + "}");
    }
    out.print("]");
%>
