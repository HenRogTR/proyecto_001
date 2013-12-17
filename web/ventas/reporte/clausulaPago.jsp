<%-- 
    Document   : clausulaPago
    Created on : 13/06/2013, 10:02:16 AM
    Author     : Henrri
--%>
<%@page import="ventaClases.cVentaCredito"%>
<%@page import="otros.cManejoFechas"%>
<%@page import="otros.cNumeroLetra"%>
<%@page import="tablas.VentaCreditoLetra"%>
<%@page import="tablas.VentaCredito"%>
<%@page import="otros.cUtilitarios"%>
<%@page import="tablas.VentasDetalle"%>
<%@page import="tablas.VentasSerieNumero"%>
<%@page import="ventaClases.cVenta"%>
<%@page import="tablas.Ventas"%>
<%
    int codVentas = 0;
    boolean estado = true;
    String mensaje = "";
    Ventas objVentas = new Ventas();
    try {
        codVentas = Integer.parseInt(request.getParameter("codVentas"));
        objVentas = new cVenta().leer_cod(codVentas);
        if (objVentas == null) {
            mensaje = "Venta no encontrada";
            estado = false;
        }
    } catch (Exception e) {
        mensaje = "Error en consulta.";
        estado = false;
    }
%>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <title>Clausula de pago</title>
        <link rel="stylesheet" type="text/css" href="contratoCompraVenta.css" media="print"/>
        <link rel="stylesheet" type="text/css" href="contratoCompraVenta.css" media="screen"/>
        <script type="text/javascript" src="../../lib/jquery/jquery-1.8.1.min.js"></script>
    </head>
    <body>
        <script>
            $(document).ready(function() {
                if ($.browser.chrome) {
                    $('#contenido').css('font-size', 14);
                }
                ;
            });
        </script>
        <div id="documento">
            <div id="contenido">
                <%
                    if (estado) {
                %>
                <div style="height: 100px;">
                </div>
                <div id="dCabecera">
                    <table>
                        <tr>
                            <td style="text-align: center; font-size: 14px;font-weight: bold; letter-spacing: 5px;"><label>CLAUSULA ADICIONAL DE MEDIO DE PAGO</label></td>
                        </tr>
                    </table>
                </div>
                <div id="dCuerpo">
                    <table>
                        <tr>
                            <td style="text-align: justify;">
                                Por el presente documento, Yo <b>MANUEL YUCRA GUTIERREZ</b>, identificado
                                con <b>DNI Nº 00115376</b>, en mi condición de Gerente General de la empresa
                                <b>Importadora Yucra S.A.C.</b> , con <b>RUC Nº 20393594561</b>
                                con domicilio en <b>Jr. Coronel Portillo # 440</b> en calidad de <b>"VENDEDOR"</b>.

                                <br><br>Hago constar, comprador <b>Sr(a). <%=objVentas.getCliente()%></b>
                                identificado con <b>
                                    <%
                                        if (objVentas.getIdentificacion().length() == 11) {
                                            out.print("RUC N°:");
                                        } else {
                                            out.print("DNI N°:");
                                        }
                                    %>
                                    <%=objVentas.getIdentificacion()%></b>                                
                                con domicilio en <b><%=objVentas.getDireccion()%></b>, 
                                quien procede en calidad de <b>"COMPRADOR"</b> mediante Clausula
                                Adicional declaramos:

                                <br><br>Que el medio de pago utilizado por el <b>"COMPRADOR"</b>, sobre la cancelación del comprobante
                                <b><%=objVentas.getDocSerieNumero()%></b>, segun Decreto ley Nº 28194, ha sido la siguiente :
                                <%
                                    if (objVentas.getTipo().equals("CREDITO")) {
                                        VentaCredito objVentaCredito = new cVentaCredito().leer_codVenta(objVentas.getCodVentas());
                                %>
                                <br><br>La forma de Pago al Crédito por un Monto de 
                                <b>S/. <%=new cUtilitarios().agregarCerosNumeroFormato(objVentas.getNeto(), 2)%>
                                    (<%=objVentas.getSon()%>)</b>, ha cancelado una cuota inicial en efectivo
                                de <b>S/. <%=new cUtilitarios().agregarCerosNumeroFormato(objVentaCredito.getMontoInicial(), 2)%></b>, 
                                y el saldo será abonado en :
                                <br><br><%=objVentaCredito.getCantidadLetras()%> Letra(s) a 30 días de 
                                <b>S/. <%=new cUtilitarios().agregarCerosNumeroFormato(objVentaCredito.getMontoLetra(), 2)%> c/u</b>, 
                                los cuales incluyen los intereses, porte y comisiones, por
                                la compra CON RESERVA DE PROPIEDAD DEL VEHICULO:
                                <%
                                } else {
                                %>
                                <br><br>La forma de Pago al Contado; en efectivo, por operaciones en las que no existe obligación de
                                utilizar medios de pago; por la suma de <b>S/. <%=new cUtilitarios().agregarCerosNumeroFormato(objVentas.getNeto(), 2)%></b>, 
                                que hacen el monto total del vehículo:<br><br>
                                <table>
                                    <%                                            }
                                        for (VentasDetalle objVentasDetalle : objVentas.getVentasDetalles()) {
                                            String producto = "";
                                            if (objVentasDetalle.getArticuloProducto().getFamilia().getCodFamilia().equals(4)) {
                                                producto = objVentasDetalle.getDescripcion();
                                            }
                                            for (VentasSerieNumero objVentasSerieNumero : objVentasDetalle.getVentasSerieNumeros()) {
                                    %>
                                    <tr>
                                        <td colspan="2"><b><%=producto%><br> <%=objVentasSerieNumero.getSerieNumero().replace("\n", "<br>")%></b></td>

                                    </tr>
                                    <%
                                        if (!objVentasSerieNumero.getObservacion().equals("")) {
                                    %>
                                    <tr>
                                        <td colspan="2"><%=objVentasSerieNumero.getObservacion().replace("\n", "<br>")%></td>
                                    </tr>
                                    <%
                                                }

                                            }
                                        }
                                    %>
                                </table>
                                <br><br>Formulamos la presente CLAUSULA ADICIONAL en honor a la verdad y que el
                                presente surta los efectos pertinentes. Para mayor constancia legalizamos nuestras 
                                firmas ante Notario Publico.
                            </td>
                        </tr>
                    </table>
                </div>
                <div id="dPie">
                    <table>
                        <tr>
                            <td style="text-align: center;">
                                ___________________________<br>
                                <b>IMPORTADORA YUCRA S.A.C.</b><br>
                                <b>VENDEDOR</b>
                            </td>
                            <td style="text-align: center;">
                                _________________________________<br>
                                <b><%=objVentas.getCliente()%></b><br>
                                <b><%=objVentas.getIdentificacion()%></b><br>
                                <b>COMPRADOR(A)</b>
                            </td>
                        </tr>
                    </table>
                </div>
                <%} else {
                        out.print(mensaje);
                    }
                %>
                <div style="clear: both;"></div>
            </div>
        </div>
    </body>
</html>
