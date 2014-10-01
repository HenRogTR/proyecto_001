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
    // ============================ sesión =====================================
    //verficar inicio de sesión        
    Usuario objUsuario = (Usuario) session.getAttribute("usuario");
    if (objUsuario == null) {
        out.print("La sesión se ha cerrado.");
        return;
    }
    //actualizamos ultimo ingreso
    session.setAttribute("fechaAcceso", new Date());
    // ============================ sesión =====================================
    String codVentaString = request.getParameter("codVenta");
    //En caso de que el parámetro codCliente no se haya enviado
    if (codVentaString == null) {
        out.print("[Parámetro codVenta no encontrado.]");
        return;
    }
    int codVenta = Integer.parseInt(codVentaString);
    EjbVentaCreditoLetra ejbVentaCreditoLetra;
    //Inicializar
    ejbVentaCreditoLetra = new EjbVentaCreditoLetra();
    //Obtener sólo activos
    List<VentaCreditoLetra> ventaCreditoLetraList = ejbVentaCreditoLetra.leerActivoPorCodigoVenta(codVenta, true);
    int tam = ventaCreditoLetraList.size();
    for (int i = 0; i < tam; i++) {
        VentaCreditoLetra objVentaCreditoLetra = ventaCreditoLetraList.get(i);
        //Si se ha realizado pago se no se debe editar
        if (objVentaCreditoLetra.getTotalPago() > 0) {
            out.print("La venta se encuentra con pagos y no se puede editar. Elimine los pagos realizados o elija la opción reprogramar.");
            return;
        }
    }
    out.print("1");
%>