<%-- 
    Document   : letraVencida
    Created on : 03/03/2014, 06:56:57 PM
    Author     : Henrri
--%>

<%@page import="tablas.Zona"%>
<%@page import="Clase.Utilitarios"%>
<%@page import="Clase.Fecha"%>
<%@page import="otrasTablasClases.cDatosExtras"%>
<%@page import="tablas.VentasDetalle"%>
<%@page import="ventaClases.cVentasDetalle"%>
<%@page import="java.util.Iterator"%>
<%@page import="personaClases.cDatosCliente"%>
<%@page import="personaClases.cEmpresaConvenio"%>
<%@page import="personaClases.cPersonal"%>
<%@page import="ventaClases.cVentaCreditoLetraReporte"%>
<%@page import="utilitarios.cValidacion"%>
<%@page import="tablas.EmpresaConvenio"%>
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
    String fechaStringInicio = "";
    String fechaString = "";
    String fechaInteresBaseString = "";
    Boolean fechaFinalUsar = false;
    Date fechaDateInicio = null;
    Date fechaDate = null;
    Date fechaInteresBaseDate = new Date();
    List LVList = null;

    Integer codCobradorInteger = 0;
    Personal objCobrador = null;
    Integer codECInteger = 0;
    EmpresaConvenio objEC = null;
    Integer tipoInteger = 0;
    Integer condicionInteger = 0;
    try {
        fechaStringInicio = request.getParameter("fechaVencimientoInicio");
        fechaString = request.getParameter("fechaVencimiento").toString();
        if (!new cValidacion().validarFecha(fechaString)) {
            out.print("Fecha y/o formato de fecha incorrecta.");
            return;
        }
        fechaDateInicio = new Fecha().stringADate(fechaStringInicio);
        fechaDate = new Fecha().stringADate(fechaString);
    } catch (Exception e) {
        out.print("Fecha(s) de vencimiento(s) no encontrada(s).");
        return;
    }
    fechaFinalUsar = Boolean.parseBoolean(request.getParameter("fechaFinalUsar"));
    //Fechas que vencen en fechaDate figurar en el reporte
    //si se usa se suma un día
    fechaDate = fechaFinalUsar ? new Fecha().sumarDias(fechaDate, 1) : fechaDate;
    //Varificando con Zona

    int codZona = 0;
    String zona = "";
    try {
        codZona = Integer.parseInt(request.getParameter("codZona").toString());
        zona = request.getParameter("zona").toString();
    } catch (Exception e) {
        out.print("codZona no definido.");
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
    //Agregar cabecera zona
    cabeceraString += "<tr><th colspan=\"2\">ZONA: " + zona + "</th></tr>";
    if (LVList == null) {
        out.print(reporte + " list -> null.");
        return;
    }
%>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <title><%=titleString%></title>
        <link rel="stylesheet" type="text/css" href="../../librerias/principal/bodyPrint.css" media="screen"/>
        <link rel="stylesheet" type="text/css" href="../../librerias/principal/bodyPrint.css" media="print"/>
    </head>
    <body>
        <div id="documento">
            <div id="contenido">
                <table style="font-size: 11px;" class="anchoTotal">
                    <thead>
                        <tr>
                            <th colspan="4" >LETRAS VENCIDAS <label style="font-size: 12px;"><%if (fechaDateInicio != null) {%>DEL <%=new Fecha().dateAString(fechaDateInicio)%><%}%> AL <%=fechaString%> <%=fechaFinalUsar ? "(*)" : ""%></label> - (<%=orden%>)</th>
                            <th colspan="4" class="derecha"><%=new Fecha().fechaHora(new Date()).toUpperCase()%></th>
                        </tr>
                        <tr>
                            <th colspan="3">INTERESES CALCULADOS AL <%=new Fecha().dateAString(fechaInteresBaseDate)%></th>
                        </tr>
                        <%=cabeceraString%>
                        <tr class="top2" style="font-size: 12px;" >
                            <th style="width: 80px;"><span>Número</span></th>
                            <th><span>Código - Nombre/Razón Social</span></th>
                            <th style="width: 60px;"><span>Vencimiento</span></th>
                            <th style="width: 60px;"><span>Monto</span></th>
                            <th style="width: 60px;"><span>Interés</span></th>
                            <th style="width: 60px;"><span>Pagos</span></th>
                            <th style="width: 60px;"><span>Saldo</span></th>
                            <th style="width: 80px;"><span>F. Ultimo Pago</span></th>
                        </tr>
                    </thead>
                    <tbody>
                        <%
                            //defiendo variables
                            Integer codPersona = 0;
                            String nombresC = "";
                            String dniPasaporte = "";
                            String ruc = "";
                            String direccion = "";
                            String telefono1 = "";
                            String telefono2 = "";
                            Integer codCliente = 0;
                            Integer codVenta = 0;
                            String docSerieNumero = "";
                            Date fecha = null;
                            Integer itemCantidad = 0;
                            Integer cantidadLetras = 0;
                            Integer codVentaCreditoLetra = 0;
                            String numeroLetra = "";
                            String detalleLetra = "";
                            Date fechaVencimiento = null;
                            Double monto = 0.00;
                            Double interes = 0.00;
                            Date fechaPago = null;
                            Double totalPago = 0.00;
                            Double interesPagado = 0.00;
                            Date interesUltimoCalculo = null;
                            Integer codZonaCliente = 0;

                            Integer diaRetraso = 0;
                            Double interesSumar = 0.00;
                            double factorInteres = (new cDatosExtras().leer_interesFactor().getDecimalDato() / 100) / 30;
                            int diaEspera = new cDatosExtras().leer_diaEspera().getEntero();

                            Integer codClienteAux = 0;
                            Integer codVentaAux = 0;
                            Double totalDeudaAux = 0.00;
                            Integer contAux = 1;//------
                            for (Iterator it = LVList.iterator(); it.hasNext();) {
                                Object dato[] = (Object[]) it.next();
                                codPersona = (Integer) dato[0];
                                nombresC = (String) dato[1];
                                dniPasaporte = (String) dato[2];
                                ruc = (String) dato[3];
                                direccion = (String) dato[4];
                                telefono1 = new Utilitarios().reemplazarCaracteresEspeciales((String) dato[5]);
                                telefono2 = new Utilitarios().reemplazarCaracteresEspeciales((String) dato[6]);
                                codCliente = (Integer) dato[7];
                                codVenta = (Integer) dato[8];
                                docSerieNumero = (String) dato[9];
                                fecha = (Date) dato[10];
                                itemCantidad = (Integer) dato[11];
                                cantidadLetras = (Integer) dato[12];
                                detalleLetra = (String) dato[15];
                                fechaVencimiento = (Date) dato[16];
                                monto = (Double) dato[17];
                                interes = (Double) dato[18];
                                fechaPago = (Date) dato[19];
                                totalPago = (Double) dato[20];
                                interesPagado = (Double) dato[21];
                                interesUltimoCalculo = (Date) dato[22];
                                codZonaCliente = (Integer) dato[23];

                                //Si es diferente a 0 y si es igual a la zona
                                if (codZona == 0 || codZonaCliente.equals(codZona)) {

                                    if (null == fechaDateInicio || !fechaVencimiento.before(fechaDateInicio)) {
                                        if (interesUltimoCalculo == null) {//se tomara el ultimo pago o la fecha de vencimiento
                                            //error al haber una fecha de pago anterior a la fecha de vencimiento
                                            diaRetraso = new Fecha().diasDiferencia(fechaInteresBaseDate, fechaPago != null ? (fechaPago.before(fechaVencimiento) ? fechaVencimiento : fechaPago) : fechaVencimiento);
                                        } else {
                                            diaRetraso = new Fecha().diasDiferencia(fechaInteresBaseDate, interesUltimoCalculo);
                                        }
                                        diaRetraso = diaRetraso < 0 ? 0 : diaRetraso;
                                        diaRetraso = diaRetraso <= diaEspera ? 0 : diaRetraso;      //todos aquellos dentro de los dias de espera no se generan intereses.
                                        interesSumar = (monto - totalPago) * factorInteres * diaRetraso;    //solo se genera interes del capital
                                        interes += interesSumar;

                                        if (!codClienteAux.equals(codCliente)) {
                                            codClienteAux = codCliente;
                        %>
                        <tr class="bottom1">
                            <th colspan="8"></th>
                        </tr>
                        <tr style="font-size: 11px;">
                            <td style="padding-left: 5px;"><%=new Utilitarios().agregarCerosIzquierda(contAux, 8)%></td>
                            <td colspan="2">
                                <span><%=new Utilitarios().agregarCerosIzquierda(codCliente, 8)%></span> - <a href="../../sDatoCliente?accionDatoCliente=mantenimiento&codDatoCliente=<%=codCliente%>" target="_blank"><%=nombresC%></a> <%=telefono1 + " " + telefono2%>
                            </td>
                            <td colspan="5"><%=direccion%></td>
                        </tr>
                        <%
                                contAux++;
                            }
                            if (!codVentaAux.equals(codVenta)) {
                                codVentaAux = codVenta;
                        %>
                        <tr>
                            <td class="derecha">
                                <div style="padding-right: 5px;"><%=new Fecha().dateAString(fecha)%></div>
                            </td>
                            <td colspan="5">
                                <div style="padding-left: 20px;">
                                    <a target="_blank" href="../../sVenta?accionVenta=mantenimiento&codVenta=<%=codVenta%>"><%=docSerieNumero%></a> ***
                                    <%
                                        List VDList = new cVentasDetalle().leer_ventas_porCodVentas(codVenta);
                                        for (Iterator VDIt = VDList.iterator(); VDIt.hasNext();) {
                                            VentasDetalle objVD = (VentasDetalle) VDIt.next();
                                            if (objVD.getItem().equals(1)) {
                                                out.print(objVD.getDescripcion());
                                            }
                                        }
                                    %>
                                </div>
                            </td>
                            <td>
                                <div style="margin-left: 5px;">N° Item: <%=itemCantidad%></div>
                            </td>
                            <td>
                                <div style="margin-left: 5px;">N° Letras: <%=cantidadLetras%></div>
                            </td>
                        </tr>
                        <%
                            }
                        %>
                        <tr style="font-size: 11px;">
                            <td></td>
                            <td><div style="padding-left: 20px;"><%=detalleLetra%></div></td>
                            <td><%=new Fecha().dateAString(fechaVencimiento)%></td>
                            <td class="derecha"><div style="padding-right: 5px;"><%=new Utilitarios().decimalFormato(monto, 2)%></div></td>
                            <td class="derecha"><div style="padding-right: 5px;"><%=new Utilitarios().decimalFormato(interes, 2)%></div></td>
                            <td class="derecha"><div style="padding-right: 5px;"><%=new Utilitarios().decimalFormato(totalPago + interesPagado, 2)%></div></td>
                            <td class="derecha"><div style="padding-right: 5px;"><%=new Utilitarios().decimalFormato((monto - totalPago + interes - interesPagado), 2)%></div></td>
                            <td><%=new Fecha().dateAString(fechaPago)%></td>
                        </tr>
                        <%
                                        totalDeudaAux += monto - totalPago + interes - interesPagado;
                                    }
                                }
                            }
                        %>
                        <tr class="bottom2">
                            <td style="height: 50px;"></td>
                            <td></td>
                            <th colspan="3" style="font-weight: bold; font-size: 14px; vertical-align: bottom;">TOTAL GENERAL</th>
                            <th colspan="2" style="font-weight: bold; font-size: 14px; vertical-align: bottom;" class="derecha">
                                <span style="padding-right: 5px;">
                                    <%=new Utilitarios().decimalFormato(totalDeudaAux, 2)%>
                                </span>
                            </th>
                            <td></td>
                        </tr>
                        <%
                            if (fechaFinalUsar) {
                        %>
                        <tr>
                            <td colspan="4">
                                (*) Se muestran letras vencidas al <%=fechaString%> (fechaVenciento)
                            </td>
                        </tr>
                        <%
                            }
                        %>
                    </tbody>
                </table>
            </div>
        </div>
    </body>
</html>
