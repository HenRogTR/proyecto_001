<%-- 
    Document   : cobranzaImprimir
    Created on : 04/06/2013, 01:38:50 PM
    Author     : Henrri
--%>

<%@page import="utilitarios.cManejoFechas"%>
<%@page import="utilitarios.cOtros"%>
<%@page import="tablas.Usuario"%>
<%@page import="cobranzaClases.cCobranza"%>
<%@page import="tablas.Cobranza"%>
<%
    int codCobranza = 0;
    Cobranza objCobranza = new Cobranza();
    try {
        codCobranza = Integer.parseInt(request.getParameter("codCobranza"));
        objCobranza = new cCobranza().leer_codCobranza(codCobranza);
        if (objCobranza == null) {
            out.print("No hay cobranza con ese codigo");
            return;
        }
        if (objCobranza.getDocSerieNumero().substring(0, 1).equals("X")) {
            out.print("No es un comprobante de pago.");
            return;
        }
    } catch (Exception e) {
        out.print("Error en codigo de cobranza");
        return;
    }
    Usuario objUsuario = (Usuario) session.getAttribute("usuario");
    if (objUsuario == null) {
        out.print("Sesión no iniciada.");
        return;
    } else {
        if (!objUsuario.getP36()) {
            out.print("No tiene permisos suficientes para acceder a esta pagina.");
            return;
        }
    }
%>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <title><%=objCobranza.getDocSerieNumero()%></title>
        <link rel="stylesheet" type="text/css" href="cobranzaImprimir.css" media="screen"/>
        <link rel="stylesheet" type="text/css" href="cobranzaImprimir.css" media="print"/>
        <script type="text/javascript" src="../../librerias/jquery/jquery-1.8.1.min.js"></script>
    </head>
    <script>
        $(document).ready(function() {
            if ($('#marca').val() == '1') {
                print();
            }
            if ($.browser.chrome) {
                $('#dCabecera').css('font-size', 8);
                $('#dCuerpo').css('font-size', 8);
                $('#dPie').css('font-size', 8);
                $('#dCuerpo').css('height', 180);
            }
            ;
        });
    </script>
    <body>
        <div id="dCabecera">
            <table>
                <tr>
                    <td style="width: 10px;"></td>
                    <td></td>
                    <td style="text-align: right; font-weight: bold;"><%=new cOtros().decimalFormato(objCobranza.getImporte() + objCobranza.getSaldo(), 2)%></td>
                </tr>
                <tr>
                    <td></td>
                    <td></td>
                    <td style="text-align: right;"></td>
                </tr>
                <tr>
                    <td></td>
                    <td></td>
                    <td style="text-align: right;"></td>
                </tr>

                <tr>
                    <td></td>
                    <td></td>
                    <td style="text-align: right;"></td>
                </tr>
                <tr>
                    <td></td>
                    <td></td>
                    <td style="text-align: right; font-weight: bold"><%=objCobranza.getDocSerieNumero()%></td>
                </tr>
            </table>
        </div>
        <div id="dCuerpo">
            <table>
                <tr>
                    <td style="width: 10px;"></td>
                    <td><%=objCobranza.getPersona().getNombresC()%></td>
                </tr>
                <tr>
                    <td></td>
                    <td><%=new cOtros().decimalFormato(objCobranza.getImporte() + objCobranza.getSaldo(), 2)%></td>
                </tr>
                <tr>
                    <td></td>
                    <td><%=objCobranza.getObservacion().replace("\n", ", ")%></td>
                </tr>
            </table>
        </div>
        <div id="dPie">
            <table>
                <tr>
                    <!--<td></td>-->
                    <td  style="width: 60px;font-weight: bold;"><%=new cManejoFechas().dia(objCobranza.getFechaCobranza())%></td>
                    <td  style="width: 60px;font-weight: bold;"><%=new cManejoFechas().mesNombre(objCobranza.getFechaCobranza())%></td>
                    <td style="width: 60px;font-weight: bold;"><%=new cManejoFechas().anio(objCobranza.getFechaCobranza())%></td>
                    <td style="width: "></td>
                </tr>
            </table>
        </div>
    </body>
</html>
