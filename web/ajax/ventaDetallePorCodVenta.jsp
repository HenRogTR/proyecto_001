<%-- 
    Document   : ventaDetallePorCodVenta
    Created on : 13/06/2014, 11:19:10 PM
    Author     : Henrri
--%>

<%@page import="java.util.Date"%>
<%@page import="tablas.Usuario"%>
<%@page import="Clase.Utilitarios"%>
<%@page import="java.util.List"%>
<%@page import="tablas.VentasDetalle"%>
<%@page import="Ejb.EjbVentaDetalle"%>
<%
    //evitar el acceso directo por el URL
    if (request.getMethod().equals("GET")) {
        out.print("No tiene permisos para ver este enlace.");
        return;
    }
    // ============================ sesi�n =====================================
    //verficar inicio de sesi�n        
    Usuario objUsuario = (Usuario) session.getAttribute("usuario");
    if (objUsuario == null) {
        out.print("La sesi�n se ha cerrado.");
        return;
    }
    //actualizamos ultimo ingreso
    session.setAttribute("fechaAcceso", new Date());
    // ============================ sesi�n =====================================
    //siempre se tendr� un dato v�lido para codigoCliente
    String codVentaString = request.getParameter("codVenta");
    //En caso de que el parametro codCliente no se haya enviado
    if (codVentaString == null) {
        out.print("[Par�metro codVenta no encontrado.]");
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
                + "\"codVentaDetalle\":\"" + new Utilitarios().agregarCerosIzquierda(objVentaDetalle.getCodVentasDetalle(), 8) + "\""
                + ", \"item\":" + objVentaDetalle.getItem()
                //                + "\"codArticuloProducto\":\"" + cUtilitarios.agregarCerosIzquierda(objVentaDetalle.getArticuloProducto().getCodArticuloProducto(), 8) + "\""
                + ", \"cantidad\":" + objVentaDetalle.getCantidad()
                + ", \"descripcion\":\"" + new Utilitarios().reemplazarCaracteresEspeciales(objVentaDetalle.getDescripcion()) + "\""
                + ", \"precioReal\":\"" + new Utilitarios().decimalFormato(objVentaDetalle.getPrecioReal(), 2) + "\""
                + ", \"precioProforma\":\"" + new Utilitarios().decimalFormato(objVentaDetalle.getPrecioReal(), 2) + "\""
                + ", \"precioCash\":\"" + new Utilitarios().decimalFormato(objVentaDetalle.getPrecioCash(), 2) + "\""
                + ", \"precioVenta\":\"" + new Utilitarios().decimalFormato(objVentaDetalle.getPrecioVenta(), 2) + "\""
                + ", \"valorVenta\":\"" + new Utilitarios().decimalFormato(objVentaDetalle.getValorVenta(), 2) + "\""
                + ", \"registro\":\"" + new Utilitarios().reemplazarCaracteresEspeciales(objVentaDetalle.getRegistro()) + "\""
                + "}");
    }
    out.print("]");
%>