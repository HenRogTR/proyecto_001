<%-- 
    Document   : sesiones
    Created on : 10/01/2014, 12:59:59 PM
    Author     : Henrri
--%>

<%@page import="HiberanteUtil.HibernateUtil"%>
<%@page import="org.hibernate.stat.Statistics"%>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <title>JSP Page</title>
    </head>
    <body>
        <%
            Statistics stats = HibernateUtil.getSessionFactory().getStatistics();
            //Primero despliego el numero de conexiones que se han pedido a Hibernate
            // (No es el numero actual, sino cuantas se han pedido en total)
            out.println("Connection count: " + stats.getConnectCount());
            out.println("<br>");

            //Numero de transacciones completadas (falladas y satisfactorias)
            out.println("Trx count: " + stats.getTransactionCount());
            out.println("<br>");

            //Numero de transacciones completadas (solo satisfactorias)
            out.println("Succ trx count: " + stats.getSuccessfulTransactionCount());
            out.println("<br>");

            // Numero de sesiones que el codigo ha abierto
            out.println("Opened sessions: " + stats.getSessionOpenCount());
            out.println("<br>");

            // Numero de sesiones que el codigo ha cerrado
            out.println("Closed sessions: " + stats.getSessionCloseCount());
            out.println("<br>");

            // Numero total de queries ejecutados
            out.println("No. queries: " + stats.getQueryExecutionCount());
        %>
    </body>
</html>
