<%-- 
    Document   : index
    Created on : 16/12/2013, 10:35:54 AM
    Author     : Henrri
--%>

<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <title>JSP Page</title>
    </head>
    <body>
        <%
            String bd_origen = "sicci_pucallpa_importadora";
            String bd_destino = "proyecto_001";
        %>
        <code>
            <br>-- almacen<br>
            INSERT INTO <%=bd_destino%>.almacen SELECT * FROM <%=bd_origen%>.almacen;

            <br>-- area<br>
            INSERT INTO <%=bd_destino%>.area SELECT * FROM <%=bd_origen%>.area;

            <br>-- familia<br>
            INSERT INTO <%=bd_destino%>.familia SELECT * FROM <%=bd_origen%>.familia;

            <br>-- marca<br>
            INSERT INTO <%=bd_destino%>.marca SELECT * FROM <%=bd_origen%>.marca;

            <br>-- articulo_producto<br>
            INSERT INTO <%=bd_destino%>.articulo_producto SELECT * FROM <%=bd_origen%>.articulo_producto;

            <br>-- zona<br>
            INSERT INTO <%=bd_destino%>.zona SELECT * FROM <%=bd_origen%>.zona;

            <br>-- persona<br>
            INSERT INTO <%=bd_destino%>.persona SELECT * FROM <%=bd_origen%>.persona;

            <br>-- cobranza<br>
            INSERT INTO <%=bd_destino%>.cobranza SELECT * FROM <%=bd_origen%>.cobranza;

            <br>-- ventas<br>
            INSERT INTO <%=bd_destino%>.ventas SELECT * FROM <%=bd_origen%>.ventas;

            <br>-- venta_credito<br>
            INSERT INTO <%=bd_destino%>.venta_credito SELECT * FROM <%=bd_origen%>.venta_credito;

            <br>-- venta_credito_letra<br>
            INSERT INTO <%=bd_destino%>.venta_credito_letra SELECT * FROM <%=bd_origen%>.venta_credito_letra;

            <br>-- cobranza_detalle<br>
            INSERT INTO <%=bd_destino%>.cobranza_detalle SELECT * FROM <%=bd_origen%>.cobranza_detalle;

            <br>-- proveedor<br>
            INSERT INTO <%=bd_destino%>.proveedor SELECT * FROM <%=bd_origen%>.proveedor;

            <br>-- compra<br>
            INSERT INTO <%=bd_destino%>.compra SELECT * FROM <%=bd_origen%>.compra;

            <br>-- compra_detalle<br>
            INSERT INTO <%=bd_destino%>.compra_detalle SELECT * FROM <%=bd_origen%>.compra_detalle;

            <br>-- compra_serie_numero<br>
            INSERT INTO <%=bd_destino%>.compra_serie_numero SELECT * FROM <%=bd_origen%>.compra_serie_numero;

            <br>-- comprobante_pago<br>
            INSERT INTO <%=bd_destino%>.comprobante_pago SELECT * FROM <%=bd_origen%>.comprobante_pago;

            <br>-- empresa_convenio<br>
            INSERT INTO <%=bd_destino%>.empresa_convenio SELECT * FROM <%=bd_origen%>.empresa_convenio;

            <br>-- datos_cliente<br>
            INSERT INTO <%=bd_destino%>.datos_cliente SELECT * FROM <%=bd_origen%>.datos_cliente;

            <br>-- datos_extras<br>
            INSERT INTO <%=bd_destino%>.datos_extras SELECT * FROM <%=bd_origen%>.datos_extras;

            <br>-- detalle_descripcion<br>
            INSERT INTO <%=bd_destino%>.detalle_descripcion SELECT * FROM <%=bd_origen%>.detalle_descripcion;

            <br>-- estado_documento<br>
            INSERT INTO <%=bd_destino%>.estado_documento SELECT * FROM <%=bd_origen%>.estado_documento;

            <br>-- kardex_articulo_producto<br>
            INSERT INTO <%=bd_destino%>.kardex_articulo_producto SELECT * FROM <%=bd_origen%>.kardex_articulo_producto;

            <br>-- kardex_serie_numero<br>
            INSERT INTO <%=bd_destino%>.kardex_serie_numero SELECT * FROM <%=bd_origen%>.kardex_serie_numero;

            <br>-- p_natural<br>
            INSERT INTO <%=bd_destino%>.p_natural SELECT * FROM <%=bd_origen%>.p_natural;

            <br>-- cargo<br>
            INSERT INTO <%=bd_destino%>.cargo SELECT * FROM <%=bd_origen%>.cargo;

            <br>-- personal<br>
            INSERT INTO <%=bd_destino%>.personal SELECT * FROM <%=bd_origen%>.personal;

            <br>-- precio_venta<br>
            INSERT INTO <%=bd_destino%>.precio_venta SELECT * FROM <%=bd_origen%>.precio_venta;

            <br>-- tipo_documento<br>
            INSERT INTO <%=bd_destino%>.tipo_documento SELECT * FROM <%=bd_origen%>.tipo_documento;

            <br>-- tramite_documentario<br>
            INSERT INTO <%=bd_destino%>.tramite_documentario SELECT * FROM <%=bd_origen%>.tramite_documentario;

            <br>-- usuario<br>
            INSERT INTO <%=bd_destino%>.usuario SELECT * FROM <%=bd_origen%>.usuario;

            <br>-- ventas_detalle<br>
            INSERT INTO <%=bd_destino%>.ventas_detalle SELECT * FROM <%=bd_origen%>.ventas_detalle;

            <br>-- ventas_serie_numero<br>
            INSERT INTO <%=bd_destino%>.ventas_serie_numero SELECT * FROM <%=bd_origen%>.ventas_serie_numero;

            <br>-- comprobante_pago_detalle<br>
            INSERT INTO <%=bd_destino%>.comprobante_pago_detalle SELECT * FROM <%=bd_origen%>.comprobante_pago_detalle;

            <br>-- documento_notificacion<br>
            INSERT INTO <%=bd_destino%>.documento_notificacion SELECT * FROM <%=bd_origen%>.documento_notificacion;

            <br>-- otros_c_c<br>
            INSERT INTO <%=bd_destino%>.otros_c_c SELECT * FROM <%=bd_origen%>.otros_c_c;

        </code>
    </body>
</html>
