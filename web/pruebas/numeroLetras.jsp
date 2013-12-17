<%-- 
    Document   : numeroLetras
    Created on : 18/04/2013, 04:41:54 PM
    Author     : Henrri
--%>

<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <title>JSP Page</title>        
        <script type="text/javascript" src="../lib/jquery/jquery-1.8.1.min.js"></script>
        <script type="text/javascript" src="../lib/propios/js/numeroALetras.js"></script>
        <script>
            var num = 1563323323.145;
            var a = Math.round(num * 100) / 100;
            var redondeado = convertirNumLetras(a);
            redondeado;
        </script>
    </head>
    <body>
        <h1>Hello World!</h1>
    </body>
</html>
