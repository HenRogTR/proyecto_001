<%-- 
    Document   : ventaCreditoLetraPorCodVenta.jsp
    Created on : 13/06/2014, 10:38:45 AM
    Author     : Henrri
--%>

<%@page import="Clase.Utilitarios"%>
<%@page import="Clase.Fecha"%>
<%@page import="java.util.List"%>
<%@page import="Ejb.EjbVentaCreditoLetra"%>
<%@page import="java.util.Date"%>
<%@page import="tablas.VentaCreditoLetra"%>
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
    Double deudaLetraSinInteres = 0.00;
    Double pagoLetra = 0.00;
    Double saldoLetra = 0.00;
    Double saldoLetraSinInteres = 0.00;
    int diaRetraso = 0;
    //ventaList no puede tomar valor null
    int tam = ventaCreditoLetraList.size();
    out.print("[");
    for (int i = 0; i < tam; i++) {
        VentaCreditoLetra objVentaCreditoLetra = ventaCreditoLetraList.get(i);
        //obtenemos la deuda del cliente
        deudaLetra = objVentaCreditoLetra.getMonto() + objVentaCreditoLetra.getInteres();
        deudaLetraSinInteres = objVentaCreditoLetra.getMonto() + objVentaCreditoLetra.getInteresPagado();
        //pagos realizados a la letra
        pagoLetra = objVentaCreditoLetra.getTotalPago() + objVentaCreditoLetra.getInteresPagado();
        //saldo de la letra con intereses
        saldoLetra = deudaLetra - pagoLetra;
        saldoLetraSinInteres = deudaLetraSinInteres - pagoLetra;
        //calculado dias de retraso
        diaRetraso = new Fecha().diasDiferencia(new Date(), objVentaCreditoLetra.getFechaVencimiento());
        if (i > 0) {
            out.print(", ");
        }
        out.print("{"
                + "\"codVentaCreditoLetra\":\"" + new Utilitarios().agregarCerosIzquierda(objVentaCreditoLetra.getCodVentaCreditoLetra(), 8) + "\""
                + ", \"numeroLetra\":" + objVentaCreditoLetra.getNumeroLetra()
                + ", \"detalleLetra\":\"" + new Utilitarios().reemplazarCaracteresEspeciales(objVentaCreditoLetra.getDetalleLetra()) + "\""
                + ", \"fechaVencimiento\":\"" + new Fecha().dateAString(objVentaCreditoLetra.getFechaVencimiento()) + "\""
                + ", \"monto\":\"" + new Utilitarios().decimalFormato(objVentaCreditoLetra.getMonto(), 2) + "\""
                + ", \"interes\":\"" + new Utilitarios().decimalFormato(objVentaCreditoLetra.getInteres(), 2) + "\""
                + ", \"fechaPago\":\"" + new Fecha().dateAString(objVentaCreditoLetra.getFechaPago()) + "\""
                + ", \"totalPago\":\"" + new Utilitarios().decimalFormato(objVentaCreditoLetra.getTotalPago(), 2) + "\""
                + ", \"interesPagado\":\"" + new Utilitarios().decimalFormato(objVentaCreditoLetra.getInteresPagado(), 2) + "\""
                + ", \"interesUltimoCalculo\":\"" + new Fecha().dateAString(objVentaCreditoLetra.getInteresUltimoCalculo()) + "\""
                + ", \"deudaLetra\":\"" + new Utilitarios().decimalFormato(deudaLetra, 2) + "\""
                + ", \"deudaLetraSinInteres\":\"" + new Utilitarios().decimalFormato(deudaLetraSinInteres, 2) + "\""
                + ", \"pagoLetra\":\"" + new Utilitarios().decimalFormato(pagoLetra, 2) + "\""
                + ", \"saldoLetra\":\"" + new Utilitarios().decimalFormato(saldoLetra, 2) + "\""
                + ", \"saldoLetraSinInteres\":\"" + new Utilitarios().decimalFormato(saldoLetraSinInteres, 2) + "\""
                + ", \"registro\":\"" + objVentaCreditoLetra.getRegistro() + "\""
                + ", \"diaRetraso\":" + diaRetraso
                + "}");
    }
    out.print("]");
%>