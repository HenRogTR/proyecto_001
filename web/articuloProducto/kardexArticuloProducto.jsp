<%-- 
    Document   : kardexArticuloProducto
    Created on : 21/12/2012, 09:46:31 PM
    Author     : Henrri
--%>

<%@page import="tablas.Almacen"%>
<%@page import="java.util.List"%>
<%@page import="compraClases.cAlmacen"%>
<%@page import="tablas.Usuario"%>
<%
    Usuario objUsuario = (Usuario) session.getAttribute("usuario");
    if (objUsuario == null) {
        session.removeAttribute("direccion");
        session.setAttribute("direccion", "");
        response.sendRedirect("../");
    } else {

%>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <title>Kardex de Artículos/Producto</title>
        <!--stilo inicio-->
        <link rel="stylesheet" type="text/css" href="../lib/propios/css/inicio/style.css" />
        <!--js query-->
        <script type="text/javascript" src="../lib/jquery/jquery-1.8.1.min.js"></script>
        <!--css js ui-->
        <link rel="stylesheet" type="text/css" href="../lib/jquery-ui/jquery-ui-1.10.0.custom/css/smoothness/jquery-ui-1.10.0.custom.min.css">
        <script type="text/javascript" src="../lib/jquery-ui/jquery-ui-1.9.0/jquery-ui-git.js"></script>
        <!--css frm-->
        <link rel="stylesheet" type="text/css" href="../lib/propios/css/tablas/tablas-reportes.css" />
        <!--css iconos-->
        <link rel="stylesheet" type="text/css" href="../lib/botones/sexybuttons.css">
        <!--js css propio-->
        <style>            
            .ui-autocomplete {
                width: 500px;
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
        <script type="text/javascript" src="../lib/articulo-producto/articulo.producto-kardex.js"></script>
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
                    session.removeAttribute("accion");
                %>
                <h3 class="titulo">MOVIMIENTO DE PRODUCTOS</h3>
                <br>
                <label class="tamanio">Código: </label> <input type="text" name="codArticuloProducto" id="codArticuloProducto" value="" placeholder="Código" style="width: 80px;text-align: right;"/>
                <input type="text" id="descripcion" name="descripcion" class="search" placeholder="Buscar producto" style="width: 480px"/>
                <label class="tamanio">Almacén</label>
                <select id="codAlmacen">
                    <option value="">Seleccione</option>
                    <%
                        cAlmacen objcAlmacen = new cAlmacen();
                        List lAlmacen = objcAlmacen.leer();
                        for (int i = 0; i < lAlmacen.size(); i++) {
                            Almacen objAlmacen = (Almacen) lAlmacen.get(i);
                    %>
                    <option value="<%=objAlmacen.getCodAlmacen()%>" <%if(objAlmacen.getCodAlmacen()==1){%>selected=""<%} %> ><%=objAlmacen.getAlmacen()%></option>
                    <%
                        }
                    %>
                </select>
                <br>
                <br>
                <table class="reporte-tabla-1" style="width: 100%;">
                    <thead>
                        <tr>
                            <th colspan="9"><label id="arti">COD: </label></th>
                        </tr>
                        <tr style="font-size: 9px; background: #999999">
                            <th style="width: 110px">Fecha y hora</th>
                            <th style="width: 100px">Documento</th>
                            <th>Detalles</th>
                            <th style="width: 30px">Entrada</th>
                            <th style="width: 30px">Salida</th>
                            <th style="width: 30px">Stock</th>
                            <th style="width: 65px">Precio</th>
                            <th style="width: 65px">P. Ponderado</th>
                            <th style="width: 65px">Total</th>
                        </tr>
                    </thead>
                    <tbody style="font-size:  10px" id="kardexArticuloProducto">
                    </tbody>
                </table>
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
%>