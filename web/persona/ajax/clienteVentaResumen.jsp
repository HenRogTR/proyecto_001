<%-- 
    Document   : clienteVentaResumen
    Created on : 23/08/2013, 08:20:51 PM
    Author     : Henrri***
--%>


<%@page import="utilitarios.cOtros"%>
<%@page import="java.util.Date"%>
<%@page import="utilitarios.cManejoFechas"%>
<%@page import="java.util.Iterator"%>
<%@page import="java.util.List"%>
<%@page import="ventaClases.cVenta"%>
<%
    int codPersona = 0;
    try {
        codPersona = Integer.parseInt(request.getParameter("codPersona"));
    } catch (Exception e) {
        out.print("[]");
        return;
    }
    out.print("[");
    cVenta objcVentas = new cVenta();
    cManejoFechas objcManejoFechas = new cManejoFechas();
    cOtros objcOtros = new cOtros();
    List lVentaResumen = objcVentas.leer_ventaResumen_codPersona(codPersona);
    if (lVentaResumen != null) {
        int contador = 0;
        Iterator iVentaResumen = lVentaResumen.iterator();
        while (iVentaResumen.hasNext()) {
            if (contador++ > 0) {
                out.print(",");
            }
            Object oVentaResumen[] = (Object[]) iVentaResumen.next();
            out.print("{"
                    + "\"codVenta\":\"" + oVentaResumen[0] + "\""
                    + ",\"fecha\":\"" + objcManejoFechas.DateAString((Date) oVentaResumen[1]) + "\""
                    + ",\"tipo\":\"" + oVentaResumen[2] + "\""
                    + ",\"docSerieNumero\":\"" + oVentaResumen[3] + "\""
                    + ",\"neto\":\"" + (oVentaResumen[6].toString().substring(0, 1).equals("1")?objcOtros.decimalFormato((Double) oVentaResumen[4], 2):"ANULADO") + "\""
                    + ",\"vendedor\":\"" + oVentaResumen[5] + "\""
                    + "}");
        }
    }
    out.print("]");
%>
