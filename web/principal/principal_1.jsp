<%-- 
    Document   : principal_1
    Created on : 16/07/2014, 05:35:13 PM
    Author     : Henrri
--%>

<%@page import="java.util.Date"%>
<%@page import="Clase.Fecha"%>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <title>JSP Page</title>
        <!--importando script-->
        <%@include file="scriptImportar.jsp" %>
        <link rel="stylesheet" type="text/css" href="../librerias/css/cssImportar.css" media="all"/>
        <script>
            function fPaginaActual() {
            }
            ;
        </script>
    </head>
    <body>
        <input type="hidden" name="paginaActualPermiso" value="1" title="PÁGINA PRINCIPAL"/>        
        <div id="wrap">
            <div id="header">
                <label class="horaCabecera"><%=new Fecha().fechaCabecera(new Date())%></label>
                <label class="usuarioInfo" id="lUsuario">USUARIO: SESIÓN NO INICIADA</label>
            </div>
            <div id="dMenu">
                <div class="titulo">
                    <div style="float: left;">
                        <div class="acceso">                            
                            <button class="sexybutton" id="bAccesoAbrir"><span><span><img src="../librerias/botonesIconos/images/icons/silk/key_go.png">Ingresar</span></span></button>
                        </div>
                        <div id="menu" class="ocultar">
                            <%@include file="menu_2.jsp" %>
                        </div>
                    </div>
                        <div class="titulo2" style="padding-left: 130px;">
                        PRINCIPAL
                    </div>
                </div>
            </div>
            <div id="finMenu" class="lineaDivisoria"></div>
            <div id="contenido">
                <div>
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
                        <div class="titulo titulo2">MISIÓN</div>
                        <div class="articles" style="font-size: 12px;padding: 10px;text-align: justify;">
                            Somos la empresa comercial que brinda servicio personalizado con una amplia gama de productos de calidada través de una cultura de valores.
                        </div>
                    </div>
                    <div style="width: 48%; float: right;">
                        <div class="titulo titulo2">VISIÓN</div>
                        <div class="articles" style="font-size: 12px;padding: 10px;text-align: justify;">
                            Ser la empresa comercial con productos de calidad para la exigencia de cada necesidad brindando un servicio de excelencia.
                        </div>
                    </div>
                </div>
            </div>
            <div id="finContenido" class="lineaDivisoria"></div>
            <div id="piePagina">
                <%@include file="piePagina.jsp" %>
            </div>
        </div>
    </body>
</html>
