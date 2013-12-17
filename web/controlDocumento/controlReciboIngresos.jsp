<%-- 
    Document   : controlReciboIngresos
    Created on : 02/10/2013, 11:53:01 AM
    Author     : Henrri
--%>

<%@page import="tablas.ComprobantePago"%>
<%@page import="otros.cCalendario"%>
<%@page import="otrasTablasClases.cComprobantePago"%>
<%@page import="tablas.EmpresaConvenio"%>
<%@page import="personaClases.cEmpresaConvenio"%>
<%@page import="tablas.DatosExtras"%>
<%@page import="java.util.Iterator"%>
<%@page import="java.util.List"%>
<%@page import="otrasTablasClases.cDatosExtras"%>
<%@page import="utilitarios.cManejoFechas"%>
<%
    cManejoFechas objcManejoFechas = new cManejoFechas();
%>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <title>control recibo ingresos</title>
        <!--todos-->
        <script type="text/javascript" src="../librerias/jquery/jquery-1.9.0-min.js" ></script>
        <script type="text/javascript" src="../librerias/jquery/jquery.timer-min.js" ></script>
        <script type="text/javascript" src="../librerias/jquery-ui/jquery-ui-1.10.3.custom/js/jquery-ui-1.10.3.custom.min.js" ></script>
        <link rel="stylesheet" type="text/css" href="../librerias/principal/todos.css" media="all"/>
        <!--cambios-->
        <%@include file="../principal/inclusiones.jsp" %>
        <!--propio-->
        <script type="text/javascript" src="../librerias/jquery.maskedinput/jquery.maskedinput.min.js"></script>
        <script type="text/javascript" src="../librerias/controlDocumento/controlReciboIngreso.js"></script>
    </head>
    <body>
        <input type="hidden" name="paginaActualPermiso" id="permisoPaginaP50" value="" title="CONTROL DE RECIBO INGRESOS"/>
        <div id="wrap">
            <div id="header">
                <label class="horaCabecera"><%=objcManejoFechas.fechaCabecera()%></label>
            </div>
            <div id="right">
                <div id="rightSub1" class="ocultar">
                    <h3 class="titulo">CONTROL DE RECIBO DE INGRESOS</h3>
                    <%
                        String tipoRecCaja = "";
                        cDatosExtras objcDatosExtras = new cDatosExtras();
                    %>
                    <table class="reporte-tabla-1">
                        <tr>
                            <th class="ancho200px">DOCUMENTO(S) DE RECIBO CAJA</th>
                            <td class="ancho160px contenedorEntrada">
                                <select name="docRecCaja" id="docRecCaja" class="anchoTotal">
                                    <%
                                        List DatosExtrasList = objcDatosExtras.leer_documentoCaja();
                                        int cont1 = 0;
                                        for (Iterator it = DatosExtrasList.iterator(); it.hasNext();) {
                                            DatosExtras objDatosExtras = (DatosExtras) it.next();
                                            if (cont1++ == 0) {
                                                tipoRecCaja = objDatosExtras.getLetras();
                                            }
                                    %>
                                    <option value="<%=objDatosExtras.getLetras()%>"><%=objDatosExtras.getLetras()%></option>
                                    <%
                                        }
                                    %>
                                </select>
                            </td>
                            <th class="ancho80px">SERIE(S)</th>
                            <td class="ancho240px">
                                <%
                                    List comPagoList = new cComprobantePago().leer_serieGenerada(tipoRecCaja);
                                    int cont2 = 0;
                                    for (Iterator it = comPagoList.iterator(); it.hasNext();) {
                                        ComprobantePago objComprobantePago = (ComprobantePago) it.next();
                                        if (cont2++ > 0) {
                                            out.print(", ");
                                        }
                                        out.print(objComprobantePago.getSerie());
                                    }
                                %>
                            </td>
                        </tr>
                        <tr>
                            <th>DOCUMENTO(S) DE DESCUENTO</th>
                            <td>
                                <select name="docRecDesc" id="docRecDesc" class="anchoTotal">
                                    <%
                                        List DatosExtras2List = objcDatosExtras.leer_documentoDescuento();
                                        int cont3 = 0;
                                        for (Iterator it = DatosExtras2List.iterator(); it.hasNext();) {
                                            DatosExtras objDatosExtras = (DatosExtras) it.next();
                                            if (cont3++ == 0) {
                                                tipoRecCaja = objDatosExtras.getLetras();
                                            }
                                    %>
                                    <option value="<%=objDatosExtras.getLetras()%>"><%=objDatosExtras.getLetras()%></option>
                                    <%
                                        }
                                    %>
                                </select>
                            </td>
                            <th>SERIE(S)</th>
                            <td>
                                <%
                                    List comPago2List = new cComprobantePago().leer_serieGenerada(tipoRecCaja);
                                    int cont4 = 0;
                                    for (Iterator it = comPago2List.iterator(); it.hasNext();) {
                                        ComprobantePago objComprobantePago = (ComprobantePago) it.next();
                                        if (cont4++ > 0) {
                                            out.print(", ");
                                        }
                                        out.print(objComprobantePago.getSerie());
                                    }
                                %>
                            </td>
                        </tr>
                    </table>
                    <table class="reporte-tabla-1" style="margin-top: 20px;">
                        <tr>
                            <th class="centrado">TIPO DE DOCUMENTO</th>
                            <th class="centrado ancho80px">SERIE</th>
                        </tr>
                        <tr>
                            <td>                                
                                <%
                                    List lComprobantePago = new cComprobantePago().leer_series();
                                %>
                                <select name="tipo" id="tipo" class="ancho80px" style="font-size: 16px;">
                                    <%
                                        for (Iterator it = lComprobantePago.iterator(); it.hasNext();) {
                                            Object tipo = (Object) it.next();
                                    %>
                                    <option value="<%=tipo%>"><%=tipo%></option>
                                    <%
                                        }
                                    %>
                                </select>
                                <button class="sexybutton sexyicononly sexysimple sexysmall sexypropio" id=""><span class="info"></span></button>
                            </td>
                            <td>
                                <select name="serieCobranza" id="serieCobranza" class="ancho80px" style="font-size: 16px;">
                                </select>
                            </td>
                        </tr>
                    </table>
                    <div style="width: 98%;">
                        <div style="width: 350px; float: left;">
                            <table class="reporte-tabla-1" style="margin-top: 20px; width: 100%;">
                                <tr>
                                    <th class="centrado ancho80px">SERIE</th>
                                    <th class="centrado ancho160px">DOCUMENTO</th>
                                    <th class="centrado">ESTADO</th>
                                </tr>
                            </table>
                            <div style="overflow: auto; height: 450px;">
                                <table class="reporte-tabla-2 vaciar" style="width: 100%;" id="documentoSerie">
                                    <%
                                        for (int i = 0; i < 100; i++) {
                                    %>
                                    <tr id="<%=i%>" >
                                        <td class="centrado" style="width: 88px; ">D01</td>
                                        <td class="centrado" style="width: 168px;">D01-001-0000<%=i%></td>
                                        <td class="centrado"><input type="checkbox" name="1" value="1" /></td>
                                    </tr>
                                    <%                                                }
                                    %>
                                </table>
                            </div>
                        </div>
                        <!--izquierdo-->
                        <div style="width: 450px; float: right;">
                            <input type="hidden" name="tipoAux" id="tipoAux" value="" />
                            <input type="hidden" name="serieAux" id="serieAux" value="" />
                            <input type="hidden" name="numeroAuxSig" id="numeroAuxSig" value="" />
                            <table class="reporte-tabla-1" style="margin-top: 20px; width: 100%;">
                                <tr>
                                    <th class="centrado medio ancho80px">GENERAR</th>
                                    <td class="centrado medio ancho120px vaciar" id="lCodCobranzaSerieNumeroUltimoS">D01-001-000123</td>
                                    <td class="derecha medio ancho80px vaciar" id="lCodCobranzaSerie">D01-001-</td>
                                    <td><input type="text" name="numeroGenerar" id="numeroGenerar" value="" class="ancho80px limpiar"/></td>
                                    <td class="medio"><button class="sexybutton sexyicononly sexysimple sexysmall sexypropio" id="bGenerarComprobantePagoDetalle"><span class="save"></span></button></td>
                                </tr>
                                <tr>
                                    <th class="centrado">BUSCAR</th>
                                    <td colspan="3" class="contenedorEntrada"><input type="text" name="buscar" id="buscar" value="" class="anchoTotal"/></td>
                                    <td><a class="sexybutton sexyicononly sexysimple sexysmall sexypropio" href="#" id="bBuscarDocumentoSerieNumero"><span class="search"></span></a></td>
                                </tr>
                            </table>
                        </div>
                    </div>
                </div>
                <div id="rightSub2" class="ocultar">
                    <div>
                        <h3 class="titulo">INPORTADORA YUCRA S.A.C.</h3>
                        <div class="articles" style="font-size: 12px;padding: 10px;text-align: justify;">
                            Como llegar a Yucra desde el óvalo Saenz Peña.
                            <br /><br />
                            <img src="../librerias/imagenes/ruta_yucra.PNG" alt="Example pic" style="border: 3px solid #ccc;" />
                            <br/><br />
                            Yucra se basa en 5 pilares:<br>
                            Calidad de servicio<br>
                            Responsabilidad<br>
                            Puntualidad<br>
                            Honestidad<br>
                            Respeto
                        </div>
                    </div>
                    <div>
                        <div style="width: 48%; float: left;">
                            <h3 class="titulo">MISIÓN</h3>
                            <div class="articles" style="font-size: 12px;padding: 10px;text-align: justify;">
                                Somos la empresa comercial que brinda servicio personalizado con una amplia gama de productos de calidada través de una cultura de valores.
                            </div>
                        </div>
                        <div style="width: 48%; float: right;">
                            <h3 class="titulo">VISIÓN</h3>
                            <div class="articles" style="font-size: 12px;padding: 10px;text-align: justify;">
                                Ser la empresa comercial con productos de calidad para la exigencia de cada necesidad brindando un servicio de excelencia.
                            </div>
                        </div>
                    </div>
                </div>
            </div>
            <div id="left">
                <div class="acceso">
                    <h3 class="titulo">INICIE SESIÓN</h3>                    
                    <button class="sexybutton" id="bAccesoAbrir"><span><span><img src="../librerias/botonesIconos/images/icons/silk/key_go.png">Ejecutar SICCI</span></span></button>
                </div>
                <div id="menu" class="ocultar">
                    <%@include file="../principal/menu.jsp" %>
                </div>
            </div>
            <div style="clear: both;"></div>
            <div id="footer">
                <%@include file="../principal/piePagina.jsp" %>
            </div>
        </div>
    </body>
</html>