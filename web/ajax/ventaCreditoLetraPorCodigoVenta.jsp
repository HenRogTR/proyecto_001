<%-- 
    Document   : ventaCreditoLetraPorCodigoVenta
    Created on : 30/09/2014, 10:17:20 AM
    Author     : Henrri
--%>

<%@page import="Clase.Utilitarios"%>
<%@page import="Clase.Fecha"%>
<%@page import="tablas.VentaCreditoLetra"%>
<%@page import="java.util.List"%>
<%@page import="Ejb.EjbVentaCreditoLetra"%>
<%@page import="java.util.Date"%>
<%@page import="tablas.Usuario"%>
<%@page import="Ejb.EjbUsuario"%>
<%
    //Se hace la llamada al archivo desde clienteKardex.jsp -> clienteKardex.js

    //****corregir****
    //evitar el acceso directo por el URL
    if (request.getMethod().equals("GET")) {
        out.print("No tiene permisos para ver este enlace.");
        return;
    }
    //verficar inicio de sesión
    EjbUsuario ejbUsuario = new EjbUsuario();
    ejbUsuario.setUsuario((Usuario) session.getAttribute("usuario"));
    if (ejbUsuario.getUsuario() == null) {  //Verificar que haya sesión iniciada.
        out.print("La sesión se ha cerrado.");
        return;
    }
    //actualizamos ultimo ingreso
    session.setAttribute("fechaAcceso", new Date());
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
    List<VentaCreditoLetra> ventaCreditoLetraList = ejbVentaCreditoLetra.leerActivoPorCodigoVentaActivo(codVenta, true);
    Date fechaBase = new Fecha().fechaHoraAFecha(new Date());
    ventaCreditoLetraList = ejbVentaCreditoLetra.VCLInteresesActualizados(ventaCreditoLetraList, fechaBase);
    //Variables
    int diaRetraso = 0;
    Double deudaAcumulada = 0.00;   //Monto de sumar capital + interes
    Double deudaAcumualdaSinInteres = 0.00;   //Monto se sumar capital + intereses pagados
    Double pagoTotal = 0.00;        //Monto de total pagado con el cliente
    Double saldoConInteres = 0.00;  //Monto de saldo con intereses
    Double saldoSinInteres = 0.00;  //Monto de saldo sin tomar interes
    //ventaList no puede tomar valor null
    int tam = ventaCreditoLetraList.size();
    out.print("[");
    for (int i = 0; i < tam; i++) {
        VentaCreditoLetra objVentaCreditoLetra = ventaCreditoLetraList.get(i);
        //Calcular totales
        deudaAcumulada = objVentaCreditoLetra.getMonto() + objVentaCreditoLetra.getInteres();
        deudaAcumualdaSinInteres = objVentaCreditoLetra.getMonto() + objVentaCreditoLetra.getInteresPagado();
        pagoTotal = objVentaCreditoLetra.getTotalPago() + objVentaCreditoLetra.getInteresPagado();
        saldoConInteres
                = (objVentaCreditoLetra.getMonto() + objVentaCreditoLetra.getInteres())
                - (objVentaCreditoLetra.getTotalPago() + objVentaCreditoLetra.getInteresPagado());
        saldoSinInteres
                = (objVentaCreditoLetra.getMonto() + objVentaCreditoLetra.getInteresPagado())
                - (objVentaCreditoLetra.getTotalPago() + objVentaCreditoLetra.getInteresPagado());
        //calculado dias de retraso
        diaRetraso = new Fecha().diasDiferencia(fechaBase, objVentaCreditoLetra.getFechaVencimiento());
        if (i > 0) {
            out.print(", ");
        }
        out.print("{"
                + " \"codVentaCreditoLetra\":\"" + Utilitarios.agregarCerosIzquierda(objVentaCreditoLetra.getCodVentaCreditoLetra(), 8) + "\""
                + ", \"numeroLetra\":" + objVentaCreditoLetra.getNumeroLetra()
                + ", \"detalleLetra\":\"" + Utilitarios.reemplazarCaracteresEspeciales(objVentaCreditoLetra.getDetalleLetra()) + "\""
                + ", \"fechaVencimiento\":\"" + new Fecha().dateAString(objVentaCreditoLetra.getFechaVencimiento()) + "\""
                + ", \"monto\":\"" + Utilitarios.decimalFormato(objVentaCreditoLetra.getMonto(), 2) + "\""
                + ", \"interes\":\"" + Utilitarios.decimalFormato(objVentaCreditoLetra.getInteres(), 2) + "\""
                + ", \"fechaPago\":\"" + new Fecha().dateAString(objVentaCreditoLetra.getFechaPago()) + "\""
                + ", \"totalPago\":\"" + Utilitarios.decimalFormato(objVentaCreditoLetra.getTotalPago(), 2) + "\""
                + ", \"interesPagado\":\"" + Utilitarios.decimalFormato(objVentaCreditoLetra.getInteresPagado(), 2) + "\""
                + ", \"interesUltimoCalculo\":\"" + new Fecha().dateAString(objVentaCreditoLetra.getInteresUltimoCalculo()) + "\""
                + ", \"deudaLetra\":\"" + Utilitarios.decimalFormato(deudaAcumulada, 2) + "\""
                + ", \"deudaLetraSinInteres\":\"" + Utilitarios.decimalFormato(deudaAcumualdaSinInteres, 2) + "\""
                + ", \"pagoLetra\":\"" + Utilitarios.decimalFormato(pagoTotal, 2) + "\""
                + ", \"saldoLetra\":\"" + Utilitarios.decimalFormato(saldoConInteres, 2) + "\""
                + ", \"saldoLetraSinInteres\":\"" + Utilitarios.decimalFormato(saldoSinInteres, 2) + "\""
                + ", \"registro\":\"" + objVentaCreditoLetra.getRegistro() + "\""
                + ", \"diaRetraso\":" + diaRetraso
                + "}");
    }
    out.print("]");
%>