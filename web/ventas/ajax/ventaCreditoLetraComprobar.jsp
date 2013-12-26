<%-- 
    Document   : ventaCreditoLetraComprobar
    Created on : 19/11/2013, 07:54:23 PM
    Author     : Henrri
--%>

<%@page import="tablas.VentaCreditoLetra"%>
<%@page import="tablas.VentaCredito"%>
<%@page import="ventaClases.cVenta"%>
<%@page import="tablas.Ventas"%>
<%
    try {
        int codVenta = Integer.parseInt(request.getParameter("codVenta"));
        Ventas objVenta = new cVenta().leer_cod(codVenta);
        String estado = "1";
        VentaCredito objVentaCreditoTemp = null;
        for (VentaCredito objVentaCredito : objVenta.getVentaCreditos()) {
            if (objVentaCredito.getRegistro().substring(0, 1).equals("1")) {
                objVentaCreditoTemp = objVentaCredito;
                for (VentaCreditoLetra objVentaCreditoLetra : objVentaCredito.getVentaCreditoLetras()) {
                    if (objVentaCreditoLetra.getTotalPago() > 0) {
                        estado = "La venta se encuentra con pagos y no se puede editar."
                                + " Elimine los pagos realizados o elija la opción reprogramar.";
                    }
                }
            }
        }
        out.print(estado);
    } catch (Exception e) {
        out.print("Error en parametros");
    }
%>