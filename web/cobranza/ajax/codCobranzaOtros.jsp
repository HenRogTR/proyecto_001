<%-- 
    Document   : codCobranzaOtros
    Created on : 21/11/2013, 02:30:12 PM
    Author     : Henrri
--%>

<%@page import="tablas.OtrosCC"%>
<%@page import="java.util.Iterator"%>
<%@page import="personaClases.cOtrosCC"%>
<%@page import="java.util.List"%>

[
<%
    try {
        int codEmpresaConvenio = Integer.parseInt(request.getParameter("codEmpresaConvenio"));
        List OCCList = new cOtrosCC().leer_codEmpresaConvenio(codEmpresaConvenio);
        if (OCCList != null) {
            int cont = 0;
            for (Iterator it = OCCList.iterator(); it.hasNext();) {
                OtrosCC objcOtrosCC = (OtrosCC) it.next();
                if (cont++ > 0) {
                    out.print(",");
                }
                out.print("{"
                        + "\"tipo\":\"" + objcOtrosCC.getTipo() + "\""
                        + "}");
            }
        }
    } catch (Exception e) {

    }
%>
]