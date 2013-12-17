<%-- 
    Document   : precioVentaBuscarAjax
    Created on : 10/03/2013, 12:35:09 PM
    Author     : Henrri
--%>
<%@page import="tablas.KardexSerieNumero"%>
<%@page import="otros.cUtilitarios"%>
<%@page import="articuloProductoClases.cPrecioVenta"%>
<%@page import="tablas.PrecioVenta"%>
<%@page import="articuloProductoClases.cKardexArticuloProducto"%>
<%@page import="tablas.KardexArticuloProducto"%>
<%
    String codArt = request.getParameter("codArticuloProducto");
    String codAlm = request.getParameter("codAlmacen");
    if (codArt == null || codAlm == null) {
        return;
    }
    int codArticuloProducto = Integer.parseInt(codArt);
    int codAlmacen = Integer.parseInt(codAlm);

    cUtilitarios objcUtilitarios = new cUtilitarios();
    KardexArticuloProducto objKardexArticuloProducto = new cKardexArticuloProducto().leer_articuloProductoStock(codArticuloProducto, codAlmacen);
    out.print("[");
    out.print("{");
    if (objKardexArticuloProducto == null) {
        out.print("\"stock\" : " + 0);
        out.print(", \"precioVenta\" : \"" + 0 + "\"");
        out.print(", \"usarSerieNumero\":" + false);
        out.print("}");
    } else {
        out.print("\"stock\" : " + objKardexArticuloProducto.getStock());
        out.print(", \"usarSerieNumero\":" + objKardexArticuloProducto.getArticuloProducto().getUsarSerieNumero());
        out.print("}");
        if (objKardexArticuloProducto.getArticuloProducto().getUsarSerieNumero()) {
            for (KardexSerieNumero objKardexSerieNumero : objKardexArticuloProducto.getKardexSerieNumeros()) {
                if (objKardexSerieNumero.getRegistro().substring(0, 1).equals("1")) {
                    out.print(" , {");
                    out.print("\"codKardexSerieNumero\":" + objKardexSerieNumero.getCodKardexSerieNumero());
                    out.print(",\"serieNumero\":\"" + objcUtilitarios.replace_comillas_comillasD_barraInvertida(objKardexSerieNumero.getSerieNumero()) + "\"");
                    out.print(",\"observacion\":\"" + objcUtilitarios.replace_comillas_comillasD_barraInvertida(objKardexSerieNumero.getObservacion()).replace("\n", "<br>").replace("\r", "") + "\"");
                    out.print("}");
                }
            }
        }
    }
    out.print("]");

%>