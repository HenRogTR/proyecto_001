<%-- 
    Document   : venta_codCliente
    Created on : 20/05/2014, 11:59:13 AM
    Author     : Henrri
--%>
<%@page import="ventaClases.cVentaCreditoLetra"%>
<%@page import="java.util.List"%>
<%@page import="utilitarios.cManejoFechas"%>
<%@page import="otrasTablasClases.cDatosExtras"%>
<%@page import="java.util.Date"%>

[
<%
    int codCliente = 0;
    try {
        codCliente = Integer.parseInt(request.getParameter("codCliente"));
        //actualizamos intereses
        Date fechaVencimiento = new Date();
        int diaEspera = new cDatosExtras().leer_diaEspera().getEntero();
        Date fechaVencimientoEspera = new cManejoFechas().StringADate(new cManejoFechas().fechaSumarDias(fechaVencimiento, -diaEspera));
        List VCLetra = new cVentaCreditoLetra().leer_cliente_interesSinActualizar(fechaVencimientoEspera, fechaVencimiento, true, codCliente);
        new cVentaCreditoLetra().actualizar_interes(VCLetra, fechaVencimiento);

        
    } catch (Exception e) {

    }
%>
]