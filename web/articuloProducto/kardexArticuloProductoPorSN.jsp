<%-- 
    Document   : kardexArticuloProductoPorSN
    Created on : 22/05/2013, 09:28:08 AM
    Author     : Henrri
--%>

<%@page import="ventaClases.cVentasSerieNumero"%>
<%@page import="tablas.VentasSerieNumero"%>
<%@page import="java.util.Iterator"%>
<%@page import="tablas.CompraSerieNumero"%>
<%@page import="compraClases.cCompraSerieNumero"%>
<%@page import="java.util.List"%>
<%@page import="tablas.Usuario"%>
<%
    Usuario objUsuario = (Usuario) session.getAttribute("usuario");
    if (objUsuario == null) {
        session.removeAttribute("direccion");
        session.setAttribute("direccion", "articuloProducto/kardexArticuloProductoPorSN.jsp");
        response.sendRedirect("../");
    } else {

%>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <title>Kardex artículo S/N</title>
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
                <h3 class="titulo">KARDEX DE ARTICULO X S/N</h3>
                <br>
                <%
                    String serieNumero = request.getParameter("serieNumero") == null ? "" : request.getParameter("serieNumero").toUpperCase();
                %>
                <form action="kardexArticuloProductoPorSN.jsp">
                    <input type="text" name="serieNumero" value="<%=serieNumero%>" placeholder="S/N aquí" style="width: 400px;"/>
                    <button class="sexybutton"><span><span><span class="search">Buscar</span></span></span></button>
                </form>
                <br>
                <%
                    if (!serieNumero.equals("")) {
                        cUtilitarios objcUtilitarios = new cUtilitarios();
                        List lCompraSerieNumero = new cCompraSerieNumero().leer_serieNumero(serieNumero);
                %>
                <table class="reporte-tabla-1">
                    <thead>
                        <tr>
                            <th colspan=4"><label>DETALLE DE PRODUCTO (COMPRA) S/N: <%=serieNumero%></label> ********* COINCIDENCIAS</th>
                        </tr>
                        <tr>
                            <th style="width: 120px;"><label>Documento</label></th>
                            <th style="width: 120px;"><label>Fecha de Compra</label></th>
                            <th style="width: 400px;"><label>Artículo</label></th>
                            <th style="width: 150px;"><label>S/N</label></th>
                        </tr>
                    </thead>
                    <tbody>
                        <%
                            if (lCompraSerieNumero.size() == 0) {
                        %>
                        <tr>
                            <td colspan="4">No se ha comprado el articulo con esa serie</td>
                        </tr>
                        <%                            } else {
                            Iterator iCompraSerieNumero = lCompraSerieNumero.iterator();
                            while (iCompraSerieNumero.hasNext()) {
                                CompraSerieNumero objCompraSerieNumero = (CompraSerieNumero) iCompraSerieNumero.next();
                        %>
                        <tr>
                            <td><%=objCompraSerieNumero.getCompraDetalle().getCompra().getDocSerieNumero()%></td>
                            <td><%=objcUtilitarios.fechaDateToString(objCompraSerieNumero.getCompraDetalle().getCompra().getFechaFactura())%></td>
                            <td><%=objCompraSerieNumero.getCompraDetalle().getDescripcion()%></td>
                            <td><%=objCompraSerieNumero.getSerieNumero() %></td>
                        </tr>
                        <%
                                }
                            }
                        %>
                    </tbody>
                </table>
                    <br>
                <%
                    //fin buscar compraSerieNumero
                    List lVentasSerieNumero = new cVentasSerieNumero().leer_serieNumero(serieNumero);
                %>
                <table class="reporte-tabla-1">
                    <thead>
                        <tr>
                            <th colspan="4"><label>DETALLE DE PRODUCTO (VENTAS) S/N: <%=serieNumero%></label> ********* COINCIDENCIAS</th>
                        </tr>
                        <tr>
                            <th style="width: 120px;"><label>Documento</label></th>
                            <th style="width: 120px;"><label>Fecha de Compra</label></th>
                            <th style="width: 400px;"><label>Artículo</label></th>
                            <th style="width: 150px;"><label>S/N</label></th>
                        </tr>
                    </thead>
                    <tbody>
                        <%
                            if (lVentasSerieNumero.size() == 0) {
                        %>
                        <tr>
                            <td colspan="4">No se ha vendido el articulo con esa serie</td>
                        </tr>
                        <%                            } else {
                            Iterator iVentasSerieNumero = lVentasSerieNumero.iterator();
                            while (iVentasSerieNumero.hasNext()) {
                                VentasSerieNumero objVentasSerieNumero = (VentasSerieNumero) iVentasSerieNumero.next();
                        %>
                        <tr>
                            <td><%=objVentasSerieNumero.getVentasDetalle().getVentas().getDocSerieNumero()%></td>
                            <td><%=objcUtilitarios.fechaDateToString(objVentasSerieNumero.getVentasDetalle().getVentas().getFecha())%></td>
                            <td><%=objVentasSerieNumero.getVentasDetalle().getDescripcion()%></td>
                            <td><%=objVentasSerieNumero.getSerieNumero() %></td>
                        </tr>
                        <%
                                }
                            }
                        %>
                    </tbody>
                </table>
                <%
                    }
                %>
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