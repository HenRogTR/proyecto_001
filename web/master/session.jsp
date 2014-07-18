<%-- 
    Document   : session
    Created on : 30/06/2014, 01:31:10 PM
    Author     : Henrri
--%>

<%@page import="java.util.Date"%>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <title>JSP Page</title>
    </head>
    <body>
        <%
//HttpSession sesionn=request.getSession();
//            out.print(new Date(session.getCreationTime()));
            out.print(new Date(session.getLastAccessedTime()));

        %>
    </body>
</html>
