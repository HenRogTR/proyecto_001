<%-- 
    Document   : nombresCEmpresaConvenioLetrasVencidasTipoCondicion
    Created on : 17/05/2013, 06:20:32 PM
    Author     : Henrri
--%>

<%@page import="tablas.DatosCliente"%>
<%@page import="personaClases.cEmpresaConvenio"%>
<%@page import="tablas.EmpresaConvenio"%>
<%@page import="tablas.VentasDetalle"%>
<%@page import="otros.cManejoFechas"%>
<%@page import="tablas.VentaCreditoLetra"%>
<%@page import="ventaClases.cVentaCreditoLetra"%>
<%@page import="java.util.Iterator"%>
<%@page import="java.util.List"%>
<%@page import="personaClases.cDatosCliente"%>
<%@page import="otros.cUtilitarios"%>
<%@page import="java.util.Date"%>
<%
    //clases
    cVentaCreditoLetra objcVentaCreditoLetra = new cVentaCreditoLetra();
    cManejoFechas objcManejoFechas = new cManejoFechas();
    cEmpresaConvenio objcEmpresaConvenio = new cEmpresaConvenio();
    EmpresaConvenio objEmpresaConvenio = new EmpresaConvenio();
    cDatosCliente objcDatosCliente = new cDatosCliente();
    //variables
    boolean estado = true;
    String mensaje = "";
    Date fechaVencimiento = new Date();
    int codEmpresaConvenio = 0, tipo = 0;
    List lLetrasVencidas = null;
    int condicion = 0;
    try {
        fechaVencimiento = objcManejoFechas.caracterADate(request.getParameter("fechaVencimiento"));
        codEmpresaConvenio = Integer.parseInt(request.getParameter("codEmpresaConvenio"));
        objEmpresaConvenio = objcEmpresaConvenio.leer_cod(codEmpresaConvenio);
        if (objEmpresaConvenio == null) {
            estado = false;
            mensaje = "*Empresa no existente.<br>";
        }
        tipo = Integer.parseInt(request.getParameter("tipo"));
        condicion = Integer.parseInt(request.getParameter("condicion"));
        lLetrasVencidas = objcVentaCreditoLetra.letrasVencidas_codEmpresaConvenio_tipo_condicion_orderByNombresC(fechaVencimiento, codEmpresaConvenio, tipo, condicion);
        if (lLetrasVencidas == null) {
            estado = false;
            mensaje = objcVentaCreditoLetra.getError() + ".<br>";
        }
    } catch (Exception e) {
        estado = false;
        mensaje = "Fecha incorrecta o empresa incorrecta.";
    }
    if (!estado) {
        out.print(mensaje);
        return;
    }
    cUtilitarios objcUtilitarios = new cUtilitarios();
%>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <title></title>
        <link rel="stylesheet" type="text/css" href="../../lib/propios/css/paginaImprimir/bodyPrint.css" media="screen"/>
        <link rel="stylesheet" type="text/css" href="../../lib/propios/css/paginaImprimir/bodyPrint.css" media="print"/>
        <style>
            td,th{
                /*border: 1px solid #3366ff;*/
            }
            @media print {
                a:link, a:visited {
                    text-decoration: none;
                    color: black;
                }
            }
        </style>
    </head>
    <body>
        <div id="documento">
            <div id="contenido">
                <%
                    if (estado) {
                %>
                <table style="width: 100%;font-size: 11px;">
                    <thead>
                        <tr class="bottom2">
                            <th colspan="8" style="font-size: 14px;"><label>LETRAS X COBRAR : <%=objEmpresaConvenio.getNombre()%> / <%=objcDatosCliente.tipoCliente(tipo)%> / <%=objcDatosCliente.condicionCliente(condicion)%></label></th>
                        </tr>
                        <tr class="bottom1"  style="font-size: 12px;" >
                            <th style="width: 80px;"><label>Número</label></th>
                            <th><label>Nombre/Razón Social</label></th>
                            <th style="width: 60px;"><label>Vencimiento</label></th>
                            <th style="width: 60px;"><label>Monto</label></th>
                            <th style="width: 60px;"><label>Interés</label></th>
                            <th style="width: 60px;"><label>Pagos</label></th>
                            <th style="width: 60px;"><label>Saldo</label></th>
                            <th style="width: 80px;"><label>F. Ultimo Pago</label></th>
                        </tr>
                    </thead>
                    <tbody>
                        <%
                            int contPersona = 0;
                            int codPersona = 0;
                            int contVentas = 0;
                            int codVentas = 0;
                            int cont = 1;
                            Double totalDedua = 0.00;
                            Iterator iLetrasVencidas = lLetrasVencidas.iterator();
                            while (iLetrasVencidas.hasNext()) {
                                VentaCreditoLetra objVentaCreditoLetra = (VentaCreditoLetra) iLetrasVencidas.next();
                                if (contPersona == 0) {//primera persona de la lista
                                    codPersona = objVentaCreditoLetra.getVentaCredito().getVentas().getPersona().getCodPersona();
                        %>
                        <tr style="font-size: 11px;">
                            <td><%=objcUtilitarios.agregarCeros_int(cont, 8)%></td>
                            <td colspan="2"><%=objVentaCreditoLetra.getVentaCredito().getVentas().getPersona().getNombresC() + (objVentaCreditoLetra.getVentaCredito().getVentas().getPersona().getTelefono1() == null ? "" : (" - ") + objVentaCreditoLetra.getVentaCredito().getVentas().getPersona().getTelefono1()) + (objVentaCreditoLetra.getVentaCredito().getVentas().getPersona().getTelefono2() == null ? "" : (" - ") + objVentaCreditoLetra.getVentaCredito().getVentas().getPersona().getTelefono2())%></td>
                            <td colspan="5"><%=objVentaCreditoLetra.getVentaCredito().getVentas().getPersona().getDireccion()%></td>
                        </tr>
                        <%
                            cont++;
                        } else {
                            if (codPersona != objVentaCreditoLetra.getVentaCredito().getVentas().getPersona().getCodPersona()) {//si la persona es diferente al anterior
                                codPersona = objVentaCreditoLetra.getVentaCredito().getVentas().getPersona().getCodPersona();
                        %>
                        <tr class="bottom1">
                            <th colspan="8"></th>
                        </tr>
                        <tr style="font-size: 11px;">
                            <td><%=objcUtilitarios.agregarCeros_int(cont, 8)%></td>
                            <td colspan="2"><%=objVentaCreditoLetra.getVentaCredito().getVentas().getPersona().getNombresC() + (objVentaCreditoLetra.getVentaCredito().getVentas().getPersona().getTelefono1() == null ? "" : (" - ") + objVentaCreditoLetra.getVentaCredito().getVentas().getPersona().getTelefono1()) + (objVentaCreditoLetra.getVentaCredito().getVentas().getPersona().getTelefono2() == null ? "" : (" - ") + objVentaCreditoLetra.getVentaCredito().getVentas().getPersona().getTelefono2())%></td>
                            <td colspan="5"><%=objVentaCreditoLetra.getVentaCredito().getVentas().getPersona().getDireccion()%></td>
                        </tr>
                        <%
                                    cont++;
                                }
                            }
                            //detalle de venta
                            if (contVentas == 0) {
                                codVentas = objVentaCreditoLetra.getVentaCredito().getVentas().getCodVentas();
                        %>
                        <tr>
                            <td style="text-align: right;"><%=objcUtilitarios.fechaDateToString(objVentaCreditoLetra.getVentaCredito().getVentas().getFecha())%></td>
                            <td style="padding-left: 20px;" colspan="5">
                                <a target="_blank" href="../../sVenta?accionVenta=mantenimiento&codVenta=<%=objVentaCreditoLetra.getVentaCredito().getVentas().getCodVentas()%>"><%=objVentaCreditoLetra.getVentaCredito().getVentas().getDocSerieNumero()%></a> ***
                                <%
                                    for (VentasDetalle objVentasDetalle : objVentaCreditoLetra.getVentaCredito().getVentas().getVentasDetalles()) {
                                        if (objVentasDetalle.getItem().equals(1)) {
                                            out.print(objVentasDetalle.getDescripcion());
                                        }
                                    }

                                %>
                            </td>
                            <td>N° Item: <%=objVentaCreditoLetra.getVentaCredito().getVentas().getItemCantidad()%></td>
                            <td>N° Letras: <%=objVentaCreditoLetra.getVentaCredito().getCantidadLetras()%></td>
                        </tr>
                        <%
                        } else {
                            if (codVentas != objVentaCreditoLetra.getVentaCredito().getVentas().getCodVentas()) {
                                codVentas = objVentaCreditoLetra.getVentaCredito().getVentas().getCodVentas();
                        %>
                        <tr>
                            <td style="text-align: right;"><%=objcUtilitarios.fechaDateToString(objVentaCreditoLetra.getVentaCredito().getVentas().getFecha())%></td>
                            <td style="padding-left: 20px;" colspan="5">
                                <a target="_blank" href="../../sVenta?accionVenta=mantenimiento&codVenta=<%=objVentaCreditoLetra.getVentaCredito().getVentas().getCodVentas()%>"><%=objVentaCreditoLetra.getVentaCredito().getVentas().getDocSerieNumero()%></a> ***
                                <%
                                    for (VentasDetalle objVentasDetalle : objVentaCreditoLetra.getVentaCredito().getVentas().getVentasDetalles()) {
                                        if (objVentasDetalle.getItem().equals(1)) {
                                            out.print(objVentasDetalle.getDescripcion());
                                        }
                                    }

                                %>
                            </td>
                            <td>N° Item: <%=objVentaCreditoLetra.getVentaCredito().getVentas().getItemCantidad()%></td>
                            <td>N° Letras: <%=objVentaCreditoLetra.getVentaCredito().getCantidadLetras()%></td>
                        </tr>
                        <%
                                }
                            }
                            Double saldoTemp = objVentaCreditoLetra.getMonto() - objVentaCreditoLetra.getTotalPago();
                            totalDedua += saldoTemp;
                        %>
                        <tr style="font-size: 11px;">
                            <td></td>
                            <td><%=objVentaCreditoLetra.getDetalleLetra()%></td>
                            <td><%=objcUtilitarios.fechaDateToString(objVentaCreditoLetra.getFechaVencimiento())%></td>
                            <td><%=objcUtilitarios.agregarCerosNumeroFormato(objVentaCreditoLetra.getMonto(), 2)%></td>
                            <td><%=objcUtilitarios.agregarCerosNumeroFormato(objVentaCreditoLetra.getInteres(), 2)%></td>
                            <td><%=objcUtilitarios.agregarCerosNumeroFormato(objVentaCreditoLetra.getTotalPago(), 2)%></td>
                            <td><%=objcUtilitarios.agregarCerosNumeroFormato(objcUtilitarios.redondearDecimales(objVentaCreditoLetra.getMonto() - objVentaCreditoLetra.getTotalPago(), 2), 2)%></td>
                            <td><%=objVentaCreditoLetra.getFechaPago() == null ? "" : objcUtilitarios.fechaDateToString(objVentaCreditoLetra.getFechaPago())%></td>
                        </tr>
                        <%
                                contPersona++;
                                contVentas++;
                            }
                        %>
                        <tr class="bottom2">
                            <td style="height: 50px;"></td>
                            <td></td>
                            <th colspan="3" style="font-weight: bold; font-size: 14px; vertical-align: bottom;">TOTAL GENERAL</th>
                            <td></td>
                            <th style="font-weight: bold; font-size: 14px; vertical-align: bottom; text-align: right;"><%=objcUtilitarios.agregarCerosNumeroFormato(objcUtilitarios.redondearDecimales(totalDedua, 2), 2)%></th>
                            <td></td>
                        </tr>
                    </tbody>
                </table>
                <%
                    } else {
                        out.print(mensaje);
                    }
                %>
            </div>
        </div>
    </body>
</html>
