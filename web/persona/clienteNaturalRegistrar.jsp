<%-- 
    Document   : personalFrm
    Created on : 09/01/2013, 12:25:20 PM
    Author     : Henrri
--%>

<%@page import="tablas.EmpresaConvenio"%>
<%@page import="personaClases.cEmpresaConvenio"%>
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
%>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <title>IY Cliente natural registrar</title>
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
        <script type="text/javascript" src="../librerias/persona/cliente/clienteNaturalRegistrar.js?v.14.04.08"></script>
    </head>
    <body>        
        <input type="hidden" name="paginaActualPermiso" id="permisoPaginaP29" value="" title="REGISTRO DE CLIENTES"/>
        <div id="wrap">
            <div id="header">
                <label class="horaCabecera"><%=objcManejoFechas.fechaCabecera()%></label>
            </div>
            <div id="right">
                <div id="rightSub1" class="ocultar">                    
                    <h3 class="titulo">REGISTRAR CLIENTE</h3>
                    <form id="formClienteNaturalRegistrar" action="../sClienteNatural" method="get">
                        <input type="hidden" name="accionDatoCliente" id="accionDatoCliente" value="registrar"/>
                        <input type="hidden" name="codPersona" id="codPersona" class="limpiar"/>
                        <input type="hidden" name="codNatural" id="codNatural" class="limpiar"/>
                        <input type="hidden" name="marcador" id="marcador" class="vaciar"/>
                        <div id="accordion">
                            <h3>CLIENTE NATURAL</h3>
                            <div>
                                <table class="reporte-tabla-1">
                                    <tfoot>
                                        <tr>
                                            <th colspan="4" class="centrado">
                                                <button class="sexybutton" type="button" id="bCancelar"><span><span><span class="delete">Cancelar</span></span></span></button>
                                                <button class="sexybutton" type="button" id="bRestaurar"><span><span><span class="redo">Restaurar</span></span></span></button>
                                                <button class="sexybutton" type="submit"><span><span><span class="save">Registrar</span></span></span></button>
                                            </th>
                                        </tr>
                                    </tfoot>
                                    <tbody>
                                        <tr>
                                            <th colspan="4" class="centrado"><span style="font-size: 13px; font-weight: bold;">DATOS PERSONALES</span></th>
                                        </tr>
                                        <tr>
                                            <th class="ancho120px">CÓDIGO</th>
                                            <td class="ancho240px">AUTOGENERADO</td>
                                            <th class="ancho120px">CRÉDITO. MÁX</th>
                                            <td class="ancho240px contenedorEntrada"><input type="text" name="saldoMax" id="saldoMax" placeholder="Ingrese S.M. aprobado" class="limpiar mayuscula entrada anchoTotal" value="5000.00"/></td>
                                        </tr>
                                        <tr>
                                            <th>CÓD. MODULAR</th>
                                            <td class="contenedorEntrada"><input type="text" name="codModular" id="codModular" placeholder="Sólo docentes" class="limpiar mayuscula entrada anchoTotal"/></td>
                                            <th>CARGO</th>
                                            <td class="contenedorEntrada"><input type="text" name="cargo" id="cargo" placeholder="Sólo docentes" class="limpiar mayuscula entrada anchoTotal"/></td>
                                        </tr>
                                        <tr>
                                            <th>CARBEN</th>
                                            <td class="contenedorEntrada"><input id="carben" name="carben" id="carben" type="text" placeholder="Sólo docentes" class="limpiar mayuscula entrada anchoTotal"/></td>
                                        </tr>
                                        <tr>
                                            <th>DNI</th>
                                            <td class="contenedorEntrada"><input type="text" id="dniPasaporte" name="dniPasaporte" class="limpiar entrada anchoTotal"/></td>
                                            <th>RUC</th>
                                            <td class="contenedorEntrada"><input type="text" id="ruc" name="ruc" class="limpiar entrada anchoTotal"/></td>
                                        </tr>
                                        <tr>
                                            <th>A. PATERNO</th>
                                            <td colspan="3" class="contenedorEntrada"><input type="text" id="apePaterno" name="apePaterno" class="limpiar mayuscula entrada anchoTotal"/></td>
                                        </tr>
                                        <tr>
                                            <th>A. MATERNO</th>
                                            <td colspan="3" class="contenedorEntrada"><input type="text" id="apeMaterno" name="apeMaterno" class="limpiar mayuscula entrada anchoTotal"/></td>
                                        </tr>
                                        <tr>
                                            <th>NOMBRES</th>
                                            <td colspan="3" class="contenedorEntrada"><input type="text" id="nombres" name="nombres" class="limpiar mayuscula entrada anchoTotal"/></td>
                                        </tr>
                                        <tr>
                                            <th>SEXO</th>
                                            <td class="contenedorEntrada">
                                                <select name="sexo" id="sexo" class="limpiar entrada anchoTotal">
                                                    <option value="">SELECCIONE</option>
                                                    <option value="0">MASCULINO</option>
                                                    <option value="1">FEMENINO</option>
                                                </select>
                                            </td>
                                            <th>F. NACIMIENTO</th>
                                            <td class="contenedorEntrada"><input type="text" name="fechaNacimiento" id="fechaNacimiento" class="limpiar entrada anchoTotal" placeholder="dd/mm/yyyy"/></td>
                                        </tr>
                                        <tr>
                                            <th>ESTADO CIVIL</th>
                                            <td class="contenedorEntrada">
                                                <select id="estadoCivil" name="estadoCivil" class="limpiar entrada anchoTotal">
                                                    <option value="">SELECCIONE</option>
                                                    <option value="SOLTERO">SOLTERO(A)</option>
                                                    <option value="CASADO">CASADO(A)</option>
                                                    <option value="DIVORCIADO">DIVORCIADO(A)</option>
                                                    <option value="VIUDO">VIUDO(A)</option>
                                                </select>
                                            </td>
                                        </tr>
                                        <tr>
                                            <th>CONYUGE <button class="sexybutton sexyicononly sexysimple sexysmall sexypropio" id="bConyugeBuscar" type="button"><span class="search"></span></button></th>
                                            <td colspan="3">
                                                <input type="hidden" name="codConyuge" id="codConyuge" value="0" />
                                                <label id="lConyuge"></label>
                                            </td>
                                        </tr>
                                        <tr>
                                            <th>TELÉFONO (1)</th>
                                            <td class="contenedorEntrada"><input type="text" name="telefono1P" id="telefono1P" class="limpiar entrada anchoTotal"/></td>
                                            <th>TELÉFONO (2)</th>
                                            <td class="contenedorEntrada"><input type="text" name="telefono2P" id="telefono2P" class="limpiar entrada anchoTotal"/></td>
                                        </tr>
                                        <tr>
                                            <th>DIRECCIÓN</th>
                                            <td colspan="3" class="contenedorEntrada"><input type="text" name="direccion" id="direccion" class="limpiar mayuscula entrada anchoTotal"/></td>
                                        </tr>
                                        <tr>
                                            <th>DIR/ZONA</th>
                                            <td class="contenedorEntrada">
                                                <select name="codZona" id="codZona" class="limpiar entrada anchoTotal">
                                                    <option value="">SELECCIONE</option>
                                                    <%
                                                        cZona objcZona = new cZona();
                                                        List lZona = objcZona.leer();
                                                        for (int i = 0; i < lZona.size(); i++) {
                                                            Zona objZona = (Zona) lZona.get(i);
                                                    %>
                                                    <option value="<%=objZona.getCodZona()%>"><%=objZona.getZona()%></option>
                                                    <%                                    }
                                                    %>
                                                </select>
                                            </td>
                                        </tr>
                                        <tr>
                                            <th>E-MAIL</th>
                                            <td colspan="3" class="contenedorEntrada">
                                                <input id="email" name="email" type="text" placeholder="Escriba direccion de correo electrónico" class="limpiar mayuscula entrada anchoTotal"/>
                                            </td>
                                        </tr>
                                        <tr>
                                            <th>PAGINA WEB</th>
                                            <td colspan="3" class="contenedorEntrada">
                                                <input id="paginaWeb" name="paginaWeb" type="text" placeholder="Escriba página web" class="limpiar mayuscula entrada anchoTotal"/>
                                            </td>
                                        </tr>
                                        <tr>
                                            <th style="height: 60px;">OBSERVACIONES DE CLIENTE</th>
                                            <td colspan="3" class="contenedorEntrada">
                                                <textarea id="observacionPersona" name="observacionPersona" class="limpiar mayuscula entrada anchoTotal alto60px"></textarea>
                                            </td>
                                        </tr>
                                        <tr>
                                            <th colspan="4" class="centrado"><span style="font-size: 13px; font-weight: bold;">DATOS LABORALES Y OTROS</span></th>
                                        </tr>
                                        <tr>
                                            <th>EMPRESA</th>
                                            <td class="contenedorEntrada">
                                                <select id="codEmpresaConvenio" name="codEmpresaConvenio" class="limpiar entrada anchoTotal">
                                                    <option value="">SELECCIONE</option>
                                                    <%
                                                        cEmpresaConvenio objcEmpresaConvenio = new cEmpresaConvenio();
                                                        List lEmpresaConvenio = objcEmpresaConvenio.leer();
                                                        for (int i = 0; i < lEmpresaConvenio.size(); i++) {
                                                            EmpresaConvenio objEmpresaConvenio = (EmpresaConvenio) lEmpresaConvenio.get(i);
                                                    %>
                                                    <option value="<%=objEmpresaConvenio.getCodEmpresaConvenio()%>"><%=objEmpresaConvenio.getNombre()%></option>
                                                    <%
                                                        }
                                                    %>
                                                </select>
                                            </td>
                                        </tr>
                                        <tr>
                                            <th>TIPO</th>
                                            <td class="contenedorEntrada">
                                                <select name="tipo" id="tipo" class="limpiar entrada anchoTotal">
                                                    <option value="">SELECCIONE</option>
                                                    <option value="1">Activo</option>
                                                    <option value="2">4 Sueldos</option>
                                                    <option value="3">Cesante</option>
                                                    <option value="4">Particular</option>
                                                </select>
                                            </td>
                                            <th>CONDICIÓN</th>
                                            <td class="contenedorEntrada">
                                                <select name="condicion" id="condicion" class="limpiar entrada anchoTotal">
                                                    <option value="">SELECCIONE</option>                                    
                                                    <option value="1">Contratado</option>
                                                    <option value="2">Nombrado</option>
                                                    <option value="3">Otros</option>
                                                </select>
                                            </td>
                                        </tr>
                                        <tr>
                                            <th>CENT. DE TRABAJO</th>
                                            <td colspan="3" class="contenedorEntrada"><input type="text" name="centroTrabajo" value="" id="centroTrabajo" placeholder="Dato opcional" class="limpiar entrada anchoTotal"/></td>
                                        </tr>
                                        <tr>
                                            <th>TELÉFONO 1</th>
                                            <td class="contenedorEntrada"><input type="text" name="telefono1C" id="telefono1C" placeholder="061-578964" class="limpiar entrada anchoTotal"/></td>
                                            <th>TELÉFONO 2</th>
                                            <td class="contenedorEntrada"><input type="text" name="telefono1C" id="telefono1C" placeholder="061-578964" class="limpiar entrada anchoTotal"/></td>
                                        </tr>
                                        <tr>
                                            <th>GARANTE <button class="sexybutton sexyicononly sexysimple sexysmall sexypropio" id="bConyugeBuscar" type="button"><span class="search"></span></button></th>
                                            <td colspan="3">
                                                <input type="hidden" name="codGarante" id="codGarante" value="0" />
                                                <label id="lGarante" class="vaciar"></label>
                                            </td>
                                        </tr>
                                        <tr>
                                            <th>OBS. LABORAL</th>
                                            <td colspan="3" class="contenedorEntrada">
                                                <textarea id="observacionDatoCliente" name="observacionDatoCliente" class="limpiar mayuscula entrada anchoTotal alto60px"></textarea>
                                            </td>
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
                <!--inicio dialogos******************************************-->
                <div id="dClienteRegistrarExito" title="Registro exitoso" style="text-align: justify;">
                    Se ha registrado correctamente el personal.<br>
                    Seleccione la opcíon a realizar.
                </div>                
                <!--fin dialogos******************************************-->
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