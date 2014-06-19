<%-- 
    Document   : compraDetalle
    Created on : 20/12/2013, 05:19:30 PM
    Author     : Henrri
--%>

<%@page import="compraClases.cCompraDetalle"%>
<%@page import="tablas.CompraSerieNumero"%>
<%@page import="utilitarios.cOtros"%>
<%@page import="tablas.CompraDetalle"%>
<%@page import="java.util.Iterator"%>
<%@page import="java.util.List"%>
<%
    int codCompra = 0;
    List CDList = null;
    try {
        codCompra = Integer.parseInt(request.getParameter("codCompra"));
        CDList = new cCompraDetalle().leer_compraDetalle_codCompra(codCompra);
    } catch (Exception e) {

    }
    if (CDList != null) {
        cOtros objcOtros = new cOtros();
        for (Iterator it = CDList.iterator(); it.hasNext();) {
            CompraDetalle objCD = (CompraDetalle) it.next();
%>
<tr>
    <td class="derecha"><div><%=objCD.getItem()%></div></td>
    <td class="derecha"><div><%=objcOtros.agregarCeros_int(objCD.getArticuloProducto().getCodArticuloProducto(), 8)%></div></td>
    <td class="derecha"><div><%=objCD.getCantidad()%></div></td>
    <td class="derecha"><div><%=objCD.getArticuloProducto().getUnidadMedida()%></div></td>
    <td>
        <div><%=objCD.getDescripcion()%></div>
        <div style="margin-left: 10px;">
            <%
                int cont = 0;
                for (CompraSerieNumero objCSN : objCD.getCompraSerieNumeros()) {
                    if (cont++ > 0) {
                        out.print(" \\ ");
                    }
                    out.print(objcOtros.replace_comillas_comillasD_barraInvertida(objCSN.getSerieNumero()));
                    if (!objCSN.getObservacion().equals("")) {
                        out.print("<br>" + objcOtros.replace_comillas_comillasD_barraInvertida(objCSN.getObservacion()));
                    }
                }
            %>
        </div>
    </td>
    <td class="derecha"><div><%=objcOtros.decimalFormato(objCD.getPrecioUnitario(), 4)%></div></td>
    <td class="derecha"><div><%=objcOtros.decimalFormato(objCD.getPrecioTotal(), 4)%></div></td>
</tr>
<%
        }
    }
%>