<%-- 
    Document   : clienteCartera
    Created on : 24/02/2014, 09:53:48 AM
    Author     : Henrri
--%>

<%@page import="personaClases.cEmpresaConvenio"%>
<%@page import="tablas.EmpresaConvenio"%>
<%@page import="personaClases.cPersonal"%>
<%@page import="tablas.Personal"%>
<%@page import="utilitarios.cOtros"%>
<%@page import="tablas.DatosCliente"%>
<%@page import="java.util.Iterator"%>
<%@page import="utilitarios.cManejoFechas"%>
<%@page import="personaClases.cDatosCliente"%>
<%@page import="java.util.List"%>
<%    
    String reporte = "";
    try {
        reporte = request.getParameter("reporte").toString();
    } catch (Exception e) {
        out.print("Parámetro reporte no encontrado.");
        return;
    }
    String tituloString = "C. clientes ";
    String cabeceraString = "";
    String orden = "";

    List clienteList = null;
    Integer codCobradorInteger = 0;
    Personal objCobrador = null;
    Integer codECInteger = 0;
    EmpresaConvenio objEC = null;
    Integer tipoInteger = 0;
    Integer condicionInteger = 0;
    // -> N 1
    if (reporte.equals("nombresC_todos")) {                                     //1-1
        clienteList = new cDatosCliente().leer_ordenadoNombresC();
        orden += "APELLIDOS-NOMBRES/RAZÓN SOCIAL ";
        tituloString += "(ape-nom/raz-soc) ";
    }
    if (reporte.equals("nombresC_cobrador")) {                                  //1-2
        try {
            codCobradorInteger = Integer.parseInt(request.getParameter("codCobrador"));
            objCobrador = new cPersonal().leer_cobradorVendedor(codCobradorInteger);
            if (objCobrador == null) {
                out.print("Cobrador no encontrado.");
                return;
            }
            clienteList = new cDatosCliente().leer_codCobrador_ordenadoNombresC(codCobradorInteger);
            orden += "APELLIDOS-NOMBRES/RAZÓN SOCIAL ";
            cabeceraString = "<tr><th colspan=\"2\">Cobrador: " + objCobrador.getPersona().getNombres() + "</th></tr>";
        } catch (Exception e) {
            out.print("Código de cobrador no encontrado");
            return;
        }
    }
    if (reporte.equals("direccion_todos")) {                                    //1-3
        clienteList = new cDatosCliente().leer_ordenadoDireccion();
        orden += "DIRECCIÓN ";
        tituloString += "(dirección) ";
    }
    if (reporte.equals("direccion_cobrador")) {                                 //1-4
        try {
            codCobradorInteger = Integer.parseInt(request.getParameter("codCobrador"));
            objCobrador = new cPersonal().leer_cobradorVendedor(codCobradorInteger);
            if (objCobrador == null) {
                out.print("Cobrador no encontrado.");
                return;
            }
            clienteList = new cDatosCliente().leer_codCobrador_ordenadoDireccion(codCobradorInteger);
            orden += "DIRECCIÓN ";
            cabeceraString = "<tr><th colspan=\"2\">Cobrador: " + objCobrador.getPersona().getNombres() + "</th></tr>";
        } catch (Exception e) {
            out.print("Código de cobrador no encontrado");
            return;
        }
    }
    // <- N 1
    // -> N 2
    if (reporte.equals("nombresC_EC_todos")) {                                  //2-1
        try {
            codECInteger = Integer.parseInt(request.getParameter("codEC"));
            objEC = new cEmpresaConvenio().leer_cod(codECInteger);
            if (objEC == null) {
                out.print("Empresa no encontrada");
                return;
            }
            clienteList = new cDatosCliente().leer_empresaConvenio_ordenNombresC(codECInteger);
            orden += "APELLIDOS-NOMBRES/RAZÓN SOCIAL ";
            cabeceraString = "<tr><th colspan=\"2\">EMPRESA/CONVENIO: " + objEC.getNombre() + "</th></tr>";
        } catch (Exception e) {
            out.print("Código de cobrador y/o empresa no encontrado");
            return;
        }
    }
    if (reporte.equals("nombresC_EC_cobrador")) {                               //2-2
        try {
            codCobradorInteger = Integer.parseInt(request.getParameter("codCobrador"));
            objCobrador = new cPersonal().leer_cobradorVendedor(codCobradorInteger);
            if (objCobrador == null) {
                out.print("Cobrador no encontrado.");
                return;
            }
            codECInteger = Integer.parseInt(request.getParameter("codEC"));
            objEC = new cEmpresaConvenio().leer_cod(codECInteger);
            if (objEC == null) {
                out.print("Empresa no encontrada");
                return;
            }
            clienteList = new cDatosCliente().leer_codCobrador_empresaConvenio_ordenNombresC(codECInteger, codCobradorInteger);
            orden += "APELLIDOS-NOMBRES/RAZÓN SOCIAL ";
            cabeceraString = "<tr><th colspan=\"2\">EMPRESA/CONVENIO: " + objEC.getNombre() + "</th></tr>";
            cabeceraString += "<tr><th colspan=\"2\">COBRADOR: " + objCobrador.getPersona().getNombres() + "</th></tr>";
        } catch (Exception e) {
            out.print("Código de cobrador y/o empresa no encontrado");
            return;
        }
    }
    if (reporte.equals("direccion_EC_todos")) {                                  //2-3
        try {
            codECInteger = Integer.parseInt(request.getParameter("codEC"));
            objEC = new cEmpresaConvenio().leer_cod(codECInteger);
            if (objEC == null) {
                out.print("Empresa no encontrada");
                return;
            }
            clienteList = new cDatosCliente().leer_empresaConvenio_ordenDireccion(codECInteger);
            orden += "DIRECCIÓN ";
            cabeceraString = "<tr><th colspan=\"2\">EMPRESA/CONVENIO: " + objEC.getNombre() + "</th></tr>";
        } catch (Exception e) {
            out.print("Código de cobrador y/o empresa no encontrado");
            return;
        }
    }
    if (reporte.equals("direccion_EC_cobrador")) {                              //2-4
        try {
            codCobradorInteger = Integer.parseInt(request.getParameter("codCobrador"));
            objCobrador = new cPersonal().leer_cobradorVendedor(codCobradorInteger);
            if (objCobrador == null) {
                out.print("Cobrador no encontrado.");
                return;
            }
            codECInteger = Integer.parseInt(request.getParameter("codEC"));
            objEC = new cEmpresaConvenio().leer_cod(codECInteger);
            if (objEC == null) {
                out.print("Empresa no encontrada");
                return;
            }
            clienteList = new cDatosCliente().leer_codCobrador_empresaConvenio_ordenNombresC(codECInteger, codCobradorInteger);
            orden += "DIRECCIÓN ";
            cabeceraString = "<tr><th colspan=\"2\">EMPRESA/CONVENIO: " + objEC.getNombre() + "</th></tr>";
            cabeceraString += "<tr><th colspan=\"2\">COBRADOR: " + objCobrador.getPersona().getNombres() + "</th></tr>";
        } catch (Exception e) {
            out.print("Código de cobrador y/o empresa no encontrado");
            return;
        }
    }
    // <- N 2
    // -> N 3
    if (reporte.equals("nombresC_EC_tipo_todos")) {                             //3-1
        try {
            codECInteger = Integer.parseInt(request.getParameter("codEC"));
            objEC = new cEmpresaConvenio().leer_cod(codECInteger);
            if (objEC == null) {
                out.print("Empresa no encontrada");
                return;
            }
            tipoInteger = Integer.parseInt(request.getParameter("tipo"));
            clienteList = new cDatosCliente().leer_empresaConvenio_tipo_ordenNombresC(codECInteger, tipoInteger);
            orden += "APELLIDOS-NOMBRES/RAZÓN SOCIAL ";
            cabeceraString = "<tr><th colspan=\"2\">EMPRESA/CONVENIO: " + objEC.getNombre() + "</th></tr>";
            cabeceraString += "<tr><th colspan=\"2\">TIPO: " + new cDatosCliente().tipoCliente(tipoInteger) + "</th></tr>";
        } catch (Exception e) {
            out.print("Código de empresa y/o tipo no encontrado");
            return;
        }
    }
    if (reporte.equals("nombresC_EC_tipo_cobrador")) {                          //3-2
        try {
            codECInteger = Integer.parseInt(request.getParameter("codEC"));
            objEC = new cEmpresaConvenio().leer_cod(codECInteger);
            if (objEC == null) {
                out.print("Empresa no encontrada");
                return;
            }
            codCobradorInteger = Integer.parseInt(request.getParameter("codCobrador"));
            objCobrador = new cPersonal().leer_cobradorVendedor(codCobradorInteger);
            if (objCobrador == null) {
                out.print("Cobrador no encontrado.");
                return;
            }
            tipoInteger = Integer.parseInt(request.getParameter("tipo"));
            //clienteList = new cDatosCliente().leer_empresaConvenio_tipo_ordenNombresC(codECInteger, tipoInteger);
            orden += "APELLIDOS-NOMBRES/RAZÓN SOCIAL ";
            cabeceraString = "<tr><th colspan=\"2\">EMPRESA/CONVENIO: " + objEC.getNombre() + "</th></tr>";
            cabeceraString += "<tr><th colspan=\"2\">TIPO: " + new cDatosCliente().tipoCliente(tipoInteger) + "</th></tr>";
            cabeceraString += "<tr><th colspan=\"2\">COBRADOR: " + objCobrador.getPersona().getNombres() + "</th></tr>";
        } catch (Exception e) {
            out.print("Código de empresa y/o tipo no encontrado");
            return;
        }
    }
    if (reporte.equals("direccion_EC_tipo_todos")) {                            //3-3
        try {
            codECInteger = Integer.parseInt(request.getParameter("codEC"));
            objEC = new cEmpresaConvenio().leer_cod(codECInteger);
            if (objEC == null) {
                out.print("Empresa no encontrada");
                return;
            }
            tipoInteger = Integer.parseInt(request.getParameter("tipo"));
            clienteList = new cDatosCliente().leer_empresaConvenio_tipo_ordenDireccion(codECInteger, tipoInteger);
            orden += "DIRECCIÓN ";
            cabeceraString = "<tr><th colspan=\"2\">EMPRESA/CONVENIO: " + objEC.getNombre() + "</th></tr>";
            cabeceraString += "<tr><th colspan=\"2\">TIPO: " + new cDatosCliente().tipoCliente(tipoInteger) + "</th></tr>";
        } catch (Exception e) {
            out.print("Código de empresa y/o tipo no encontrado");
            return;
        }
    }
    if (reporte.equals("direcion_EC_tipo_cobrador")) {                          //3-4
        try {
            codECInteger = Integer.parseInt(request.getParameter("codEC"));
            objEC = new cEmpresaConvenio().leer_cod(codECInteger);
            if (objEC == null) {
                out.print("Empresa no encontrada");
                return;
            }
            codCobradorInteger = Integer.parseInt(request.getParameter("codCobrador"));
            objCobrador = new cPersonal().leer_cobradorVendedor(codCobradorInteger);
            if (objCobrador == null) {
                out.print("Cobrador no encontrado.");
                return;
            }
            tipoInteger = Integer.parseInt(request.getParameter("tipo"));
            //clienteList = new cDatosCliente().leer_empresaConvenio_tipo_ordenNombresC(codECInteger, tipoInteger);
            orden += "DIRECCIÓN ";
            cabeceraString = "<tr><th colspan=\"2\">EMPRESA/CONVENIO: " + objEC.getNombre() + "</th></tr>";
            cabeceraString += "<tr><th colspan=\"2\">TIPO: " + new cDatosCliente().tipoCliente(tipoInteger) + "</th></tr>";
            cabeceraString += "<tr><th colspan=\"2\">COBRADOR: " + objCobrador.getPersona().getNombres() + "</th></tr>";
        } catch (Exception e) {
            out.print("Código de empresa y/o tipo no encontrado");
            return;
        }
    }
    // <- N 3
    // -> N 4
    if (reporte.equals("nombresC_EC_tipo_condicion_todos")) {                   //4-1
        try {
            codECInteger = Integer.parseInt(request.getParameter("codEC"));
            objEC = new cEmpresaConvenio().leer_cod(codECInteger);
            if (objEC == null) {
                out.print("Empresa no encontrada");
                return;
            }
            tipoInteger = Integer.parseInt(request.getParameter("tipo"));
            condicionInteger = Integer.parseInt(request.getParameter("condicion"));
            clienteList = new cDatosCliente().leer_empresaConvenio_tipo_condicion_ordenNombresC(codECInteger, tipoInteger, condicionInteger);
            orden += "APELLIDOS-NOMBRES/RAZÓN SOCIAL ";
            cabeceraString = "<tr><th colspan=\"2\">EMPRESA/CONVENIO: " + objEC.getNombre() + "</th></tr>";
            cabeceraString += "<tr><th colspan=\"2\">TIPO: " + new cDatosCliente().tipoCliente(tipoInteger) + " / CONDICIÓN: " + new cDatosCliente().condicionCliente(condicionInteger) + "</th></tr>";
        } catch (Exception e) {
            out.print("Código de empresa y/o tipo no encontrado");
            return;
        }
    }
    if (reporte.equals("direccion_EC_tipo_condicion_todos")) {                  //4-2
        try {
            codECInteger = Integer.parseInt(request.getParameter("codEC"));
            objEC = new cEmpresaConvenio().leer_cod(codECInteger);
            if (objEC == null) {
                out.print("Empresa no encontrada");
                return;
            }
            tipoInteger = Integer.parseInt(request.getParameter("tipo"));
            condicionInteger = Integer.parseInt(request.getParameter("condicion"));
            clienteList = new cDatosCliente().leer_empresaConvenio_tipo_condicion_ordenDireccion(codECInteger, tipoInteger, condicionInteger);
            orden += "DIRECCIÓN ";
            cabeceraString = "<tr><th colspan=\"2\">EMPRESA/CONVENIO: " + objEC.getNombre() + "</th></tr>";
            cabeceraString += "<tr><th colspan=\"2\">TIPO: " + new cDatosCliente().tipoCliente(tipoInteger) + " / CONDICIÓN: " + new cDatosCliente().condicionCliente(condicionInteger) + "</th></tr>";
        } catch (Exception e) {
            out.print("Código de empresa y/o tipo no encontrado");
            return;
        }
    }
    // <- N 4
    if (clienteList == null) {
        out.print(reporte + " lista -> null.");
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
                            <th colspan="2">CARTERA DE CLIENTES X <%=orden%></th>
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
