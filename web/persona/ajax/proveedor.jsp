<%-- 
    Document   : proveedor
    Created on : 12/08/2013, 11:18:27 AM
    Author     : Henrri
--%>

<%@page import="utilitarios.cOtros"%>
<%@page import="tablas.Proveedor"%>
<%@page import="personaClases.cProveedor"%>
<%
    int codProveedor = 0;
    try {
        codProveedor = Integer.parseInt(request.getParameter("codProveedor"));
    } catch (Exception e) {
        codProveedor = 0;
    }
    cProveedor objcProveedor = new cProveedor();
    Proveedor objProveedor = new Proveedor();
    switch (codProveedor) {
        case -1:
            objProveedor = objcProveedor.leer_primero();
            break;
        case 0:
            objProveedor = objcProveedor.leer_ultimo();
            break;
        default:
            objProveedor = objcProveedor.leer_cod(codProveedor);
            break;
    }
    out.print("[");
    if (objProveedor != null) {
        session.removeAttribute("codProveedorListar");
        session.setAttribute("codProveedorListar", objProveedor.getCodProveedor());
        out.print("{"
                //                + "\"\":\"" + "" + "\""
                + "\"codProveedor\":\"" + new cOtros().agregarCeros_int(objProveedor.getCodProveedor(), 8) + "\""
                + ",\"ruc\":\"" + objProveedor.getRuc() + "\""
                + ",\"razonSocial\":\"" + new cOtros().replace_comillas_comillasD_barraInvertida(objProveedor.getRazonSocial()) + "\""
                + ",\"direccion\":\"" + new cOtros().replace_comillas_comillasD_barraInvertida(objProveedor.getDireccion()) + "\""
                + ",\"telefono1\":\"" + objProveedor.getTelefono() + "\""
                + ",\"telefono2\":\"" + "" + "\""
                + ",\"email\":\"" + objProveedor.getEmail() + "\""
                + ",\"paginaWeb\":\"" + objProveedor.getPaginaWeb() + "\""
                + ",\"logo\":\"" + objProveedor.getLogo() + "\""
                + ",\"registro\":\"" + objProveedor.getRegistro() + "\""
                + "}");
    }
    out.print("]");
%>
