<%-- 
    Document   : letraVencidaDetalleExcel
    Created on : 09/10/2014, 12:24:00 AM
    Author     : Henrri
--%>
<%@page import="personaClases.cDatosCliente"%>
<%@page import="utilitarios.cManejoFechas"%>
<%@page import="Ejb.EjbDatosExtras"%>
<%@page import="Clase.Utilitarios"%>
<%@page import="java.util.List"%>
<%@page import="Ejb.EjbVentaCreditoLetra"%>
<%@page import="Clase.Fecha"%>
<%@page import="java.util.Date"%>
<%
    String orden;
    String clienteCobrador;
    int codCobrador_req;
    String cobradorNombresC_req;
    int codZona_req;
    String zona_req;
    int codEmpresaConvenio_req;
    String empresaConvenio_req;
    int codTipo_req;
    String tipo_req;
    int codCondicion_req;
    String condicion_req;
    Date fechaInicio = null;
    Date fechaInicioAux = null;
    Date fechaFin = null;
    Date fechaFinAux = null;
    Date fechaInteresBase = new Fecha().fechaHoraAFecha(new Date());
    Boolean fechaFinalUsar = false;

    try {
        orden = request.getParameter("orden").toString();
        clienteCobrador = request.getParameter("clienteCobrador").toString();
        codCobrador_req
                = "todos".equals(clienteCobrador)
                ? 0
                : Integer.parseInt(request.getParameter("codCobrador").toString());
        cobradorNombresC_req
                = "todos".equals(clienteCobrador)
                ? "TODOS"
                : request.getParameter("cobradorNombresC").toString();
        codZona_req = Integer.parseInt(request.getParameter("codZona").toString());
        zona_req = request.getParameter("zona").toString();
        codEmpresaConvenio_req
                = "".equals(request.getParameter("codEmpresaConvenio").toString())
                ? 0
                : Integer.parseInt(request.getParameter("codEmpresaConvenio").toString());
        empresaConvenio_req
                = 0 == codEmpresaConvenio_req
                ? "TODOS"
                : request.getParameter("empresaConvenio").toString();
        codTipo_req
                = "".equals(request.getParameter("codTipo").toString())
                ? 0
                : Integer.parseInt(request.getParameter("codTipo").toString());
        tipo_req
                = 0 == codTipo_req
                ? "TODOS"
                : request.getParameter("tipo").toString();
        codCondicion_req
                = "".equals(request.getParameter("codCondicion").toString())
                ? 0
                : Integer.parseInt(request.getParameter("codCondicion").toString());
        condicion_req
                = 0 == codCondicion_req
                ? "TODOS"
                : request.getParameter("condicion").toString();
        fechaInicio = new Fecha().stringADate(request.getParameter("fechaInicio").toString());
        fechaFin = new Fecha().stringADate(request.getParameter("fechaFin").toString());
        fechaFinalUsar = Boolean.parseBoolean(request.getParameter("fechaFinalUsar").toString());
    } catch (Exception e) {
        out.print("Error en parámetros.");
        return;
    }

    fechaInicioAux
            = null == fechaInicio
            ? new Date(0, 0, 0)//en caso sea null poner la primera fecha
            : fechaInicio;
    //Si fechafinal usar es true se deja como esta sino se resta un dia, ya que se usa beetwenn
    fechaFinAux
            = fechaFinalUsar
            ? fechaFin
            : (new Fecha().sumarDias(fechaFin, -1));
    EjbVentaCreditoLetra ejbVentaCreditoLetra = new EjbVentaCreditoLetra();

    List<Object[]> VCLList
            = "nombresC".equals(orden)
            ? ejbVentaCreditoLetra.leerLetrasVencidasOrdenNombresC(fechaInicioAux, fechaFinAux)
            : ejbVentaCreditoLetra.leerLetrasVencidasOrdenDireccion(fechaInicioAux, fechaFinAux);
    if (VCLList == null) {
        out.print(ejbVentaCreditoLetra.getError());
        return;
    }
    response.setContentType("application/vnd.ms-excel"); //Tipo de fichero.
    response.setHeader("Content-Disposition", "attachment;filename=\"LETRAS VENCIDAS DETALLES " + new cManejoFechas().DateAString2(fechaFin) + " " + new cManejoFechas().fechaHoraActualNumerosLineal() + ".xls\"");
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
                <table style="width: 4100px;font-size: 14px;">
                    <thead>
                        <tr class="bottom2">
                            <th colspan="5" style="text-align: left">LETRAS VENCIDAS <label style="font-weight: bold;"><%if (fechaInicio != null) {%>DEL <%=new Fecha().dateAString(fechaInicio)%><%}%> AL <%=new Fecha().dateAString(fechaFin)%> <%=fechaFinalUsar ? "(*)" : ""%></label> - (<%=orden%>)</th>
                        </tr>
                        <tr>
                            <th colspan="5" style="text-align: left;">INTERESES CALCULADOS AL <%=new Fecha().dateAString(fechaInteresBase)%></th>
                        </tr>
                        <tr>
                            <th colspan="5" style="text-align: left;">EMPRESA/CONVENIO: <%=empresaConvenio_req%></th>
                        </tr>
                        <tr>
                            <th colspan="5" style="text-align: left;">TIPO: <%=tipo_req%></th>
                        </tr>
                        <tr>
                            <th colspan="5" style="text-align: left;">CONDICIÓN: <%=condicion_req%></th>
                        </tr>
                        <tr>
                            <th colspan="5" style="text-align: left;">ZONA: <%=zona_req%></th>
                        </tr>
                        <tr>
                            <th colspan="5" style="text-align: left;">COBRADOR: <%=cobradorNombresC_req%></th>
                        </tr>
                        <tr class="bottom1">
                            <th style="width: 80px;"><label>COD.CLIEN</label></th>
                            <th style="width: 100px;"><label>DNI / RUC</label></th>
                            <th><label>NOMBRE/RAZ.SOCIAL</label></th>
                            <th style="width: 700px;"><label>DIRECCIÓN</label></th>
                            <th style="width: 100px;"><label>DOC.VENTA</label></th>
                            <th style="width: 700px">PRIMER ITEM</th>
                            <th style="width: 80px">NETO V.</th>
                            <th style="width: 80px;"><label>D. CAP.</label></th>
                            <th style="width: 80px;"><label>D. INT.</label></th>
                            <th style="width: 100px;"><label>LET.VEN.ANT</label></th>
                            <th style="width: 80px;"><label>C. LET. VENC</label></th>
                            <th style="width: 80px;"><label>CUOT.MEN.</label></th>
                            <th style="width: 300px;"><label>COBRADOR</label></th>
                            <th style="width: 300px;">ZONA</th>
                            <th style="width: 500px;">EMPRESA/CONVENIO</th>
                            <th style="width: 150px;"><label>TIPO</label></th>
                            <th style="width: 150px;"><label>CONDICIÓN</label></th>
                        </tr>
                    </thead>
                    <tbody>
                        <%
                            //Variables
                            Integer codCliente = 0; //[0]
                            int codTipo = 0;
                            int codCondicion = 0;
                            int codCobrador = 0;
                            String cobradorNombresC = ""; //[4]
                            Date interesEvitar = null;      //[5]
                            boolean interesEvitarPermanente = false;
                            int codEmpresaConvenio = 0;
                            String empresaConvenio = "";
                            int codPersona = 0;
                            String nombresC = "";   //[10]
                            String direccion = "";
                            String dniPasaporte = "";
                            String ruc = "";
                            String telefono1 = "";
                            String telefono2 = ""; //[15]
                            int codZona = 0;
                            String zona = "";
                            int codVenta = 0;
                            int itemCantidad = 0;   //[19]
                            String primerItem = "";
                            String docSerieNumero = "";   //[21]
                            Date fecha = null;
                            Double neto = 0.00;
                            int codVendedor = 0;
                            String vendedorNombresC = "";//[25]
                            Double montoInicial = 0.00;
                            Double montoLetra = 0.00;
                            int codVentaCreditoLetra = 0;
                            Date fechaVencimiento = null;
                            Double monto = 0.00;
                            Double interes = 0.00; //[31]
                            Date fechaPago = null;
                            Double totalPago = 0.00;
                            Double interesPagado = 0.00;
                            Double interesPendiente = 0.00;
                            Date interesUltimoCalculo = null; //[36]

                            int codTipoAux = 0;
                            int codCondicionAux = 0;
                            int codCobradorAux = 0;
                            int codEmpresaConvenioAux = 0;
                            int codZonaAux = 0;
                            int codVentaAux = 0;
                            Double deudaCapitalVenta = 0.00;
                            Double deudaInteresVenta = 0.00;
                            Date fechaVencimientoMasVencida = null;
                            int letrasVencidas = 0;

                            EjbDatosExtras ejbDatosExtras = new EjbDatosExtras();
                            int diaEspera = ejbDatosExtras.diaEspera();
                            double interesDefinido = ejbDatosExtras.interesFactor(); //Factor de interés
                            double factorInteres = (interesDefinido / 100) / 30;
                            int diaRetraso = 0;
                            Double interesSumar = 0.00;
                            int cont = 0;

                            int tam = VCLList.size();
                            for (int i = 0; i < tam; i++) {
                                Object[] dato = VCLList.get(i);
                                //Verificar cobrador, empresa, tipo, condicion y zona
                                codTipoAux = (Integer) dato[1];
                                codCondicionAux = (Integer) dato[2];
                                codCobradorAux = (Integer) dato[3];
                                codEmpresaConvenioAux = (Integer) dato[7];
                                codZonaAux = (Integer) dato[16];
                                codVenta = (Integer) dato[18];
                                if ((codCobrador_req == 0 || codCobrador_req == codCobradorAux)
                                        & (codEmpresaConvenio_req == 0 || codEmpresaConvenio_req == codEmpresaConvenioAux)
                                        & (codTipo_req == 0 || codTipo_req == codTipoAux)
                                        & (codCondicion_req == 0 || codCondicion_req == codCondicionAux)
                                        & (codZona_req == 0 || codZona_req == codZonaAux)) {
                                    if (cont == 0) {
                                        codVentaAux = codVenta;
                                    }
                                    //si el cliente es distinto se imprimen los datos
                                    if (codVentaAux != codVenta) {
                        %>
                        <tr>
                            <td style="text-align: left;padding-left: 5px; mso-number-format:'@';vertical-align: top;"><span><%=Utilitarios.agregarCerosIzquierda(codCliente, 8)%></span></td>
                            <td style="text-align: right; mso-number-format:'@';vertical-align: top;"><%=dniPasaporte.equals("") ? ruc : dniPasaporte%></td>
                            <td style="vertical-align: top; padding-left: 5px;"><%=nombresC%></td>
                            <td style="vertical-align: top; padding-left: 5px;"><%=direccion%></td>
                            <td style="vertical-align: top; padding-left: 5px;"><%=docSerieNumero%></td>
                            <td style="vertical-align: top; padding-left: 5px;"><%=primerItem%></td>
                            <td style="text-align: right; mso-number-format:'0.00';"><%=Utilitarios.decimalFormato(neto, 2)%></td>
                            <td style="text-align: right; mso-number-format:'0.00';"><%=Utilitarios.decimalFormato(deudaCapitalVenta, 2)%></td>
                            <td style="text-align: right; mso-number-format:'0.00';"><%=Utilitarios.decimalFormato(deudaInteresVenta, 2)%></td>
                            <td style="padding-left: 20px;"><%=new Fecha().dateAString(fechaVencimientoMasVencida)%></td>
                            <td style="text-align: right"><%=letrasVencidas%></td>
                            <td style="text-align: right; mso-number-format:'0.00';"><%=Utilitarios.decimalFormato(montoLetra, 2)%></td>
                            <td><%=cobradorNombresC%></td>
                            <td><%=zona%></td>
                            <td><%=empresaConvenio%></td>
                            <td><%=cDatosCliente.tipoCliente(codTipo)%></td>
                            <td><%= cDatosCliente.condicionCliente(codCondicion)%></td>
                        </tr>
                        <%
                                        codVentaAux = codVenta;
                                        //Reiniciar totales
                                        deudaCapitalVenta = 0.00;
                                        deudaInteresVenta = 0.00;
                                        fechaVencimientoMasVencida = null;
                                        letrasVencidas = 0;
                                    }
                                    //Recuperar todos los parámetros
                                    codCliente = (Integer) dato[0]; //[0]
                                    codTipo = (Integer) dato[1];
                                    codCondicion = (Integer) dato[2];
                                    codCobrador = (Integer) dato[3];
                                    cobradorNombresC = (String) dato[4]; //[4]
                                    interesEvitar = (Date) dato[5];      //[5]
                                    interesEvitarPermanente = (Boolean) dato[6];
                                    codEmpresaConvenio = (Integer) dato[7];
                                    empresaConvenio = (String) dato[8];
                                    codPersona = (Integer) dato[9];
                                    nombresC = (String) dato[10];   //[10]
                                    direccion = (String) dato[11];
                                    dniPasaporte = (String) dato[12];
                                    ruc = (String) dato[13];
                                    telefono1 = (String) dato[14];
                                    telefono2 = (String) dato[15]; //[15]
                                    codZona = (Integer) dato[16];
                                    zona = (String) dato[17];
//                            int codVenta = 0;
                                    itemCantidad = (Integer) dato[19];
                                    primerItem = (String) dato[20];
                                    docSerieNumero = (String) dato[21];   //[21]
                                    fecha = (Date) dato[22];
                                    neto = (Double) dato[23];
                                    codVendedor = (Integer) dato[24];
                                    vendedorNombresC = (String) dato[25];//[25]
                                    montoInicial = (Double) dato[26];
                                    montoLetra = (Double) dato[27];
                                    codVentaCreditoLetra = (Integer) dato[28];
                                    fechaVencimiento = (Date) dato[29];
                                    monto = (Double) dato[30];
                                    interes = (Double) dato[31]; //[31]
                                    fechaPago = (Date) dato[32];
                                    totalPago = (Double) dato[33];
                                    interesPagado = (Double) dato[34];
                                    interesPendiente = (Double) dato[35];
                                    interesUltimoCalculo = (Date) dato[36]; //[36]
                                    //obtener la fecha del credito con la letra mas vencida
                                    if (fechaVencimientoMasVencida == null) {
                                        fechaVencimientoMasVencida = fechaVencimiento;
                                    } else {
                                        //si fecha vencimiento es menor a la aux
                                        if (fechaVencimientoMasVencida.after(fechaVencimiento)) {
                                            fechaVencimientoMasVencida = fechaVencimiento;
                                        }
                                    }
                                    //obtener interes y deuda capital
                                    deudaCapitalVenta += monto - totalPago;
                                    if (interesUltimoCalculo == null) {//se tomara el ultimo pago o la fecha de vencimiento
                                        //error al haber una fecha de pago anterior a la fecha de vencimiento
                                        diaRetraso = new Fecha().diasDiferencia(fechaInteresBase, fechaPago != null ? (fechaPago.before(fechaVencimiento) ? fechaVencimiento : fechaPago) : fechaVencimiento);
                                    } else {
                                        diaRetraso = new Fecha().diasDiferencia(fechaInteresBase, interesUltimoCalculo);
                                    }
                                    diaRetraso = diaRetraso < 0 ? 0 : diaRetraso;
                                    diaRetraso = diaRetraso <= diaEspera ? 0 : diaRetraso;      //todos aquellos dentro de los dias de espera no se generan intereses.
                                    interesSumar = (monto - totalPago) * factorInteres * diaRetraso;    //solo se genera interes del capital
                                    deudaInteresVenta += interesSumar;

                                    letrasVencidas++;
                                    cont++;
                                }
                            }
                            //imprmir el ultimo dato si al menos hay un dato
                            if (cont > 0) {
                        %>
                        <tr>
                            <td style="text-align: left;padding-left: 5px; mso-number-format:'@';vertical-align: top;"><span><%=Utilitarios.agregarCerosIzquierda(codCliente, 8)%></span></td>
                            <td style="text-align: right; mso-number-format:'@';vertical-align: top;"><%=dniPasaporte.equals("") ? ruc : dniPasaporte%></td>
                            <td style="vertical-align: top; padding-left: 5px;"><%=nombresC%></td>
                            <td style="vertical-align: top; padding-left: 5px;"><%=direccion%></td>
                            <td style="vertical-align: top; padding-left: 5px;"><%=docSerieNumero%></td>
                            <td style="vertical-align: top; padding-left: 5px;"><%=primerItem%></td>
                            <td style="text-align: right; mso-number-format:'0.00';"><%=Utilitarios.decimalFormato(neto, 2)%></td>
                            <td style="text-align: right; mso-number-format:'0.00';"><%=Utilitarios.decimalFormato(deudaCapitalVenta, 2)%></td>
                            <td style="text-align: right; mso-number-format:'0.00';"><%=Utilitarios.decimalFormato(deudaInteresVenta, 2)%></td>
                            <td style="padding-left: 20px;"><%=new Fecha().dateAString(fechaVencimientoMasVencida)%></td>
                            <td style="text-align: right"><%=letrasVencidas%></td>
                            <td style="text-align: right; mso-number-format:'0.00';"><%=Utilitarios.decimalFormato(montoLetra, 2)%></td>
                            <td><%=cobradorNombresC%></td>
                            <td><%=zona%></td>
                            <td><%=empresaConvenio%></td>
                            <td><%=cDatosCliente.tipoCliente(codTipo)%></td>
                            <td><%= cDatosCliente.condicionCliente(codCondicion)%></td>
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
