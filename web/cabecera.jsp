<%@page import="otros.cUtilitarios"%>
<%@page import="java.util.Date"%>
<%    
    cUtilitarios objcU = new cUtilitarios();
%>
<h2 style="float: right;margin-top: 15px;margin-right: 25px;"><%=objcU.fechaActual() %></h2>