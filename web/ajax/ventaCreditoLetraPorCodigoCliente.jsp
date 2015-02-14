<%-- 
    Document   : ventaCreditoLetraPorCodigoCliente
    Created on : 27/09/2014, 04:33:43 PM
    Author     : Henrri
    Descripción: Retorna objetos ajax, las cuales muestran los datos de cuotas
                 de pagos actualizados.
--%>

<%@page import="java.util.List"%>
<%@page import="tablas.VentaCreditoLetra"%>
<%@page import="Clase.Fecha"%>
<%@page import="Clase.Utilitarios"%>
<%@page import="Ejb.EjbVentaCreditoLetra"%>
<%@page import="Ejb.EjbCliente"%>
<%@page import="java.util.Date"%>
<%@page import="tablas.Usuario"%>
<%@page import="Ejb.EjbUsuario"%>
<%
    //****corregir****
    //evitar el acceso directo por el URL
//    if (request.getMethod().equals("GET")) {
//        out.print("No tiene permisos para ver este enlace.");
//        return;
//    }
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
    //Leer todos las VCL de un cliente ordenado por venta.
    List<VentaCreditoLetra> ventaCreditoLetraList = ejbVentaCreditoLetra.leerActivoPorCodigoCliente(codClienteI, false);
    //Obtener la lista con los créditos actualizados
    Date fechaBase = new Fecha().fechaHoraAFecha(new Date());
    ventaCreditoLetraList = ejbVentaCreditoLetra.VCLInteresesActualizados(ventaCreditoLetraList, fechaBase);
//    ventaCreditoLetraList = ejbVentaCreditoLetra.VCLInteresesActualizados(ventaCreditoLetraList, new Date());
    //variables para calcular datos
    Double deudaLetra = 0.00;
    Double deudaLetraSinInteres = 0.00;
    Double pagoLetra = 0.00;
    Double saldoLetra = 0.00;
    Double saldoLetraSinInteres = 0.00;
    int diaRetraso = 0;
    String margen = "";
    int codVenta = 0;

    int tam = ventaCreditoLetraList.size(); //Tamaño de datos
    int cont = 0; //temporal para imprimir coma
    out.print("[");
    for (int i = 0; i < tam; i++) {     //Iniciando for
        out.print(cont++ > 0 ? "," : "");   //A partir de segunda iteración imprimir coma
        VentaCreditoLetra objVentaCreditoLetra = ventaCreditoLetraList.get(i);
        //
        String dias = "";
        String estilo = "";
        if (codVenta != objVentaCreditoLetra.getVentas().getCodVentas()) {
            codVenta = objVentaCreditoLetra.getVentas().getCodVentas();
            margen = "finalVenta";
        } else {
            margen = "";
        }
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
        //Obteniendo fondo de letra
        if (saldoLetra > 0 & diaRetraso > 0) {
            dias = String.valueOf(diaRetraso);
            estilo = "tomato";
        }
        if (saldoLetra > 0 & objVentaCreditoLetra.getNumeroLetra() == 0) {
            estilo = "tomato";
        }
        if (saldoLetra > 0 & diaRetraso < 0 & diaRetraso > -6) {
            estilo = "#ffcccc";
        }
        out.print("{"
                + "  \"codVentaCreditoLetra\":" + objVentaCreditoLetra.getCodVentaCreditoLetra()
                + ", \"numeroLetra\":\"" + objVentaCreditoLetra.getNumeroLetra() + "\""
                + ", \"detalleLetra\":\"" + Utilitarios.reemplazarCaracteresEspeciales(objVentaCreditoLetra.getDetalleLetra()) + "\""
                + ", \"fechaVencimiento\":\"" + new Fecha().dateAString(objVentaCreditoLetra.getFechaVencimiento()) + "\""
                + ", \"monto\":\"" + Utilitarios.decimalFormato(objVentaCreditoLetra.getMonto(), 2) + "\""
                + ", \"interes\":\"" + Utilitarios.decimalFormato(objVentaCreditoLetra.getInteres(), 2) + "\""
                + ", \"fechaPago\":\"" + new Fecha().dateAString(objVentaCreditoLetra.getFechaPago()) + "\""
                + ", \"totalPago\":\"" + Utilitarios.decimalFormato(objVentaCreditoLetra.getTotalPago() + objVentaCreditoLetra.getInteresPagado(), 2) + "\""
                + ", \"interesPagado\":\"" + Utilitarios.decimalFormato(objVentaCreditoLetra.getInteresPagado(), 2) + "\""
                + ", \"interesUltimoCalculo\":\"" + new Fecha().dateAString(objVentaCreditoLetra.getInteresUltimoCalculo()) + "\""
                + ", \"deudaLetra\":\"" + Utilitarios.decimalFormato(deudaLetra, 2) + "\""
                + ", \"deudaLetraSinInteres\":\"" + Utilitarios.decimalFormato(deudaLetraSinInteres, 2) + "\""
                + ", \"pagoLetra\":\"" + new Utilitarios().decimalFormato(pagoLetra, 2) + "\""
                + ", \"saldoLetra\":\"" + new Utilitarios().decimalFormato(saldoLetra, 2) + "\""
                + ", \"saldoLetraSinInteres\":\"" + new Utilitarios().decimalFormato(saldoLetraSinInteres, 2) + "\""
                + ", \"registro\":\"" + objVentaCreditoLetra.getRegistro() + "\""
                + ", \"diaRetraso\":\"" + dias + "\""
                + ", \"estilo\":\"" + estilo + "\""
                + ", \"finalVenta\":\"" + margen + "\""
                + ", \"codVenta\":" + objVentaCreditoLetra.getVentas().getCodVentas()
                + ", \"docNumeroSerie\":\"" + objVentaCreditoLetra.getVentas().getDocSerieNumero() + "\""
                + "}");

    }   //Fin for de lista
    out.print("]");
%>