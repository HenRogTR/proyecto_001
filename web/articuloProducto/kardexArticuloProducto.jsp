<%-- 
    Document   : kardexArticuloProductoNuevo
    Created on : 17/12/2013, 11:16:29 AM
    Author     : Henrri
--%>

<%@page import="tablas.Almacen"%>
<%@page import="java.util.Iterator"%>
<%@page import="compraClases.cAlmacen"%>
<%@page import="java.util.List"%>
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
        <script type="text/javascript" src="../librerias/articuloProducto/articuloProductoKardex.js"></script>
        <script type="text/javascript" src="../librerias/plugin/mask/jquery.mask.min.js"></script>
        <style>            
            .ui-autocomplete {
                width: 500px;
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
        <%
            int codArticuloProducto = 0;
            try {
                codArticuloProducto = (Integer) session.getAttribute("codArticuloProductoKardex");
            } catch (Exception e) {

            }
        %>
        <input type="hidden" name="paginaActualPermiso" id="permisoPaginaP7" value="" title="KARDEX ARTICULO PRODUCTO"/>
        <div id="wrap">
            <div id="header">
                <label class="horaCabecera"><%=objcManejoFechas.fechaCabecera()%></label>
            </div>
            <div id="right">
                <div id="rightSub1" class="ocultar">
                    <h3 class="titulo">
                        MOVIMIENTO DE PRODUCTOS
                    </h3>
                    <div>
                        <input type="text" name="codKardexArticuloProducto" id="codKardexArticuloProducto" value="" />
                        <input type="text" name="codOperacion" id="codOperacion" value="" />
                        <input type="text" name="codOperacionDetalle" id="codOperacionDetalle" value="" />
                    </div>
                    <table class="reporte-tabla-1 anchoTotal">
                        <thead>
                            <tr>
                                <th class="ancho60px medio">BUSCAR</th>
                                <td class="ancho120px contenedorEntrada medio"><input type="search" name="codArticuloProducto" id="codArticuloProducto" value="<%=codArticuloProducto == 0 ? "" : codArticuloProducto%>" class="anchoTotal entrada derecha" placeholder="Código"/></td>
                                <td class="contenedorEntrada"><textarea name="descripcion" id="descripcion" class="anchoTotal entrada mayuscula izquierda" style="height: 35px;" placeholder="Descripción"></textarea></td>
                                <th class="ancho60px medio">ALMACÉN</th>
                                <td class="contenedorEntrada ancho120px medio">
                                    <%
                                        List almacenList = new cAlmacen().leer();
                                    %>
                                    <select name="codAlmacen" id="codAlmacen" class="anchoTotal entrada">
                                        <%
                                            for (Iterator it = almacenList.iterator(); it.hasNext();) {
                                                Almacen objAlmacen = (Almacen) it.next();
                                        %>
                                        <option value="<%=objAlmacen.getCodAlmacen()%>"><%=objAlmacen.getAlmacen()%></option>
                                        <%
                                            }
                                        %>
                                    </select>
                                </td>
                            </tr>
                        </thead>
                    </table>
                    <table class="reporte-tabla-1 anchoTotal" style="margin-top: 10px; font-size: 10px;">
                        <thead>
                            <tr>
                                <th colspan="2">CÓDIGO/DESCRIPCIÓN</th>
                                <td colspan="7"><div class="vaciar" id="codDescripcion"></div></td>
                            </tr>
                            <tr>
                                <th style="width: 110px">Fecha y hora</th>
                                <th style="width: 100px">Documento</th>
                                <th>Detalles</th>
                                <th style="width: 30px">Entrada</th>
                                <th style="width: 30px">Salida</th>
                                <th style="width: 30px">Stock</th>
                                <th style="width: 65px">Precio</th>
                                <th style="width: 65px">P. Ponderado</th>
                                <th style="width: 65px">Total</th>
                            </tr>
                        </thead>
                        <tfoot>

                        </tfoot>
                        <tbody id="tbArticuloProductoKardex" class="vaciar">
                            <!--                            <tr>
                                                            <td>26/04/2013 13:36:50</td>
                                                            <td>F-001-029861</td>
                                                            <td>C/Crédito E.H. INVERSIONES SAC</td>
                                                            <td class="derecha">20</td>
                                                            <td class="derecha">0</td>
                                                            <td class="derecha">20</td>
                                                            <td class="derecha">310.00</td>
                                                            <td class="derecha">310.00</td>
                                                            <td class="derecha">6200.00</td>
                                                        </tr>-->
                        </tbody>
                    </table>
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