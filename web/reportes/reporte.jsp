<%-- 
    Document   : reporte
    Created on : 24/12/2013, 10:02:28 AM
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
        <title></title>
        <!--todos-->
        <script type="text/javascript" src="../librerias/jquery/jquery-1.9.0-min.js" ></script>
        <script type="text/javascript" src="../librerias/jquery/jquery.timer-min.js" ></script>
        <script type="text/javascript" src="../librerias/jquery-ui/jquery-ui-1.10.3.custom/js/jquery-ui-1.10.3.custom.min.js" ></script>
        <link rel="stylesheet" type="text/css" href="../librerias/principal/todos.css" media="all"/>
        <!--cambios-->
        <%@include file="../principal/inclusiones.jsp" %>
        <!--propio-->
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
                            <table class="reporte-tabla-1">
                                <thead>

                                </thead>
                                <tfoot>

                                </tfoot>
                                <tbody>
                                    <tr>
                                        <th class="ancho80px"><span>COBRADOR</span></th>
                                        <td class="ancho280px">
                                            <input type="radio" name="tabs_cliente_Cobrador" id="tabs_cliente_todos" value="todos" checked="checked"  class="clienteCobrador" /><label for="tabs_cliente_todos">Todos</label>
                                            <input type="radio" name="tabs_cliente_Cobrador" id="tabs_cliente_por_cobrador" value="cobrador"  class="clienteCobrador"/><label for="tabs_cliente_por_cobrador">Por Cobrador</label>
                                        </td>
                                    </tr>
                                    <tr>
                                        <th><span>ORDEN</span></th>
                                        <td></td>
                                        <td>
                                            <a id="reporteCliente" href="#" class="sexybutton sexyicononly aClientes" ><span><span><span class="print"></span></span></span></a>
                                        </td>
                                    </tr>                                    
                                    <tr>
                                        <th><span>EMPRESA</span></th>
                                    </tr>                                    
                                    <tr>
                                        <th><span>TIPO</span></th>
                                    </tr>
                                    <tr>
                                        <th><span>CONDICIÓN</span></th>
                                    </tr>
                                </tbody>
                            </table>
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
            <div style="clear: both;"></div>
            <div id="footer">
                <%@include file="../principal/piePagina.jsp" %>
            </div>
        </div>
    </body>
</html>
