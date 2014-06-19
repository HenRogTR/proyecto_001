<%-- 
    Document   : ventaPorCodCliente
    Created on : 11/06/2014, 06:08:29 PM
    Author     : Henrri
--%>

<%@page import="tablas.VentaCreditoLetra"%>
<%@page import="Ejb.EjbVentaCreditoLetra"%>
<%@page import="tablas.Personal"%>
<%@page import="Ejb.EjbPersonal"%>
<%@page import="clases.cFecha"%>
<%@page import="clases.cUtilitarios"%>
<%@page import="java.util.Date"%>
<%@page import="tablas.Ventas"%>
<%@page import="java.util.List"%>
<%@page import="Ejb.EjbVenta"%>
<%
    //evitar el acceso directo por el URL
//    if (request.getMethod().equals("GET")) {
//        out.print("No tiene permisos para ver este enlace.");
//        return;
//    }
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
    Double pagoVenta;
    Double saldoVenta;
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
        pagoVenta = 0.00;
        saldoVenta = 0.00;
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
        pagoVenta = totalPago + interesPagado;
        saldoVenta = deudaVenta - pagoVenta;
        if (i > 0) {
            out.print(", ");
        }
        out.print("{"
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
                + ", \"codCliente\":\"" + cUtilitarios.agregarCerosIzquierda(codClienteI, 8) + "\""
                + ", \"cliente\":\"" + cUtilitarios.reemplazarCaracteresEspeciales(objVenta.getCliente()) + "\""
                + ", \"identificacion\":\"" + objVenta.getIdentificacion() + "\""
                + ", \"direccion\":\"" + cUtilitarios.reemplazarCaracteresEspeciales(objVenta.getDireccion()) + "\""
                + ", \"docSerieNumeroGuia\":\"" + cUtilitarios.reemplazarCaracteresEspeciales(objVenta.getDocSerieNumeroGuia()) + "\""
                + ", \"direccion2\":\"" + cUtilitarios.reemplazarCaracteresEspeciales(objVenta.getDireccion2()) + "\""
                + ", \"direccion3\":\"" + cUtilitarios.reemplazarCaracteresEspeciales(objVenta.getDireccion3()) + "\""
                + ", \"registro\":\"" + objVenta.getRegistro() + "\""
                + ", \"cantidadLetras\":\"" + cantidadLetras + "\""
                + ", \"monto\":\"" + cUtilitarios.decimalFormato(monto, 2) + "\""
                + ", \"interes\":\"" + cUtilitarios.decimalFormato(interes, 2) + "\""
                + ", \"totalPago\":\"" + cUtilitarios.decimalFormato(totalPago, 2) + "\""
                + ", \"interesPagado\":\"" + cUtilitarios.decimalFormato(interesPagado, 2) + "\""
                + ", \"deudaVenta\":\"" + cUtilitarios.decimalFormato(deudaVenta, 2) + "\""
                + ", \"pagoVenta\":\"" + cUtilitarios.decimalFormato(pagoVenta, 2) + "\""
                + ", \"saldoVenta\":\"" + cUtilitarios.decimalFormato(+saldoVenta, 2) + "\""
                + "}");
    }
    out.print("]");
%>
