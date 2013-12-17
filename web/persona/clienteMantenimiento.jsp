<%-- 
    Document   : clienteMantenimiento
    Created on : 23/08/2013, 10:20:18 AM
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
        <title>IY Cliente mantenimiento</title>
        <!--todos-->
        <script type="text/javascript" src="../librerias/jquery/jquery-1.9.0-min.js" ></script>
        <script type="text/javascript" src="../librerias/jquery/jquery.timer-min.js" ></script>
        <script type="text/javascript" src="../librerias/jquery-ui/jquery-ui-1.10.3.custom/js/jquery-ui-1.10.3.custom.min.js" ></script>
        <link rel="stylesheet" type="text/css" href="../librerias/principal/todos.css" media="all"/>
        <!--cambios-->
        <%@include file="../principal/inclusiones.jsp" %>

        <!--propio-->
        <script type="text/javascript" src="../librerias/jquery/jquery.numeric-min.js"></script>        
        <script type="text/javascript" src="../librerias/jquery-ui/jquery-ui-1.10.3.custom/js/i18n/jquery.ui.datepicker-es-min.js"></script>
        <script type="text/javascript" src="../librerias/plugin/mask/jquery.mask.min.js"></script>
        <script type="text/javascript" src="../librerias/utilitarios/manejoFecha.js"></script>
        <script type="text/javascript" src="../librerias/persona/cliente/clienteMantenimiento.js?v13.10.30"></script>
        <style>
            .ui-autocomplete {
                width: 500px;
                max-height: 200px;
                overflow-y: auto;
                /* prevent horizontal scrollbar */
                overflow-x: hidden;
            }
            /* IE 6 doesn't support max-height
            * we use height instead, but this forces the menu to always be this tall
            */
            * html .ui-autocomplete {
                height: 200px;
            }
        </style>
    </head>
    <body>
        <input type="hidden" name="paginaActualPermiso" id="permisoPaginaP1" value="" title="MANTENIMIENTO DE CLIENTES"/>
        <div id="wrap">
            <div id="header">
                <label class="horaCabecera"><%=objcManejoFechas.fechaCabecera()%></label>
            </div>
            <div id="right">
                <div id="rightSub1" class="ocultar">
                    <h3 class="titulo">
                        <button class="sexybutton sexyicononly sexysimple sexypropio sexysmall" id="bBuscarCliente"><span class="search"></span></button>
                        CLIENTE MANTENIMIENTO
                        <a href="clienteNaturalRegistrar.jsp" class="sexybutton"><span><span><span class="add">Natural</span></span></span></a>&nbsp;
                        <a href="clienteJuridicoRegistrar.jsp" class="sexybutton"><span><span><span class="add">Jurídico</span></span></span></a>
                    </h3>
                    <%
                        int codDatoCliente = 0;
                        try {
                            codDatoCliente = (Integer) session.getAttribute("codDatoClienteMantenimiento");
                        } catch (Exception e) {
                            codDatoCliente = 0;
                        }
                    %>                    
                    <input type="hidden" name="codDatoCliente" id="codDatoCliente" value="<%=codDatoCliente%>" />
                    <div id="cliente" class="ocultar">
                        <div id="accordionNatural">
                            <h3>
                                DATOS PERSONALES/GENERALES
                            </h3>
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
                                            <th style="text-align: center;">                                                
                                                <button class="sexybutton sexyicononly sexysimple sexysmall sexypropio" id="bNuevoTabla"><span class="add"></span></button>
                                                <a class="sexybutton sexyicononly sexysimple sexysmall sexypropio" id="bEditar"><span class="edit"></span></a>
                                                <button class="sexybutton sexyicononly sexysimple sexysmall sexypropio" id="bEliminar"><span class="delete"></span></button>
                                            </th>
                                        </tr>
                                        <tr>
                                            <th style="width: 120px;">CÓD. CLIENTE</th>
                                            <td style="width: 240px;" class="lCodDatoCliente vaciar"></td>
                                            <th style="width: 120px;">CRÉDITO. MÁX</th>
                                            <td style="width: 240px;" class="lCreditoMax vaciar"></td>
                                        </tr>
                                        <tr class="clienteNatural">
                                            <th>CÓD. MODULAR</th>
                                            <td class="lCodModular vaciar"></td>
                                            <th>CARGO</th>
                                            <td class="lCargo vaciar"></td>
                                        </tr>
                                        <tr class="clienteNatural">
                                            <th>CARBEN</th>
                                            <td class="lCarben vaciar"></td>
                                        </tr>
                                        <tr class="clienteNatural">
                                            <th>DNI</th>
                                            <td class="lDni vaciar"></td>
                                            <th>RUC</th>
                                            <td class="lRuc vaciar"></td>
                                        </tr>
                                        <tr class="clienteNatural">
                                            <th>A. PATERNO</th>
                                            <td colspan="3" class="lApePaterno vaciar"></td>
                                        </tr>
                                        <tr class="clienteNatural">
                                            <th>A. MATERNO</th>
                                            <td colspan="3" class="lApeMaterno vaciar"></td>
                                        </tr>
                                        <tr class="clienteNatural">
                                            <th>NOMBRES</th>
                                            <td colspan="3"  class="vaciar lNombres"></td>
                                        </tr>
                                        <tr class="clienteNatural">
                                            <th>SEXO</th>
                                            <td class="lSexo vaciar"></td>
                                            <th>F. NACIMIENTO</th>
                                            <td class="lFechaNacimiento vaciar"></td>
                                        </tr>
                                        <tr class="clienteNatural">
                                            <th>ESTADO CIVIL</th>
                                            <td class="lEstadoCivil vaciar"></td>
                                        </tr>
                                        <tr class="clienteNatural">
                                            <th>CONYUGE</th>
                                            <td colspan="3" class="lConyuge vaciar"></td>
                                        </tr>
                                        <tr class="clienteNatural">
                                            <th>TEL. FIJO</th>
                                            <td class="lTelefono1P vaciar"></td>
                                            <th>CELULAR</th>
                                            <td class="lTelefono2P vaciar"></td>
                                        </tr>
                                        <tr class="clienteNatural">
                                            <th>COBRADOR</th>
                                            <td colspan="3" class="lCobrador vaciar"></td>
                                        </tr>
                                        <tr class="clienteNatural">
                                            <th>DIRECCIÓN</th>
                                            <td colspan="3" class="lDireccion vaciar"></td>
                                        </tr>
                                        <tr class="clienteNatural">
                                            <th>DIR/ZONA</th>
                                            <td colspan="3" class="lZona vaciar"></td>
                                        </tr>
                                        <tr class="clienteNatural">
                                            <th>CORREO</th>
                                            <td colspan="3" class="lCorreo vaciar"></td>
                                        </tr>
                                        <tr class="clienteNatural">
                                            <th style="height: 60px;">OBSERVACIONES</th>
                                            <td colspan="3" class="lObservacionPersona vaciar"></td>
                                        </tr>
                                        <!--cliente juridico-->
                                        <tr class="clienteJuridico">
                                            <th>RUC</th>
                                            <td class="lRuc vaciar"></td>
                                            <th>I. ACTIVIDADES</th>
                                            <td class="lFechaNacimiento vaciar"></td>
                                        </tr>
                                        <tr class="clienteJuridico">
                                            <th>RAZÓN SOCIAL</th>
                                            <td colspan="3" class="vaciar lNombres"></td>
                                        </tr>
                                        <tr class="clienteJuridico">
                                            <th>REPRE./PROPIET</th>
                                            <td colspan="3" class="vaciar lPersonaPropietario"></td>
                                        </tr>
                                        <tr class="clienteJuridico">
                                            <th>TEL. FIJO</th>
                                            <td class="lTelefono1P vaciar"></td>
                                            <th>CELULAR</th>
                                            <td class="lTelefono2P vaciar"></td>
                                        </tr>
                                        <tr class="clienteJuridico">
                                            <th>COBRADOR</th>
                                            <td colspan="3" class="lCobrador vaciar"></td>
                                        </tr>
                                        <tr class="clienteJuridico">
                                            <th>DIRECCIÓN</th>
                                            <td colspan="3" class="lDireccion vaciar"></td>
                                        </tr>
                                        <tr class="clienteJuridico">
                                            <th>DIR/ZONA</th>
                                            <td colspan="3" class="lZona vaciar"></td>
                                        </tr>
                                        <tr class="clienteJuridico">
                                            <th>CORREO</th>
                                            <td colspan="3" class="lCorreo vaciar"></td>
                                        </tr>
                                        <tr class="clienteJuridico">
                                            <th style="height: 60px;">OBSERVACIONES</th>
                                            <td colspan="3" class="lObservacionPersona vaciar"></td>
                                        </tr>
                                    </tbody>
                                </table>
                            </div>
                            <h3>DATOS LABORALES Y OTROS</h3>
                            <div>
                                <table class="reporte-tabla-1 clienteNatural">
                                    <tbody>
                                        <tr>
                                            <th>EMPRESA</th>
                                            <td colspan="3" class="lEmpresa vaciar"></td>
                                        </tr>
                                        <tr>
                                            <th style="width: 120px;">TIPO</th>
                                            <td style="width: 240px;" class="lTipo vaciar"></td>
                                            <th style="width: 120px;">CONDICIÓN</th>
                                            <td style="width: 240px;" class="lCondicion vaciar"></td>
                                        </tr>
                                        <tr>
                                            <th>CENT. DE TRABAJO</th>
                                            <td colspan="3" class="lCentroTrabajo vaciar"></td>
                                        </tr>
                                        <tr>
                                            <th>TELÉFONO 1</th>
                                            <td class="lTelefono1T vaciar"></td>
                                            <th>TELÉFONO 2</th>
                                            <td class="lTelefono2T vaciar"></td>
                                        </tr>
                                        <tr>
                                            <th>GARANTE</th>
                                            <td colspan="3" class="lGarante vaciar"></td>
                                        </tr>
                                        <tr>
                                            <th style="height: 60px;">OBSERVACIONES</th>
                                            <td colspan="3" class="lObservacionLaboral vaciar"></td>
                                        </tr>
                                    </tbody>
                                </table>
                            </div>
                            <h3>VENTAS (RESUMEN) - 10 ÚLTIMAS</h3>
                            <div>
                                <table class="reporte-tabla-1">
                                    <thead>
                                        <tr>
                                            <th style="width: 120px;">FECHA</th>
                                            <th style="width: 120px;">DOC N/S</th>
                                            <th style="width: 120px;">TIPO</th>
                                            <th style="width: 120px;">IMPORTE</th>
                                            <th style="width: 240px;">VENDEDOR</th>
                                        </tr>
                                    </thead>
                                    <tfoot>

                                    </tfoot>
                                    <tbody id="tbClienteVentaResumen">

                                    </tbody>
                                </table>
                            </div>
                            <h3>DOCUMENTO/NOTIFICACIONES</h3>
                            <div>
                                <table class="reporte-tabla-1 anchoTotal">
                                    <thead>
                                        <tr>
                                            <th class="ancho160px medio">TÍTULO</th>
                                            <th class="ancho80px medio">FECHA</th>
                                            <th class="medio">
                                                DESCRIPCIÓN 
                                                <button class="sexybutton sexyicononly sexysimple sexysmall sexypropio" id="bDocumentoNotificacion" type="button"><span class="add"></span></button>
                                                <input type="text" name="codDocumentoNotificacionAux" id="codDocumentoNotificacionAux" value="" class="ocultar"/>
                                            </th>
                                            <th class="ancho120px medio">OBSERVACIÓN</th>
                                            <th class="ancho80px centrado">OPCIÓN</th>
                                        </tr>
                                    </thead>
                                    <tbody id="tbClienteDocumentoNotificacion" class="vacir">
                                        <tr>
                                            <td class="centrado"><img alt="not found" src="../imagenes/loading.gif" style="height: 11px;"></td>
                                            <td class="centrado"><img alt="not found" src="../imagenes/loading.gif" style="height: 11px;"></td>
                                            <td class="centrado"><img alt="not found" src="../imagenes/loading.gif" style="height: 11px;"></td>
                                            <td class="centrado"><img alt="not found" src="../imagenes/loading.gif" style="height: 11px;"></td>
                                            <td class="centrado"><img alt="not found" src="../imagenes/loading.gif" style="height: 11px;"></td>
                                        </tr>
                                    </tbody>
                                </table>
                            </div>
                        </div>
                    </div>
                </div>
                <%@include file="../principal/div2.jsp" %>
                <!--*******Dialog******************************************************************************-->
                <div id="dClienteBuscar" title="BUSCAR CLIENTE" style="padding: 20px;">
                    <table class="reporte-tabla-1" style="width: 100%;">
                        <thead>
                            <tr>
                                <th style=""><label>APELLIDOS-NOMBRES/RAZÓN SOCIAL</label></th>
                                <th style="width: 170px;"><label>DNI-PASAPORTE/RUC</label></th>
                                <th style="width: 100px;"><label>COD. CLIENTE</label></th>
                            </tr>
                        </thead>
                        <tbody>
                            <tr>
                                <td>
                                    <input type="text" name="nombresCBuscar" value="" id="nombresCBuscar" style="width: 99%;"/>
                                </td>
                                <td>
                                    <input type="text" name="dniPasaporteRucBuscar" id="dniPasaporteRucBuscar" value="" style="width: 98%;"/>
                                </td>
                                <td>
                                    <input type="text" name="codDatoClienteBuscar" id="codDatoClienteBuscar" value="" />
                                </td>
                            </tr>
                        </tbody>
                    </table>
                </div>
                <div id="dDocumentoNotificacion" title="Documento/Notificación" style="padding: 20px;">
                    <form action="../sDocumentoNotificacion" id="formDocumentoNotificacion">
                        <!--<input type="text" name="accionDocumentoNotificacion" id="accionDocumentoNotificacion" value="registrar" />-->
                        <table class="reporte-tabla-1 anchoTotal">
                            <tbody>
                                <tr>
                                    <th class="ancho120px"><label for="varchar1">TÍTULO</label></th>
                                    <td class="contenedorEntrada"><input type="text" name="varchar1" id="varchar1" value="" class="anchoTotal limpiar entrada mayuscula" /></td>
                                    <th class="ancho120px"><label for="fech1">FECHA</label></th>
                                    <td class="contenedorEntrada"><input type="text" name="fech1" id="fech1" value="" class="anchoTotal limpiar entrada mayuscula" /></td>
                                </tr>
                                <tr>
                                    <th><label for="text1">DESCRIPCIÓN</label></th>
                                    <td colspan="3" class="contenedorEntrada alto160px"><textarea name="text1" id="text1" class="anchoTotal altoTotal limpiar entrada"></textarea></td>
                                </tr>
                                <tr>
                                    <th><label for="text2">OBSERVACIÓN</label></th>
                                    <td colspan="3" class="contenedorEntrada alto160px"><textarea name="text2" id="text2" class="anchoTotal altoTotal limpiar entrada"></textarea></td>
                                </tr>
                            </tbody>
                        </table>
                    </form>
                </div>
                <div id="dDocumentoNotificacionBorrarConfirmar" title="¿Confirma eliminar este documento?">

                </div>
                <!--*******Dialog******************************************************************************-->
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
