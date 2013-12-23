<%-- 
    Document   : venta
    Created on : 26/08/2013, 05:14:00 PM
    Author     : Henrri***
--%>

<%@page import="tablas.DatosCliente"%>
<%@page import="utilitarios.cManejoFechas"%>
<%@page import="utilitarios.cOtros"%>
<%@page import="personaClases.cPersona"%>
<%@page import="ventaClases.cVenta"%>
<%@page import="tablas.Ventas"%>
<%
    int codVenta = 0;
    String parametro = "";
    try {
        codVenta = Integer.parseInt(request.getParameter("codVenta"));
        parametro = request.getParameter("parametro").toString();
    } catch (Exception e) {
        out.print("[]");
        return;
    };
    cOtros objcOtros = new cOtros();
    cManejoFechas objcManejoFechas = new cManejoFechas();
    cVenta objcVenta = new cVenta();
    Ventas objVenta = null;
    switch (codVenta) {
        case -1:
            objVenta = objcVenta.leer_primero();
            break;
        case 0:
            objVenta = objcVenta.leer_ultimo();
            break;
        default:
            objVenta = objcVenta.leer_cod(codVenta);
            while (objVenta == null) {
                if (parametro.equals("siguiente")) {
                    Ventas objVenta1 = objcVenta.leer_ultimo();
                    codVenta++;
                    if (codVenta > objVenta1.getCodVentas()) {//para ver que no haya pasado al final
                        objVenta = objVenta1;
                    }
                }
                if (parametro.equals("anterior")) {
                    Ventas objVenta1 = objcVenta.leer_primero();
                    codVenta++;
                    if (codVenta < objVenta1.getCodVentas()) {//para ver que no haya pasado al final
                        objVenta = objVenta1;
                    }
                }
                if (parametro.equals("")) {
                    break;
                }
            }
            break;

    }
    //impresion ajax

    out.print("[");
    if (objVenta != null) {
        session.removeAttribute("codVentaMantenimiento");
        session.setAttribute("codVentaMantenimiento", objVenta.getCodVentas());
        DatosCliente objCliente = objVenta.getPersona().getDatosClientes().iterator().next();
        out.print("{"
                + "\"codVenta\":\"" + objcOtros.agregarCeros_int(objVenta.getCodVentas(), 8) + "\""
                //*****inicio datos de clientes****************
                + ",\"codDatoCliente\":\"" + objcOtros.agregarCeros_int(objCliente.getCodDatosCliente(), 8) + "\""
                + ",\"codPersona\":\"" + objcOtros.agregarCeros_int(objVenta.getPersona().getCodPersona(), 8) + "\""
                + ",\"cliente\":\"" + objcOtros.replace_comillas_comillasD_barraInvertida(objVenta.getCliente()) + "\""
                + ",\"direccion\":\"" + objcOtros.replace_comillas_comillasD_barraInvertida(objVenta.getDireccion()) + "\""
                + ",\"direccion2\":\"" + objcOtros.replace_comillas_comillasD_barraInvertida(objVenta.getDireccion2()) + "\""
                + ",\"direccion3\":\"" + objcOtros.replace_comillas_comillasD_barraInvertida(objVenta.getDireccion3()) + "\""
                + ",\"dniPasaporte\":\"" + objVenta.getPersona().getDniPasaporte() + "\""
                + ",\"ruc\":\"" + objVenta.getPersona().getRuc() + "\""
                + ",\"empresaConvenio\":\"" + objcOtros.replace_comillas_comillasD_barraInvertida(objCliente.getEmpresaConvenio().getNombre()) + "\""
                //fin datos cliente
                + ",\"docSerieNumero\":\"" + objVenta.getDocSerieNumero() + "\""
                + ",\"docSerieNumeroGuia\":\"" + objcOtros.replace_comillas_comillasD_barraInvertida(objVenta.getDocSerieNumeroGuia())+ "\""
                + ",\"fecha\":\"" + objcManejoFechas.DateAString(objVenta.getFecha()) + "\""
                + ",\"moneda\":\"" + objVenta.getMoneda() + "\""
                + ",\"subTotal\":\"" + objcOtros.agregarCerosNumeroFormato(objVenta.getSubTotal(), 2) + "\""
                + ",\"descuento\":\"" + objcOtros.agregarCerosNumeroFormato(objVenta.getDescuento(), 2) + "\""
                + ",\"total\":\"" + objcOtros.agregarCerosNumeroFormato(objVenta.getTotal(), 2) + "\""
                + ",\"valorIgv\":\"" + objcOtros.agregarCerosNumeroFormato(objVenta.getValorIgv(), 2) + "\""
                + ",\"neto\":\"" + objcOtros.agregarCerosNumeroFormato(objVenta.getNeto(), 2) + "\""
                + ",\"son\":\"" + objVenta.getSon() + "\""
                //****datos de vendedor
                + ",\"vendedor\":\"" + (new cPersona().leer_cod(objVenta.getPersonaCodVendedor())).getNombresC() + "\""
                //fin datos vendedor
                + ",\"observacion\":\"" + objcOtros.replace_comillas_comillasD_barraInvertida(objVenta.getObservacion()) + "\""
                + ",\"registro\":\"" + objVenta.getRegistro() + "\""
                + ",\"tipo\":\"" + objVenta.getTipo() + "\"");
        out.print("}");
    }
    out.print("]");
%>
