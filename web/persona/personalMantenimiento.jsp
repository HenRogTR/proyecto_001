<%-- 
    Document   : personalMantenimiento
    Created on : 21/08/2013, 05:04:31 PM
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
        <title>:.SICCI Importadora Yucra. S.A.C.</title>
        <!--todos-->
        <script type="text/javascript" src="../librerias/jquery/jquery-1.9.0-min.js" ></script>
        <script type="text/javascript" src="../librerias/jquery/jquery.timer-min.js" ></script>
        <script type="text/javascript" src="../librerias/jquery-ui/jquery-ui-1.10.3.custom/js/jquery-ui-1.10.3.custom.min.js" ></script>
        <link rel="stylesheet" type="text/css" href="../librerias/principal/todos.css" media="all"/>
        <!--cambios-->
        <%@include file="../principal/inclusiones.jsp" %>
        <!--propio-->
        <script type="text/javascript" src="../librerias/persona/personal/personalMantenimiento.js"></script>
    </head>
    <body>
        <input type="hidden" name="paginaActualPermiso" id="permisoPaginaP9" value="" title="MANTENIMIENTO DE CLIENTES"/>
        <div id="wrap">
            <div id="header">
                <label class="horaCabecera"><%=objcManejoFechas.fechaCabecera()%></label>
            </div>
            <div id="right">
                <div id="rightSub1" class="ocultar">
                    <%
                        int codPersonal = 0;
                        try {
                            codPersonal = (Integer) session.getAttribute("codPersonalMantenimiento");
                        } catch (Exception e) {
                            codPersonal = 0;
                        }
                    %>
                    <h3 class="titulo">MANTENIMIENTO DE PERSONAL</h3>                    
                    <input type="hidden" name="codPersonal" id="codPersonal" value="<%=codPersonal%>" />
                    <input type="hidden" name="codPersona" id="codPersona"/>
                    <div id="accordion">
                        <h3>DATOS PERSONALES</h3>
                        <div>
                            <table class="reporte-tabla-1">                            
                                <tbody>
                                    <tr>
                                        <th colspan="3" style="text-align: center;">
                                            <button class="sexybutton" id="bPrimero"><span><span><span class="first">Primero</span></span></span></button>
                                            <button class="sexybutton" id="bAnterior"><span><span><span class="prev">Anterior</span></span></span></button>
                                            <button class="sexybutton" id="bSiguiente"><span><span><span class="next">Siguiente</span></span></span></button>
                                            <button class="sexybutton" id="bUltimo"><span><span><span class="last">Último</span></span></span></button>
                                        </th>
                                        <th>
                                            <a class="sexybutton sexyicononly sexysimple sexysmall sexypropio" href="personalRegistrar.jsp" id="bNuevoTabla"><span class="add"></span></a>
                                            <a class="sexybutton sexyicononly sexysimple sexysmall sexypropio" href="personalEditar.jsp"><span class="edit"></span></a>
                                            <button class="sexybutton sexyicononly sexysimple sexysmall sexypropio" id="bEliminar"><span class="delete"></span></button>
                                        </th>
                                    </tr>
                                    <tr>
                                        <th>CÓD. PERSONAL</th>
                                        <td id="lCodPersonal" class="vaciar"></td>
                                    </tr>
                                    <tr>
                                        <th style="width: 120px;">DNI</th>
                                        <td style="width: 240px;" id="lDniPasaporte" class="vaciar"></td>
                                        <th style="width: 120px;">RUC</th>
                                        <td style="width: 240px;" id="lRuc" class="vaciar"></td>
                                    </tr>
                                    <tr>
                                        <th>A. PATERNO</th>
                                        <td colspan="3" id="lApePaterno" class="vaciar"></td>
                                    </tr>
                                    <tr>
                                        <th>A. MATERNO</th>
                                        <td colspan="3" id="lApeMaterno" class="vaciar"></td>
                                    </tr>
                                    <tr>
                                        <th>NOMBRES</th>
                                        <td colspan="3" id="lNombres" class="vaciar"></td>
                                    </tr>
                                    <tr>
                                        <th>SEXO</th>
                                        <td id="lSexo" class="vaciar"></td>
                                        <th>F. NACIMIENTO</th>
                                        <td id="lFechaNacimiento" class="vaciar"></td>
                                    </tr>
                                    <tr>
                                        <th>ESTADO CIVIL</th>
                                        <td id="lEstadoCivil" class="vaciar"></td>
                                    </tr>
                                    <tr>
                                        <th>CONYUGE</th>
                                        <td colspan="3" id="lConyuge" class="vaciar"></td>
                                    </tr>
                                    <tr>
                                        <th>TELÉFONO 1</th>
                                        <td id="lTelefono1P" class="vaciar"></td>
                                        <th>TELÉFONO 2</th>
                                        <td id="lTelefono2P" class="vaciar"></td>
                                    </tr>
                                    <tr>
                                        <th>DIRECCIÓN</th>
                                        <td colspan="3" id="lDireccion" class="vaciar"></td>
                                    </tr>
                                    <tr>
                                        <th>DIR/ZONA</th>
                                        <td colspan="3" id="lZona" class="vaciar"></td>
                                    </tr>
                                    <tr>
                                        <th>CORREO</th>
                                        <td colspan="3" id="lCorreo" class="vaciar"></td>
                                    </tr>
                                    <tr>
                                        <th style="height: 60px;">OBSERVACIONES</th>
                                        <td colspan="3" id="lObservacionPersona" class="vaciar"></td>
                                    </tr>
                                </tbody>
                            </table>
                        </div>
                        <h3>DATOS LABORALES</h3>
                        <div>
                            <table class="reporte-tabla-1">
                                <tbody>
                                    <tr>
                                        <th>ESTADO</th>
                                        <td id="lEstado" class="vaciar"></td>
<!--                                        <th>CONDICIÓN</th>
                                        <td id="lCondicion" class="vaciar"></td>-->
                                    </tr>
                                    <tr>
                                        <th style="width: 120px;">CARGO(S)</th>
                                        <td style="width: 240px;" id="lCargo" class="vaciar"></td>
                                        <th style="width: 120px;">ÁREA(S)</th>
                                        <td style="width: 240px;" id="lArea" class="vaciar"></td>
                                    </tr>
                                    <tr>
                                        <th>F. INICIO ACT.</th>
                                        <td id="lFechaInicioActividades" class="vaciar"></td>
                                        <th>F. FIN ACT.</th>
                                        <td id="lFechaFinActividades" class="vaciar"></td>
                                    </tr>
                                    <tr>
                                        <th style="height: 60px;">OBSERVACIONES</th>
                                        <td colspan="3" id="lObservacionPersonal" class="vaciar"></td>
                                    </tr>
                                </tbody>
                            </table>
                        </div>
                        <h3>OBSERVACIONES</h3>
                        <div>

                        </div>
                        <h3>OPCIONES</h3>
                        <div>

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
                    <!--                    <input type="text" name="usuario" id="usuario" placeholder="Usuario" class="login"/>
                                        <input type="password" name="contrasenia" id="contrasenia" placeholder="Contraseña" class="login"/>-->
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
