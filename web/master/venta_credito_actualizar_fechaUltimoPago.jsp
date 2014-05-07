<%-- 
    Document   : venta_credito_letra_actualizar
    Created on : 02/12/2013, 12:20:22 PM
    Author     : Henrri
--%>


<%@page import="tablas.VentaCreditoLetra"%>
<%@page import="java.util.Iterator"%>
<%@page import="ventaClases.cVentaCreditoLetra"%>
<%@page import="java.util.List"%>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <title>...</title>
    </head>
    <body>
        <%
            List VCLetraList = new cVentaCreditoLetra().leer();
            for (Iterator it = VCLetraList.iterator(); it.hasNext();) {
                VentaCreditoLetra objVCL = (VentaCreditoLetra) it.next();
                out.print(new cVentaCreditoLetra().actualizar_fechaUltimoPago(objVCL.getCodVentaCreditoLetra())+"<br>");
            }
        %>
    </body>
</html>
