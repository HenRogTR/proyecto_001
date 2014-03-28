<%-- 
    Document   : ap
    Created on : 27/03/2014, 05:49:08 PM
    Author     : Henrri
--%>
<%@page import="utilitarios.cOtros"%>
<%@page import="java.util.Iterator"%>
<%@page import="articuloProductoClases.cArticuloProducto"%>
<%@page import="compraClases.cCompra"%>
<%@page import="java.util.List"%>
<%@page import="utilitarios.cManejoFechas"%>
<%@page import="utilitarios.cValidacion"%>
<%@page import="java.util.Date"%>
<%@page import="tablas.Proveedor"%>
<%
    String tituloString = " r. comprados ";
    String cabeceraString = "";
    String orden = "";

    String fechaInicioString = "";
    String fechaFinString = "";
    Date fechaInicioDate = null;
    Date fechaFinDate = null;
    List aPList = null;
    cCompra objcCompra = new cCompra();
    Integer codProveedor = 0;
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
    aPList = new cArticuloProducto().leer_comprados_SC(fechaInicioDate, fechaFinDate);
    if (aPList == null) {
        out.print(" list -> null. <br>Error -> " + objcCompra.getError());
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
                            <th class="centrado ancho60px"><span>CANTIDAD</span></th>
                            <th class="centrado ancho80px"><span>P. UNITARIO</span></th>
                            <th class="centrado ancho80px"><span>V. TOTAL</span></th>
                            <th class="centrado ancho120px"><span>DOCUMENTO</span></th>
                            <th style="padding-left: 5px;"><span>PROVEEDOR</span></th>
                        </tr>
                    </thead>
                    <tbody>
                        <%
                            Integer codAP = 0;
                            String descripcion = "";
                            Integer codCompra = 0;
                            String docSerieNumero = "";
                            Date fechaCompra = null;
                            String proveedor = "";
                            Integer codCompraDetalle = 0;
                            Integer cantidad = 0;
                            Double precioUnitario = 0.00;
                            Double precioTotal = 0.00;

                            Integer codAPAux = 0;
                            for (Iterator it = aPList.iterator(); it.hasNext();) {
                                Object dato[] = (Object[]) it.next();

                                codAP = (Integer) dato[0];
                                descripcion = (String) dato[1];
                                codCompra = (Integer) dato[2];
                                docSerieNumero = (String) dato[3];
                                fechaCompra = (Date) dato[4];
                                proveedor = (String) dato[5];
                                codCompraDetalle = (Integer) dato[6];
                                cantidad = (Integer) dato[7];
                                precioUnitario = (Double) dato[8];
                                precioTotal = (Double) dato[9];

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
                            <td class="derecha" style="padding-right: 5px;"><span><%=new cManejoFechas().DateAString(fechaCompra)%></span></td>
                            <td class="derecha" style="padding-right: 5px;"><span><%=cantidad%></span></td>
                            <td class="derecha" style="padding-right: 5px;"><span><%=new cOtros().decimalFormato(precioUnitario, 2)%></span></td>
                            <td class="derecha" style="padding-right: 5px;"><span><%=new cOtros().decimalFormato(precioTotal, 2)%></span></td>
                            <td class="izquierda" style="padding-left: 15px;"><span><%=docSerieNumero%></span></td>
                            <td class="izquierda" style="padding-left: 5px;"><span><%=proveedor%></span></td>
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
