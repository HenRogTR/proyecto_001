<%-- 
    Document   : ventaPorCodCliente
    Created on : 04/07/2014, 05:38:24 PM
    Author     : Henrri
--%>

<%@page import="java.util.List"%>
<%@page import="tablas.Ventas"%>
<%@page import="Clase.Fecha"%>
<%@page import="utilitarios.cManejoFechas"%>
<%@page import="Clase.Utilitarios"%>
<%@page import="tablas.DatosCliente"%>
<%@page import="Ejb.EjbVenta"%>
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
    String codClienteString = (String) session.getAttribute("reporteVentaCodCliente");
    //En caso de que el parámetro codCliente no se haya enviado
    if (codClienteString == null) {
        out.print("[Parámetro codCliente no encontrado.]");
        return;
    }
    int codClienteI = Integer.parseInt(codClienteString);
    EjbCliente ejbCliente;
    EjbVenta ejbVenta;
    //Obteniendo Cliente
    ejbCliente = new EjbCliente();
    DatosCliente objCliente = ejbCliente.leerCodigoCliente(codClienteI, false);
    ejbVenta = new EjbVenta();
    List<Ventas> ventaList = ejbVenta.leerPorCodigoCliente(codClienteI, true);
    String cliente = Utilitarios.agregarCerosIzquierda(objCliente.getCodDatosCliente(), 8) + " " + objCliente.getPersona().getNombresC();
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
                            <th class="izquierda" colspan="6"><%=cliente%></th>
                            <th class="derecha" colspan="3"><%=new Fecha().fechaHora(new Date()).toUpperCase()%></th>
                        </tr>
                        <tr class="top2 bottom2">
                            <th style="width: 90px;">DOCUMENTO</th>
                            <th style="width: 90px;">TIPO</th>
                            <th style="width: 90px;">CONTADO</th>
                            <th style="width: 90px;">CRÉDITO</th>
                            <th style="width: 90px;">INICIAL</th>
                            <th>N. LETRAS</th>
                            <th style="width: 90px;">INTERÉS</th>
                            <th style="width: 90px;">AMORTIZADO</th>
                            <th style="width: 90px;">SALDO</th>
                        </tr>
                    </thead>
                    <tbody>
                        <%
                            //Variables
                            Double contadoTotal = 0.00;
                            Double creditoTotal = 0.00;
                            Double inicialTotal = 0.00;
                            Double interesTotal = 0.00;
                            Double amortizadoTotal = 0.00;
                            Double saldoTotal = 0.00;
                            Date auxDate = null;
                            int tam = ventaList.size();
                            for (int i = 0; i < tam; i++) {
                                Ventas objVenta = ventaList.get(i);
                                //Imprimir la fecha
                                if (null == auxDate || objVenta.getFecha().after(auxDate)) {
                        %>                                    
                        <tr class="top2 padding">
                            <th class="centrado"><%=new Fecha().dateAString(objVenta.getFecha())%></th>
                        </tr>
                        <%
                                auxDate = objVenta.getFecha();
                            }
                        %>
                        <tr>
                            <td class="centrado"><%=objVenta.getDocSerieNumero()%></td>
                            <td><%=objVenta.getTipo()%></td>
                            <%
                                if ("1".equals(objVenta.getRegistro().substring(0, 1))) {
                                    //Si es un venta al contado
                                    if ("CONTADO".equals(objVenta.getTipo())) {
                            %>
                            <td class="derecha"><%=Utilitarios.decimalFormato(objVenta.getNeto(), 2)%></td>
                            <td></td>
                            <td colspan="5"></td>
                            <%
                                contadoTotal += objVenta.getNeto();
                            } else {      //Si en caso es al credito
                            %>
                            <td></td>
                            <td class="derecha"><%=Utilitarios.decimalFormato(objVenta.getNeto(), 2)%></td>
                            <td class="derecha"><%=Utilitarios.decimalFormato(objVenta.getMontoInicial(), 2)%></td>
                            <td class="derecha"><%=objVenta.getCantidadLetras()%></td>
                            <td class="derecha"><%=Utilitarios.decimalFormato(objVenta.getInteres(), 2)%></td>
                            <td class="derecha"><%=Utilitarios.decimalFormato(objVenta.getAmortizado() + objVenta.getInteresPagado(), 2)%></td>
                            <td class="derecha"><%=Utilitarios.decimalFormato((objVenta.getNeto() + objVenta.getInteres()) - (objVenta.getAmortizado() + objVenta.getInteresPagado()), 2)%></td>
                            <%
                                    creditoTotal += objVenta.getNeto();
                                    inicialTotal += objVenta.getMontoInicial();
                                    interesTotal += objVenta.getInteres();
                                    amortizadoTotal += objVenta.getAmortizado() + objVenta.getInteresPagado();
                                }
                            } else {    //Si está anulado
                            %>
                            <td colspan="7" style="font-weight: bold">*********** DOCUMENTO ANULADO *********</td>
                            <%
                                }
                                saldoTotal += (objVenta.getNeto() + objVenta.getInteres()) - (objVenta.getAmortizado() + objVenta.getInteresPagado());
                            %>
                        </tr>
                        <%
                            }
                        %>
                        <tr class="top3 padding">
                            <td></td>
                            <th class="derecha">TOTAL</th>
                            <th class="derecha"><%=Utilitarios.decimalFormato(contadoTotal, 2)%></th>
                            <th class="derecha"><%=Utilitarios.decimalFormato(creditoTotal, 2)%></th>
                            <th class="derecha"><%=Utilitarios.decimalFormato(inicialTotal, 2)%></th>
                            <td></td>
                            <th class="derecha"><%=Utilitarios.decimalFormato(interesTotal, 2)%></th>
                            <th class="derecha"><%=Utilitarios.decimalFormato(amortizadoTotal, 2)%></th>
                            <th class="derecha"><%=Utilitarios.decimalFormato(saldoTotal, 2)%></th>
                        </tr>
                    </tbody>
                </table>
            </div>
        </div>
    </body>
</html>
