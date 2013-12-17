<%-- 
    Document   : clienteLeer
    Created on : 18/10/2013, 11:04:43 AM
    Author     : Henrri
--%>
<%@page import="utilitarios.cOtros"%>
<%@page import="tablas.DatosCliente"%>
<%@page import="java.util.Iterator"%>
<%@page import="personaClases.cDatosCliente"%>
<%@page import="java.util.List"%>

[
<%
    try {
        String term = request.getParameter("term").toString();
        List clienteList = new cDatosCliente().leer_dniPasaporteRucNombresC_ordenado(term);
        if (clienteList != null) {
            cOtros objcOtros = new cOtros();
            int cont = 0;
            for (Iterator it = clienteList.iterator(); it.hasNext();) {
                DatosCliente objCliente = (DatosCliente) it.next();
                if (cont++ > 0) {
                    out.print(",");
                }
                String dni = objCliente.getPersona().getDniPasaporte().equals("") ? "" : "DNI " + objCliente.getPersona().getDniPasaporte();
                String ruc = objCliente.getPersona().getRuc().equals("") ? "" : "RUC " + objCliente.getPersona().getRuc();
                out.print("{ "
                        + "\"label\":\"" + dni + " " + ruc + " " + objcOtros.replace_comillas_comillasD_barraInvertida(objCliente.getPersona().getNombresC()) + "\""
                        + ",\"value\":{"
                        + "\"codCliente\":\"" + objcOtros.agregarCeros_int(objCliente.getCodDatosCliente(), 8) + "\""
                        + ",\"nombresC\":\"" + objcOtros.replace_comillas_comillasD_barraInvertida(objCliente.getPersona().getNombresC()) + "\""
                        + ",\"codPersona\" : " + objCliente.getPersona().getCodPersona() + " "
                        + ",\"direccion\" : \"" + objcOtros.replace_comillas_comillasD_barraInvertida(objCliente.getPersona().getDireccion()) + "\""
                        + ",\"dniPasaporte\" : \"" + objCliente.getPersona().getDniPasaporte() + "\""
                        + ",\"ruc\" : \"" + objCliente.getPersona().getRuc() + "\""
                        + ",\"nombresC\" : \"" + objCliente.getPersona().getNombresC() + "\""
                        + ",\"empresaConvenio\":\"" + objcOtros.replace_comillas_comillasD_barraInvertida(objCliente.getEmpresaConvenio().getNombre()) + "\""
                        + ",\"condicion\":\"" + (new cDatosCliente().condicionCliente(objCliente.getCondicion()).toUpperCase()) + "\""
                        + ",\"creditoMax\":\"" + objcOtros.agregarCerosNumeroFormato(objCliente.getCreditoMax(), 2) + "\""
                        + " }}");
            }
        }
    } catch (Exception e) {
    }


%>
]