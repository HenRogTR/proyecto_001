<%-- 
    Document   : marcaListar
    Created on : 08/11/2012, 11:07:20 AM
    Author     : Henrri
--%>

<%@page import="tablas.Marca"%>
<%@page import="java.util.Iterator"%>
<%@page import="java.util.List"%>
<%@page import="articuloProductoClases.cMarca"%>
<%@page import="tablas.Usuario"%>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <title>Mantenimiento de marcas</title>
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
        <link rel="stylesheet" type="text/css" href="../librerias/botonesIconos/sexybuttons.css" media="screen">
    </head>
    <body>
        <%
            Usuario objUsuario = (Usuario) session.getAttribute("usuario");
            if (objUsuario == null) {
                session.removeAttribute("direccion");
                session.setAttribute("direccion", "articuloProducto/marcaListar.jsp");
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
                    session.removeAttribute("accion");
                    cMarca objcMarca = new cMarca();
                    List lMarca = objcMarca.leer();
                    Iterator iMarca = lMarca.iterator();
                %>
                <h3 class="titulo">MANTENIMIENTO DE MARCAS <a class="sexybutton" href="../sMarca?accion=r" title="Nuevo"><span><span><span class="add">Nuevo</span></span></span></a></h3>
                <table class="tinytable">
                    <thead>
                        <tr>
                            <th style="width: 50px"><label>Código</label></th>
                            <th style="width: 150px"><label>Nombre</label></th>
                            <th style="width: 100px"><label>Opción</label></th>
                        </tr>
                    </thead>
                    <tbody>
                        <%
                            while (iMarca.hasNext()) {
                                Marca objMarca = (Marca) iMarca.next();
                        %>
                        <tr>
                            <td><label><%=objMarca.getCodMarca()%></label></td>
                            <td><label><%=objMarca.getDescripcion()%></label></td>
                            <td>
                                <a class="sexybutton sexyicononly personal" href="../sMarca?accion=a&codMarca=<%=objMarca.getCodMarca() %>" title="Editar"><span><span><span class="edit"></span></span></span></a>  
                                <a class="sexybutton sexyicononly personal" href="../sMarca?accion=d&codMarca=<%=objMarca.getCodMarca() %>" title="Eliminar"><span><span><span class="delete"></span></span></span></a>  
                            </td>
                        </tr>
                        <%
                            }
                            if (lMarca.size() == 0) {
                                %>
                                <tr>
                                    <td colspan="3">
                                        No se encuentra ninguna marca en la BD, 
                                        es necesario registrar al menos una Marca... <a href="../sMarca?accion=r">Continuar</a>
                                    </td>
                                </tr>
                                <%
                            }
                        %>               
                    </tbody>
                </table>
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