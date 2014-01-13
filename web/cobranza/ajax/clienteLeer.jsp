<%-- 
    Document   : clienteLeer
    Created on : 04/10/2013, 07:45:18 PM
    Author     : Henrri - N
--%>

<%@page import="tablas.HibernateUtil"%>
<%@page import="utilitarios.cOtros"%>
<%@page import="personaClases.cDatosCliente"%>
<%@page import="tablas.DatosCliente"%>
<%
    out.print("[");
    int codCliente = 0;
    try {
        cDatosCliente objcCliente = new cDatosCliente();
        codCliente = Integer.parseInt(request.getParameter("codCliente"));
        DatosCliente objCliente = objcCliente.leer_cod(codCliente);
        if (objCliente != null) {
            cOtros objcOtros = new cOtros();
            out.print("{"
                    + "\"codCliente\":\"" + objcOtros.agregarCeros_int(objCliente.getCodDatosCliente(), 8) + "\""
                    + ",\"nombresC\":\"" + objcOtros.replace_comillas_comillasD_barraInvertida(objCliente.getPersona().getNombresC()) + "\""
                    + ",\"direccion\":\"" + objcOtros.replace_comillas_comillasD_barraInvertida(objCliente.getPersona().getDireccion()) + "\""
                    + ",\"codEmpresaConvenio\":\"" + objCliente.getEmpresaConvenio().getCodEmpresaConvenio() + "\""
                    + ",\"empresaConvenio\":\"" + objcOtros.replace_comillas_comillasD_barraInvertida(objCliente.getEmpresaConvenio().getNombre()) + "\""
                    + ",\"codCobranza\":\"" + objCliente.getEmpresaConvenio().getCodCobranza() + "\""
                    + ",\"tipo\":\"" + objcCliente.tipoCliente(objCliente.getTipo()).toUpperCase() + "\""
                    + ",\"condicion\":\"" + objcCliente.condicionCliente(objCliente.getCondicion()).toUpperCase() + "\""
                    + ",\"saldoFavor\":\"" + objcOtros.agregarCerosNumeroFormato(objCliente.getSaldoFavor(), 2) + "\""
                    + "}");
        }
    } catch (Exception e) {
    }
    out.print("]");
    HibernateUtil.getSessionFactory().close();
%>