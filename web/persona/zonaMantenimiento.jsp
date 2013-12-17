<%-- 
    Document   : zonaListar
    Created on : 26/11/2012, 01:01:02 PM
    Author     : Henrri
--%>

<%@page import="utilitarios.cEmpresa"%>
<%@page import="utilitarios.cManejoFechas"%>
<%
    cManejoFechas objcManejoFechas = new cManejoFechas();
%>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <title><%=new cEmpresa().getAbreviatura()%> Zona mantenimiento</title>
        <!--todos-->
        <script type="text/javascript" src="../librerias/jquery/jquery-1.9.0-min.js" ></script>
        <script type="text/javascript" src="../librerias/jquery/jquery.timer-min.js" ></script>
        <script type="text/javascript" src="../librerias/jquery-ui/jquery-ui-1.10.3.custom/js/jquery-ui-1.10.3.custom.min.js" ></script>
        <link rel="stylesheet" type="text/css" href="../librerias/principal/todos.css" media="all"/>
        <!--cambios-->
        <%@include file="../principal/inclusiones.jsp" %>
        <!--propio-->
        <script type="text/javascript" src="../librerias/persona/zona/zonaMantenimiento.js"></script>
    </head>
    <body>
        <input type="hidden" name="paginaActualPermiso" id="permisoPaginaP16" value="" title="MANTENIMIENTO DE ZONA"/>
        <div id="wrap">
            <div id="header">
                <label class="horaCabecera"><%=objcManejoFechas.fechaCabecera()%></label>
            </div>
            <div id="right">
                <div id="rightSub1" class="ocultar">
                    <h3 class="titulo">
                        MANTENIMIENTO DE ZONA
                        <a class="sexybutton sexyicononly sexysimple sexysmall sexypropio" href="../persona/zonaRegistrar.jsp" id="bNuevo"><span class="add"></span></a>
                        <a class="sexybutton sexyicononly sexysimple sexysmall sexypropio" href="../persona/zonaEditar.jsp"><span class="edit"></span></a>
                        <button class="sexybutton sexyicononly sexysimple sexysmall sexypropio" id="bAnular"><span class="delete"></span></button>
                    </h3>
                    <%
                        int codZona = 0;
                        try {
                            codZona = (Integer) session.getAttribute("codZonaMantenimiento");
                        } catch (Exception e) {
                        }
                    %>
                    <input type="hidden" name="codZona" id="codZona" value="<%=codZona%>" />
                    <table class="reporte-tabla-1">
                        <thead>
                            <tr>
                                <th colspan="2" style="text-align: center;">
                                    <button class="sexybutton" id="bPrimero"><span><span><span class="first">Primero</span></span></span></button>
                                    <button class="sexybutton" id="bAnterior"><span><span><span class="prev">Anterior</span></span></span></button>
                                    <button class="sexybutton" id="bSiguiente"><span><span><span class="next">Siguiente</span></span></span></button>
                                    <button class="sexybutton" id="bUltimo"><span><span><span class="last">Último</span></span></span></button>
                                </th>
                            </tr>
                        </thead>
                        <tbody>
                            <tr>
                                <th style="width: 120px;">COD. ZONA</th>
                                <td id="lCodZona" class="vaciar" style="width: 320px;">XXXXXXXX</td>
                            </tr>
                            <tr>
                                <th>ZONA</th>
                                <td id="lZona" class="vaciar">NOMBRE DE ZONA</td>
                            </tr>
                            <tr>
                                <th>OBSERVACIÓN</th>
                                <td id="lDescripcion" class="vaciar" style="height: 100px;">OBESRVACIÓN DE LA ZONA.</td>
                            </tr>
                        </tbody>
                    </table>
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