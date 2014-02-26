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
        <script type="text/javascript" src="../librerias/reporte/reporte.js"></script>
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
                    <h3 class="titulo"><a href="../index.jsp" class="sexybutton"><span><span><span class="home">Inicio</span></span></span></a> MÓDULO REPORTES</h3>
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
                                                <input type="text" name="" value="" class="anchoTotal entrada fechaEntrada"/>
                                            </td>                                        
                                            <td>
                                                <a id="" class="sexybutton sexyicononly aCliente" ><span><span><span class="print"></span></span></span></a>
                                                <a id="" class="sexybutton sexyicononly aCliente" ><span><span><span class="excel"></span></span></span></a>
                                            </td>
                                            <th>
                                                <span>TRAMOS</span>
                                            </th>
                                            <td>
                                                <a id="" class="sexybutton sexyicononly aCliente" ><span><span><span class="excel"></span></span></span></a>
                                            </td>
                                        </tr>                                    
                                        <tr>
                                            <th><span>TIPO</span></th>
                                            <td class="contenedorEntrada">
                                                <div>                                                    
                                                    <select name="" id="" class="anchoTotal contenedorEntrada limpiar">
                                                        <option value="">Seleccione</option>
                                                        <option value="1">ACTIVO</option>
                                                        <option value="2">4 SUELDOS</option>
                                                        <option value="3">CESANTE</option>
                                                        <option value="4">PARTICULAR</option>
                                                    </select>
                                                </div>
                                            </td>
                                            <td>
                                                <a id="" class="sexybutton sexyicononly aCliente" ><span><span><span class="print"></span></span></span></a>
                                            </td>
                                            <th>
                                                <span>LET. PENDIENTE</span>
                                            </th>
                                            <td class="contenedorEntrada">
                                                <input type="text" name="" value="" class="anchoTotal entrada fechaEntrada"/>
                                            </td>                                        
                                            <td>
                                                <a id="" class="sexybutton sexyicononly aCliente" ><span><span><span class="print"></span></span></span></a>
                                                <a id="" class="sexybutton sexyicononly aCliente" ><span><span><span class="excel"></span></span></span></a>
                                            </td>
                                        </tr>
                                        <tr>
                                            <th><span>CONDICIÓN</span></th>
                                            <td class="contenedorEntrada">
                                                <div>                                                    
                                                    <select name="" id="" class="anchoTotal contenedorEntrada limpiar">
                                                        <option value="">Seleccione</option>
                                                        <option value="1">CONTRATADO</option>
                                                        <option value="2">NOMBRADO</option>
                                                        <option value="3">OTROS</option>
                                                    </select>
                                                </div>
                                            </td>
                                            <td>
                                                <a id="" class="sexybutton sexyicononly aCliente" ><span><span><span class="print"></span></span></span></a>
                                            </td>
                                            <th>
                                                <span>LET. PENDIENTE</span>
                                            </th>
                                            <td class="contenedorEntrada">
                                                <input type="text" name="" value="" class="anchoTotal entrada fechaEntrada"/>
                                            </td>                                        
                                            <td>
                                                <a id="" class="sexybutton sexyicononly aCliente" ><span><span><span class="print"></span></span></span></a>
                                                <a id="" class="sexybutton sexyicononly aCliente" ><span><span><span class="excel"></span></span></span></a>
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

                        </div>
                        <div id="tabs_cobranza">

                        </div>
                        <div id="tabs_compra">

                        </div>
                        <div id="tabs_proveedor">

                        </div>
                        <div id="tabs_articuloProducto">

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
