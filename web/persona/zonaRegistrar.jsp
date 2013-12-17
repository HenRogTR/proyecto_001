<%-- 
    Document   : zonaRegistrar
    Created on : 30/09/2013, 11:19:34 AM
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
        <title> zona registrar</title>
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
        <script type="text/javascript" src="../librerias/persona/zona/zonaRegistrar.js"></script>
    </head>
    <body>
        <input type="hidden" name="paginaActualPermiso" id="permisoPaginaP46" value="" title="REGISTRAR ZONA"/>
        <div id="wrap">
            <div id="header">
                <label class="horaCabecera"><%=objcManejoFechas.fechaCabecera()%></label>
            </div>
            <div id="right">
                <div id="rightSub1" class="ocultar">
                    <h3 class="titulo">REGISTRAR ZONA</h3>
                    <form id="formZonaRegistrar" action="../sZona">
                        <input type="hidden" name="accionZona" value="registrar" />
                        <table class="reporte-tabla-1">                            
                            <tbody>
                                <tr>
                                    <th style="width: 120px;">COD. ZONA</th>
                                    <td id="lCodZona" class="vaciar" style="width: 320px;">AUTOGENERADO</td>
                                </tr>
                                <tr>
                                    <th>ZONA</th>
                                    <td id="lZona" class="vaciar contenedorEntrada"><input type="text" name="zona" id="zona" value="" class="limpiar anchoTotal mayuscula"></td>
                                </tr>
                                <tr>
                                    <th>OBSERVACIÓN</th>
                                    <td id="lDescripcion" class="vaciar contenedorEntrada" style="height: 100px;"><textarea name="descripcion" id="descripcion" class="anchoTotal altoTotal mayuscula"></textarea></td>
                                </tr>
                                <tr>
                                    <th colspan="2" class="centrado">
                                        <button type="button" class="sexybutton"><span><span><span class="cancel">Resturar</span></span></span></button>
                                        <button type="button" class="sexybutton"><span><span><span class="undo">Resturar</span></span></span></button>
                                        <button type="submit" class="sexybutton"><span><span><span class="save">Registrar</span></span></span></button>
                                    </th>
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