<%-- 
    Document   : articuloProductoMantenimiento
    Created on : 29/08/2013, 09:43:57 AM
    Author     : Henrri ****
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
        <title>IY Artículo mantenimiento</title>
        <!--todos-->
        <script type="text/javascript" src="../librerias/jquery/jquery-1.9.0-min.js" ></script>
        <script type="text/javascript" src="../librerias/jquery/jquery.timer-min.js" ></script>
        <script type="text/javascript" src="../librerias/jquery-ui/jquery-ui-1.10.3.custom/js/jquery-ui-1.10.3.custom.min.js" ></script>
        <link rel="stylesheet" type="text/css" href="../librerias/principal/todos.css" media="all"/>
        <!--cambios-->
        <%@include file="../principal/inclusiones.jsp" %>
        <!--propio-->
        <script type="text/javascript" src="../librerias/articuloProducto/articuloProductoMantenimiento.js?v13.12.30"></script>
        <script type="text/javascript" src="../librerias/jquery/jquery.numeric-min.js"></script>
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
        <input type="hidden" name="paginaActualPermiso" id="permisoPaginaP4" value="" title="MANTENIMIENTO DE ARTÍCULOS"/>
        <div id="wrap">
            <div id="header">
                <label class="horaCabecera"><%=objcManejoFechas.fechaCabecera()%></label>
            </div>
            <div id="right">
                <div id="rightSub1" class="ocultar">                    
                    <h3 class="titulo">
                        <button class="sexybutton sexysimple sexyicononly sexysmall sexypropio" id="bAPBuscar"><span class="search"></span></button>
                        ARTÍCULO MANTENIMIENTO
                    </h3>
                    <%
                        int codAP = 0;
                        try {
                            codAP = (Integer) session.getAttribute("codArticuloProductoMantenimiento");
                        } catch (Exception e) {
                            codAP = 0;
                        }
                    %>
                    <input type="hidden" name="codArticuloProducto" id="codArticuloProducto" value="<%=codAP%>" />
                    <div id="dAPAccordion">
                        <h3>DATOS GENERALES</h3>
                        <div>
                            <table class="reporte-tabla-1">
                                <thead>
                                    <tr>
                                        <th colspan="3" style="text-align: center;">
                                            <button class="sexybutton" id="bPrimero"><span><span><span class="first">Primero</span></span></span></button>
                                            <button class="sexybutton" id="bAnterior"><span><span><span class="prev">Anterior</span></span></span></button>
                                            <button class="sexybutton" id="bSiguiente"><span><span><span class="next">Siguiente</span></span></span></button>
                                            <button class="sexybutton" id="bUltimo"><span><span><span class="last">Último</span></span></span></button>
                                        </th>
                                        <th style="text-align: center;">                                                
                                            <a class="sexybutton sexyicononly sexysimple sexysmall sexypropio" id="bNuevo"><span class="add"></span></a>
                                            <button class="sexybutton sexyicononly sexysimple sexysmall sexypropio" id="bEditar"><span class="edit"></span></button>
                                            <button class="sexybutton sexyicononly sexysimple sexysmall sexypropio" id="bAnular"><span class="delete"></span></button>
                                        </th>
                                    </tr>
                                </thead>
                                <tbody>
                                    <tr>
                                        <th style="width: 160px;">CÓDIGO</th>
                                        <td style="width: 200px;" id="lCodArticuloProducto" class="vaciar"></td>
                                        <th style="width: 160px;">CÓDIGO DE REFERENCIA</th>
                                        <td style="width: 200px;" id="lCodReferencia" class="vaciar"></td>
                                    </tr>
                                    <tr>
                                        <th>DESCRIPCIÓN</th>
                                        <td colspan="3" id="lDescripcion" class="vaciar"></td>
                                    </tr>
                                    <tr>
                                        <th class="medio">
                                            STOCK <button id="bStock" class="boton iconoSoloPequenio info disabled" disabled="">&nbsp;</button>
                                        </th>
                                        <td id="lStock" class="vaciar"></td>
                                        <th class="medio">
                                            PRECIO VENTA <button id="bPrecioVentaModificar" class="boton iconoSoloPequenio edit" disabled="">&nbsp;</button>
                                        </th>
                                        <td id="lPrecioVenta" class="vaciar"></td>
                                    </tr>
                                    <tr>
                                        <th>HABILITAR S/N</th>
                                        <td id="lUsarSerieNumero" class="vaciar"></td>
                                        <th>UNIDAD DE MEDIDA</th>
                                        <td id="lUnidadMedida" class="vaciar"></td>
                                    </tr>
                                    <tr>
                                        <th>REINTEGRO TRIBUTARIO</th>
                                        <td id="lReintegroTributario" class="vaciar"></td>
                                    </tr>
                                    <tr>
                                        <th>FAMILIA</th>
                                        <td id="lFamilia" class="vaciar"></td>
                                        <th>MARCA</th>
                                        <td id="lMarca" class="vaciar"></td>
                                    </tr>
                                    <tr>
                                        <th>OBSERVACIÓN</th>
                                        <td colspan="3" id="lObservacion" class="vaciar" style="height: 50px;"></td>
                                    </tr>
                                </tbody>
                            </table>
                        </div>
                        <h3>COMPRA(S)/ENTRDA - ÚLTIMAS 10 </h3>
                        <div>
                            <table class="reporte-tabla-1">
                                <thead>
                                    <tr>
                                        <th style="width: 120px;">FECHA</th>
                                        <th style="width: 120px;">DOC N/S</th>
                                        <th style="width: 120px;">TIPO</th>
                                        <th style="width: 80px;">P. UNITARIO</th>
                                        <th style="width: 280px;">PROVEEDOR</th>
                                    </tr>
                                </thead>
                                <tfoot>

                                </tfoot>
                                <tbody id="tbAPCompraResumen">

                                </tbody>
                            </table>
                        </div>
                        <h3>VENTAS(S)SALIDA - ÚLTIMAS 10 </h3>
                        <div>
                            <table class="reporte-tabla-1">
                                <thead>
                                    <tr>
                                        <th style="width: 120px;">FECHA</th>
                                        <th style="width: 120px;">DOC N/S</th>
                                        <th style="width: 120px;">TIPO</th>
                                        <th style="width: 80px;">IMPORTE</th>
                                        <th style="width: 280px;">CLIENTE</th>
                                    </tr>
                                </thead>
                                <tfoot>

                                </tfoot>
                                <tbody id="tbAPVentaResumen">

                                </tbody>
                            </table>
                        </div>
                    </div>
                    <!--inicio dialogos-->
                    <div id="dPrecioVentaModificar" title="Modificar precio venta">
                        <table class="reporte-tabla-1" style="font-size: 13px;">
                            <tr>
                                <th style="width: 100px;">PRECIO ACTUAL</th>
                                <td style="width: 140px;" id="lPrecioActualAux" class="vaciar"></td>
                            </tr>
                            <tr>
                                <th>NUEVO PRECIO</th>
                                <td>S/. <input id="precioNuevo" name="precioNuevo" style="width: 80px;"/></td>
                            </tr>
                        </table>
                    </div>
                    <div id="dAPBuscar" style="padding: 20px;" title="Buscar">
                        <table class="reporte-tabla-1" style="width: 100%;">
                            <thead>
                                <tr>
                                    <th style="width: 120px;">CÓDIGO</th>
                                    <th>DESCRIPCIÓN</th>
                                </tr>
                            </thead>
                            <tr>
                                <td>
                                    <input type="text" name="codArticuloProductoBuscar" id="codArticuloProductoBuscar" value="" />
                                </td>
                                <td>
                                    <input type="text" name="descripcionBuscar" id="descripcionBuscar" value="" style="width: 98%;"/>
                                </td>
                            </tr>
                        </table>
                    </div>
                    <!--fin dialogos-->
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
                    <a id="bAccesoAbrir" class="boton botonNormal key">Ejecutar SICCI</a>
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