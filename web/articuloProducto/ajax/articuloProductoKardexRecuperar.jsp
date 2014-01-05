<%-- 
    Document   : articuloProductoKardexRecuperar
    Created on : 22/12/2012, 12:27:13 AM
    Author     : Henrri
--%>

<%@page import="ventaClases.cVenta"%>
<%@page import="otros.cManejoFechas"%>
<%@page import="tablas.Ventas"%>
<%@page import="tablas.Compra"%>
<%@page import="compraClases.cCompra"%>
<%@page import="otros.cUtilitarios"%>
<%@page import="tablas.KardexArticuloProducto"%>
<%@page import="articuloProductoClases.cKardexArticuloProducto"%>
<%@page import="tablas.ArticuloProducto"%>
<%@page import="java.util.List"%>
<%@page import="articuloProductoClases.cArticuloProducto"%>
<%
//se usa para listar todos el movimiento de los diversos articulos Kardex.
    String codArt = request.getParameter("codArticuloProducto");
    String codAlm = request.getParameter("codAlmacen");
//    codAlmacen = "1";//temporal
//    codArticuloProducto = "1";
    if (codArt == null || codAlm == null) {
        return;
    }
    int codArticuloProducto = Integer.parseInt(codArt), codAlmacen = Integer.parseInt(codAlm);

    cKardexArticuloProducto objcKardexArticuloProducto = new cKardexArticuloProducto();
    cCompra objcCompra = new cCompra();
    cVenta objcVenta = new cVenta();
    cUtilitarios objcUtilitarios = new cUtilitarios();
    cManejoFechas objcManejoFechas = new cManejoFechas();

    List lKardexArticuloProducto = objcKardexArticuloProducto.leer(codArticuloProducto, codAlmacen);
    if (lKardexArticuloProducto.size() == 0) {
        return;
    }
    int contador = 0;
    String docSerieNumero = "";
    out.print("[");
    for (int i = 0; i < lKardexArticuloProducto.size(); i++) {
        KardexArticuloProducto objKardexArticuloProducto = (KardexArticuloProducto) lKardexArticuloProducto.get(i);
        switch (objKardexArticuloProducto.getTipoOperacion()) {
            case 1: //compra
                Compra objCompra = objcCompra.leer_cod(objKardexArticuloProducto.getCodOperacion());
                docSerieNumero = objCompra.getDocSerieNumero();
                break;
            case 2: //venta
                Ventas objVentas = objcVenta.leer_cod(objKardexArticuloProducto.getCodOperacion());
                docSerieNumero = objVentas.getDocSerieNumero();
                break;
            case 3: //traslado 

                break;
            case 4: //actulizacion manual
                break;
            case 5://reorte por eliminacion de venta
                Ventas objVentasEliminacion = objcVenta.leer_cod(objKardexArticuloProducto.getCodOperacion());
                docSerieNumero = objVentasEliminacion.getDocSerieNumero();
                break;
        }
        if (contador++ > 0) {
            out.println(",");
        }
        out.print("{"
                + "\"descripcion\":\"" + objcUtilitarios.replace_comillas_comillasD_barraInvertida(objKardexArticuloProducto.getArticuloProducto().getDescripcion()) + "\", "
                + "\"registro\":\"" + objcManejoFechas.regsitroAFechaHora(objKardexArticuloProducto.getRegistro()) + "\" , "
                + "\"docSerieNumero\":\"" + docSerieNumero + "\", "
                + "\"detalle\":\"" + objcUtilitarios.replace_comillas_comillasD_barraInvertida(objKardexArticuloProducto.getDetalle()) + "\", "
                + "\"entrada\":" + objKardexArticuloProducto.getEntrada() + ", "
                + "\"salida\":" + objKardexArticuloProducto.getSalida() + ", "
                + "\"stock\":" + objKardexArticuloProducto.getStock() + ", "
                + "\"precio\":\"" + objcUtilitarios.agregarCerosNumeroFormato(objcUtilitarios.redondearDecimales(objKardexArticuloProducto.getPrecio(), 2), 2) + "\", "
                + "\"precioPonderado\":\"" + objcUtilitarios.agregarCerosNumeroFormato(objcUtilitarios.redondearDecimales(objKardexArticuloProducto.getPrecioPonderado(), 2), 2) + "\", "
                + "\"total\":\"" + objcUtilitarios.agregarCerosNumeroFormato(objcUtilitarios.redondearDecimales(objKardexArticuloProducto.getTotal(), 2), 2) + "\""
                + "}");
    }
    out.print("]");
%>