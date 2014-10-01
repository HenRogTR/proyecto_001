<%-- 
    Document   : cobranzaPorCodClienteYCodVenta
    Created on : 30/07/2014, 04:37:34 PM
    Author     : Henrri
--%>

<%@page import="Ejb.EjbCobranza"%>
<%@page import="tablas.Cobranza"%>
<%@page import="java.util.List"%>
<%@page import="Clase.Fecha"%>
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
    String codClienteString = (String) session.getAttribute("reporteCobranzaCodCliente");
    String codVentaString = (String) session.getAttribute("reporteCobranzaCodVenta");
    //En caso de que el parámetro codCliente no se haya enviado
    if (null == codClienteString) {
        out.print("[Parámetro codCliente no encontrado.]");
        return;
    }
    int codClienteI = Integer.parseInt(codClienteString);
    int codVentaI = codVentaString == null ? 0 : Integer.parseInt(codVentaString);
    EjbCliente ejbCliente;
    EjbCobranza ejbCobranza;
    //Obteniendo Cliente
    ejbCliente = new EjbCliente();
    DatosCliente objCliente = ejbCliente.leerCodigoCliente(codClienteI, false);
    String cliente = Utilitarios.agregarCerosIzquierda(objCliente.getCodDatosCliente(), 8) + " " + objCliente.getPersona().getNombresC();
    //Obtener cobranza
    ejbCobranza = new EjbCobranza();
    List<Cobranza> cobranzaList
            = null == codVentaString
            ? ejbCobranza.leerActivoPorCodigoCliente(codClienteI, false)
            : ejbCobranza.leerActivoPorCodigoVenta(codVentaI, false);
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
                            <th class="izquierda" colspan="3"><%=cliente%></th>
                            <th class="derecha"><%=new Fecha().fechaHora(new Date()).toUpperCase()%></th>
                        </tr>
                        <tr class="top2 bottom2 padding">
                            <th style="width: 120px;">FECHA</th>
                            <th style="width: 120px;">RECIBO</th>
                            <th style="width: 120px;">IMPORTE</th>
                            <th class="izquierda">DETALLES</th>
                        </tr>
                    </thead>
                    <tbody>
                        <%
                            Double total = 0.00;
                            Date auxDate = null;
                            int tam = cobranzaList.size();
                            for (int i = 0; i < tam; i++) {
                                Cobranza objCobranza = cobranzaList.get(i);
                                total += objCobranza.getImporte() + objCobranza.getSaldo();
                                //Imprimir la fecha
                                if (null == auxDate || objCobranza.getFechaCobranza().after(auxDate)) {
                        %>
                        <tr class="top1 padding">
                            <th class="derecha"><%=new Fecha().dateAString(objCobranza.getFechaCobranza())%></th>
                            <th colspan="4"></th>
                        </tr>
                        <%
                                auxDate = objCobranza.getFechaCobranza();
                            }
                        %>
                        <tr>
                            <td></td>
                            <td><%=objCobranza.getDocSerieNumero()%></td>
                            <td class="derecha"><%=Utilitarios.decimalFormato(objCobranza.getImporte() + objCobranza.getSaldo(), 2)%></td>
                            <td><%=Utilitarios.reemplazarCaracteresEspeciales(objCobranza.getObservacion())%></td>
                        </tr>
                        <%
                            }
                        %>
                        <tr class="top2">
                            <th></th>
                            <th class="derecha">TOTAL GENERAL</th>
                            <th class="derecha"><%=Utilitarios.decimalFormato(total, 2)%></th>
                        </tr>
                    </tbody>
                </table>
            </div>
        </div>
    </body>
</html>
