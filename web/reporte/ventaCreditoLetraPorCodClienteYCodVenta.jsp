<%-- 
    Document   : ventaCreditoLetraPorCodClienteYCodVenta
    Created on : 25/07/2014, 11:03:09 AM
    Author     : Henrri
--%>

<%@page import="Clase.Fecha"%>
<%@page import="Ejb.EjbVentaCreditoLetra"%>
<%@page import="tablas.VentaCreditoLetra"%>
<%@page import="java.util.List"%>
<%@page import="Clase.Utilitarios"%>
<%@page import="tablas.DatosCliente"%>
<%@page import="Ejb.EjbCliente"%>
<%@page import="java.util.Date"%>
<%@page import="tablas.Usuario"%>
<%
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
    //
    String codClienteString = (String) session.getAttribute("reporteVentaCreditoLetraCodCliente");
    String codVentaString = (String) session.getAttribute("reporteVentaCreditoLetraCodVenta");
    //En caso de que el parámetro codCliente no se haya enviado
    if (null == codClienteString) {
        out.print("[Parámetro codCliente no encontrado.]");
        return;
    }
    int codClienteI = Integer.parseInt(codClienteString);
    int codVentaI = codVentaString == null ? 0 : Integer.parseInt(codVentaString);
    EjbCliente ejbCliente;
    EjbVentaCreditoLetra ejbVentaCreditoLetra;
    //Obteniendo Cliente
    ejbCliente = new EjbCliente();
    DatosCliente objCliente = ejbCliente.leerCodigoCliente(codClienteI, false);
    String cliente = Utilitarios.agregarCerosIzquierda(objCliente.getCodDatosCliente(), 8) + " " + objCliente.getPersona().getNombresC();
    //Obtener las VCL
    ejbVentaCreditoLetra = new EjbVentaCreditoLetra();
    List<VentaCreditoLetra> ventaCreditoLetraList
            = null == codVentaString
            ? ejbVentaCreditoLetra.leerActivoPorCodigoCliente(codClienteI, false)
            : ejbVentaCreditoLetra.leerActivoPorCodigoVenta(codVentaI, false);
%>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <title><%=cliente.length() > 60 ? (cliente.substring(0, 59) + "...") : cliente%></title>
        <link rel="stylesheet" type="text/css" href="../librerias/css/cssPaginaImprimir.css" media="screen"/>
        <link rel="stylesheet" type="text/css" href="../librerias/css/cssPaginaImprimir.css" media="print"/>
    </head>
    <body>
        <div id="documento">
            <div id="contenido">
                <table class="tabla-imprimir" style="font-size: 11px;">
                    <thead>
                        <tr class="padding">
                            <th class="izquierda" colspan="5"><%=cliente%></th>
                            <th class="derecha" colspan="3"><%=new Fecha().fechaHora(new Date()).toUpperCase()%></th>
                        </tr>
                        <tr class="top2 bottom2">
                            <th style="width: 90px;">DOCUMENTO</th>
                            <th>DETALLE</th>
                            <th style="width: 90px;">F.VENCIMIENTO</th>
                            <th style="width: 90px;">MONTO</th>
                            <th style="width: 90px;">INTERÉS</th>
                            <th style="width: 90px;">PAGADO</th>
                            <th style="width: 90px;">F.PAGO(*)</th>
                            <th style="width: 90px;">SALDO</th>
                        </tr>
                    </thead>
                    <tbody>
                        <%
                            Double montoGeneral = 0.00;
                            Double interesGeneral = 0.00;
                            Double deudaGeneral = 0.00;
                            Double pagadoGeneral = 0.00;
                            int tam = ventaCreditoLetraList.size();
                            int codVentaAux = 0;
                            for (int i = 0; i < tam; i++) {
                                VentaCreditoLetra objVentaCreditoLetra = ventaCreditoLetraList.get(i);
                                Double deuda = objVentaCreditoLetra.getMonto() + objVentaCreditoLetra.getInteres();
                                Double pagado = objVentaCreditoLetra.getTotalPago() + objVentaCreditoLetra.getInteresPagado();
                                //totales
                                montoGeneral += objVentaCreditoLetra.getTotalPago();
                                interesGeneral += objVentaCreditoLetra.getInteres();
                                deudaGeneral += deuda;
                                pagadoGeneral += pagado;
                                if (0 == codVentaAux || objVentaCreditoLetra.getVentas().getCodVentas() != codVentaAux) {
                        %>
                        <tr class="top1 padding">
                            <th class="centrado"><%=new Fecha().dateAString(objVentaCreditoLetra.getVentas().getFecha())%></th>
                            <th colspan="7" class="izquierda"><%=objVentaCreditoLetra.getVentas().getDocSerieNumero()%></th>
                        </tr>
                        <%
                                codVentaAux = objVentaCreditoLetra.getVentas().getCodVentas();
                            }
                        %>
                        <tr>
                            <td></td>
                            <td><%=objVentaCreditoLetra.getDetalleLetra()%></td>
                            <td class="centrado"><%=new Fecha().dateAString(objVentaCreditoLetra.getFechaVencimiento())%></td>
                            <td class="derecha"><%=Utilitarios.decimalFormato(objVentaCreditoLetra.getMonto(), 2)%></td>
                            <td class="derecha"><%=Utilitarios.decimalFormato(objVentaCreditoLetra.getInteres(), 2)%></td>
                            <td class="derecha"><%=Utilitarios.decimalFormato(pagado, 2)%></td>
                            <td class="centrado"><%=new Fecha().dateAString(objVentaCreditoLetra.getFechaPago())%></td>
                            <td class="derecha"><%=Utilitarios.decimalFormato(deuda - pagado, 2)%></td>
                        </tr>
                        <%
                            }
                        %>
                        <tr class="top2 padding">
                            <td></td>
                            <th colspan="2" class="derecha">TOTAL GENERAL</th>
                            <th class="derecha"><%=Utilitarios.decimalFormato(montoGeneral, 2)%></th>
                            <th class="derecha"><%=Utilitarios.decimalFormato(interesGeneral, 2)%></th>
                            <th class="derecha"><%=Utilitarios.decimalFormato(pagadoGeneral, 2)%></th>
                            <td class="centrado"></td>
                            <th class="derecha"><%=Utilitarios.decimalFormato(deudaGeneral - pagadoGeneral, 2)%></th>
                        </tr>
                    </tbody>
                </table>
            </div>
        </div>
    </body>
</html>
