<%-- 
    Document   : contratoCompraVenta
    Created on : 11/06/2013, 06:52:39 PM
    Author     : Henrri
--%>


<%@page import="utilitarios.cManejoFechas"%>
<%@page import="utilitarios.cNumeroLetra"%>
<%@page import="utilitarios.cOtros"%>
<%@page import="tablas.VentaCreditoLetra"%>
<%@page import="tablas.VentaCredito"%>
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
        <title>Contrato CompraVenta</title>
        <link rel="stylesheet" type="text/css" href="contratoCompraVenta.css" media="print"/>
        <link rel="stylesheet" type="text/css" href="contratoCompraVenta.css" media="screen"/>
        <script type="text/javascript" src="../../librerias/jquery/jquery-1.8.1.min.js"></script>
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
                            <td style="text-align: center; font-size: 14px;font-weight: bold; letter-spacing: 5px;"><label>CONTRATO PRIVADO DE COMPRA Y VENTA</label></td>
                        </tr>
                    </table>
                </div>
                <div id="dCuerpo">
                    <table>
                        <tr>
                            <td style="text-align: justify;">
                                Conste por el presente documento privado de compra y venta que celebran 
                                de una parte como vendedor: la Empresa <b>Importadora Yucra S.A.C.</b>, representado por su 
                                gerente general <b>Sr. MANUEL YUCRA GUTIERREZ</b> , Identificado con 
                                <b>DNI N°: 00115376</b>, con domicilio legal en Pucallpa, 
                                provincia de Coronel Portillo departamento de Ucayali, 
                                y de la otra parte como comprador(a) <b>Sr(a). <%=objVentas.getCliente()%></b>
                                identificado con <b>
                                    <%
                                        if (objVentas.getIdentificacion().length() == 11) {
                                            out.print("RUC N°:");
                                        } else {
                                            out.print("DNI N°:");
                                        }
                                    %>
                                    <%=objVentas.getIdentificacion()%></b>  
                                con domicilio legal en <b><%=objVentas.getDireccion()%></b> bajo las cláusulas siguientes:<br>
                                <br><b>PRIMERO:</b><br>
                                El vendedor declara ser legítimo propietario, <b>VEHICULO MENOR CON LAS SIGUIENTES
                                    CARACTERISTICAS:</b><br>
                                <table>
                                    <tr>
                                        <td style="width: 200px;">PLACA:</td>
                                        <td>EN TRÁMITE</td>
                                    </tr>
                                    <tr>
                                        <td>CLASE:</td>
                                        <td>VEH-AUT-MEN</td>
                                    </tr>
                                    <tr>
                                        <td>PROPIETARIO:</td>
                                        <td>IMPORTADORA YUCRA</td>
                                    </tr>
                                    <%
                                        for (VentasDetalle objVentasDetalle : objVentas.getVentasDetalles()) {
                                            for (VentasSerieNumero objVentasSerieNumero : objVentasDetalle.getVentasSerieNumeros()) {
                                    %>
                                    <tr>
                                        <td colspan="2"><%=objVentasSerieNumero.getSerieNumero().replace("\n", "<br>")%></td>

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
                                <br><b>SEGUNDO:</b><br>
                                Por el presente documento el citado vendedor en uso de sus propios derechos 
                                da en calidad de venta real y enajenación perpetua y transferencia definitiva a través
                                del comprador los productos antes señalados.
                                <br><br><b>TERCERO:</b><br>
                                El Comprador se compromete a cancelar el precio pactado por el total de 
                                <b>S/. <%=new cOtros().decimalFormato(objVentas.getNeto(), 2)%> <%=objVentas.getSon()%></b><br>
                                <%
                                    if (objVentas.getTipo().equals("CREDITO")) {
                                        VentaCredito objVentaCredito = objVentas.getVentaCreditos().iterator().next();
                                %>
                                <br>En <b><%=objVentaCredito.getCantidadLetras()%></b> cuota(s) mensuales por el valor de <b>S/. <%=new cOtros().decimalFormato(objVentaCredito.getMontoLetra(), 2)%></b> mensual(es) con 
                                INICIAL de <b>S/. <%=new cOtros().decimalFormato(objVentaCredito.getMontoInicial(), 2)%></b>.

                                <br><br><b>CUARTO:</b> De las responsabilidades.-<br> 
                                <b>“EL (LOS) COMPRADOR (ES)”</b> y/o <b>“EL (LOS) FIADORES)”,</b> 
                                quedan como únicos responsables por cualquier tipo 
                                de daños que a la propiedad o a terceros pudiera(n) 
                                ocasionar con el vehículo materia de este contrato 
                                a partir de la fecha de suscripción del presente documento;
                                asimismo, cualquier deterioro o daño que sufra el 
                                vehículo en cuestión después de la suscripción del 
                                presente documento, será de responsabilidad de 
                                <b>“EL (LOS) COMPRADOR (ES)”</b> y/o <b>“EL (LOS) FIADOR(ES)”.</b>
                                En el caso que la desaparición sea parcial o total 
                                <b>“EL (LOS) COMPRADOR (ES)”</b> y <b>“EL (LOS) FIADOR (ES)”</b> 
                                se verá (n) obligado (s) a continuar efectuando 
                                los pagos de la cuotas a que se obligó con 
                                <b>“EL VENDEDOR”</b>, hasta completar el precio total del vehículo.
                                Igualmente, a partir de la fecha de suscripción 
                                del presente contrato, <b>“EL (LOS) COMPRADORES (ES)”</b>
                                y/o <b>“EL (LOS) FIADOR (ES)”</b>, asumen la responsabilidad
                                por el pago que se origine de cualquier multa 
                                infracción que provenga de cualquier acción 
                                efectuada con el vehículo materia del presente contrato,
                                de forma que <b>“EL VENDEDOR”</b> queda total 
                                y absolutamente liberada de cualquier obligación o
                                responsabilidad que se derive de estos hechos, 
                                así como de cualquier responsabilidad civil, 
                                penal administrativa.
                                <div style="height: 200px;">
                                </div>
                                <br><br><b>QUINTO.-</b><br> <b>“EL (LOS) COMPRADOR (ES)”</b> 
                                autoriza(n) al <b>“EL VENDEDOR”</b> que ante el 
                                incumplimiento de sesenta días de la cuota mensual 
                                de pago, <b>“EL VENDEDOR”</b> puede recoger el vehículo 
                                materia de esta venta y se procederá automáticamente 
                                la conclusión de este contrato.

                                <br><br><b>SEXTO.-</b><br> 
                                <b>“EL VENDEDOR”</b> no asumirá ninguna responsabilidad por la demora en
                                la entrega de las demoras producidas en la obtención de 
                                la <b>TARJETA DE PROPIEDAD</b> y <b>PLACA DE RODAJE</b>.

                                <br><br><b>SEPTIMO.-</b><br>
                                En señal de conformidad de todas las cláusulas del presente contrato, firman ambos contratantes
                                en la ciudad de Pucallpa a los  <b><%=new cNumeroLetra().numeroALetra(new cManejoFechas().dia(objVentas.getFecha()), true)%></b> 
                                dias del mes de <b><%=new cManejoFechas().mesNombre(objVentas.getFecha()).toUpperCase()%></b> del <b><%=new cNumeroLetra().numeroALetra(String.valueOf(new cManejoFechas().anio(objVentas.getFecha())), true)%></b>.

                                <%
                                } else {
                                %>
                                <br><br><b>CUARTO:</b><br>
                                En señal de conformidad de todas las cláusulas del presente contrato, firman ambos contratantes
                                en la ciudad de Pucallpa a los  <b><%=new cNumeroLetra().numeroALetra(new cManejoFechas().dia(objVentas.getFecha()), true)%></b> 
                                dias del mes de <b><%=new cManejoFechas().mesNombre(objVentas.getFecha()).toUpperCase()%></b> del <b><%=new cNumeroLetra().numeroALetra(String.valueOf(new cManejoFechas().anio(objVentas.getFecha())), true)%></b>.

                                <%                                            }
                                %>
                            </td>
                        </tr>
                    </table>
                </div>
                <div id="dPie">
                    <table>
                        <tr>
                            <td style="text-align: center;">
                                _________________________<br>
                                <b>IMPORTADORA YUCRA S.A.C.</b><br>
                                <b>VENDEDOR</b>
                            </td>
                            <td style="text-align: center;">
                                _________________________________<br>
                                <b><%=objVentas.getCliente()%></b><br>
                                <b><%=objVentas.getIdentificacion()%></b><br>
                                <b>COMPRADOR</b>
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
/div>
</div>
</body>
</html>
