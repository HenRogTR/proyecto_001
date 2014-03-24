<%-- 
    Document   : articuloProducto
    Created on : 19/03/2014, 11:01:36 AM
    Author     : Henrri
--%>

<%@page import="java.util.Date"%>
<%@page import="utilitarios.cManejoFechas"%>
<%@page import="articuloProductoClases.cMarca"%>
<%@page import="articuloProductoClases.cFamilia"%>
<%@page import="tablas.Familia"%>
<%@page import="tablas.Marca"%>
<%@page import="tablas.KardexSerieNumero"%>
<%@page import="articuloProductoClases.cKardexSerieNumero"%>
<%@page import="utilitarios.cOtros"%>
<%@page import="java.util.Iterator"%>
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

    String tituloString = " r. stock ";
    String cabeceraString = "";
    String orden = "";
    String inventario = "";
    String nombreArchivoString = "";

    String pCompra = request.getParameter("pCompra");
    String pVenta = request.getParameter("pVenta");
    String sn = request.getParameter("sn");

    List aPList = null;
    cArticuloProducto objcArticuloProducto = new cArticuloProducto();
    Integer codFamiliaInteger = 0;
    Familia objFamilia = null;
    Integer codMarcaInteger = 0;
    Marca objMarca = null;

    int tamanioLista = 0;

    //nivel 1
    if (reporte.equals("alfabetico_inventarioGeneral")) {
        aPList = objcArticuloProducto.leer_inventario_ordenDescripcion_SC();
        orden += "ALFABÉTICO";
        tituloString += "";
        inventario += "GENERAL";
        nombreArchivoString += " GENERAL";
    }
    if (reporte.equals("normal_inventarioGeneral")) {
        aPList = objcArticuloProducto.leer_inventario_SC();
        orden += "CÓDIGO";
        inventario += "GENERAL";
        nombreArchivoString += " GENERAL";
    }
    if (reporte.equals("alfabetico_conStock")) {
        aPList = objcArticuloProducto.leer_inventario_ordenDescripcion_SC();
        tamanioLista = aPList.size();
        for (int i = 0; i < tamanioLista; i++) {
            Object dato[] = (Object[]) aPList.get(i);
            Integer stockTempInteger = (Integer) (dato[6] == null ? 0 : dato[6]);
            if (stockTempInteger < 1) {
                aPList.remove(i);
                tamanioLista--;
                i--;
            }
        }
        orden += "ALFABÉTICO";
        inventario += "CON STOCK";
        nombreArchivoString += " CON STOCK";
    }
    if (reporte.equals("normal_conStock")) {
        aPList = objcArticuloProducto.leer_inventario_SC();
        tamanioLista = aPList.size();
        for (int i = 0; i < tamanioLista; i++) {
            Object dato[] = (Object[]) aPList.get(i);
            Integer stockTempInteger = (Integer) (dato[6] == null ? 0 : dato[6]);
            if (stockTempInteger < 1) {
                aPList.remove(i);
                tamanioLista--;
                i--;
            }
        }
        orden += "CÓDIGO";
        inventario += "CON STOCK";
        nombreArchivoString += " CON STOCK";
    }
    if (reporte.equals("alfabetico_sinStock")) {
        aPList = objcArticuloProducto.leer_inventario_ordenDescripcion_SC();
        tamanioLista = aPList.size();
        for (int i = 0; i < tamanioLista; i++) {
            Object dato[] = (Object[]) aPList.get(i);
            Integer stockTempInteger = (Integer) (dato[6] == null ? 0 : dato[6]);
            if (stockTempInteger > 0) {
                aPList.remove(i);
                tamanioLista--;
                i--;
            }
        }
        orden += "ALFABÉTICO";
        inventario += "SIN STOCK";
        nombreArchivoString += " SIN STOCK";
    }
    if (reporte.equals("normal_sinStock")) {
        aPList = objcArticuloProducto.leer_inventario_SC();
        tamanioLista = aPList.size();
        for (int i = 0; i < tamanioLista; i++) {
            Object dato[] = (Object[]) aPList.get(i);
            Integer stockTempInteger = (Integer) (dato[6] == null ? 0 : dato[6]);
            if (stockTempInteger > 0) {
                aPList.remove(i);
                tamanioLista--;
                i--;
            }
        }
        orden += "CÓDIGO";
        inventario += "SIN STOCK";
        nombreArchivoString += " SIN STOCK";
    }

    //nivel 2
    if (reporte.equals("alfabetico_familia_inventarioGeneral")) {
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
        aPList = objcArticuloProducto.leer_inventario_familia_ordenDescripcion_SC(codFamiliaInteger);
        orden += "ALFABÉTICO";
        inventario += "GENERAL";
        cabeceraString += "<tr><th colspan=\"3\">FAMILIA: " + objFamilia.getFamilia() + "</th></tr>";
        nombreArchivoString += " GENERAL F: " + objFamilia.getFamilia();
    }
    if (reporte.equals("alfabetico_familia_conStock")) {
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
        aPList = objcArticuloProducto.leer_inventario_familia_ordenDescripcion_SC(codFamiliaInteger);
        tamanioLista = aPList.size();
        for (int i = 0; i < tamanioLista; i++) {
            Object dato[] = (Object[]) aPList.get(i);
            Integer stockTempInteger = (Integer) (dato[6] == null ? 0 : dato[6]);
            if (stockTempInteger < 1) {
                aPList.remove(i);
                tamanioLista--;
                i--;
            }
        }
        orden += "ALFABÉTICO";
        inventario += "CON STOCK";
        cabeceraString += "<tr><th colspan=\"3\">FAMILIA: " + objFamilia.getFamilia() + "</th></tr>";
        nombreArchivoString += " CON STOCK F: " + objFamilia.getFamilia();
    }
    if (reporte.equals("alfabetico_familia_sinStock")) {
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
        aPList = objcArticuloProducto.leer_inventario_familia_ordenDescripcion_SC(codFamiliaInteger);
        tamanioLista = aPList.size();
        for (int i = 0; i < tamanioLista; i++) {
            Object dato[] = (Object[]) aPList.get(i);
            Integer stockTempInteger = (Integer) (dato[6] == null ? 0 : dato[6]);
            if (stockTempInteger > 0) {
                aPList.remove(i);
                tamanioLista--;
                i--;
            }
        }
        orden += "ALFABÉTICO";
        inventario += "SIN STOCK";
        cabeceraString += "<tr><th colspan=\"3\">FAMILIA: " + objFamilia.getFamilia() + "</th></tr>";
        nombreArchivoString += " SIN STOCK F: " + objFamilia.getFamilia();
    }
    if (reporte.equals("normal_familia_inventarioGeneral")) {
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
        aPList = objcArticuloProducto.leer_inventario_familia_SC(codFamiliaInteger);
        orden += "CÓDIGO";
        inventario += "GENERAL";
        cabeceraString += "<tr><th colspan=\"3\">FAMILIA: " + objFamilia.getFamilia() + "</th></tr>";
        nombreArchivoString += " GENERAL F: " + objFamilia.getFamilia();
    }
    if (reporte.equals("normal_familia_conStock")) {
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
        aPList = objcArticuloProducto.leer_inventario_familia_SC(codFamiliaInteger);
        tamanioLista = aPList.size();
        for (int i = 0; i < tamanioLista; i++) {
            Object dato[] = (Object[]) aPList.get(i);
            Integer stockTempInteger = (Integer) (dato[6] == null ? 0 : dato[6]);
            if (stockTempInteger < 1) {
                aPList.remove(i);
                tamanioLista--;
                i--;
            }
        }
        orden += "CÓDIGO";
        inventario += "CON STOCK";
        cabeceraString += "<tr><th colspan=\"3\">FAMILIA: " + objFamilia.getFamilia() + "</th></tr>";
        nombreArchivoString += " CON STOCK F: " + objFamilia.getFamilia();
    }
    if (reporte.equals("normal_familia_sinStock")) {
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
        aPList = objcArticuloProducto.leer_inventario_familia_SC(codFamiliaInteger);
        tamanioLista = aPList.size();
        for (int i = 0; i < tamanioLista; i++) {
            Object dato[] = (Object[]) aPList.get(i);
            Integer stockTempInteger = (Integer) (dato[6] == null ? 0 : dato[6]);
            if (stockTempInteger > 0) {
                aPList.remove(i);
                tamanioLista--;
                i--;
            }
        }
        orden += "CÓDIGO";
        inventario += "SIN STOCK";
        cabeceraString += "<tr><th colspan=\"3\">FAMILIA: " + objFamilia.getFamilia() + "</th></tr>";
        nombreArchivoString += " SIN STOCK F: " + objFamilia.getFamilia();
    }

    //nivel 3
    if (reporte.equals("alfabetico_familia_marca_inventarioGeneral")) {
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
        aPList = objcArticuloProducto.leer_inventario_familia_marca_ordenDescripcion_SC(codFamiliaInteger, codMarcaInteger);
        orden += "ALFABÉTICO";
        inventario += "GENERAL";
        cabeceraString += "<tr><th colspan=\"3\">FAMILIA: " + objFamilia.getFamilia() + " / MARCA: " + objMarca.getDescripcion() + "</th></tr>";
        nombreArchivoString += " GENERAL F: " + objFamilia.getFamilia() + " M: " + objMarca.getDescripcion();
    }
    if (reporte.equals("alfabetico_familia_marca_conStock")) {
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
        aPList = objcArticuloProducto.leer_inventario_familia_marca_ordenDescripcion_SC(codFamiliaInteger, codMarcaInteger);
        tamanioLista = aPList.size();
        for (int i = 0; i < tamanioLista; i++) {
            Object dato[] = (Object[]) aPList.get(i);
            Integer stockTempInteger = (Integer) (dato[6] == null ? 0 : dato[6]);
            if (stockTempInteger < 1) {
                aPList.remove(i);
                tamanioLista--;
                i--;
            }
        }
        orden += "ALFABÉTICO";
        inventario += "CON STOCK";
        cabeceraString += "<tr><th colspan=\"3\">FAMILIA: " + objFamilia.getFamilia() + " / MARCA: " + objMarca.getDescripcion() + "</th></tr>";
        nombreArchivoString += " CON STOCK F: " + objFamilia.getFamilia() + " M: " + objMarca.getDescripcion();
    }
    if (reporte.equals("alfabetico_familia_marca_sinStock")) {
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
        aPList = objcArticuloProducto.leer_inventario_familia_marca_ordenDescripcion_SC(codFamiliaInteger, codMarcaInteger);
        tamanioLista = aPList.size();
        for (int i = 0; i < tamanioLista; i++) {
            Object dato[] = (Object[]) aPList.get(i);
            Integer stockTempInteger = (Integer) (dato[6] == null ? 0 : dato[6]);
            if (stockTempInteger > 0) {
                aPList.remove(i);
                tamanioLista--;
                i--;
            }
        }
        orden += "ALFABÉTICO";
        inventario += "SIN STOCK";
        cabeceraString += "<tr><th colspan=\"3\">FAMILIA: " + objFamilia.getFamilia() + " / MARCA: " + objMarca.getDescripcion() + "</th></tr>";
        nombreArchivoString += " SIN STOCK F: " + objFamilia.getFamilia() + " M: " + objMarca.getDescripcion();
    }
    if (reporte.equals("normal_familia_marca_inventarioGeneral")) {
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
        aPList = objcArticuloProducto.leer_inventario_familia_marca_SC(codFamiliaInteger, codMarcaInteger);
        orden += "CÓDIGO";
        inventario += "GENERAL";
        cabeceraString += "<tr><th colspan=\"3\">FAMILIA: " + objFamilia.getFamilia() + " / MARCA: " + objMarca.getDescripcion() + "</th></tr>";
        nombreArchivoString += " GENERAL F: " + objFamilia.getFamilia() + " M: " + objMarca.getDescripcion();
    }
    if (reporte.equals("normal_familia_marca_conStock")) {
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
        aPList = objcArticuloProducto.leer_inventario_familia_marca_SC(codFamiliaInteger, codMarcaInteger);
        tamanioLista = aPList.size();
        for (int i = 0; i < tamanioLista; i++) {
            Object dato[] = (Object[]) aPList.get(i);
            Integer stockTempInteger = (Integer) (dato[6] == null ? 0 : dato[6]);
            if (stockTempInteger < 1) {
                aPList.remove(i);
                tamanioLista--;
                i--;
            }
        }
        orden += "CÓDIGO";
        inventario += "CON STOCK";
        cabeceraString += "<tr><th colspan=\"3\">FAMILIA: " + objFamilia.getFamilia() + " / MARCA: " + objMarca.getDescripcion() + "</th></tr>";
        nombreArchivoString += " CON STOCK F: " + objFamilia.getFamilia() + " M: " + objMarca.getDescripcion();
    }
    if (reporte.equals("normal_familia_marca_sinStock")) {
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
        aPList = objcArticuloProducto.leer_inventario_familia_marca_SC(codFamiliaInteger, codMarcaInteger);
        tamanioLista = aPList.size();
        for (int i = 0; i < tamanioLista; i++) {
            Object dato[] = (Object[]) aPList.get(i);
            Integer stockTempInteger = (Integer) (dato[6] == null ? 0 : dato[6]);
            if (stockTempInteger > 0) {
                aPList.remove(i);
                tamanioLista--;
                i--;
            }
        }
        orden += "CÓDIGO";
        inventario += "SIN STOCK";
        cabeceraString += "<tr><th colspan=\"3\">FAMILIA: " + objFamilia.getFamilia() + " / MARCA: " + objMarca.getDescripcion() + "</th></tr>";
        nombreArchivoString += " SIN STOCK F: " + objFamilia.getFamilia() + " M: " + objMarca.getDescripcion();
    }
    if (aPList == null) {
        out.print(reporte + " list -> null. <br>Error -> " + objcArticuloProducto.getError());
        return;
    }
    response.setContentType("application/vnd.ms-excel"); //Tipo de fichero.
    response.setHeader("Content-Disposition", "attachment;filename=\"INVENTARIO DE ARTÍCULOS AL " + new cManejoFechas().DateAString2(new Date()) + " " + nombreArchivoString + " " + new cManejoFechas().fechaHoraActualNumerosLineal() + ".xls\"");
%>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <title><%=tituloString%></title>
    </head>
    <body>
        <table>
            <thead>
                <tr>
                    <th colspan="2">REPORTE DE ARTÍCULOS - <%=inventario%> - (<%=orden%>) AL <%=new cManejoFechas().DateAString(new Date())%></th>
                </tr>
                <%=cabeceraString%>
                <tr>
                    <th style="width: 80px;"><span>Código</span></th>
                    <th style="width: 400px;"><span>Descripción</span></th>
                        <%
                            if (pCompra != null) {
                        %>
                    <th style="width: 80px;"><label>P. Compra</label></th>
                        <%                                    }
                            if (pVenta != null) {
                        %>
                    <th style="width: 80px;"><label>P. Venta</label></th>
                        <%                                            }
                        %>
                    <th style="width: 80px;"><label>Stock actual</label></th>
                </tr>
            </thead>
            <tbody>
                <%
                    Integer codAP = 0;
                    String descripcion = "";
                    Boolean usarSerieNumero = null;
                    Double precioCompra = 0.00;
                    Double precioVenta = 0.00;
                    Integer codKAP = 0;
                    Integer stock = 0;
                    for (Iterator it = aPList.iterator(); it.hasNext();) {
                        Object dato[] = (Object[]) it.next();
                        codAP = (Integer) dato[0];
                        descripcion = (String) dato[1];
                        usarSerieNumero = (Boolean) dato[2];
                        precioCompra = (Double) dato[3];
                        precioVenta = (Double) dato[4];
                        codKAP = (Integer) dato[5];
                        stock = (Integer) (dato[6] == null ? 0 : dato[6]);
                %>
                <tr>
                    <td style="text-align: right;padding-right: 5px; mso-number-format:'@'; vertical-align: top;"><%=new cOtros().agregarCeros_int(codAP, 8)%></td>
                    <td><%=descripcion%></td>
                    <%
                        if (pCompra != null) {

                    %>
                    <td style="text-align: right; mso-number-format:'0.0000'; vertical-align: top;"><%=new cOtros().decimalFormato(precioCompra, 4)%></td>
                    <%
                        }
                        if (pVenta != null) {
                    %>
                    <td style="text-align: right; mso-number-format:'0.00'; vertical-align: top;"><%=new cOtros().decimalFormato(precioVenta, 2)%></td>
                    <%
                        }
                    %>
                    <td style="text-align: right; mso-number-format:'0.00'; vertical-align: top;"><%=stock%></td>
                </tr>
                <%
                    if (sn != null) {
                        if (usarSerieNumero & codKAP != null & stock > 0) {
                %>
                <tr>
                    <td></td>
                    <td colspan="4">
                        <div style="padding-left: 15px; font-size: 11px;">

                            <%
                                List ksnList = new cKardexSerieNumero().leer_por_codKardexArticuloProducto(codKAP);
                                for (Iterator it2 = ksnList.iterator(); it2.hasNext();) {
                                    KardexSerieNumero objKSN = (KardexSerieNumero) it2.next();
                                    out.print(objKSN.getSerieNumero() + "<br>");
                                }
                            %>
                        </div>
                    </td>
                </tr>
                <%                                }
                        }
                    }
                %>
            </tbody>
        </table>
    </body>
</html>
