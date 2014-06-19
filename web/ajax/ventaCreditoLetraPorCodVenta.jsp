<%-- 
    Document   : ventaCreditoLetraPorCodVenta.jsp
    Created on : 13/06/2014, 10:38:45 AM
    Author     : Henrri
--%>


<%@page import="clases.cUtilitarios"%>
<%@page import="java.util.List"%>
<%@page import="Ejb.EjbVentaCreditoLetra"%>
<%@page import="java.util.Date"%>
<%@page import="tablas.VentaCreditoLetra"%>
<%@page import="clases.cFecha"%>
<%
    //evitar el acceso directo por el URL
    if (request.getMethod().equals("GET")) {
        out.print("No tiene permisos para ver este enlace.");
        return;
    }
    //obtenemos el codVenta
    String codVentaString = request.getParameter("codVenta");
    //En caso de que el parametro codCliente no se haya enviado
    if (codVentaString == null) {
        out.print("[Parámetro codVenta no encontrado.]");
        return;
    }
    int codVenta = Integer.parseInt(codVentaString);
    //iniciando interface
    EjbVentaCreditoLetra ejbVentaCreditoLetra = new EjbVentaCreditoLetra();
    //Recuperando lista            
    List<VentaCreditoLetra> ventaCreditoLetraList = ejbVentaCreditoLetra.leerActivoPorCodigoVenta(codVenta, true);
    //variables para calcular datos
    Double deudaLetra = 0.00;
    Double pagoLetra = 0.00;
    Double saldoLetra = 0.00;
    int diaRetraso = 0;
    //ventaList no puede tomar valor null
    int tam = ventaCreditoLetraList.size();
    out.print("[");
    for (int i = 0; i < tam; i++) {
        VentaCreditoLetra objVentaCreditoLetra = ventaCreditoLetraList.get(i);
        //obtenemos la deuda del cliente
        deudaLetra = objVentaCreditoLetra.getMonto() + objVentaCreditoLetra.getInteres();
        //pagos realizados a la letra
        pagoLetra = objVentaCreditoLetra.getTotalPago() + objVentaCreditoLetra.getInteresPagado();
        //saldo de la letra
        saldoLetra = deudaLetra - pagoLetra;
        //calculado dias de retraso
        diaRetraso = cFecha.diasDiferencia(new Date(), objVentaCreditoLetra.getFechaVencimiento());
        if (i > 0) {
            out.print(", ");
        }
        out.print("{"
                + "\"codVentaCreditoLetra\":\"" + cUtilitarios.agregarCerosIzquierda(objVentaCreditoLetra.getCodVentaCreditoLetra(), 8) + "\""
                + ", \"numeroLetra\":" + objVentaCreditoLetra.getNumeroLetra()
                + ", \"detalleLetra\":\"" + cUtilitarios.reemplazarCaracteresEspeciales(objVentaCreditoLetra.getDetalleLetra()) + "\""
                + ", \"fechaVencimiento\":\"" + cFecha.dateAString(objVentaCreditoLetra.getFechaVencimiento()) + "\""
                + ", \"monto\":\"" + cUtilitarios.decimalFormato(objVentaCreditoLetra.getMonto(), 2) + "\""
                + ", \"interes\":\"" + cUtilitarios.decimalFormato(objVentaCreditoLetra.getInteres(), 2) + "\""
                + ", \"fechaPago\":\"" + cFecha.dateAString(objVentaCreditoLetra.getFechaPago()) + "\""
                + ", \"totalPago\":\"" + cUtilitarios.decimalFormato(objVentaCreditoLetra.getTotalPago(), 2) + "\""
                + ", \"interesPagado\":\"" + cUtilitarios.decimalFormato(objVentaCreditoLetra.getInteresPagado(), 2) + "\""
                + ", \"interesUltimoCalculo\":\"" + cFecha.dateAString(objVentaCreditoLetra.getInteresUltimoCalculo()) + "\""
                + ", \"deudaLetra\":\"" + cUtilitarios.decimalFormato(deudaLetra, 2) + "\""
                + ", \"pagoLetra\":\"" + cUtilitarios.decimalFormato(pagoLetra, 2) + "\""
                + ", \"saldoLetra\":\"" + cUtilitarios.decimalFormato(saldoLetra, 2) + "\""
                + ", \"registro\":\"" + objVentaCreditoLetra.getRegistro() + "\""
                + ", \"diaRetraso\":" + diaRetraso
                + "}");
    }
    out.print("]");
%>