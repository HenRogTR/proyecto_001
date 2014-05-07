<%-- 
    Document   : empresaConvenio
    Created on : 23/04/2014, 11:49:31 AM
    Author     : Henrri
--%>
<%@page import="tablas.EmpresaConvenio"%>
<%@page import="java.util.Iterator"%>
<%@page import="personaClases.cEmpresaConvenio"%>
<%@page import="java.util.List"%>

[
<%
    List li = new cEmpresaConvenio().leer();
    int cont = 0;
    for (Iterator it = li.iterator(); it.hasNext();) {
        EmpresaConvenio obj = (EmpresaConvenio) it.next();
        if (cont++ > 0) {
            out.print(", ");
        }
        out.print("{"
                + "\"codEmpresaConvenio\":" + obj.getCodEmpresaConvenio()
                + ", \"nombre\":\"" + obj.getNombre() + "\""
                + ", \"codCobranza\":\"" + obj.getCodCobranza() + "\""
                + ", \"interesAsigando\":" + obj.isInteresAsigando()
                + ", \"interesAutomatico\":" + obj.isInteresAutomatico()
                + "}"
        );
    }
%>
]