<%-- 
    Document   : zonaLeer
    Created on : 30/09/2013, 09:35:16 AM
    Author     : Henrri
--%>

<%@page import="utilitarios.cOtros"%>
<%@page import="personaClases.cZona"%>
<%@page import="tablas.Zona"%>
<%
    int codZona = 0;
    String parametro = "";
    try {
        codZona = Integer.parseInt(request.getParameter("codZona"));
        parametro = request.getParameter("parametro").toString();
    } catch (Exception e) {
        out.print("[]");
        return;
    }
    Zona objZona = null;
    cZona objcZona = new cZona();

    switch (codZona) {
        case -1:
            objZona = objcZona.leer_primero();
            break;
        case 0:
            objZona = objcZona.leer_ultimo();
            break;
        default:
            objZona = objcZona.leer_cod(codZona);
            while (objZona == null) {
                if (parametro.equals("anterior")) {
                    Zona objZona1 = objcZona.leer_primero();
                    codZona--;
                    if (codZona < objZona1.getCodZona()) {
                        objZona = objZona1;
                    }
                }
                if (parametro.equals("siguiente")) {
                    Zona objZona1 = objcZona.leer_ultimo();
                    codZona++;
                    if (codZona > objZona1.getCodZona()) {
                        objZona = objZona1;
                    }
                }
                if (parametro.equals("")) {
                    break;
                }
            }
            break;
    }
    out.print("[");
    if (objZona != null) {
        session.removeAttribute("codZonaMantenimiento");
        session.setAttribute("codZonaMantenimiento", objZona.getCodZona());
        cOtros objcOtros = new cOtros();
        out.print("{"
                + "\"codZona\":\"" + objcOtros.agregarCeros_int(objZona.getCodZona(), 8) + "\""
                + ",\"zona\":\"" + objcOtros.replace_comillas_comillasD_barraInvertida(objZona.getZona()) + "\""
                + ",\"observacion\":\"" + objcOtros.replace_comillas_comillasD_barraInvertida(objZona.getDescripcion()) + "\""
                + "}");
    }
    out.print("]");
%>