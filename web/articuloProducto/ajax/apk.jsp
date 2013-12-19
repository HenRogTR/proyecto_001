<%-- 
    Document   : apk
    Created on : 18/12/2013, 06:52:14 PM
    Author     : Henrri
    Descripción: 
--%><%@page import="utilitarios.cManejoFechas"%>
<%@page import="compraClases.cCompra"%>
<%@page import="tablas.Ventas"%>
<%@page import="ventaClases.cVenta"%>
<%@page import="tablas.Compra"%>
<%@page import="utilitarios.cOtros"%>
<%@page import="tablas.KardexArticuloProducto"%>
<%@page import="java.util.Iterator"%>
<%@page import="articuloProductoClases.cKardexArticuloProducto"%>
<%@page import="java.util.List"%>



<%
    int codArticuloProducto = 0;
    int codAlmacen = 0;
    try {
        codArticuloProducto = Integer.parseInt(request.getParameter("codArticuloProducto"));
        codAlmacen = Integer.parseInt(request.getParameter("codAlmacen"));
    } catch (Exception e) {

    }
    List lKardexArticuloProducto = new cKardexArticuloProducto().leer(codArticuloProducto, codAlmacen);
    if (lKardexArticuloProducto != null) {
        if (lKardexArticuloProducto.size() == 0) {
%>
<tr>
    <td colspan="9">
        No hay movimiento de este artículo
    </td>
</tr>
<%
} else {
    cOtros objcOtros = new cOtros();
    String docSerieNumero = "";
    for (Iterator it = lKardexArticuloProducto.iterator(); it.hasNext();) {
        KardexArticuloProducto objKAP = (KardexArticuloProducto) it.next();
        //para ver el tipo de operacion
        switch (objKAP.getTipoOperacion()) {
            case 1: //compra
                Compra objCompra = new cCompra().leer_cod(objKAP.getCodOperacion());
                docSerieNumero = "<a href='../sCompra?accionCompra=mantenimiento&codCompra=" + objCompra.getCodCompra() + "'>" + objCompra.getDocSerieNumero() + "</a>";
                break;
            case 2: //venta
                Ventas objVenta = new cVenta().leer_cod(objKAP.getCodOperacion());
                docSerieNumero = "<a href='../sVenta?accionVenta=mantenimiento&codVenta=" + objVenta.getCodVentas() + "'>" + objVenta.getDocSerieNumero() + "</a>";
                break;
            case 3: //traslado 

                break;
            case 4: //actulizacion manual
                break;
            case 5://reporte por eliminacion de venta
                Ventas objVenta2 = new cVenta().leer_cod(objKAP.getCodOperacion());
                docSerieNumero = "<a href='../sVenta?accionVenta=mantenimiento&codVenta=" + objVenta2.getCodVentas() + "'>" + objVenta2.getDocSerieNumero() + "</a>";
                break;
        }

%>
<tr>
    <td><%=new cManejoFechas().registroAFechaHora(objKAP.getRegistro())%></td>
    <td><%=docSerieNumero%></td>
    <td><%=objKAP.getDetalle()%></td>
    <td class="derecha kap_entrada"><%=objKAP.getEntrada()%></td>
    <td class="derecha kap_salida"><%=objKAP.getSalida()%></td>
    <td class="derecha kap_kardex"><span id="kap_<%=objKAP.getCodKardexArticuloProducto()%>" class="codKardexArticuloProducto"><%=objKAP.getStock()%></span></td>
    <td class="derecha"><%=objcOtros.agregarCerosNumeroFormato(objKAP.getPrecio(), 2)%></td>
    <td class="derecha"><%=objcOtros.agregarCerosNumeroFormato(objKAP.getPrecioPonderado(), 2)%></td>
    <td class="derecha"><%=objcOtros.agregarCerosNumeroFormato(objKAP.getTotal(), 2)%></td>
</tr>
<%
            }
        }
    }

%>