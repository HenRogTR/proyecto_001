<%-- 
    Document   : nombresC
    Created on : 16/05/2013, 11:18:14 AM
    Author     : Henrri
--%>

<%@page import="tablas.Persona"%>
<%@page import="personaClases.cPersona"%>
<%@page import="personaClases.cDatosCliente"%>
<%@page import="tablas.DatosCliente"%>
<%@page import="otros.cUtilitarios"%>
<%@page import="java.util.Iterator"%>
<%@page import="java.util.List"%>
<%
    cUtilitarios objcUtilitarios = new cUtilitarios();
    cDatosCliente objcDatosCliente = new cDatosCliente();
    List lCliente = null;
    Persona objCobrador = null;
    cPersona objcPersona = new cPersona();
    int codCobrador = 0;
    try {
        codCobrador = Integer.parseInt(request.getParameter("codCobrador"));
        objCobrador = objcPersona.leer_cod(codCobrador);
        if (objCobrador == null) {
            out.print("No hay cobrador con ese codigo");
            return;
        }
        lCliente = objcDatosCliente.leer_codCobrador_ordenadoNombresC(codCobrador);
        if (lCliente == null) {
            out.print(objcDatosCliente.getError());
            return;
        }
    } catch (Exception e) {
        out.print("Error en parametros");
        return;
    }
%>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <title>Cartera clientes X Ape-Nombre <%=objcUtilitarios.fechaHoraActualNumerosLineal()%></title>
        <link rel="stylesheet" type="text/css" href="../../../lib/propios/css/paginaImprimir/bodyPrintHorizontal.css" media="screen"/>
        <link rel="stylesheet" type="text/css" href="../../../lib/propios/css/paginaImprimir/bodyPrintHorizontal.css" media="print"/>
        <link rel="stylesheet" type="text/css" href="../../../lib/propios/css/tablas/tablas-reportes.css" media="print"/>
        <link rel="stylesheet" type="text/css" href="../../../lib/propios/css/tablas/tablas-reportes.css" media="screen"/>
    </head>
    <body>
        <div id="documento">
            <div id="contenido">
                <table class="tabla-imprimir">
                    <thead>
                        <tr>
                            <th colspan="2">Cartera de clientes X Apellidos nombres :: C. <%=objCobrador.getNombres()%></th>
                            <th colspan="3"><%=objcUtilitarios.fechaHoraActual()%></th>
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
            </div>
        </div>
    </body>
</html>