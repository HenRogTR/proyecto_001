<%-- 
    Document   : usuarioPrivilegios
    Created on : 31/03/2014, 04:12:56 PM
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
        <title></title>
        <!--todos-->
        <script type="text/javascript" src="../librerias/jquery/jquery-1.9.0-min.js" ></script>
        <script type="text/javascript" src="../librerias/jquery/jquery.timer-min.js" ></script>
        <script type="text/javascript" src="../librerias/jquery-ui/jquery-ui-1.10.3.custom/js/jquery-ui-1.10.3.custom.min.js" ></script>
        <link rel="stylesheet" type="text/css" href="../librerias/principal/todos.css" media="all"/>
        <!--cambios-->
        <%@include file="../principal/inclusiones.jsp" %>
        <!--propio-->
        <script type="text/javascript" src="../librerias/persona/usuario/usuarioPrivilegio.js"></script>
    </head>
    <body>
        <input type="hidden" name="paginaActualPermiso" value="1" title=""/>
        <div id="wrap">
            <div id="header">
                <label class="horaCabecera"><%=objcManejoFechas.fechaCabecera()%></label>
            </div>
            <div id="right">
                <div id="rightSub1" class="ocultar">
                    <h3 class="titulo">EDITAR LOS PRIVILEGIOS DE <span id="sUsuario"></span> </h3>
                    <form id="frm_usuarioPermiso" action="../sUsuario">
                        <input type="text" name="codUsuario" id="codUsuario" value="<%=request.getParameter("codUsuario")%>" class="ocultar" />
                        <input type="text" name="accionUsuario" id="accion" value="editarPrivilegio" class="ocultar" />
                        <fieldset class="">
                            <legend class="">
                                PRIVILEGIOS GLOBALES
                                <input type="checkbox" class="checkall_box" name="permisoTodos" id="permisoTodos" value="ON" />
                                <label for="permisoTodos">Marcar todos</label>
                            </legend>
                            <div style="width: 30%; float: left; margin: 5px;">
                                <fieldset class="ancho240px">
                                    <legend>Cliente</legend>
                                    <div>
                                        <input type="checkbox" class="checkall" name="p29" id="p29" value="ON"/>
                                        <label for="p29">REGISTRAR, EDITAR</label>
                                    </div>
                                    <div>
                                        <input type="checkbox" class="checkall" name="p1" id="p1" value="ON"/>
                                        <label for="p1">CONSULTAR</label>
                                    </div>
                                    <div>
                                        <input type="checkbox" class="checkall" name="p2" id="p2" value="ON"/>
                                        <label for="p2">KARDEX</label>                           
                                    </div>
                                    <div>
                                        <input type="checkbox" class="checkall" name="p51" id="p51" value="ON"/>
                                        <label for="p51">HABILITAR INTERESES</label>                           
                                    </div>
                                </fieldset>
                                <fieldset class="ancho240px">
                                    <legend>Empresa/Convenio</legend>
                                    <div>
                                        <input type="checkbox" class="checkall" name="p41" id="p41" value="ON" />
                                        <label for="p41">REGISTRAR, EDITAR, BORRAR</label>
                                    </div>
                                    <div>
                                        <input type="checkbox" class="checkall" name="p12" id="p12" value="ON" />
                                        <label for="p12">CONSULTAR</label>
                                    </div>
                                </fieldset>
                                <fieldset class="ancho240px">
                                    <legend>Garante</legend>
                                    <div>
                                        <input type="checkbox" class="checkall" name="p48" id="p48" value="ON" />
                                        <label for="p48">REGISTRAR, EDITAR, BORRAR</label>       
                                    </div>
                                    <div>
                                        <input type="checkbox" class="checkall" name="p25" id="p25" value="ON" />
                                        <label for="p25">CONSULTAR</label>
                                    </div>
                                </fieldset>
                                <fieldset class="ancho240px">
                                    <legend>Zona</legend>
                                    <div>
                                        <input type="checkbox" class="checkall" name="p46" id="p46" value="ON" />
                                        <label for="p46">REGISTRAR, EDITAR, BORRAR</label>
                                    </div>
                                    <div>
                                        <input type="checkbox" class="checkall" name="p16" id="p16" value="ON" />
                                        <label for="p16">LISTAR</label>
                                    </div>
                                </fieldset>
                                <fieldset class="ancho240px">
                                    <legend>Personal</legend>
                                    <div>
                                        <input type="checkbox" class="checkall" name="p30" id="p30" value="ON" />
                                        <label for="p30">REGISTRAR, EDITAR, BORRAR</label>
                                    </div>
                                    <div>
                                        <input type="checkbox" class="checkall" name="p9" id="p9" value="ON" />
                                        <label for="p9">LISTAR</label>
                                    </div>
                                </fieldset>
                                <fieldset class="ancho240px">
                                    <legend>Usuario</legend>
                                    <div>
                                        <input type="checkbox" class="checkall" name="p44" id="p44" value="ON" />
                                        <label for="p44">REGISTRAR, EDITAR, BORRAR</label>
                                    </div>
                                    <div>
                                        <input type="checkbox" class="checkall" name="p20" id="p20" value="ON" />
                                        <label for="p20">LISTAR</label>
                                    </div>
                                </fieldset>                            
                                <fieldset class="ancho240px">
                                    <legend>Área</legend>
                                    <div>
                                        <input type="checkbox" class="checkall" name="p32" id="p32" value="ON" />
                                        <label for="p32">REGISTRAR, EDITAR, BORRAR</label>
                                    </div>
                                    <div>
                                        <input type="checkbox" class="checkall" name="p11" id="p11" value="ON" />
                                        <label for="p11">LISTAR</label>
                                    </div>
                                </fieldset>
                            </div>
                            <div style="width: 30%; float: left; margin: 10px;">
                                <fieldset class="ancho240px">
                                    <legend>Venta</legend>
                                    <div>
                                        <input type="checkbox" class="checkall" name="p31" id="p31" value="ON" />
                                        <label for="p31">REGISTRAR, EDITAR</label>
                                    </div>
                                    <div>
                                        <input type="checkbox" class="checkall" name="p18" id="p18" value="ON" />
                                        <label for="p18">CONSULTAR</label>
                                    </div>
                                    <div>
                                        <input type="checkbox" class="checkall" name="p23" id="p23" value="ON" />
                                        <label for="p23">ANULAR</label>
                                    </div>
                                    <div>
                                        <input type="checkbox" class="checkall" name="p34" id="p34" value="ON" />
                                        <label for="p34">IMPRIMIR</label>
                                    </div>
                                    <div>
                                        <input type="checkbox" class="checkall" name="p33" id="p33" value="ON" />
                                        <label for="p33">MODIFICAR LETRA CRÉDITO</label>
                                    </div>
                                </fieldset>
                                <fieldset class="ancho240px">
                                    <legend>Almacén</legend>
                                    <div>
                                        <input type="checkbox" class="checkall" name="p38" id="p38" value="ON" />
                                        <label for="p38">REGISTRAR, EDITAR, BORRAR</label>
                                    </div>
                                    <div>
                                        <input type="checkbox" class="checkall" name="p8" id="p8" value="ON" />
                                        <label for="p8">CONSULTAR</label>
                                    </div>
                                </fieldset>                            
                                <fieldset class="ancho240px">
                                    <legend>Marca</legend>
                                    <div>
                                        <input type="checkbox" class="checkall" name="p45" id="p45" value="ON" />
                                        <label for="p45">REGISTRAR, EDITAR, BORRAR</label>
                                    </div>
                                    <div>
                                        <input type="checkbox" class="checkall" name="p13" id="p13" value="ON" />
                                        <label for="p13">CONSULTAR</label>
                                    </div>
                                </fieldset>
                                <fieldset class="ancho240px">
                                    <legend>Compra</legend>
                                    <div>
                                        <input type="checkbox" class="checkall" name="p39" id="p39" value="ON" />
                                        <label for="p39">REGISTRAR, EDITAR</label>
                                    </div>
                                    <div>
                                        <input type="checkbox" class="checkall" name="p3" id="p3" value="ON" />
                                        <label for="p3">LISTAR</label>
                                    </div>
                                    <div>
                                        <input type="checkbox" class="checkall" name="p40" id="p40" value="ON"/>
                                        <label for="p40">ANULAR</label>
                                    </div>
                                </fieldset>
                                <fieldset class="ancho240px">
                                    <legend>Reporte</legend>
                                    <div>
                                        <input type="checkbox" class="checkall" name="p19" id="p19" value="ON"/>
                                        <label for="p19">ACCEDER</label>
                                    </div>
                                </fieldset>
                                <fieldset class="ancho240px">
                                    <legend>Cargo</legend>
                                    <div>
                                        <input type="checkbox" class="checkall" name="p42" id="p42" value="ON" />
                                        <label for="p42">REGISTRAR, EDITAR, BORRAR</label>
                                    </div>
                                    <div>
                                        <input type="checkbox" class="checkall" name="p10" id="p10" value="ON" />
                                        <label for="p10">LISTAR</label>
                                    </div>
                                </fieldset>
                            </div>
                            <div style="width: 30%; float: left; margin: 10px;">
                                <fieldset class="ancho240px">
                                    <legend>Cobranza</legend>
                                    <div>
                                        <input type="checkbox" class="checkall" name="p22" id="p22" value="ON" />
                                        <label for="p22">ACCEDER</label>
                                    </div>
                                    <div>
                                        <input type="checkbox" class="checkall" name="p35" id="p35" value="ON" />
                                        <label for="p35">REGISTRAR RECIBO</label>
                                    </div>
                                    <div>
                                        <input type="checkbox" class="checkall" name="p24" id="p24" value="ON" />
                                        <label for="p24">ANULAR RECIBO</label>
                                    </div>
                                    <div>
                                        <input type="checkbox" class="checkall" name="p36" id="p36" value="ON" />
                                        <label for="p36">IMPRIMIR RECIBO</label>
                                    </div>
                                    <div>
                                        <input type="checkbox" class="checkall" name="p49" id="p49" value="ON" />
                                        <label for="p49">IMPRIMIR COPIA RECIBO</label>
                                    </div>
                                    <div>
                                        <input type="checkbox" class="checkall" name="p37" id="p37" value="ON" />
                                        <label for="p37">UTILIZAR SALDO A FAVOR</label>
                                    </div>
                                </fieldset>
                                <fieldset class="ancho240px">
                                    <legend>Artículos</legend>
                                    <div>
                                        <input type="checkbox" class="checkall" name="p15" id="p15" value="ON"/>
                                        <label for="p15">REGISTRAR, EDITAR, BORRAR</label>
                                    </div>
                                    <div>
                                        <input type="checkbox" class="checkall" name="p4" id="p4" value="ON" />
                                        <label for="p4">LISTAR</label>
                                    </div>
                                    <div>
                                        <input type="checkbox" class="checkall" name="p7" id="p7" value="ON"/>
                                        <label for="p7">KARDEX</label>
                                    </div>
                                    <div>
                                        <input type="checkbox" class="checkall" name="p6" id="p6" value="ON"/>
                                        <label for="p6">ACTUALIZACION MANUAL</label>
                                    </div>
                                    <div>
                                        <input type="checkbox" class="checkall" name="p21" id="p21" value="ON"/>
                                        <label for="p21">KARDEX S/N</label>
                                    </div>
                                    <div>
                                        <input type="checkbox" class="checkall" name="p27" id="p27" value="ON"/>
                                        <label for="p27">EDITAR PRECIO VENTA</label>
                                    </div>
                                    <div>
                                        <input type="checkbox" class="checkall" name="p52" id="p52" value="ON"/>
                                        <label for="p52">EDITAR PRECIO CASH</label>
                                    </div>
                                </fieldset>
                                <fieldset class="ancho240px">
                                    <legend>familia</legend>
                                    <div>
                                        <input type="checkbox" class="checkall" name="p43" id="p43" value="ON"/>
                                        <label for="p43">REGISTRAR, EDITAR, BORRAR</label>
                                    </div>
                                    <div>
                                        <input type="checkbox" class="checkall" name="p14" id="p14" value="ON" />
                                        <label for="p14">LISTAR</label>
                                    </div>
                                </fieldset>
                                <fieldset class="ancho240px">
                                    <legend>Proveedor</legend>
                                    <div>
                                        <input type="checkbox" class="checkall" name="p17" id="p17" value="ON" />
                                        <label for="p17">REGISTRAR, EDITAR, BORRAR</label>
                                    </div>
                                    <div>
                                        <input type="checkbox" class="checkall" name="p5" id="p5" value="ON" />
                                        <label for="p5">LISTAR</label>
                                    </div>
                                </fieldset>
                                <fieldset class="ancho240px">
                                    <legend>Propietario</legend>
                                    <div>
                                        <input type="checkbox" class="checkall" name="p47" id="p47" value="ON" />
                                        <label for="p47">REGISTRAR, EDITAR, BORRAR</label>
                                    </div>
                                    <div>
                                        <input type="checkbox" class="checkall" name="p26" id="p26" value="ON" />
                                        <label for="p26">LISTAR</label>
                                    </div>
                                </fieldset>
                            </div>
                            <div class="lineaDivisoria">
                                <button id="bDeshacer" type="button" class="sexybutton botonClic"><span><span><span class="undo">Restaurar</span></span></span></button>
                                <button id="bGuardar" type="button" class="sexybutton botonClic"><span><span><span class="save">Guardar</span></span></span></button>
                            </div>
                        </fieldset> 
                    </form>
                </div>
                <%@include file="../principal/div2.jsp" %>
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