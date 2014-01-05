<%-- 
    Document   : marcaFrm
    Created on : 08/11/2012, 11:07:10 AM
    Author     : Henrri
--%>

<%@page import="tablas.Marca"%>
<%@page import="articuloProductoClases.cMarca"%>
<%@page import="personaClases.cZona"%>
<%@page import="tablas.Area"%>
<%@page import="tablas.Persona"%>
<%@page import="tablas.Zona"%>
<%@page import="java.util.Iterator"%>
<%@page import="java.util.List"%>
<%@page import="otros.cUtilitarios"%>
<%@page import="tablas.Usuario"%>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <title>Mantenimiento de áreas</title>
        <!--stilo inicio-->
        <link rel="stylesheet" type="text/css" href="../lib/propios/css/inicio/style.css" />
        <!--js query-->
        <script type="text/javascript" src="../lib/jquery/jquery-1.8.1.min.js"></script>
        <!--css js ui-->
        <link rel="stylesheet" type="text/css" href="../lib/jquery-ui/jquery-ui-1.10.0.custom/css/smoothness/jquery-ui-1.10.0.custom.min.css">
        <script type="text/javascript" src="../lib/jquery-ui/jquery-ui-1.9.0/jquery-ui-git.js"></script>
        <!--css frm-->
        <link rel="stylesheet" type="text/css" href="../lib/propios/css/formulario/detalles.css" />
        <!--css js modal-->
        <link rel="stylesheet" type="text/css" href="../lib/modal/css/basic.css"/>
        <!-- IE6 "fix" for the close png image -->
        <!--[if lt IE 7]>
        <link rel="stylesheet" type="text/css"  href='../lib/modal/css/basic_ie.css'/>
        <![endif]-->
        <style>
            #simplemodal-container {
                height:100px; 
                width:350px; 
                color:#000000; 
                background-color: #bbb; 
                border:4px solid #444; 
                padding:12px;
            }
        </style>
        <script type="text/javascript" src="../lib/modal/js/jquery.simplemodal.js"></script>
        <!--css iconos-->
        <link rel="stylesheet" type="text/css" href="../lib/botones/sexybuttons.css">
        <!--css y js inicio menu-->
        <style>
            .ui-menu { 
                width: 155px;
            }
        </style>
        <script>
            $(function() {
                $("#menu").menu();
            });
        </script>
    </head>
    <body>
        <%
            Usuario objUsuario = (Usuario) session.getAttribute("usuario");
            if (objUsuario == null) {
                session.removeAttribute("direccion");
                session.setAttribute("direccion", "articuloProducto/marcaFrm.jsp");
                response.sendRedirect("../index.jsp");
            } else {
        %>
        <div id="wrap">

            <div id="header">
                <%@include file="../cabecera.jsp" %>
            </div>

            <div id="left"> 
                <%@include file="../menu2.jsp" %>
            </div>

            <div id="right">
                <%
                    cUtilitarios objcUtilitarios = new cUtilitarios();

                    Marca objMarca = new Marca();
                    String accion = (String) session.getAttribute("accionMarca");
                    if (accion == null) {
                        response.sendRedirect("../articuloProducto/marcaListar.jsp");
                    } else {
                        String codigo = "Autogenerado";
                        String accion2 = objcUtilitarios.accion2(accion);
                        if (accion.equals("a")) {
                            int codMarca = (Integer) session.getAttribute("codMarca");
                            codigo = String.valueOf(codMarca);
                        }
                %>
                <h3 class="titulo"><%=accion2.toUpperCase() %> MARCA</h3>
                <br>
                <form id="marcaFrm" action="../sMarca">
                    <table class="tinytable">
                        <tbody>
                            <tr>
                                <th><label>*Codigo :</label></th>
                                <td>
                                    <input type="text" id="codMarca" name="codMarca" value="<%=codigo%>" readonly="" class="lectura"/>
                                </td>
                            </tr>
                            <tr>
                                <th><label>*Nombre :</label></th>
                                <td>
                                    <input type="text" id="descripcion" name="descripcion" value="<%=objMarca.getDescripcion()==null?"":objMarca.getDescripcion() %>" />
                                </td>
                            </tr>
                            <tr>
                                <td colspan="2">
                                    <button class="sexybutton"  type="button" id="cancelar"><span><span><span class="cancel">Cancelar</span></span></span></button>
                                    <button class="sexybutton" type="reset" id="restaurar"><span><span><span class="redo">Restaurar</span></span></span></button>
                                    <button class="sexybutton" type="submit" id="accion"><span><span><span class="save">Guardar</span></span></span></button>
                                    <div id="ajax_loader"><img id="loader_gif" src="../imagenes/loading.gif" style=" display:none;"/><label id="men" style="display: none"> Guardando... Espere por favor</label></div>
                                </td>
                            </tr>
                        </tbody>
                    </table>
                </form>
                <!--modal-continuar-->
                <div id="basic-modal-content">
                    <div class="ui-widget">
                        <div class="ui-state-highlight ui-corner-all" style="margin-top: 20px; padding: 0 .7em;">
                            <p>
                                <strong id="mensaje"></strong>
                            </p>
                        </div>
                    </div>
                    <br>
                    <a class="sexybutton sexysimple personal" href="../sMarca?accion=r" title="Nuevo"><span class="add">Registrar otra marca</span></a>&nbsp;
                    <a class="sexybutton sexysimple personal" href="marcaListar.jsp" title="Nuevo"><span class="add">Listar marcas</span></a>
                </div>
                <!-- preload the images -->
                <div style='display:none'>
                    <img src='img/basic/x.png' alt='' />
                </div>
                <script src="../librerias/jquery.validate/1.11.1/jquery.validate.min.js" type="text/javascript"></script>
                <script src="../librerias/jquery.validate/1.11.1/localization/messages_es.js" type="text/javascript"></script>
                <script type="text/javascript">
                    $(document).ready(function() {
                        $("input,textarea").blur(function() {
                            $(this).val($(this).val().toUpperCase());
                        });
                        $("input,textarea").blur(function() {
                            $(this).val($.trim($(this).val()));
                        });
                    });
                    $.validator.setDefaults({
                        submitHandler: function() {
                            $("#cancelar").attr("disabled", "disabled").addClass("disabled");
                            $("#restaurar").attr("disabled", "disabled").addClass("disabled");
                            $("#accion").attr("disabled", "disabled").addClass("disabled");
                            var form = $("#marcaFrm");
                            var url = form.attr('action');  //la url del action del formulario
                            var datos = form.serialize(); // los datos del formulario
                            $.ajax({
                                type: 'POST',
                                url: url,
                                data: datos,
                                beforeSend: mostrarLoader, //funciones que definimos más abajo
                                error: callback_error,
                                success: mostrarRespuesta  //funciones que definimos más abajo
                            });
                        },
                        showErrors: function(map, list) {
                            var focussed = document.activeElement;
                            if (focussed && $(focussed).is("input, textarea")) {
                                $(this.currentForm).tooltip("close", {currentTarget: focussed}, true)
                            }
                            this.currentElements.removeAttr("title").removeClass("ui-state-highlight");
                            $.each(list, function(index, error) {
                                $(error.element).attr("title", error.message).addClass("ui-state-highlight");
                            });
                            if (focussed && $(focussed).is("input, textarea")) {
                                $(this.currentForm).tooltip("open", {target: focussed});
                            }
                        }
                    });
                    (function() {
                        $("#marcaFrm").tooltip({
                            show: false,
                            hide: false
                        });
                        $("#marcaFrm").validate({
                            rules: {
                                descripcion: {
                                    required: true,
                                    minlength: 2,
                                    remote: "marcaVerificar.jsp"
                                }
                            },
                            messages: {
                                descripcion: {
                                    required: "Por favor, introduzca un nombre de <b>Marca</b>",
                                    minlength: "El nombre de Marca debe consistir de por lo menos <b>{0}</b> caracteres",
                                    remote: "La marca ya existe"
                                }
                            }
                        });
                    })();
                    function mostrarLoader() {
                        $('#loader_gif').fadeIn("slow");
                        $('#men').fadeIn("slow");
                    }
                    ;
                    function callback_error(XMLHttpRequest, textStatus, errorThrown) {
                        $("#loader_gif").fadeOut("slow");
                        $("#men").fadeOut("slow");
                        $("#mensaje").text("Error en el servidor, contacte al administrador");
                        $("#basic-modal-content").modal();
                    }
                    ;
                    function mostrarRespuesta(respuesta) {
                        $("#loader_gif").fadeOut("slow");
                        $("#men").fadeOut("slow");
                        $("#descripcion").val("");
                        $("#cancelar").removeAttr("disabled").removeClass("disabled");
                        $("#restaurar").removeAttr("disabled").removeClass("disabled");
                        $("#accion").removeAttr("disabled").removeClass("disabled");
                        if (respuesta == "true") {
                            $("#mensaje").text("Registro exitoso");
                            $("#basic-modal-content").modal();
                        }
                        else {
                            $("#mensaje").text("Falló el registro");
                            $("#basic-modal-content").modal();
                        }
                    }
                </script>
                <%
                    }
                %>
            </div>
            <div style="clear: both;"> </div>
            <div id="footer">
                <%@include file="../piePagina.jsp" %>
            </div>
        </div>
        <%
            }
        %>
    </body>
</html>
