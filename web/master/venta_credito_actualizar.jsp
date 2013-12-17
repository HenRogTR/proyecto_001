<%-- 
    Document   : venta_credito_letra_actualizar
    Created on : 02/12/2013, 12:20:22 PM
    Author     : Henrri
--%>


<%@page import="utilitarios.cManejoFechas"%>
<%@page import="utilitarios.cOtros"%>
<%@page import="java.util.Date"%>
<%@page import="tablas.VentaCreditoLetra"%>
<%@page import="tablas.VentaCredito"%>
<%@page import="java.util.Iterator"%>
<%@page import="ventaClases.cVentaCredito"%>
<%@page import="java.util.List"%>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <title>...</title>
    </head>
    <body>
        <%
            List l = new cVentaCredito().leer_admin();
            for (Iterator it = l.iterator(); it.hasNext();) {
                VentaCredito obj = (VentaCredito) it.next();
        %>
        Actualizando... <%=obj.getVentas().getDocSerieNumero()%> 
        <%
            Date fechaInicial = null;
            Double montoLetra = 0.00;
            String duracion = "";
            Date fechaVencimientoLetra = null;
            int a = 0;
            for (VentaCreditoLetra objVentaCreditoLetra : obj.getVentaCreditoLetras()) {
                if (objVentaCreditoLetra.getNumeroLetra() == 0) {
                    fechaInicial = objVentaCreditoLetra.getFechaVencimiento();
                }
                if (objVentaCreditoLetra.getNumeroLetra() == 1) {
                    montoLetra = objVentaCreditoLetra.getMonto();
                    fechaVencimientoLetra = objVentaCreditoLetra.getFechaVencimiento();
                    a = objVentaCreditoLetra.getDetalleLetra().indexOf("(S)");
                    if (a != -1) {
                        duracion = "semanal";
                    } else {
                        a = objVentaCreditoLetra.getDetalleLetra().indexOf("(Q)");
                        if (a != -1) {
                            duracion = "quincenal";
                        } else {
                            duracion = "mensual";
                        }
                    }
                }
            }
            out.print("Estado: " + new cVentaCredito().actualizar_fechaInicial_montoLetra(obj.getCodVentaCredito(), fechaInicial, montoLetra, duracion, fechaVencimientoLetra));
        %>
        // Fecha Inicial -> <%=new cManejoFechas().DateAString(fechaInicial)%> // monto letra -> <%=new cOtros().agregarCerosNumeroFormato(montoLetra, 2)%> // duracion -> <%=duracion%>
        <br>
        <%
            }
        %>
    </body>
</html>
