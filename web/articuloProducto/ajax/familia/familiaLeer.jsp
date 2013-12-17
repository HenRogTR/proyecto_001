<%-- 
    Document   : familiaLeer
    Created on : 14/10/2013, 10:40:13 AM
    Author     : Henrri
--%><%@page import="utilitarios.cOtros"%>
<%@page import="articuloProductoClases.cFamilia"%>
<%@page import="tablas.Familia"%>

[
<%
    int codFamilia = 0;
    String parametro = "";
    try {
        codFamilia = Integer.parseInt(request.getParameter("codFamilia"));
        parametro = request.getParameter("parametro").toString();
        Familia objFamilia = null;
        cFamilia objcFamilia = new cFamilia();
        switch (codFamilia) {
            case -1:
                objFamilia = objcFamilia.leer_primero();
                break;
            case 0:
                objFamilia = objcFamilia.leer_ultimo();
                break;
            default:
                objFamilia = objcFamilia.leer_cod(codFamilia);
                while (objFamilia == null) {
                    if (parametro.equals("siguiente")) {
                        Familia objFamilia1 = objcFamilia.leer_ultimo();
                        codFamilia++;
                        if (codFamilia > objFamilia1.getCodFamilia()) {//para ver que no haya pasado al final
                            objFamilia = objFamilia1;
                        }
                    }
                    if (parametro.equals("anterior")) {
                        Familia objFamilia1 = objcFamilia.leer_primero();
                        codFamilia--;
                        if (codFamilia < objFamilia.getCodFamilia()) {//para ver que no haya pasado al final
                            objFamilia = objFamilia1;
                        }
                    }
                    if (parametro.equals("")) {
                        break;
                    }
                }
                break;
        }
        if (objFamilia != null) {
            session.removeAttribute("codFamiliaMantenimiento");
            session.setAttribute("codFamiliaMantenimiento", objFamilia.getCodFamilia());
            cOtros objcOtros = new cOtros();
            out.print("{"
                    + "\"codFamilia\":\"" + objcOtros.agregarCeros_int(objFamilia.getCodFamilia(), 8) + "\""
                    + ",\"familia\":\"" + objcOtros.replace_comillas_comillasD_barraInvertida(objFamilia.getFamilia()) + "\""
                    + ",\"observacion\":\"" + objcOtros.replace_comillas_comillasD_barraInvertida(objFamilia.getObservacion()) + "\""
                    + ",\"registro\":\"" + objFamilia.getRegistro() + "\""
                    + "}");
        }

    } catch (Exception e) {

    }
%>
]