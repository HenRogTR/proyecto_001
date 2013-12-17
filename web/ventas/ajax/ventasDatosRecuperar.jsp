<%-- 
    Document   : ventasDatosRecuperar
    Created on : 19/05/2013, 02:52:39 PM
    Author     : Henrri
--%>

<%@page import="personaClases.cPersona"%>
<%@page import="otros.cUtilitarios"%>
<%@page import="ventaClases.cVenta"%>
<%@page import="tablas.Ventas"%>
<%
    Boolean estado = true;
    String mensaje = "";
    int codVentas = 0;
    String tipo = "Contado";
    Ventas objVentas = new Ventas();
    try {
        codVentas = Integer.parseInt(request.getParameter("codVentas"));
        objVentas = new cVenta().leer_cod(codVentas);
        if (objVentas.getVentaCreditos().iterator().hasNext()) {
            tipo = "Crédito";
        }
//        out.print(objVentas);

    } catch (Exception e) {
        out.print("[]");
        estado = false;
    };
//    out.print(mensaje);
    cUtilitarios objcUtilitarios = new cUtilitarios();
    if (objVentas == null) {
        return;
    }
    out.print("[");
    out.print("{");
    out.print(
            "\"codVentas\":\"" + objcUtilitarios.agregarCeros_int(objVentas.getCodVentas(), 8) + "\""
            //*****inicio datos de clientes****************
            + ",\"nombresC\":\"" + objcUtilitarios.replace_comillas_comillasD_barraInvertida(objVentas.getCliente()) + "\""
            + ",\"direccion\":\"" + objcUtilitarios.replace_comillas_comillasD_barraInvertida(objVentas.getDireccion()) + "\""
            + ",\"dniPasaporte\":\"" + objVentas.getPersona().getDniPasaporte() + "\""
            + ",\"ruc\":\"" + objVentas.getPersona().getRuc() + "\""
            //fin datos cliente
            + ",\"docSerieNumero\":\"" + objVentas.getDocSerieNumero() + "\""
            + ",\"fecha\":\"" + objcUtilitarios.fechaDateToString(objVentas.getFecha()) + "\""
            + ",\"moneda\":\"" + objVentas.getMoneda() + "\""
            + ",\"subTotal\":\"" + objcUtilitarios.agregarCerosNumeroFormato(objVentas.getSubTotal(), 2) + "\""
            + ",\"descuento\":\"" + objcUtilitarios.agregarCerosNumeroFormato(objVentas.getDescuento(), 2) + "\""
            + ",\"total\":\"" + objcUtilitarios.agregarCerosNumeroFormato(objVentas.getTotal(), 2) + "\""
            + ",\"valorIgv\":\"" + objcUtilitarios.agregarCerosNumeroFormato(objVentas.getValorIgv(), 2) + "\""
            + ",\"neto\":\"" + objcUtilitarios.agregarCerosNumeroFormato(objVentas.getNeto(), 2) + "\""
            + ",\"son\":\"" + objVentas.getSon() + "\""
            //****datos de vendedor
            + ",\"vendedorDatos\":\"" + (new cPersona().leer_cod(objVentas.getPersonaCodVendedor())).getNombresC() + "\""
            //fin datos vendedor
            + ",\"observacion\":\"" + objcUtilitarios.replace_comillas_comillasD_barraInvertida(objVentas.getObservacion()).replace("\\n", "<br>") + "\""
            + ",\"registro\":\"" + objVentas.getRegistro() + "\""
            + ",\"tipo\":\"" + tipo + "\"");
    out.print("}");
    out.print("]");
%>