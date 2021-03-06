<%-- 
    Document   : empresaConvenioRegistrar
    Created on : 09/10/2013, 07:37:25 PM
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
        <title> empresa convenio registrar</title>
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
        <script type="text/javascript" src="../librerias/persona/empresaConvenio/empresaConvenioRegistrar.js"></script>
    </head>
    <body>
        <input type="hidden" name="paginaActualPermiso" id="permisoPaginaP41" value="" title="REGISTAR EMPRESA CONVENIO"/>
        <div id="wrap">
            <div id="header">
                <label class="horaCabecera"><%=objcManejoFechas.fechaCabecera()%></label>
            </div>
            <div id="right">
                <div id="rightSub1" class="ocultar">
                    <h3 class="titulo">REGISTRAR EMPRESA CONVENIO</h3>
                    <form action="../sEmpresaConvenio" id="formEmpresaConvenioRegistrar">
                        <input type="hidden" name="accion" value="registrar" />
                        <table class="reporte-tabla-1">
                            <tr>
                                <th class="ancho200px"><label for="codEmpresaConvenio">COD EMPRESA/CONVENIO</label></th>
                                <td class="ancho360px"><span id="codEmpresaConvenio">AUTOGENERADO</span></td>
                            </tr>
                            <tr>
                                <th><label for="nombre">NOMBRE</label></th>
                                <td class="contenedorEntrada"><textarea name="nombre" id="nombre" class="anchoTotal alto60px mayuscula limpiar"></textarea></td>
                            </tr>
                            <tr>
                                <th><label for="abreviatura">ABREVIATURA</label></th>
                                <td class="contenedorEntrada"><input type="text" name="abreviatura" id="abreviatura" value="" class="anchoTotal mayuscula limpiar" /></td>
                            </tr>
                            <tr>
                                <th><label for="codCobranza">COD. COBRANZA</label></th>
                                <td class="contenedorEntrada"><input type="text" name="codCobranza" id="codCobranza" value="" class="ancho40px mayuscula limpiar"/><span>- NÚMERO:SERIE</span></td>
                            </tr>
                            <tr id="trBotones">
                                <th colspan="4" class="centrado">
                                    <button class="sexybutton" id="bCancelar" type="button"><span><span><span class="cancel">Cancelar</span></span></span></button>
                                    <button class="sexybutton" id="bRestaurar" type="reset"><span><span><span class="undo">Restaurar</span></span></span></button>
                                    <button class="sexybutton" id="bRegistrar" type="submit"><span><span><span class="save">Registrar</span></span></span></button>
                                </th>
                            </tr>
                        </table>
                    </form>
                </div>
                <div id="rightSub2" class="ocultar">
                    <div>
                        <h3 class="titulo">IMPORTADORA YUCRA S.A.C.</h3>
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
