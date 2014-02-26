<%-- 
    Document   : clienteCartera
    Created on : 24/02/2014, 09:53:48 AM
    Author     : Henrri
--%>

<%@page import="personaClases.cPersonal"%>
<%@page import="tablas.Personal"%>
<%@page import="utilitarios.cOtros"%>
<%@page import="tablas.DatosCliente"%>
<%@page import="java.util.Iterator"%>
<%@page import="utilitarios.cManejoFechas"%>
<%@page import="personaClases.cDatosCliente"%>
<%@page import="java.util.List"%>
<%
    List clienteList = null;
    String reporte = "";
    try {
        reporte = request.getParameter("reporte").toString();
    } catch (Exception e) {
        out.print("Reporte no encontrado.");
        return;
    }
    String tituloString = "C. clientes ";
    String cabeceraString = "";
    String orden = "";

    Integer codCobrador = 0;
    Personal objCobrador = null;
    if (reporte.equals("nombresC")) {
        clienteList = new cDatosCliente().leer_ordenadoNombresC();
        orden += "APELLIDOS-NOMBRES/RAZÓN SOCIAL ";
        tituloString += "(ape-nom/raz-soc) ";
    }
    if (reporte.equals("nombresC_Cobrador")) {
        try {
            codCobrador = Integer.parseInt(request.getParameter("codCobrador"));
            objCobrador = new cPersonal().leer_cobradorVendedor(codCobrador);
            if (objCobrador == null) {
                out.print("Cobrador no encontrado.");
                return;
            }
            clienteList = new cDatosCliente().leer_codCobrador_ordenadoNombresC(codCobrador);
            orden += "APELLIDOS-NOMBRES/RAZÓN SOCIAL ";
            cabeceraString = "<tr><th colspan=\"2\">Cobrador: " + objCobrador.getPersona().getNombres() + "</th></tr>";
        } catch (Exception e) {
            out.print("Parámetro codcobrador no encontrado");
            return;
        }
    }
    if (reporte.equals("direccion_Cobrador")) {
        try {
            codCobrador = Integer.parseInt(request.getParameter("codCobrador"));
            objCobrador = new cPersonal().leer_cobradorVendedor(codCobrador);
            if (objCobrador == null) {
                out.print("Cobrador no encontrado.");
                return;
            }
            clienteList = new cDatosCliente().leer_codCobrador_ordenadoDireccion(codCobrador);
            orden += "DIRECCIÓN ";
            cabeceraString = "<tr><th colspan=\"2\">Cobrador: " + objCobrador.getPersona().getNombres() + "</th></tr>";
        } catch (Exception e) {
            out.print("Parámetro codcobrador no encontrado");
            return;
        }
    }
    if (reporte.equals("direccion")) {
        clienteList = new cDatosCliente().leer_ordenadoDireccion();
        orden += "DIRECCIÓN ";
        tituloString += "(dirección) ";
    }
    if (clienteList == null) {
        out.print("lista -> null.");
        return;
    }
    tituloString += new cManejoFechas().fechaHoraActualNumerosLineal() + " ";
%>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <title><%=tituloString%></title>
        <link rel="stylesheet" type="text/css" href="../../librerias/principal/bodyPrint.css" media="screen"/>
        <link rel="stylesheet" type="text/css" href="../../librerias/principal/bodyPrint.css" media="print"/>
    </head>
    <body>
        <div id="documento" style="width: 1000px;">
            <div id="contenido">
                <table class="anchoTotal">
                    <thead>
                        <tr>
                            <th colspan="2">CARTERA CLIENTE :: <%=orden%></th>
                            <th colspan="3"><%=new cManejoFechas().fechaHoraActual()%></th>
                        </tr>
                        <%=cabeceraString%>
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
