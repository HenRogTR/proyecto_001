<%-- 
    Document   : serieNumeroStockLeer
    Created on : 18/10/2013, 05:46:41 PM
    Author     : Henrri
--%>

<%@page import="tablas.KardexSerieNumero"%>
<%@page import="utilitarios.cOtros"%>
<%@page import="articuloProductoClases.cKardexArticuloProducto"%>
<%@page import="tablas.KardexArticuloProducto"%>


[
<%
    try {
        int codArticuloProducto = Integer.parseInt(request.getParameter("codArticuloProducto"));
        int codAlmacen = Integer.parseInt(request.getParameter("codAlmacen"));
        KardexArticuloProducto objKardexArticuloProducto = new cKardexArticuloProducto().leer_articuloProductoStock(codArticuloProducto, codAlmacen);
        if (objKardexArticuloProducto != null) {
            int cont = 0;
            cOtros objcOtros = new cOtros();
            for (KardexSerieNumero objKardexSerieNumero : objKardexArticuloProducto.getKardexSerieNumeros()) {
                if (objKardexSerieNumero.getRegistro().substring(0, 1).equals("1")) {//solo habilitados
                    if (cont++ > 0) {
                        out.print(",");
                    }
                    out.print("{"
                            + "\"codKardexSerieNumero\":" + objKardexSerieNumero.getCodKardexSerieNumero()
                            + ",\"serieNumero\":\"" + objcOtros.replace_comillas_comillasD_barraInvertida(objKardexSerieNumero.getSerieNumero()) + "\""
                            + ",\"observacion\":\"" + objcOtros.replace_comillas_comillasD_barraInvertida(objKardexSerieNumero.getObservacion()) + "\""
                            + ",\"codCompraSerieNumero\":" + objKardexSerieNumero.getCompraSerieNumeroCodCompraSerieNumero()
                            + "}");
                }
            }
        }

    } catch (Exception e) {

    }
%>
]