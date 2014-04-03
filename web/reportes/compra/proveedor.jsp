<%-- 
    Document   : proveedor
    Created on : 27/03/2014, 05:47:02 PM
    Author     : Henrri
--%>
<%@page import="compraClases.cCompra"%>
<%@page import="java.util.List"%>
<%@page import="utilitarios.cManejoFechas"%>
<%@page import="utilitarios.cValidacion"%>
<%@page import="java.util.Date"%>
<%@page import="tablas.Proveedor"%>
<%
    String tituloString = " r. comprados ";
    String cabeceraString = "";
    String orden = "";

    String fechaInicioString = "";
    String fechaFinString = "";
    Date fechaInicioDate = null;
    Date fechaFinDate = null;
    List compraList = null;
    cCompra objcCompra = new cCompra();
    Integer codProveedor = 0;
    Proveedor objProveedor = null;

    try {
        fechaInicioString = request.getParameter("fechaInicio").toString();
        fechaFinString = request.getParameter("fechaFin").toString();
        if (!(new cValidacion().validarFecha(fechaInicioString)) || !(new cValidacion().validarFecha(fechaFinString))) {
            out.print("Fecha y/o formato de fecha incorrecta.");
            return;
        }
        fechaInicioDate = new cManejoFechas().StringADate(fechaInicioString);
        fechaFinDate = new cManejoFechas().StringADate(fechaFinString);
        if (fechaInicioDate.compareTo(fechaFinDate) > 0) {
            out.print("Las fechas estan fuera de rango.");
            return;
        }
    } catch (Exception e) {
        out.print("Fechas no encontradas.");
        return;
    }

    if (compraList == null) {
        out.print(" list -> null. <br>Error -> " + objcCompra.getError());
        return;
    }
%>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <title>JSP Page</title>
    </head>
    <body>
        <h1>Hello World!</h1>
    </body>
</html>
