<%-- 
    Document   : proveedorEditar
    Created on : 17/08/2013, 10:52:22 AM
    Author     : Henrri
--%>

<%@page import="personaClases.cProveedor"%>
<%@page import="tablas.Proveedor"%>
<%@page import="tablas.Usuario"%>
<%
    Usuario objUsuario = (Usuario) session.getAttribute("usuario");
    if (objUsuario == null) {
        session.removeAttribute("direccion");
        session.setAttribute("direccion", "persona/proveedorListar");
        response.sendRedirect("../");
    } else {
        int codProveedor = 0;

        Proveedor objProveedor = new Proveedor();
        cProveedor objcProveedor = new cProveedor();
        cUtilitarios objcUtilitarios = new cUtilitarios();
        try {
            codProveedor = (Integer) session.getAttribute("codProveedorEditar");
            objProveedor = objcProveedor.leer_cod(codProveedor);
            if (objProveedor == null || !objProveedor.getRegistro().substring(0, 1).equals("1")) {
                response.sendRedirect("proveedorListar.jsp");
            }
        } catch (Exception e) {
            codProveedor = 0;
            response.sendRedirect("proveedorListar.jsp");
            return;
        }
%>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <title>Proveedor editar</title>
        <!--stilo inicio-->
        <link rel="stylesheet" type="text/css" href="../lib/propios/css/inicio/style.css" media="screen"/>
        <!--js query-->
        <script type="text/javascript" src="../lib/jquery/jquery-1.8.1.min.js"></script>
        <!--css js ui-->
        <link rel="stylesheet" type="text/css" href="../lib/jquery-ui/jquery-ui-1.10.0.custom/css/smoothness/jquery-ui-1.10.0.custom.min.css" media="screen">
        <script type="text/javascript" src="../lib/jquery-ui/jquery-ui-1.9.0/jquery-ui-git.js"></script>
        <!--css frm-->
        <link rel="stylesheet" type="text/css" href="../lib/propios/css/tablas/tablas-reportes.css" media="screen"/>
        <!--css iconos-->
        <link rel="stylesheet" type="text/css" href="../lib/botones/sexybuttons.css" media="screen">
        <!--propio-->
        <script type="text/javascript" src="../lib/jquerynumeric/jquery.numeric.js"></script>
        <script type="text/javascript" src="../lib/persona/proveedor/proveedorEditar.js"></script>
        <script type="text/javascript" src="../lib/jquery-validation/jquery-validation-1.10.0/js/jquery.validate.min.js"></script>
        <script type="text/javascript" src="../lib/jquery-validation/localization/messages_es.js" ></script>
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
                <h3 class="titulo">PROVEEDORES DE ARTÍCULOS</h3>
                <form action="../sProveedor" id="formProveedor">
                    <table class="reporte-tabla-1" style="margin-top: 10px;">
                        <thead>
                            <tr>
                                <th colspan="4">EDITAR PROVEEDOR</th>
                            </tr>
                        </thead>
                        <tfoot>
                            <tr id="trBotones">
                                <th colspan="4" style="text-align: center;">
                                    <button class="sexybutton" type="button" id="cancelar"><span><span><span class="cancel">Cancelar</span></span></span></button>&nbsp;&nbsp;
                                    <button class="sexybutton" type="reset" id="restaurar"><span><span><span class="redo">Restaurar</span></span></span></button>&nbsp;&nbsp;
                                    <button class="sexybutton" type="submit" id="registrar"><span><span><span class="save">Registrar</span></span></span></button>
                                </th>
                            </tr>
                        </tfoot>
                        <tbody>
                            <tr>
                                <th style="width: 120px;"><label>Código</label></th>
                                <td style="width: 200px;"><input type="text" name="codProveedor" id="codProveedor" value="<%=objcUtilitarios.agregarCeros_int(objProveedor.getCodProveedor(), 8)%>" class="tamanio lectura" readonly=""/></td>
                                <th style="width: 80px;"><label>Ruc*</label></th>
                                <td style="width: 200px;"><input type="text" name="ruc" id="ruc" class="tamanio" placeholder="20123456782" value="<%=objProveedor.getRuc()%>"/></td>
                            </tr>
                            <tr>
                                <th><label>Razón Social *</label></th>
                                <td colspan="3"><input type="text" name="razonSocial" id="razonSocial"  placeholder="NombreEmpresa S.A." style="width: 96%" value="<%=objProveedor.getRazonSocial()%>"/></td>
                            </tr>
                            <tr>
                                <th><label>Gerente/Propietario </label></th>
                                <td colspan="3">
                                    <input type="hidden" name="codPersona" id="codPersona"/>
                                    <input type="text" name="nombresApellidos" id="nombresApellidos"  placeholder="Nombre Apellidos" style="width: 96%" />
                                </td>
                            </tr>
                            <tr>
                                <th><label>Dirección *</label></th>
                                <td colspan="3"><input type="text" name="direccion" id="direccion"  placeholder="Av. Jr. Psje." style="width: 96%" value="<%=objProveedor.getDireccion()%>"/></td>
                            </tr>
                            <tr>
                                <th><label>Teléfono 1</label></th>
                                <td><input type="text" name="telefono1" id="telefono1" class="tamanio" placeholder="01-7895665" value="<%=objProveedor.getTelefono()%>"/></td>
                                <th><label>Teléfono 2</label></th>
                                <td><input type="text" name="telefono2" id="telefono2" class="tamanio" placeholder="999999999"/></td>
                            </tr>
                            <tr>
                                <th><label>Email</label></th>
                                <td colspan="3"><input type="text" name="email" id="email"  placeholder="correo@example.com" style="width: 96%" value="<%=objProveedor.getEmail()%>"/></td>
                            </tr>
                            <tr>
                                <th><label>Página Web</label></th>
                                <td colspan="3"><input type="text" name="paginaWeb" id="paginaWeb"  placeholder="http://paginaWeb.com" style="width: 96%" value="<%=objProveedor.getPaginaWeb()%>"/></td>
                            </tr>
                            <tr>
                                <th><label>Observaciones</label></th>
                                <td colspan="3"><textarea name="observaciones" id="observaciones" style="width: 96%;height: 60px" placeholder=""><%=objProveedor.getObservaciones()%></textarea></td>
                            </tr>
                        </tbody>
                    </table>
                    <!--otras variables-->
                    <input type="hidden" name="accionProveedor" id="accionProveedor" value="editar" />
                </form>
            </div>
            <div style="clear: both;"></div>
            <div id="footer">
                <%@include file="../piePagina.jsp" %>
            </div>
        </div>
    </body>
</html>
<%    }
%>
