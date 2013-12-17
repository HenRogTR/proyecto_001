<%-- 
    Document   : areaFrm
    Created on : 26/11/2012, 10:28:32 AM
    Author     : Henrri
--%>

<%@page import="otros.cUtilitarios"%>
<%@page import="tablas.Usuario"%>
<%@page import="tablas.Area"%>
<%
    Usuario objUsuario = (Usuario) session.getAttribute("usuario");
    if (objUsuario == null) {
        session.removeAttribute("direccion");
        session.setAttribute("direccion", "persona/areaFrm.jsp");
        response.sendRedirect("../");
    } else {
        String accion = (String) session.getAttribute("accionArea");
        if (accion == null) {
            response.sendRedirect("areaListar.jsp");
        } else {
            cUtilitarios objUtilitarios = new cUtilitarios();
            String accion2 = objUtilitarios.accion2(accion);
%>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <title><%=accion2%> </title>
        <!--stilo inicio-->
        <link rel="stylesheet" type="text/css" href="../lib/propios/css/inicio/style.css" />
        <!--js query-->
        <script type="text/javascript" src="../lib/jquery/jquery-1.8.1.min.js"></script>
        <!--css js ui-->
        <link rel="stylesheet" type="text/css" href="../lib/jquery-ui/jquery-ui-1.10.0.custom/css/smoothness/jquery-ui-1.10.0.custom.min.css">
        <script type="text/javascript" src="../lib/jquery-ui/jquery-ui-1.9.0/jquery-ui-git.js"></script>
        <!--css frm-->
        <link rel="stylesheet" type="text/css" href="../lib/propios/css/formulario/detalles.css" />        
        <!--css iconos-->
        <link rel="stylesheet" type="text/css" href="../lib/botones/sexybuttons.css">
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
                <h3 class="titulo"><%=accion2.toUpperCase()%> ÁREA</h3>
                <%
                    Area objArea = new Area();
                %>
                <form action="../sArea" id="areaFrm">
                    <table class="tinytable">
                        <tr>
                            <th><label style="width: 100px;">Código</label></th>
                            <td><input type="text" name="codArea" value="<%=objArea.getCodArea() == null ? "Autogenerado" : objArea.getCodArea()%>" id="codArea" class="lectura" readonly=""/></td>
                        </tr>
                        <tr>
                            <th><label>Área</label></th>
                            <td><input type="text" name="area" value="<%=objArea.getArea() == null ? "" : objArea.getArea()%>" id="area"/></td>
                        </tr>
                        <tr>
                            <th><label>Detalle</label></th>
                            <td><textarea name="detalle" id="detalle" style="height: 50px;"><%=objArea.getDetalle() == null ? "" : objArea.getDetalle()%></textarea></td>
                        </tr>
                        <tr>
                            <td style="text-align: center" colspan="2">
                                <button class="sexybutton"  type="button" id="cancelar"><span><span><span class="cancel">Cancelar</span></span></span></button>&nbsp;&nbsp;
                                <button class="sexybutton" type="reset" id="restaurar"><span><span><span class="redo">Restaurar</span></span></span></button>&nbsp;&nbsp;
                                <button class="sexybutton" type="submit" id="accion"><span><span><span class="save">Guardar</span></span></span></button>
                            </td>
                        </tr>
                    </table>
                </form>
                <!--inicio dialogo cancelar registro-->
                <div id="registroCancelar" title="Cancelar registro">
                    <div class="ui-widget">
                        <div class="ui-state-highlight ui-corner-all" style="margin-top: 20px; padding: 0 .7em;">
                            <p><span class="ui-icon ui-icon-info" style="float: left; margin-right: .3em;"></span>
                                <strong>¡Atención!</strong> Está seguro de cancelar el registro, tenga en cuenta que se perderan los datos.</p>
                        </div>
                    </div>
                </div>
                <!--fin dialogo cancelar registro-->
                <!--inicio dialogo confirmar registro-->
                <div id="registroConfirmar" title="Confirmar registro">
                    <table class="tinytable">
                        <tr>
                            <th><label style="width: 100px;">Código</label></th>
                            <td><label id="lCodArea" style="width: 230px"></label></td>
                        </tr>
                        <tr>
                            <th><label>Área</label></th>
                            <td><label id="lArea"></label></td>
                        </tr>
                        <tr>
                            <th><label>Detalle</label></th>
                            <td><label id="lDetalle"></label></td>
                        </tr>
                    </table>                        
                    <div class="ui-state-highlight ui-corner-all" style="margin-top: 20px; padding: 0 .7em;">
                        <p>
                            <strong>¿Desea guardar los datos?</strong>
                            <span class="ui-icon ui-icon-info" style="float: left; margin-right: .3em;"></span>
                        </p>
                    </div>
                </div>
                <!--fin dialogo confirmar registro-->
                <!--inicio registro exitoso-->
                <div id="registroExitoso" title="Registro exitoso">
                    <div class="ui-widget">
                        <div class="ui-state-highlight ui-corner-all" style="margin-top: 20px; padding: 0 .7em;">
                            <p><span class="ui-icon ui-icon-info" style="float: left; margin-right: .3em;"></span>
                                <strong>¡Atención!</strong> El registro se realizó correctamente.</p>
                        </div>
                    </div>
                </div>
                <!--fin registro exitoso-->
                <!--inicio registro error-->
                <div id="registroError" title="Error en el registro">
                    <div class="ui-widget">
                        <div class="ui-state-error ui-corner-all" style="padding: 0 .7em;">
                            <p><span class="ui-icon ui-icon-alert" style="float: left; margin-right: .3em;"></span>
                                <strong>¡Alerta!</strong> Error en el registro, verifique e intente nuevamente.
                                Si el error persiste contacte con el administrador <a href="mailto:henrri.trujillo@gmail.com" target="_black">HenRogTR</a></p>
                        </div>
                    </div>
                </div>
                <!--fin registro error-->
                <!--inicio error servidor-->
                <div id="registroErrorServidor" title="Error del servidor">
                    <div class="ui-widget">
                        <div class="ui-state-error ui-corner-all" style="padding: 0.7em;">
                            <p>
                                <span class="ui-icon ui-icon-alert" style="float: left;margin-right: .3em;"></span>
                                <strong>¡Error del servidor!</strong> Verifique con el administrador del sistema.
                            </p>
                        </div>
                    </div>
                </div>
                <!--inicio error servidor-->
                <script type="text/javascript" src="../lib/jquery-validation/jquery-validation-1.10.0/js/jquery.validate.min.js"></script>
                <script type="text/javascript" src="../lib/jquery-validation/localization/messages_es.js" ></script>
                <script type="text/javascript" src="../lib/persona/area-dialog.js"></script>
                <script type="text/javascript" src="../lib/persona/area-validation.js"></script>
                <script type="text/javascript" src="../lib/persona/area-funciones-ajax.js"></script>                
            </div>
            <div style="clear: both;"> </div>
            <div id="footer">
                <%@include file="../piePagina.jsp" %>
            </div>
        </div>
    </body>
</html>
<%
        }
    }
%>