<%-- 
    Document   : vendidos
    Created on : 25/03/2014, 11:39:58 AM
    Author     : Henrri
--%>

<%@page import="articuloProductoClases.cMarca"%>
<%@page import="articuloProductoClases.cFamilia"%>
<%@page import="utilitarios.cOtros"%>
<%@page import="java.util.Iterator"%>
<%@page import="utilitarios.cManejoFechas"%>
<%@page import="utilitarios.cValidacion"%>
<%@page import="java.util.Date"%>
<%@page import="tablas.ArticuloProducto"%>
<%@page import="tablas.Marca"%>
<%@page import="tablas.Familia"%>
<%@page import="articuloProductoClases.cArticuloProducto"%>
<%@page import="java.util.List"%>
<%
    String reporte = "";
    try {
        reporte = request.getParameter("reporte").toString();
    } catch (Exception e) {
        out.print("Parámetro reporte no encontrado.");
        return;
    }

    String tituloString = " r. vendidos ";
    String cabeceraString = "";
    String orden = "";

    String fechaInicioString = "";
    String fechaFinString = "";
    Date fechaInicioDate = null;
    Date fechaFinDate = null;
    List aPList = null;
    cArticuloProducto objcArticuloProducto = new cArticuloProducto();
    Integer codFamiliaInteger = 0;
    Familia objFamilia = null;
    Integer codMarcaInteger = 0;
    Marca objMarca = null;
    Integer codArticuloProductoInteger = 0;
    ArticuloProducto objArticuloProducto = null;

    try {
        fechaInicioString = request.getParameter("fechaInicio").toString();
        fechaFinString = request.getParameter("fechaFin").toString();
        if (!(new cValidacion().validarFecha(fechaInicioString)) || !(new cValidacion().validarFecha(fechaFinString))) {
            out.print("Fecha y/o formato de fecha incorrecta.");
            return;
        }
        fechaInicioDate = new cManejoFechas().StringADate(fechaInicioString);
        fechaFinDate = new cManejoFechas().StringADate(fechaFinString);
        if (fechaInicioDate.compareTo(fechaFinDate) > 0) {
            out.print("Las fechas estan fuera de rango.");
            return;
        }
    } catch (Exception e) {
        out.print("Fechas no encontradas.");
        return;
    }
    //nivel 1
    if (reporte.equals("vendidos")) {
        aPList = objcArticuloProducto.leer_vendidos_SC(fechaInicioDate, fechaFinDate);
    }
    if (reporte.equals("vendidos_familia")) {
        try {
            codFamiliaInteger = Integer.parseInt(request.getParameter("codFamilia"));
            objFamilia = new cFamilia().leer_cod(codFamiliaInteger);
            if (objFamilia == null) {
                out.print("Familia no encontrado.");
                return;
            }
        } catch (Exception e) {
            out.print("Código de familia no encontrado.");
            return;
        }
        aPList = objcArticuloProducto.leer_vendidos_familia_SC(fechaInicioDate, fechaFinDate, codFamiliaInteger);
        cabeceraString += "<tr><th colspan=\"6\" style=\"padding-left: 5px;\">FAMILIA: " + objFamilia.getFamilia() + "</th></tr>";
    }
    if (reporte.equals("vendidos_familia_marca")) {
        try {
            codFamiliaInteger = Integer.parseInt(request.getParameter("codFamilia"));
            objFamilia = new cFamilia().leer_cod(codFamiliaInteger);
            if (objFamilia == null) {
                out.print("Familia no encontrado.");
                return;
            }
            codMarcaInteger = Integer.parseInt(request.getParameter("codMarca"));
            objMarca = new cMarca().leer_cod(codMarcaInteger);
            if (objMarca == null) {
                out.print("Marca no encontrado.");
                return;
            }
        } catch (Exception e) {
            out.print("Código de familia y/o marca no encontrado.");
            return;
        }
        aPList = objcArticuloProducto.leer_vendidos_familia_marca_SC(fechaInicioDate, fechaFinDate, codFamiliaInteger, codMarcaInteger);
        cabeceraString += "<tr><th colspan=\"6\" style=\"padding-left: 5px;\">FAMILIA: " + objFamilia.getFamilia() + " / MARCA: " + objMarca.getDescripcion() + "</th></tr>";
    }
    if (reporte.equals("vendidos_ap")) {
        try {
            codArticuloProductoInteger = Integer.parseInt(request.getParameter("codAP"));
            objArticuloProducto = new cArticuloProducto().leer_cod(codArticuloProductoInteger);
            if (objArticuloProducto == null) {
                out.print("Artículo no encontrado.");
                return;
            }
        } catch (Exception e) {
            out.print("Código de artículo no encontrado.");
            return;
        }
        aPList = objcArticuloProducto.leer_vendidos_articuloProducto_SC(fechaInicioDate, fechaFinDate, codArticuloProductoInteger);
        cabeceraString += "<tr><th colspan=\"6\" style=\"padding-left: 5px;\">ARTÍCULO PRODUCTO " + objArticuloProducto.getDescripcion() + "</th></tr>";
    }

    if (aPList == null) {
        out.print(reporte + " list -> null. <br>Error -> " + objcArticuloProducto.getError());
        return;
    }
%>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <title><%=tituloString%></title>
        <link rel="stylesheet" type="text/css" href="../../librerias/principal/bodyPrint.css" media="screen"/>
        <link rel="stylesheet" type="text/css" href="../../librerias/principal/bodyPrint.css" media="print"/>
    </head>
    <body>
        <div id="documento">
            <div id="contenido">
                <table class="reporte-tabla-1 anchoTotal">
                    <thead>
                        <tr>
                            <th colspan="5" style="padding-left: 5px;">PRODUCTOS VENDIDOS PERIODO <%=fechaInicioString%> - <%=fechaFinString%></th>
                            <th class="derecha"><%=new cManejoFechas().fechaHoraActual()%></th>
                        </tr>
                        <%=cabeceraString%>
                        <tr class="top2">
                            <th class="centrado ancho80px"><span>FECHA</span></th>
                            <th class="centrado ancho100px"><span>DOCUMENTO</span></th>
                            <th class="centrado ancho60px"><span>CANTIDAD</span></th>
                            <th class="centrado ancho80px"><span>P. UNITARIO</span></th>
                            <th class="centrado ancho80px"><span>V. VENTA</span></th>
                            <th style="padding-left: 5px;"><span>CLIENTE</span></th>
                        </tr>
                    </thead>
                    <tbody>
                        <%
                            Integer codAP = 0;
                            String descripcion = "";
                            Integer codVenta = 0;
                            String docSerieNumero = "";
                            Date fecha = null;
                            String cliente = "";
                            Integer codVentaDetalle = 0;
                            Integer cantidad = 0;
                            Double precioVenta = 0.00;
                            Double valorVenta = 0.00;

                            Integer codAPAux = 0;
                            for (Iterator it = aPList.iterator(); it.hasNext();) {
                                Object dato[] = (Object[]) it.next();

                                codAP = (Integer) dato[0];
                                descripcion = (String) dato[1];
                                codVenta = (Integer) dato[2];
                                docSerieNumero = (String) dato[3];
                                fecha = (Date) dato[4];
                                cliente = (String) dato[5];
                                codVentaDetalle = (Integer) dato[6];
                                cantidad = (Integer) dato[7];
                                precioVenta = (Double) dato[8];
                                valorVenta = (Double) dato[9];

                                if (!codAPAux.equals(codAP)) {
                        %>
                        <tr class="top1">
                            <th class="izquierda" style="padding-left: 5px;"><span><%=new cOtros().agregarCeros_int(codAP, 8)%></span></th>
                            <th colspan="5" style="padding-left: 5px;"><span><%=descripcion%></span></th>
                        </tr>
                        <%
                                codAPAux = codAP;
                            }
                        %>
                        <tr>
                            <td class="derecha" style="padding-right: 5px;"><span><%=new cManejoFechas().DateAString(fecha)%></span></td>
                            <td class="izquierda" style="padding-left: 5px;"><span><%=docSerieNumero%></span></td>
                            <td class="derecha" style="padding-right: 5px;"><span><%=cantidad%></span></td>
                            <td class="derecha" style="padding-right: 5px;"><span><%=new cOtros().decimalFormato(precioVenta, 2)%></span></td>
                            <td class="derecha" style="padding-right: 5px;"><span><%=new cOtros().decimalFormato(valorVenta, 2)%></span></td>
                            <td class="izquierda" style="padding-left: 5px;"><span><%=cliente%></span></td>
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
