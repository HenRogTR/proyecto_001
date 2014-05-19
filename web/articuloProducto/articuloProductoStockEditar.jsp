<%-- 
    Document   : articuloProductoStockEditar
    Created on : 19/06/2013, 10:29:34 AM
    Author     : Henrri
--%>

<%@page import="articuloProductoClases.cKardexSerieNumero"%>
<%@page import="tablas.KardexSerieNumero"%>
<%@page import="tablas.Usuario"%>
<%
    Usuario objUsuario = (Usuario) session.getAttribute("usuario");
    if (objUsuario == null) {
        session.removeAttribute("direccion");
        session.setAttribute("direccion", "");
        response.sendRedirect("../");
    } else {
        Boolean estado = true;
        KardexSerieNumero objKardexSerieNumero = new KardexSerieNumero();
        int codKardexSerieNumero = 0;
        try {
            codKardexSerieNumero = Integer.parseInt(request.getParameter("codKardexSerieNumero"));
            objKardexSerieNumero = new cKardexSerieNumero().leer_codKardexSerieNumero(codKardexSerieNumero);
            if (objKardexSerieNumero == null) {
                estado = false;
            }
        } catch (Exception e) {
            estado = false;
        }
        if (!estado) {
            response.sendRedirect("articuloProductoMantenimiento.jsp");
        } else {
%>
<%--<%@page contentType="text/html" pageEncoding="UTF-8"%>--%>
<%@page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <title>Editar serie</title>
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
                <h3 class="titulo">EDICIÓN DE SERIE/NÚMERO</h3>
                <form action="../sKardexSerieNumero" method="get">
                    <table class="reporte-tabla-1" style="margin-top: 10px;">
                        <thead>
                            <tr>
                                <th colspan="3"><%=objKardexSerieNumero.getKardexArticuloProducto().getArticuloProducto().getDescripcion()%></th>
                            </tr>
                            <tr>
                                <th><label>CÓDIGO</label></th>
                                <th style="width: 300px;"><label>SERIE/NÚMERO</label></th>
                                <th style="width: 300px;"><label>OBSERVACIÓN</label></th>
                            </tr>
                        </thead>
                        <tfoot>
                            <tr>
                                <td colspan="3" style="text-align: right;">
                                    <button type="submit" class="sexybutton"><span><span><span class="save">Guardar</span></span></span></button>
                                </td>
                            </tr>
                        </tfoot>
                        <tbody>
                            <tr>
                                <td>
                                    <%=objKardexSerieNumero.getCodKardexSerieNumero()%>
                                    <input type="hidden" name="codKardexSerieNumero" value="<%=objKardexSerieNumero.getCodKardexSerieNumero()%>"/>
                                </td>
                                <td>
                                    <textarea style="width: 98%;height: 100px;" name="serieNumero"><%=objKardexSerieNumero.getSerieNumero()%></textarea>
                                </td>
                                <td>
                                    <textarea style="width: 98%;height: 100px;" name="observacion"><%=objKardexSerieNumero.getObservacion()%></textarea>
                                </td>
                            </tr>
                        </tbody>
                    </table>
                    <input type="hidden" name="codKardexArticuloProducto" value="<%=objKardexSerieNumero.getKardexArticuloProducto().getCodKardexArticuloProducto()%>"/>
                    <input type="hidden" name="accionKardexSerieNumero" value="editar"/>
                    <input type="hidden" name="codArticuloProducto" value="<%=objKardexSerieNumero.getKardexArticuloProducto().getArticuloProducto().getCodArticuloProducto() %>"/>
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
    }
%>