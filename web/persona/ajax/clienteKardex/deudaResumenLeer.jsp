<%-- 
    Document   : deudaResumenLeer
    Created on : 05/10/2013, 12:05:11 PM
    Author     : Henrri
--%>
<%@page import="utilitarios.cManejoFechas"%>
<%@page import="java.util.List"%>
<%@page import="otrasTablasClases.cDatosExtras"%>
<%@page import="java.util.Date"%>
<%@page import="personaClases.cDatosCliente"%>
<%@page import="tablas.DatosCliente"%>
<%@page import="utilitarios.cOtros"%>
<%@page import="ventaClases.cVentaCreditoLetra"%>


[
<%
    try {
        int codCliente = Integer.parseInt(request.getParameter("codCliente"));
        cOtros objcOtros = new cOtros();
        Object a[]=new cVentaCreditoLetra().leer_resumen(1); 
        //actualizamos letras pendientes interes
        Date fechaVencimiento = new Date();
        int diaEspera = new cDatosExtras().leer_diaEspera().getEntero();
        Date fechaVencimientoEspera = new cManejoFechas().StringADate(new cManejoFechas().fechaSumarDias(fechaVencimiento, -diaEspera));
        List VCLetra = new cVentaCreditoLetra().leer_cliente_interesSinActualizar(fechaVencimientoEspera, fechaVencimiento, true, codCliente);
        new cVentaCreditoLetra().actualizar_interes(VCLetra, fechaVencimiento);
        
        Object tem[] = new cVentaCreditoLetra().leer_resumen(new cDatosCliente().leer_cod(codCliente).getPersona().getCodPersona());
        out.print("{"
                + "\"mTotal\":\"" + objcOtros.agregarCerosNumeroFormato(objcOtros.redondearDecimales((Double) (tem[0] == null ? 0.00 : tem[0]), 2), 2) + "\""
                + ",\"mAmortizado\":\"" + objcOtros.agregarCerosNumeroFormato(objcOtros.redondearDecimales((Double) (tem[1] == null ? 0.00 : tem[1]), 2), 2) + "\""
                + ",\"mSaldo\":\"" + objcOtros.agregarCerosNumeroFormato(objcOtros.redondearDecimales((Double) (tem[2] == null ? 0.00 : tem[2]), 2), 2) + "\""
                + "}");

    } catch (Exception e) {
    }
%>
]