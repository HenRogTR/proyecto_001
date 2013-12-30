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
        <script type="text/javascript" src="../librerias/compra/compraMantenimiento.js?v13.12.26"></script>
        <style>
            .ui-autocomplete {
                width: 400px;
                max-height: 300px;
                overflow-y: auto;
                /* prevent horizontal scrollbar */
                overflow-x: hidden;
            }
            /* IE 6 doesn't support max-height
            * we use height instead, but this forces the menu to always be this tall
            */
            * html .ui-autocomplete {
                height: 300px;
            }
        </style>
    </head>
    <body>
        <input type="hidden" name="paginaActualPermiso" id="permisoPaginaP39" value="" title="MANTENIMIENTO DE COMPRAS"/>
        <div id="wrap">
            <div id="header">
                <label class="horaCabecera"><%=objcManejoFechas.fechaCabecera()%></label>
            </div>
            <div id="right">
                <%
                    int codCompra = 0;
                    try {
                        codCompra = (Integer) session.getAttribute("codCompraMantenimiento");
                    } catch (Exception e) {
                    }
                %>
                <div id="rightSub1" class="ocultar">
                    <h3 class="titulo"><a href="compraRegistrar.jsp" class="sexybutton"><span><span><span class="add">Nueva compra</span></span></span></a> MANTENIMIENTO DE COMPRAS</h3>
                    <div class="ocultar">
                        <input type="text" name="codCompra" id="codCompra" value="<%=codCompra%>" />
                    </div>
                    <table class="reporte-tabla-1">
                        <tr>
                            <th class="ancho80px"><button class="sexybutton sexyicononly sexysimple sexysmall sexypropio" id="bEditar"><span class="search"></span></button><span>BUSCAR</span></th>
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
                                        <a class="sexybutton sexyicononly sexysimple sexysmall sexypropio" id="bImprimir" href="#"><span class="print"></span></a>
                                        <button class="sexybutton sexyicononly sexysimple sexysmall sexypropio" id="bEditar"><span class="edit"></span></button>
                                        <button class="sexybutton sexyicononly sexysimple sexysmall sexypropio" id="bAnular"><span class="delete"></span></button>
                                    </th>
                                </tr>
                            </thead>
                            <tbody>
                                <tr>
                                    <th>COD. OPERACIÓN</th>
                                    <td><div id="lCodCompra" class="vaciar esperando"></div></td>
                                    <th>DET. REGISTRO</th>
                                    <td colspan="3"><div id="lRegistro" class="vaciar esperando"></div></td>
                                </tr>
                                <tr>
                                    <th class="ancho120px">DOCUMENTO</th>
                                    <td><div id="lDocSerieNumero" class="vaciar esperando"></div></td>
                                    <th class="ancho140px">TIPO DE COMPRA</th>
                                    <td class="ancho120px"><div id="lTipo" class="vaciar esperando"></div></td>
                                    <th class="ancho140px">MONEDA</th>
                                    <td class="ancho120px"><div id="lMoneda" class="vaciar esperando"></div></td>
                                </tr>
                                <tr>
                                    <th>RUC</th>
                                    <td><div id="lRuc" class="vaciar esperando"></div><div class=></div</td>
                                    <th>RAZON SOCIAL</th>
                                    <td colspan="3"><div id="lRazonSocial" class="vaciar esperando"></div></td>
                                </tr>
                                <tr>
                                    <th>DIRECCIÓN</th>
                                    <td colspan="5"><div id="lDireccion" class="vaciar esperando"></div></div></td>
                                </tr>
                                <tr>
                                    <th>F. FACTURA</th>
                                    <td><div id="lFechaFactura" class="vaciar esperando"></div></div></td>
                                    <th>F. VENCIMIENTO</th>
                                    <td><div id="lFechaVencimiento" class="vaciar esperando"></div></div></td>
                                    <th>F. LLEGADA</th>
                                    <td><div id="lFechaLlegada" class="vaciar esperando"></div></div></td>
                                </tr>
                            </tbody>
                        </table>
                        <div style="padding: 5px;" class="tdFondoTh">
                            <table class="reporte-tabla-1 anchoTotal" style="font-size: 10px;">
                                <thead>
                                    <tr>
                                        <th style="width: 25px;"><label>Item</label></th>                                        
                                        <th style="width: 50px;">Código</th>
                                        <th style="width: 30px;"><label>Cant.</label></th>
                                        <th style="width: 55px;"><label>U. Medida</label></th>
                                        <th><label>Descripción</label></th>
                                        <th style="width: 65px;"><label>P. Unitario</label></th>
                                        <th style="width: 65px;"><label>P. Total</label></th>

                                    </tr>
                                </thead>
                                <tfoot>
                                    <tr>
                                        <th colspan="2"><label>Son</label></th>
                                        <td colspan="3" rowspan="2"><div id="lSon" class="vaciar esperando"></div></div></td>
                                        <th><label>Sub total</label></th>
                                        <td class="derecha"><div id="lSubTotal" class="vaciar esperando"></label></div></td>
                                    </tr>
                                    <tr>
                                        <td colspan="2"><label></label></td>
                                        <th><label>Descuento</label></th>
                                        <td class="derecha"><div id="lDescuento" class="vaciar esperando"></div></td>
                                    </tr>
                                    <tr>
                                        <th colspan="2" rowspan="3">Observa-<br> ciones</th>
                                        <td colspan="3" rowspan="4"><div id="lObservacion" class="vaciar esperando" style="text-align: justify;" ></div></div></td>
                                        <th><label>Total</label></th>
                                        <td class="derecha"><div id="lTotal" class="vaciar esperando"></div></div></td>
                                    </tr>
                                    <tr>
                                        <th><label>IGV</label></th>
                                        <td class="derecha"><div id="lMontoIgv" class="vaciar esperando"></div></div></td>
                                    </tr>
                                    <tr>
                                        <th><label>Neto</label></th>
                                        <td class="derecha"><div id="lNeto" class="vaciar esperando"></div></td>
                                    </tr>
                                </tfoot>
                                <tbody id="tbCompraDetalle">
                                    <tr>
                                        <td class="derecha"><div class="esperando"></div></td>
                                        <td class="derecha"><div class="esperando"></div></td>
                                        <td class="derecha"><div class="esperando"></div></td>
                                        <td class="derecha"><div class="esperando"></div></td>
                                        <td><div class="esperando"></div></td>
                                        <td class="derecha"><div class="esperando"></div></td>
                                        <td class="derecha"><div class="esperando"></div></td>
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