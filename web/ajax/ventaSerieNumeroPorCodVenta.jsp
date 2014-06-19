<%-- 
    Document   : ventaSerieNumeroPorCodVenta
    Created on : 18/06/2014, 07:19:33 PM
    Author     : Henrri
--%>

<%@page import="clases.cUtilitarios"%>
<%@page import="tablas.VentasSerieNumero"%>
<%@page import="java.util.List"%>
<%@page import="Ejb.EjbVentaSerieNumero"%>
<%
    //evitar el acceso directo por el URL
    if (request.getMethod().equals("GET")) {
        out.print("No tiene permisos para ver este enlace.");
        return;
    }
    //obtenemos el codVenta
    String codVentaString = request.getParameter("codVenta");
    //En caso de que el parametro codCliente no se haya enviado
    if (codVentaString == null) {
        out.print("[Parámetro codVenta no encontrado.]");
        return;
    }
    int codVenta = Integer.parseInt(codVentaString);
    EjbVentaSerieNumero ejbVentaSerieNumero;
    //recuperando
    ejbVentaSerieNumero = new EjbVentaSerieNumero();
    List<VentasSerieNumero> ventasSerieNumeroList = ejbVentaSerieNumero.leerActivoPorCodigoVenta(codVenta, true);
    //obteniendo tamaño
    int tam = ventasSerieNumeroList.size();
    out.print("[");
    for (int i = 0; i < tam; i++) {
        VentasSerieNumero objVentaSerieNumero = ventasSerieNumeroList.get(i);
        if (i > 0) {
            out.print(", ");
        }
        out.print("{"
                + "\"codVentaSerieNumero\":\"" + cUtilitarios.agregarCerosIzquierda(objVentaSerieNumero.getCodVentasSerieNumero(), 8) + "\""
                + ", \"serieNumero\":\"" + cUtilitarios.reemplazarCaracteresEspeciales(objVentaSerieNumero.getSerieNumero()) + "\""
                + ", \"observacion\":\"" + cUtilitarios.reemplazarCaracteresEspeciales(objVentaSerieNumero.getObservacion()) + "\""
                + ", \"registro\":\"" + objVentaSerieNumero.getRegistro() + "\""
                + "}");
    }
    out.print("]");
%>
