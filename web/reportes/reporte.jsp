<%-- 
    Document   : reporte
    Created on : 24/12/2013, 10:02:28 AM
    Author     : Henrri
--%>


<%@page import="tablas.EmpresaConvenio"%>
<%@page import="java.util.Iterator"%>
<%@page import="personaClases.cEmpresaConvenio"%>
<%@page import="java.util.List"%>
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
        <title> reporte</title>
        <!--todos-->
        <script type="text/javascript" src="../librerias/jquery/jquery-1.9.0-min.js" ></script>
        <script type="text/javascript" src="../librerias/jquery/jquery.timer-min.js" ></script>
        <script type="text/javascript" src="../librerias/jquery-ui/jquery-ui-1.10.3.custom/js/jquery-ui-1.10.3.custom.min.js" ></script>
        <link rel="stylesheet" type="text/css" href="../librerias/principal/todos.css" media="all"/>
        <!--cambios-->
        <%@include file="../principal/inclusiones.jsp" %>
        <!--propio-->
        <script type="text/javascript" src="../librerias/jquery-ui/jquery-ui-1.10.3.custom/js/i18n/jquery.ui.datepicker-es-min.js"></script>
        <script type="text/javascript" src="../librerias/plugin/mask/jquery.mask.min.js"></script>
        <script type="text/javascript" src="../librerias/utilitarios/validaciones.js"></script>
        <script type="text/javascript" src="../librerias/utilitarios/manejoFecha.js"></script>
        <script type="text/javascript" src="../librerias/reporte/reporte.js?v.14.03.25-2"></script>
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
        <input type="hidden" name="paginaActualPermiso" id="permisoPaginaP19" value="" title=""/>
        <div id="wrap">
            <div id="header">
                <label class="horaCabecera"><%=objcManejoFechas.fechaCabecera()%></label>
            </div>
            <div id="right" style="width: 1024px;">
                <div id="rightSub1" class="ocultar">
                    <input type="text" name="fechaActual" id="fechaActual" value="<%=new cManejoFechas().DateAString(new Date())%>" class="ocultar" />
                    <h3 class="titulo"><a href="../index.jsp" class="sexybutton"><span><span><span class="home">Inicio</span></span></span></a> MÓDULO REPORTES <a href="reporteMenu.jsp" class="sexybutton"><span><span><span class="info">Versión antigua</span></span></span></a></h3>
                    <div id="tabs">
                        <ul>
                            <li><a href="#tabs_cliente">Clientes</a></li>
                            <li><a href="#tabs_venta">Ventas</a></li>
                            <li><a href="#tabs_cobranza">Cobranza</a></li>
                            <li><a href="#tabs_compra">Compras</a></li>
                            <li><a href="#tabs_proveedor">Proveedor</a></li>
                            <li><a href="#tabs_articuloProducto">Artículos</a></li>
                            <li><a href="#tabs_otros">Otros</a></li>
                        </ul>
                        <div id="tabs_cliente">
                            <div>
                                <table class="reporte-tabla-1 anchoTotal">
                                    <tbody>
                                        <tr>
                                            <th><span>COBRADOR</span></th>
                                            <td colspan="2">
                                                <input type="radio" name="tCliente_cobrador" id="tCliente_todos" value="todos" class="clienteCobrador" checked="checked"/><label for="tCliente_todos">Todos</label>
                                                <input type="radio" name="tCliente_cobrador" id="tCliente_por_cobrador" value="cobrador"  class="clienteCobrador"/><label for="tCliente_por_cobrador">Por Cobrador</label>
                                            </td>
                                            <td colspan="5" id="tdClienteCobrador" class="ocultar">
                                                <div>
                                                    <a id="tCliente_bCobradorBuscar" class="sexybutton sexyicononly"><span><span><span class="search"></span></span></span></a>
                                                    <input type="text" name="clienteCodCobrador" id="clienteCodCobrador" value="" class="ocultar"/>
                                                    <span id="tCliente_cobradorNombresC">APELLIDOS/NOMBRES</span>
                                                </div>
                                            </td>
                                        </tr>
                                        <tr>
                                            <th class="ancho80px"><span>ORDEN</span></th>
                                            <td>
                                                <input type="radio" name="tCliente_orden" id="tCliente_nombresC" value="nombresC" checked="checked" /><label for="tCliente_nombresC">Apellidos/Nombres</label>
                                                <input type="radio" name="tCliente_orden" id="tCliente_direccion" value="direccion"/><label for="tCliente_direccion">Dirección</label>
                                            </td>
                                            <td class="ancho40px">
                                                <a id="rClienteOrden" class="sexybutton sexyicononly aCliente" ><span><span><span class="print"></span></span></span></a>
                                            </td>
                                            <th class="ancho110px">
                                                <span>LET. PENDIENTE</span>
                                            </th>
                                            <td class="contenedorEntrada ancho90px">
                                                <input type="text" id="clienteFVLOrden" value="" class="anchoTotal entrada fechaEntrada"/>
                                            </td>                                        
                                            <td class="ancho90px">
                                                <a id="rClienteOrdenVCL" class="sexybutton sexyicononly aCliente" ><span><span><span class="print"></span></span></span></a>
                                                <a id="rClienteOrdenVCLExcel" class="sexybutton sexyicononly aCliente" ><span><span><span class="excel"></span></span></span></a>
                                            </td>
                                            <th class="ancho60px">
                                                <span>TRAMOS</span>
                                            </th>
                                            <td class="ancho40px">                                                
                                                <a id="rClienteOrdenVCLTExcel" class="sexybutton sexyicononly aCliente" ><span><span><span class="excel"></span></span></span></a>
                                            </td>
                                        </tr>                                    
                                        <tr>
                                            <th><span>EMPRESA</span></th>
                                            <td class="contenedorEntrada">
                                                <div>
                                                    <%
                                                        List empresaList = new cEmpresaConvenio().leer_SC();
                                                    %>
                                                    <select name="tClienteCodEC" id="tClienteCodEC" class="anchoTotal contenedorEntrada limpiar">
                                                        <option value="">Seleccione</option>
                                                        <%
                                                            for (Iterator it = empresaList.iterator(); it.hasNext();) {
                                                                EmpresaConvenio objEC = (EmpresaConvenio) it.next();
                                                        %>
                                                        <option value="<%=objEC.getCodEmpresaConvenio()%>"><%=objEC.getNombre()%></option>
                                                        <%
                                                            }
                                                        %>
                                                    </select>
                                                </div>
                                            </td>                                        
                                            <td>
                                                <a id="rClienteOrdenEC" class="sexybutton sexyicononly aCliente"><span><span><span class="print"></span></span></span></a>
                                            </td>
                                            <th>
                                                <span>LET. PENDIENTE</span>
                                            </th>
                                            <td class="contenedorEntrada">
                                                <input type="text" id="clienteFVLECOrden" name="" value="" class="anchoTotal entrada fechaEntrada"/>
                                            </td>                                        
                                            <td>
                                                <a id="rClienteECOrdenVCL" class="sexybutton sexyicononly aCliente" ><span><span><span class="print"></span></span></span></a>
                                                <a id="rClienteECOrdenVCLExcel" class="sexybutton sexyicononly aCliente" ><span><span><span class="excel"></span></span></span></a>
                                            </td>
                                            <th>
                                                <span>TRAMOS</span>
                                            </th>
                                            <td>
                                                <a id="rClienteOrdenECVCLTExcel" class="sexybutton sexyicononly aCliente" ><span><span><span class="excel"></span></span></span></a>
                                            </td>
                                        </tr>                                    
                                        <tr>
                                            <th><span>TIPO</span></th>
                                            <td class="contenedorEntrada">
                                                <div>                                                    
                                                    <select name="tClienteTipo" id="tClienteTipo" class="anchoTotal contenedorEntrada limpiar">
                                                        <option value="">Seleccione</option>
                                                        <option value="1">ACTIVO</option>
                                                        <option value="2">4 SUELDOS</option>
                                                        <option value="3">CESANTE</option>
                                                        <option value="4">PARTICULAR</option>
                                                    </select>
                                                </div>
                                            </td>
                                            <td>
                                                <a id="rClienteOrdenECTipo" class="sexybutton sexyicononly aCliente" ><span><span><span class="print"></span></span></span></a>
                                            </td>
                                            <th>
                                                <span>LET. PENDIENTE</span>
                                            </th>
                                            <td class="contenedorEntrada">
                                                <input type="text" id="clienteFVLECTipoOrden" name="" value="" class="anchoTotal entrada fechaEntrada"/>
                                            </td>                                        
                                            <td>
                                                <a id="rClienteECTipoOrdenVCL" class="sexybutton sexyicononly aCliente" ><span><span><span class="print"></span></span></span></a>
                                                <a id="rClienteECTipoOrdenVCLExcel" class="sexybutton sexyicononly aCliente" ><span><span><span class="excel"></span></span></span></a>
                                            </td>
                                        </tr>
                                        <tr>
                                            <th><span>CONDICIÓN</span></th>
                                            <td class="contenedorEntrada">
                                                <div>                                                    
                                                    <select name="tClienteCondicion" id="tClienteCondicion" class="anchoTotal contenedorEntrada limpiar">
                                                        <option value="">Seleccione</option>
                                                        <option value="1">CONTRATADO</option>
                                                        <option value="2">NOMBRADO</option>
                                                        <option value="3">OTROS</option>
                                                    </select>
                                                </div>
                                            </td>
                                            <td>
                                                <a id="rClienteOrdenECTipoCondicion" class="sexybutton sexyicononly aCliente" ><span><span><span class="print"></span></span></span></a>
                                            </td>
                                            <th>
                                                <span>LET. PENDIENTE</span>
                                            </th>
                                            <td class="contenedorEntrada">
                                                <input type="text" id="clienteFVLECTipoCondicionOrden" name="" value="" class="anchoTotal entrada fechaEntrada"/>
                                            </td>                                        
                                            <td>
                                                <a id="rClienteECTipoCondicionOrdenVCL" class="sexybutton sexyicononly aCliente" ><span><span><span class="print"></span></span></span></a>
                                                <a id="rClienteECTipoCondicionOrdenVCLExcel" class="sexybutton sexyicononly aCliente" ><span><span><span class="excel"></span></span></span></a>
                                            </td>
                                        </tr>
                                    </tbody>
                                </table>
                            </div>
                            <!--dialog's-->
                            <div id="dVendedorCobradorBuscar" title="Seleccione cobrador" class="contenedorEntrada">
                                <input type="search" name="cobradorVendedorBuscar" id="cobradorVendedorBuscar" value="" class="anchoTotal entrada mayuscula"/>
                            </div>
                        </div>
                        <div id="tabs_venta">
                            <div>
                                <table class="reporte-tabla-1">
                                    <tbody>
                                        <tr>
                                            <th class="ancho140px"><span>TIPO</span></th>
                                            <td colspan="2">
                                                <div>
                                                    <input type="radio" name="tVenta_tipo" id="tVenta_todo" value="todo" class="ventaTipo" checked="checked"/><label for="tVenta_todo">Todos</label>
                                                    <input type="radio" name="tVenta_tipo" id="tVenta_contado" value="contado"  class="ventaTipo"/><label for="tVenta_contado">Contado</label>
                                                    <input type="radio" name="tVenta_tipo" id="tVenta_credito" value="credito"  class="ventaTipo"/><label for="tVenta_credito">Crédito</label>
                                                </div>
                                            </td>
                                        </tr>
                                        <tr>
                                            <th><span>PERIÓDO DE VENTA</span></th>
                                            <td class="ancho400px">
                                                <label>DEL</label> <input type="text" id="ventaFechaInicio" name="" value="" class="ancho110px entrada fechaEntrada"/>
                                                <label>AL</label> <input type="text" id="ventaFechaFin" name="" value="" class="ancho110px entrada fechaEntrada"/>
                                            </td>
                                            <td class="ancho90px">
                                                <a id="rVentaPeriodoTipo" class="sexybutton sexyicononly aVenta" ><span><span><span class="print"></span></span></span></a>
                                                <a id="rVentaPeriodoTipoExcel" class="sexybutton sexyicononly aVenta" ><span><span><span class="excel"></span></span></span></a>
                                            </td>
                                        </tr>
                                        <tr>
                                            <th><span>DOCUMENTO (F-B-G)</span></th>
                                            <td>
                                                <select id="ventaTipoDoc" name="ventaTipoDoc" class="ancho50px entrada">
                                                    <option value="F">F</option>
                                                    <option value="B">B</option>
                                                    <option value="G">G</option>
                                                </select>
                                                <span> - </span>
                                                <input type="text" id="ventaSerieDoc" name="ventaSerieDoc" value="" class="ancho40px entrada"/>
                                            </td>
                                            <td>
                                                <a id="rVentaPeriodoDocumetoTipo" class="sexybutton sexyicononly aVenta" ><span><span><span class="print"></span></span></span></a>
                                                <a id="rVentaPeriodoDocumetoTipoExcel" class="sexybutton sexyicononly aVenta" ><span><span><span class="excel"></span></span></span></a>
                                            </td>
                                        </tr>
                                        <tr>
                                            <th><span>VENDEDOR</span> <a id="venta_bVendedorBuscar" class="sexybutton sexyicononly"><span><span><span class="search"></span></span></span></a></th>
                                            <td>                                                
                                                <input type="text" name="venta_codVendedor" id="venta_codVendedor" value="" class="ocultar"/>
                                                <span id="venta_vendedorNombresC">APELLIDOS/NOMBRES</span>
                                            </td>
                                            <td>
                                                <a id="rVentaVendedorTipo" class="sexybutton sexyicononly aVenta" ><span><span><span class="print"></span></span></span></a>
                                                <a id="rVentaVendedorTipoExcel" class="sexybutton sexyicononly aVenta" ><span><span><span class="excel"></span></span></span></a>
                                            </td>
                                        </tr>
                                        <tr>
                                            <th><span>DOC. ANULADOS</span></th>
                                            <td></td>
                                            <td>
                                                <a id="rVentaPeriodoAnuladoTipo" class="sexybutton sexyicononly aVenta" ><span><span><span class="print"></span></span></span></a>
                                                <a id="rVentaPeriodoAnuladoTipoExcel" class="sexybutton sexyicononly aVenta" ><span><span><span class="excel"></span></span></span></a>
                                            </td>
                                        </tr>
                                    </tbody>
                                </table>
                            </div>
                            <!--dialog's-->
                            <div id="venta_dVendedorBuscar" title="Seleccione vendedor" class="contenedorEntrada">
                                <input type="search" name="venta_vendedorBuscar" id="venta_vendedorBuscar" value="" class="anchoTotal entrada mayuscula"/>
                            </div>
                        </div>
                        <div id="tabs_cobranza">
                            <div>
                                <table class="reporte-tabla-1">
                                    <tbody>
                                        <tr>
                                            <th class="ancho140px"><span>PERIODO</span></th>
                                            <td colspan="2">
                                                <div>
                                                    <label>DEL</label> <input type="text" id="cobranza_fechaInicio" name="cobranza_fechaInicio" value="" class="ancho110px entrada fechaEntrada"/>
                                                    <label>AL</label> <input type="text" id="cobranza_fechaFin" name="cobranza_fechaFin" value="" class="ancho110px entrada fechaEntrada"/>
                                                </div>
                                            </td>                                            
                                        </tr>
                                        <tr>
                                            <th><span>COBRADOR</span></th>
                                            <td colspan="2">
                                                <div>
                                                    <input type="radio" name="cobranza_cobrador" id="cobranza_todos" value="todos" class="cobranzaCobrador" checked="checked"/><label for="cobranza_todos">Todos</label>
                                                    <input type="radio" name="cobranza_cobrador" id="cobranza_cobrador" value="cobrador"  class="cobranzaCobrador"/><label for="cobranza_cobrador">Por Cobrador</label>
                                                </div>
                                            </td>
                                        </tr>
                                        <tr id="td_cobranza_cobrador" class="ocultar">
                                            <td class="derecha"><a id="cobranza_bCobradorBuscar" class="sexybutton sexyicononly"><span><span><span class="search"></span></span></span></a></td>
                                            <td colspan="2">
                                                <input type="text" name="cobranza_codCobrador" id="cobranza_codCobrador" value="" class="ocultar"/>
                                                <span id="cobranza_cobradorNombresC">APELLIDOS/NOMBRES</span>
                                            </td>
                                        </tr>
                                        <tr>
                                            <th><span>TIPO</span></th>
                                            <td class="ancho400px">
                                                <div>
                                                    <input type="radio" name="cobranza_tipo" id="cobranza_tipoTodo" value="todo" checked="checked"/><label for="cobranza_tipoTodo">Todo</label>
                                                    <input type="radio" name="cobranza_tipo" id="cobranza_tipoInicial" value="inicial" /><label for="cobranza_tipoInicial">Iniciales</label>
                                                    <input type="radio" name="cobranza_tipo" id="cobranza_tipoCobranza" value="cobranza" /><label for="cobranza_tipoCobranza">Cobranza</label>
                                                    <input type="radio" name="cobranza_tipo" id="cobranza_tipoAnticipo" value="anticipo" /><label for="cobranza_tipoAnticipo">Anticipo</label>
                                                </div>
                                            </td>
                                            <td class="ancho40px"><a id="cobranza_rTipo" class="sexybutton sexyicononly aCobranza" ><span><span><span class="print"></span></span></span></a></td>
                                        </tr>
                                        <tr>
                                            <th><span>DOCUMENTO</span></th>
                                            <td>
                                                <div>
                                                    <input type="text" id="cobranza_tipoDocumento" name="cobranza_tipoDocumento" value="" class="ancho40px entrada mayuscula"/>
                                                    <span> - </span>
                                                    <input type="text" id="cobranza_serieDocumento" name="cobranza_serieDocumento" value="" class="ancho50px entrada"/>
                                                </div>
                                            </td>
                                            <td><a id="cobranza_rDocumento" class="sexybutton sexyicononly aCobranza" ><span><span><span class="print"></span></span></span></a></td>
                                        </tr>
                                        <tr>
                                            <th><span>ANULADOS</span></th>
                                            <td></td>
                                            <td><a id="cobranza_rAnulado" class="sexybutton sexyicononly aCobranza" ><span><span><span class="print"></span></span></span></a></td>
                                        </tr>
                                        <tr>
                                            <th><span>CLIENTES-PAGOS</span></th>
                                            <td></td>
                                            <td><a id="cobranza_rPago" class="sexybutton sexyicononly aCobranza" ><span><span><span class="print"></span></span></span></a></td>
                                        </tr>
                                    </tbody>
                                </table>
                            </div>
                            <!--dialog's-->
                            <div id="cobranza_dCobradorBuscar" title="Seleccione cobrador" class="contenedorEntrada">
                                <input type="search" name="cobrador_cobradorBuscar" id="cobrador_cobradorBuscar" value="" class="anchoTotal entrada mayuscula"/>
                            </div>
                        </div>
                        <div id="tabs_compra">
                            <div>
                                <table class="reporte-tabla-1">
                                    <tbody>
                                        <tr>
                                            <th><span>PERIODO</span></th>
                                            <td colspan="2">
                                                <div>
                                                    <label>DEL</label> <input type="text" id="compra_fechaInicio" name="compra_fechaInicio" value="" class="ancho110px entrada fechaEntrada"/>
                                                    <label>AL</label> <input type="text" id="compra_fechaFin" name="compra_fechaFin" value="" class="ancho110px entrada fechaEntrada"/>
                                                </div>
                                            </td>
                                        </tr>
                                        <tr>
                                            <th class="ancho120px"><span>TIPO</span></th>
                                            <td class="ancho440px">
                                                <div>
                                                    <input type="radio" name="compra_tipo" value="documento" checked="checked" id="compra_documento"/><label for="compra_documento">Documento</label>
                                                    <input type="radio" name="compra_tipo" value="articulo" id="compra_articulo"/><label for="compra_articulo">Artículo</label>
                                                </div>
                                            </td>
                                            <td class="ancho50px">
                                                <a id="compra_rTipo" class="sexybutton sexyicononly aCompra" ><span><span><span class="print"></span></span></span></a>
                                            </td>
                                        </tr>
                                        <tr>
                                            <th><span>PROVEEDOR</span> <a id="compra_bProveedorBuscar" class="sexybutton sexyicononly"><span><span><span class="search"></span></span></span></a></th>
                                            <td>
                                                <div>
                                                    <input type="text" name="compra_codProveedor" id="compra_codProveedor" value="" class="ocultar"/>
                                                    <span id="compra_proveedor"></span>
                                                </div>
                                            </td>
                                            <td>
                                                <div>
                                                    <a id="compra_rProveedor" class="sexybutton sexyicononly aCompra" ><span><span><span class="print"></span></span></span></a>
                                                </div>
                                            </td>
                                        </tr>
                                    </tbody>
                                </table>

                                <div id="compra_dProveedorBuscar" title="Seleccione proveedor" class="contenedorEntrada">
                                    <input type="search" name="compra_proveedorBuscar" id="compra_proveedorBuscar" value="" class="anchoTotal entrada mayuscula"/>
                                </div>
                            </div>
                        </div>
                        <div id="tabs_proveedor">

                        </div>
                        <div id="tabs_articuloProducto">
                            <div>
                                <table class="reporte-tabla-1">
                                    <tbody>
                                        <tr>
                                            <th class="ancho200px"><span>ORDEN</span></th>
                                            <td class="ancho200px">
                                                <div>
                                                    <input type="radio" name="articulo_orden" id="articulo_alfabetico" value="alfabetico" checked="checked" /><label for="articulo_alfabetico">Alfabético</label>
                                                    <input type="radio" name="articulo_orden" id="articulo_normal" value="normal" /><label for="articulo_normal">Normal</label>
                                                </div>
                                            </td>
                                            <th class="ancho60px"><span>INCLUIR</span></th>
                                            <td colspan="2">
                                                <div>
                                                    <input type="checkbox" name="articulo_precioCompra" id="articulo_precioCompra" value="ON" /><label for="articulo_precioCompra">P. Compra</label>
                                                    <input type="checkbox" name="articulo_precioVenta" id="articulo_precioVenta" value="ON" /><label for="articulo_precioVenta">P. Venta</label>
                                                    <input type="checkbox" name="articulo_serieNumero" id="articulo_serieNumero" value="articuloNormal" value="ON"/><label for="articulo_serieNumero">S/N</label>
                                                </div>
                                            </td>
                                        </tr>
                                        <tr>
                                            <th><span>INVENTARIO GENERAL</span></th>
                                            <td class="ancho320px" colspan="3">
                                                <div>
                                                    <input type="radio" name="articulo_tipoInventario" value="inventarioGeneral" id="articulo_inventarioGeneral" checked="checked" /><label for="articulo_inventarioGeneral">General</label>
                                                    <input type="radio" name="articulo_tipoInventario" value="conStock" id="articulo_conStock" /><label for="articulo_conStock">Con Stock</label>
                                                    <input type="radio" name="articulo_tipoInventario" value="sinStock" id="articulo_sinStock" /><label for="articulo_sinStock">Sin stock</label>
                                                </div>
                                            </td>
                                            <td class="ancho90px">
                                                <div>
                                                    <a id="articulo_rInventario" class="sexybutton sexyicononly aArticuloProducto" ><span><span><span class="print"></span></span></span></a>
                                                    <a id="articulo_rInventarioExcel" class="sexybutton sexyicononly aArticuloProducto" ><span><span><span class="excel"></span></span></span></a>
                                                </div>
                                            </td>
                                        </tr>
                                        <tr>
                                            <th><span>FAMILIA</span> <a id="articuloProducto_bFamiliaStockBuscar" class="sexybutton sexyicononly"><span><span><span class="search"></span></span></span></a></th>
                                            <td colspan="3">
                                                <div>
                                                    <input type="text" name="articuloProducto_codFamiliaStock" id="articuloProducto_codFamiliaStock" value="" class="ocultar"/>
                                                    <span id="articuloProducto_familiaStock"></span>
                                                </div>
                                            </td>
                                            <td>
                                                <div>
                                                    <a id="articulo_rFamiliaInventario" class="sexybutton sexyicononly aArticuloProducto" ><span><span><span class="print"></span></span></span></a>
                                                    <a id="articulo_rFamiliaInventarioExcel" class="sexybutton sexyicononly aArticuloProducto" ><span><span><span class="excel"></span></span></span></a>
                                                </div>
                                            </td>
                                        </tr>
                                        <tr>
                                            <th><span>MARCA</span> <a id="articuloProducto_bMarcaStockBuscar" class="sexybutton sexyicononly"><span><span><span class="search"></span></span></span></a></th>
                                            <td colspan="3">
                                                <div>
                                                    <input type="text" name="articuloProducto_codMarcaStock" id="articuloProducto_codMarcaStock" value="" class="ocultar"/>
                                                    <span id="articuloProducto_marcaStock"></span>
                                                </div>
                                            </td>
                                            <td>
                                                <div>
                                                    <a id="articulo_rFamiliaMarcaInventario" class="sexybutton sexyicononly aArticuloProducto" ><span><span><span class="print"></span></span></span></a>
                                                    <a id="articulo_rFamiliaMarcaInventarioExcel" class="sexybutton sexyicononly aArticuloProducto" ><span><span><span class="excel"></span></span></span></a>
                                                </div>
                                            </td>
                                        </tr>
                                    </tbody>
                                </table>
                            </div>
                            <div style="padding-top: 40px;">
                                <table class="reporte-tabla-1">
                                    <tbody>
                                        <tr>
                                            <th><span>MOVIMIENTO</span></th>
                                            <td colspan="2">
                                                <div>
                                                    <input type="radio" name="articuloProducto_control" id="articuloProducto_vendidos" value="vendidos" checked="checked" /><label for="articuloProducto_vendidos">Vendidos</label>
                                                    <input type="radio" name="articuloProducto_control" id="articuloProducto_comprados" value="comprados" /><label for="articuloProducto_comprados">Comprados</label>
                                                </div>
                                            </td>
                                        </tr>
                                        <tr>
                                            <th class="ancho200px"><span>PERIODO</span></th>
                                            <td class="ancho420px">
                                                <label>DEL</label> <input type="text" id="articuloProducto_fechaInicio" name="articuloProducto_fechaInicio" value="" class="ancho110px entrada fechaEntrada"/>
                                                <label>AL</label> <input type="text" id="articuloProducto_fechaFin" name="articuloProducto_fechaFin" value="" class="ancho110px entrada fechaEntrada"/>
                                            </td>
                                            <td class="ancho90px">
                                                <div>
                                                    <a id="articulo_rMovimiento" class="sexybutton sexyicononly aArticuloProducto aArticuloProductoFechaPeriodo" ><span><span><span class="print"></span></span></span></a>
                                                    <a id="articulo_rMovimientoExcel" class="sexybutton sexyicononly aArticuloProducto aArticuloProductoFechaPeriodo" ><span><span><span class="excel"></span></span></span></a>
                                                </div>
                                            </td>
                                        </tr>
                                        <tr>
                                            <th><span>FAMILIA</span> <a id="articuloProducto_bFamiliaMovimientoBuscar" class="sexybutton sexyicononly"><span><span><span class="search"></span></span></span></a></th>
                                            <td>
                                                <div>
                                                    <input type="text" name="articuloProducto_codFamiliaMovimiento" id="articuloProducto_codFamiliaMovimiento" value="" class="ocultar"/>
                                                    <span id="articuloProducto_familiaMovimiento"></span>
                                                </div>
                                            </td>                                            
                                            <td>
                                                <div>
                                                    <a id="articulo_rFamiliaMovimiento" class="sexybutton sexyicononly aArticuloProducto aArticuloProductoFechaPeriodo" ><span><span><span class="print"></span></span></span></a>
                                                    <a id="articulo_rFamiliaMovimientoExcel" class="sexybutton sexyicononly aArticuloProducto aArticuloProductoFechaPeriodo" ><span><span><span class="excel"></span></span></span></a>
                                                </div>
                                            </td>
                                        </tr>
                                        <tr>
                                            <th><span>MARCA</span> <a id="articuloProducto_bMarcaMovimientoBuscar" class="sexybutton sexyicononly"><span><span><span class="search"></span></span></span></a></th>
                                            <td>
                                                <div>
                                                    <input type="text" name="articuloProducto_codMarcaMovimiento" id="articuloProducto_codMarcaMovimiento" value="" class="ocultar"/>
                                                    <span id="articuloProducto_marcaMovimiento"></span>
                                                </div>
                                            </td>                                            
                                            <td>
                                                <div>
                                                    <a id="articulo_rFamiliaMarcaMovimiento" class="sexybutton sexyicononly aArticuloProducto aArticuloProductoFechaPeriodo" ><span><span><span class="print"></span></span></span></a>
                                                    <a id="articulo_rFamiliaMarcaMovimientoExcel" class="sexybutton sexyicononly aArticuloProducto aArticuloProductoFechaPeriodo" ><span><span><span class="excel"></span></span></span></a>
                                                </div>
                                            </td>
                                        </tr>
                                        <tr>
                                            <th><span>ARTÍCULO/PRODUCTO</span> <a id="articuloProducto_bArticuloProductoMovimientoBuscar" class="sexybutton sexyicononly"><span><span><span class="search"></span></span></span></a></th>
                                            <td>
                                                <div>
                                                    <input type="text" name="articuloProducto_codArticuloProductoMovimiento" id="articuloProducto_codArticuloProductoMovimiento" value="" class="ocultar"/>
                                                    <span id="articuloProducto_articuloProductoMovimiento"></span>
                                                </div>
                                            </td>                                            
                                            <td>
                                                <div>
                                                    <a id="articulo_rAPMovimiento" class="sexybutton sexyicononly aArticuloProducto aArticuloProductoFechaPeriodo" ><span><span><span class="print"></span></span></span></a>
                                                    <a id="articulo_rAPMovimientoExcel" class="sexybutton sexyicononly aArticuloProducto aArticuloProductoFechaPeriodo" ><span><span><span class="excel"></span></span></span></a>
                                                </div>
                                            </td>
                                        </tr>
                                    </tbody>
                                </table>
                            </div>
                            <!--dialog's-->
                            <div id="articuloProducto_dFamiliaStockBuscar" title="Seleccione familia" class="contenedorEntrada">
                                <input type="search" name="articuloProducto_familiaStockBuscar" id="articuloProducto_familiaStockBuscar" value="" class="anchoTotal entrada mayuscula"/>
                            </div>
                            <div id="articuloProducto_dMarcaStockBuscar" title="Seleccione marca" class="contenedorEntrada">
                                <input type="search" name="articuloProducto_marcaStockBuscar" id="articuloProducto_marcaStockBuscar" value="" class="anchoTotal entrada mayuscula"/>
                            </div>
                            <div id="articuloProducto_dFamiliaMovimientoBuscar" title="Seleccione familia" class="contenedorEntrada">
                                <input type="search" name="articuloProducto_familiaMovimientoBuscar" id="articuloProducto_familiaMovimientoBuscar" value="" class="anchoTotal entrada mayuscula"/>
                            </div>
                            <div id="articuloProducto_dMarcaMovimientoBuscar" title="Seleccione marca" class="contenedorEntrada">
                                <input type="search" name="articuloProducto_marcaStockBuscar" id="articuloProducto_marcaMovimientoBuscar" value="" class="anchoTotal entrada mayuscula"/>
                            </div>
                            <div id="articuloProducto_dArticuloProductoMovimientoBuscar" title="Seleccione artículo/producto" class="contenedorEntrada">
                                <table class="reporte-tabla-1 anchoTotal">
                                    <tr>
                                        <td class="ancho110px">
                                            <div><input type="search" name="articuloProducto_codArticuloProductoMovimientoBuscar" id="articuloProducto_codArticuloProductoMovimientoBuscar" class="anchoTotal entrada mayuscula derecha"/></div>
                                        </td>
                                        <td>
                                            <div><input type="search" name="articuloProducto_articuloProductoMovimientoBuscar" id="articuloProducto_articuloProductoMovimientoBuscar" value="" class="anchoTotal entrada mayuscula"/></div>
                                        </td>
                                    </tr>
                                </table>
                            </div>
                        </div>
                        <div id="tabs_otros">

                        </div>
                    </div>
                </div>
                <%@include file="../principal/div2.jsp" %>
            </div>            
            <div id="left" class="ocultar">
                <div class="acceso">
                    <h3 class="titulo">INICIE SESIÓN</h3>                    
                    <button class="sexybutton" id="bAccesoAbrir" type="button"><span><span><img src="../librerias/botonesIconos/images/icons/silk/key_go.png">Ejecutar SICCI</span></span></button>
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
