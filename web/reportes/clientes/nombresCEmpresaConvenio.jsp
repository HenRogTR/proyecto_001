<%-- 
    Document   : nombresCEmpresaConvenio
    Created on : 17/05/2013, 04:43:38 PM
    Author     : Henrri
--%>

<%@page import="personaClases.cEmpresaConvenio"%>
<%@page import="tablas.EmpresaConvenio"%>
<%@page import="personaClases.cDatosCliente"%>
<%@page import="tablas.DatosCliente"%>
<%@page import="otros.cUtilitarios"%>
<%@page import="java.util.Iterator"%>
<%@page import="java.util.List"%>
<%
    boolean estado = true;
    String mensaje = "";
    EmpresaConvenio objEmpresaConvenio = new EmpresaConvenio();
    cDatosCliente objcDatosCliente = new cDatosCliente();
    List lCliente = null;
    try {
        int codEmpresaConvenio = Integer.parseInt(request.getParameter("codEmpresaConvenio"));
        objEmpresaConvenio = new cEmpresaConvenio().leer_cod(codEmpresaConvenio);
        if (objEmpresaConvenio == null) {
            estado = false;
            mensaje = "No hay empresa con ese parametro";
        }
        lCliente = objcDatosCliente.leer_empresaConvenio_ordenNombresC(codEmpresaConvenio);
        if (lCliente == null) {
            estado = false;
            mensaje = objcDatosCliente.getError();
        }
    } catch (Exception e) {
        estado = false;
        mensaje = e.getMessage();
        //La cadena n
    }
    cUtilitarios objcUtilitarios = new cUtilitarios();
%>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <title>Cartera clientes X Ape-Nombre <%=objcUtilitarios.fechaHoraActualNumerosLineal()%></title>
        <link rel="stylesheet" type="text/css" href="../../lib/propios/css/paginaImprimir/bodyPrintHorizontal.css" media="screen"/>
        <link rel="stylesheet" type="text/css" href="../../lib/propios/css/paginaImprimir/bodyPrintHorizontal.css" media="print"/>
        <link rel="stylesheet" type="text/css" href="../../lib/propios/css/tablas/tablas-reportes.css" media="print"/>
        <link rel="stylesheet" type="text/css" href="../../lib/propios/css/tablas/tablas-reportes.css" media="screen"/>
        <script type="text/javascript" src="../../lib/jquery/jquery-1.8.1.min.js"></script>
    </head>
    <body>
        <div id="documento">
            <div id="contenido">
                <%
                    if (estado) {
                %>
                <table class="tabla-imprimir">
                    <thead>
                        <tr>
                            <th colspan="2">Cartera de clientes X Apellidos nombres</th>
                            <th colspan="3"><%=objcUtilitarios.fechaHoraActual()%></th>
                        </tr>
                        <tr>
                            <th colspan="5"><%=objEmpresaConvenio.getNombre()%></th>
                        </tr>
                        <tr class="top3 bottom2">
                            <th style="width: 80px;text-align: center;"><label>Código</label></th>
                            <th style="width: 350px;"><label>Ape-Nombres/Razón Social</label></th>                                
                            <th style="width: 350px;"><label>Direccion</label></th>
                            <th style="width: 100px;"><label>Tipo</label></th>
                            <th><label>Condición</label></th>
                        </tr>
                    </thead>
                    <tbody>
                        <%
                            Iterator iCliente = lCliente.iterator();
                            while (iCliente.hasNext()) {
                                DatosCliente objDatosCliente = (DatosCliente) iCliente.next();
                        %>
                        <tr>
                            <td style="text-align: right; padding-right: 15px;"><%=objcUtilitarios.agregarCeros_int(objDatosCliente.getPersona().getCodPersona(), 8)%></td>
                            <td><%=objDatosCliente.getPersona().getNombresC()%></td>
                            <td><%=objDatosCliente.getPersona().getDireccion()%></td>
                            <td><%=objcDatosCliente.tipoCliente(objDatosCliente.getTipo())%></td>
                            <td><%=objcDatosCliente.condicionCliente(objDatosCliente.getCondicion())%></td>
                        </tr>
                        <%
                            }
                        %>
                        <tr class="top2">
                            <th></th>
                            <th></th>
                            <th><label>TOTAL CLIENTES:&nbsp;&nbsp;<%=lCliente.size()%></label> </th>
                            <th></th>
                            <th></th>
                        </tr>
                    </tbody>
                </table>
                <%
                    } else {
                        out.print(mensaje);
                    }
                %>
            </div>
        </div>
    </body>
</html>