<%-- 
    Document   : ventaRegistrar
    Created on : 17/10/2013, 10:02:00 AM
    Author     : Henrri
--%>

<%@page import="java.util.Date"%>
<%@page import="utilitarios.cManejoFechas"%>
<%
    cManejoFechas objcManejoFechas = new cManejoFechas();
%>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <title>venta registrar</title>
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
        <script type="text/javascript" src="../librerias/plugin/placeholder/jquery.placeholder-min.js"></script>
        <script type="text/javascript" src="../librerias/jquery.validate/1.11.1/jquery.validate.min.js"></script>
        <script type="text/javascript" src="../librerias/jquery.validate/1.11.1/additional-methods.min.js"></script>
        <script type="text/javascript" src="../librerias/jquery.validate/1.11.1/localization/messages_es.js"></script>
        <script type="text/javascript" src="../librerias/plugin/mask/jquery.mask.min.js"></script>
        <script type="text/javascript" src="../librerias/jquery-ui/jquery-ui-1.10.3.custom/js/i18n/jquery.ui.datepicker-es-min.js"></script>
        <script type="text/javascript" src="../librerias/venta/ventaRegistrar.js?v14.01.29"></script>        
        <script type="text/javascript" src="../librerias/utilitarios/validaciones.js"></script>
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
        <input type="hidden" name="paginaActualPermiso" id="permisoPaginaP31" value="" title="REGISTRAR VENTA"/>
        <div id="wrap">
            <div id="header">
                <label class="horaCabecera"><%=objcManejoFechas.fechaCabecera()%></label>
            </div>
            <div id="right">
                <div id="rightSub1" class="ocultar">
                    <h3 class="titulo">REGISTRAR VENTA</h3>
                    <form id="formVentaRegistrar" action="../sVenta">
                        <div class="ocultar">
                            <label for="fechaAux">fechaAux</label><input type="text" name="fechaAux" id="fechaAux" value="<%=objcManejoFechas.DateAString(new Date())%>"/>
                            <label for="codPersona">codPersona</label><input type="text" name="codPersona" id="codPersona" value="" class="limpiar" />
                            <label for="codCliente">codCliente</label><input type="text" name="codCliente" id="codCliente" value="" class="limpiar" />
                            <br>
                            <label for="codVendedor">codVendedor</label><input type="text" name="codVendedor" id="codVendedor" value="" class="limpiar"/>
                            <label for="itemCantidad">itemCantidad</label><input type="text" name="itemCantidad" id="itemCantidad" value="0" />
                            <label for="auxiliarGenerarLetraCredito">auxiliarGenerarLetraCredito</label><input type="text" name="auxiliarGenerarLetraCredito" id="auxiliarGenerarLetraCredito" value="0"/>
                            <br>
                            <label for="itemCantidadAux">itemCantidadAux</label><input type="text" name="itemCantidadAux" id="itemCantidadAux" value="" class="" />
                            <label for="periodoLetra">periodoLetra</label><input type="text" name="periodoLetra" id="periodoLetra" value="mensual"/>
                            <label for="cantidadLetras">cantidadLetras</label><input type="text" name="cantidadLetras" id="cantidadLetras" value="" />
                            <br>
                            <label for="fechaInicioLetras">fechaInicioLetras</label><input type="text" name="fechaInicioLetras" id="fechaInicioLetras" value="" />
                            <label for="montoInicialLetra">montoInicialLetra</label><input type="text" name="montoInicialLetra" id="montoInicialLetra" value="" />                    
                            <label for="fechaVencimientoInicial">fechaVencimientoInicial</label><input type="text" name="fechaVencimientoInicial" id="fechaVencimientoInicial" value=""/>
                            <br>
                            <label for="codVenta">codVenta</label><input type="text" name="codVenta" id="codVenta" value=""/>
                        </div>
                        <table class="reporte-tabla-1">
                            <thead>
                                <tr>
                                    <th colspan="6">CENTRO DE VENTAS</th>
                                </tr>
                            </thead>
                            <tfoot>
                                <tr id="trBoton">
                                    <th colspan="6" class="centrado">
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
                                    <th class="ancho120px"><label for="tipo">T. VENTA</label></th>
                                    <td class="ancho140px contenedorEntrada">
                                        <select name="tipo" id="tipo" class="limpiar entrada anchoTotal">
                                            <option value="">--</option>
                                            <option value="contado">CONTADO</option>
                                            <option value="credito">CRÉDITO</option>
                                        </select>
                                    </td>
                                    <th class="ancho120px"><label for="fecha">F. VENTA</label></th>
                                    <td class="ancho140px contenedorEntrada">
                                        <input type="text" name="fecha" id="fecha" value="<%=objcManejoFechas.DateAString(new Date())%>" class="limpiar entrada anchoTotal" placeholder="dd/mm/yyyy" />
                                    </td>
                                </tr>
                                <tr>
                                    <th>CLIENTE <button class="sexybutton sexyicononly sexysimple sexysmall sexypropio" type="button" id="bClienteBuscar"><span class="search"></span></button></th>
                                    <td colspan="3">
                                        <span id="lClienteNombresC" class="vaciar"></span>
                                    </td>
                                    <th>CRED. MÁX</th>
                                    <td><span id="lClienteCreditoMax" class="vaciar"></span></td>
                                </tr>
                                <tr>
                                    <th>DIRECCIÓN</th>
                                    <td colspan="5"><span id="lClienteDireccion" class="vaciar"></span></td>
                                </tr>
                                <tr>
                                    <th>DNI/PASAPORTE</th>
                                    <td><span id="lClienteDniPasaporte" class="vaciar"></span></td>
                                    <th>RUC</th>
                                    <td><span id="lClienteRuc" class="vaciar"></span></td>
                                    <th>MONEDA</th>
                                    <td class="contenedorEntrada">
                                        <select id="moneda" name="moneda" class="limpiar entrada anchoTotal">
                                            <option value="">---</option>
                                            <option value="soles" selected="">SOLES</option>
                                            <option value="dolares">DÓLARES</option>
                                        </select>
                                    </td>
                                </tr>
                                <tr>
                                    <th>EMPRESA</th>
                                    <td colspan="3"><span id="lClienteEmpresaConvenio" class="vaciar"></span></td>
                                    <th>CONDICIÓN</th>
                                    <td><span id="lClienteCondicion" class="vaciar"></span></td>
                                </tr>
                                <tr>
                                    <th>VENDEDOR <button class="sexybutton sexyicononly sexysimple sexysmall sexypropio" type="button" id="bVendedorBuscar"><span class="search"></span></button></th>
                                    <td colspan="3">
                                        <span id="lVendedorNombresC" class="vaciar"></span>
                                    </td>
                                    <th>LETRAS CRÉD.</th>
                                    <td class="centrado"><button class="sexybutton disabled" type="button" id="bLetraCreditoGenerar" disabled=""><span><span><span class="add">Generar</span></span></span></button></td>
                                </tr>
                                <tr>
                                    <td colspan="6" class="tdFondoTh">
                                        <table style="font-size: 10px !important;" class="anchoTotal">
                                            <thead style="font-size: 12px;">
                                                <tr>
                                                    <th style="width: 25px;">Item</th>
                                                    <th style="width: 35px;">Código</th>
                                                    <th style="width: 30px;">Cant.</th>
                                                    <th style="width: 35px;">U.M.</th>
                                                    <th class="centrado">
                                                        Descripción <button class="sexybutton sexyicononly sexysimple sexysmall sexypropio" type="button" id="bArticuloProducto"><span class="add"></span></button>
                                                    </th>
                                                    <th style="width: 60px;">P. U.</th>
                                                    <th style="width: 60px;">P. Total</th>
                                                </tr>
                                            </thead>
                                            <tfoot>
                                                <tr>
                                                    <th>Son:</label></th>
                                                    <td colspan="4"><span id="lSon" class="vaciar"></span></td>
                                                    <th>Sub Total</th>
                                                    <td class="derecha"><span id="lSubTotal" class="vaciar"></span></td>
                                                </tr>
                                                <tr>
                                                    <th colspan="2">Observación</th>
                                                    <td colspan="3" rowspan="4" class="contenedorEntrada"><textarea id="observacion" name="observacion" class="anchoTotal altoTotal limpiar entrada" rows="5"></textarea></td>
                                                    <th>Descuento</th>
                                                    <td class="derecha contenedorEntrada"><input type="text" name="descuento" id="descuento" value="" class="derecha anchoTotal limpiar entrada" style="font-size: 11px;"/></td>
                                                </tr>
                                                <tr>
                                                    <td colspan="2"></td>
                                                    <th>Total</th>
                                                    <td class="derecha"><span id="lTotal" class="vaciar"></span></td>
                                                </tr>
                                                <tr>
                                                    <td colspan="2"></td>
                                                    <th>IGV</th>
                                                    <td class="derecha"><span id="lMontoIgv"></span></td>
                                                </tr>
                                                <tr>
                                                    <td colspan="2"></td>
                                                    <th>Neto</th>
                                                    <td class="derecha"><span id="lNeto" class="vaciar"></span></td>
                                                </tr>
                                            </tfoot>
                                            <tbody id="tbArticuloProducto" class="vaciar">
                                            </tbody>
                                        </table>
                                    </td>
                                </tr>
                            </tbody>
                        </table>
                    </form>
                    <!--dialogos-->
                    <div id="dClienteBuscar" title="Seleccione cliente" class="contenedorEntrada">
                        <input type="search" name="clienteBuscar" id="clienteBuscar" value="" class="anchoTotal entrada"/>
                    </div>
                    <div id="dVendedorBuscar" title="Seleccione vendedor" class="contenedorEntrada">
                        <input type="search" name="vendedorBuscar" id="vendedorBuscar" value="" class="anchoTotal entrada"/>
                    </div>
                    <div id="dArticuloProducto" title="Seleccione Artículo/Producto">
                        <table class="reporte-tabla-2 anchoTotal">
                            <thead>
                                <tr>
                                    <th style="width: 50px;"><span>Item</span></th>
                                    <th style="width: 90px;"><span>Cod</span></th>
                                    <th style="width: 90px;"><span>Cantidad</span></th>
                                    <th style="width: 80px;"><span>U.Medida</span></th>
                                    <th class="centrado"><span style="margin-right: 30px;">Artículo</span>Stock: <span id="lStock"></span></th>
                                    <th style="width: 100px;"><span>P. Proforma</span></th>
                                    <th style="width: 100px;"><span>P. Venta</span></th>
                                    <th style="width: 30px;" class="centrado">S/N</th>
                                </tr>
                            </thead>
                            <tbody>
                                <tr>
                                    <td class="derecha contenedorEntrada"><span id="lItem" class="vaciar"></span></td>
                                    <td class="contenedorEntrada"><input type="search" name="codArticuloProducto" id="codArticuloProducto" value="" class="derecha entrada2 anchoTotal limpiar"/></td>
                                    <td class="contenedorEntrada"><input type="text" name="cantidad" id="cantidad" value="1" class="derecha entrada2 anchoTotal" /></td>
                                    <td><span id="lUnidadMedida" class="vaciar"></span></td>
                                    <td class="contenedorEntrada alto40px"><textarea class="anchoTotal altoTotal" name="descripcion" id="descripcion"></textarea></td>
                                    <!--<td class="contenedorEntrada"><input type="search" name="descripcion" id="descripcion" value="" class="izquierda entrada2 anchoTotal limpiar" /></td>-->
                                    <td class="derecha"><span id="lPrecioContado"></span> <img src="../librerias/botonesIconos/images/icons/silk/pencil.png" id="bPrecioContadoEditar"></td>
                                    <td class="contenedorEntrada"><input type="text" name="precioVenta" id="precioVenta" class="derecha anchoTotal limpiar entrada2" placeholder="0.00"/></td>
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
                                    </tbody>
                                </table>
                            </div>
                        </div>
                    </div>
                    <!--precioSugeridoEditar-->
                    <div id="dPrecioContadoEditar" title="Cambiar precio proforma">
                        <table class="reporte-tabla-1">
                            <tr>
                                <th style="width: 200px;">P. Contado Actual</th>
                                <td style="width: 200px;">S/. <label id="lPrecioContadoActual"></label></td>
                            </tr>
                            <tr>
                                <th>P. Proforma Nuevo</th>
                                <td class="derecha">S/. <input id="precioContadoNuevo"/></td>
                            </tr>
                        </table>
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
                    <div id="dGenerarLetrasCredito" title="Generación de letras de pago">
                        <table class="reporte-tabla-1" style="width: 100%;font-size: 11px;">
                            <thead>
                                <tr>
                                    <th style="width: 33%; text-align: center;" colspan="2"><label>LETRAS</label></th>
                                    <th style="text-align: center;" colspan="2"><label>VENCIMIENTO</label></th>
                                    <th colspan="2" style="width: 33%; text-align: center;"><label>MONTO</label></th>
                                </tr>
                            </thead>
                            <tfoot>
                                <tr>
                                    <th style="width: 70px;"><label>Neto</label></th>
                                    <td style="width: 80px;text-align: right;"><label id="lNetoLetras">0.00</label></td>
                                    <th style="width: 70px;"><label>N° Cuotas</label></th>
                                    <td style="width: 80px;">
                                        <input type="text" name="numeroLetras" id="numeroLetras" value="1" style="width: 95%;text-align: right"/>
                                    </td>
                                    <th style="width: 70px;"><label>F. Inicio</label></th>
                                    <td style="width: 80px;">
                                        <input type="text" name="fechaInicio" id="fechaInicio" value="<%=objcManejoFechas.fechaSumarDias(new Date(), 30)%>" style="width: 95%;" />
                                    </td>
                                </tr>
                                <tr>
                                    <th><label>Inicial</label></th>
                                    <td>
                                        <input type="text" name="montoInicial" id="montoInicial" value="0" style="width: 95%;text-align: right;"/>
                                    </td>
                                    <th><label>Vencimiento</label></th>
                                    <td>
                                        <input type="text" name="fechaVencimiento" id="fechaVencimiento" value="<%=objcManejoFechas.DateAString(new Date())%>" style="width: 95%;" readonly=""/>
                                    </td>
                                    <th><label>Monto Cuota</label> <label style="color: red;">*</label></th>
                                    <td style="text-align: right;">
                                        <label id="lMontoCuota">0.00</label>
                                    </td>
                                </tr>
                                <tr>
                                    <th colspan="2"><label>Periodo (Letras)</label></th>
                                    <td colspan="4">
                                        <input type="radio" name="periodoLetra" value="mensual" id="mensual" checked="checked"/><label for="mensual">Mensual</label>&nbsp;&nbsp;
                                        <input type="radio" name="periodoLetra" value="quincenal" id="quincenal"/><label for="quincenal">Quincenal</label>&nbsp;&nbsp;
                                        <input type="radio" name="periodoLetra" value="semanal" id="semanal"/><label for="semanal">Semanal</label>
                                    </td>
                                </tr>
                                <tr>
                                    <td colspan="6" style="font-size: 10px; color: red;">(*) Monto referencial</td>
                                </tr>
                            </tfoot>
                            <tbody>
                                <tr>
                                    <td colspan="6">
                                        <div style="width: 100%;height: 300px;overflow: auto;">
                                            <table style="width: 100%;">
                                                <thead>
                                                </thead>
                                                <tbody id="tbDetalleLetras">

                                                </tbody>
                                            </table>
                                        </div>
                                    </td>
                                </tr>
                            </tbody>
                        </table>
                    </div>
                    <div id="dVentaRegistrarExito" title="Registro exitoso" style="text-align: justify;">
                        Se ha registrado correctamente la venta.<br>
                        Seleccione la opción a realizar.
                    </div>
                    <div id="dVentaRegistrarConfirmar" title="Confirmar venta">
                        <table class="reporte-tabla-1 anchoTotal">
                            <tr>
                                <th class="ancho80px">DOCUMENTO</th>
                                <td class="ancho160px"><span id="lMostrar1" class="vaciar"></span></td>
                                <th class="ancho80px">TIPO</th>
                                <td class="ancho160px"><span id="lMostrar2" class="vaciar"></span></td>
                                <th class="ancho80px">FECHA</th>
                                <td><span id="lMostrar3" class="vaciar"></span></td>
                            </tr>
                            <tr id="trMostrarVC" class="ventaCredito">
                                <td colspan="6">
                                    <div class="tdFondoTh">
                                        <table class="anchoTotal">
                                            <tr>
                                                <th class="ancho120px">Monto Inicial</th>
                                                <td class="ancho200px"><span id="lMostrar4" class="vaciar"></span></td>
                                                <th class="ancho120px">F. Vencimiento Ini</th>
                                                <td><span id="lMostrar5" class="vaciar"></span></td>
                                            </tr>
                                            <tr>
                                                <th>N° Letras</th>
                                                <td><span id="lMostrar6" class="vaciar"></span></td>
                                                <th>Periódo</th>
                                                <td><span id="lMostrar7" class="vaciar"></span></td>
                                            </tr>
                                            <tr>
                                                <th>Monto letra</th>
                                                <td><span id="lMostrar8" class=""></span></td>
                                                <th>Inicio Letras Fec</th>
                                                <td><span id="lMostrar9" class="vaciar"></span></td>
                                            </tr>
                                        </table>
                                    </div>
                                </td>
                            </tr>
                            <tr>
                                <th>CLIENTE</th>
                                <td colspan="5"><span id="lMostrar10" class="vaciar"></span></td>
                            </tr>
                            <tr>
                                <th>VENDEDOR</th>
                                <td colspan="5"><span id="lMostrar11" class="vaciar"></span></td>
                            </tr>
                            <tr>
                                <td colspan="6">
                                    <div class="tdFondoTh">                                        
                                        <table style="font-size: 10px !important;" class="anchoTotal">
                                            <thead>
                                                <tr>
                                                    <th colspan="6" class="centrado">RESUMEN DE ARTÍCULOS</th>
                                                </tr>
                                                <tr>
                                                    <th class="ancho40px">Item</th>
                                                    <th class="ancho40px">Cant</th>
                                                    <th>Descripcion</th>
                                                    <th class="ancho80px">P. Total</th>
                                                </tr>
                                            </thead>
                                            <tfoot>
                                                <tr>
                                                    <th colspan="3">Neto</th>
                                                    <td class="derecha"><span id="lMostrar12" class="vaciar"></span></td>
                                                </tr>
                                            </tfoot>
                                            <tbody id="tbAPMostrar" class="vaciar">
                                                
                                            </tbody>
                                        </table>
                                    </div>
                                </td>
                            </tr>
                        </table>
                        <div class="ui-state-highlight ui-corner-all" style="margin-top: 20px; padding: 0 .7em;">
                            <p><span class="ui-icon ui-icon-info" style="float: left; margin-right: .3em;"></span>
                                <strong>¡Atención!</strong> Sr. Usuario revise los datos antes de continuar con el registro.</p>
                        </div>
                    </div>
                </div>                
                <%@include file="../principal/div2.jsp" %>
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