<%-- 
    Document   : ventaCreditoLetraResumenPorCodCliente
    Created on : 17/06/2014, 04:35:51 PM
    Author     : Henrri
--%>

<%@page import="clases.cFecha"%>
<%@page import="clases.cUtilitarios"%>
<%@page import="java.util.Date"%>
<%@page import="java.util.List"%>
<%@page import="Ejb.EjbVentaCreditoLetra"%>
<%
    //evitar el acceso directo por el URL
    if (request.getMethod().equals("GET")) {
        out.print("No tiene permisos para ver este enlace.");
        return;
    }
    EjbVentaCreditoLetra ejbVentaCreditoLetra;
    //siempre se tendrá un dato válido para codigoCliente
    String codClienteString = request.getParameter("codCliente");
    //En caso de que el parametro codCliente no se haya enviado
    if (codClienteString == null) {
        out.print("[Parámetro codCliente no encontrado.]");
        return;
    }
    int codCliente = Integer.parseInt(codClienteString);
    //iniciando session bean
    ejbVentaCreditoLetra = new EjbVentaCreditoLetra();
    //obteniendo resumen
    List<Object[]> ventaCreditoLetraObjects = ejbVentaCreditoLetra.leerResumenPorCodigoCliente(codCliente);
    //definir variables (por año/mes)
    Date fechaVencimiento = null;
    Double monto = 0.00;
    Double interes = 0.00;
    Double totalPago = 0.00;
    Double interesPagado = 0.00;
    //calcular totoles (por año/mes)
    Double deudaCliente = 0.00;
    Double pagoCliente = 0.00;
    Double saldoCliente = 0.00;
    //ventaList no puede tomar valor null
    int tam = ventaCreditoLetraObjects.size();
    //recorriendo array
    out.print("[");
    for (int i = 0; i < tam; i++) {
        Object[] VCLResumen = ventaCreditoLetraObjects.get(i);
        fechaVencimiento = (Date) VCLResumen[0];
        monto = (Double) VCLResumen[1];
        interes = (Double) VCLResumen[2];
        totalPago = (Double) VCLResumen[3];
        interesPagado = (Double) VCLResumen[4];
        deudaCliente = monto + interes;
        pagoCliente = totalPago + interesPagado;
        saldoCliente = deudaCliente - pagoCliente;
        if (i > 0) {
            out.print(", ");
        }
        out.print("{"
                + "\"mes\":\"" + cFecha.mesNombreCorto(fechaVencimiento).toUpperCase() + "\""
                + ", \"anio\":\"" + cFecha.anioCorto(fechaVencimiento) + "\""
                + ", \"fechaVencimiento\":\"" + cFecha.dateAString(fechaVencimiento) + "\""
                + ", \"monto\":\"" + cUtilitarios.decimalFormato(monto, 2) + "\""
                + ", \"interes\":\"" + cUtilitarios.decimalFormato(interes, 2) + "\""
                + ", \"totalPago\":\"" + cUtilitarios.decimalFormato(totalPago, 2) + "\""
                + ", \"interesPagado\":\"" + cUtilitarios.decimalFormato(interesPagado, 2) + "\""
                + ", \"deudaCliente\":\"" + cUtilitarios.decimalFormato(deudaCliente, 2) + "\""
                + ", \"pagoCliente\":\"" + cUtilitarios.decimalFormato(pagoCliente, 2) + "\""
                + ", \"saldoCliente\":\"" + cUtilitarios.decimalFormato(saldoCliente, 2) + "\""
                + "}");
    }
    out.print("]");
%>