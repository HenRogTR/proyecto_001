<%-- 
    Document   : ventaEditar
    Created on : 18/11/2013, 07:39:52 PM
    Author     : Henrri
--%>

<%@page import="personaClases.cPersona"%>
<%@page import="tablas.Persona"%>
<%@page import="personaClases.cDatosCliente"%>
<%@page import="tablas.DatosCliente"%>
<%@page import="tablas.VentasSerieNumero"%>
<%@page import="utilitarios.cOtros"%>
<%@page import="tablas.VentasDetalle"%>
<%@page import="java.util.Iterator"%>
<%@page import="ventaClases.cVentasDetalle"%>
<%@page import="java.util.List"%>
<%@page import="java.util.Date"%>
<%@page import="ventaClases.cVenta"%>
<%@page import="tablas.Ventas"%>
<%@page import="utilitarios.cManejoFechas"%>
<%
    cManejoFechas objcManejoFechas = new cManejoFechas();
%>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <title>editar venta</title>
        <!--todos-->
        <script type="text/javascript" src="../librerias/jquery/jquery-1.9.0-min.js" ></script>
        <script type="text/javascript" src="../librerias/jquery/jquery.timer-min.js" ></script>
        <script type="text/javascript" src="../librerias/jquery-ui/jquery-ui-1.10.3.custom/js/jquery-ui-1.10.3.custom.min.js" ></script>
        <link rel="stylesheet" type="text/css" href="../librerias/principal/todos.css" media="all"/>
        <!--cambios-->
        <%@include file="../principal/inclusiones.jsp" %>
        <!--propio-->
        <script type="text/javascript" src="../librerias/venta/ventaEditar.js"></script>
    </head>
    <body>
        <input type="hidden" name="paginaActualPermiso" id="permisoPaginaP31" value="" title="EDITAR VENTA"/>
        <div id="wrap">
            <div id="header">
                <label class="horaCabecera"><%=objcManejoFechas.fechaCabecera()%></label>
            </div>
            <div id="right">
                <div id="rightSub1" class="ocultar">
                    <h3 class="titulo">EDITAR VENTA</h3>
                    <form id="formVentaEditar" action="../sVenta">
                        <%
                            cOtros objcOtros = new cOtros();
                            int codVentaI = (Integer) session.getAttribute("codVentaMantenimiento");
                            Ventas objVenta = new cVenta().leer_cod(codVentaI);
                            DatosCliente objCliente = new cDatosCliente().leer_codPersona(objVenta.getPersona().getCodPersona());
                            Persona objVendedor = new cPersona().leer_cod(objVenta.getPersonaCodVendedor());
                        %>
                        <div class="">
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
                                    <th colspan="6">
                                        <button class="sexybutton" type="button" id="bCancelar"><span><span><span class="cancel">Cancelar</span></span></span></button>
                                        <button class="sexybutton" type="reset" id="bRestaurar"><span><span><span class="redo">Restaurar</span></span></span></button>
                                        <button class="sexybutton" type="submit" id="bRegistrar"><span><span><span class="save">Registrar</span></span></span></button>
                                    </th>
                                </tr>
                            </tfoot>
                            <tbody>
                                <tr>
                                    <th>COD. OPERACIÓN</th>
                                    <td>
                                        <span id="lCodVenta" class="vaciar"><%=objcOtros.agregarCeros_int(objVenta.getCodVentas(), 8)%></span>
                                    </td>
                                    <th>DET. REGISTRO</th>
                                    <td colspan="3"><span id="lRegistroDetalle" class="vaciar"></span></td>
                                </tr>
                                <tr>
                                    <th class="ancho120px"><label for="docSerieNumero">DOCUMENTO</label></th>
                                    <td class="ancho140px contenedorEntrada"><input type="text" name="docSerieNumero" id="docSerieNumero" value="<%=objVenta.getDocSerieNumero()%>" class="limpiar mayuscula entrada anchoTotal" placeholder="F-001-000001"/></td>
                                    <th class="ancho120px"><label for="tipo">T. VENTA</label></th>
                                    <td class="ancho140px contenedorEntrada">
                                        <select name="tipo" id="tipo" class="limpiar entrada anchoTotal">
                                            <option value="">--</option>
                                            <option value="contado" <%if (objVenta.getTipo().equals("CONTADO")) {%>selected=""<%}%>>CONTADO</option>
                                            <option value="credito" <%if (objVenta.getTipo().equals("CREDITO")) {%>selected=""<%}%>>CRÉDITO</option>
                                        </select>
                                    </td>
                                    <th class="ancho120px"><label for="fecha">F. VENTA</label></th>
                                    <td class="ancho140px contenedorEntrada">
                                        <input type="text" name="fecha" id="fecha" value="<%=objcManejoFechas.DateAString(objVenta.getFecha())%>" class="limpiar entrada anchoTotal" placeholder="dd/mm/yyyy" />
                                    </td>
                                </tr>
                                <tr>
                                    <th>CLIENTE <button class="sexybutton sexyicononly sexysimple sexysmall sexypropio" type="button" id="bClienteBuscar"><span class="search"></span></button></th>
                                    <td colspan="3">
                                        <span id="lClienteNombresC" class="vaciar"><%=objVenta.getCliente()%></span>
                                    </td>
                                    <th>CRED. MÁX</th>
                                    <td><span id="lClienteCreditoMax" class="vaciar"><%=objcOtros.agregarCerosNumeroFormato(objCliente.getCreditoMax(), 2)%></span></td>
                                </tr>
                                <tr>
                                    <th>DIRECCIÓN</th>
                                    <td colspan="5"><span id="lClienteDireccion" class="vaciar"><%=objVenta.getDireccion()%></span></td>
                                </tr>
                                <tr>
                                    <th>DNI/PASAPORTE</th>
                                    <td><span id="lClienteDniPasaporte" class="vaciar"><%=objVenta.getPersona().getDniPasaporte()%></span></td>
                                    <th>RUC</th>
                                    <td><span id="lClienteRuc" class="vaciar"><%=objVenta.getPersona().getRuc()%></span></td>
                                    <th>MONEDA</th>
                                    <td class="contenedorEntrada">
                                        <select id="moneda" name="moneda" class="limpiar entrada anchoTotal">
                                            <option value="">---</option>
                                            <option value="soles" <%if (objVenta.getMoneda().equals("SOLES")) {%>selected=""<%} %>>SOLES</option>
                                            <option value="dolares" <%if (objVenta.getMoneda().equals("DOLARES")) {%>selected=""<%}%>>DÓLARES</option>
                                        </select>
                                    </td>
                                </tr>
                                <tr>
                                    <th>EMPRESA</th>
                                    <td colspan="3">
                                        <span id="lClienteEmpresaConvenio" class="vaciar"><%=objCliente.getEmpresaConvenio().getNombre()%></span>
                                    </td>
                                    <th>CONDICIÓN</th>
                                    <td><span id="lClienteCondicion" class="vaciar"><%=new cDatosCliente().condicionCliente(objCliente.getCondicion()).toUpperCase()%></span></td>
                                </tr>
                                <tr>
                                    <th>VENDEDOR <button class="sexybutton sexyicononly sexysimple sexysmall sexypropio" type="button" id="bVendedorBuscar"><span class="search"></span></button></th>
                                    <td colspan="3">
                                        <span id="lVendedorNombresC" class="vaciar"><%=objVendedor.getNombresC()%></span>
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
                                                    <td colspan="4"><span id="lSon" class="vaciar"><%=objVenta.getSon()%></span></td>
                                                    <th>Sub Total</th>
                                                    <td class="derecha"><span id="lSubTotal" class="vaciar"><%=objcOtros.agregarCerosNumeroFormato(objVenta.getSubTotal(), 2)%></span></td>
                                                </tr>
                                                <tr>
                                                    <th colspan="2">Observación</th>
                                                    <td colspan="3" rowspan="4" class="contenedorEntrada"><textarea id="observacion" name="observacion" class="anchoTotal altoTotal limpiar" rows="5"><%=objVenta.getObservacion()%></textarea></td>
                                                    <th>Descuento</th>
                                                    <td class="derecha contenedorEntrada"><input type="text" name="descuento" id="descuento" value="<%=objcOtros.agregarCerosNumeroFormato(objVenta.getDescuento(), 2)%>" class="derecha anchoTotal limpiar" style="font-size: 11px;"/></td>
                                                </tr>
                                                <tr>
                                                    <td colspan="2"></td>
                                                    <th>Total</th>
                                                    <td class="derecha"><span id="lTotal" class="vaciar"><%=objcOtros.agregarCerosNumeroFormato(objVenta.getTotal(), 2)%></span></td>
                                                </tr>
                                                <tr>
                                                    <td colspan="2"></td>
                                                    <th>IGV</th>
                                                    <td class="derecha"><span id="lMontoIgv"><%=objcOtros.agregarCerosNumeroFormato(objVenta.getValorIgv(), 2)%></span></td>
                                                </tr>
                                                <tr>
                                                    <td colspan="2"></td>
                                                    <th>Neto</th>
                                                    <td class="derecha"><span id="lNeto" class="vaciar"><%=objcOtros.agregarCerosNumeroFormato(objVenta.getNeto(), 2)%></span></td>
                                                </tr>
                                            </tfoot>
                                            <tbody id="tbArticuloProducto" class="vaciar">
                                                <%
                                                    List VDList = new cVentasDetalle().leer_ventasDetalle_porCodVentas(codVentaI);
                                                    for (Iterator it = VDList.iterator(); it.hasNext();) {
                                                        VentasDetalle objVentasDetalle = (VentasDetalle) it.next();
                                                %>
                                                <tr id="trArticuloProducto<%=objVentasDetalle.getItem()%>">
                                                    <td class="derecha"><span id="lItem<%=objVentasDetalle.getItem()%>" class="vaciar"><%=objVentasDetalle.getItem()%></span></td>
                                                    <td class="derecha">
                                                        <input type="text" name="codArticuloProducto<%=objVentasDetalle.getItem()%>" id="codArticuloProducto<%=objVentasDetalle.getItem()%>" value="<%=objVentasDetalle.getArticuloProducto().getCodArticuloProducto()%>" class="limpiar ocultar" />
                                                        <span id="lCodArticuloProducto<%=objVentasDetalle.getArticuloProducto().getCodArticuloProducto()%>" class="vaciar"><%=objcOtros.agregarCeros_int(objVentasDetalle.getArticuloProducto().getCodArticuloProducto(), 8)%></span> 
                                                    </td>
                                                    <td class="derecha">
                                                        <input type="text" name="cantidad<%=objVentasDetalle.getItem()%>" id="cantidad<%=objVentasDetalle.getItem()%>" value="<%=objVentasDetalle.getCantidad()%>" class="limpiar ocultar" />
                                                        <span id="lCantidad<%=objVentasDetalle.getItem()%>" class="vaciar"><%=objVentasDetalle.getCantidad()%></span>
                                                    </td>
                                                    <td class="derecha">
                                                        <span id="lUnidad<%=objVentasDetalle.getItem()%>" class="vaciar"><%=objVentasDetalle.getArticuloProducto().getUnidadMedida()%></span>
                                                    </td>
                                                    <td class="izquierda">
                                                        <span id="lDescripcion<%=objVentasDetalle.getItem()%>" class="vaciar" title="<%=objVentasDetalle.getItem()%>"><%=objVentasDetalle.getDescripcion()%></span>
                                                        <div id="dSerieNumeroMostrar<%=objVentasDetalle.getItem()%>" style="padding-left: 15px;">
                                                            <%
                                                                for (VentasSerieNumero objVentasSerieNumero : objVentasDetalle.getVentasSerieNumeros()) {
                                                            %>
                                                            <%=objVentasSerieNumero.getSerieNumero()%>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
                                                            <%
                                                                }
                                                            %>
                                                        </div>
                                                        <div id="dSerieNumero<%=objVentasDetalle.getItem()%>">
                                                        </div>
                                                    </td>
                                                    <td class="derecha">
                                                        <input type="text" name="precioContado<%=objVentasDetalle.getItem()%>" id="precioContado<%=objVentasDetalle.getItem()%>" value="<%=objcOtros.agregarCerosNumeroFormato(objVentasDetalle.getPrecioReal(), 2)%>" class="limpiar ocultar" />
                                                        <input type="text" name="precioVenta<%=objVentasDetalle.getItem()%>" id="precioVenta<%=objVentasDetalle.getItem()%>" value="<%=objcOtros.agregarCerosNumeroFormato(objVentasDetalle.getPrecioVenta(), 2)%>" class="limpiar ocultar" />
                                                        <span id="lPrecioVenta<%=objVentasDetalle.getItem()%>" class="vaciar"><%=objcOtros.agregarCerosNumeroFormato(objVentasDetalle.getPrecioVenta(), 2)%></span>
                                                    </td>
                                                    <td class="derecha">
                                                        <input type="text" name="precioTotal<%=objVentasDetalle.getItem()%>" id="precioTotal<%=objVentasDetalle.getItem()%>" value="<%=objcOtros.agregarCerosNumeroFormato(objVentasDetalle.getValorVenta(), 2)%>" class="limpiar ocultar"/>
                                                        <span id="lPrecioTotal<%=objVentasDetalle.getItem()%>" class="vaciar"><%=objcOtros.agregarCerosNumeroFormato(objVentasDetalle.getValorVenta(), 2)%></span>
                                                    </td>
                                                </tr>
                                                <%
                                                    }
                                                %>
                                            </tbody>
                                        </table>
                                    </td>
                                </tr>
                            </tbody>
                        </table>
                    </form>
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