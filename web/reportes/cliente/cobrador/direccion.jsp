<%-- 
    Document   : direccion
    Created on : 18/02/2014, 12:24:49 PM
    Author     : Henrri
--%>

<%@page import="personaClases.cPersona"%>
<%@page import="tablas.Persona"%>
<%@page import="utilitarios.cOtros"%>
<%@page import="tablas.DatosCliente"%>
<%@page import="java.util.Iterator"%>
<%@page import="java.util.List"%>
<%@page import="personaClases.cDatosCliente"%>
<%@page import="otros.cUtilitarios"%>
<%
    cUtilitarios objcUtilitarios = new cUtilitarios();
    List clienteList = null;
    Persona objCobrador = null;
    try {
        Integer codCobrador = Integer.parseInt(request.getParameter("codCobrador"));
        objCobrador = new cPersona().leer_cod(codCobrador);
        if (objCobrador == null) {
            out.print("Cobrador no encontrado.");
            return;
        }
        clienteList = new cDatosCliente().leer_codCobrador_ordenadoDireccion(codCobrador);
        if (clienteList == null) {
            out.print("Error en consulta.");
            return;
        }
    } catch (Exception e) {
        out.print("Error en paramámetros.");
        return;
    }
%>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <title>Cartera clientes X Dirección <%=objcUtilitarios.fechaHoraActualNumerosLineal()%></title>
        <link rel="stylesheet" type="text/css" href="../../../librerias/principal/bodyPrint.css" media="screen"/>
        <link rel="stylesheet" type="text/css" href="../../../librerias/principal/bodyPrint.css" media="print"/>
    </head>
    <body>
        <div id="documento" style="width: 1000px;">
            <div id="contenido">
                <table class="anchoTotal">
                    <thead>
                        <tr>
                            <th colspan="2">Cartera de clientes X Apellidos/nombres :: C. <%=objCobrador.getNombres()%></th>
                            <th colspan="3"><%=objcUtilitarios.fechaHoraActual()%></th>
                        </tr>
                        <tr class="top3 bottom2">
                            <th style="width: 70px;" class="centrado"><span>Código</span></th>
                            <th><span>Ape-Nombres/Razón Social</span></th>
                            <th style="width: 380px;"><span>Dirección</span></th>
                            <th style="width: 95px;"><span>Tipo</span></th>
                            <th style="width: 95px;"><span>Condición</span></th>
                        </tr>
                    </thead>
                    <tbody>
                        <%
                            for (Iterator it = clienteList.iterator(); it.hasNext();) {
                                DatosCliente objCliente = (DatosCliente) it.next();
                        %>
                        <tr>
                            <td>
                                <div style="padding:0px 5px 0px 5px;"><%=new cOtros().agregarCeros_int(objCliente.getCodDatosCliente(), 8)%></div>
                            </td>
                            <td>
                                <div style="padding:0px 5px 0px 5px;"><a href="../../sDatoCliente?accionDatoCliente=mantenimiento&codDatoCliente=<%=objCliente.getCodDatosCliente()%>" target="_blank"><%=objCliente.getPersona().getNombresC()%></a></div>
                            </td>
                            <td>
                                <div style="padding:0px 5px 0px 5px;"><%=objCliente.getPersona().getDireccion()%></div>
                            </td>
                            <td>
                                <div style="padding:0px 5px 0px 5px;"><%=new cDatosCliente().tipoCliente(objCliente.getTipo()).toUpperCase()%></div>
                            </td>
                            <td>
                                <div style="padding:0px 5px 0px 5px;"><%=new cDatosCliente().condicionCliente(objCliente.getCondicion()).toUpperCase()%></div>
                            </td>
                        </tr>
                        <%
                            }
                        %>
                        <tr class="top2">
                            <th></th>
                            <th></th>
                            <th><span>TOTAL CLIENTES:&nbsp;&nbsp;<%=clienteList.size()%></span> </th>
                            <th></th>
                            <th></th>
                        </tr>
                    </tbody>
                </table>
            </div>
        </div>
    </body>
</html>