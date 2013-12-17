<%-- 
    Document   : personaDatos
    Created on : 21/05/2013, 04:03:30 AM
    Author     : Henrri
--%>

<%@page import="personaClases.cDatosCliente"%>
<%@page import="tablas.DatosCliente"%>
<%@page import="sun.font.EAttribute"%>
<%@page import="tablas.EmpresaConvenio"%>
<%@page import="otros.cUtilitarios"%>
<%@page import="personaClases.cPersona"%>
<%@page import="tablas.Persona"%>
<%
    boolean estado = true;
    String mensaje = "";
    int codPersona = 0;
    Persona objPersona = new Persona();
    cPersona objcPersona = new cPersona();
    try {
        codPersona = Integer.parseInt(request.getParameter("codPersona"));
        objPersona = objcPersona.leer_cod(codPersona);
        if (objPersona == null) {
            mensaje = "No hay cliente con ese código";
            estado = false;
        } else {
            if (!objPersona.getDatosClientes().iterator().hasNext()) {
                mensaje = "No hay cliente con ese código";
                estado = false;
            }
        }
    } catch (Exception e) {
        mensaje = "Error en el codPersona";
        estado = false;
    }
    if (!estado) {
        out.print("[{");
        out.print("\"error\":\"" + mensaje + "\"");
        out.print("}]");
        return;
    }

    DatosCliente objDatosCliente = objPersona.getDatosClientes().iterator().next();
    cUtilitarios objcUtilitarios = new cUtilitarios();
    out.print("[{");
    out.print(""
            + "\"codPersona\":\"" + objcUtilitarios.agregarCeros_int(objPersona.getCodPersona(), 8) + "\""
            + ",\"codDatoCliente\":\"" + objcUtilitarios.agregarCeros_int(objDatosCliente.getCodDatosCliente(), 8) + "\""
            + ",\"nombresC\":\"" + objPersona.getNombresC() + "\""
            + ",\"direccion\":\"" + objcUtilitarios.replace_comillas_comillasD_barraInvertida(objPersona.getDireccion()) + "\""
            //******inicio datos cliente

            + ",\"empresaConvenio\":\"" + objDatosCliente.getEmpresaConvenio().getNombre() + "\""
            + ",\"condicion\":\"" + new cDatosCliente().condicionCliente(objDatosCliente.getCondicion()) + "\""
            //******inicio datos cliente
            + "");
    out.print("}]");
%>