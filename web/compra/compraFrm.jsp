<%-- 
    Document   : compraFrm
    Created on : 27/11/2012, 11:08:48 AM
    Author     : Henrri
--%>

<%@page import="otros.cUtilitarios"%>
<%@page import="personaClases.cProveedor"%>
<%@page import="tablas.Usuario"%>

<%    Usuario objUsuario = (Usuario) session.getAttribute("usuario");
    if (objUsuario == null) {
        session.removeAttribute("direccion");
        session.setAttribute("direccion", "compra/compraFrm.jsp");
        response.sendRedirect("../");
    } else {

%>

<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <title>Compra de articulos productos</title>
        <!--stilo inicio-->
        <link rel="stylesheet" type="text/css" href="../lib/propios/css/inicio/style.css" />
        <!--js query-->
        <script type="text/javascript" src="../lib/jquery/jquery-1.8.1.min.js"></script>
        <!--css js ui-->
        <link rel="stylesheet" type="text/css" href="../lib/jquery-ui/jquery-ui-1.10.0.custom/css/smoothness/jquery-ui-1.10.0.custom.min.css">
        <script type="text/javascript" src="../lib/jquery-ui/jquery-ui-1.9.0/jquery-ui-git.js"></script>
        <!--css frm-->
        <link rel="stylesheet" type="text/css" href="../lib/propios/css/tablas/tablas-reportes.css" media="screen"/>
        <!--css iconos-->
        <link rel="stylesheet" type="text/css" href="../lib/botones/sexybuttons.css">
        <!--css y js inicio menu-->
        <style>
            .ui-autocomplete {
                width: 400px;
                max-height: 500px;
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
        <!--inicio prpios-->
        <link type="text/css" rel="stylesheet" href="../lib/propios/css/tablas/tablas-reportes.css">
        <script type="text/javascript" src="../lib/propios/js/formatoDecimal.js"></script>
        <script type="text/javascript" src="../lib/propios/js/numeric/jquery.numeric.js"></script>
        <script src="../lib/jquery-ui/jquery-ui-1.10.0.custom/js/i18n/jquery.ui.datepicker-es.js"></script>

    </head>
    <body>
        <div id="wrap">

            <div id="header">
                <%@include file="../cabecera.jsp" %>
            </div>

            <div id="left"> 
                <%@include file="../menu2.jsp" %>
            </div>

            <div id="right">                
                <h3 class="titulo">CENTRO DE COMPRAS <a href="compraRegistrar.jsp">+</a> <label id="tit" style="float: right; margin-right: 130px">DOCUMENTO:</label></h3>
                <form id="compraFrm" method="post" action="../sCompra">
                    <input type="text" name="accionCompra" value="r" class="ocultar"/>
                    <br>
                    <table class="reporte-tabla-1" style="width: 100%;">
                        <thead>
                            <tr>
                                <th colspan="6" style="text-align: center;"><label style="font-weight: bold;">R E G I S T R A R &nbsp;&nbsp;&nbsp;&nbsp;C O M P R A</label></th>
                            </tr>
                        </thead>
                        <tfoot id="botones">
                            <tr>
                                <th colspan="6" style="text-align: center;">
                                    <button id="cancelar" class="sexybutton" type="button"><span><span><span class="cancel">Cancelar</span></span></span></button>&nbsp;&nbsp;
                                    <button id="restaurar" class="sexybutton" type="reset"><span><span><span class="redo">Restaurar</span></span></span></button>&nbsp;&nbsp;
                                    <button id="accion" class="sexybutton" type="submit"><span><span><span class="save">Registrar</span></span></span></button>
                                </th>
                            </tr>
                        </tfoot>
                        <tbody>
                            <tr>
                                <th style="width: 14%;"><label>Documento:</label></th>
                                <td style="width: 19%;"><input type="text" name="docSerieNumero" value="" id="docSerieNumero" style="width: 96%;"/></td>
                                <th style="width: 14%;"><label>Tipo de compra</label></th>
                                <td style="width: 19%;">
                                    <select id="tipo" name="tipo" style="width: 96%;">
                                        <option value="">Seleccione</option>
                                        <option value="0">Contado</option>
                                        <option value="1" selected="">Credito</option>
                                    </select>
                                </td>
                                <th style="width: 14%;"><label>Moneda</label></th>
                                <td style="width: 20%;">
                                    <select id="moneda" name="moneda" style="width: 96%;">
                                        <option value="">Seleccione</option>
                                        <option value="0" selected="">Soles</option>
                                        <option value="1">Dolares</option>
                                    </select>
                                </td>
                            </tr>
                            <tr>
                                <th>
                                    <label>Proveedor</label>
                                    <button class="sexybutton sexyicononly" type="button" id="bProveedorSeleccionar"><span><span><span class="add" id="sProveedorSeleccionar"></span></span></span></button>
                                </th>
                                <td colspan="5">
                                    <input type="hidden" name="codProveedor" id="codProveedor"/>
                                    <label id="lProveedor" ></label>
                                </td>
                            </tr>
                            <tr>
                                <th><label>Dirección</label></th>
                                <td colspan="5"><label id="lDireccion" ></td>
                            </tr>
                            <tr>
                                <th><label>F. Factura</label></th>
                                <td>
                                    <input id="fechaFactura" name="fechaFactura" type="text" value=""  style="width: 80%;" placeholder="dd/mm/yyyy"/>&nbsp;
                                </td>
                                <th><label>F. Vencimiento</label></th>
                                <td>
                                    <input id="fechaVencimiento" name="fechaVencimiento" type="text" value=""  style="width: 96%;" placeholder="dd/mm/yyyy"/>
                                </td>
                                <th><label>F. Llegada</label></th>
                                <td>
                                    <input id="fechaLlegada" name="fechaLlegada" type="text" value=""  style="width: 96%;" placeholder="dd/mm/yyyy"/>
                                </td>
                            </tr>
                            <tr>
                                <th colspan="6" style="text-align: center;"><label style="font-weight: bold;">D E T A L L E &nbsp;&nbsp;&nbsp;&nbsp;D E &nbsp;&nbsp;&nbsp;&nbsp;A R T Í C U L O S / P R O D U  CT O S</label></th>
                            </tr>
                            <tr>
                                <td colspan="6">
                                    <table style="width: 100%;">
                                        <thead>
                                            <tr>
                                                <th style="width: 22px;"><label>Item</label></th>
                                                <th style="width: 28px;"><label>Cant.</label></th>
                                                <th style="width: 55px;"><label>U. Medida</label></th>
                                                <th>
                                                    <label>Descripción</label>
                                                    <button type="button" id="bArticuloProductoAgregarDialogo" class="sexybutton sexyicononly"><span><span><span class="add"></span></span></span></button>
                                                    <input type="hidden" name="itemCantidad" value="0" id="itemCantidad"/>
                                                </th>
                                                <th style="width: 90px;"><label>P. Unitario</label></th>
                                                <th style="width: 90px;"><label>P. Total</label></th>
                                            </tr>
                                        </thead>
                                        <tfoot>
                                            <tr>
                                                <th colspan="2"><label>Son</label></th>
                                                <td colspan="2" rowspan="2"><label id="lSon"></label></td>
                                                <th><label>Sub total</label></th>
                                                <td style="text-align: right;"><label id="lSubTotal"></label></td>
                                            </tr>
                                            <tr>
                                                <td colspan="2"><label></label></td>
                                                <th><label>Descuento</label></th>
                                                <td style="text-align: right;">
                                                    <input type="text" name="descuento" value="" id="descuento" style="width: 94%;text-align: right;"/>
                                                </td>
                                            </tr>
                                            <tr>
                                                <th colspan="2" rowspan="3"><label>Observa- ciones</label></th>
                                                <td colspan="2" rowspan="4"><textarea style="width: 98%;height: 90%;" id="observacion" name="observacion"></textarea></td>
                                                <th><label>Total</label></th>
                                                <td style="text-align: right;"><label id="lTotal"></label></td>
                                            </tr>
                                            <tr>
                                                <th><label>IGV</label></th>
                                                <td style="text-align: right;"><label id="lMontoIgv">0.00</label></td>
                                            </tr>
                                            <tr>
                                                <th><label>Neto</label></th>
                                                <td style="text-align: right;"><label id="lNeto"></label></td>
                                            </tr>
                                        </tfoot>
                                        <tbody id="tbArticuloProducto">
                                        </tbody>
                                    </table>
                                </td>
                            </tr>
                        </tbody>
                        <input type="hidden" name="auxiliarArticuloProductoCambio" value="" id="auxiliarArticuloProductoCambio" /> 
                    </table>
                </form>
                <!--╔═══ div inicio seleccionar proveedor
                    ║-->
                <div id="dProveedorSeleccionar" title="Seleccione proveedor">
                    <input type="text" name="proveedorSeleccionar" id="proveedorSeleccionar" style="width: 700px;" placeholder="RUC / Razón Social"/>
                </div>
                <!--║
                    ╚═══ div fin seleccionar proveedor -->
                <!--╔═══ div inicio seleccionar articulo producto
                    ║-->
                <div id="dArticuloProductoAgregar" title="Seleccione Artículo/Producto">
                    <table class="reporte-tabla-1">
                        <thead>
                            <tr>
                                <th style="width: 30px;"><label>Item</label></th>
                                <th style="width: 30px;"><label>Cod</label></th>
                                <th style="width: 60px;"><label>Cantidad</label></th>
                                <th style="width: 100px;"><label>U.Medida</label></th>
                                <th style="width: 500px;"><label>Articulo</label></th>
                                <th><label>P. Unitario</label></th>
                                <th style="width: 50px;text-align: center;">S/N</th>
                            </tr>
                        </thead>
                        <tbody>
                            <tr>
                                <td style="text-align: right;"><label id="lItem"></label></td>
                                <td><input type="text" id="codArticuloProducto" name="codArticuloProducto" style="text-align: right;width: 40px;"/></td>
                                <td><input type="text" id="cantidad" name="cantidad" value="1" size="3" class="tamanio" style="text-align: right;width: 50px"/></td>
                                <td style="text-align: right;"><label id="lUnidadMedida"></label></td>
                                <td>                                    
                                    <input type="text" id="descripcion" name="descripcion" size="60" style="width: 97%;" placeholder="Buscar artículo/producto"/>
                                </td>
                                <td><input type="text" id="precioUnitario" name="precioUnitario" size="10" placeholder="0.0000" class="tamanio" style="text-align: right"/></td>
                                <td style="text-align: center;"><input type="checkbox" name="serieNumero" id="serieNumero" value="ON" class="serieNumero"/></td>
                            </tr>
                        </tbody>
                    </table>
                    <table class="reporte-tabla-1 ocultar" id="tSeriesNumeros">
                        <thead>
                            <tr>
                                <th style="width: 30px;">Item</th>
                                <th style="width: 500px;">Serie/Número</th>
                                <th style="width: 250px;">Observaciones</th>                                
                            </tr>
                        </thead>
                        <tbody id="seriesNumeros">
                            <%                                for (int i = 1; i <= 50; i++) {
                            %>
                            <tr id="trSerieNumero<%=i%>" class="ocultar">
                                <th><%=i%></th>
                                <td><textarea name="serieNumero<%=i%>" id="serieNumero<%=i%>"  style="width: 98%;" rows="5" ></textarea></td>
                                <td><textarea name="serieNumeroObservacion<%=i%>" id="serieNumeroObservacion<%=i%>" style="width: 98%;" rows="3" readonly=""></textarea></td>
                            </tr>
                            <%                                }
                            %>
                        </tbody>
                    </table>
                </div>
                <!--║
                    ╚═══ div fin seleccionar articulo producto-->
                <!--╔═══ div inicio editar articulo producto
                    ║-->
                <div id="dArticuloProductoEditar" title="Editar Artículo/Producto">
                    <table class="reporte-tabla-1">                            
                        <tr>
                            <th style="width: 30px;"><label>Item</label></th>
                            <th style="width: 30px;"><label>Cod</label></th>
                            <th style="width: 60px;"><label>Cantidad</label></th>
                            <th style="width: 100px;"><label>U.Medida</label></th>
                            <th style="width: 500px;"><label>Articulo</label></th>
                            <th><label>P. Unitario</label></th>
                        </tr>
                        <tr>
                            <td style="text-align: right;"><label id="lItemE"></label></td>
                            <td><input type="text" id="codArticuloProductoE" name="codArticuloProductoE" style="text-align: right;width: 40px;"/></td>
                            <td><input type="text" id="cantidadE" name="cantidadE" value="1" size="3" class="tamanio" style="text-align: right;width: 50px"/></td>
                            <td style="text-align: right;"><label id="lUnidadMedidaE"></label></td>
                            <td>
                                <input type="hidden" name="codArticuloProductoE" value="" id="codArticuloProductoE"/>
                                <input type="text" id="descripcionE" name="descripcionE" size="60" style="width: 97%;" placeholder="Buscar artículo/producto"/>
                            </td>
                            <td><input type="text" id="precioUnitarioE" name="precioUnitarioE" size="10" placeholder="0.0000" class="tamanio" style="text-align: right"/></td>
                        </tr>
                    </table>
                </div>
                <!--║
                    ╚═══ div fin editar articulo producto-->
                <!--
                ╔═══ div inicio accion articulo producto 
                ║
                -->
                <div id="dArticuloProductoAccionClic" title="Item 1">
                    <button type="button" class="sexybutton" id="bEditarArticuloProducto"><span><span><span class="edit">Editar</span></span></span></button>
                    <button type="button" class="sexybutton" id="bEliminarArticuloProducto"><span><span><span class="delete">Eliminar</span></span></span></button>
                    <br>
                    <br>
                    <table id="tSerieNumeroVista" class="reporte-tabla-1 ocultar">                        
                    </table>
                </div>
                <!--
                ║
                ╚═══ div fin accion articulo 
                -->
                <!--
                ╔═══ div inicio proveedor no seleccionado
                ║
                -->
                <div id="dProveedorNoSeleccionado" title="No ha seleccionado proveedor">
                    <div class="ui-widget">
                        <div class="ui-state-highlight ui-corner-all" style="margin-top: 20px; padding: 0 .7em;">
                            <p><span class="ui-icon ui-icon-info" style="float: left; margin-right: .3em;"></span>
                                <strong>Alerta!</strong> Para continuar con el registro es necesario seleccionar proveedor.</p>
                        </div>
                    </div>
                </div>
                <!--
                ║
                ╚═══ div fin proveedor no seleccionado
                -->
                <!--
                ╔═══ div inicio proveedor no seleccionado
                ║
                -->
                <div id="dArticuloProductoNoSeleccionado" title="No hay ningún Articulo agregado">
                    <div class="ui-widget">
                        <div class="ui-state-highlight ui-corner-all" style="margin-top: 20px; padding: 0 .7em;">
                            <p><span class="ui-icon ui-icon-info" style="float: left; margin-right: .3em;"></span>
                                <strong>Alerta!</strong> Para continuar con el registro es necesario como mínimo tener un <b>Artículo</b> comprado.</p>
                        </div>
                    </div>
                </div>
                <!--
                ║
                ╚═══ div fin proveedor no seleccionado
                -->
                <!--
                ╔═══ div inicio registro exitoso
                ║
                -->
                <div id="dRegistroExitoso" title="Registro exitoso">
                    <a name="bRegistroExitoVer" id="bRegistroExitoVer" class="sexybutton" href="#"><span><span><span class="search">Ver detalles</span></span></span></a>
                    <button name="bRegistroExitoNuevo" id="bRegistroExitoNuevo" class="sexybutton"><span><span><span class="add">Nuevo</span></span></span></button>
                </div>
                <!--
                ║
                ╚═══ div fin registro exitoso
                -->                
                <%--<%@include file="../errorServidor.jsp" %>--%>
                <!--<script type="text/javascript" src="../lib/propios/js/errorServidor.js"></script>-->
                <script type="text/javascript" src="../lib/jquery-validation/jquery-validation-1.10.0/js/jquery.validate.min.js"></script>
                <script type="text/javascript" src="../lib/jquery-validation/localization/messages_es.js"></script>
                <script type="text/javascript" src="../lib/jquery-validation/additional-methods.js"></script>
                <script type="text/javascript" src="../lib/jquery.maskedinput/jquery.maskedinput.min.js"></script>
                <script type="text/javascript" src="../lib/compra/compraFrm.js"></script>
                <script type="text/javascript" src="../lib/compra/compraFrmValidacion.js"></script>
            </div>

            <div style="clear: both;"> </div>

            <div id="footer">
                <%@include file="../piePagina.jsp" %>
            </div>
        </div>
    </body>
</html>
<%
    }
%>