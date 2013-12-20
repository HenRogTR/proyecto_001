<%-- 
    Document   : ksn
    Created on : 19/12/2013, 04:49:02 PM
    Author     : Henrri
--%>
<%@page import="tablas.KardexSerieNumero"%>
<%@page import="articuloProductoClases.cKardexSerieNumero"%>
<%@page import="java.util.Iterator"%>
<%@page import="java.util.List"%>
<%
    int codKAP = 0;
    List KSNList = null;
    try {
        codKAP = Integer.parseInt(request.getParameter("codKAP"));
        KSNList = new cKardexSerieNumero().leer_por_codKardexArticuloProducto(codKAP);
    } catch (Exception e) {

    }
%>
<table class="reporte-tabla-1 anchoTotal" style="font-size: 11px;">
    <thead>
        <tr>
            <th class="ancho40px">Item</th>
            <th class="ancho320px">S/N</th>
            <th>Observaciones</th>
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
            <td><span><%=objKSN.getObservacion() %></span></td>
        </tr>
        <%
                    cant++;
                }
            }
        %>
    </tbody>
</table>