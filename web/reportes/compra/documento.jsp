<%-- 
    Document   : documento
    Created on : 27/03/2014, 05:49:02 PM
    Author     : Henrri
--%>
<%@page import="personaClases.cProveedor"%>
<%@page import="tablas.CompraSerieNumero"%>
<%@page import="compraClases.cCompraSerieNumero"%>
<%@page import="utilitarios.cOtros"%>
<%@page import="java.util.Iterator"%>
<%@page import="compraClases.cCompra"%>
<%@page import="java.util.List"%>
<%@page import="utilitarios.cManejoFechas"%>
<%@page import="utilitarios.cValidacion"%>
<%@page import="java.util.Date"%>
<%@page import="tablas.Proveedor"%>
<%
    String reporte = "";
    try {
        reporte = request.getParameter("reporte").toString();
    } catch (Exception e) {
        out.print("Parámetro reporte no encontrado.");
        return;
    }

    String tituloString = " r. comprados ";
    String cabeceraString = "";
    String orden = "";

    String fechaInicioString = "";
    String fechaFinString = "";
    Date fechaInicioDate = null;
    Date fechaFinDate = null;
    List compraList = null;
    cCompra objcCompra = new cCompra();
    Integer codProveedorInteger = 0;
    Proveedor objProveedor = null;

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

    if (reporte.equals("documento")) {
        compraList = objcCompra.leer_fechas_SC(fechaInicioDate, fechaFinDate);
    }
    if (reporte.equals("proveedor_documento")) {
        try {
            codProveedorInteger = Integer.parseInt(request.getParameter("codProveedor"));
            objProveedor = new cProveedor().leer_cod(codProveedorInteger);
            if (objProveedor == null) {
                out.print("Proveedor no encontrado.");
                return;
            }
        } catch (Exception e) {
            out.print("Código de proveedor no encontrado");
            return;
        }
        compraList = objcCompra.leer_proveedor_fechas_SC(fechaInicioDate, fechaFinDate, codProveedorInteger);
        cabeceraString = "<tr><th colspan=\"5\">PROVEEDOR: " + objProveedor.getRazonSocial() + "</th></tr>";
    }

    if (compraList == null) {
        out.print(reporte + " list -> null. <br>Error -> " + objcCompra.getError());
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
                <table class="tabla-imprimir">
                    <thead>
                        <tr>
                            <th colspan="2">
                                REGISTRO DE COMPRAS PERIODO <%=fechaInicioString + " - " + fechaFinString%>
                            </th>
                            <th style="text-align: right;" colspan="3"><%=new cManejoFechas().fechaHoraActual()%></th>
                        </tr>
                        <%=cabeceraString%>
                        <tr class="top2">
                            <th></th>
                            <th>Proveedor</th>
                            <th>Fecha</th>
                            <th>Documento</th>
                            <th>Tipo</th>
                        </tr>
                    </thead>
                    <tbody>
                        <%
                            Integer codCompra = 0;
                            String docSerieNumero = "";
                            Date fechaFactura = null;
                            String tipo = "";
                            String observacion = "";
                            Double neto = 0.00;
                            Integer codProveedor = 0;
                            String ruc = "";
                            String razonSocial = "";
                            Integer codCompraDetalle = 0;
                            Integer codArticuloProducto = 0;
                            Integer cantidad = 0;
                            String descripcion = "";
                            Boolean usarSerieNumero = null;
                            Double precioUnitario = 0.00;
                            Double precioTotal = 0.00;

                            Integer codCompraAux = 0;

                            for (Iterator it = compraList.iterator(); it.hasNext();) {
                                Object dato[] = (Object[]) it.next();

                                codCompra = (Integer) dato[0];
                                docSerieNumero = (String) dato[1];
                                fechaFactura = (Date) dato[2];
                                tipo = (String) dato[3];
                                observacion = (String) dato[4];
                                codProveedor = (Integer) dato[6];
                                ruc = (String) dato[7];
                                razonSocial = (String) dato[8];
                                codCompraDetalle = (Integer) dato[9];
                                codArticuloProducto = (Integer) dato[10];
                                cantidad = (Integer) dato[11];
                                descripcion = (String) dato[12];
                                usarSerieNumero = (Boolean) dato[13];
                                precioUnitario = (Double) dato[14];
                                precioTotal = (Double) dato[15];

                                if (!codCompraAux.equals(codCompra)) {
                                    if (!codCompraAux.equals(0)) {
                        %>
                        <tr class="top1">
                            <td class="derecha" style="padding-right: 5px; font-weight: bold;"><span>Observación</span></td>
                            <td><%=new cOtros().replace_comillas_comillasD_barraInvertida(observacion)%></td>
                            <th style="padding-left: 5px;">Sub Total</th>
                            <th class="derecha" style="padding-right: 5px;"><%=new cOtros().agregarCerosNumeroFormato(neto, 2)%></th>
                        </tr>
                        <tr>
                            <th style="height: 20px;"></th>
                        </tr>
                        <%
                            }
                        %>
                        <tr class="top1">
                            <th class="ancho100px" style="padding-left: 5px;"><span><%=ruc%></span></th>
                            <th style="padding-left: 5px;"><span><%=razonSocial%></span></th>
                            <th class="ancho100px"><span><%=new cManejoFechas().DateAString(fechaFactura)%></span></th>
                            <th class="ancho100px"><span><%=docSerieNumero%></span></th>
                            <th class="ancho80px"><span><%=tipo.toUpperCase()%></span></th>
                        </tr>
                        <%
                                codCompraAux = codCompra;
                            }
                            neto = (Double) dato[5];
                        %>
                        <tr>
                            <td class="derecha" style="padding-right: 5px;"><span><%=cantidad%></span></td>
                            <td class="izquierda" style="padding-left: 5px;"><span><%=new cOtros().agregarCeros_int(codArticuloProducto, 8)%> / <%=new cOtros().replace_comillas_comillasD_barraInvertida(descripcion)%></span></td>
                            <td class="derecha" style="padding-right: 5px;"><span><%=new cOtros().decimalFormato(precioUnitario, 4)%></span></td>
                            <td class="derecha" style="padding-right: 5px;"><span><%=new cOtros().decimalFormato(precioTotal, 2)%></span></td>
                        </tr>
                        <%
                            if (usarSerieNumero) {
                        %>
                        <tr>
                            <td></td>
                            <td>
                                <div style="padding-left: 15px; font-size: 11px;">
                                    <%
                                        List csnList = new cCompraSerieNumero().leer_codCompraDetalle(codCompraDetalle);
                                        for (Iterator it2 = csnList.iterator(); it2.hasNext();) {
                                            CompraSerieNumero objCSN = (CompraSerieNumero) it2.next();
                                            out.print(new cOtros().replace_comillas_comillasD_barraInvertida(objCSN.getSerieNumero()) + "<br>");
                                        }
                                    %>
                                </div>
                            </td>
                        </tr>
                        <%                                }
                            if (!it.hasNext()) {
                        %>
                        <tr class="top1">
                            <td class="derecha" style="padding-right: 5px; font-weight: bold;"><span>Observación</span></td>
                            <td><%=new cOtros().replace_comillas_comillasD_barraInvertida(observacion)%></td>
                            <th style="padding-left: 5px;">Sub Total</th>
                            <th class="derecha" style="padding-right: 5px;"><%=new cOtros().agregarCerosNumeroFormato(neto, 2)%></th>
                        </tr>
                        <%
                                }
                            }
                        %>
                    </tbody>
                </table>
            </div>
        </div>
    </body>
</html>
