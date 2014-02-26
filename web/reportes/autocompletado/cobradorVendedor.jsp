<%-- 
    Document   : cobradorVendedor_new
    Created on : 28/01/2014, 09:41:22 AM
    Author     : Henrri
--%>
<%@page import="java.util.Iterator"%>
<%@page import="utilitarios.cOtros"%>
<%@page import="personaClases.cPersonal"%>
<%@page import="java.util.List"%>



[
<%
    String termString = "";
    List personalList = null;
    termString = request.getParameter("term").toString();
    personalList = new cPersonal().leer_cobradorVendedor_SC(termString);
    if (personalList != null) {
        cOtros objcOtros = new cOtros();
        int contador = 0;
        for (Iterator it = personalList.iterator(); it.hasNext();) {
            Object[] personalObjects = (Object[]) it.next();
            if (contador++ > 0) {
                out.println(",");
            }
            String nombresC = objcOtros.replace_comillas_comillasD_barraInvertida(personalObjects[4].toString());
            String dni = personalObjects[2].toString().equals("") ? "" : "DNI " + personalObjects[2].toString();
            String ruc = personalObjects[3].toString().equals("") ? "" : "RUC " + personalObjects[3].toString();
            out.println("{ "
                    + "\"label\" : \"" + dni + " " + ruc + " " + nombresC + "\", "
                    + "\"value\" : { "
                    + "\"codPersona\" : " + personalObjects[1].toString()
                    + ",\"nombresC\" : \"" + nombresC + "\""
                    + "} "
                    + "}");
        }
    }
%>
]