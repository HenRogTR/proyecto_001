<%-- 
    Document   : ventaPorCodigoVenta
    Created on : 15/10/2014, 11:42:56 AM
    Author     : Henrri
--%>

<%@page import="Ejb.EjbVenta"%>
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
    //siempre se tendrá un dato válido para codigoCliente
    String codVentaString = request.getParameter("codVenta");
    //En caso de que el parametro codCliente no se haya enviado
    if (codVentaString == null) {
        out.print("Parámetro codCliente no encontrado.");
        return;
    }
    int codVentaI = Integer.parseInt(codVentaString);
    //Bean
    EjbVenta ejbVenta;
    //Actualizar la venta.
    
    //Obtener venta
%>