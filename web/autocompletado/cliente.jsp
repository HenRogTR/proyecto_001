<%-- 
    Document   : cliente
    Created on : 10/06/2014, 10:33:07 PM
    Author     : Henrri
--%>

<%@page import="clases.cUtilitarios"%>
<%@page import="tablas.DatosCliente"%>
<%@page import="java.util.List"%>
<%@page import="Ejb.EjbCliente"%>

<%
    //evitar el acceso directo por el URL
    if (request.getMethod().equals("GET")) {
        out.print("No tiene permisos para ver este enlace.");
        return;
    }
    EjbCliente ejbCliente = new EjbCliente();
    List clienteList = ejbCliente.leerClienteOrdenadoAlfabeticamente();
    int codCliente = 0;
    String dniPasaporte = "";
    String ruc = "";
    String nombresC = "";

    out.print("[");
    int tam = clienteList.size();
    for (int i = 0; i < tam; i++) {
        Object[] cliente = (Object[]) clienteList.get(i);
        codCliente = (Integer) cliente[0];
        dniPasaporte = cliente[2].toString();
        ruc = cliente[3].toString();
        nombresC = cliente[4].toString();
        dniPasaporte = "".equals(dniPasaporte) ? "" : "DNI " + dniPasaporte + " ";
        ruc = "".equals(ruc) ? "" : "RUC " + ruc + " ";
        if (i > 0) {
            out.print(",");
        }
        out.println("{ "
                + "\"label\": \"" + dniPasaporte + ruc + cUtilitarios.reemplazarCaracteresEspeciales(nombresC) + "\", "
                + "\"value\": { "
                + "\"codCliente\": \"" + cUtilitarios.agregarCerosIzquierda(codCliente, 8) + "\""
                + ",\"nombresC\": \"" + cUtilitarios.reemplazarCaracteresEspeciales(nombresC) + "\""
                + "} "
                + "}");
    }
    out.print("]");
%>