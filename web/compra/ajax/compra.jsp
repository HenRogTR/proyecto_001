<%-- 
    Document   : compra
    Created on : 07/08/2013, 11:52:38 AM
    Author     : henrri
--%>

<%@page import="otros.cUtilitarios"%>
<%@page import="compraClases.cCompra"%>
<%@page import="tablas.Compra"%>
<%
    int codCompra = 0;
    try {
        codCompra = Integer.parseInt(request.getParameter("codCompra"));
    } catch (Exception e) {
    };
    Compra objCompra = new Compra();
    cCompra objcCompra = new cCompra();
    cUtilitarios objcUtilitarios = new cUtilitarios();
    switch (codCompra) {
        case -1://primero
            objCompra = objcCompra.leer_primero();
            break;
        case 0://ultimo
            objCompra = objcCompra.leer_ultimo();
            break;
        default://otros numeros
            objCompra = objcCompra.leer_cod(codCompra);
            break;
    }
//    out.print(codCompra);
    out.print("[");
    if (objCompra != null) {
        out.print("{"
                + "\"codCompra\":\"" + objcUtilitarios.agregarCeros_int(objCompra.getCodCompra(), 8) + "\""
                //                + "\"\":\"" + "\""
                + ",\"tipo\" : \"" + objCompra.getTipo() + "\""
                + ",\"item\" : " + objCompra.getItemCantidad()
                + ",\"docSerieNumero\" : \"" + objCompra.getDocSerieNumero() + "\""
                + ",\"fechaFactura\" : \"" + objcUtilitarios.fechaDateToString(objCompra.getFechaFactura()) + "\""
                + ",\"fechaVencimiento\" : \"" + objcUtilitarios.fechaDateToString(objCompra.getFechaVencimiento()) + "\""
                + ",\"fechaLlegada\" : \"" + objcUtilitarios.fechaDateToString(objCompra.getFechaLlegada()) + "\""
                + ",\"subTotal\" : \"" + objcUtilitarios.agregarCerosNumeroFormato(objcUtilitarios.redondearDecimales(objCompra.getSubTotal(), 2), 2) + "\""
                + ",\"total\" : \"" + objcUtilitarios.agregarCerosNumeroFormato(objcUtilitarios.redondearDecimales(objCompra.getTotal(), 2), 2) + "\""
                + ",\"montoIgv\" : \"" + objcUtilitarios.agregarCerosNumeroFormato(objcUtilitarios.redondearDecimales(objCompra.getMontoIgv(), 2), 2) + "\""
                + ",\"neto\" : \"" + objcUtilitarios.agregarCerosNumeroFormato(objcUtilitarios.redondearDecimales(objCompra.getNeto(), 2), 2) + "\""
                + ",\"son\" : \"" + objCompra.getSon() + "\""
                + ",\"moneda\" : \"" + objCompra.getMoneda() + "\""
                + ",\"observacion\" : \"" + objcUtilitarios.replace_comillas_comillasD_barraInvertida(objCompra.getObservacion()) + "\""
                + ",\"codProveedor\" : " + objCompra.getProveedor().getCodProveedor()
                + ",\"ruc\" : \"" + objCompra.getProveedor().getRuc() + "\""
                + ",\"razonSocial\" : \"" + objcUtilitarios.replace_comillas_comillasD_barraInvertida(objCompra.getProveedor().getRazonSocial()) + "\""
                + ",\"direccion\" : \"" + objcUtilitarios.replace_comillas_comillasD_barraInvertida(objCompra.getProveedor().getDireccion()) + "\""
                + "}");
    }
    out.print("]");
%>
