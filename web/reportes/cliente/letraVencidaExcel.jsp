<%-- 
    Document   : letraVencidaExcel
    Created on : 05/03/2014, 10:52:06 AM
    Author     : Henrri
--%>

<%@page import="otrasTablasClases.cDatosExtras"%>
<%@page import="personaClases.cDatosCliente"%>
<%@page import="personaClases.cEmpresaConvenio"%>
<%@page import="personaClases.cPersonal"%>
<%@page import="ventaClases.cVentaCreditoLetraReporte"%>
<%@page import="tablas.EmpresaConvenio"%>
<%@page import="utilitarios.cOtros"%>
<%@page import="java.util.Iterator"%>
<%@page import="utilitarios.cManejoFechas"%>
<%@page import="utilitarios.cValidacion"%>
<%@page import="tablas.Personal"%>
<%@page import="java.util.List"%>
<%@page import="java.util.Date"%>
<%
    String reporte = "";
    try {
        reporte = request.getParameter("reporte").toString();
    } catch (Exception e) {
        out.print("Reporte no definido.");
        return;
    }
    String titleString = "";
    String cabeceraString = "";

    String orden = "";
    String fechaString = "";
    Date fechaDate = null;
    List LVList = null;

    Integer codCobradorInteger = 0;
    Personal objCobrador = null;
    Integer codECInteger = 0;
    EmpresaConvenio objEC = null;
    Integer tipoInteger = 0;
    Integer condicionInteger = 0;
    try {
        fechaString = request.getParameter("fechaVencimiento").toString();
        if (!new cValidacion().validarFecha(fechaString)) {
            out.print("Fecha y/o formato de fecha incorrecta.");
            return;
        }
        fechaDate = new cManejoFechas().StringADate(fechaString);
    } catch (Exception e) {
        out.print("Fecha de vencimiento no encontrada.");
        return;
    }

    //========================== 1 nivel =======================================
    if (reporte.equals("nombresC_todos")) {
        LVList = new cVentaCreditoLetraReporte().letrasVencidas_todos_ordenNombresC_SC(fechaDate);
        orden += "APELLIDOS-NOMBRES/RAZÓN SOCIAL ";
    }
    if (reporte.equals("nombresC_cobrador")) {
        try {
            codCobradorInteger = Integer.parseInt(request.getParameter("codCobrador"));
            objCobrador = new cPersonal().leer_cobradorVendedor(codCobradorInteger);
            if (objCobrador == null) {
                out.print("Cobrador no encontrado.");
                return;
            }
            LVList = new cVentaCreditoLetraReporte().letrasVencidas_cobrador_ordenNombresC_SC(fechaDate, codCobradorInteger);
            orden += "APELLIDOS-NOMBRES/RAZÓN SOCIAL ";
            cabeceraString += "<tr><th colspan=\"2\">COBRADOR: " + objCobrador.getPersona().getNombres() + "</th></tr>";
        } catch (Exception e) {
            out.print("Código de cobrador no encontrado");
            return;
        }
    }
    if (reporte.equals("direccion_todos")) {
        LVList = new cVentaCreditoLetraReporte().letrasVencidas_todos_ordenDireccion_SC(fechaDate);
        orden += "DIRECCIÓN ";
    }
    if (reporte.equals("direccion_cobrador")) {
        try {
            codCobradorInteger = Integer.parseInt(request.getParameter("codCobrador"));
            objCobrador = new cPersonal().leer_cobradorVendedor(codCobradorInteger);
            if (objCobrador == null) {
                out.print("Cobrador no encontrado.");
                return;
            }
            LVList = new cVentaCreditoLetraReporte().letrasVencidas_cobrador_ordenDireccion_SC(fechaDate, codCobradorInteger);
            orden += "DIRECCIÓN ";
            cabeceraString += "<tr><th colspan=\"2\">COBRADOR: " + objCobrador.getPersona().getNombres() + "</th></tr>";
        } catch (Exception e) {
            out.print("Código de cobrador no encontrado");
            return;
        }
    }
    //========================== 2 nivel Empresa/Convenio ======================
    if (reporte.equals("nombresC_EC_todos")) {                                  //2-1
        try {
            codECInteger = Integer.parseInt(request.getParameter("codEC"));
            objEC = new cEmpresaConvenio().leer_cod(codECInteger);
            if (objEC == null) {
                out.print("Empresa no encontrada");
                return;
            }
            LVList = new cVentaCreditoLetraReporte().letrasVencidas_empresaConvenio_todos_ordenNombresC_SC(fechaDate, codECInteger);
            orden += "APELLIDOS-NOMBRES/RAZÓN SOCIAL ";
            cabeceraString = "<tr><th colspan=\"2\">EMPRESA/CONVENIO: " + objEC.getNombre() + "</th></tr>";
        } catch (Exception e) {
            out.print("Código de cobrador y/o empresa no encontrado");
            return;
        }
    }
    if (reporte.equals("direccion_EC_todos")) {                                 //2-1
        try {
            codECInteger = Integer.parseInt(request.getParameter("codEC"));
            objEC = new cEmpresaConvenio().leer_cod(codECInteger);
            if (objEC == null) {
                out.print("Empresa no encontrada");
                return;
            }
            LVList = new cVentaCreditoLetraReporte().letrasVencidas_empresaConvenio_todos_ordenDireccion_SC(fechaDate, codECInteger);
            orden += "DIRECCIÓN ";
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
            LVList = new cVentaCreditoLetraReporte().letrasVencidas_empresaConvenio_cobrador_ordenNombresC_SC(fechaDate, codECInteger, codCobradorInteger);
            orden += "APELLIDOS-NOMBRES/RAZÓN SOCIAL ";
            cabeceraString = "<tr><th colspan=\"2\">EMPRESA/CONVENIO: " + objEC.getNombre() + "</th></tr>";
            cabeceraString += "<tr><th colspan=\"2\">COBRADOR: " + objCobrador.getPersona().getNombres() + "</th></tr>";
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
            LVList = new cVentaCreditoLetraReporte().letrasVencidas_empresaConvenio_cobrador_ordenDireccion_SC(fechaDate, codECInteger, codCobradorInteger);
            orden += "DIRECCIÓN ";
            cabeceraString = "<tr><th colspan=\"2\">EMPRESA/CONVENIO: " + objEC.getNombre() + "</th></tr>";
            cabeceraString += "<tr><th colspan=\"2\">COBRADOR: " + objCobrador.getPersona().getNombres() + "</th></tr>";
        } catch (Exception e) {
            out.print("Código de cobrador y/o empresa no encontrado");
            return;
        }
    }

    //========================== 3 nivel Empresa/Convenio-Tipo =================
    if (reporte.equals("nombresC_EC_tipo_todos")) {                                  //3-1
        try {
            codECInteger = Integer.parseInt(request.getParameter("codEC"));
            objEC = new cEmpresaConvenio().leer_cod(codECInteger);
            if (objEC == null) {
                out.print("Empresa no encontrada");
                return;
            }
            tipoInteger = Integer.parseInt(request.getParameter("tipo"));
            LVList = new cVentaCreditoLetraReporte().letrasVencidas_empresaConvenio_tipo_todos_ordenNombresC_SC(fechaDate, codECInteger, tipoInteger);
            orden += "APELLIDOS-NOMBRES/RAZÓN SOCIAL ";
            cabeceraString = "<tr><th colspan=\"2\">EMPRESA/CONVENIO: " + objEC.getNombre() + "</th></tr>";
            cabeceraString += "<tr><th colspan=\"2\">TIPO: " + new cDatosCliente().tipoCliente(tipoInteger) + "</th></tr>";
        } catch (Exception e) {
            out.print("Código de cobrador y/o empresa no encontrado");
            return;
        }
    }
    if (reporte.equals("direccion_EC_tipo_todos")) {                                 //3-2
        try {
            codECInteger = Integer.parseInt(request.getParameter("codEC"));
            objEC = new cEmpresaConvenio().leer_cod(codECInteger);
            if (objEC == null) {
                out.print("Empresa no encontrada");
                return;
            }
            tipoInteger = Integer.parseInt(request.getParameter("tipo"));
            LVList = new cVentaCreditoLetraReporte().letrasVencidas_empresaConvenio_tipo_todos_ordenDireccion_SC(fechaDate, codECInteger, tipoInteger);
            orden += "DIRECCIÓN ";
            cabeceraString = "<tr><th colspan=\"2\">EMPRESA/CONVENIO: " + objEC.getNombre() + "</th></tr>";
            cabeceraString += "<tr><th colspan=\"2\">TIPO: " + new cDatosCliente().tipoCliente(tipoInteger) + "</th></tr>";
        } catch (Exception e) {
            out.print("Código de cobrador y/o empresa no encontrado");
            return;
        }
    }
    if (reporte.equals("nombresC_EC_tipo_cobrador")) {                               //3-3
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
            tipoInteger = Integer.parseInt(request.getParameter("tipo"));
            LVList = new cVentaCreditoLetraReporte().letrasVencidas_empresaConvenio_tipo_cobrador_ordenNombresC_SC(fechaDate, codECInteger, tipoInteger, codCobradorInteger);
            orden += "APELLIDOS-NOMBRES/RAZÓN SOCIAL ";
            cabeceraString = "<tr><th colspan=\"2\">EMPRESA/CONVENIO: " + objEC.getNombre() + "</th></tr>";
            cabeceraString += "<tr><th colspan=\"2\">TIPO: " + new cDatosCliente().tipoCliente(tipoInteger) + "</th></tr>";
            cabeceraString += "<tr><th colspan=\"2\">COBRADOR: " + objCobrador.getPersona().getNombres() + "</th></tr>";
        } catch (Exception e) {
            out.print("Código de cobrador y/o empresa no encontrado");
            return;
        }
    }
    if (reporte.equals("direccion_EC_tipo_cobrador")) {                              //3-4
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
            tipoInteger = Integer.parseInt(request.getParameter("tipo"));
            LVList = new cVentaCreditoLetraReporte().letrasVencidas_empresaConvenio_tipo_cobrador_ordenDireccion_SC(fechaDate, codECInteger, tipoInteger, codCobradorInteger);
            orden += "DIRECCIÓN ";
            cabeceraString = "<tr><th colspan=\"2\">EMPRESA/CONVENIO: " + objEC.getNombre() + "</th></tr>";
            cabeceraString += "<tr><th colspan=\"2\">TIPO: " + new cDatosCliente().tipoCliente(tipoInteger) + "</th></tr>";
            cabeceraString += "<tr><th colspan=\"2\">COBRADOR: " + objCobrador.getPersona().getNombres() + "</th></tr>";
        } catch (Exception e) {
            out.print("Código de cobrador y/o empresa no encontrado");
            return;
        }
    }
    //===================== 4 nivel Empresa/Convenio-Tipo-Condición=============
    if (reporte.equals("nombresC_EC_tipo_condicion_todos")) {                                  //4-1
        try {
            codECInteger = Integer.parseInt(request.getParameter("codEC"));
            objEC = new cEmpresaConvenio().leer_cod(codECInteger);
            if (objEC == null) {
                out.print("Empresa no encontrada");
                return;
            }
            tipoInteger = Integer.parseInt(request.getParameter("tipo"));
            condicionInteger = Integer.parseInt(request.getParameter("condicion"));
            LVList = new cVentaCreditoLetraReporte().letrasVencidas_empresaConvenio_tipo_condicion_todos_ordenNombresC_SC(fechaDate, codECInteger, tipoInteger, condicionInteger);
            orden += "APELLIDOS-NOMBRES/RAZÓN SOCIAL ";
            cabeceraString = "<tr><th colspan=\"2\">EMPRESA/CONVENIO: " + objEC.getNombre() + "</th></tr>";
            cabeceraString += "<tr><th colspan=\"2\">TIPO: " + new cDatosCliente().tipoCliente(tipoInteger) + " / CONDICIÓN: " + new cDatosCliente().condicionCliente(condicionInteger) + "</th></tr>";
        } catch (Exception e) {
            out.print("Código de cobrador y/o empresa no encontrado");
            return;
        }
    }
    if (reporte.equals("direccion_EC_tipo_condicion_todos")) {                                 //4-2
        try {
            codECInteger = Integer.parseInt(request.getParameter("codEC"));
            objEC = new cEmpresaConvenio().leer_cod(codECInteger);
            if (objEC == null) {
                out.print("Empresa no encontrada");
                return;
            }
            tipoInteger = Integer.parseInt(request.getParameter("tipo"));
            condicionInteger = Integer.parseInt(request.getParameter("condicion"));
            LVList = new cVentaCreditoLetraReporte().letrasVencidas_empresaConvenio_tipo_condicion_todos_ordenDireccion_SC(fechaDate, codECInteger, tipoInteger, condicionInteger);
            orden += "DIRECCIÓN ";
            cabeceraString = "<tr><th colspan=\"2\">EMPRESA/CONVENIO: " + objEC.getNombre() + "</th></tr>";
            cabeceraString += "<tr><th colspan=\"2\">TIPO: " + new cDatosCliente().tipoCliente(tipoInteger) + " / CONDICIÓN: " + new cDatosCliente().condicionCliente(condicionInteger) + "</th></tr>";
        } catch (Exception e) {
            out.print("Código de cobrador y/o empresa no encontrado");
            return;
        }
    }
    if (reporte.equals("nombresC_EC_tipo_condicion_cobrador")) {                               //4-3
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
            tipoInteger = Integer.parseInt(request.getParameter("tipo"));
            condicionInteger = Integer.parseInt(request.getParameter("condicion"));
            LVList = new cVentaCreditoLetraReporte().letrasVencidas_empresaConvenio_tipo_condicion_cobrador_ordenNombresC_SC(fechaDate, codECInteger, tipoInteger, condicionInteger, codCobradorInteger);
            orden += "APELLIDOS-NOMBRES/RAZÓN SOCIAL ";
            cabeceraString = "<tr><th colspan=\"2\">EMPRESA/CONVENIO: " + objEC.getNombre() + "</th></tr>";
            cabeceraString += "<tr><th colspan=\"2\">TIPO: " + new cDatosCliente().tipoCliente(tipoInteger) + " / CONDICIÓN: " + new cDatosCliente().condicionCliente(condicionInteger) + "</th></tr>";
            cabeceraString += "<tr><th colspan=\"2\">COBRADOR: " + objCobrador.getPersona().getNombres() + "</th></tr>";
        } catch (Exception e) {
            out.print("Código de cobrador y/o empresa no encontrado");
            return;
        }
    }
    if (reporte.equals("direccion_EC_tipo_condicion_cobrador")) {                              //4-4
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
            tipoInteger = Integer.parseInt(request.getParameter("tipo"));
            condicionInteger = Integer.parseInt(request.getParameter("condicion"));
            LVList = new cVentaCreditoLetraReporte().letrasVencidas_empresaConvenio_tipo_condicion_cobrador_ordenDireccion_SC(fechaDate, codECInteger, tipoInteger, condicionInteger, codCobradorInteger);
            orden += "DIRECCIÓN ";
            cabeceraString = "<tr><th colspan=\"2\">EMPRESA/CONVENIO: " + objEC.getNombre() + "</th></tr>";
            cabeceraString += "<tr><th colspan=\"2\">TIPO: " + new cDatosCliente().tipoCliente(tipoInteger) + " / CONDICIÓN: " + new cDatosCliente().condicionCliente(condicionInteger) + "</th></tr>";
            cabeceraString += "<tr><th colspan=\"2\">COBRADOR: " + objCobrador.getPersona().getNombres() + "</th></tr>";
        } catch (Exception e) {
            out.print("Código de cobrador y/o empresa no encontrado");
            return;
        }
    }
    if (LVList == null) {
        out.print(reporte + " list -> null.");
        return;
    }
    response.setContentType("application/vnd.ms-excel"); //Tipo de fichero.
    response.setHeader("Content-Disposition", "attachment;filename=\"LETRAS VENCIDAS " + new cManejoFechas().DateAString2(fechaDate) + " " + new cManejoFechas().fechaHoraActualNumerosLineal() + ".xls\"");
%>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <title>JSP Page</title>
    </head>
    <body>
        <div id="documento">
            <div id="contenido">
                <table style="width: 820px;font-size: 14px;">
                    <thead>
                        <tr class="bottom2">
                            <th colspan="3"><label>Letras X cobrar : Clientes en general(Apellidos/Nombres) - Vencimiento <%=fechaString%></label></th>
                        </tr>
                        <%=cabeceraString%>
                        <tr class="bottom1">
                            <th style="width: 120px;"><label>Cod. Cliente</label></th>
                            <th><label>Nombre/Razón Social</label></th>
                            <th style="width: 120px;"><label>DNI / Ruc</label></th>
                            <th style="width: 80px;"><label>Monto</label></th>
                        </tr>
                    </thead>
                    <tbody>
                        <%
                            //defiendo variables
                            String nombresC = "";
                            String dniPasaporte = "";
                            String ruc = "";
                            Integer codCliente = 0;
                            Date fechaVencimiento = null;
                            Double monto = 0.00;
                            Double interes = 0.00;
                            Date fechaPago = null;
                            Double totalPago = 0.00;
                            Double interesPagado = 0.00;
                            Date interesUltimoCalculo = null;

                            Integer diaRetraso = 0;
                            Double interesSumar = 0.00;
                            double factorInteres = (new cDatosExtras().leer_interesFactor().getDecimalDato() / 100) / 30;
                            int diaEspera = new cDatosExtras().leer_diaEspera().getEntero();

                            Double deudaTotal = 0.00;

                            Integer codClienteAux = 0;
                            Integer contAux = 0;//------
                            for (Iterator it = LVList.iterator(); it.hasNext();) {
                                Object dato[] = (Object[]) it.next();
                                codCliente = (Integer) dato[7];
                                //si es el primer item
                                if (contAux++ == 0) {
                                    codClienteAux = codCliente;
                                }
                                //si el codCliente es diferente al anterior se imprimimen los datos
                                if (!codClienteAux.equals(codCliente)) {
                        %>
                        <tr>
                            <td style="text-align: left;padding-left: 5px; mso-number-format:'@';">*<span><%=new cOtros().agregarCeros_int(codClienteAux, 8)%></span></td>
                            <td><%=nombresC%></td>
                            <td style="text-align: right; mso-number-format:'@';"><%=dniPasaporte.equals("") ? ruc : dniPasaporte%></td>
                            <td style="text-align: right; mso-number-format:'0.00';"><%=new cOtros().decimalFormato(deudaTotal, 2)%></td>
                        </tr>
                        <%
                                    codClienteAux = codCliente;
                                    deudaTotal = 0.00;
                                }
                                nombresC = (String) dato[1];
                                dniPasaporte = (String) dato[2];
                                ruc = (String) dato[3];
                                fechaVencimiento = (Date) dato[16];
                                monto = (Double) dato[17];
                                interes = (Double) dato[18];
                                fechaPago = (Date) dato[19];
                                totalPago = (Double) dato[20];
                                interesPagado = (Double) dato[21];
                                interesUltimoCalculo = (Date) dato[22];

                                if (interesUltimoCalculo == null) {//se tomara el ultimo pago o la fecha de vencimiento
                                    diaRetraso = new cManejoFechas().diferenciaDosDias(fechaDate, fechaPago != null ? fechaPago : fechaVencimiento);
                                } else {
                                    diaRetraso = new cManejoFechas().diferenciaDosDias(fechaDate, interesUltimoCalculo);
                                }
                                diaRetraso = diaRetraso < 0 ? 0 : diaRetraso;
                                diaRetraso = diaRetraso <= diaEspera ? 0 : diaRetraso;      //todos aquellos dentro de los dias de espera no se generan intereses.
                                interesSumar = (monto - totalPago) * factorInteres * diaRetraso;    //solo se genera interes del capital
                                interes += interesSumar;

                                deudaTotal += monto - totalPago + interes - interesPagado;
                            }
                        %>
                        <tr>
                            <td style="text-align: left;padding-left: 5px; mso-number-format:'@';"><span>*<%=new cOtros().agregarCeros_int(codCliente, 8)%></span></td>
                            <td><%=nombresC%></td>
                            <td style="text-align: right; mso-number-format:'@';"><%=dniPasaporte.equals("") ? ruc : dniPasaporte%></td>
                            <td style="text-align: right; mso-number-format:'0.00';"><%=new cOtros().decimalFormato(deudaTotal, 2)%></td>
                        </tr>
                    </tbody>
                </table>
            </div>
        </div>
    </body>
</html>
