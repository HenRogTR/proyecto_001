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
        <script type="text/javascript" src="../librerias/persona/cliente/clienteNaturalRegistrar.js"></script>
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
                            <h3>DATOS PERSONALES</h3>
                            <div>
                                <table class="reporte-tabla-1">                                    
                                    <tbody>
                                        <tr>
                                            <th style="width: 120px;">CÓDIGO</th>
                                            <td style="width: 240px;">AUTOGENERADO</td>
                                            <th style="width: 120px;">CRÉDITO. MÁX</th>
                                            <td style="width: 240px;"><input type="text" name="saldoMax" id="saldoMax" placeholder="Ingrese S.M. aprobado" class="limpiar mayuscula" value="5000.00"/></td>
                                        </tr>
                                        <tr>
                                            <th>CÓD. MODULAR</th>
                                            <td><input type="text" name="codModular" id="codModular" placeholder="Sólo docentes" class="limpiar mayuscula"/></td>
                                            <th>CARGO</th>
                                            <td><input type="text" name="cargo" id="cargo" placeholder="Sólo docentes" class="limpiar mayuscula"/></td>
                                        </tr>
                                        <tr>
                                            <th>CARBEN</th>
                                            <td><input id="carben" name="carben" id="carben" type="text" placeholder="Sólo docentes" class="limpiar mayuscula"/></td>
                                        </tr>
                                        <tr>
                                            <th>DNI</th>
                                            <td><input type="text" id="dniPasaporte" name="dniPasaporte" class="limpiar" style="width:95%;"/></td>
                                            <th>RUC</th>
                                            <td>
                                                <input type="text" id="ruc" name="ruc" class="limpiar" style="width: 95%;"/>
                                            </td>
                                        </tr>
                                        <tr>
                                            <th>A. PATERNO</th>
                                            <td colspan="3">
                                                <input type="text" id="apePaterno" name="apePaterno" style="width: 95%;" class="limpiar mayuscula"/>
                                            </td>
                                        </tr>
                                        <tr>
                                            <th>A. MATERNO</th>
                                            <td colspan="3">
                                                <input type="text" id="apeMaterno" name="apeMaterno" style="width: 95%;" class="limpiar mayuscula"/>
                                            </td>
                                        </tr>
                                        <tr>
                                            <th>NOMBRES</th>
                                            <td colspan="3">
                                                <input type="text" id="nombres" name="nombres" style="width: 95%;"  class="limpiar mayuscula"/>
                                            </td>
                                        </tr>
                                        <tr>
                                            <th>SEXO</th>
                                            <td>
                                                <select name="sexo" id="sexo" class="limpiar" style="width: 90%;">
                                                    <option value="">SELECCIONE</option>
                                                    <option value="0">MASCULINO</option>
                                                    <option value="1">FEMENINO</option>
                                                </select>
                                            </td>
                                            <th>F. NACIMIENTO</th>
                                            <td>
                                                <input type="text" name="fechaNacimiento" id="fechaNacimiento" class="limpiar" placeholder="dd/mm/yyyy" style="width: 90%;"/>
                                            </td>
                                        </tr>
                                        <tr>
                                            <th>ESTADO CIVIL</th>
                                            <td>
                                                <select id="estadoCivil" name="estadoCivil" class="limpiar" style="width: 90%;">
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
                                            <td>
                                                <input type="text" name="telefono1P" id="telefono1P" class="limpiar" style="width: 90%;"/>
                                            </td>
                                            <th>TELÉFONO (2)</th>
                                            <td>
                                                <input type="text" name="telefono2P" id="telefono2P" class="limpiar" style="width: 90%;"/>
                                            </td>
                                        </tr>
                                        <tr>
                                            <th>COBRADOR <button class="sexybutton sexyicononly sexysimple sexysmall sexypropio" id="bCobradorBuscar" type="button"><span class="search"></span></button></th>
                                            <td colspan="3">
                                                <input type="hidden" name="codCobrador" id="codCobrador" value="0" />
                                                <label id="lCobrador" class="vaciar"></label>
                                            </td>
                                        </tr>
                                        <tr>
                                            <th>DIRECCIÓN</th>
                                            <td colspan="3">
                                                <input type="text" name="direccion" id="direccion" style="width: 95%" class="limpiar mayuscula"/>
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
                                                    <option value="<%=objZona.getCodZona()%>"><%=objZona.getZona()%></option>
                                                    <%                                    }
                                                    %>
                                                </select>
                                            </td>
                                        </tr>
                                        <tr>
                                            <th>E-MAIL</th>
                                            <td colspan="3">
                                                <input id="email" name="email" type="text" placeholder="Escriba direccion de correo electrónico" style="width: 95%" class="limpiar mayuscula"/>
                                            </td>
                                        </tr>
                                        <tr>
                                            <th>PAGINA WEB</th>
                                            <td colspan="3">
                                                <input id="paginaWeb" name="paginaWeb" type="text" placeholder="Escriba página web" style="width: 95%" class="limpiar mayuscula"/>
                                            </td>
                                        </tr>
                                        <tr>
                                            <th style="height: 60px;">OBSERVACIONES</th>
                                            <td colspan="3">
                                                <textarea id="observacionPersona" name="observacionPersona" style="width: 95%;height: 50px" class="limpiar mayuscula"></textarea>
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
                                            <th style="width: 120px;">EMPRESA</th>
                                            <td colspan="3" style="width: 240px;">
                                                <select id="codEmpresaConvenio" name="codEmpresaConvenio" style="width: 230px" class="limpiar">
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
                                            <th style="width: 120px;">TIPO</th>
                                            <td style="width: 240px;">
                                                <select name="tipo" id="tipo" class="limpiar">
                                                    <option value="">SELECCIONE</option>
                                                    <option value="1">Activo</option>
                                                    <option value="2">4 Sueldos</option>
                                                    <option value="3">Cesante</option>
                                                    <option value="4">Particular</option>
                                                </select>
                                            </td>
                                            <th style="width: 120px;">CONDICIÓN</th>
                                            <td style="width: 240px;">
                                                <select name="condicion" id="condicion" class="limpiar">
                                                    <option value="">SELECCIONE</option>                                    
                                                    <option value="1">Contratado</option>
                                                    <option value="2">Nombrado</option>
                                                    <option value="3">Otros</option>
                                                </select>
                                            </td>
                                        </tr>
                                        <tr>
                                            <th>CENT. DE TRABAJO</th>
                                            <td colspan="3"><input type="text" name="centroTrabajo" value="" id="centroTrabajo" placeholder="Dato opcional" style="width: 97%" class="limpiar"/></td>
                                        </tr>
                                        <tr>
                                            <th>TELÉFONO 1</th>
                                            <td><input type="text" name="telefono1C" id="telefono1C" placeholder="061-578964" class="limpiar"/></td>
                                            <th>TELÉFONO 2</th>
                                            <td><input type="text" name="telefono1C" id="telefono1C" placeholder="061-578964" class="limpiar"/></td>
                                        </tr>
                                        <tr>
                                            <th>GARANTE <button class="sexybutton sexyicononly sexysimple sexysmall sexypropio" id="bConyugeBuscar" type="button"><span class="search"></span></button></th>
                                            <td colspan="3">
                                                <input type="hidden" name="codGarante" id="codGarante" value="0" />
                                                <label id="lGarante" class="vaciar"></label>
                                            </td>
                                        </tr>
                                        <tr>
                                            <th style="height: 60px;">OBS. LABORAL</th>
                                            <td colspan="3">
                                                <textarea id="observacionDatoCliente" name="observacionDatoCliente" style="width: 95%;height: 50px" class="limpiar mayuscula"></textarea>
                                            </td>
                                        </tr>
                                        <tr>
                                            <th colspan="4" style="text-align: center;">
                                                <button class="sexybutton" type="button" id="bCancelar"><span><span><span class="delete">Cancelar</span></span></span></button>
                                                <button class="sexybutton" type="button" id="bRestaurar"><span><span><span class="redo">Restaurar</span></span></span></button>
                                                <button class="sexybutton" type="submit"><span><span><span class="save">Registrar</span></span></span></button>
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
                <!--inicio dialogos******************************************-->
                <div id="dClienteRegistrarExito" title="Registro exitoso" style="text-align: justify;">
                    Se ha registrado correctamente el personal.<br>
                    Seleccione la opcíon a realizar.
                </div>
                <!--div editar cobrador-->
                <div id="dCobradorBuscar" title="Cobrador asigando">
                    <table class="reporte-tabla-1" style="width: 100%;">
                        <tr>
                            <th style="width: 120px;"><label>COBRADOR ACTUAL</label></th>
                            <td><label id="lCobradorAsigando"></label></td>
                        </tr>
                        <tr>
                            <th><label>NUEVO COBRADOR</label></th>
                            <td>
                                <input type="text" name="cobradorBuscar" id="cobradorBuscar" value="" style="width: 98%;" />
                                <input type="hidden" name="codCobradorAux" id="codCobradorAux" value=""/>
                            </td>
                        </tr>
                    </table>
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