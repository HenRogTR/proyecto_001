<%-- 
    Document   : reporteMenu
    Created on : 20/03/2013, 09:22:01 AM
    Author     : Henrri
--%>

<%@page import="tablas.Personal"%>
<%@page import="personaClases.cPersonal"%>
<%@page import="tablas.Persona"%>
<%@page import="personaClases.cPersona"%>
<%@page import="tablas.EmpresaConvenio"%>
<%@page import="personaClases.cEmpresaConvenio"%>
<%@page import="java.util.Iterator"%>
<%@page import="otros.cManejoFechas"%>
<%@page import="tablas.Familia"%>
<%@page import="articuloProductoClases.cFamilia"%>
<%@page import="java.util.List"%>
<%@page import="tablas.Usuario"%>
<%
    Usuario objUsuario = (Usuario) session.getAttribute("usuario");
    if (objUsuario == null) {
        session.removeAttribute("direccion");
        session.setAttribute("direccion", "reportes/reporteMenu.jsp");
        response.sendRedirect("../");
    } else {

%>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <title>Reportes</title>
        <!--stilo inicio-->
        <link rel="stylesheet" type="text/css" href="../lib/propios/css/inicio/style.css" />
        <!--js query-->
        <script type="text/javascript" src="../lib/jquery/jquery-1.8.1.min.js"></script>
        <!--css js ui-->
        <link rel="stylesheet" type="text/css" href="../lib/jquery-ui/jquery-ui-1.10.0.custom/css/smoothness/jquery-ui-1.10.0.custom.min.css">
        <script type="text/javascript" src="../lib/jquery-ui/jquery-ui-1.9.0/jquery-ui-git.js"></script>
        <!--css frm-->
        <link rel="stylesheet" type="text/css" href="../lib/propios/css/formulario/detalles.css" />        
        <!--css iconos-->
        <link rel="stylesheet" type="text/css" href="../lib/botones/sexybuttons.css">
        <!--propio-->
        <script>
            $(document).ready(function() {
                var tabs = $("#tabs").tabs();
                tabs.find(".ui-tabs-nav").sortable({
                    axis: "x",
                    stop: function() {
                        tabs.tabs("refresh");
                    }
                });
            });
        </script>
        <link rel="stylesheet" type="text/css" href="../lib/propios/css/tablas/tablas-reportes.css">        
        <!--f calendario-->
        <script type="text/javascript" src="../lib/reportes/reporteMenu.js?v13.07.26"></script>
        <script type="text/javascript" src="../lib/jquery.maskedinput/jquery.maskedinput.min.js"></script>
        <!--idioma español date-->
        <script src="../lib/jquery-ui/jquery-ui-1.10.0.custom/js/i18n/jquery.ui.datepicker-es.js"></script>
        <script src="../lib/jquery-ui/jquery-ui-1.10.0.custom/js/jquery.ui.effect-clip.js"></script>
        <script>
            $(function() {
                $("#comprasFechaInicio").datepicker({
                    showAnim: "clip",
                    defaultDate: "-7",
                    changeMonth: true,
                    changeYear: true,
                    numberOfMonths: 3,
                    onClose: function(selectedDate) {
                        $("#comprasFechaFin").datepicker("option", "minDate", selectedDate);
                    }
                });
                $("#comprasFechaFin").datepicker({
                    showAnim: "clip",
                    defaultDate: "+1w",
                    changeMonth: true,
                    changeYear: true,
                    numberOfMonths: 3,
                    onClose: function(selectedDate) {
                        $("#comprasFechaInicio").datepicker("option", "maxDate", selectedDate);
                    }
                });
                $("#articulosFechaInicio").datepicker({
                    showAnim: "clip",
                    defaultDate: "-2w",
                    changeMonth: true,
                    changeYear: true,
                    numberOfMonths: 3,
                    onClose: function(selectedDate) {
                        $("#articulosFechaFin").datepicker("option", "minDate", selectedDate);
                    }
                });
                $("#articulosFechaFin").datepicker({
                    showAnim: "clip",
                    defaultDate: "+1w",
                    changeMonth: true,
                    changeYear: true,
                    numberOfMonths: 3,
                    onClose: function(selectedDate) {
                        $("#articulosFechaInicio").datepicker("option", "maxDate", selectedDate);
                    }
                });
            });
        </script>
    </head>
    <body>        
        <div id="wrap">
            <div id="header">
                <%@include file="../cabecera.jsp" %>
            </div>
            <div id="right" style="width: 1024px;">
                <%
                    cFamilia objcFamilia = new cFamilia();
                    cEmpresaConvenio objcEmpresaConvenio = new cEmpresaConvenio();
                    cUtilitarios objcUtilitarios = new cUtilitarios();
                %>
                <h3 class="titulo">REPORTES EN GENERAL <a href="../index.jsp" class="sexybutton"><span><span><span class="home">Inicio</span></span></span></a></h3>
                <br>
                <div id="tabs">
                    <ul>
                        <li><a href="#cliente">Clientes</a></li>
                        <li><a href="#venta">Ventas</a></li>
                        <li><a href="#cobranza">Cobranza</a></li>
                        <li><a href="#compras">Compras</a></li>
                        <li><a href="#proveedor">Proveedor</a></li>
                        <li><a href="#articuloProducto">Artículos</a></li>
                        <li><a href="#otros">Otros</a></li>
                    </ul>
                    <!--cliente-->
                    <div id="cliente">
                        <table class="reporte-tabla-1">
                            <thead>
                                <tr>
                                    <th><label>Cobrador</label></th>
                                    <td>
                                        <input type="radio" name="clienteCobrador" value="todos" checked="checked"  class="clienteCobrador" /> Todos
                                        <input type="radio" name="clienteCobrador" value="cobrador"  class="clienteCobrador"/> Por Cobrador
                                    </td>
                                    <td colspan="4" id="tdClienteCobrador" class="ocultar">
                                        <input type="hidden" name="clienteCodCobrador" id="clienteCodCobrador" value=""/>
                                        <input type="text" name="clienteCobradorBuscar" id="clienteCobradorBuscar" value="" style="width: 98%;"/>
                                    </td>
                                </tr>
                                <tr>
                                    <th><label>ORDENADO</label></th>
                                    <td>
                                        <input type="radio" name="clienteOrden" value="nombresC" checked="checked" /> Apellidos/Nombres&nbsp;&nbsp;&nbsp;
                                        <input type="radio" name="clienteOrden" value="direccion"/> Dirección
                                    </td>
                                    <td>
                                        <a href="#" class="sexybutton sexyicononly aClientes" id="reporteCliente"><span><span><span class="print"></span></span></span></a>
                                    </td>
                                    <th><label>LETRAS PENDIENTE DE PAGO</label></th>
                                    <td>
                                        <input type="text" name="clienteFechaVencimientoLetraGeneral" value="<%=objcUtilitarios.fechaDateToString(new Date())%>" id="clienteFechaVencimientoLetraGeneral" placeholder="dd/mm/yyyy" readonly=""/>
                                        <script>
                                            $().ready(function(e) {
                                                $("#clienteFechaVencimientoLetraGeneral").datepicker({
                                                    showAnim: "clip",
                                                    changeMonth: true,
                                                    changeYear: true
                                                });
                                            });
                                        </script>
                                    </td>
                                    <td>
                                        <a href="#" class="sexybutton sexyicononly aClientes" id="reporteClienteLetrasVencidas"><span><span><span class="print"></span></span></span></a>
                                        <a href="#" class="sexybutton sexyicononly aClientes" id="reporteClienteLetrasVencidasExcel"><span><span><img src="../lib/imagenes/excel.png"/></span></span></a>
                                    </td>
                                    <th style="width: 80px;"><label>TRAMOS</label></th>
                                    <td>
                                        <a href="#" class="sexybutton sexyicononly aClientes" id="reporteClienteLetrasVencidasTramosExcel"><span><span><img src="../lib/imagenes/excel.png"/></span></span></a>
                                    </td>
                                </tr>
                                <tr>
                                    <th><label>EMPRESA</label></th>
                                    <td>
                                        <%
                                            Iterator iEmpresaConvenio = objcEmpresaConvenio.leer().iterator();
                                        %>
                                        <select name="clienteCodEmpresaConvenio" id="clienteCodEmpresaConvenio" style="font-size: 12px;width: 300px;">
                                            <option value="">SELECCIONAR</option>
                                            <%
                                                while (iEmpresaConvenio.hasNext()) {
                                                    EmpresaConvenio objEmpresaConvenio = (EmpresaConvenio) iEmpresaConvenio.next();
                                            %>
                                            <option value="<%=objEmpresaConvenio.getCodEmpresaConvenio()%>"><%=objEmpresaConvenio.getNombre()%></option>
                                            <%
                                                }
                                            %>
                                        </select>
                                    </td>
                                    <td>
                                        <a href="#" class="sexybutton sexyicononly aClientes" id="reporteClienteEmpresaConvenio"><span><span><span class="print"></span></span></span></a>
                                    </td>
                                    <th><label>LETRAS PENDIENTE DE PAGO</label></th>
                                    <td>
                                        <input type="text" name="clienteFechaVencimientoLetra" value="<%=objcUtilitarios.fechaDateToString(new Date())%>" id="clienteFechaVencimientoLetra" placeholder="dd/mm/yyyy" readonly=""/>
                                        <script>
                                            $().ready(function(e) {
                                                $("#clienteFechaVencimientoLetra").datepicker({
                                                    showAnim: "clip",
                                                    changeMonth: true,
                                                    changeYear: true,
                                                });
                                            });
                                        </script>
                                    </td>
                                    <td>
                                        <a href="#" class="sexybutton sexyicononly aClientes" id="reporteClienteEmpresaConvenioLetrasVencidas"><span><span><span class="print"></span></span></span></a>
                                        <a href="#" class="sexybutton sexyicononly aClientes" id="reporteClienteEmpresaConvenioLetrasVencidasExcel"><span><span><img src="../lib/imagenes/excel.png"/></span></span></a>
                                    </td>
                                    <th style="width: 80px;"><label>TRAMOS</label></th>
                                    <td>
                                        <a href="#" class="sexybutton sexyicononly aClientes" id="reporteClienteEmpresaConvenioLetrasVencidasTramosExcel"><span><span><img src="../lib/imagenes/excel.png"/></span></span></a>
                                    </td>
                                </tr>
                                <tr>
                                    <th>TIPO</th>
                                    <td>
                                        <select name="clienteTipo" id="clienteTipo" style="font-size: 12px;width: 300px;">
                                            <option value="">SELECCIONE TIPO</option>
                                            <option value="1">ACTIVO</option>
                                            <option value="2">4 SUELDOS</option>
                                            <option value="3">CESANTE</option>
                                            <option value="4">PARTICULAR</option>
                                        </select>
                                    </td>
                                    <td>
                                        <a href="#" class="sexybutton sexyicononly aClientes" id="reporteClienteEmpresaConvenioTipo"><span><span><span class="print"></span></span></span></a>
                                    </td>
                                    <th><label>LETRAS PENDIENTE DE PAGO</label></th>
                                    <td>
                                        <input type="text" name="clienteFechaVencimientoLetraTipo" value="<%=objcUtilitarios.fechaDateToString(new Date())%>" id="clienteFechaVencimientoLetraTipo" placeholder="dd/mm/yyyy" readonly=""/>
                                        <script>
                                            $().ready(function(e) {
                                                $("#clienteFechaVencimientoLetraTipo").datepicker({
                                                    showAnim: "clip",
                                                    changeMonth: true,
                                                    changeYear: true,
                                                });
                                            });
                                        </script>
                                    </td>
                                    <td>
                                        <a href="#" class="sexybutton sexyicononly aClientes" id="reporteClienteEmpresaConvenioLetrasVencidasTipo"><span><span><span class="print"></span></span></span></a>
                                        <a href="#" class="sexybutton sexyicononly aClientes" id="reporteClienteEmpresaConvenioLetrasVencidasTipoExcel"><span><span><img src="../lib/imagenes/excel.png"/></span></span></a>
                                    </td>
                                    <!--                                    <th></th>
                                                                        <td></td>-->
                                </tr>
                                <tr>
                                    <th>CONDICIÓN</th>
                                    <td>
                                        <select name="clienteCondicion" id="clienteCondicion" style="font-size: 12px;width: 300px;">
                                            <option value="">SELECCIONE CONDICIÓN</option>                                    
                                            <option value="1">CONTRATADO</option>
                                            <option value="2">NOMBRADO</option>
                                            <option value="3">OTROS</option>
                                        </select>
                                    </td>
                                    <td>
                                        <a href="#" class="sexybutton sexyicononly aClientes" id="reporteClienteEmpresaConvenioTipoCondicion"><span><span><span class="print"></span></span></span></a>
                                    </td>
                                    <th><label>LETRAS PENDIENTE DE PAGO</label></th>
                                    <td>
                                        <input type="text" name="clienteFechaVencimientoLetraTipoCondicion" value="<%=objcUtilitarios.fechaDateToString(new Date())%>" id="clienteFechaVencimientoLetraTipoCondicion" placeholder="dd/mm/yyyy" readonly=""/>
                                        <script>
                                            $().ready(function(e) {
                                                $("#clienteFechaVencimientoLetraTipoCondicion").datepicker({
                                                    showAnim: "clip",
                                                    changeMonth: true,
                                                    changeYear: true,
                                                });
                                            });
                                        </script>
                                    </td>
                                    <td>
                                        <a href="#" class="sexybutton sexyicononly aClientes" id="reporteClienteEmpresaConvenioLetrasVencidasTipoCondicion"><span><span><span class="print"></span></span></span></a>
                                        <a href="#" class="sexybutton sexyicononly aClientes" id="reporteClienteEmpresaConvenioLetrasVencidasTipoCondicionExcel"><span><span><img src="../lib/imagenes/excel.png"/></span></span></a>
                                    </td>
                                </tr>
                            </thead>
                        </table>
                    </div>
                    <!--venta-->
                    <div id="venta">
                        <table class="reporte-tabla-1" style="font-size: 12px;width: 620px;">
                            <tr>
                                <th style="width: 140px;"><label>TIPO</label></th>
                                <td>
                                    <input type="radio" name="ventaTipo" value="todo" checked="checked" /> Todo
                                    &nbsp;&nbsp;&nbsp;&nbsp;<input type="radio" name="ventaTipo" value="contado" /> Contado
                                    &nbsp;&nbsp;&nbsp;&nbsp;<input type="radio" name="ventaTipo" value="credito" /> Crédito
                                </td>
                                <th colspan="2" style="text-align: right;">OPCIONES</th>
                            </tr>
                            <tr>
                                <th>PERIODO DE VENTA</th>
                                <td>
                                    DEL <input type="text" name="ventasFechaInicio" id="ventasFechaInicio" value="<%=new cManejoFechas().fechaSumarMes(new Date(), -1)%>" readonly=""/>
                                    AL <input type="text" name="ventasFechaFin" id="ventasFechaFin" value="<%=new cManejoFechas().fechaDateToString(new Date())%>" readonly=""/>
                                    <script>
                                        $().ready(function(e) {
                                            $("#ventasFechaInicio").datepicker({
                                                showAnim: "clip",
                                                changeMonth: true,
                                                changeYear: true,
                                                onClose: function(selectedDate) {
                                                    $("#ventasFechaFin").datepicker("option", "minDate", selectedDate);
                                                }
                                            });
                                            $("#ventasFechaFin").datepicker({
                                                showAnim: "clip",
                                                changeMonth: true,
                                                changeYear: true,
                                                onClose: function(selectedDate) {
                                                    $("#cobranzaFechaInicio").datepicker("option", "maxDate", selectedDate);
                                                }
                                            });
                                            $("#ventasFechaFin").datepicker("option", "minDate", $("#ventasFechaInicio").val());
                                            $("#ventasFechaInicio").datepicker("option", "maxDate", $("#ventasFechaFin").val());
                                        });
                                    </script>
                                </td>
                                <td>
                                    <a href="#" class="sexybutton sexyicononly aVentas" id="ventasPeriodo" target="_blank"><span><span><span class="print"></span></span></span></a>
                                </td>
                                <td>
                                    <a href="#" class="sexybutton sexyicononly aVentas" id="ventasPeriodoExcel" target="_blank"><span><span><img src="../lib/imagenes/excel.png"/></span></span></a>
                                </td>
                            </tr>
                            <tr>
                                <th style="width: 40px;">DOCUMENTO (F-B-G)</th>
                                <td style="font-size: 14px;">
                                    <select id="ventaSerieLetra" name="ventaSerieLetra">
                                        <option value="F">F</option>
                                        <option value="B">B</option>
                                        <option value="G">G</option>
                                    </select>
                                    -
                                    <input type="text" name="ventaSerieNumero" id="ventaSerieNumero" value="" style="width: 50px;" />
                                </td>
                                <td>
                                    <a href="#" class="sexybutton sexyicononly aVentas" id="ventasDocumento" target="_blank"><span><span><span class="print"></span></span></span></a>
                                </td>
                                <td>
                                    <a href="#" class="sexybutton sexyicononly aVentas" id="ventasDocumentoExcel" target="_blank"><span><span><img src="../lib/imagenes/excel.png"/></span></span></a>
                                </td>
                            </tr>
                            <tr>
                                <th>VENDEDOR</th>
                                <td>
                                    <%
                                        List lVendedor = new cPersonal().leer_cobradorVendedor();
                                        Iterator iVendedor = lVendedor.iterator();
                                    %>
                                    <select id="ventasCodVendedor" name="ventasCodVendedor" style="font-size: 13px;">
                                        <option value="">Seleccionar</option>
                                        <%
                                            while (iVendedor.hasNext()) {
                                                Personal objPersonal = (Personal) iVendedor.next();
                                        %>
                                        <option value="<%=objPersonal.getPersona().getCodPersona() %>"><%=objPersonal.getPersona().getNombresC() %></option>
                                        <%
                                            }
                                        %>
                                    </select>
                                </td>
                                <td>
                                    <a href="#" class="sexybutton sexyicononly aVentas" id="ventasVendedor" target="_blank"><span><span><span class="print"></span></span></span></a>
                                </td>
                                <td>
                                    <a href="#" class="sexybutton sexyicononly aVentas" id="ventasVendedorExcel" target="_blank"><span><span><img src="../lib/imagenes/excel.png"/></span></span></a>
                                </td>
                            </tr>
                            <tr>
                                <th>DOC. ANULADOS</th>
                                <td>
                                    DEL <input type="text" name="ventasAnuladosFechaInicio" id="ventasAnuladosFechaInicio" value="<%=new cManejoFechas().fechaSumarMes(new Date(), -1)%>" readonly=""/>
                                    AL <input type="text" name="ventasAnuladosFechaFin" id="ventasAnuladosFechaFin" value="<%=new cManejoFechas().fechaDateToString(new Date())%>" readonly=""/>
                                    <script>
                                        $().ready(function(e) {
                                            $("#ventasAnuladosFechaInicio").datepicker({
                                                showAnim: "clip",
                                                changeMonth: true,
                                                changeYear: true,
                                                onClose: function(selectedDate) {
                                                    $("#ventasAnuladosFechaFin").datepicker("option", "minDate", selectedDate);
                                                }
                                            });
                                            $("#ventasAnuladosFechaFin").datepicker({
                                                showAnim: "clip",
                                                changeMonth: true,
                                                changeYear: true,
                                                onClose: function(selectedDate) {
                                                    $("#cobranzaAnuladosFechaInicio").datepicker("option", "maxDate", selectedDate);
                                                }
                                            });
                                            $("#ventasAnuladosFechaFin").datepicker("option", "minDate", $("#ventasAnuladosFechaInicio").val());
                                            $("#ventasAnuladosFechaInicio").datepicker("option", "maxDate", $("#ventasAnuladosFechaFin").val());
                                        });
                                    </script>
                                </td>
                                <td>
                                    <a href="#" class="sexybutton sexyicononly aVentas" id="ventasAnulados" target="_blank"><span><span><span class="print"></span></span></span></a>
                                </td>
                                <td>
                                    <a href="#" class="sexybutton sexyicononly aVentas" id="ventasAnuladosExcel" target="_blank"><span><span><img src="../lib/imagenes/excel.png"/></span></span></a>
                                </td>
                            </tr>
                        </table>
                    </div>
                    <!--cobranza-->
                    <div id="cobranza">
                        <table class="reporte-tabla-1" style="font-size: 12px;">
                            <thead>                                
                                <tr>
                                    <th>PERIODO</th>
                                    <td>
                                        DEL <input type="text" name="cobranzaFechaInicio" id="cobranzaFechaInicio" value="<%=new cManejoFechas().fechaSumarMes(new Date(), -1)%>" readonly="" />
                                        AL <input type="text" name="cobranzaFechaFin" id="cobranzaFechaFin" value="<%=new cManejoFechas().fechaDateToString(new Date())%>" readonly="" />
                                        <script>
                                            $().ready(function(e) {
                                                $("#cobranzaFechaInicio").datepicker({
                                                    showAnim: "clip",
                                                    changeMonth: true,
                                                    changeYear: true,
                                                    onClose: function(selectedDate) {
                                                        $("#cobranzaFechaFin").datepicker("option", "minDate", selectedDate);
                                                    }
                                                });
                                                $("#cobranzaFechaFin").datepicker({
                                                    showAnim: "clip",
                                                    changeMonth: true,
                                                    changeYear: true,
                                                    onClose: function(selectedDate) {
                                                        $("#cobranzaFechaInicio").datepicker("option", "maxDate", selectedDate);
                                                    }
                                                });
                                                $("#cobranzaFechaFin").datepicker("option", "minDate", $("#cobranzaFechaInicio").val());
                                                $("#cobranzaFechaInicio").datepicker("option", "maxDate", $("#cobranzaFechaFin").val());
                                            });
                                        </script>
                                    </td>
                                    <th>Opciones</th>
                                </tr>
                            </thead>
                            <thead>
                                <tr>
                                    <th>
                                        <input type="checkbox" name="cobranzaCobrador" id="cobranzaCobrador" value="ON" /> COBRADOR<a href="#" class="sexybutton sexyicononly" id="aCobranzaCobradorBuscar"><span><span><span class="search"></span></span></span></a>
                                    </th>
                                    <td colspan="2">
                                        <input type="hidden" id="cobranzaCodCobrador" name="cobranzaCodCobrador" value="" />
                                        <input type="text" id="cobranzaCobradorBuscar" value="" style="width: 85%; "/>
                                        <a href="#" class="sexybutton sexyicononly" id="aCobranzaCobradorLimpiar"><span><span><span class="erase"></span></span></span></a>
                                    </td>
                                </tr>
                                <tr>
                                    <th>TIPO</th>
                                    <td>
                                        <input type="radio" name="cobranzaTipo" value="todo" checked="checked"/> Todo&nbsp;&nbsp;
                                        <input type="radio" name="cobranzaTipo" value="iniciales" /> Iniciales&nbsp;&nbsp;
                                        <input type="radio" name="cobranzaTipo" value="cobranza" /> Cobranza&nbsp;&nbsp;
                                        <input type="radio" name="cobranzaTipo" value="anticipos" /> Anticipo&nbsp;&nbsp;
                                    </td>
                                    <td>
                                        <a href="#" class="sexybutton sexyicononly aCobranza" id="reporteClientes1" target="_blank"><span><span><span class="print"></span></span></span></a>
                                    </td>
                                </tr>
                                <tr>
                                    <th>DOCUMENTO</th>
                                    <td>
                                        <input type="text" name="cobranzaSerieDocumento" id="cobranzaSerieDocumento" value="" />
                                    </td>
                                    <td>
                                        <a href="#" class="sexybutton sexyicononly aCobranza" id="reporteClientes2" target="_blank"><span><span><span class="print"></span></span></span></a>
                                    </td>
                                </tr>
                                <tr>
                                    <th>ANULADOS</th>
                                    <td></td>
                                    <td>
                                        <a href="#" class="sexybutton sexyicononly aCobranza" id="reporteClientes3" target="_blank"><span><span><span class="print"></span></span></span></a>
                                    </td>
                                </tr>
                                <tr>
                                    <th>CLIENTES Y PAGOS</th>
                                    <td>
                                        DEL <input type="text" name="cobranzaClienteFechaInicio" id="cobranzaClienteFechaInicio" value="<%=new cManejoFechas().fechaSumarMes(new Date(), -1)%>" readonly="" />
                                        AL <input type="text" name="cobranzaClienteFechaFin" id="cobranzaClienteFechaFin" value="<%=new cManejoFechas().fechaDateToString(new Date())%>" readonly="" />
                                        <script>
                                            $().ready(function(e) {
                                                $("#cobranzaClienteFechaInicio").datepicker({
                                                    showAnim: "clip",
                                                    changeMonth: true,
                                                    changeYear: true,
                                                    onClose: function(selectedDate) {
                                                        $("#cobranzaClienteFechaFin").datepicker("option", "minDate", selectedDate);
                                                    }
                                                });
                                                $("#cobranzaClienteFechaFin").datepicker({
                                                    showAnim: "clip",
                                                    changeMonth: true,
                                                    changeYear: true,
                                                    onClose: function(selectedDate) {
                                                        $("#cobranzaClienteFechaInicio").datepicker("option", "maxDate", selectedDate);
                                                    }
                                                });
                                                $("#cobranzaClienteFechaFin").datepicker("option", "minDate", $("#cobranzaClienteFechaInicio").val());
                                                $("#cobranzaClienteFechaInicio").datepicker("option", "maxDate", $("#cobranzaClienteFechaFin").val());
                                            });
                                        </script>
                                    </td>
                                    <td>
                                        <a href="#" class="sexybutton sexyicononly aCobranza" id="reporteClientes4" target="_blank"><span><span><span class="print"></span></span></span></a>
                                    </td>
                                </tr>
                            </thead>
                        </table>
                    </div>
                    <!--compras-->
                    <div id="compras" style="text-align: center;">
                        <table class="reporte-tabla-1">
                            <thead>
                                <tr>
                                    <th>PERIODO</th>
                                    <td>
                                        Del  <input type="text" name="comprasFechaInicio" value="" id="comprasFechaInicio" placeholder="dd/mm/yyyy" readonly=""/>
                                        a <input type="text" name="comprasFechaFin" value="" id="comprasFechaFin" placeholder="dd/mm/yyyy" readonly=""/>
                                    </td>
                                </tr>
                            </thead>
                            <tbody>
                                <tr>
                                    <th style="width: 130px;">TIPO DE REPORTE</th>
                                    <td style="width: 550px;">
                                        <input type="radio" name="tipoReporte" value="documento" checked="checked" id="comprasDocumento"/>Documento &nbsp;&nbsp;&nbsp;
                                        <input type="radio" name="tipoReporte" value="articulo" id="comprasArticulo"/>Artículo
                                    </td>
                                    <td>
                                        <a class="sexybutton sexyicononly aCompras" href="blanco.html" target="imprimirTipoReporte" id="aTipoReporte"><span><span><span class="print"></span></span></span></a>
                                    </td>
                                </tr>
                                <tr>
                                    <th>PROVEEDOR</th>
                                    <td>
                                        <input type="hidden" name="codProveedor" id="comprasCodProveedor" class="compras"/>                                            
                                        <input type="text" name="proveedorSeleccionar" id="comprasProveedorSeleccionar" style="width: 98%;" placeholder="RUC / Razón Social" class="compras"/>
                                    </td>
                                    <td>
                                        <a class="sexybutton sexyicononly aCompras" href="#" target="imprimirProveedor" id="aProveedor"><span><span><span class="print"></span></span></span></a>
                                    </td>
                                </tr>
                            </tbody>
                        </table>
                    </div>
                    <!--proveedor-->
                    <div id="proveedor">
                        Reportes de proveedor
                    </div>
                    <!--reporte de articulos.-->
                    <div id="articuloProducto">
                        <table class="reporte-tabla-1">
                            <thead>
                                <tr>
                                    <th style="width: 160px;"><label>ORDEN</label></th>
                                    <td style="width: 160px;">
                                        <input type="radio" name="articuloOrden" value="articuloAlfabetico" checked="checked" /> Alfabético &nbsp;&nbsp;
                                        <input type="radio" name="articuloOrden" value="articuloNormal" /> Normal
                                    </td>
                                    <th style="width: 160px;">INCLUIR</th>
                                    <td style="width: 200px;" colspan="3">
                                        <input type="checkbox" name="articuloPrecioCompra" value="ON" /> P. Compra &nbsp;&nbsp;
                                        <input type="checkbox" name="articuloPrecioVenta" value="ON" /> P. Venta &nbsp;&nbsp;
                                        <input type="checkbox" name="articuloSerieNumero" value="articuloNormal" value="ON"/> S/N
                                    </td>
                                </tr>
                            </thead>
                            <tbody>
                                <tr>
                                    <th><label>INVENTARIO GENERAL</label></th>
                                    <td colspan="3">
                                        <input type="radio" name="articuloTipoInventario" value="articuloInventarioGeneral" checked="checked" /> General&nbsp;&nbsp;
                                        <input type="radio" name="articuloTipoInventario" value="articuloConStock" /> Con Stock&nbsp;&nbsp;
                                        <input type="radio" name="articuloTipoInventario" value="articuloSinStock" /> Sin stock
                                    </td>
                                    <td style="width: 40px; ">
                                        <a href="#" class="sexybutton sexyicononly aArticulos" id="aArticulosInventario"><span><span><span class="print"></span></span></span></a>
                                    </td>
                                </tr>
                                <tr>
                                    <th><label>FAMILIAS</label></th>
                                    <td colspan="3">
                                        <%
                                            List lFamilia = objcFamilia.leer();
                                        %>
                                        <select id="codFamilia" name="codFamilia" style="width: 90%;">
                                            <option value="">Seleccione</option>
                                            <%
                                                for (int i = 0; i < lFamilia.size(); i++) {
                                                    Familia objFamilia = (Familia) lFamilia.get(i);
                                            %>
                                            <option value="<%=objFamilia.getCodFamilia()%>" ><%=objFamilia.getFamilia()%></option>
                                            <%
                                                }
                                            %>
                                        </select>
                                    </td>
                                    <td>
                                        <a href="#" class="sexybutton sexyicononly aArticulos" id="aArticulosInventarioFamilia"><span><span><span class="print"></span></span></span></a>
                                    </td>
                                </tr>
                            </tbody>
                        </table>
                        <br>
                        <table class="reporte-tabla-1">
                            <thead>
                                <tr>
                                    <th style="width: 160px;">ARTÍCULOS</th>
                                    <td style="width: 500px">
                                        <input type="radio" name="articulosControl" value="reporteArticulosVendidos" checked="checked" /> Vendidos&nbsp;&nbsp;&nbsp;
                                        <input type="radio" name="articulosControl" value="reporteArticulosComprados" /> Comprados
                                    </td>
                                </tr>
                                <tr>
                                    <th>PERIÓDO</th>
                                    <td>
                                        Del  <input type="text" name="articulosFechaInicio" value="" id="articulosFechaInicio" placeholder="dd/mm/yyyy" readonly=""/>
                                        a <input type="text" name="articulosFechaFin" value="" id="articulosFechaFin" placeholder="dd/mm/yyyy" readonly=""/>
                                    </td>
                                    <td>
                                        <a href="#" class="sexybutton sexyicononly aArticulos" id="aArticulosControl"><span><span><span class="print"></span></span></span></a>
                                    </td>
                                </tr>
                            </thead>
                        </table>
                    </div>
                    <div id="otros">
                        Reporte otros
                    </div>
                </div>                
            </div>
            <div style="clear: both;"></div>
            <div id="footer">
                <%@include file="../piePagina.jsp" %>
            </div>
        </div>
    </body>
</html>
<%    }
%>