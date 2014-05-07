<%-- 
    Document   : articuloProductoEditar
    Created on : 16/04/2013, 10:18:14 AM
    Author     : Henrri
--%>

<%@page import="tablas.CompraDetalle"%>
<%@page import="tablas.Marca"%>
<%@page import="articuloProductoClases.cMarca"%>
<%@page import="tablas.Familia"%>
<%@page import="articuloProductoClases.cFamilia"%>
<%@page import="java.util.Iterator"%>
<%@page import="java.util.List"%>
<%@page import="articuloProductoClases.cArticuloProducto"%>
<%@page import="tablas.ArticuloProducto"%>
<%@page import="tablas.Usuario"%>
<%
    Usuario objUsuario = (Usuario) session.getAttribute("usuario");
    if (objUsuario == null) {
        session.removeAttribute("direccion");
        session.setAttribute("direccion", "articuloProducto/articuloProductoMantenimiento.jsp");
        response.sendRedirect("../");
    } else {
        cArticuloProducto objcArticuloProducto = new cArticuloProducto();
        ArticuloProducto objArticuloProducto = null;
        int codArticuloProducto = 0;
        try {
            codArticuloProducto = Integer.parseInt(request.getParameter("codArticuloProducto"));
            objArticuloProducto = objcArticuloProducto.leer_cod(codArticuloProducto);
            if (objArticuloProducto == null) {
                response.sendRedirect("articuloProductoMantenimiento.jsp");
                return;
            }
        } catch (Exception e) {
            response.sendRedirect("articuloProductoMantenimiento.jsp");
            return;
        }
%>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <title>Editar artículo/producto</title>
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
        <link rel="stylesheet" type="text/css" href="../librerias/botonesIconos/sexybuttons.css" media="screen">
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
                    cUtilitarios objcUtilitarios = new cUtilitarios();
                    cFamilia objcFamilia = new cFamilia();
                    cMarca objcMarca = new cMarca();
                %>
                <h3 class="titulo">EDITAR ARTÍCULO/PRODUCTO</h3>
                <br>
                <form id="articuloProductoFrm" action="../sArticuloProducto">
                    <table class="reporte-tabla-1" style="font-size: 12px;">
                        <thead>
                            <tr>
                                <th colspan="4" style="text-align: center;"><label class="tituloEspaciado">EDITAR ARTICULOS/PRODUCTOS</label></th>
                            </tr>
                        </thead>
                        <tfoot>
                            <tr id="trBoton">
                                <th colspan="4" style="text-align: center">                                    
                                    <button class="sexybutton" type="button" id="cancelar"><span><span><span class="cancel">Cancelar</span></span></span></button>
                                    <button class="sexybutton" type="reset" id="restaurar"><span><span><span class="redo">Restaurar</span></span></span></button>
                                    <button class="sexybutton" type="submit" id="accion"><span><span><span class="save">Guardar</span></span></span></button>
                                    <!--paramtetros-->
                                    <input type="hidden" name="accionArticuloProducto" value="editar" />
                                </th>
                            </tr>
                            <tr>
                                <th colspan="12">
                                    <label style="color: red">(*) Datos obligatorios</label>
                                </th>
                            </tr>
                        </tfoot>
                        <tbody>
                            <tr>
                                <th style="width: 160px;"><label>Código</label></th>
                                <td style="width: 200px;"><input type="text" name="codArticuloProducto" id="codArticuloProducto" class="lectura" value="<%=objcUtilitarios.agregarCeros_int(objArticuloProducto.getCodArticuloProducto(), 8)%>" readonly=""/></td>
                                <th style="width: 160px;"><label>Código de referencia</label></th>
                                <td style="width: 200px;"><input type="text" name="codReferencia" id="codReferencia" class="tamanio"/></td>
                            </tr>
                            <tr>
                                <th><label>Descripción</label><label class="requerido"></label></th>
                                <td colspan="3"><textarea id="descripcion" name="descripcion" style="width: 99%;height: 50px" ><%=objArticuloProducto.getDescripcion()%></textarea></td>
                            </tr>
                            <tr>
                                <th>
                                    Controlar S/N<label class="requerido"></label>
                                    <a class="sexybutton sexyicononly" id="serieNumeroInfo"><span><span><span class="info"></span></span></span></a>
                                </th>
                                <td>
                                    <%
                                        boolean serieNumeroTemp = true;
                                        for (CompraDetalle objCompraDetalle : objArticuloProducto.getCompraDetalles()) {
                                            if (objCompraDetalle.getRegistro().substring(0, 1).equals("1")) {
                                                serieNumeroTemp = false;
                                            }
                                        }
                                        if (serieNumeroTemp) {
                                    %>
                                    <select id="usarSerieNumero" name="usarSerieNumero">
                                        <option value="">Seleccione</option>
                                        <option value="1">Habilitar</option>
                                        <option value="0">Deshabilitar</option>
                                    </select>
                                    <%                                                } else {
                                    %>
                                    <label><%=objArticuloProducto.getUsarSerieNumero() ? "HABILITADO" : "DESHABILITADO"%></label>
                                    <input type="hidden" name="usarSerieNumero" value="<%=objArticuloProducto.getUsarSerieNumero() ? "1" : "0"%>" />
                                    <%
                                        }
                                    %>
                                </td>
                                <th>Reintegro Tributario<label class="requerido"></label></th>
                                <td>
                                    <select id="reintegroTributario" name="reintegroTributario">
                                        <option value="">Seleccione</option>
                                        <option value="1" <%if (objArticuloProducto.getReintegroTributario()) {%>selected=""<%}%>>Si</option>
                                        <option value="0" <%if (!objArticuloProducto.getReintegroTributario()) {%>selected=""<%}%>>No</option>
                                    </select>
                                </td>
                            </tr>
                            <tr>
                                <th><label>Familia</label><label class="requerido"></label></th>
                                <td>
                                    <%
                                        List lFamilia = objcFamilia.leer();
                                    %>
                                    <select id="codFamilia" name="codFamilia" style="width: 90%;">
                                        <option value="">Seleccione</option>
                                        <%
                                            for (int i = 0; i < lFamilia.size(); i++) {
                                                Familia objFamilia = (Familia) lFamilia.get(i);
                                        %>
                                        <option value="<%=objFamilia.getCodFamilia()%>" <%if (objFamilia.getCodFamilia().equals(objArticuloProducto.getFamilia().getCodFamilia())) {%>selected=""<%}%>><%=objFamilia.getFamilia()%></option>
                                        <%
                                            }
                                        %>
                                    </select>
                                </td>
                                <th><label>Marca</label><label class="requerido"></label></th>
                                <td>
                                    <select id="codMarca" name="codMarca">
                                        <option value="">Seleccione</option>
                                        <%
                                            List lMarca = objcMarca.leer();
                                            Iterator iMarca = lMarca.iterator();
                                            while (iMarca.hasNext()) {
                                                Marca objMarca = (Marca) iMarca.next();
                                        %>
                                        <option value="<%=objMarca.getCodMarca()%>" <%if (objMarca.getCodMarca().equals(objArticuloProducto.getMarca().getCodMarca())) {%>selected=""<%}%>><%=objMarca.getDescripcion()%></option>
                                        <%
                                            }
                                        %>
                                    </select>
                                </td>
                            </tr>                                
                            <tr>
                                <th><label>Observaciones</label></th>
                                <td colspan="3"><textarea id="observaciones" name="observaciones" style="width: 98%;height: 50px" ><%=objArticuloProducto.getDescripcion() == null ? "" : objArticuloProducto.getObservaciones()%></textarea></td>
                            </tr>
                            <tr>
                                <th><label>U. Medida</label></th>
                                <td colspan="3"><input type="text" id="unidadMedida" name="unidadMedida" style="width: 450px" value="<%=objArticuloProducto.getUnidadMedida()%>"/></td>
                            </tr>
                            <tr>
                                <th><label>Foto</label></th>
                                <td colspan="3"><input type="file" id="foto" name="foto" style="width: 450px"/></td>
                            </tr>                            
                        </tbody>
                    </table>
                </form>
                <!--div info serie numero-->
                <div title="Información Serie/Número" id="dSerieNumeroInfo" style="font-size: 13px;text-align: justify;">
                    <strong>¡Advertencia!</strong> Ya se ha realizado compras para este articulo. Editar esta información requiere
                    realizar cambios que afectan a los modulos de Compras y Ventas. Consulte al AD de la BD para contar con la posibilidad
                    de editar esta información.
                </div>
                <script type="text/javascript" src="../lib/jquery-validation/jquery-validation-1.10.0/js/jquery.validate.min.js"></script>
                <script type="text/javascript" src="../lib/jquery-validation/localization/messages_es.js"></script>
                <script type="text/javascript" src="../lib/articulo-producto/articulo.producto-editar.js?v13.08.02"></script>
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