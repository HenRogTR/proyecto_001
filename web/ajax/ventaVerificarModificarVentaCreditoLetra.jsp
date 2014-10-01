<%-- 
    Document   : ventaVerificarModificarVentaCreditoLetra
    Created on : 23/07/2014, 11:37:05 AM
    Author     : Henrri
--%>

<%@page import="tablas.VentaCreditoLetra"%>
<%@page import="java.util.List"%>
<%@page import="Ejb.EjbVentaCreditoLetra"%>
<%@page import="java.util.Date"%>
<%@page import="tablas.Usuario"%>
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
    String codVentaString = request.getParameter("codVenta");
    //En caso de que el par�metro codCliente no se haya enviado
    if (codVentaString == null) {
        out.print("[Par�metro codVenta no encontrado.]");
        return;
    }
    int codVenta = Integer.parseInt(codVentaString);
    EjbVentaCreditoLetra ejbVentaCreditoLetra;
    //Inicializar
    ejbVentaCreditoLetra = new EjbVentaCreditoLetra();
    //Obtener s�lo activos
    List<VentaCreditoLetra> ventaCreditoLetraList = ejbVentaCreditoLetra.leerActivoPorCodigoVenta(codVenta, true);
    int tam = ventaCreditoLetraList.size();
    for (int i = 0; i < tam; i++) {
        VentaCreditoLetra objVentaCreditoLetra = ventaCreditoLetraList.get(i);
        //Si se ha realizado pago se no se debe editar
        if (objVentaCreditoLetra.getTotalPago() > 0) {
            out.print("La venta se encuentra con pagos y no se puede editar. Elimine los pagos realizados o elija la opci�n reprogramar.");
            return;
        }
    }
    out.print("1");
%>