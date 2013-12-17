<%-- 
    Document   : areaListar
    Created on : 26/11/2012, 12:10:47 PM
    Author     : Henrri
--%>

<%@page import="tablas.Area"%>
<%@page import="personaClases.cArea"%>
<%@page import="java.util.Iterator"%>
<%@page import="java.util.List"%>
<%@page import="tablas.Usuario"%>
<%
    Usuario objUsuario = (Usuario) session.getAttribute("usuario");
    if (objUsuario == null) {
        session.removeAttribute("direccion");
        session.setAttribute("direccion", "persona/areaListar.jsp");
        session.setAttribute("error", "Inicie sesión");
        response.sendRedirect("../index.jsp");
    } else {
%>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <title>Áreas</title>
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
                <%
                    cArea objcArea = new cArea();

                    String accion = request.getParameter("txtAccion");
                    int codArea;
                    if (accion == null) {
                        accion = "l";
                    }
                    if (accion.equals("e")) {
                        codArea = Integer.parseInt(request.getParameter("codArea"));
                        if (objcArea.actualizar_registro(1, "1", "1")) {
                        } else {
                            out.print(objcArea.getError());
                            out.println("sdsd" + codArea);
                        }
                    }

                    List lArea = objcArea.leer();
                    Iterator iArea = lArea.iterator();
                %>
                <h3 class="titulo">MANTENIEMIENTO DE ÁREAS &nbsp; <a class="sexybutton sexyicononly personal" href="../sArea?accionArea=r" title="Nuevo"><span><span><span class="add"></span></span></span></a>  </h3>
                <table class="tinytable">
                    <thead>
                        <tr>
                            <th><label>Código</label></th>
                            <th><label>Nombre</label></th>
                            <th><label>Descripcion</label></th>
                            <th><label>Opción</label></th>
                        </tr>
                    </thead>
                    <tbody>
                        <%
                            while (iArea.hasNext()) {
                                Area objArea = (Area) iArea.next();
                        %>
                        <tr>
                            <td><label><%=objArea.getCodArea()%></label></td>
                            <td><label><%=objArea.getArea()%></label></td>
                            <td><label><%=objArea.getDetalle()%></label></td>
                            <td>
                                <a class="sexybutton sexyicononly personal" href="../sArea?accion=a&codArea=<%=objArea.getCodArea()%>" title="Editar"><span><span><span class="edit"></span></span></span></a>  
                                <a class="sexybutton sexyicononly personal" href="../sArea?accion=d&codArea=<%=objArea.getCodArea()%>" title="Eliminar"><span><span><span class="delete"></span></span></span></a>  
                            </td>
                        </tr>
                        <%
                            }
                        %>               
                    </tbody>
                </table>
                <!--</fieldset>-->
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