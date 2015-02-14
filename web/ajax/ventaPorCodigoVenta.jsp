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
    //siempre se tendr� un dato v�lido para codigoCliente
    String codVentaString = request.getParameter("codVenta");
    //En caso de que el parametro codCliente no se haya enviado
    if (codVentaString == null) {
        out.print("Par�metro codCliente no encontrado.");
        return;
    }
    int codVentaI = Integer.parseInt(codVentaString);
    //Bean
    EjbVenta ejbVenta;
    //Actualizar la venta.
    
    //Obtener venta
%>