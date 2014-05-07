<%-- 
    Document   : newjsp
    Created on : 15/11/2012, 10:25:01 PM
    Author     : Henrri
--%>

<%@page import="utilitarios.cOtros"%>
<%@page import="personaClases.cUsuario"%>
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
        <title>Almacén</title>
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
                    cAlmacen objcAlmacen = new cAlmacen();
                    cUsuario objcUsuario = new cUsuario();
                %>
                <h3 class="titulo">MANTENIMIENTO DE ALMACEN(ES) &nbsp; <a href="../sAlmacen?accionAlmacen=r" class="sexybutton"><span><span><span class="add">Nuevo</span></span></span></a></h3>
                <br>
                <div style="width:850px; height: 550px ;overflow: auto;">
                    <table class="reporte-tabla-1">
                        <tr>
                            <th style="width: 100px;"><label>CÓDIGO</label></th>
                            <th style="width: 200px;"><label>DESCRIPCIÓN</label></th>
                            <th style="width: 200px;"><label>DIRECCIÓN</label></th>
                            <th style="width: 200px;"><label>DETALLE</label></th>
                            <th style="width: 180px;"><label>OPCIONES</label></th>
                                <%
                                    if (objUsuario.getP30()) {
                                %>
                            <th style="width: 150px"><label>REGISTRADOR</label></th>
                            <th style="width: 300px"><label>F. REGISTRO</label></th>
                            <th style="width: 150px"><label>ESTADO</label></th>
                                <%                                    }
                                %>
                        </tr>
                        <%
                            List lAlmacen = objcAlmacen.leer();
                            for (int i = 0; i < lAlmacen.size(); i++) {
                                Almacen objAlmacen = (Almacen) lAlmacen.get(i);
                        %>
                        <tr>
                            <td><%=objAlmacen.getCodAlmacen()%></td>
                            <td><%=objAlmacen.getAlmacen()%></td>
                            <td><%=objAlmacen.getDireccion()%></td>
                            <td><%=objAlmacen.getDetalle()%></td>
                            <td style="text-align: center;">
                                <a href="../sAlamacen?accionAlmacen=a&codAlmacen=<%=objAlmacen.getCodAlmacen()%>" class="sexybutton sexyicononly"><span><span><span class="edit"></span></span></span></a>
                                <a href="../sAlamacen?accionAlmacen=d&codAlmacen=<%=objAlmacen.getCodAlmacen()%>" class="sexybutton sexyicononly"><span><span><span class="delete"></span></span></span></a>
                            </td>
                            <%
                                if (objUsuario.getP30()) {
                                    Usuario objUsuario1 = objcUsuario.leer_cod(Integer.parseInt(objAlmacen.getRegistro().substring(15, objAlmacen.getRegistro().length())));
                            %>
                            <td><%=objUsuario1.getUsuario()%></td>
                            <td><%=new cManejoFechas().fechaFormato(objAlmacen.getRegistro())%></td>
                            <td style="color: green"><%=objUsuario.getRegistro().substring(0, 1).equals("1") ? "Activo" : "Borrado"%></td>
                            <%
                                }
                            %>
                        </tr>
                        <%                        }
                        %>
                    </table>
                </div>
            </div>
            <div style="clear: both;"> </div>
            <div id="footer">
                <%@include file="../piePagina.jsp" %>
            </div>
        </div>
    </body>
</html>
<%    }
%>