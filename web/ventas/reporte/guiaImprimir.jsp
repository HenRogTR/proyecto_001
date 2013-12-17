<%-- 
    Document   : guiaImprimir
    Created on : 10/12/2013, 05:19:12 PM
    Author     : Henrri
--%>


<%@page import="tablas.VentasSerieNumero"%>
<%@page import="tablas.VentasDetalle"%>
<%@page import="java.util.Iterator"%>
<%@page import="utilitarios.cManejoFechas"%>
<%@page import="ventaClases.cVentasDetalle"%>
<%@page import="java.util.List"%>
<%@page import="utilitarios.cOtros"%>
<%@page import="ventaClases.cVenta"%>
<%@page import="tablas.Ventas"%>
<%@page import="tablas.Usuario"%>
<%
    //ver permisos
    Usuario objUsuario = (Usuario) session.getAttribute("usuario");
    if (objUsuario == null) {//que haya sesion iniciada
        out.print("Primero inicie sesión");
        return;
    } else {
        if (!objUsuario.getP31()) {//tener el permiso respectivo
            out.print("No tiene permiso para imprimir guía.");
            return;
        }
    }
    int codVenta = 0;
    Ventas objVenta = null;
    cOtros objcOtros = new cOtros();
    try {
        codVenta = (Integer) session.getAttribute("codVentaMantenimiento");
        objVenta = new cVenta().leer_cod(codVenta);
        if (objcOtros.replace_comillas_comillasD_barraInvertida(objVenta.getDocSerieNumeroGuia()).trim().equals("")) {
            out.print("Guia no adjuntada");
            return;
        }
    } catch (Exception e) {
        return;
    }
    List lVD = new cVentasDetalle().leer_ventas_porCodVentas(objVenta.getCodVentas());
    cManejoFechas objcManejoFechas = new cManejoFechas();
%>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <title><%=objVenta.getDocSerieNumero()%> Guía-> <%=objVenta.getDocSerieNumeroGuia()%></title>
        <link rel="stylesheet" type="text/css" href="guiaImprimir.css" media="screen"/>
        <link rel="stylesheet" type="text/css" href="guiaImprimir.css" media="print"/>        
    </head>
    <body>
        <div id="documento">
            <div id="contenido">
                <div style="padding-left: 180px; padding-top: 140px; height:210px; ">
                    <table>
                        <tr>
                            <td style="height: 30px; width: 540px"><%=objcManejoFechas.DateAString(objVenta.getFecha())%></td>
                        </tr>
                        <tr>
                            <td style="height: 30px;"><%=objVenta.getDireccion2()%></td>
                            <td></td>
                            <td style="font-size: 14px; font-weight: bold;"><%=objVenta.getDocSerieNumeroGuia()%></td>
                        </tr>
                        <tr>
                            <td style="height: 30px;"><%=objVenta.getCliente()%></td>
                        </tr>
                        <tr>
                            <td style="height: 40px;"><%=objVenta.getPersona().getRuc()%></td>
                            <td><%=objVenta.getPersona().getDniPasaporte()%></td>
                        </tr>
                        <tr>
                            <td>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;<%=objVenta.getDireccion3()%></td>
                        </tr>
                    </table>
                </div>
                <div style="padding-left: 50px;">
                    <table>
                        <%
                            for (Iterator it = lVD.iterator(); it.hasNext();) {
                                VentasDetalle objVentasDetalle = (VentasDetalle) it.next();
                        %>
                        <tr>
                            <td style="width: 70px; text-align: right"><%=objVentasDetalle.getCantidad()%>&nbsp;&nbsp;</td>
                            <td style="width: 80px; text-align: right"><%=objVentasDetalle.getArticuloProducto().getUnidadMedida().toUpperCase()%>&nbsp;</td>
                            <td style="width: 80px; text-align: right"><%=objcOtros.agregarCeros_int(objVentasDetalle.getArticuloProducto().getCodArticuloProducto(), 8)%>&nbsp</td>
                            <td style="padding-left: 30px;">
                                <%=objVentasDetalle.getDescripcion()%>
                                <%
                                    if (objVentasDetalle.getArticuloProducto().getUsarSerieNumero()) {
                                %>
                                <div style="padding-left: 20px;">
                                    <%
                                        for (VentasSerieNumero objVentasSerieNumero : objVentasDetalle.getVentasSerieNumeros()) {
                                            out.print(objcOtros.replace_comillas_comillasD_barraInvertida(objVentasSerieNumero.getSerieNumero())+"&nbsp;&nbsp; , ");
                                        }
                                    %>
                                </div>
                                <%
                                    }
                                %>
                            </td>
                        </tr>
                        <%
                            }
                        %>
                    </table>
                </div>
            </div>                
        </div>
    </body>
</html>
