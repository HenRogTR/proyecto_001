<%-- 
    Document   : ventasDetalle
    Created on : 30/05/2013, 10:53:18 AM
    Author     : Henrri
--%>

<%@page import="tablas.VentasDetalle"%>
<%@page import="java.util.Iterator"%>
<%@page import="otros.cUtilitarios"%>
<%@page import="ventaClases.cVentasDetalle"%>
<%@page import="java.util.ArrayList"%>
<%@page import="java.util.List"%>
<%
    boolean estado = true;
    String mensaje = "";
    int codVentas = 0;
    List lVentasDetalle = new ArrayList();
    cVentasDetalle objcVentasDetalle = new cVentasDetalle();
    try {
        codVentas = Integer.parseInt(request.getParameter("codVentas"));
        lVentasDetalle = objcVentasDetalle.leer_ventasDetalle_porCodVentas(codVentas);
        if (lVentasDetalle == null) {
            estado = false;
            mensaje = "Error en consulta";
        }
    } catch (Exception e) {
        estado = false;
        mensaje = "Error en consulta";
    }
    if (!estado) {
        out.print("[]");
        return;
    }
    cUtilitarios objcUtilitarios = new cUtilitarios();
    int cont = 0;
    Iterator iVentasDetalle = lVentasDetalle.iterator();
    out.print("[");
    while (iVentasDetalle.hasNext()) {
        VentasDetalle objVentasDetalle = (VentasDetalle) iVentasDetalle.next();
        if (cont++ > 0) {
            out.print(",");
        }
        out.print("{"
                + "\"item\":" + objVentasDetalle.getItem()
                + ",\"codArticuloProducto\":\"" + objcUtilitarios.agregarCeros_int(objVentasDetalle.getArticuloProducto().getCodArticuloProducto(), 8) + "\""
                + ",\"cantidad\":" + objVentasDetalle.getCantidad()
                + ",\"unidadMedida\":\"" + objVentasDetalle.getArticuloProducto().getUnidadMedida() + "\""
                + ",\"descripcion\":\"" + objcUtilitarios.replace_comillas_comillasD_barraInvertida(objVentasDetalle.getDescripcion()) + "\""
                + ",\"precioVenta\":\"" + objcUtilitarios.agregarCerosNumeroFormato(objVentasDetalle.getPrecioVenta(), 2) + "\""
                + ",\"valorVenta\":\"" + objcUtilitarios.agregarCerosNumeroFormato(objVentasDetalle.getValorVenta(), 2) + "\""
                + "}");
    }
    out.print("]");
%>
