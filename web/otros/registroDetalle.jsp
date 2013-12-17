<%-- 
    Document   : registroDetalle
    Created on : 11/10/2013, 08:05:06 PM
    Author     : Henrri
--%>

<%@page import="personaClases.cUsuario"%>
<%@page import="tablas.Usuario"%>
<%@page import="utilitarios.cManejoFechas"%>
<%
    cManejoFechas objcManejoFechas = new cManejoFechas();

%>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <title>registro detalle</title>
        <!--todos-->
        <script type="text/javascript" src="../librerias/jquery/jquery-1.9.0-min.js" ></script>
        <script type="text/javascript" src="../librerias/jquery/jquery.timer-min.js" ></script>
        <script type="text/javascript" src="../librerias/jquery-ui/jquery-ui-1.10.3.custom/js/jquery-ui-1.10.3.custom.min.js" ></script>
        <link rel="stylesheet" type="text/css" href="../librerias/principal/todos.css" media="all"/>
        <!--cambios-->
        <%@include file="../principal/inclusiones.jsp" %>
        <!--propio-->
        <script>
            function fPaginaActual() {
            }
            ;
        </script>
    </head>
    <body>
        <input type="hidden" name="paginaActualPermiso" id="permisoPaginaP60" value="" title="DETALLE REGISTRO"/>
        <div id="wrap">
            <div id="header">
                <label class="horaCabecera"><%=objcManejoFechas.fechaCabecera()%></label>
            </div>
            <div id="right">
                <div id="rightSub1" class="ocultar">
                    <h3 class="titulo">DETALLE DE REGISTRO</h3>
                    <table class="reporte-tabla-1 anchoTotal">
                        <%
                            String registro = "";
                            String historial = "";
                            try {
                                registro = request.getParameter("registro").toString();
                                historial = request.getParameter("historial").toString();
                                if (registro.length() >= 16) {
                                    Usuario objUsuario = new cUsuario().leer_cod(Integer.parseInt(registro.substring(15, registro.length())));
                        %>
                        <tr>
                            <th class="ancho200px">ESTADO</th>
                            <td><%=registro.substring(0, 1).equals("0") ? "BORRADO/DESABILITADO/ANULADO" : (registro.substring(0, 1).equals("1") ? "ACTIVO/HABILITADO" : "OTROS")%></td>
                        </tr>
                        <tr>
                            <th>USUARIO</th>
                            <td><%=objUsuario.getUsuario()%></td>
                        </tr>
                        <tr>
                            <th>FECHA Y HORA*</th>
                            <td><%=objcManejoFechas.fechaHoraFormatoDeRegistro(registro)%></td>
                        </tr>
                        <tr>
                            <th>HISTORIAL DE CAMBIOS</th>
                            <td>
                                <%
                                    if (historial.length() >= 16) {
                                        String[] registroHistoria = historial.split(":");
                                        for (int i = registroHistoria.length - 1; i >= 0; i--) {
                                            String regTem = registroHistoria[i];
                                            if (regTem.length() >= 16) {
                                                out.print(objcManejoFechas.fechaHoraFormatoDeRegistro(regTem) + " " + new cUsuario().leer_cod(Integer.parseInt(regTem.substring(15, regTem.length()))).getUsuario() + " " + (regTem.substring(0, 1).equals("0") ? "BORRADO/DESABILITADO/ANULADO" : (regTem.substring(0, 1).equals("1") ? "ACTIVO/HABILITADO" : "OTROS")) + " <br>");
                                            } else {
                                                out.print("Parámetro erroneo<br>");
                                            }
                                        }
                                    }
                                %>
                            </td>
                        </tr>
                        <tr>
                            <td colspan="2" class="derecha" style="color: red;">(*) última actualización</td>
                        </tr>
                        <%
                        } else {
                        %>
                        <tr>
                            <th>PARÁMETRO CON ERROR, VERIFIQUE EL ORIGEN</th>
                        </tr>
                        <%
                            }
                        } catch (Exception e) {
                        %>
                        <tr>
                            <th>ERROR EN PARÁMETRO</th>
                        </tr>
                        <%
                            }
                        %>


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