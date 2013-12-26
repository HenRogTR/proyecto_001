<%-- 
    Document   : ventaCredito
    Created on : 26/12/2013, 10:10:11 AM
    Author     : Henrri
--%>

<%@page import="tablas.VentaCreditoLetra"%>
<%@page import="java.util.Iterator"%>
<%@page import="utilitarios.cManejoFechas"%>
<%@page import="utilitarios.cOtros"%>
<%@page import="ventaClases.cVentaCreditoLetra"%>
<%@page import="ventaClases.cVentaCredito"%>
<%@page import="java.util.List"%>
<%@page import="tablas.VentaCredito"%>

<%
    int codVenta = 0;
    VentaCredito objVentaCredito = null;
    List VCLList = null;
    try {
        codVenta = Integer.parseInt(request.getParameter("codVenta"));
        objVentaCredito = new cVentaCredito().leer_codVenta(codVenta);
        VCLList = new cVentaCreditoLetra().leer_porCodVenta(codVenta);
    } catch (Exception e) {
        out.print("[]");
        return;
    }
%>
[
<%
    cOtros objcOtros = new cOtros();
    cManejoFechas objcManejoFechas = new cManejoFechas();
    if (objVentaCredito != null & VCLList != null) {
        String ventaCreditoLetra = "";
        for (Iterator it = VCLList.iterator(); it.hasNext();) {
            VentaCreditoLetra objVentaCreditoLetra = (VentaCreditoLetra) it.next();
            ventaCreditoLetra += "<tr>"
                    + "<td style=\"width: 33%;\">" + objVentaCreditoLetra.getDetalleLetra() + "</td>"
                    + "<td style=\"width: 34%; padding-left: 20px;\">" + objcManejoFechas.DateAString(objVentaCreditoLetra.getFechaVencimiento()) + "</td>"
                    + "<td class=\"derecha\" style=\"padding-right: 20px;\">" + objcOtros.agregarCerosNumeroFormato(objVentaCreditoLetra.getMonto(), 2) + "</td>"
                    + "</tr>";
        }
        out.print("{"
                + "\"codVentaCredito\":" + objVentaCredito.getCodVentaCredito()
                + ", \"estado\":" + objVentaCredito.getEstado()
                + ", \"duracion\":\"" + objVentaCredito.getDuracion() + "\""
                + ", \"montoInicial\":\"" + objcOtros.agregarCerosNumeroFormato(objVentaCredito.getMontoInicial(), 2) + "\""
                + ", \"fechaInicial\":\"" + objcManejoFechas.DateAString(objVentaCredito.getFechaInicial()) + "\""
                + ", \"cantidadLetras\":" + objVentaCredito.getCantidadLetras()
                + ", \"montoLetra\":\"" + objcOtros.agregarCerosNumeroFormato(objVentaCredito.getMontoLetra(), 2) + "\""
                + ", \"fechaVencimientoLetra\":\"" + objcManejoFechas.DateAString(objVentaCredito.getFechaVencimientoLetra()) + "\""
                + ", \"ventaCreditoLetra\":\"" + objcOtros.replace_comillas_comillasD_barraInvertida(ventaCreditoLetra) + "\""
                + "}");
    }
%>
]