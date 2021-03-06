<%-- 
    Document   : ventaCreditoLetraResumenPorCodCliente
    Created on : 17/06/2014, 04:35:51 PM
    Author     : Henrri
--%>

<%@page import="tablas.Usuario"%>
<%@page import="Clase.Utilitarios"%>
<%@page import="Clase.Fecha"%>
<%@page import="java.util.Date"%>
<%@page import="java.util.List"%>
<%@page import="Ejb.EjbVentaCreditoLetra"%>
<%
    //evitar el acceso directo por el URL
    if (request.getMethod().equals("GET")) {
        out.print("No tiene permisos para ver este enlace.");
        return;
    }
    // ============================ sesi�n =====================================
    //verficar inicio de sesi�n        
    Usuario objUsuario = (Usuario) session.getAttribute("usuario");
    if (objUsuario == null) {
        out.print("La sesi�n se ha cerrado.");
        return;
    }
    //actualizamos ultimo ingreso
    session.setAttribute("fechaAcceso", new Date());
    // ============================ sesi�n =====================================
    EjbVentaCreditoLetra ejbVentaCreditoLetra;
    //siempre se tendr� un dato v�lido para codigoCliente
    String codClienteString = request.getParameter("codCliente");
    //En caso de que el parametro codCliente no se haya enviado
    if (codClienteString == null) {
        out.print("[Par�metro codCliente no encontrado.]");
        return;
    }
    int codCliente = Integer.parseInt(codClienteString);
    //iniciando session bean
    ejbVentaCreditoLetra = new EjbVentaCreditoLetra();
    //obteniendo resumen
    List<Object[]> ventaCreditoLetraObjects = ejbVentaCreditoLetra.leerResumenPorCodigoCliente(codCliente);
    //definir variables (por a�o/mes)
    Date fechaVencimiento = null;
    Double monto = 0.00;
    Double interes = 0.00;
    Double totalPago = 0.00;
    Double interesPagado = 0.00;
    //calcular totoles (por a�o/mes)
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
                + "\"mes\":\"" + new Fecha().mesNombreCorto(fechaVencimiento).toUpperCase() + "\""
                + ", \"anio\":\"" + new Fecha().anioCorto(fechaVencimiento) + "\""
                + ", \"fechaVencimiento\":\"" + new Fecha().dateAString(fechaVencimiento) + "\""
                + ", \"monto\":\"" + new Utilitarios().decimalFormato(monto, 2) + "\""
                + ", \"interes\":\"" + new Utilitarios().decimalFormato(interes, 2) + "\""
                + ", \"totalPago\":\"" + new Utilitarios().decimalFormato(totalPago, 2) + "\""
                + ", \"interesPagado\":\"" + new Utilitarios().decimalFormato(interesPagado, 2) + "\""
                + ", \"deudaCliente\":\"" + new Utilitarios().decimalFormato(deudaCliente, 2) + "\""
                + ", \"pagoCliente\":\"" + new Utilitarios().decimalFormato(pagoCliente, 2) + "\""
                + ", \"saldoCliente\":\"" + new Utilitarios().decimalFormato(saldoCliente, 2) + "\""
                + "}");
    }
    out.print("]");
%>