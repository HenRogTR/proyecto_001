<%-- 
    Document   : ventasImprimir
    Created on : 15/05/2013, 06:13:33 PM
    Author     : Henrri
--%>
<%@page import="utilitarios.cOtros"%>
<%@page import="utilitarios.cManejoFechas"%>
<%@page import="ventaClases.cVentasDetalle"%>
<%@page import="personaClases.cPersona"%>
<%@page import="tablas.VentaCreditoLetra"%>
<%@page import="tablas.VentasSerieNumero"%>
<%@page import="tablas.VentasDetalle"%>
<%@page import="java.util.Iterator"%>
<%@page import="java.util.ArrayList"%>
<%@page import="java.util.List"%>
<%@page import="tablas.Ventas"%>
<%@page import="tablas.Usuario"%>
<%
    boolean estado = true;
    String mensaje = "";
    String titulo = "No hay ventas";
    cVentasDetalle objcVentasDetalle = new cVentasDetalle();
    List lVentasDetalle = new ArrayList();

    cManejoFechas objcManejoFechas = new cManejoFechas();
    cOtros objcOtros = new cOtros();
    try {
        int codVentas = Integer.parseInt(request.getParameter("codVentas"));
        lVentasDetalle = objcVentasDetalle.leer_ventas_porCodVentas(codVentas);
        if (lVentasDetalle.size() == 0) {
            estado = false;
            mensaje = "No hay venta para ese codigo<br>";
        } else {
            titulo = ((VentasDetalle) lVentasDetalle.iterator().next()).getVentas().getDocSerieNumero() + " " + objcManejoFechas.fechaHoraActualNumerosLineal();
        }
    } catch (NumberFormatException e) {
        estado = false;
        mensaje = "Imposible generar reporte<br>";
        //La cadena no se puede convertir a entero 
    }
    Usuario objUsuario = (Usuario) session.getAttribute("usuario");
    if (objUsuario == null) {
        estado = false;
        mensaje += "Tiene que logearse antes<br>";
    } else {
        if (!objUsuario.getP1() || !objUsuario.getP34()) {
            estado = false;
            mensaje += "No tiene permisos suficientes para acceder a esta pagina<br>";
        }
    }
    if (!estado) {
        out.print(mensaje);
        return;
    }
%>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <title><%=titulo%></title>        
        <link rel="stylesheet" type="text/css" href="ventasImprimir.css" media="screen"/>
        <link rel="stylesheet" type="text/css" href="ventasImprimir.css" media="print"/>
    </head>
    <style>
        /*        td{
                    border: 1px solid #3366ff;
                }
                th{
                    border: 1px solid #3366ff;
                }*/

    </style>    
    <body>
        <%
            Ventas objVentasAux = ((VentasDetalle) lVentasDetalle.get(0)).getVentas();
            int tamanioCuerpo = 480;
        %>
        <div id="documento">
            <div id="contenido">
                <div style="height: 160px; text-align: right; margin-right: 10px;">
                    <label>V. <%=new cPersona().leer_cod(objVentasAux.getPersonaCodVendedor()).getNombres()%></label>
                </div>
                <div id="dCabecera">
                    <table>
                        <tr>
                            <td style="width: 150px;"></td>
                            <td><%=objVentasAux.getCliente()%></td>
                            <td colspan="3" rowspan="2" style="vertical-align: middle; text-align: center; font-size: 14px;font-weight: bold;"><%=objVentasAux.getDocSerieNumero()%></td>
                        </tr>
                        <tr>
                            <td></td>
                        </tr>
                        <tr>
                            <td></td>
                        </tr>
                        <tr>
                            <td></td>
                        </tr>
                        <tr>
                            <td></td>
                        </tr>
                        <tr>
                            <td></td>
                            <td><%=objVentasAux.getDireccion()%></td>
                        </tr>
                        <tr>
                            <td></td>
                        </tr>
                        <tr>
                            <td></td>
                        </tr>
                        <tr>
                            <td></td>
                        </tr>
                        <tr>
                            <td></td>
                        </tr>
                        <tr>
                            <td></td>
                            <td><%=objVentasAux.getIdentificacion()%>
                                <%
                                    if (objVentasAux.getDocSerieNumero().substring(0, 1).equals("F")) {
                                        tamanioCuerpo = 530;
                                    }
                                %>
                            </td>
                            <td style="text-align: left;width: 90px;"><%=objcManejoFechas.dia(objVentasAux.getFecha())%></td>
                            <td style="text-align: right;width: 80px;"><%=objcManejoFechas.mesNombre(objVentasAux.getFecha())%></td>
                            <td style="text-align: right;width: 80px;"><%=objcManejoFechas.anio(objVentasAux.getFecha())%></td>
                        </tr>
                    </table>
                </div>
                <div id="dCuerpo" style="height: <%=tamanioCuerpo%>px;">
                    <table>
                        <%
                            Iterator i = lVentasDetalle.iterator();
                            while (i.hasNext()) {
                                VentasDetalle objVentasDetalle = (VentasDetalle) i.next();
                        %>
                        <tr>
                            <td style="width: 100px;"></td>
                            <td style="width: 50px;"><%=objVentasDetalle.getCantidad()%></td>
                            <td>
                                <%=objVentasDetalle.getDescripcion()%><br>
                                <%
                                    for (VentasSerieNumero objVentasSerieNumero : objVentasDetalle.getVentasSerieNumeros()) {
                                        out.print("&nbsp;&nbsp;" + objVentasSerieNumero.getSerieNumero().replace("\n", "<br>") + ", ");
                                        if (objVentasSerieNumero.getObservacion() != "") {
                                            out.print("&nbsp;&nbsp;" + objcOtros.replace_comillas_comillasD_barraInvertida(objVentasSerieNumero.getObservacion()) + "<br>");
                                        }
                                    }
                                %>
                            </td>
                            <td style="text-align: right;width: 80px;"><%=objcOtros.agregarCerosNumeroFormato(objVentasDetalle.getPrecioVenta(), 2)%></td>
                            <td style="text-align: right;width: 80px;"><%=objcOtros.agregarCerosNumeroFormato(objVentasDetalle.getValorVenta(), 2)%></td>
                        </tr>
                        <%
                            }
                            if (objVentasAux.getTipo().equals("CREDITO")) {
                        %>
                        <tr>
                            <td></td>
                            <td></td>
                            <td style="font-size: 8px;">
                                <%                                    
                                    out.print("<br><br>Incial S/. " + objcOtros.agregarCerosNumeroFormato(objVentasAux.getMontoInicial(), 2) + " ," + objVentasAux.getCantidadLetras() + " Letra(s) de S/. " + objcOtros.agregarCerosNumeroFormato(objVentasAux.getMontoLetra(), 2) + ", Inicio: " + objcManejoFechas.DateAString(objVentasAux.getFechaVencimientoLetraDeuda()));
                                %>
                            </td>
                        </tr>
                        <%                            }

                            if (objVentasAux.getObservacion() != "") {
                        %>
                        <tr>
                            <td style="height: 20px;"></td>
                        </tr>
                        <tr>
                            <td></td>
                            <td></td>
                            <td style="font-weight: bold;">Obs: <%=objVentasAux.getObservacion()%></td>
                        </tr>
                        <%                                    }
                        %>
                    </table>
                </div>
                <div id="dPie">
                    <table>
                        <%
                            if (objVentasAux.getDocSerieNumero().substring(0, 1).equals("B")) {
                        %>
                        <tr>
                            <td style="width: 130px;"></td>
                            <td><%=objVentasAux.getSon()%></td>
                            <td></td>
                            <td style="text-align: right;"><%=objcOtros.agregarCerosNumeroFormato(objVentasAux.getNeto(), 2)%></td>
                        </tr>
                        <%
                            }
                            if (objVentasAux.getDocSerieNumero().substring(0, 1).equals("F")) {
                        %>
                        <tr>
                            <td style="width: 130px;"></td>
                            <td><%=objVentasAux.getSon()%></td>
                            <td></td>
                            <td style="text-align: right;"><%=objcOtros.agregarCerosNumeroFormato(objVentasAux.getSubTotal(), 2)%></td>
                        </tr>
                        <tr>
                            <td></td>
                        </tr>
                        <tr>
                            <td></td>
                        </tr>
                        <tr>
                            <td></td>
                            <td></td>
                            <td></td>
                            <td style="text-align: right;"><%=objcOtros.agregarCerosNumeroFormato(objVentasAux.getValorIgv(), 2)%></td>
                        </tr>
                        <tr>
                            <td></td>
                        </tr>
                        <tr>
                            <td></td>
                        </tr>
                        <tr>
                            <td></td>
                            <td></td>
                            <td></td>
                            <td style="text-align: right;"><%=objcOtros.agregarCerosNumeroFormato(objVentasAux.getNeto(), 2)%></td>
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