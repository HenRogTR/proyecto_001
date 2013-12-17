<%-- 
    Document   : articuloProductoIngreso
    Created on : 29/08/2013, 05:34:17 PM
    Author     : Henrri******
--%>

<%@page import="utilitarios.cManejoFechas"%>
<%@page import="utilitarios.cOtros"%>
<%@page import="tablas.CompraDetalle"%>
<%@page import="java.util.Iterator"%>
<%@page import="compraClases.cCompraDetalle"%>
<%
    int codAP = 0;
    try {
        codAP = Integer.parseInt(request.getParameter("codArticuloProducto"));
    } catch (Exception e) {
        out.print("[]");
        return;
    }
    cCompraDetalle objcCompraDetalle = new cCompraDetalle();
    cOtros objcOtros = new cOtros();
    cManejoFechas objcManejoFechas = new cManejoFechas();
    Iterator iUltimos10 = objcCompraDetalle.leer_ultimoDiez(codAP).iterator();
    out.print("[");
    int cont = 0;
    while (iUltimos10.hasNext()) {
        if (cont++ > 0) {
            out.print(",");
        }
        CompraDetalle objCompraDetalle = (CompraDetalle) iUltimos10.next();
        out.print("{"
                + "\"fecha\":\"" + objcManejoFechas.DateAString(objCompraDetalle.getCompra().getFechaFactura()) + "\""
                + ",\"codCompra\":\"" + objcOtros.agregarCeros_int(objCompraDetalle.getCompra().getCodCompra(), 8) + "\""
                + ",\"docSerieNumero\":\"" + objCompraDetalle.getCompra().getDocSerieNumero() + "\""
                + ",\"tipo\":\"" + objCompraDetalle.getCompra().getTipo() + "\""
                + ",\"precioUnitario\":\"" + objcOtros.agregarCerosNumeroFormato(objCompraDetalle.getPrecioUnitario(), 4) + "\""
                + ",\"\":\"" + "" + "\""
                + ",\"codProveedor\":\"" + objcOtros.agregarCeros_int(objCompraDetalle.getCompra().getProveedor().getCodProveedor(), 8) + "\""
                + ",\"proveedor\":\"" + objcOtros.replace_comillas_comillasD_barraInvertida(objCompraDetalle.getCompra().getProveedor().getRazonSocial()) + "\""
                + "}");
    }
    out.print("]");
%>
