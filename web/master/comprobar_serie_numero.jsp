<%-- 
    Document   : comprobar_serie_numero
    Created on : 11/12/2013, 06:24:37 PM
    Author     : Henrri
--%>

<%@page import="tablas.KardexArticuloProducto"%>
<%@page import="tablas.KardexArticuloProducto"%>
<%@page import="tablas.ArticuloProducto"%>
<%@page import="articuloProductoClases.cArticuloProducto"%>
<%@page import="java.util.Iterator"%>
<%@page import="java.util.List"%>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <title>JSP Page</title>
    </head>
    <body>
        <%
            List lAP = new cArticuloProducto().leer_admin();
            for (Iterator it = lAP.iterator(); it.hasNext();) {
                ArticuloProducto objAP = (ArticuloProducto) it.next();
                int codKAP = 0;
                KardexArticuloProducto objActual = null;
                for (KardexArticuloProducto objKAP : objAP.getKardexArticuloProductos()) {
                    if (objKAP.getCodKardexArticuloProducto() > codKAP) {
                        codKAP = objKAP.getCodKardexArticuloProducto();
                        objActual = objKAP;
                    }
                }

                if (objActual != null) {
                    if (objActual.getArticuloProducto().getUsarSerieNumero()) {
                        if (objActual.getStock() != objActual.getKardexSerieNumeros().size()) {
                            out.println("codAP=" + objActual.getArticuloProducto().getCodArticuloProducto() + " ::: codKAP=" + objActual.getCodKardexArticuloProducto() + " stock: " + objActual.getStock() + "<br>");
                        }
                    }
                }
            }
        %>
    </body>
</html>
