<%-- 
    Document   : cobranzaNueva
    Created on : 04/10/2013, 05:10:36 PM
    Author     : Henrri
--%>

<%@page import="tablas.ComprobantePago"%>
<%@page import="otrasTablasClases.cComprobantePago"%>
<%@page import="tablas.DatosExtras"%>
<%@page import="java.util.Iterator"%>
<%@page import="java.util.List"%>
<%@page import="otrasTablasClases.cDatosExtras"%>
<%@page import="personaClases.cDatosCliente"%>
<%@page import="tablas.DatosCliente"%>
<%@page import="ventaClases.cVenta"%>
<%@page import="tablas.Ventas"%>
<%@page import="java.util.Date"%>
<%@page import="utilitarios.cManejoFechas"%>
<%
    cManejoFechas objcManejoFechas = new cManejoFechas();
%>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <title>cobranza nueva</title>
        <!--todos-->
        <script type="text/javascript" src="../librerias/jquery/jquery-1.9.0-min.js" ></script>
        <script type="text/javascript" src="../librerias/jquery/jquery.timer-min.js" ></script>
        <script type="text/javascript" src="../librerias/jquery-ui/jquery-ui-1.10.3.custom/js/jquery-ui-1.10.3.custom.min.js" ></script>
        <link rel="stylesheet" type="text/css" href="../librerias/principal/todos.css" media="all"/>
        <!--cambios-->
        <%@include file="../principal/inclusiones.jsp" %>
        <!--propio-->
        <script type="text/javascript" src="../librerias/utilitarios/manejoFecha.js"></script>
        <script type="text/javascript" src="../librerias/utilitarios/formatoDecimal.js"></script>
        <script type="text/javascript" src="../librerias/cobranza/cobranza.js?v14.01.14"></script>
        <script type="text/javascript" src="../librerias/plugin/mask/jquery.mask.min.js"></script>
        <script type="text/javascript" src="../librerias/jquery-ui/jquery-ui-1.10.3.custom/js/i18n/jquery.ui.datepicker-es-min.js"></script>
        <style>
            .ui-autocomplete {
                width: 500px;
                max-height: 200px;
                overflow-y: auto;
                /* prevent horizontal scrollbar */
                overflow-x: hidden;
            }
            /* IE 6 doesn't support max-height
            * we use height instead, but this forces the menu to always be this tall
            */
            * html .ui-autocomplete {
                height: 200px;
            }
        </style>
    </head>
    <body>
        <input type="hidden" name="paginaActualPermiso" id="permisoPaginaP22" value="" title="COBRANZA"/>
        <div id="wrap">
            <div id="header">
                <label class="horaCabecera"><%=objcManejoFechas.fechaCabecera()%></label>
            </div>
            <div id="right" style="width: 1024px;">                
                <div id="rightSub1" class="ocultar">
                    <%
                        int codCliente = 0;
                        try {
                            codCliente = (Integer) session.getAttribute("codClienteCobranza");
                        } catch (Exception e) {
                            Ventas objVentas = new cVenta().leer_ultimaVentaCredito();
                            if (objVentas != null) {
                                codCliente = new cDatosCliente().leer_codPersona(objVentas.getPersona().getCodPersona()).getCodDatosCliente();
                            }
                        }
                    %>
                    <h3 class="titulo"><a href="../index.jsp" class="sexybutton"><span><span><span class="home">Inicio</span></span></span></a> MÓDULO COBRANZA</h3>
                    <div class="ocultar">
                        <input type="text" name="codCliente" id="codCliente" value="<%=codCliente%>" />
                        <label for="codCliente">codCliente</label>
                        <input type="text" name="codPersona" id="codPersona" value="" />
                        <label for="codPersona">codPersona</label>
                        <input type="text" name="codVenta" id="codVenta" value="0" />
                        <label for="codVenta">codVenta</label>
                        <input type="text" name="codPersonaAux" id="codPersonaAux" value="0" />
                        <label for="codPersonaAux">codPersonaAux</label>
                        <input type="text" id="aux" value="0"/>
                        <label for="aux">aux</label>
                        <input type="text" id="auxDocSerieNumero" value=""/>
                        <label for="auxDocSerieNumero">auxDocSerieNumero</label>
                        <input type="text" id="auxCodCobranza" value=""/>
                        <label for="auxCodCobranza">auxCodCobranza</label>
                        <input type="text" id="auxSaldoFavor" value="0.00"/>
                        <label for="auxSaldoFavor">auxSaldoFavor</label>
                        <input type="text" id="marcaSaldoFavor" value="0"/>                    
                        <label for="marcaSaldoFavor">marcaSaldoFavor</label>
                        <input type="text" id="auxCodCobranza2" value="0"/>                    
                        <label for="auxCodCobranza2">auxCodCobranza2</label>
                    </div>
                    <div>
                        <!--inicio div izquierdo-->
                        <div style="width: 50%; float: left;">
                            <!--datos de cliente-->
                            <table class="reporte-tabla-1 anchoTotal">
                                <thead>
                                    <tr>
                                        <th colspan="4" class="centrado medio">NOMBRE / RAZÓN SOCIAL <button class="sexybutton sexyicononly sexysimple sexypropio sexysmall" id="bBuscarCliente" type="button"><span class="search"></span></button></th>
                                    </tr>
                                    <tr>
                                        <td style="width: 15%;">
                                            <span id="sCodCliente" class="vaciar">Cod Cliente</span>
                                        </td>
                                        <td colspan="3"><span id="sNombresC" class="vaciar">Nombres/Razón Social</span></td>
                                    </tr>
                                    <tr>
                                        <td colspan="4"><span id="sDireccion" class="vaciar">Dirección</span></td>
                                    </tr>
                                    <tr>
                                        <td colspan="2"><span id="sEmpresaConvenio" class="vaciar">Empresa/Convenio</span></td>
                                        <td style="width: 25%;"><span id="sCodCobranza" class="vaciar">C. Cobranza</span></td>
                                        <td style="width: 25%;"><span id="sCondicion" class="vaciar">Condición</span></td>
                                    </tr>
                                </thead>
                            </table>
                            <!--detalle de documentos-->
                            <table class="reporte-tabla-2 anchoTotal" style="font-size: 9px; margin-top: 20px;">
                                <thead>
                                    <tr>
                                        <th style="width: 76px;"><label>Documento</label></th>
                                        <th style="width: 65px;"><label>Detalle</label></th>
                                        <th style="width: 65px;"><label>F.Vencim.</label></th>
                                        <th style="width: 45px;"><label>Cuota s/.</label></th>
                                        <th style="width: 45px;"><label>Pagado</label></th>
                                        <th style="width: 65px;"><label>F.Pago</label></th>
                                        <th style="width: 25px;"><label title="Días atrasados">D.</label></th>
                                        <th style="width: 45px;"><label>Int.</label></th>
                                        <th><label>Saldo</label></th>
                                    </tr>
                                </thead>
                            </table>
                            <div style="overflow: auto; height:400px;">
                                <table class="reporte-tabla-2 anchoTotal" style="font-size: 9px;">
                                    <tbody id="tbVentaCreditoLetras">
                                        <%
                                            for (int i = 0; i < 25; i++) {
                                        %>
                                        <tr>
                                            <td style="width: 80px; height: 14px;"></td>
                                            <td style="width: 65px;"></td>
                                            <td style="width: 65px;"></td>
                                            <td style="width: 45px;text-align: right;"></td>
                                            <td style="width: 45px;text-align: right;"></td>
                                            <td style="width: 65px;"></td>
                                            <td style="width: 25px;text-align: right"></td>
                                            <td style="width: 45px;text-align: right"></td>
                                            <td style="text-align: right"></td>
                                        </tr>
                                        <%                                    }
                                        %>
                                    </tbody>
                                </table>
                            </div>
                            <!--detalle de deuda-->
                            <table class="reporte-tabla-1 anchoTotal" style="margin-top: 20px;">
                                <thead>
                                    <tr>
                                        <th style="width: 15%;"><label>Total</label></th>
                                        <td style="text-align: right;"><label id="lTotal">0.00</label></td>
                                        <th style="width: 15%;"><label>Amortizado</label></th>
                                        <td style="text-align: right;"><label id="lAmortizado">0.00</label></td>
                                        <th style="width: 15%;"><label>Saldo</label></th>
                                        <td style="text-align: right;"><label id="lSaldo">0.00</label></td>
                                    </tr>
                                    <tr>
                                        <th style="font-size: 14px;">Filtro</th>
                                        <td colspan="5" style="color: red; font-size: 14px;"><label id="lFiltro">No se esta flitrando el pago.</label></td>
                                    </tr>                                
                                </thead>
                            </table>
                        </div>
                        <!--fin div izquierdo-->
                        <!--inicio div derecho-->
                        <div style="width: 49%; float: right;">
                            <!--tipo pago-->
                            <table class="reporte-tabla-1" style="float: left;width: 30%;">
                                <tbody>
                                    <tr>
                                        <td>
                                            <input type="radio" name="tipoPago" value="normal" checked="checked" id="tipo1" /> <label for="tipo1">Normal</label><br>
                                            <input type="radio" name="tipoPago" value="anticipo" id="tipo2"/> <label for="tipo2">Anticipo</label>
                                        </td>
                                    </tr>
                                </tbody>
                            </table>
                            <!--usar saldo favor-->
                            <table class="reporte-tabla-1" style="width:60%;float: right;">
                                <thead>
                                    <tr>                                
                                        <th class="medio">
                                            Saldo a favor:
                                            <button class="sexybutton" id="bSaldoFavorUsar" type="button"><span><span><span class="ok">USAR</span></span></span></button>
                                        </th>
                                        <td style="text-align: right;width: 70px;">
                                            <span id="sSaldoFavor" class="vaciar">0.00</span>
                                        </td>
                                    </tr>
                                </thead>
                            </table>
                            <!--detalle documento-->
                            <div style="clear: both;"></div>
                            <table class="reporte-tabla-2 anchoTotal" style="margin-top: 20px; font-size: 9px;">
                                <thead>
                                    <tr>
                                        <th style="width: 80px;"><label>Documento</label></th>
                                        <th style="width: 25px;"><label>C.</label></th>
                                        <th style="width: 225px;"><label>Descripción</label></th>
                                        <th style="width: 50px;"><label>P. U.</label></th>
                                        <th><label>T. Venta</label></th>
                                    </tr>
                                </thead>
                            </table>
                            <div style="overflow: auto;height: 100px;">
                                <table class="reporte-tabla-2 anchoTotal" style="font-size: 9px;">
                                    <tbody id="tbVentasDetalle">
                                        <%
                                            for (int i = 0; i < 5; i++) {
                                        %>
                                        <tr>
                                            <td style="width: 80px;height: 14px;"></td>
                                            <td style="width: 25px;"></td>
                                            <td style="width: 225px;"></td>
                                            <td style="width: 50px;text-align: right;"></td>
                                            <td style="text-align: right;"></td>
                                        </tr>
                                        <%                                            }
                                        %>
                                    </tbody>
                                </table>
                            </div>
                            <!--div contenedor cobranza y detalle cobranza-->
                            <div>
                                <div style="float: left;width: 55%;"><!--div panel izquierdo contenedor de recibo-->
                                    <table class="reporte-tabla-2 anchoTotal">
                                        <thead>
                                            <tr>
                                                <th style="width: 65px;"><label>F. Pago</label></th>
                                                <th style="width: 45px;"><label>Monto</label></th>
                                                <th style="width: 90px;"><label>Recibo</label></th>
                                                <th><label>Saldo</label></th>
                                            </tr>
                                        </thead>
                                    </table>
                                    <div style="overflow: auto;height: 340px;">
                                        <table class="reporte-tabla-2 anchoTotal" id="tCobranza"style="font-size: 9px;">
                                            <%
                                                for (int i = 0; i < 25; i++) {
                                            %>
                                            <tr>
                                                <td style="width: 65px;height: 14px;"></td>
                                                <td style="width: 45px;"></td>
                                                <td style="width: 80px;"></td>
                                                <td style="text-align: right;"></td>
                                            </tr>
                                            <%                                            }
                                            %>
                                        </table>
                                    </div>
                                </div>
                                <!--fin div panel izquierdo contenedor recibo-->
                                <div style="float: right; width: 44%;"><!--div inicio panel derecho detalle-->
                                    <table class="reporte-tabla-2 anchoTotal">
                                        <tr>
                                            <th class="centrado"><label>Detalle de cobranza</label></th>
                                        </tr>
                                    </table>
                                    <div style="overflow: auto;height: 120px;">
                                        <table class="reporte-tabla-2 anchoTotal" id="tCobranzaDetalle" style="font-size: 9px;">
                                        </table>
                                    </div>
                                    <div>
                                        <table class="reporte-tabla-2 anchoTotal" style="font-size: 9px">
                                            <thead>
                                                <tr>
                                                    <th style="width: 45px;"><label>Año/Mes</label></th>
                                                    <th style="width: 50px;"><label>Monto</label></th>
                                                    <th style="width: 50px;"><label>Pagos</label></th>
                                                    <th><label>Saldo</label></th>
                                                </tr>
                                            </thead>
                                        </table>
                                        <div id="dVentaCreditoLetraResumenMensual" style="overflow: auto;height: 200px;">
                                            <table class="reporte-tabla-2 anchoTotal" id="tCobranzaResumen" style="font-size: 9px;">
                                                <%
                                                    for (int i = 0; i < 20; i++) {
                                                %>
                                                <tr>
                                                    <td style="width: 45px;height: 14px;"></td>
                                                    <td style="width: 50px; text-align: right;"></td>
                                                    <td style="width: 50px; text-align: right;"></td>
                                                    <td style="text-align: right;"></td>
                                                </tr>
                                                <%                                                }
                                                %>
                                            </table>
                                        </div>
                                    </div>                            
                                </div>
                            </div>
                            <div style="clear: both;"></div>
                            <!--nuevo pago-->
                            <table class="reporte-tabla-1" style="margin-top: 20px;">
                                <thead>
                                    <tr>
                                        <th><label>Recibo</label></th>
                                        <th><label>Fecha</label></th>
                                        <th><label>Monto</label></th>
                                        <th style="text-align: center;"><label>Opciones</label></th>
                                    </tr>
                                    <tr>
                                        <td class="ancho200px">
                                            <div id="dUsarSaldoFavor" style="font-size: 12px; font-weight: bold;" class="ocultar">
                                                <span>XXX-111-999999</span>
                                            </div>
                                            <div id="dNoUsarSaldoFavor">
                                                <%
                                                    String tipoRecCaja = "";
                                                %>
                                                <div id="dCaja" style="font-size: 12px; font-weight: bold;">
                                                    <select name="docRecCaja" id="docRecCaja" class="entrada" style="padding: 0px;">
                                                        <%
                                                            List DatosExtrasList = new cDatosExtras().leer_documentoCaja();
                                                            int cont1 = 0;
                                                            for (Iterator it = DatosExtrasList.iterator(); it.hasNext();) {
                                                                DatosExtras objDatosExtras = (DatosExtras) it.next();
                                                                if (cont1++ == 0) {
                                                                    tipoRecCaja = objDatosExtras.getLetras();
                                                                }
                                                        %>
                                                        <option value="<%=objDatosExtras.getLetras()%>"><%=objDatosExtras.getLetras()%></option>
                                                        <%
                                                            }
                                                        %>
                                                    </select><span>-</span><select name="serieSelect" id="serieSelect" style="padding: 0px;" class="entrada">
                                                        <%
                                                            List comPagoList = new cComprobantePago().leer_serieGenerada(tipoRecCaja);
                                                            for (Iterator it = comPagoList.iterator(); it.hasNext();) {
                                                                ComprobantePago objComprobantePago = (ComprobantePago) it.next();
                                                        %>
                                                        <option value="<%=objComprobantePago.getSerie()%>"><%=objComprobantePago.getSerie()%></option>
                                                        <%
                                                            }
                                                        %>
                                                    </select><span>-XXXXXX</span>
                                                </div>
                                                <div id="dDescuento" class="ocultar" style="font-size: 12px; font-weight: bold;">                                                    
                                                    <select name="docRecDesc" id="docRecDesc" class="entrada" style="padding: 0px;">

                                                    </select>
                                                    <span>-</span>
                                                    <input type="text" name="serie" id="serie" value="" class="ancho40px entrada" style=" font-size: 18px;" /><span>-XXXXXX</span>
                                                </div>
                                                <div id="dManual" class="ocultar contenedorEntrada" style="font-size: 12px;font-weight: bold;">
                                                    <input type="text" name="docSerieNumero" id="docSerieNumero" class="anchoTotal limpiar entrada mayuscula"/>
                                                </div>
                                            </div>
                                        </td>
                                        <td class="contenedorEntrada ancho80px">
                                            <input type="text" name="fechaCobranza" id="fechaCobranza" value="<%=objcManejoFechas.DateAString(new Date())%>" class="anchoTotal entrada" style="font-size: 16px;" />
                                            <input type="hidden" name="auxFecha" id="auxFecha" value="<%=objcManejoFechas.DateAString(new Date())%>" />
                                        </td>
                                        <td class="contenedorEntrada ancho120px">
                                            <input type="text" name="montoAmortizar" value="" id="montoAmortizar" class="anchoTotal derecha entrada" style="font-size: 16px;" /> 
                                        </td>
                                        <td>
                                            <button class="sexybutton sexyicononly sexysimple sexysmall sexypropio" id="bAmortizar" type="button"><span class="save"></span></button>                                            
                                        </td>
                                    </tr>
                                    <tr>
                                        <th class="izquierda" style="font-size: 10px;">
                                            <input type="radio" name="tipoCobro" id="rdCaja" value="caja" checked="checked" /><label for="rdCaja">Caja</label>
                                            <input type="radio" name="tipoCobro" id="rdDescuento" value="descuento" /><label for="rdDescuento">Desc.</label>
                                            <input type="radio" name="tipoCobro" id="rdManual" value="manual"/><label for="rdManual">Manual</label>
                                        </th>
                                        <td colspan="3">
                                            <a class="sexybutton" href="reporte/cobranzaImprimir.jsp" target="_blank" id="cobranzaImprimir"><span><span><span class="print">Imp. Matri</span></span></span></a>
                                            <a class="sexybutton" href="#" id="bImprimirTicket"><span><span><span class="print">Imp. Ticket</span></span></span></a>
                                        </td>
                                    </tr>
                                </thead>
                            </table>
                        </div>
                        <!--fin div derecho-->
                    </div>
                    <!--dalog********************************************************************-->
                    <div id="dClienteBuscar" title="BUSCAR CLIENTE" style="padding: 20px;">
                        <table class="reporte-tabla-1 anchoTotal" >
                            <thead>
                                <tr>
                                    <th class="ancho120px"><label>COD. CLIENTE</label></th>
                                    <th style=""><label>DNI-PASPORTE/RUC APELLIDOS-NOMBRES/RAZÓN SOCIAL</label></th>
                                </tr>
                            </thead>
                            <tbody>
                                <tr>
                                    <td class="contenedorEntrada">
                                        <input type="text" name="codClienteBuscar" id="codClienteBuscar" value="" class="entrada anchoTotal derecha" />
                                    </td>
                                    <td class="contenedorEntrada">
                                        <input type="text" name="dniPasaporteRucNombresCBuscar" id="dniPasaporteRucNombresCBuscar" value="" class="entrada anchoTotal"/>
                                    </td>
                                </tr>
                            </tbody>
                        </table>
                    </div>
                    <!--confirmar grabacion-->
                    <div id="dAmortizarConfirmar" title="Confirmar cobranza" style="font-size: 13px; text-align: justify;">
                        <strong>¡Confirmar!</strong> Esta a un clic de realizar el pago, tenga en cuenta que no se podra anular esta operación, antes de ello verifique los datos nuevamente.
                        <b>¿Está ud. seguro de continuar?</b><br>
                        <b>Tipo de operacion: </b><label id="lTipoOperacion" style="font-size: 14px;color: red;"></label>
                    </div>

                    <!--confirmar saldo a favor-->
                    <div id="dConfirmarSaldoFavor" title="Saldo a favor">
                        <strong>!Confirmar¡</strong> El monto a pagar supera la deuda mantenida, se activará <b>SALDO A FAVOR</b><br>
                        (Pago)<label></label> - (Deuda)<label></label> = (Diferencia)<label></label><br>
                        <b>Saldo a favor:</b> <label></label><br>
                        ¿Confirma operación? Despues no se podrá borrar este pago
                    </div>

                    <div id="dConfirmarFiltro" title="Confirmar Filtro" style="font-size: 16px;">
                        <strong>¡Confirmar!</strong> Se va a filtrar solo por este <b>DOCUMENTO</b><br>
                        Esta seguro de hacerlo
                    </div>

                    <!--confirmar saldo a favor usar-->

                    <div id="dSaldoFavorConfirmar" title="Saldo a favor">
                        Se va a utilizar <b>SALDO A FAVOR</b> del cliente, ¿está seguro de continuar?
                    </div>

                    <div id="dCobranzaEliminar" title="Eliminar conbraza">
                        Se eliminara definitivamente el pago correspondiente seleccionado<br>
                        ¿Desea continuar?
                    </div>
                </div>
                <div id="rightSub2" class="ocultar">
                    <div>
                        <h3 class="titulo">INPORTADORA YUCRA S.A.C.</h3>
                        <div class="articles" style="font-size: 12px;padding: 10px;text-align: justify;">
                            Como llegar a Yucra desde el óvalo Saenz Peña.
                            <br /><br />
                            <img src="../librerias/imagenes/ruta_yucra.PNG" alt="Example pic" style="border: 3px solid #ccc;" />
                            <br/><br />
                            Yucra se basa en 5 pilares:<br>
                            Calidad de servicio<br>
                            Responsabilidad<br>
                            Puntualidad<br>
                            Honestidad<br>
                            Respeto
                        </div>
                    </div>
                    <div>
                        <div style="width: 48%; float: left;">
                            <h3 class="titulo">MISIÓN</h3>
                            <div class="articles" style="font-size: 12px;padding: 10px;text-align: justify;">
                                Somos la empresa comercial que brinda servicio personalizado con una amplia gama de productos de calidada través de una cultura de valores.
                            </div>
                        </div>
                        <div style="width: 48%; float: right;">
                            <h3 class="titulo">VISIÓN</h3>
                            <div class="articles" style="font-size: 12px;padding: 10px;text-align: justify;">
                                Ser la empresa comercial con productos de calidad para la exigencia de cada necesidad brindando un servicio de excelencia.
                            </div>
                        </div>
                    </div>
                </div>
            </div>
            <div id="left" class="ocultar">
                <div class="acceso">
                    <h3 class="titulo">INICIE SESIÓN</h3>                    
                    <button class="sexybutton" id="bAccesoAbrir" type="button"><span><span><img src="../librerias/botonesIconos/images/icons/silk/key_go.png">Ejecutar SICCI</span></span></button>
                </div>
                <div id="menu" class="ocultar">
                    <%@include file="../principal/menu.jsp" %>
                </div>
            </div>
            <div style="clear: both;"></div>
            <div id="footer">
                <%@include file="../principal/piePagina.jsp" %>
            </div>
        </div>
    </body>
</html>