<%-- 
    Document   : cliente_codCliente
    Created on : 10/04/2014, 04:31:02 PM
    Author     : Henrri
--%>
<%@page import="ventaClases.cVenta"%>
<%@page import="utilitarios.cOtros"%>
<%@page import="personaClases.cDatosCliente"%>
[
<%
    try {
        int codCliente = Integer.parseInt(request.getParameter("codCliente"));
        if (codCliente == 0) {
            codCliente = new cVenta().leer_codCliente_ultimaVentaCredito_SC();
        }
        Object datoCliente[] = new cDatosCliente().leer_codigo_SC(codCliente);
        if (datoCliente != null) {
            out.print("{"
                    + "\"codCliente\":\"" + new cOtros().agregarCeros_int((Integer) datoCliente[0], 8) + "\""
                    + ", \"nombresC\":\"" + new cOtros().replace_comillas_comillasD_barraInvertida((String) datoCliente[1]) + "\""
                    + ", \"direccion\":\"" + new cOtros().replace_comillas_comillasD_barraInvertida((String) datoCliente[2]) + "\""
                    + ", \"codEmpresaConvenio\":\"" + (Integer) datoCliente[3] + "\""
                    + ", \"empresaConvenio\":\"" + new cOtros().replace_comillas_comillasD_barraInvertida((String) datoCliente[4]) + "\""
                    + ", \"codCobranza\":\"" + (String) datoCliente[5] + "\""
                    + ", \"tipo\":\"" + new cDatosCliente().tipoCliente((Integer) datoCliente[6]).toUpperCase() + "\""
                    + ", \"condicion\":\"" + new cDatosCliente().condicionCliente((Integer) datoCliente[7]).toUpperCase() + "\""
                    + ", \"saldoFavor\":\"" + new cOtros().agregarCerosNumeroFormato((Double) datoCliente[8], 2) + "\""
                    + "}");
        }
    } catch (Exception e) {        
    }
%>
]