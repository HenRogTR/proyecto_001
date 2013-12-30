<%-- 
    Document   : ksn
    Created on : 19/12/2013, 04:49:02 PM
    Author     : Henrri
--%>
<%@page import="articuloProductoClases.cKardexArticuloProducto"%>
<%@page import="tablas.KardexArticuloProducto"%>
<%@page import="tablas.KardexSerieNumero"%>
<%@page import="articuloProductoClases.cKardexSerieNumero"%>
<%@page import="java.util.Iterator"%>
<%@page import="java.util.List"%>
<%
    int codKAP = 0;
    int codAP = 0;
    List KSNList = null;
    try {
        codAP = Integer.parseInt(request.getParameter("codAP"));
        KardexArticuloProducto objKAP = new cKardexArticuloProducto().leer_articuloProductoStock(codAP, 1);
        KSNList = new cKardexSerieNumero().leer_por_codKardexArticuloProducto(objKAP.getCodKardexArticuloProducto());
    } catch (Exception e) {

    }
%>
<table class="reporte-tabla-1 anchoTotal" style="font-size: 11px;">
    <thead>
        <tr>
            <th class="ancho40px">Item</th>
            <th class="ancho320px">S/N</th>
            <th>Observaciones</th>
            <th class="ancho40px">Opción</th>
        </tr>
    </thead>
    <tfoot>

    </tfoot>
    <tbody>
        <%
            if (KSNList != null) {
                int cant = 1;
                for (Iterator it = KSNList.iterator(); it.hasNext();) {
                    KardexSerieNumero objKSN = (KardexSerieNumero) it.next();
        %>

        <tr>
            <td class="derecha"><span><%=cant%></span></td>
            <td><span><%=objKSN.getSerieNumero()%></span></td>
            <td><span><%=objKSN.getObservacion()%></span></td>
            <td>
                <a class="sexybutton" href="articuloProductoStockEditar.jsp?codKardexSerieNumero=<%=objKSN.getCodKardexSerieNumero()%>" target="_blank"><span><span><span class="edit"></span></span></span></a>
            </td>
        </tr>
        <%
                    cant++;
                }
            }
        %>
    </tbody>
</table>