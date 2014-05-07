<%-- 
    Document   : ventaCreditoLetraResumenMensual
    Created on : 18/11/2013, 09:38:34 AM
    Author     : Henrri
--%>
<%@page import="utilitarios.cManejoFechas"%>
<%@page import="utilitarios.cOtros"%>
<%@page import="personaClases.cDatosCliente"%>
<%@page import="tablas.DatosCliente"%>
<%@page import="java.util.Date"%>
<%@page import="java.util.Iterator"%>
<%@page import="ventaClases.cVentaCreditoLetra"%>
<%@page import="java.util.List"%>


[
<%
    try {
        int codClienteI = Integer.parseInt(request.getParameter("codCliente"));
        DatosCliente objCliente = new cDatosCliente().leer_cod(codClienteI);
        List lVCLResumenMensual = new cVentaCreditoLetra().leer_resumenPagos(objCliente.getPersona().getCodPersona());
        int contador = 0;
        if (lVCLResumenMensual != null) {
            for (Iterator it = lVCLResumenMensual.iterator(); it.hasNext();) {
                Object[] temRP = (Object[]) it.next();
                if (contador++ > 0) {
                    out.print(",");
                }
                out.print(" {"
                        + "\"mesAnio\":\"" + new cManejoFechas().mesNombreCorto((Date) temRP[6]).toUpperCase() + "-" + temRP[1].toString().substring(2, 4) + "\""
                        + ",\"monto\":\"" + new cOtros().decimalFormato(Double.parseDouble(temRP[2].toString()), 2) + "\""
                        + ",\"interes\":\"" + new cOtros().decimalFormato(Double.parseDouble(temRP[3].toString()), 2) + "\""
                        + ",\"pagos\":\"" + new cOtros().decimalFormato(Double.parseDouble(temRP[4].toString()), 2) + "\""
                        + ",\"saldo\":\"" + new cOtros().decimalFormato(Double.parseDouble(temRP[5].toString()), 2) + "\""
                        + "}");
            }
        }
    } catch (Exception e) {

    }
%>
]