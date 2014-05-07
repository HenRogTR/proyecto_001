<%-- 
    Document   : proveedorListar
    Created on : 09/11/2012, 12:30:02 PM
    Author     : Henrri
--%>

<%@page import="personaClases.cProveedor"%>
<%@page import="tablas.Proveedor"%>
<%@page import="java.util.Iterator"%>
<%@page import="java.util.List"%>
<%@page import="tablas.Usuario"%>
<%
    Usuario objUsuario = (Usuario) session.getAttribute("usuario");
    if (objUsuario == null) {
        session.removeAttribute("direccion");
        session.setAttribute("direccion", "persona/areaFrm.jsp");
        response.sendRedirect("../");
    } else {
%>
<%@page contentType="text/html" pageEncoding="UTF-8"%>

<!DOCTYPE html>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <title>Listar Proveedores</title>
        <!--stilo inicio-->
        <link rel="stylesheet" type="text/css" href="../lib/propios/css/inicio/style.css" />
        <!--js query-->
        <script type="text/javascript" src="../lib/jquery/jquery-1.8.1.min.js"></script>
        <!--css js ui-->
        <link rel="stylesheet" type="text/css" href="../lib/jquery-ui/jquery-ui-1.10.0.custom/css/smoothness/jquery-ui-1.10.0.custom.min.css">
        <script type="text/javascript" src="../lib/jquery-ui/jquery-ui-1.9.0/jquery-ui-git.js"></script>
        <!--css frm-->
        <link rel="stylesheet" type="text/css" href="../lib/propios/css/tablas/tablas-reportes.css">
        <!--css js modal-->
        <!--css iconos-->
        <link rel="stylesheet" type="text/css" href="../librerias/botonesIconos/sexybuttons.css" media="screen">
        <!--css y js de pagina-->
        <script type="text/javascript" src="../lib/persona/proveedor/proveedorListar.js?v13.08.12"></script>
        <script type="text/javascript" src="../lib/jquerynumeric/jquery.numeric.js"></script>
        <style>
            .ui-autocomplete {
                width: 400px;
                max-height: 300px;
                overflow-y: auto;
                /* prevent horizontal scrollbar */
                overflow-x: hidden;
            }
            /* IE 6 doesn't support max-height
     * we use height instead, but this forces the menu to always be this tall
            */
            * html .ui-autocomplete {
                height: 300px;
            }
        </style>
    </head>
    <body>
        <div id="wrap">
            <div id="header">
                <%@include file="../cabecera.jsp" %>
            </div>
            <div id="left"> 
                <%@include file="../menu2.jsp" %>
            </div>
            <div id="right">
                <%
                    int codProveedor = 0;
                    try {
                        codProveedor = (Integer) session.getAttribute("codProveedorListar");
                    } catch (Exception e) {
                        codProveedor = 0;
                    }
                %>
                <h3 class="titulo">MANTENIMIENTO DE PROVEEDORES <a class="sexybutton personal" href="proveedorRegistrar.jsp" title="Nuevo"><span><span><span class="add">Nuevo</span></span></span></a></h3>
                <div style="margin-top: 10px;">
                    Buscar:&nbsp;<input type="number" name="codProveedorBuscar" id="codProveedorBuscar" value="<%=codProveedor == 0 ? "" : codProveedor%>" placeholder="Código" style="width: 100px; text-align: right;"/>
                    <input type="hidden" name="codProveedorAux" id="codProveedorAux" value="<%=codProveedor%>" />
                    <input type="text" name="rucRazonSocialBuscar" id="rucRazonSocialBuscar" value="" placeholder="Ruc/Razón Social" style="width: 450px;"/><br>
                </div>
                <table class="reporte-tabla-1" style="margin-top: 10px;">
                    <thead>
                        <tr>
                            <th colspan="4" style="text-align: right;">
                                <label style="font-size: 14px; float: left; font-weight: bold;">DETALLE DE PROVEEDOR</label>
                                <button class="sexybutton" id="bPrimero"><span><span><span class="first">Primero</span></span></span></button>
                                <button class="sexybutton" id="bAnterior"><span><span><span class="prev">Anterior</span></span></span></button>
                                <button class="sexybutton" id="bSiguiente"><span><span><span class="next">Siguiente</span></span></span></button>
                                <button class="sexybutton" id="bUltimo"><span><span><span class="last">Último</span></span></span></button>
                            </th>
                        </tr>
                    </thead>
                    <tfoot>
                        <tr id="trBotones">
                            <th colspan="4" style="text-align: center;">
                                <a class="sexybutton" href="proveedorRegistrar.jsp" title="Nuevo"><span><span><span class="add">Nuevo</span></span></span></a>
                                <button class="sexybutton" id="editar" ><span><span><span class="edit">Editar</span></span></span></button>
                                <button class="sexybutton" id="eliminar"><span><span><span class="delete">Eliminar</span></span></span></button>
                            </th>
                        </tr>
                    </tfoot>
                    <tbody>
                        <tr>
                            <th style="width: 120px;">Código</th>
                            <td style="width: 160px;">
                                <input type="hidden" name="codProveedor" id="codProveedor" value="" />
                                <label id="lCodProveedor" class="limpiar"></label>
                            </td>
                            <th style="width: 120px;">Ruc</th>
                            <td style="width: 160px;">
                                <label id="lRuc" class="limpiar"></label>
                            </td>
                        </tr>
                        <tr>
                            <th>Razón Social</th>
                            <td colspan="3"><label  id="lRazonSocial" class="limpiar"></label></td>
                        </tr>
                        <tr>
                            <th>Gerente</th>
                            <td colspan="3"><label  id="lPropietario" class="limpiar"></label></td>
                        </tr>
                        <tr>
                            <th>Direccion</th>
                            <td colspan="3"><label id="lDireccion" class="limpiar"></label></td>
                        </tr>
                        <tr>
                            <th>Telefono1</th>
                            <td><label  id="lTelefono1" class="limpiar"></label></td>
                            <th>Telefono2</th>
                            <td><label  id="lTelefono2" class="limpiar"></label></td>
                        </tr>
                        <tr>
                            <th>E-mail</th>
                            <td colspan="3"><label id="lEmail" class="limpiar"></label></td>
                        </tr>
                        <tr>
                            <th>Página web</th>
                            <td colspan="3"><label class="limpiar" id="lPaginaWeb"></label></td>
                        </tr>
                        <tr>
                            <th>Observaciones</th>
                            <td colspan="3"><label class="limpiar" id="lObservaciones"></label></td>
                        </tr>
                    </tbody>
                </table>
                <div id="dProveedorEliminarConfirmar" title="Eliminar proveedor">
                    ¿Está seguro de eliminar al proveedor?
                </div>
            </div>
            <div style="clear: both;"> </div>
            <div id="footer">
                <%@include file="../piePagina.jsp" %>
            </div>
        </div>
    </body>
</html>
<%            }
%>