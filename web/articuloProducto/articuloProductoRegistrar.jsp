<%-- 
    Document   : articuloProductoRegistrar
    Created on : 08/11/2012, 11:06:39 AM
    Author     : Henrri
--%>

<%@page import="articuloProductoClases.cMarca"%>
<%@page import="tablas.Marca"%>
<%@page import="articuloProductoClases.cFamilia"%>
<%@page import="tablas.Familia"%>
<%@page import="java.util.Iterator"%>
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
        <title>IY Registrar Articulo Producto</title>
        <!--todos-->
        <script type="text/javascript" src="../librerias/jquery/jquery-1.9.0-min.js" ></script>
        <script type="text/javascript" src="../librerias/jquery/jquery.timer-min.js" ></script>
        <script type="text/javascript" src="../librerias/jquery-ui/jquery-ui-1.10.3.custom/js/jquery-ui-1.10.3.custom.min.js" ></script>
        <link rel="stylesheet" type="text/css" href="../librerias/principal/todos.css" media="all"/>
        <!--cambios-->
        <%@include file="../principal/inclusiones.jsp" %>
        <!--propio-->
        <script type="text/javascript" src="../librerias/jquery.validate/1.11.1/jquery.validate.min.js"></script>
        <script type="text/javascript" src="../librerias/jquery.validate/1.11.1/localization/messages_es.js"></script>
        <script type="text/javascript" src="../librerias/articuloProducto/articuloProductoRegistrar.js"></script>
    </head>
    <body>
        <input type="hidden" name="paginaActualPermiso" id="permisoPaginaP15" value="" title="REGISTRO DE ARTÍCULO/PRODUCTO"/>
        <div id="wrap">
            <div id="header">
                <label class="horaCabecera"><%=objcManejoFechas.fechaCabecera()%></label>
            </div>
            <div id="right">
                <div id="rightSub1" class="ocultar">                    
                    <h3 class="titulo">REGISTRAR ARTICULO PRODUCTO</h3>
                    <%
                        cFamilia objcFamilia = new cFamilia();
                        cMarca objcMarca = new cMarca();
                    %>
                    <form id="formArticuloProducto" action="../sArticuloProducto">
                        <input type="hidden" name="accionArticuloProducto" id="accionArticuloProducto" value="registrar" />
                        <input type="hidden" name="codArticuloProducto" id="codArticuloProducto" value="" />
                        <table class="reporte-tabla-1">
                            <tfoot>
                                <tr id="trBotones">
                                    <th colspan="4">
                                        <button class="sexybutton" type="button" id="cancelar"><span><span><span class="cancel">Cancelar</span></span></span></button>
                                        <button class="sexybutton" type="reset" id="restaurar"><span><span><span class="redo">Restaurar</span></span></span></button>
                                        <button class="sexybutton" type="submit" id="accion"><span><span><span class="save">Guardar</span></span></span></button>
                                    </th>
                                </tr>
                            </tfoot>
                            <tbody>
                                <tr>
                                    <th style="width: 160px;">CÓDIGO</th>
                                    <td style="width: 200px;">
                                        AUTOGENERADO
                                    </td>
                                    <th style="width: 160px;">CÓDIGO DE REFERENCIA</th>
                                    <td style="width: 200px;">
                                        <input type="text" name="codReferencia" id="codReferencia" class="vaciar dato"/>
                                    </td>
                                </tr>
                                <tr>
                                    <th>DESCRIPCIÓN</th>
                                    <td colspan="3">
                                        <textarea id="descripcion" name="descripcion" style="width: 95%;height: 50px" class="vaciar dato"></textarea>
                                    </td>
                                </tr>
                                <tr>
                                    <th>
                                        HABILITAR S/N
                                        <a class="sexybutton sexyicononly sexysimple sexysmall sexypropio" id="bSerieNumeroInfo"><span class="info"></span></a>
                                    </th>
                                    <td>
                                        <select id="usarSerieNumero" name="usarSerieNumero" class="vaciar">
                                            <option value="">Seleccione</option>
                                            <option value="1">Habilitar</option>
                                            <option value="0">Deshabilitar</option>
                                        </select>
                                    </td>
                                    <th>UNIDAD DE MEDIDA</th>
                                    <td>
                                        <input type="text" id="unidadMedida" name="unidadMedida" style="width: 90%" class="vaciar dato"/>
                                    </td>
                                </tr>
                                <tr>
                                    <th>REINTEGRO TRIBUTARIO</th>
                                    <td>
                                        <select id="reintegroTributario" name="reintegroTributario" class="vaciar">
                                            <option value="">Seleccione</option>
                                            <option value="1">Si</option>
                                            <option value="0">No</option>
                                        </select>
                                    </td>
                                </tr>
                                <tr>
                                    <th>FAMILIA</th>
                                    <td>
                                        <select id="codFamilia" name="codFamilia" class="vaciar">
                                            <option value="">Seleccione</option>
                                            <%
                                                List lFamilia = objcFamilia.leer();
                                                Iterator iFamilia = lFamilia.iterator();
                                                while (iFamilia.hasNext()) {
                                                    Familia objFamilia = (Familia) iFamilia.next();
                                            %>
                                            <option value="<%=objFamilia.getCodFamilia()%>"><%=objFamilia.getFamilia()%></option>
                                            <%
                                                }
                                            %>
                                        </select>
                                    </td>
                                    <th>MARCA</th>
                                    <td>
                                        <select id="codMarca" name="codMarca" class="vaciar">
                                            <option value="">Seleccione</option>
                                            <%
                                                List lMarca = objcMarca.leer();
                                                Iterator iMarca = lMarca.iterator();
                                                while (iMarca.hasNext()) {
                                                    Marca objMarca = (Marca) iMarca.next();
                                            %>
                                            <option value="<%=objMarca.getCodMarca()%>"><%=objMarca.getDescripcion()%></option>
                                            <%
                                                }
                                            %>
                                        </select>
                                    </td>

                                </tr>
                                <tr>
                                    <th>OBSERVACIÓN</th>
                                    <td colspan="3">
                                        <textarea id="observacion" name="observacion" style="width: 95%;height: 50px" class="vaciar dato"></textarea>
                                    </td>
                                </tr>
                            </tbody>
                        </table>
                    </form>
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
                <!--dialog*******************************************************-->
                <!--div info serie numero-->                
                <div title="Información Serie/Número" id="dSerieNumeroInfo" style="font-size: 13px;text-align: justify;">
                    <div class="ui-state-highlight ui-corner-all" style="margin-top: 20px; padding: 0 .7em;">
                        <p><span class="ui-icon ui-icon-info" style="float: left; margin-right: .3em;"></span>
                            <strong>¡Advertencia!</strong> Estimado usuario indique si el Artículo a registrar se va controlar o no 
                            por <b>Serie/Número</b>, una vez completado el registro no se podrá modificar.<br>
                            En caso de dudas sirvase a consultar con el área respectiva.
                    </div>
                </div>
                <div id="dAPRegistrarExito" title="Registro exitoso" style="text-align: justify;">
                    Se ha registrado correctamente el artículo.<br>
                    Seleccione la opcíon a realizar.
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