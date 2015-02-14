<%-- 
    Document   : copiar datos
    Created on : 01/10/2014, 05:01:51 PM
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
            String origen = "sicci_aguaytia_importadora";
            String destino = "sicci_aguaytia_importadora_auditar";
        %>

        -- almacen<br>
        INSERT INTO <%=destino%>.almacen SELECT * FROM <%=origen%>.almacen; <br>
        -- area<br>
        INSERT INTO <%=destino%>.area SELECT * FROM <%=origen%>.area; <br>
        -- familia<br>
        INSERT INTO <%=destino%>.familia SELECT * FROM <%=origen%>.familia; <br>
        -- marca<br>
        INSERT INTO <%=destino%>.marca SELECT * FROM <%=origen%>.marca; <br>
        -- articulo_producto<br>
        INSERT INTO <%=destino%>.articulo_producto SELECT * FROM <%=origen%>.articulo_producto; <br>
        -- zona<br>
        INSERT INTO <%=destino%>.zona SELECT * FROM <%=origen%>.zona; <br>
        -- persona<br>
        INSERT INTO <%=destino%>.persona SELECT * FROM <%=origen%>.persona; <br>
        -- cobranza<br>
        INSERT INTO <%=destino%>.cobranza SELECT * FROM <%=origen%>.cobranza; <br>
        -- ventas<br>
        INSERT INTO <%=destino%>.ventas SELECT * FROM <%=origen%>.ventas; <br>
        -- venta_credito_letra<br>
        INSERT INTO <%=destino%>.venta_credito_letra SELECT * FROM <%=origen%>.venta_credito_letra; <br>
        -- cobranza_detalle<br>
        INSERT INTO <%=destino%>.cobranza_detalle SELECT * FROM <%=origen%>.cobranza_detalle; <br>
        -- proveedor<br>
        INSERT INTO <%=destino%>.proveedor SELECT * FROM <%=origen%>.proveedor; <br>
        -- compra<br>
        INSERT INTO <%=destino%>.compra SELECT * FROM <%=origen%>.compra; <br>
        -- compra_detalle<br>
        INSERT INTO <%=destino%>.compra_detalle SELECT * FROM <%=origen%>.compra_detalle; <br>
        -- compra_serie_numero<br>
        INSERT INTO <%=destino%>.compra_serie_numero SELECT * FROM <%=origen%>.compra_serie_numero; <br>
        -- comprobante_pago<br>
        INSERT INTO <%=destino%>.comprobante_pago SELECT * FROM <%=origen%>.comprobante_pago; <br>
        -- empresa_convenio<br>
        INSERT INTO <%=destino%>.empresa_convenio SELECT * FROM <%=origen%>.empresa_convenio; <br>
        -- datos_cliente<br>
        INSERT INTO <%=destino%>.datos_cliente SELECT * FROM <%=origen%>.datos_cliente; <br>
        -- datos_extras<br>
        INSERT INTO <%=destino%>.datos_extras SELECT * FROM <%=origen%>.datos_extras; <br>
        -- detalle_descripcion<br>
        INSERT INTO <%=destino%>.detalle_descripcion SELECT * FROM <%=origen%>.detalle_descripcion; <br>
        -- estado_documento<br>
        INSERT INTO <%=destino%>.estado_documento SELECT * FROM <%=origen%>.estado_documento; <br>
        -- kardex_articulo_producto<br>
        INSERT INTO <%=destino%>.kardex_articulo_producto SELECT * FROM <%=origen%>.kardex_articulo_producto; <br>
        -- kardex_serie_numero<br>
        INSERT INTO <%=destino%>.kardex_serie_numero SELECT * FROM <%=origen%>.kardex_serie_numero; <br>
        -- p_natural<br>
        INSERT INTO <%=destino%>.p_natural SELECT * FROM <%=origen%>.p_natural; <br>
        -- cargo<br>
        INSERT INTO <%=destino%>.cargo SELECT * FROM <%=origen%>.cargo; <br>
        -- personal<br>
        INSERT INTO <%=destino%>.personal SELECT * FROM <%=origen%>.personal; <br>
        -- precio_venta<br>
        INSERT INTO <%=destino%>.precio_venta SELECT * FROM <%=origen%>.precio_venta; <br>
        -- tipo_documento<br>
        INSERT INTO <%=destino%>.tipo_documento SELECT * FROM <%=origen%>.tipo_documento; <br>
        -- tramite_documentario<br>
        INSERT INTO <%=destino%>.tramite_documentario SELECT * FROM <%=origen%>.tramite_documentario; <br>
        -- usuario<br>
        INSERT INTO <%=destino%>.usuario SELECT * FROM <%=origen%>.usuario; <br>
        -- ventas_detalle<br>
        INSERT INTO <%=destino%>.ventas_detalle SELECT * FROM <%=origen%>.ventas_detalle; <br>
        -- ventas_serie_numero<br>
        INSERT INTO <%=destino%>.ventas_serie_numero SELECT * FROM <%=origen%>.ventas_serie_numero; <br>
        -- comprobante_pago_detalle<br>
        INSERT INTO <%=destino%>.comprobante_pago_detalle SELECT * FROM <%=origen%>.comprobante_pago_detalle; <br>
        -- documento_notificacion<br>
        INSERT INTO <%=destino%>.documento_notificacion SELECT * FROM <%=origen%>.documento_notificacion<br>
    </body>
</html>
