<%-- 
    Document   : personalEditar
    Created on : 09/01/2013, 12:25:20 PM
    Author     : Henrri********
--%>

<%@page import="utilitarios.cOtros"%>
<%@page import="tablas.PNatural"%>
<%@page import="personaClases.cPersonal"%>
<%@page import="tablas.Personal"%>
<%@page import="tablas.Area"%>
<%@page import="personaClases.cArea"%>
<%@page import="tablas.Cargo"%>
<%@page import="java.util.Iterator"%>
<%@page import="personaClases.cCargo"%>
<%@page import="tablas.Zona"%>
<%@page import="java.util.List"%>
<%@page import="personaClases.cZona"%>
<%@page import="utilitarios.cManejoFechas"%>
<%
    cManejoFechas objcManejoFechas = new cManejoFechas();
    cOtros objcOtros = new cOtros();
    int codPersonal = 0;
    Personal objPersonal = null;
    try {
        codPersonal = (Integer) session.getAttribute("codPersonalEditar");
        objPersonal = new cPersonal().leer_cod(codPersonal);
        if (objPersonal == null) {
            response.sendRedirect("personalMantenimiento.jsp");
            return;
        }
    } catch (Exception e) {
        response.sendRedirect("personalMantenimiento.jsp");
        return;
    }
%>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <title>IY Personal editar</title>
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
        <script type="text/javascript" src="../librerias/jquery.validate/1.11.1/additional-methods.min.js"></script>        
        <script type="text/javascript" src="../librerias/jquery-ui/jquery-ui-1.10.3.custom/js/i18n/jquery.ui.datepicker-es-min.js"></script>
        <script type="text/javascript" src="../librerias/jquery.maskedinput/jquery.maskedinput.min.js"></script>
        <script type="text/javascript" src="../librerias/persona/personal/personalEditar.js"></script>
    </head>
    <body>
        <input type="hidden" name="paginaActualPermiso" id="permisoPaginaP30" value="" title="MANTENIMIENTO DE CLIENTES"/>
        <div id="wrap">
            <div id="header">
                <label class="horaCabecera"><%=objcManejoFechas.fechaCabecera()%></label>
            </div>
            <div id="right">
                <div id="rightSub1" class="ocultar">                    
                    <h3 class="titulo">EDITAR PERSONAL</h3>
                    <%
                        PNatural objNatural = null;
                        for (PNatural objNatural1 : objPersonal.getPersona().getPNaturals()) {
                            if (objNatural1.getRegistro().substring(0, 1).equals("1")) {
                                objNatural = objNatural1;
                            }
                        }
                    %>
                    <form id="formPersonalEditar" action="../sPersonal" method="get">
                        <input type="hidden" name="accionPersonal" id="accionPersonal" value="editar"/>
                        <input type="hidden" name="codPersona" id="codPersona" class="vaciar" value="<%=objPersonal.getPersona().getCodPersona()%>"/>
                        <input type="hidden" name="codNatural" id="codNatural" class="vaciar" value="<%=objNatural.getCodNatural()%>"/>
                        <input type="hidden" name="codPersonal" id="codPersonal" value="<%=objPersonal.getCodPersonal()%>"/>
                        <input type="hidden" name="marcador" id="marcador" class="vaciar"/>
                        <div id="accordion">
                            <h3>DATOS PERSONALES</h3>
                            <div>
                                <table class="reporte-tabla-1">                                    
                                    <tbody>
                                        <tr>
                                            <th>CÓDIGO</th>
                                            <td><%=objcOtros.agregarCeros_int(objPersonal.getCodPersonal(), 8)%></td>
                                        </tr>
                                        <tr>
                                            <th style="width: 120px;">DNI</th>
                                            <td style="width: 240px;">
                                                <input type="text" id="dniPasaporte" name="dniPasaporte" class="limpiar" style="width:95%;" value="<%=objPersonal.getPersona().getDniPasaporte()%>"/>
                                            </td>
                                            <th style="width: 120px;">RUC</th>
                                            <td style="width: 240px;">
                                                <input type="text" id="ruc" name="ruc" class="limpiar" style="width: 95%;" value="<%=objPersonal.getPersona().getRuc()%>"/>
                                            </td>
                                        </tr>
                                        <tr>
                                            <th>A. PATERNO</th>
                                            <td colspan="3">
                                                <input type="text" id="apePaterno" name="apePaterno" style="width: 95%;" class="limpiar mayuscula" value="<%=objNatural.getApePaterno()%>"/>
                                            </td>
                                        </tr>
                                        <tr>
                                            <th>A. MATERNO</th>
                                            <td colspan="3">
                                                <input type="text" id="apeMaterno" name="apeMaterno" style="width: 95%;" class="limpiar mayuscula" value="<%=objNatural.getApeMaterno()%>"/>
                                            </td>
                                        </tr>
                                        <tr>
                                            <th>NOMBRES</th>
                                            <td colspan="3">
                                                <input type="text" id="nombres" name="nombres" style="width: 95%;"  class="limpiar mayuscula" value="<%=objPersonal.getPersona().getNombres()%>"/>
                                            </td>
                                        </tr>
                                        <tr>
                                            <th>SEXO</th>
                                            <td>
                                                <select name="sexo" id="sexo" class="limpiar" style="width: 90%;">
                                                    <option value="">SELECCIONE</option>
                                                    <option value="1" <%if (objNatural.getSexo()) {%>selected=""<%}%>>FEMENINO</option>
                                                    <option value="0" <%if (!objNatural.getSexo()) {%>selected=""<%}%>>MASCULINO</option>
                                                </select>
                                            </td>
                                            <th>F. NACIMIENTO</th>
                                            <td>
                                                <input type="text" name="fechaNacimiento" id="fechaNacimiento" class="limpiar" placeholder="dd/mm/yyyy" style="width: 90%;" value="<%=objcManejoFechas.DateAString(objPersonal.getPersona().getFechaNacimiento())%>"/>
                                            </td>
                                        </tr>
                                        <tr>
                                            <th>ESTADO CIVIL</th>
                                            <td>
                                                <select id="estadoCivil" name="estadoCivil" class="limpiar" style="width: 90%;">
                                                    <option value="">SELECCIONE</option>
                                                    <option value="SOLTERO" <%if (objNatural.getEstadoCivil().toUpperCase().equals("SOLTERO")) {%>selected=""<%}%>>SOLTERO(A)</option>
                                                    <option value="CASADO"<%if (objNatural.getEstadoCivil().toUpperCase().equals("CASADO")) {%>selected=""<%}%>>CASADO(A)</option>
                                                    <option value="DIVORCIADO" <%if (objNatural.getEstadoCivil().toUpperCase().equals("DIVORCIADO")) {%>selected=""<%}%>>DIVORCIADO(A)</option>
                                                    <option value="VIUDO" <%if (objNatural.getEstadoCivil().toUpperCase().equals("VIUDO")) {%>selected=""<%}%>>VIUDO(A)</option>                               
                                                </select>
                                            </td>
                                        </tr>
                                        <tr>
                                            <th>TELÉFONO (1)</th>
                                            <td>
                                                <input type="text" name="telefono1" id="telefono1" class="limpiar" style="width: 90%;" value="<%=objPersonal.getPersona().getTelefono1()%>"/>
                                            </td>
                                            <th>TELÉFONO (2)</th>
                                            <td>
                                                <input type="text" name="telefono2" id="telefono2" class="limpiar" style="width: 90%;" value="<%=objPersonal.getPersona().getTelefono2()%>"/>
                                            </td>
                                        </tr>
                                        <tr>
                                            <th>DIRECCIÓN</th>
                                            <td colspan="3">
                                                <input type="text" name="direccion" id="direccion" style="width: 95%" class="limpiar mayuscula" value="<%=objPersonal.getPersona().getDireccion()%>"/>
                                            </td>
                                        </tr>
                                        <tr>
                                            <th>DIR/ZONA</th>
                                            <td colspan="3">
                                                <select name="codZona" id="codZona" class="limpiar" style="width: 35%;">
                                                    <option value="">SELECCIONE</option>
                                                    <%
                                                        cZona objcZona = new cZona();
                                                        List lZona = objcZona.leer();
                                                        for (int i = 0; i < lZona.size(); i++) {
                                                            Zona objZona = (Zona) lZona.get(i);
                                                    %>
                                                    <option value="<%=objZona.getCodZona()%>" <%if (objZona.getCodZona().equals(objPersonal.getPersona().getZona().getCodZona())) {%>selected=""<%}%>><%=objZona.getZona()%></option>
                                                    <%                                        }
                                                    %>
                                                </select>
                                            </td>
                                        </tr>
                                        <tr>
                                            <th>E-MAIL</th>
                                            <td colspan="3">
                                                <input id="email" name="email" type="text" placeholder="Escriba direccion de correo electrónico" style="width: 95%" class="limpiar mayuscula" value="<%=objPersonal.getPersona().getEmail()%>"/>
                                            </td>
                                        </tr>
                                        <tr>
                                            <th style="height: 60px;">OBSERVACIONES</th>
                                            <td colspan="3">
                                                <textarea id="observacionPersona" name="observacionPersona" style="width: 95%;height: 50px" class="limpiar mayuscula"><%=objPersonal.getPersona().getObservaciones()%></textarea>
                                            </td>
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
                                            <td>
                                                <select name="estado" id="estado" style="width: 90%;" class="limpiar">
                                                    <option value="">SELECCIONE</option>                                    
                                                    <option value="1" selected="">HABILITADO</option>
                                                    <option value="0">DESHABILITADO</option>
                                                </select>
                                            </td>
                                        </tr>
                                        <tr>
                                            <th style="width: 120px;">CARGO (S)</th>
                                            <td style="width: 240px;">
                                                <select name="codCargo" id="codCargo" style="width: 90%;" class="limpiar">
                                                    <option value="">SELECCIONE</option>
                                                    <%
                                                        List lCargo = new cCargo().leer_cargoOrdenado();
                                                        Iterator iCargo = lCargo.iterator();
                                                        while (iCargo.hasNext()) {
                                                            Cargo objCargo = (Cargo) iCargo.next();
                                                    %>
                                                    <option value="<%=objCargo.getCodCargo()%>" <%if (objPersonal.getCargo().getCodCargo().equals(objCargo.getCodCargo())) {%>selected=""<%}%>><%=objCargo.getCargo()%></option>
                                                    <%
                                                        }
                                                    %>
                                                </select>
                                            </td>
                                            <th style="width: 120px;">ÁREA (S)</th>
                                            <td style="width: 240px;">
                                                <select name="codArea" id="codArea" class="limpiar" style="width: 90%;">
                                                    <option value="">SELECCIONE</option>
                                                    <%
                                                        cArea objcArea = new cArea();
                                                        List lArea = objcArea.leer_areaOrdenado();
                                                        Iterator iArea = lArea.iterator();
                                                        while (iArea.hasNext()) {
                                                            Area objArea = (Area) iArea.next();
                                                    %>
                                                    <option value="<%=objArea.getCodArea()%>" <%if (objPersonal.getArea().getCodArea().equals(objArea.getCodArea())) {%>selected=""<%}%>><%=objArea.getArea()%></option>
                                                    <%
                                                        }
                                                    %>
                                                </select>
                                            </td>
                                        </tr>
                                        <tr>
                                            <th>F. INICIO ACT.</th>
                                            <td>
                                                <input type="text" name="fechaInicioActividades" id="fechaInicioActividades" class="limpiar" placeholder="dd/mm/yyyy" style="width: 90%;" value="<%=objcManejoFechas.DateAString(objPersonal.getFechaInicioActividades())%>"/>
                                            </td>
                                            <th>F. FIN ACT.</th>
                                            <td>
                                                <input type="text" name="fechaFinActividades" id="fechaFinActividades" class="limpiar" placeholder="dd/mm/yyyy" style="width: 90%;" value="<%=objcManejoFechas.DateAString(objPersonal.getFechaFinActividades())%>"/>
                                            </td>
                                        </tr>
                                        <tr>
                                            <th style="height: 60px;">OBSERVACIONES</th>
                                            <td colspan="3">
                                                <textarea id="observacionPersonal" name="observacionPersonal" style="width: 95%;height: 50px" class="limpiar mayuscula"><%=objPersonal.getObservacion()%></textarea>
                                            </td>
                                        </tr>
                                        <tr>
                                            <th colspan="4" style="text-align: center;">
                                                <button class="sexybutton" type="button" id="bCancelar"><span><span><span class="delete">Cancelar</span></span></span></button>
                                                <button class="sexybutton" type="reset" id="bRestaurar"><span><span><span class="redo">Restaurar</span></span></span></button>
                                                <button class="sexybutton" type="submit"><span><span><span class="save">Editar</span></span></span></button>
                                            </th>
                                        </tr>
                                    </tbody>
                                </table>
                            </div>
                        </div>
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