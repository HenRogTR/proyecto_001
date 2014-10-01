<%-- 
    Document   : ventaCredito
    Created on : 26/12/2013, 10:10:11 AM
    Author     : Henrri
--%>

<%@page import="Clase.Utilitarios"%>
<%@page import="Clase.Fecha"%>
<%@page import="tablas.VentaCreditoLetra"%>
<%@page import="java.util.List"%>
<%@page import="tablas.Ventas"%>
<%@page import="Ejb.EjbVenta"%>
<%@page import="Ejb.EjbVentaCreditoLetra"%>
<%@page import="java.util.Date"%>
<%@page import="tablas.Usuario"%>
<%
    //corregir* hay que modificar esto
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
    String codVentaString = request.getParameter("codVenta");
    //En caso de que el par�metro codCliente no se haya enviado
    if (codVentaString == null) {
        out.print("[Par�metro codVenta no encontrado.]");
        return;
    }
    int codVenta = Integer.parseInt(codVentaString);
    //Llamar
    EjbVentaCreditoLetra ejbVentaCreditoLetra;
    EjbVenta ejbVenta;
    //Fin llamada
    ejbVenta = new EjbVenta();
    Ventas objVenta = ejbVenta.leerPorCodigo(codVenta, true);
    //Obtener s�lo activos
    ejbVentaCreditoLetra = new EjbVentaCreditoLetra();
    List<VentaCreditoLetra> ventaCreditoLetraList = ejbVentaCreditoLetra.leerActivoPorCodigoVenta(codVenta, true);
    int tam = ventaCreditoLetraList.size();
%>
[
<%
    String ventaCreditoLetraTemp = "";
    for (int i = 0; i < tam; i++) {
        VentaCreditoLetra objVentaCreditoLetra = ventaCreditoLetraList.get(i);
        ventaCreditoLetraTemp += "<tr>"
                + "<td style=\"width: 33%;\">" + objVentaCreditoLetra.getDetalleLetra() + "</td>"
                + "<td style=\"width: 34%; padding-left: 20px;\">" + new Fecha().dateAString(objVentaCreditoLetra.getFechaVencimiento()) + "</td>"
                + "<td class=\"derecha\" style=\"padding-right: 20px;\">" + Utilitarios.decimalFormato(objVentaCreditoLetra.getMonto(), 2) + "</td>"
                + "</tr>";
    }
    out.print("{"
            + "\"codVentaCredito\":" + 1
            + ", \"duracion\":\"" + objVenta.getDuracion() + "\""
            + ", \"montoInicial\":\"" + Utilitarios.decimalFormato(objVenta.getMontoInicial(), 2) + "\""
            + ", \"fechaInicial\":\"" + new Fecha().dateAString(objVenta.getFechaInicialVencimiento()) + "\""
            + ", \"cantidadLetras\":" + objVenta.getCantidadLetras()
            + ", \"montoLetra\":\"" + Utilitarios.decimalFormato(objVenta.getMontoLetra(), 2) + "\""
            + ", \"fechaVencimientoLetra\":\"" + new Fecha().dateAString(objVenta.getFechaVencimientoLetraDeuda()) + "\""
            + ", \"ventaCreditoLetra\":\"" + Utilitarios.reemplazarCaracteresEspeciales(ventaCreditoLetraTemp) + "\""
            + "}");
%>
]