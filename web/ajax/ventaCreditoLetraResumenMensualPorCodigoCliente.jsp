<%-- 
    Document   : ventaCreditoLetraResumenMensualPorCodigoCliente
    Created on : 28/09/2014, 07:57:27 PM
    Author     : Henrri
--%>

<%@page import="Clase.Utilitarios"%>
<%@page import="Clase.Fecha"%>
<%@page import="java.util.List"%>
<%@page import="tablas.VentaCreditoLetra"%>
<%@page import="Ejb.EjbVentaCreditoLetra"%>
<%@page import="Ejb.EjbCliente"%>
<%@page import="java.util.Date"%>
<%@page import="tablas.Usuario"%>
<%@page import="Ejb.EjbUsuario"%>
<%
    //Se hace la llamada al archivo desde cobranza.jsp -> cobranza.js

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
    //Obtener el código enviado por ajax
    String codClienteString = request.getParameter("codCliente");
    //En caso de que el parámetro codCliente no se haya enviado
    if (codClienteString == null) {
        out.print("[Parámetro codCliente no encontrado.]");
        return;
    }
    int codClienteI = Integer.parseInt(codClienteString);
    //Definir bean's
    EjbCliente ejbCliente;
    EjbVentaCreditoLetra ejbVentaCreditoLetra;
    //Inicializar bean
    ejbCliente = new EjbCliente();
    ejbVentaCreditoLetra = new EjbVentaCreditoLetra();
    //Buscar el cliente por id
    ejbCliente.setCliente(ejbCliente.leerPorCodigoClienteActivo(codClienteI, false));
    //si no se encontro con el código dado
    if (ejbCliente.getCliente() == null) {
        out.print("[]");
        return;
    }
    //Leer todos las VCL de un cliente ordenado por fecha de vencimiento
    List<VentaCreditoLetra> ventaCreditoLetraList = ejbVentaCreditoLetra.leerActivoPorCodigoClienteOrdenadoFechaVencimiento(codClienteI, false);
    Date fechaBase = new Fecha().fechaHoraAFecha(new Date());
    ventaCreditoLetraList = ejbVentaCreditoLetra.VCLInteresesActualizados(ventaCreditoLetraList, fechaBase);

    //calcular totoles(sumar) -> por año/mes
    Double capital = 0.00;          //Monto de la deuda capital
    Double interes = 0.00;          //Monto de la deuda interés
    Double capitalPagado = 0.00;    //Monto de capital pagado
    Double interesPagado = 0.00;    //Monto de interés pagado
    Double deudaAcumulada = 0.00;   //Monto de sumar capital + interes
    Double pagoTotal = 0.00;        //Monto de total pagado con el cliente
    Double saldoConInteres = 0.00;  //Monto de saldo con intereses
    Double saldoSinInteres = 0.00;  //Monto de saldo sin tomar interes

    int cont = 0;
    int temMes = -1;//Temp para mes
    int tam = ventaCreditoLetraList.size(); //Tamaño de datos
    VentaCreditoLetra objVentaCreditoLetra = null;
    out.print("[");
    for (int i = 0; i < tam; i++) {     //Iniciando for
        objVentaCreditoLetra = ventaCreditoLetraList.get(i);

        if (i == 0) {
            //Asignar temMes
            temMes = objVentaCreditoLetra.getFechaVencimiento().getMonth();
            //Imprimir la primera parte
            out.print(cont++ > 0 ? ", " : "");
            out.print("{"
                    + "\"mes\":\"" + new Fecha().mesNombreCorto(objVentaCreditoLetra.getFechaVencimiento()).toUpperCase() + "\""
                    + ", \"anio\":\"" + new Fecha().anioCorto(objVentaCreditoLetra.getFechaVencimiento()) + "\""
                    + "");
        }
        //Ver si no se cambia de mes
        if (temMes != objVentaCreditoLetra.getFechaVencimiento().getMonth()) {
            //Imprimir lo restante
            out.print(""
                    + ", \"capital\":\"" + Utilitarios.decimalFormato(capital, 2) + "\""
                    + ", \"interes\":\"" + Utilitarios.decimalFormato(interes, 2) + "\""
                    + ", \"capitalPagado\":\"" + Utilitarios.decimalFormato(capitalPagado, 2) + "\""
                    + ", \"interesPagado\":\"" + Utilitarios.decimalFormato(interesPagado, 2) + "\""
                    + ", \"deudaAcumulada\":\"" + Utilitarios.decimalFormato(deudaAcumulada, 2) + "\""
                    + ", \"pagoTotal\":\"" + Utilitarios.decimalFormato(pagoTotal, 2) + "\""
                    + ", \"saldoConInteres\":\"" + Utilitarios.decimalFormato(saldoConInteres, 2) + "\""
                    + ", \"saldoSinInteres\":\"" + Utilitarios.decimalFormato(saldoSinInteres, 2) + "\""
                    + "}");
            //Prepara para el siguiente
            out.print(cont++ > 0 ? ", " : "");
            out.print("{"
                    + "\"mes\":\"" + new Fecha().mesNombreCorto(objVentaCreditoLetra.getFechaVencimiento()).toUpperCase() + "\""
                    + ", \"anio\":\"" + new Fecha().anioCorto(objVentaCreditoLetra.getFechaVencimiento()) + "\""
                    + "");
            //Reiniciar en 0 los nuevos
            capital = 0.00;          //Monto de la deuda-> capital
            interes = 0.00;          //Monto de la deuda-> interés
            capitalPagado = 0.00;    //Monto de capital pagado
            interesPagado = 0.00;    //Monto de interés pagado
            deudaAcumulada = 0.00;   //Monto de sumar capital + interes
            pagoTotal = 0.00;        //Monto de total pagado con el cliente
            saldoConInteres = 0.00;  //Monto de saldo con intereses
            saldoSinInteres = 0.00;  //Monto de saldo sin tomar interes

            temMes = objVentaCreditoLetra.getFechaVencimiento().getMonth();
        }
        //Calcular totales
        capital += objVentaCreditoLetra.getMonto();
        interes += objVentaCreditoLetra.getInteres();
        capitalPagado += objVentaCreditoLetra.getTotalPago();
        interesPagado += objVentaCreditoLetra.getInteresPagado();
        deudaAcumulada += objVentaCreditoLetra.getMonto() + objVentaCreditoLetra.getInteres();
        pagoTotal += objVentaCreditoLetra.getTotalPago() + objVentaCreditoLetra.getInteresPagado();
        saldoConInteres
                += (objVentaCreditoLetra.getMonto() + objVentaCreditoLetra.getInteres())
                - (objVentaCreditoLetra.getTotalPago() + objVentaCreditoLetra.getInteresPagado());
        saldoSinInteres
                += (objVentaCreditoLetra.getMonto() + objVentaCreditoLetra.getInteresPagado())
                - (objVentaCreditoLetra.getTotalPago() + objVentaCreditoLetra.getInteresPagado());
    }
    out.print(""
            + ", \"capital\":\"" + Utilitarios.decimalFormato(capital, 2) + "\""
            + ", \"interes\":\"" + Utilitarios.decimalFormato(interes, 2) + "\""
            + ", \"capitalPagado\":\"" + Utilitarios.decimalFormato(capitalPagado, 2) + "\""
            + ", \"interesPagado\":\"" + Utilitarios.decimalFormato(interesPagado, 2) + "\""
            + ", \"deudaAcumulada\":\"" + Utilitarios.decimalFormato(deudaAcumulada, 2) + "\""
            + ", \"pagoTotal\":\"" + Utilitarios.decimalFormato(pagoTotal, 2) + "\""
            + ", \"saldoConInteres\":\"" + Utilitarios.decimalFormato(saldoConInteres, 2) + "\""
            + ", \"saldoSinInteres\":\"" + Utilitarios.decimalFormato(saldoSinInteres, 2) + "\""
            + "}");
    out.print("]");
%>