<%-- 
    Document   : ventaDetallePorCodVenta
    Created on : 13/06/2014, 11:19:10 PM
    Author     : Henrri
--%>

<%@page import="clases.cUtilitarios"%>
<%@page import="java.util.List"%>
<%@page import="tablas.VentasDetalle"%>
<%@page import="Ejb.EjbVentaDetalle"%>
<%
    //evitar el acceso directo por el URL
    if (request.getMethod().equals("GET")) {
        out.print("No tiene permisos para ver este enlace.");
        return;
    }
    //siempre se tendrá un dato válido para codigoCliente
    String codVentaString = request.getParameter("codVenta");
    //En caso de que el parametro codCliente no se haya enviado
    if (codVentaString == null) {
        out.print("[Parámetro codVenta no encontrado.]");
        return;
    }
    int codVenta = Integer.parseInt(codVentaString);
    //sesion bean
    EjbVentaDetalle ejbVentaDetalle = new EjbVentaDetalle();
    List<VentasDetalle> ventasDetalleList = ejbVentaDetalle.leerActivoPorCodigoVenta(codVenta, true);
    //ventaList no puede tomar valor null
    int tam = ventasDetalleList.size();
    out.print("[");
    for (int i = 0; i < tam; i++) {
        VentasDetalle objVentaDetalle = ventasDetalleList.get(i);
        if (i > 0) {
            out.print(", ");
        }
        out.print("{"
                + "\"codVentaDetalle\":\"" + cUtilitarios.agregarCerosIzquierda(objVentaDetalle.getCodVentasDetalle(), 8) + "\""
                + ", \"item\":" + objVentaDetalle.getItem()
                //                + "\"codArticuloProducto\":\"" + cUtilitarios.agregarCerosIzquierda(objVentaDetalle.getArticuloProducto().getCodArticuloProducto(), 8) + "\""
                + ", \"cantidad\":" + objVentaDetalle.getCantidad()
                + ", \"descripcion\":\"" + cUtilitarios.reemplazarCaracteresEspeciales(objVentaDetalle.getDescripcion()) + "\""
                + ", \"precioReal\":\"" + cUtilitarios.decimalFormato(objVentaDetalle.getPrecioReal(), 2) + "\""
                + ", \"precioProforma\":\"" + cUtilitarios.decimalFormato(objVentaDetalle.getPrecioReal(), 2) + "\""
                + ", \"precioCash\":\"" + cUtilitarios.decimalFormato(objVentaDetalle.getPrecioCash(), 2) + "\""
                + ", \"precioVenta\":\"" + cUtilitarios.decimalFormato(objVentaDetalle.getPrecioVenta(), 2) + "\""
                + ", \"valorVenta\":\"" + cUtilitarios.decimalFormato(objVentaDetalle.getValorVenta(), 2) + "\""
                + ", \"registro\":\"" + cUtilitarios.reemplazarCaracteresEspeciales(objVentaDetalle.getRegistro()) + "\""
                + "}");
    }
    out.print("]");
%>