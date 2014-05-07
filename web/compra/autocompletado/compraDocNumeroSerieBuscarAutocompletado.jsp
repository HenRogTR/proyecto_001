<%-- 
    Document   : compraDocNumeroSerieBuscarAutocompletado
    Created on : 11/12/2012, 07:35:39 AM
    Author     : Henrri
--%>
<%@page import="utilitarios.cOtros"%>
<%@page import="utilitarios.cManejoFechas"%>
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
                + "\"fechaFactura\" : \"" + new cManejoFechas().DateAString(objCompra.getFechaFactura()) + "\" , "
                + "\"fechaVencimiento\" : \"" + new cManejoFechas().DateAString(objCompra.getFechaVencimiento()) + "\" , "
                + "\"fechaLlegada\" : \"" + new cManejoFechas().DateAString(objCompra.getFechaLlegada()) + "\" , "
                + "\"subTotal\" : \"" + new cOtros().decimalFormato(objCompra.getSubTotal(), 2) + "\" , "
                + "\"total\" : \"" + new cOtros().decimalFormato(objCompra.getTotal(), 2) + "\" , "
                + "\"montoIgv\" : \"" + new cOtros().decimalFormato(objCompra.getMontoIgv(), 2) + "\" , "
                + "\"neto\" : \"" + new cOtros().decimalFormato(objCompra.getNeto(), 2) + "\" , "
                + "\"son\" : \"" + objCompra.getSon() + "\" , "
                + "\"moneda\" : \"" + objCompra.getMoneda() + "\" , "
                + "\"observacion\" : \"" + new cOtros().replace_comillas_comillasD_barraInvertida(objCompra.getObservacion()) + "\" , "
                + "\"codProveedor\" : " + objCompra.getProveedor().getCodProveedor() + " , "
                + "\"ruc\" : \"" + objCompra.getProveedor().getRuc() + "\" , "
                + "\"razonSocial\" : \"" + new cOtros().replace_comillas_comillasD_barraInvertida(objCompra.getProveedor().getRazonSocial()) + "\" , "
                + "\"direccion\" : \"" + new cOtros().replace_comillas_comillasD_barraInvertida(objCompra.getProveedor().getDireccion()) + "\" , "
                + "\"propietario\" : \"" + propietario + "\""
                + " } }");
    }
    out.print("]");
%>