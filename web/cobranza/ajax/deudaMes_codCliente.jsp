<%-- 
    Document   : deudaMes_codCliente
    Created on : 16/04/2014, 04:06:34 PM
    Author     : Henrri
--%>
<%@page import="otrasTablasClases.cDatosExtras"%>
<%@page import="utilitarios.cOtros"%>
<%@page import="utilitarios.cManejoFechas"%>
<%@page import="java.util.Date"%>
<%@page import="java.util.Iterator"%>
<%@page import="java.util.List"%>
<%@page import="ventaClases.cVentaCreditoLetra"%>

[
<%
    try {
        int codCliente = Integer.parseInt(request.getParameter("codCliente"));
        //actualizamos letras pendientes interes.
        Date fechaBase = new Date();
        int diaEspera = new cDatosExtras().leer_diaEspera().getEntero();
        Date fechaVencimientoEspera = new cManejoFechas().StringADate(new cManejoFechas().fechaSumarDias(fechaBase, -diaEspera));
        List VCLetra = new cVentaCreditoLetra().leer_cliente_interesSinActualizar(fechaVencimientoEspera, fechaBase, true, codCliente);
        new cVentaCreditoLetra().actualizar_interes(VCLetra, fechaBase);

        List lDeudaMes = new cVentaCreditoLetra().leer_deudaMes(codCliente);
        int cont = 0;
        Date fechaVencimiento = null;
        Double monto = 0.00;
        Double interes = 0.00;
        Double totalPago = 0.00;
        Double interesPagado = 0.00;
        Double totalPagado = 0.00;

        for (Iterator it = lDeudaMes.iterator(); it.hasNext();) {
            Object dato[] = (Object[]) it.next();
            fechaVencimiento = (Date) dato[0];
            monto = (Double) dato[1];
            interes = (Double) dato[2];
            totalPago = (Double) dato[3];
            interesPagado = (Double) dato[4];
            totalPagado = totalPago + interesPagado;
            //recalcular intereses ya que no se jala lo actualizado
            if (cont++ > 0) {
                out.print(", ");
            }
            out.print("{"
                    + "\"anioMes\":\"" + cManejoFechas.mesNombreCorto(fechaVencimiento).toUpperCase() + "-" + new cManejoFechas().anioCorto(fechaVencimiento) + "\""
                    + ", \"monto\":\"" + new cOtros().decimalFormato(monto + interes, 2) + "\""
                    + ", \"interes\":\"" + new cOtros().decimalFormato(interes, 2) + "\""
                    + ", \"totalPago\":\"" + new cOtros().decimalFormato(totalPagado, 2) + "\""
                    + ", \"saldo\":\"" + new cOtros().decimalFormato((monto + interes) - totalPagado, 2) + "\""
                    + ", \"fechaVencimiento\":\"" + new cManejoFechas().DateAString(fechaVencimiento) + "\""
                    + "}");
        }
    } catch (Exception e) {

    }
%>
]