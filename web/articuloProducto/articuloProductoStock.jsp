<%-- 
    Document   : articuloProductoStock
    Created on : 19/06/2013, 09:32:17 AM
    Author     : Henrri
--%>

<%@page import="tablas.KardexSerieNumero"%>
<%@page import="articuloProductoClases.cKardexArticuloProducto"%>
<%@page import="tablas.KardexArticuloProducto"%>
<%@page import="tablas.Usuario"%>
<%
    Usuario objUsuario = (Usuario) session.getAttribute("usuario");
    if (objUsuario == null) {
        session.removeAttribute("direccion");
        session.setAttribute("direccion", "articuloProducto/articuloProductoStock.jsp");
        response.sendRedirect("../");
    } else {
        Boolean estado = true;
        int codArticuloProducto = 0;
        try {
            codArticuloProducto = Integer.parseInt(request.getParameter("codArticuloProducto"));
        } catch (Exception e) {
            estado = false;
        }
        if (!estado) {
            response.sendRedirect("articuloProductoMantenimiento.jsp");
        } else {

%>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <title>Series en Stock</title>
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
                    KardexArticuloProducto objKardexArticuloProducto = new cKardexArticuloProducto().leer_articuloProductoStock(codArticuloProducto, 1);
                %>
                <h3 class="titulo">SERIES EN STOCK</h3>
                <table class="reporte-tabla-1" style="margin-top: 10px;width: 100%;">
                    <thead>
                        <tr>
                            <th style="width: 60px;"><label>CÓDIGO</label></th>
                            <td style="width: 120px;"><%=objcUtilitarios.agregarCeros_int(objKardexArticuloProducto.getArticuloProducto().getCodArticuloProducto(), 8)%></td>
                            <th style="width: 120px;"><label>DESCRIPCIÓN</label></th>
                            <td><%=objKardexArticuloProducto.getArticuloProducto().getDescripcion()%></td>
                            <th><label>OPCIÓN</label></th>
                        </tr>
                    </thead>
                    <tbody>
                        <%
                            for (KardexSerieNumero objKardexSerieNumero : objKardexArticuloProducto.getKardexSerieNumeros()) {
                        %>
                        <tr>
                            <td><%=objKardexSerieNumero.getCodKardexSerieNumero()%></td>
                            <td colspan="2"><%=objKardexSerieNumero.getSerieNumero().replace("\n", "<br>")%></td>
                            <td><%=objKardexSerieNumero.getObservacion().replace("\n", "<br>")%></td>
                            <td>
                                <a class="sexybutton" href="articuloProductoStockEditar.jsp?codKardexSerieNumero=<%=objKardexSerieNumero.getCodKardexSerieNumero()%>" target="_blank"><span><span><span class="edit"></span></span></span></a>
                            </td>
                        </tr>
                        <%    }
                        %>
                    </tbody>
                </table>
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