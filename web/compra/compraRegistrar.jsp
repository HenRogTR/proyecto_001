<%-- 
    Document   : compraRegistrar
    Created on : 18/10/2013, 07:20:04 PM
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
        <title>compra registrar</title>
        <!--todos-->
        <script type="text/javascript" src="../librerias/jquery/jquery-1.9.0-min.js" ></script>
        <script type="text/javascript" src="../librerias/jquery/jquery.timer-min.js" ></script>
        <script type="text/javascript" src="../librerias/jquery-ui/jquery-ui-1.10.3.custom/js/jquery-ui-1.10.3.custom.min.js" ></script>
        <link rel="stylesheet" type="text/css" href="../librerias/principal/todos.css" media="all"/>
        <!--cambios-->
        <%@include file="../principal/inclusiones.jsp" %>
        <!--propio-->
        <script type="text/javascript" src="../librerias/utilitarios/manejoFecha.js"></script>
        <script type="text/javascript" src="../librerias/utilitarios/formatoDecimal.js"></script>
        <script type="text/javascript" src="../librerias/jquery-ui/jquery-ui-1.10.3.custom/js/i18n/jquery.ui.datepicker-es-min.js"></script>
        <script type="text/javascript" src="../librerias/plugin/mask/jquery.mask.min.js"></script>
        <script type="text/javascript" src="../librerias/compra/compraRegistrar.js?v13.12.26"></script>
        <style>
            .ui-autocomplete {
                width: 400px;
                max-height: 400px;
                overflow-y: auto;
                /* prevent horizontal scrollbar */
                overflow-x: hidden;
            }
            /* IE 6 doesn't support max-height
            * we use height instead, but this forces the menu to always be this tall
            */
            * html .ui-autocomplete {
                height: 400px;
            }
        </style>
    </head>
    <body>
        <input type="hidden" name="paginaActualPermiso" id="permisoPaginaP39" value="" title=""/>
        <div id="wrap">
            <div id="header">
                <label class="horaCabecera"><%=objcManejoFechas.fechaCabecera()%></label>
            </div>
            <div id="right">
                <div id="rightSub1" class="ocultar">
                    <h3 class="titulo">REGISTRAR COMPRA<a class="sexybutton"  href="compraFrm.jsp"><span><span><span class="info">Version antigua</span></span></span></a></h3>
                    <form id="formCompraRegistrar" action="../sCompra">
                        <input type="text" name="accionCompra" id="accionCompra" value="registrar" class="ocultar"/>
                        <table class="reporte-tabla-1">
                            <thead>
                                <tr>
                                    <th colspan="6">CENTRO DE COMPRAS</th>
                                </tr>
                            </thead>                            
                            <tfoot>
                                <tr id="trBoton">
                                    <th colspan="6">
                                        <button class="sexybutton" type="button" id="bCancelar"><span><span><span class="cancel">Cancelar</span></span></span></button>
                                        <button class="sexybutton" type="reset" id="bRestaurar"><span><span><span class="redo">Restaurar</span></span></span></button>
                                        <button class="sexybutton" type="submit" id="bRegistrar"><span><span><span class="save">Registrar</span></span></span></button>
                                    </th>
                                </tr>
                            </tfoot>
                            <tbody>
                                <tr>
                                    <th class="ancho120px"><label for="docSerieNumero">DOCUMENTO</label></th>
                                    <td class="ancho140px contenedorEntrada"><input type="text" name="docSerieNumero" id="docSerieNumero" value="" class="limpiar mayuscula entrada anchoTotal" placeholder="F-001-000001"/></td>
                                    <th class="ancho120px"><label for="tipo">T. COMPRA</label></th>
                                    <td class="ancho140px contenedorEntrada">
                                        <select name="tipo" id="tipo" class="limpiar entrada anchoTotal">
                                            <option value="">---</option>
                                            <option value="0">CONTADO</option>
                                            <option value="1" selected="">CRÉDITO</option>
                                        </select>
                                    </td>
                                    <th class="ancho120px"><label for="moneda">MONEDA</label></th>
                                    <td class="ancho140px contenedorEntrada">
                                        <select id="moneda" name="moneda" class="limpiar entrada anchoTotal">
                                            <option value="">---</option>
                                            <option value="0" selected="">SOLES</option>
                                            <option value="1">DÓLARES</option>
                                        </select>
                                    </td>
                                </tr>
                                <tr>
                                    <th>RUC <button class="sexybutton sexyicononly sexysimple sexysmall sexypropio" type="button" id="bProveedorBuscar"><span class="search"></span></button></th>
                                    <td>
                                        <input type="text" name="codProveedor" id="codProveedor" value="" class="limpiar ocultar"/>
                                        <span id="lProveedorRuc" class="vaciar"></span>
                                    </td>
                                    <th>RAZON SOCIAL</th>
                                    <td colspan="3"><span id="lProveedorRazonSocial" class="vaciar"></span></td>
                                </tr>
                                <tr>
                                    <th>DIRECCIÓN</th>
                                    <td colspan="5"><span id="lProveedorDireccion" class="vaciar"></span></td>
                                </tr>
                                <tr>
                                    <th><label for="fechaFactura">F. FACTURA</label></th>
                                    <td class="contenedorEntrada"><input type="text" name="fechaFactura" id="fechaFactura" value="" class="anchoTotal entrada limpiar" placeholder="dd/mm/yyyy"/></td>
                                    <th><label for="fechaLlegada">F. LLEGADA</label></th>
                                    <td class="contenedorEntrada"><input type="text" name="fechaLlegada" id="fechaLlegada" value="" class="anchoTotal entrada limpiar" placeholder="dd/mm/yyyy"/></td>
                                    <th><label for="fechaVencimiento">F. VENCIMIENTO</label></th>
                                    <td class="contenedorEntrada"><input type="text" name="fechaVencimiento" id="fechaVencimiento" value="" class="anchoTotal entrada limpiar" placeholder="dd/mm/yyyy"/></td>
                                </tr>
                                <tr>
                                    <th colspan="6">
                            <table style="font-size: 10px !important;" class="anchoTotal">
                                <thead>
                                    <tr>
                                        <th style="width: 30px;">Item</th>
                                        <th style="width: 30px;">Cant.</th>
                                        <th style="width: 45px;">Cod.</th>
                                        <th style="width: 45px;">U. M.</th>
                                        <th class="centrado medio">
                                            Descripción <button class="sexybutton sexyicononly sexysimple sexysmall sexypropio" type="button" id="bArticuloProductoAgregar"><span class="add"></span></button>
                                            <input type="text" name="itemCantidad" id="itemCantidad" value="0" class="ocultar"/>
                                            <input type="text" name="itemCantidadAux" id="itemCantidadAux" value="" class="ocultar" /> 
                                        </th>
                                        <th style="width: 60px;">P. Unit.</th>
                                        <th style="width: 60px;">P. Total</th>
                                    </tr>
                                </thead>
                                <tfoot>
                                    <tr>
                                        <th>Son:</label></th>
                                        <td colspan="4" id="lSon" class="vaciar"></td>
                                        <th>Sub Total</th>
                                        <td style="text-align: right;" id="lSubTotal" class="vaciar"></td>
                                    </tr>
                                    <tr>
                                        <th colspan="2">Observación</th>
                                        <td colspan="3" rowspan="4" id="lObservacion" class="vaciar"></td>
                                        <th>Descuento</th>
                                        <td class="contenedorEntrada">
                                            <input type="text" name="descuento" value="0.00" id="descuento" class="limpiar derecha anchoTotal"/>
                                        </td>
                                    </tr>
                                    <tr>
                                        <td colspan="2"></td>
                                        <th>Total</th>
                                        <td style="text-align: right;" id="lTotal" class="vaciar"></td>
                                    </tr>
                                    <tr>
                                        <td colspan="2"></td>
                                        <th>IGV</th>
                                        <td class="derecha"><span id="lMontoIgv">0.00</span></td>
                                    </tr>
                                    <tr>
                                        <td colspan="2"></td>
                                        <th>Neto</th>
                                        <td style="text-align: right;" id="lNeto" class="vaciar"></td>
                                    </tr>
                                </tfoot>
                                <tbody id="tbArticuloProducto">
                                    <!--                                    <tr id="trArticuloProducto1">
                                                                            <td class="derecha"><span id="lItem1" class="vaciar">1</span></td>
                                                                            <td class="derecha">
                                                                                <input type="text" name="cantidad1" id="cantidad1" value="2" class="limpiar ocultar" />
                                                                                <span id="lCantidad1" class="vaciar">2</span>
                                                                            </td>
                                                                            <td class="derecha">
                                                                                <input type="text" name="codArticuloProducto1" id="codArticuloProducto1" value="00000001" class="limpiar ocultar" />
                                                                                <span id="lCodArticuloProducto1" class="vaciar">00000001</span>
                                                                            </td>
                                                                            <td class="derecha">
                                                                                <span id="lUnidad1" class="vaciar">UNIDAD</span>
                                                                            </td>
                                                                            <td class="izquierda">
                                                                                <span id="lDescripcion1" class="vaciar">TV DAEWOO 21" MOD DTH-21S9</span>
                                                                                <div id="dSerieNumeroMostrar1" style="padding-left: 15px;">
                                                                                    7dskfldskldks<br>
                                                                                    dfgfdgfgfdg<br>
                                                                                </div>
                                                                                <div id="dSerieNumero1">
                                                                                    <textarea id="item1SerieNumero1" name="item1SerieNumero1" class="limpiar mayuscula ocultar">7dskfldskldks</textarea>
                                                                                    <textarea id="item1SerieNumeroObservacion1" name="item1SerieNumeroObservacion1" class="limpiar mayuscula ocultar"></textarea>
                                                                                    <textarea id="item1SerieNumero2" name="item1SerieNumero2" class="limpiar mayuscula ocultar">dfgfdgfgfdg</textarea>
                                                                                    <textarea id="item1SerieNumeroObservacion2" name="item1SerieNumeroObservacion2" class="limpiar mayuscula ocultar"></textarea>
                                                                                </div>
                                                                            </td>
                                                                            <td class="derecha">
                                                                                <input type="text" name="precioUnitario1" id="precioUnitario1" value="100.00" class="limpiar ocultar" />
                                                                                <span id="lPrecioUnitario1" class="vaciar">100.00</span>
                                                                            </td>
                                                                            <td class="derecha">
                                                                                <input type="text" name="precioTotal1" id="precioTotal1" value="200.00" class="limpiar ocultar"/>
                                                                                <span id="lPrecioTotal1" class="vaciar">200.00</span>
                                                                            </td>
                                                                        </tr>-->
                                </tbody>
                            </table>
                            </th>
                            </tr>
                            </tbody>
                        </table>
                    </form>
                    <!--dialogos-->
                    <div id="dProveedorBuscar" title="Seleccione proveedor" class="contenedorEntrada">
                        <input type="search" name="proveedorBuscar" id="proveedorBuscar" value="" class="anchoTotal entrada" placeholder="Ingrese ruc o razón social para buscar un proveedor"/>
                    </div>
                    <div id="dArticuloProductoAgregar" title="Seleccione Artículo/Producto">
                        <table class="reporte-tabla-2 anchoTotal">
                            <thead>
                                <tr>
                                    <th style="width: 50px;"><span>Item</span></th>
                                    <th style="width: 90px;"><span>Cod</span></th>
                                    <th style="width: 90px;"><span>Cantidad</span></th>
                                    <th style="width: 100px;"><span>U.Medida</span></th>
                                    <th><span>Artículo</span></th>
                                    <th style="width: 100px;"><span>P. Unitario</span></th>
                                    <th style="width: 30px;" class="centrado">S/N</th>
                                </tr>
                            </thead>
                            <tbody>
                                <tr>
                                    <td class="medio derecha contenedorEntrada"><span id="lItem" class="vaciar"></span></td>
                                    <td class="contenedorEntrada"><input type="search" name="codArticuloProducto" id="codArticuloProducto" value="" class="derecha entrada2 anchoTotal limpiar"/></td>
                                    <td class="contenedorEntrada"><input type="text" name="cantidad" id="cantidad" value="1" class="derecha entrada2 anchoTotal" /></td>
                                    <td class="medio"><span id="lUnidadMedida" class="vaciar"></span></td>
                                    <td class="contenedorEntrada"><input type="search" name="descripcion" id="descripcion" value="" class="izquierda entrada2 anchoTotal limpiar" /></td>
                                    <td class="contenedorEntrada"><input type="text" name="precioUnitario" id="precioUnitario" class="derecha anchoTotal limpiar entrada2" placeholder="0.0000"/></td>
                                    <td><input type="checkbox" name="serieNumero" id="serieNumero" value="ON"/></td>
                                </tr>
                            </tbody>
                        </table>
                        <div class="anchoTotal ocultar" style="margin-top: 20px;" id="dSerieNumero">
                            <table class="reporte-tabla-1 anchoTotal">
                                <thead>
                                    <tr>
                                        <th class="ancho40px">Item</th>
                                        <th class="ancho400px">Serie/Número</th>
                                        <th>Observaciones</th>                                
                                    </tr>
                                </thead>
                            </table>
                            <div style="overflow: auto;height: 430px;">
                                <table class="reporte-tabla-1 anchoTotal">
                                    <tbody id="tSerieNumero">
                                        <%
                                            for (int i = 1; i <= 50; i++) {
                                        %>
                                        <tr id="trSerieNumero<%=i%>" class="ocultar trSerieNumero">
                                            <th class="ancho40px"><%=i%></th>
                                            <td class="ancho400px contenedorEntrada"><textarea name="serieNumero<%=i%>" id="serieNumero<%=i%>"  class="anchoTotal alto60px limpiar mayuscula"></textarea></td>
                                            <td class="contenedorEntrada"><textarea name="serieNumeroObservacion<%=i%>" id="serieNumeroObservacion<%=i%>" class="anchoTotal alto60px limpiar mayuscula"></textarea></td>
                                        </tr>
                                        <%                                }
                                        %>
                                    </tbody>
                                </table>
                            </div>
                        </div>
                    </div>
                    <div id="dItemAccionDobleClic" title="Item 1">
                        <table class="reporte-tabla-1 anchoTotal">
                            <thead>
                                <tr>
                                    <th style="width: 40px;"><span>Item</span></th>
                                    <th><span>Artículo</span></th>
                                </tr>
                            </thead>
                            <tbody>
                                <tr>                                    
                                    <td class="medio derecha contenedorEntrada"><span id="lItemMostrar" class="vaciar"></span></td>
                                    <td class="contenedorEntrada"><span id="lDescripcionMostrar"></span></td>
                                </tr>
                            </tbody>
                        </table>
                    </div>
                </div>
                <div id="rightSub2" class="ocultar">
                    <div>
                        <h3 class="titulo">IMPORTADORA YUCRA S.A.C.</h3>
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