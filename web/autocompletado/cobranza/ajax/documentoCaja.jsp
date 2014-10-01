<%-- 
    Document   : documentoCaja
    Created on : 17/04/2014, 09:49:48 AM
    Author     : Henrri
--%>
<%@page import="tablas.DatosExtras"%>
<%@page import="java.util.Iterator"%>
<%@page import="otrasTablasClases.cDatosExtras"%>
<%@page import="java.util.List"%>

[
<%
    List DatosExtrasList = new cDatosExtras().leer_documentoCaja();
    int cont = 0;
    for (Iterator it = DatosExtrasList.iterator(); it.hasNext();) {
        if (cont++ > 0) {
            out.print(", ");
        }
        DatosExtras objDatosExtras = (DatosExtras) it.next();
        out.print("{\"documentoCaja\":\"" + objDatosExtras.getLetras() + "\"}");
    }
%>
]