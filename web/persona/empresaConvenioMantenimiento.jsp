<%-- 
    Document   : empresaConvenioMantenimiento
    Created on : 30/09/2013, 06:53:52 PM
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
        <title>empresa/convenio mantenimiento</title>
        <!--todos-->
        <script type="text/javascript" src="../librerias/jquery/jquery-1.9.0-min.js" ></script>
        <script type="text/javascript" src="../librerias/jquery/jquery.timer-min.js" ></script>
        <script type="text/javascript" src="../librerias/jquery-ui/jquery-ui-1.10.3.custom/js/jquery-ui-1.10.3.custom.min.js" ></script>
        <link rel="stylesheet" type="text/css" href="../librerias/principal/todos.css" media="all"/>
        <!--cambios-->
        <%@include file="../principal/inclusiones.jsp" %>
        <!--propio-->
        <script type="text/javascript" src="../librerias/persona/empresaConvenio/empresaConvenioMantenimiento.js?v.13.11.20"></script>
    </head>
    <body>
        <input type="hidden" name="paginaActualPermiso" id="permisoPaginaP12" value="" title=""/>
        <div id="wrap">
            <div id="header">
                <label class="horaCabecera"><%=objcManejoFechas.fechaCabecera()%></label>
            </div>
            <div id="right">
                <div id="rightSub1" class="ocultar">
                    <h3 class="titulo">MANTENIMIENTO EMPRESA CONVENIO <a class="sexybutton sexyicononly sexysimple sexysmall sexypropio" href="empresaConvenioRegistrar.jsp" id="bNuevo"><span class="add"></span></a></h3>
                            <%
                                int codEmpresaConvenio = 0;
                                try {
                                    codEmpresaConvenio = (Integer) session.getAttribute("codEmpresaConvenioMantenimiento");
                                } catch (Exception e) {
                                    codEmpresaConvenio = 0;
                                }
                            %>
                    <input type="hidden" name="codEmpresaConvenio" id="codEmpresaConvenio" value="<%=codEmpresaConvenio%>" />
                    <div id="accordionEmpresaConvenioMantenimiento">
                        <h3>DATOS GENERALES</h3>
                        <div class="">
                            <table class="reporte-tabla-1">
                                <tr>
                                    <th colspan="2" class="centrado">
                                        <button class="sexybutton" id="bPrimero"><span><span><span class="first">Primero</span></span></span></button>
                                        <button class="sexybutton" id="bAnterior"><span><span><span class="prev">Anterior</span></span></span></button>
                                        <button class="sexybutton" id="bSiguiente"><span><span><span class="next">Siguiente</span></span></span></button>
                                        <button class="sexybutton" id="bUltimo"><span><span><span class="last">Último</span></span></span></button>
                                    </th>
                                </tr>
                                <tr>
                                    <th class="ancho160px medio">
                                        <button class="sexybutton sexyicononly sexysimple sexysmall sexypropio" id="bEditar"><span class="edit"></span></button>
                                        <button class="sexybutton sexyicononly sexysimple sexysmall sexypropio" id="bEliminar"><span class="delete"></span></button>
                                        CÓDIGO
                                    </th>
                                    <td id="lcodEmpresaConvenio" class="vaciar ancho400px">XXXXXXXX</td>
                                </tr>
                                <tr>
                                    <th>NOMBRE</th>
                                    <td id="lNombre" class="vaciar">EMPRESA1</td>
                                </tr>
                                <tr>
                                    <th>ABREVIATURA</th>
                                    <td id="lAbreviatura" class="vaciar">EMP</td>
                                </tr>
                                <tr>
                                    <th>COD. COBRANZA(S)</th>
                                    <td id="lCodCobranza" class="vaciar">E01</td>
                                </tr>
                            </table>
                        </div>
                        <h3>SERIES ASIGNADAS</h3>
                        <div>
                            <table class="reporte-tabla-1">
                                <thead>
                                    <tr>
                                        <th class="ancho120px">CÓD.</th>
                                        <th class="ancho80px">SERIE</th>
                                        <th class="ancho200px">ÚLTIMO GENERADO</th>
                                        <th class="ancho200px">ÚLTIMO USADO</th>
                                    </tr>
                                </thead>
                                <tbody class="vaciar" id="tSerieNumeroGenerado">
                                    <%
                                        for (int i = 1; i <= 12; i++) {
                                    %>
                                    <tr>
                                        <td class="centrado">E01</td>
                                        <td class="centrado"><%= i < 10 ? "00" + i : (i < 100) ? "0" + i : i%></td>
                                        <td class="centrado">E01-<%= i < 10 ? "00" + i : (i < 100) ? "0" + i : i%>-000XXXX</td>
                                        <td class="centrado">E01-<%= i < 10 ? "00" + i : (i < 100) ? "0" + i : i%>-0000XXX</td>
                                    </tr>
                                    <%
                                        }
                                    %>
                                </tbody>
                            </table>
                        </div>
                    </div>
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