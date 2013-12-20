<%-- 
    Document   : compraMantenimiento
    Created on : 16/10/2013, 09:41:35 PM
    Author     : Henrri
--%>

<%@page import="utilitarios.cManejoFechas"%>
<%
    cManejoFechas objcManejoFechas = new cManejoFechas();
%>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <title>compra mantenimiento</title>
        <!--todos-->
        <script type="text/javascript" src="../librerias/jquery/jquery-1.9.0-min.js" ></script>
        <script type="text/javascript" src="../librerias/jquery/jquery.timer-min.js" ></script>
        <script type="text/javascript" src="../librerias/jquery-ui/jquery-ui-1.10.3.custom/js/jquery-ui-1.10.3.custom.min.js" ></script>
        <link rel="stylesheet" type="text/css" href="../librerias/principal/todos.css" media="all"/>
        <!--cambios-->
        <%@include file="../principal/inclusiones.jsp" %>
        <!--propio-->
        <script>
            function fPaginaActual() {
            }
            ;
        </script>
    </head>
    <body>
        <input type="hidden" name="paginaActualPermiso" id="permisoPaginaP39" value="" title="MANTENIMIENTO DE COMPRAS"/>
        <div id="wrap">
            <div id="header">
                <label class="horaCabecera"><%=objcManejoFechas.fechaCabecera()%></label>
            </div>
            <div id="right">
                <div id="rightSub1" class="ocultar">
                    <h3 class="titulo">MANTENIMIENTO DE COMPRAS</h3>
                    <table class="reporte-tabla-1">
                        <tr>
                            <th class="ancho80px"><span>BUSCAR</span></th>
                            <td class="ancho120px contenedorEntrada"><input type="search" name="codCompraBuscar" id="codCompraBuscar" value="" class="entrada anchoTotal derecha"/></td>
                            <td class="ancho160px contenedorEntrada"><input type="text" name="docSerieNumeroBuscar" id="docSerieNumeroBuscar" value="" class="entrada anchoTotal"/></td>
                        </tr>
                    </table>
                    <div>
                        <table class="reporte-tabla-1 anchoTotal" style="margin-top: 10px;">
                            <thead>
                                <tr>
                                    <th colspan="5" class="centrado">
                                        <button class="sexybutton" id="bPrimero"><span><span><span class="first">Primero</span></span></span></button>
                                        <button class="sexybutton" id="bAnterior"><span><span><span class="prev">Anterior</span></span></span></button>
                                        <button class="sexybutton" id="bSiguiente"><span><span><span class="next">Siguiente</span></span></span></button>
                                        <button class="sexybutton" id="bUltimo"><span><span><span class="last">Último</span></span></span></button>
                                    </th>
                                    <th class="centrado">                                                
                                        <button class="sexybutton sexyicononly sexysimple sexysmall sexypropio" id="bImprimir"><span class="print"></span></button>
                                        <button class="sexybutton sexyicononly sexysimple sexysmall sexypropio" id="bEditar"><span class="edit"></span></button>
                                        <button class="sexybutton sexyicononly sexysimple sexysmall sexypropio" id="bAnular"><span class="delete"></span></button>
                                    </th>
                                </tr>
                            </thead>
                            <tbody>
                                <tr>
                                    <th>COD. OPERACIÓN</th>
                                    <td><span id="lCodCompra" class="vaciar"></span></td>
                                    <th>DET. REGISTRO</th>
                                    <td colspan="3"><span id="lRegistroDetalle" class="vaciar"></span></td>
                                </tr>
                                <tr>
                                    <th class="ancho120px">DOCUMENTO</th>
                                    <td><span id="" class="vaciar"></span></td>
                                    <th class="ancho140px">TIPO DE COMPRA</th>
                                    <td class="ancho120px"><span id="" class="vaciar"></span></td>
                                    <th class="ancho140px">MONEDA</th>
                                    <td class="ancho120px"><span id="" class="vaciar"></span></td>
                                </tr>
                                <tr>
                                    <th>RUC</th>
                                    <td><span id="" class="vaciar"></span></td>
                                    <th>RAZON SOCIAL</th>
                                    <td colspan="3"><span id="" class="vaciar"></span></td>
                                </tr>
                                <tr>
                                    <th>DIRECCIÓN</th>
                                    <td colspan="5"><span id="" class="vaciar"></span></td>
                                </tr>
                                <tr>
                                    <th>F. FACTURA</th>
                                    <td><span id="" class="vaciar"></span></td>
                                    <th>F. VENCIMIENTO</th>
                                    <td><span id="" class="vaciar"></span></td>
                                    <th>F. LLEGADA</th>
                                    <td><span id="" class="vaciar"></span></td>
                                </tr>
                            </tbody>
                        </table>
                        <div style="padding: 5px;" class="tdFondoTh">
                            <table class="reporte-tabla-1 anchoTotal" style="font-size: 10px;">
                                <thead>
                                    <tr>
                                        <th style="width: 22px;"><label>Item</label></th>
                                        <th style="width: 28px;"><label>Cant.</label></th>
                                        <th style="width: 55px;"><label>U. Medida</label></th>
                                        <th><label>Descripción</label></th>
                                        <th style="width: 65px;"><label>P. Unitario</label></th>
                                        <th style="width: 65px;"><label>P. Total</label></th>

                                    </tr>
                                </thead>
                                <tfoot>
                                    <tr>
                                        <th colspan="2"><label>Son</label></th>
                                        <td colspan="2" rowspan="2"><label id="lSon"></label></td>
                                        <th><label>Sub total</label></th>
                                        <td class="derecha"><label id="lSubTotal"></label></td>
                                    </tr>
                                    <tr>
                                        <td colspan="2"><label></label></td>
                                        <th><label>Descuento</label></th>
                                        <td class="derecha"><label id="lDescuento"></label></td>
                                    </tr>
                                    <tr>
                                        <th colspan="2" rowspan="3">Observa-<br> ciones</th>
                                        <td colspan="2" rowspan="4"><label style="text-align: justify;" id="lObservacion"></label></td>
                                        <th><label>Total</label></th>
                                        <td class="derecha"><label id="lTotal"></label></td>
                                    </tr>
                                    <tr>
                                        <th><label>IGV</label></th>
                                        <td class="derecha"><label id="lMontoIgv"></label></td>
                                    </tr>
                                    <tr>
                                        <th><label>Neto</label></th>
                                        <td class="derecha"><label id="lNeto"></label></td>
                                    </tr>
                                </tfoot>
                                <tbody>
                                    <tr>
                                        <td class="derecha"><span>1</span></td>
                                        <td></td>
                                        <td></td>
                                        <td></td>
                                        <td></td>
                                        <td></td>
                                    </tr>
                                    <tr>
                                        <td class="derecha"><span>2</span></td>
                                        <td></td>
                                        <td></td>
                                        <td></td>
                                        <td></td>
                                        <td></td>
                                    </tr>
                                </tbody>
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