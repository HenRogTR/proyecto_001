<%-- 
    Document   : usuario
    Created on : 16/09/2013, 07:17:51 PM
    Author     : Henrri
--%>

<%@page import="utilitarios.cOtros"%>
<%@page import="tablas.Usuario"%>
<%@page import="personaClases.cUsuario"%>

<%
    int codUsuario = 0;
    String parametro = "";
    try {
        codUsuario = Integer.parseInt(request.getParameter("codUsuario"));
        parametro = request.getParameter("parametro").toString();
    } catch (Exception e) {
        out.print("[]");
        return;
    }
    cUsuario objcUsuario = new cUsuario();
    cOtros objcOtros = new cOtros();
    Usuario objUsuario = null;
    switch (codUsuario) {
        case -1:
            objUsuario = objcUsuario.leer_primero();
            break;
        case 0:
            objUsuario = objcUsuario.leer_ultimo();
            break;
        default:            
            while (objUsuario == null) {
                objUsuario = objcUsuario.leer_cod(codUsuario);
                if (parametro.equals("anterior")) {
                    Usuario objUsuario1 = objcUsuario.leer_primero();
                    codUsuario--;
                    if (codUsuario < objUsuario1.getCodUsuario()) {
                        objUsuario = objUsuario1;
                    }
                }
                if (parametro.equals("siguiente")) {
                    Usuario objUsuario1 = objcUsuario.leer_ultimo();
                    codUsuario++;
                    if (codUsuario > objUsuario1.getCodUsuario()) {
                        objUsuario = objUsuario1;
                    }
                }
                if (parametro.equals("")) {
                    break;
                }
            }
            break;
    }
    out.print("[");
    if (objUsuario != null) {
        session.removeAttribute("codUsuarioMantenimiento");
        session.setAttribute("codUsuarioMantenimiento", objUsuario.getCodUsuario());
        out.print("{"
                + "\"codUsuario\":\"" + objcOtros.agregarCeros_int(objUsuario.getCodUsuario(), 8) + "\""
                + ", \"usuario\":\"" + objUsuario.getUsuario() + "\""
                + ", \"ip\":\"" + objUsuario.getIp() + "\""
                + ", \"estado\":" + objUsuario.getEstado()
                + ", \"personal\":\"" + objUsuario.getPersona().getNombresC() + "\""
                + ", \"permiso1\":" + objUsuario.getP1()
                + ", \"permiso2\":" + objUsuario.getP2()
                + ", \"permiso3\":" + objUsuario.getP3()
                + ", \"permiso4\":" + objUsuario.getP4()
                + ", \"permiso5\":" + objUsuario.getP5()
                + ", \"permiso6\":" + objUsuario.getP6()
                + ", \"permiso7\":" + objUsuario.getP7()
                + ", \"permiso8\":" + objUsuario.getP8()
                + ", \"permiso9\":" + objUsuario.getP9()
                + ", \"permiso10\":" + objUsuario.getP10()
                + ", \"permiso11\":" + objUsuario.getP11()
                + ", \"permiso12\":" + objUsuario.getP12()
                + ", \"permiso13\":" + objUsuario.getP13()
                + ", \"permiso14\":" + objUsuario.getP14()
                + ", \"permiso15\":" + objUsuario.getP15()
                + ", \"permiso16\":" + objUsuario.getP16()
                + ", \"permiso17\":" + objUsuario.getP17()
                + ", \"permiso18\":" + objUsuario.getP18()
                + ", \"permiso19\":" + objUsuario.getP19()
                + ", \"permiso20\":" + objUsuario.getP20()
                + ", \"permiso21\":" + objUsuario.getP21()
                + ", \"permiso22\":" + objUsuario.getP22()
                + ", \"permiso23\":" + objUsuario.getP23()
                + ", \"permiso24\":" + objUsuario.getP24()
                + ", \"permiso25\":" + objUsuario.getP25()
                + ", \"permiso26\":" + objUsuario.getP26()
                + ", \"permiso27\":" + objUsuario.getP27()
                + ", \"permiso28\":" + objUsuario.getP28()
                + ", \"permiso29\":" + objUsuario.getP29()
                + ", \"permiso30\":" + objUsuario.getP30()
                + ", \"permiso31\":" + objUsuario.getP31()
                + ", \"permiso32\":" + objUsuario.getP32()
                + ", \"permiso33\":" + objUsuario.getP33()
                + ", \"permiso34\":" + objUsuario.getP34()
                + ", \"permiso35\":" + objUsuario.getP35()
                + ", \"permiso36\":" + objUsuario.getP36()
                + ", \"permiso37\":" + objUsuario.getP37()
                + ", \"permiso38\":" + objUsuario.getP38()
                + ", \"permiso39\":" + objUsuario.getP39()
                + ", \"permiso40\":" + objUsuario.getP40()
                + ", \"permiso41\":" + objUsuario.getP41()
                + ", \"permiso42\":" + objUsuario.getP42()
                + ", \"permiso43\":" + objUsuario.getP43()
                + ", \"permiso44\":" + objUsuario.getP44()
                + ", \"permiso45\":" + objUsuario.getP45()
                + ", \"permiso46\":" + objUsuario.getP46()
                + ", \"permiso47\":" + objUsuario.getP47()
                + ", \"permiso48\":" + objUsuario.getP48()
                + ", \"permiso49\":" + objUsuario.getP49()
                + ", \"permiso50\":" + objUsuario.getP50()
                + ", \"permiso51\":" + objUsuario.getP51()
                + ", \"permiso52\":" + objUsuario.getP52()
                + ", \"permiso53\":" + objUsuario.getP53()
                + ", \"permiso54\":" + objUsuario.getP54()
                + ", \"permiso55\":" + objUsuario.getP55()
                + ", \"permiso56\":" + objUsuario.getP56()
                + ", \"permiso57\":" + objUsuario.getP57()
                + ", \"permiso58\":" + objUsuario.getP58()
                + ", \"permiso59\":" + objUsuario.getP59()
                + ", \"permiso60\":" + objUsuario.getP60()
                + "}");
    }
    out.print("]");
%>