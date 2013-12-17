<%-- 
    Document   : empresaConvenioLeer
    Created on : 30/09/2013, 11:03:36 PM
    Author     : Henrri
--%>

<%@page import="personaClases.cEmpresaConvenio"%>
<%@page import="utilitarios.cOtros"%>
<%@page import="tablas.EmpresaConvenio"%>
<%
    int codEmpresaConvenio = 0;
    String parametro = "";
    try {
        codEmpresaConvenio = Integer.parseInt(request.getParameter("codEmpresaConvenio"));
        parametro = request.getParameter("parametro").toString();
    } catch (Exception e) {
        out.print("[]");
        return;
    }

    EmpresaConvenio objEmpresaConvenio = null;
    cOtros objcOtros = new cOtros();
    cEmpresaConvenio objcEmpresaConvenio = new cEmpresaConvenio();
    switch (codEmpresaConvenio) {
        case -1:
            objEmpresaConvenio = objcEmpresaConvenio.leer_primero();
            break;
        case 0:
            objEmpresaConvenio = objcEmpresaConvenio.leer_ultimo();
            break;
        default:
            objEmpresaConvenio = objcEmpresaConvenio.leer_cod(codEmpresaConvenio);
            while (objEmpresaConvenio == null) {
                if (parametro.equals("siguiente")) {
                    EmpresaConvenio objEmpresaConvenio1 = objcEmpresaConvenio.leer_ultimo();
                    codEmpresaConvenio++;
                    if (codEmpresaConvenio > objEmpresaConvenio1.getCodEmpresaConvenio()) {//para ver que no haya pasado al final
                        objEmpresaConvenio = objEmpresaConvenio1;
                    }
                }
                if (parametro.equals("anterior")) {
                    EmpresaConvenio objEmpresaConvenio1 = objcEmpresaConvenio.leer_primero();
                    codEmpresaConvenio--;
                    if (codEmpresaConvenio < objEmpresaConvenio1.getCodEmpresaConvenio()) {//para ver que no haya pasado al final
                        objEmpresaConvenio = objEmpresaConvenio1;
                    }
                }
                if (parametro.equals("")) {
                    break;
                }
            }
            break;
    }
    out.print("[");
    if (objEmpresaConvenio != null) {
        session.removeAttribute("codEmpresaConvenioMantenimiento");
        session.setAttribute("codEmpresaConvenioMantenimiento", objEmpresaConvenio.getCodEmpresaConvenio());
        out.print("{"
                + "\"codEmpresaConvenio\":\"" + objcOtros.agregarCeros_int(objEmpresaConvenio.getCodEmpresaConvenio(), 8) + "\""
                + ",\"nombre\":\"" + objcOtros.replace_comillas_comillasD_barraInvertida(objEmpresaConvenio.getNombre()) + "\""
                + ",\"abreviatura\":\"" + objEmpresaConvenio.getAbreviatura() + "\""
                + ",\"codCobranza\":\"" + objEmpresaConvenio.getCodCobranza() + "\""
                + ",\"\":\"" + "" + "\""
                + "}");
    }
    out.print("]");
%>