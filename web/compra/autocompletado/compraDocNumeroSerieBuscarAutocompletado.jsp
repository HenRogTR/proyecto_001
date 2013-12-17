<%-- 
    Document   : compraDocNumeroSerieBuscar
    Created on : 11/12/2012, 07:35:39 AM
    Author     : Henrri
--%>
<%@page import="otros.cNumeroLetra"%>
<%@page import="otros.cUtilitarios"%>
<%@page import="tablas.Compra"%>
<%@page import="compraClases.cCompra"%>
<%@page import="tablas.Proveedor"%>
<%@page import="java.util.ArrayList"%>
<%@page import="java.util.List"%>
<%@page import="personaClases.cProveedor"%>
<%
    String criterio = request.getParameter("term");
    if (criterio == null) {
        return;
    }
    cCompra objcCompra = new cCompra();
    cUtilitarios objcUtilitarios = new cUtilitarios();
    List lCompra = objcCompra.leerDocNumeroSerie(criterio);
    String propietario = "";
    int contador = 0;
    out.print("[");
    for (int i = 0; i < lCompra.size(); i++) {
        Compra objCompra = (Compra) lCompra.get(i);
        if (contador++ > 0) {
            out.println(",");
        }
        out.println("{ \"label\" : \"" + objCompra.getDocSerieNumero() + "\", \"value\" : { "
                + "\"codCompra\" : " + objCompra.getCodCompra() + " , "
                + "\"tipo\" : \"" + objCompra.getTipo() + "\" , "
                + "\"item\" : " + objCompra.getItemCantidad() + " , "
                + "\"docSerieNumero\" : \"" + objCompra.getDocSerieNumero() + "\" , "
                + "\"fechaFactura\" : \"" + objcUtilitarios.fechaDateToString(objCompra.getFechaFactura()) + "\" , "
                + "\"fechaVencimiento\" : \"" + objcUtilitarios.fechaDateToString(objCompra.getFechaVencimiento()) + "\" , "
                + "\"fechaLlegada\" : \"" + objcUtilitarios.fechaDateToString(objCompra.getFechaLlegada()) + "\" , "
                + "\"subTotal\" : \"" + objcUtilitarios.agregarCerosNumeroFormato(objcUtilitarios.redondearDecimales(objCompra.getSubTotal(), 2), 2) + "\" , "
                + "\"total\" : \"" + objcUtilitarios.agregarCerosNumeroFormato(objcUtilitarios.redondearDecimales(objCompra.getTotal(), 2), 2) + "\" , "
                + "\"montoIgv\" : \"" + objcUtilitarios.agregarCerosNumeroFormato(objcUtilitarios.redondearDecimales(objCompra.getMontoIgv(), 2), 2) + "\" , "
                + "\"neto\" : \"" + objcUtilitarios.agregarCerosNumeroFormato(objcUtilitarios.redondearDecimales(objCompra.getNeto(), 2), 2) + "\" , "
                + "\"son\" : \"" + objCompra.getSon()+ "\" , "
                + "\"moneda\" : \"" + objCompra.getMoneda() + "\" , "
                + "\"observacion\" : \"" + objcUtilitarios.replace_comillas_comillasD_barraInvertida(objCompra.getObservacion().replace("\n", "::").replace("\r", "  ").replace("/", " - ")) + "\" , "
                + "\"codProveedor\" : " + objCompra.getProveedor().getCodProveedor() + " , "
                + "\"ruc\" : \"" + objCompra.getProveedor().getRuc() + "\" , "
                + "\"razonSocial\" : \"" + objcUtilitarios.replace_comillas_comillasD_barraInvertida(objCompra.getProveedor().getRazonSocial()) + "\" , "
                + "\"direccion\" : \"" + objcUtilitarios.replace_comillas_comillasD_barraInvertida(objCompra.getProveedor().getDireccion()) + "\" , "
                + "\"propietario\" : \"" + propietario + "\""
                + " } }");
    }
    out.print("]");
%>