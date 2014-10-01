<%-- 
    Document   : vclrm
    Created on : 26/08/2013, 10:01:58 AM
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
%>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <title>Resumen pagos</title>
        <link rel="stylesheet" type="text/css" href="../librerias/principal/bodyPrint.css" media="screen"/>
        <link rel="stylesheet" type="text/css" href="../librerias/principal/bodyPrint.css" media="print"/>
    </head>
    <body>
        <div id="documento">
            <div id="contenido">
                <table class="tabla-imprimir" style="width: 600px;">
                    <thead>
                        <tr class="bottom2">
                            <th class="izquierda" colspan="5" style="padding-left: 20px;"><%=new Utilitarios().agregarCerosIzquierda(codClienteI, 8)%> - <%=ejbCliente.getCliente().getPersona().getNombresC()%></th>
                        </tr>
                        <tr class="bottom2">
                            <th class="centrado ancho120px">MES/AÑO</th>
                            <th class="centrado ancho120px">TOTAL MES</th>
                            <th style="" class="centrado">TOTAL INTERÉS(*)</th>
                            <th class="centrado ancho120px">TOTAL PAGOS</th>
                            <th class="centrado ancho120px">TOTAL SALDO</th>
                        </tr>
                    </thead>
                    <tbody>
                        <%
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
                            //Genereal
                            Double capitalTotal = 0.00;
                            Double interesTotal = 0.00;
                            Double pagoTotalTotal = 0.00;
                            Double saldoConInteresTotal = 0.00;

                            int temMes = -1;//Temp para mes
                            int tam = ventaCreditoLetraList.size(); //Tamaño de datos
                            VentaCreditoLetra objVentaCreditoLetra = null;
                            for (int i = 0; i < tam; i++) {     //Iniciando for
                                objVentaCreditoLetra = ventaCreditoLetraList.get(i);

                                if (i == 0) {
                                    //Asignar temMes
                                    temMes = objVentaCreditoLetra.getFechaVencimiento().getMonth();
                                    //Imprimir la primera parte
%>
                        <tr>
                            <td style="text-align: right;padding-right: 20px;">
                                <%=new Fecha().mesNombreCorto(objVentaCreditoLetra.getFechaVencimiento()).toUpperCase() + "-" + new Fecha().anioCorto(objVentaCreditoLetra.getFechaVencimiento())%>
                            </td>
                            <%
//                                    out.print("{"
//                                            + "\"mes\":\"" + new Fecha().mesNombreCorto(objVentaCreditoLetra.getFechaVencimiento()).toUpperCase() + "\""
//                                            + ", \"anio\":\"" + new Fecha().anioCorto(objVentaCreditoLetra.getFechaVencimiento()) + "\""
//                                            + "");
                                }
                                //Ver si no se cambia de mes
                                if (temMes != objVentaCreditoLetra.getFechaVencimiento().getMonth()) {
                                    //Imprimir lo restante
%>
                            <td style="text-align: right;padding-right: 20px;"><%=Utilitarios.decimalFormato(capital, 2)%></td>
                            <td style="text-align: right;padding-right: 20px;"><%=new Utilitarios().decimalFormato(interes, 2)%></td>
                            <td style="text-align: right;padding-right: 20px;"><%=new Utilitarios().decimalFormato(pagoTotal, 2)%></td>
                            <td style="text-align: right;padding-right: 20px;"><%=new Utilitarios().decimalFormato(saldoConInteres, 2)%></td>
                        </tr>
                        <%
//                            out.print(""
//                                    + ", \"capital\":\"" + Utilitarios.decimalFormato(capital, 2) + "\""
//                                    + ", \"interes\":\"" + Utilitarios.decimalFormato(interes, 2) + "\""
//                                    + ", \"capitalPagado\":\"" + Utilitarios.decimalFormato(capitalPagado, 2) + "\""
//                                    + ", \"interesPagado\":\"" + Utilitarios.decimalFormato(interesPagado, 2) + "\""
//                                    + ", \"deudaAcumulada\":\"" + Utilitarios.decimalFormato(deudaAcumulada, 2) + "\""
//                                    + ", \"pagoTotal\":\"" + Utilitarios.decimalFormato(pagoTotal, 2) + "\""
//                                    + ", \"saldoConInteres\":\"" + Utilitarios.decimalFormato(saldoConInteres, 2) + "\""
//                                    + ", \"saldoSinInteres\":\"" + Utilitarios.decimalFormato(saldoSinInteres, 2) + "\""
//                                    + "}");
                            //Prepara para el siguiente
%>
                        <tr>
                            <td style="text-align: right;padding-right: 20px;">
                                <%=new Fecha().mesNombreCorto(objVentaCreditoLetra.getFechaVencimiento()).toUpperCase() + "-" + new Fecha().anioCorto(objVentaCreditoLetra.getFechaVencimiento())%>
                            </td>
                            <%
//                                    out.print("{"
//                                            + "\"mes\":\"" + new Fecha().mesNombreCorto(objVentaCreditoLetra.getFechaVencimiento()).toUpperCase() + "\""
//                                            + ", \"anio\":\"" + new Fecha().anioCorto(objVentaCreditoLetra.getFechaVencimiento()) + "\""
//                                            + "");
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
                                    //Calcular general
                                    capitalTotal += objVentaCreditoLetra.getMonto();
                                    interesTotal += objVentaCreditoLetra.getInteres();
                                    pagoTotalTotal += objVentaCreditoLetra.getTotalPago() + objVentaCreditoLetra.getInteresPagado();
                                    saldoConInteresTotal
                                            += (objVentaCreditoLetra.getMonto() + objVentaCreditoLetra.getInteres())
                                            - (objVentaCreditoLetra.getTotalPago() + objVentaCreditoLetra.getInteresPagado());
                                }
                            %>
                            <td style="text-align: right;padding-right: 20px;"><%=Utilitarios.decimalFormato(capital, 2)%></td>
                            <td style="text-align: right;padding-right: 20px;"><%=new Utilitarios().decimalFormato(interes, 2)%></td>
                            <td style="text-align: right;padding-right: 20px;"><%=new Utilitarios().decimalFormato(pagoTotal, 2)%></td>
                            <td style="text-align: right;padding-right: 20px;"><%=new Utilitarios().decimalFormato(saldoConInteres, 2)%></td>
                        </tr>
                        <%
//                            out.print(""
//                                    + ", \"capital\":\"" + Utilitarios.decimalFormato(capital, 2) + "\""
//                                    + ", \"interes\":\"" + Utilitarios.decimalFormato(interes, 2) + "\""
//                                    + ", \"capitalPagado\":\"" + Utilitarios.decimalFormato(capitalPagado, 2) + "\""
//                                    + ", \"interesPagado\":\"" + Utilitarios.decimalFormato(interesPagado, 2) + "\""
//                                    + ", \"deudaAcumulada\":\"" + Utilitarios.decimalFormato(deudaAcumulada, 2) + "\""
//                                    + ", \"pagoTotal\":\"" + Utilitarios.decimalFormato(pagoTotal, 2) + "\""
//                                    + ", \"saldoConInteres\":\"" + Utilitarios.decimalFormato(saldoConInteres, 2) + "\""
//                                    + ", \"saldoSinInteres\":\"" + Utilitarios.decimalFormato(saldoSinInteres, 2) + "\""
//                                    + "}");
                        %>
                        <tr class="top2 bottom2">
                            <th class="centrado">T. GENERAL</th>
                            <th style="text-align: right;padding-right: 20px;"><%=new Utilitarios().decimalFormato(capitalTotal, 2)%></th>
                            <th style="text-align: right;padding-right: 20px;"><%=new Utilitarios().decimalFormato(interesTotal, 2)%></th>
                            <th style="text-align: right;padding-right: 20px;"><%=new Utilitarios().decimalFormato(pagoTotalTotal, 2)%></th>
                            <th style="text-align: right;padding-right: 20px;"><%=new Utilitarios().decimalFormato(saldoConInteresTotal, 2)%></th>
                        </tr>
                        <tr>
                            <td colspan="5" class="derecha" style="font-size: 10px; padding-right: 20px;"><%=new Fecha().fechaHora(new Date()).toUpperCase()%></td>
                        </tr>
                        <tr>
                            <td colspan="5">
                                <div style="font-size: 10px; padding-left: 20px;">
                                    (*)Intereses calculados al día actual, con el cliente afectado a pago de intereses.
                                </div>
                            </td>
                        </tr>
                    </tbody>
                </table>
            </div>
        </div>
    </body>
</html>
