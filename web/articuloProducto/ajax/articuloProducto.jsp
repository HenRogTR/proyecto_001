<%-- 
    Document   : articuloProducto
    Created on : 12/07/2013, 10:51:56 AM
    Author     : Henrri***
--%>



<%@page import="tablas.KardexArticuloProducto"%>
<%@page import="utilitarios.cOtros"%>
<%@page import="articuloProductoClases.cArticuloProducto"%>
<%@page import="tablas.ArticuloProducto"%>
<%
    int codArticuloProducto = 0;
    String parametro = "";
    try {
        codArticuloProducto = Integer.parseInt(request.getParameter("codArticuloProducto"));
        parametro = request.getParameter("parametro").toString();
    } catch (Exception e) {
        out.print("[]");
        return;
    }
    cArticuloProducto objcArticuloProducto = new cArticuloProducto();
    cOtros objcOtros = new cOtros();
    ArticuloProducto objArticuloProducto = null;
    switch (codArticuloProducto) {
        case -1:
            objArticuloProducto = objcArticuloProducto.leer_primero();
            break;
        case 0:
            objArticuloProducto = objcArticuloProducto.leer_ultimo();
            break;
        default:
            objArticuloProducto = objcArticuloProducto.leer_cod(codArticuloProducto);
            while (objArticuloProducto == null) {
                if (parametro.equals("siguiente")) {
                    ArticuloProducto objArticuloProducto1 = objcArticuloProducto.leer_ultimo();
                    codArticuloProducto++;
                    if (codArticuloProducto > objArticuloProducto1.getCodArticuloProducto()) {//para ver que no haya pasado al final
                        objArticuloProducto = objArticuloProducto1;
                    }
                }
                if (parametro.equals("anterior")) {
                    ArticuloProducto objArticuloProducto1 = objcArticuloProducto.leer_primero();
                    codArticuloProducto++;
                    if (codArticuloProducto < objArticuloProducto1.getCodArticuloProducto()) {//para ver que no haya pasado al final
                        objArticuloProducto = objArticuloProducto1;
                    }
                }
                if (parametro.equals("")) {
                    break;
                }
            }
            break;

    }


    out.print("[");
    if (objArticuloProducto != null) {
        session.removeAttribute("codArticuloProductoMantenimiento");
        session.setAttribute("codArticuloProductoMantenimiento", objArticuloProducto.getCodArticuloProducto());
        int stock = 0, codKAP = 0;
        for (KardexArticuloProducto objKardexArticuloProducto : objArticuloProducto.getKardexArticuloProductos()) {
            if (objKardexArticuloProducto.getCodKardexArticuloProducto() > codKAP) {
                codKAP = objKardexArticuloProducto.getCodKardexArticuloProducto();
                stock = objKardexArticuloProducto.getStock();
            }
        }
        out.println("{"
                + " \"codArticuloProducto\" : \"" + objcOtros.agregarCeros_int(objArticuloProducto.getCodArticuloProducto(), 8) + "\""
                + ",\"codReferencia\" : \"" + (objArticuloProducto.getCodReferencia() == null ? "" : objArticuloProducto.getCodReferencia()) + "\" "
                + ",\"descripcion\" : \"" + objcOtros.replace_comillas_comillasD_barraInvertida(objArticuloProducto.getDescripcion()) + "\" "
                + ",\"precioVenta\":\"" + objcOtros.agregarCerosNumeroFormato(objArticuloProducto.getPrecioVenta(), 2) + "\""
                + ",\"familia\" : \"" + objArticuloProducto.getFamilia().getFamilia() + "\" "
                + ",\"marca\" : \"" + objArticuloProducto.getMarca().getDescripcion() + "\" "
                + ",\"unidadMedida\" : \"" + objArticuloProducto.getUnidadMedida() + "\" "
                + ",\"usarSerieNumero\" : \"" + (objArticuloProducto.getUsarSerieNumero() ? "HABILITADO" : "DESABILITADO") + "\""
                + ",\"reintegroTributario\" : \"" + (objArticuloProducto.getReintegroTributario() ? "SI" : "NO") + "\""
                + ",\"observaciones\" : \"" + objArticuloProducto.getObservaciones() + "\""
                + ",\"registro\" : \"" + objArticuloProducto.getRegistro() + "\""
                + ",\"stock\" : \"" + stock + "\""
                + "}");
    }
    out.print("]");
%>