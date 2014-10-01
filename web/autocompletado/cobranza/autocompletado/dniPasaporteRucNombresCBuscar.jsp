<%-- 
    Document   : dniPasaporteRucNombresCBuscar
    Created on : 11/01/2014, 10:30:23 AM
    Author     : Henrri
--%>

<%@page import="java.util.Date"%>
<%@page import="tablas.Usuario"%>
<%@page import="java.util.Iterator"%>
<%@page import="utilitarios.cOtros"%>
<%@page import="personaClases.cDatosCliente"%>
<%@page import="java.util.List"%>

[
<%
    // ============================ sesi�n =====================================
    //verficar inicio de sesi�n        
    Usuario objUsuario = (Usuario) session.getAttribute("usuario");
    if (objUsuario == null) {
        out.print("La sesi�n se ha cerrado.");
        return;
    }
    //actualizamos ultimo ingreso
    session.setAttribute("fechaAcceso", new Date());
    // ============================ sesi�n =====================================
    try {
        String term = request.getParameter("term").toString();
        List clienteList = new cDatosCliente().leer_dniPasaporteRucNombresC_ordenado_CS(term);
        if (clienteList != null) {
            cOtros objcOtros = new cOtros();
            int cont = 0;
            for (Iterator it = clienteList.iterator(); it.hasNext();) {
                Object[] cliente = (Object[]) it.next();
                if (cont++ > 0) {
                    out.print(",");
                }
                String dniPasaporte = cliente[2].toString();
                String ruc = cliente[3].toString();
                String nombresC = cliente[4].toString();
                dniPasaporte = dniPasaporte.equals("") ? "" : "DNI " + dniPasaporte;
                ruc = ruc.equals("") ? "" : "RUC " + ruc;
                out.print("{ "
                        + "\"label\":\"" + dniPasaporte + " " + ruc + " " + objcOtros.replace_comillas_comillasD_barraInvertida(nombresC) + "\""
                        + ",\"value\":{"
                        + "\"codCliente\":\"" + objcOtros.agregarCeros_int(Integer.parseInt(cliente[0].toString()), 8) + "\""
                        + ",\"nombresC\":\"" + objcOtros.replace_comillas_comillasD_barraInvertida(nombresC) + "\""
                        + ",\"codPersona\" : " + cliente[1].toString()
                        + " }}");
            }
        }
    } catch (Exception e) {

    }
%>
]