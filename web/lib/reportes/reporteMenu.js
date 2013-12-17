/* 
 * To change this template, choose Tools | Templates
 * and open the template in the editor.
 */

$(document).ready(function() {
    /*
     * ===========================================================================
     * autocompletados
     */
    $("#comprasProveedorSeleccionar").autocomplete({
        source: "autocompletado/proveedorRucRazonSocialBuscarAutocompletado.jsp",
        minLength: 2,
        select: comprasProveedorSeleccionado,
        focus: comprasProveedorMarcado
    });

    $("#clienteCobradorBuscar").autocomplete({
        source: "autocompletado/cobradorVendedor.jsp",
        minLength: 2,
        select: clientesCobradorSeleccionado,
        focus: clientesCobradorMarcado
    });
    $('.clienteCobrador').click(function() {
        if ($(this).val() == 'todos') {
            $('#tdClienteCobrador').addClass('ocultar');
        }
        ;
        if ($(this).val() == 'cobrador') {
            $('#tdClienteCobrador').removeClass('ocultar');
        }
    });
    //ventas

    $('#ventaSerieNumero').mask('999');
//cobranza
//    $('#cobranzaSerieDocumento').mask('a-999');

    $('#aCobranzaCobradorBuscar').click(function(event) {
        event.preventDefault();
    });

    $('#aCobranzaCobradorLimpiar').click(function(event) {
        $('#cobranzaCobradorBuscar').val('');
        $('#cobranzaCodCobrador').val('');
        event.preventDefault();
    });

    $("#cobranzaCobradorBuscar").autocomplete({
        source: "autocompletado/cobradorVendedor.jsp",
        minLength: 2,
        select: cobranzaCobradorSeleccionado,
        focus: cobranzaCobradorMarcado
    });

    /*
     * ══════════════════════════════════════════════════════
     * eventos clic para los <a> con class pritn
     */
    $('.aClientes').click(function(event) {
        $('#dMensajeAlertaDiv').empty();
        $('#dMensajeAlerta').dialog({title: 'Corriga los errores.'});
        var estado = true;
        var $boton = $('#' + $(this).attr('id'));   //obteniendo id del boton clickeado
        var clienteOrden = $("input[name=clienteOrden]:checked").val();   //obteniendo orden
        var codEmpresaConvenio = $('#clienteCodEmpresaConvenio').val();
        var tipo = $('#clienteTipo').val();
        var condicion = $('#clienteCondicion').val();
        var clienteCobrador = $("input[name=clienteCobrador]:checked").val();
        if (clienteCobrador == 'todos') {
            switch ($(this).attr('id')) { //case
                case 'reporteCliente':
                    $(this).attr('target', '_blank').attr('href', 'clientes/' + clienteOrden + '.jsp');
                    break;
                case 'reporteClienteEmpresaConvenio':
                    if (codEmpresaConvenio == '') {
                        $('#dMensajeAlertaDiv').append('<label style="color:red;">* Seleccione empresa.</label><br>');
                        estado = false;
                    }
                    if (!estado) {
                        $('#dMensajeAlerta').dialog('open');
                        return;
                    }
                    $(this).attr('target', '_blank').attr('href', 'clientes/' + clienteOrden + 'EmpresaConvenio.jsp?codEmpresaConvenio=' + codEmpresaConvenio);
                    break;
                case 'reporteClienteEmpresaConvenioTipo':
                    if (codEmpresaConvenio == '') {
                        $('#dMensajeAlertaDiv').append('<label style="color:red;">* Seleccione empresa.</label><br>');
                        estado = false;
                    }
                    if (tipo == '') {
                        $('#dMensajeAlertaDiv').append('<label style="color:red;">* Seleccione tipo.</label><br>');
                        estado = false;
                    }
                    if (!estado) {
                        $('#dMensajeAlerta').dialog('open');
                        event.preventDefault();
                    }
                    $(this).attr('target', '_blank').attr('href', 'clientes/' + clienteOrden + 'EmpresaConvenioTipo.jsp?codEmpresaConvenio=' + codEmpresaConvenio + '&tipo=' + tipo);
                    break;
                case 'reporteClienteEmpresaConvenioTipoCondicion':
                    if (codEmpresaConvenio == '') {
                        $('#dMensajeAlertaDiv').append('<label style="color:red;">* Seleccione empresa.</label><br>');
                        estado = false;
                    }
                    if (tipo == '') {
                        $('#dMensajeAlertaDiv').append('<label style="color:red;">* Seleccione tipo.</label><br>');
                        estado = false;
                    }
                    if (condicion == '') {
                        $('#dMensajeAlertaDiv').append('<label style="color:red;">* Seleccione condición.</label><br>');
                        estado = false;
                    }
                    if (!estado) {
                        $('#dMensajeAlerta').dialog('open');
                        event.preventDefault();
                    }
                    $(this).attr('target', '_blank').attr('href', 'clientes/' + clienteOrden + 'EmpresaConvenioTipoCondicion.jsp?codEmpresaConvenio=' + codEmpresaConvenio + '&tipo=' + tipo + '&condicion=' + condicion);
                    break;
                case 'reporteClienteLetrasVencidas':
                    $(this).attr('target', '_blank').attr('href', 'clientes/' + clienteOrden + 'LetrasVencidas.jsp?fechaVencimiento=' + $('#clienteFechaVencimientoLetraGeneral').val());
                    break;
                case 'reporteClienteLetrasVencidasExcel':
                    $(this).attr('target', '_blank').attr('href', 'clientes/' + clienteOrden + 'LetrasVencidasExcel.jsp?fechaVencimiento=' + $('#clienteFechaVencimientoLetraGeneral').val());
                    break;
                case 'reporteClienteLetrasVencidasTramosExcel':
                    $(this).attr('target', '_blank').attr('href', 'clientes/' + clienteOrden + 'LetrasVencidasTramosExcel.jsp?fechaVencimiento=' + $('#clienteFechaVencimientoLetraGeneral').val());
                    break;
                case 'reporteClienteEmpresaConvenioLetrasVencidas':
                    if (codEmpresaConvenio == '') {
                        alert('Seleccione empresa');
                        return;
                    }
                    $(this).attr('target', '_blank').attr('href', 'clientes/' + clienteOrden + 'EmpresaConvenioLetrasVencidas.jsp?codEmpresaConvenio=' + codEmpresaConvenio + '&fechaVencimiento=' + $('#clienteFechaVencimientoLetra').val());
                    break;
                case 'reporteClienteEmpresaConvenioLetrasVencidasTipo':
                    if (codEmpresaConvenio == '') {
                        $('#dMensajeAlertaDiv').append('<label style="color:red;">* Seleccione empresa.</label><br>');
                        estado = false;
                    }
                    if (tipo == '') {
                        $('#dMensajeAlertaDiv').append('<label style="color:red;">* Seleccione tipo.</label><br>');
                        estado = false;
                    }
                    if (!estado) {
                        $('#dMensajeAlerta').dialog('open');
                        event.preventDefault();
                    }
                    $(this).attr('target', '_blank').attr('href', 'clientes/' + clienteOrden + 'EmpresaConvenioLetrasVencidasTipo.jsp?codEmpresaConvenio=' + codEmpresaConvenio + '&fechaVencimiento=' + $('#clienteFechaVencimientoLetraTipo').val() + '&tipo=' + tipo);
                    break;
                case 'reporteClienteEmpresaConvenioLetrasVencidasTipoCondicion':
                    if (codEmpresaConvenio == '') {
                        $('#dMensajeAlertaDiv').append('<label style="color:red;">* Seleccione empresa.</label><br>');
                        estado = false;
                    }
                    if (tipo == '') {
                        $('#dMensajeAlertaDiv').append('<label style="color:red;">* Seleccione tipo.</label><br>');
                        estado = false;
                    }
                    if (condicion == '') {
                        $('#dMensajeAlertaDiv').append('<label style="color:red;">* Seleccione condición.</label><br>');
                        estado = false;
                    }
                    if (!estado) {
                        $('#dMensajeAlerta').dialog('open');
                        event.preventDefault();
                    }
                    $(this).attr('target', '_blank').attr('href', 'clientes/' + clienteOrden + 'EmpresaConvenioLetrasVencidasTipoCondicion.jsp?codEmpresaConvenio=' + codEmpresaConvenio + '&fechaVencimiento=' + $('#clienteFechaVencimientoLetraTipoCondicion').val() + '&tipo=' + tipo + '&condicion=' + condicion);
                    break;
                case 'reporteClienteEmpresaConvenioLetrasVencidasExcel':
                    if (codEmpresaConvenio == '') {
                        alert('Seleccione empresa');
                        return;
                    }
                    $(this).attr('target', '_blank').attr('href', 'clientes/' + clienteOrden + 'EmpresaConvenioLetrasVencidasExcel.jsp?codEmpresaConvenio=' + codEmpresaConvenio + '&fechaVencimiento=' + $('#clienteFechaVencimientoLetra').val());
                    break;
                case 'reporteClienteEmpresaConvenioLetrasVencidasTipoExcel':
                    if (codEmpresaConvenio == '') {
                        $('#dMensajeAlertaDiv').append('<label style="color:red;">* Seleccione empresa.</label><br>');
                        estado = false;
                    }
                    if (tipo == '') {
                        $('#dMensajeAlertaDiv').append('<label style="color:red;">* Seleccione tipo.</label><br>');
                        estado = false;
                    }
                    if (!estado) {
                        $('#dMensajeAlerta').dialog('open');
                        event.preventDefault();
                    }
                    $(this).attr('target', '_blank').attr('href', 'clientes/' + clienteOrden + 'EmpresaConvenioLetrasVencidasTipoExcel.jsp?codEmpresaConvenio=' + codEmpresaConvenio + '&fechaVencimiento=' + $('#clienteFechaVencimientoLetraTipo').val() + '&tipo=' + tipo);
                    break;
                case 'reporteClienteEmpresaConvenioLetrasVencidasTipoCondicionExcel':
                    if (codEmpresaConvenio == '') {
                        $('#dMensajeAlertaDiv').append('<label style="color:red;">* Seleccione empresa.</label><br>');
                        estado = false;
                    }
                    if (tipo == '') {
                        $('#dMensajeAlertaDiv').append('<label style="color:red;">* Seleccione tipo.</label><br>');
                        estado = false;
                    }
                    if (condicion == '') {
                        $('#dMensajeAlertaDiv').append('<label style="color:red;">* Seleccione condición.</label><br>');
                        estado = false;
                    }
                    if (!estado) {
                        $('#dMensajeAlerta').dialog('open');
                        event.preventDefault();
                    }
                    $(this).attr('target', '_blank').attr('href', 'clientes/' + clienteOrden + 'EmpresaConvenioLetrasVencidasTipoCondicionExcel.jsp?codEmpresaConvenio=' + codEmpresaConvenio + '&fechaVencimiento=' + $('#clienteFechaVencimientoLetra').val() + '&tipo=' + tipo + '&condicion=' + condicion);
                    break;
                case 'reporteClienteEmpresaConvenioLetrasVencidasTramosExcel':
                    if (codEmpresaConvenio == '') {
                        alert('Seleccione empresa');
                        return;
                    }
                    $(this).attr('target', '_blank').attr('href', 'clientes/' + clienteOrden + 'EmpresaConvenioLetrasVencidasTramosExcel.jsp?codEmpresaConvenio=' + codEmpresaConvenio + '&fechaVencimiento=' + $('#clienteFechaVencimientoLetra').val());
                    break;
                default :
                    $('#dMensajeAlertaDiv').append('<label style="color:red;">* Reporte no implementado.</label><br>Id: ' + $(this).attr('id') + '<br>');
                    $('#dMensajeAlerta').dialog('open');
            }
        } else {
            var codCobrador = $('#clienteCodCobrador').val();
            if (codCobrador == '') {
                alert('Seleccione cobrador');
                event.preventDefault();
                return;
            }
            switch ($(this).attr('id')) {
                case 'reporteCliente':
                    $(this).attr('target', 'cliente').attr('href', 'clientes/cobrador/' + clienteOrden + '.jsp?codCobrador=' + codCobrador);
                    break;
                case 'reporteClienteEmpresaConvenio':
                    if (codEmpresaConvenio == '') {
                        alert('Seleccione empresa');
                        return;
                    }
                    $(this).attr('target', 'cliente').attr('href', 'clientes/cobrador/' + clienteOrden + 'EmpresaConvenio.jsp?codEmpresaConvenio=' + codEmpresaConvenio + '&codCobrador=' + codCobrador);
                    break;
                case 'reporteClienteLetrasVencidas':
                    $(this).attr('target', 'cliente').attr('href', 'clientes/cobrador/' + clienteOrden + 'LetrasVencidas.jsp?fechaVencimiento=' + $('#clienteFechaVencimientoLetraGeneral').val() + '&codCobrador=' + codCobrador);
                    break;
                case 'reporteClienteLetrasVencidasExcel':
                    $(this).attr('target', '_blank').attr('href', 'clientes/cobrador/' + clienteOrden + 'LetrasVencidasExcel.jsp?fechaVencimiento=' + $('#clienteFechaVencimientoLetraGeneral').val() + '&codCobrador=' + codCobrador);
                    break;
                case 'reporteClienteLetrasVencidasTramosExcel':
                    $(this).attr('target', '_blank').attr('href', 'clientes/cobrador/' + clienteOrden + 'LetrasVencidasTramosExcel.jsp?fechaVencimiento=' + $('#clienteFechaVencimientoLetraGeneral').val() + '&codCobrador=' + codCobrador);
                    break;
                case 'reporteClienteEmpresaConvenioLetrasVencidas':
                    if (codEmpresaConvenio == '') {
                        alert('Seleccione empresa');
                        return;
                    }
                    $(this).attr('target', 'cliente').attr('href', 'clientes/cobrador/' + clienteOrden + 'EmpresaConvenioLetrasVencidas.jsp?codEmpresaConvenio=' + codEmpresaConvenio + '&fechaVencimiento=' + $('#clienteFechaVencimientoLetra').val() + '&codCobrador=' + codCobrador);
                    break;
                case 'reporteClienteEmpresaConvenioLetrasVencidasExcel':
                    if (codEmpresaConvenio == '') {
                        alert('Seleccione empresa');
                        return;
                    }
                    $(this).attr('target', '_blank').attr('href', 'clientes/cobrador/' + clienteOrden + 'EmpresaConvenioLetrasVencidasExcel.jsp?codEmpresaConvenio=' + codEmpresaConvenio + '&fechaVencimiento=' + $('#clienteFechaVencimientoLetra').val() + '&codCobrador=' + codCobrador);
                    break;
                case 'reporteClienteEmpresaConvenioLetrasVencidasTramosExcel':
                    if (codEmpresaConvenio == '') {
                        alert('Seleccione empresa');
                        return;
                    }
                    $(this).attr('target', '_blank').attr('href', 'clientes/cobrador/' + clienteOrden + 'EmpresaConvenioLetrasVencidasTramosExcel.jsp?codEmpresaConvenio=' + codEmpresaConvenio + '&fechaVencimiento=' + $('#clienteFechaVencimientoLetra').val() + '&codCobrador=' + codCobrador);
                    break;
                default :
                    $('#dMensajeAlertaDiv').append('<label style="color:red;">* Reporte no implementado.</label><br>Id: ' + $(this).attr('id') + '<br>');
                    $('#dMensajeAlerta').dialog('open');
            }
        }
    });

    $(".aVentas").click(function(event) {
        var ventaTipo = $('input[name=ventaTipo]:checked').val();
        var id = $(this).attr('id');
        var fechaInicio = 'fechaInicio=' + $("#ventasFechaInicio").val();
        var fechaFin = 'fechaFin=' + $("#ventasFechaFin").val();
        var fechaInicioAnulado = 'fechaInicio=' + $("#ventasAnuladosFechaInicio").val();
        var fechaFinAnulado = 'fechaFin=' + $("#ventasAnuladosFechaFin").val();
        var ventaSerieNumero = $('#ventaSerieNumero').val();
        var ventaSerieLetra = $('#ventaSerieLetra').val() + '-';
        var vendedor = $('#ventasCodVendedor').val();
        switch (id) {
            case'ventasPeriodo':
                $(this).attr('target', '_blank').attr('href', 'ventas/' + id + '.jsp?ventaTipo=' + ventaTipo + '&' + fechaInicio + '&' + fechaFin);
                break;
            case 'ventasPeriodoExcel':
                $(this).attr('target', '_blank').attr('href', 'ventas/' + id + '.jsp?ventaTipo=' + ventaTipo + '&' + fechaInicio + '&' + fechaFin);
                break;
            case 'ventasDocumento':
                if (ventaSerieNumero == '') {
                    alert('Escriba serie.');
                    event.preventDefault();
                }
                $(this).attr('target', '_blank').attr('href', 'ventas/' + id + '.jsp?ventaTipo=' + ventaTipo + '&' + fechaInicio + '&' + fechaFin + '&serie=' + ventaSerieLetra + ventaSerieNumero);
                break;
            case 'ventasDocumentoExcel':
                if (ventaSerieNumero == '') {
                    alert('Escriba serie.');
                    event.preventDefault();
                }
                $(this).attr('target', '_blank').attr('href', 'ventas/' + id + '.jsp?ventaTipo=' + ventaTipo + '&' + fechaInicio + '&' + fechaFin + '&serie=' + ventaSerieLetra + ventaSerieNumero);
                break;
            case'ventasVendedor':
                if (vendedor == '') {
                    alert('Seleccione vendedor.');
                    event.preventDefault();
                }
                $(this).attr('target', '_blank').attr('href', 'ventas/' + id + '.jsp?ventaTipo=' + ventaTipo + '&' + fechaInicio + '&' + fechaFin + '&codVendedor=' + vendedor);
                break;
            case 'ventasVendedorExcel':
                if (vendedor == '') {
                    alert('Seleccione vendedor.');
                    event.preventDefault();
                }
                $(this).attr('target', '_blank').attr('href', 'ventas/' + id + '.jsp?ventaTipo=' + ventaTipo + '&' + fechaInicio + '&' + fechaFin + '&codVendedor=' + vendedor);
                break;
            case 'ventasAnulados':
                $(this).attr('target', '_blank').attr('href', 'ventas/' + id + '.jsp?ventaTipo=' + ventaTipo + '&' + fechaInicioAnulado + '&' + fechaFinAnulado);
                break;
            case 'ventasAnuladosExcel':
                $(this).attr('target', '_blank').attr('href', 'ventas/' + id + '.jsp?ventaTipo=' + ventaTipo + '&' + fechaInicioAnulado + '&' + fechaFinAnulado);
                break;
            default:
                alert(id);
                event.preventDefault();
        }

    });

    $('.aCobranza').click(function(event) {
        $('#dMensajeAlertaDiv').empty();
        var tipoReporte = 'tipo=' + $('input[name=cobranzaTipo]:checked').val();
        var fecha1 = 'fecha1=' + $('#cobranzaFechaInicio').val();
        var fecha2 = 'fecha2=' + $('#cobranzaFechaFin').val();
        if ($('#cobranzaCobrador').is(':checked')) {
            var codCobrador = $('#cobranzaCodCobrador').val();
            if (codCobrador == null || codCobrador == '' || $.trim(codCobrador) == '') {
                $('#dMensajeAlertaDiv').append('<label style="color:red;">* SeleccioneCobrador.</label><br>');
                $('#dMensajeAlerta').dialog('open');
                event.preventDefault();
            }
            codCobrador = 'codCobrador=' + codCobrador;
            switch ($(this).attr('id')) {
                case 'reporteClientes1':
                    $(this).attr('href', 'cobranza/cobrador/periodo.jsp?' + tipoReporte + '&' + fecha1 + '&' + fecha2 + '&' + codCobrador);
                    break;
                case 'reporteClientes2':
                    var doc = $('#cobranzaSerieDocumento').val();
                    if (doc == '') {
                        alert('Ingrese Serie del documento');
                        event.preventDefault();
                    }
                    $(this).attr('href', 'cobranza/cobrador/documento.jsp?' + tipoReporte + '&' + fecha1 + '&' + fecha2 + '&documento=' + doc + '&' + codCobrador);
                    break;
                case 'reporteClientes3':
                    $(this).attr('href', 'cobranza/cobrador/anulados.jsp?' + tipoReporte + '&' + fecha1 + '&' + fecha2 + '&' + codCobrador);
                    break;
                case 'reporteClientes4':
                    var fecha11 = 'fecha1=' + $("#cobranzaClienteFechaInicio").val();
                    var fecha22 = 'fecha2=' + $("#cobranzaClienteFechaFin").val();
                    $(this).attr('href', 'cobranza/cobrador/clientesPagos.jsp?' + tipoReporte + '&' + fecha11 + '&' + fecha22 + '&' + codCobrador);
                    break;
            }
        } else {
            switch ($(this).attr('id')) {
                case 'reporteClientes1':
                    $(this).attr('href', 'cobranza/periodo.jsp?' + tipoReporte + '&' + fecha1 + '&' + fecha2);
                    break;
                case 'reporteClientes2':
                    var doc = $('#cobranzaSerieDocumento').val();
                    if (doc == '') {
                        alert('Ingrese Serie del documento');
                        event.preventDefault();
                    }
                    $(this).attr('href', 'cobranza/documento.jsp?' + tipoReporte + '&' + fecha1 + '&' + fecha2 + '&documento=' + doc);
                    break;
                case 'reporteClientes3':
                    $(this).attr('href', 'cobranza/anulados.jsp?' + tipoReporte + '&' + fecha1 + '&' + fecha2);
                    break;
                case 'reporteClientes4':
                    var fecha11 = 'fecha1=' + $("#cobranzaClienteFechaInicio").val();
                    var fecha22 = 'fecha2=' + $("#cobranzaClienteFechaFin").val();
                    $(this).attr('href', 'cobranza/clientesPagos.jsp?' + fecha11 + '&' + fecha22);
                    break;
            }
        }
    });

    $(".aCompras").click(function(event) {
        var $boton = $("#" + $(this).attr("id")); //creamos una variable a traves del boton hecho clic
        if ($("#comprasFechaInicio").val() != "" & $("#comprasFechaFin").val() != "") {
            if ($boton.attr("id") == "aTipoReporte") {
                var tipoReporte;
                if ($("#comprasDocumento").is(":checked")) {   //si el check esta en documento
                    tipoReporte = "documento";
                } else {
                    if ($("#comprasArticulo").is(":checked")) {    //si el check esta en articulo
                        tipoReporte = "articulo";
                    } else {
                        return;
                        event.preventDefault();
                    }
                }
                $(this).attr("href", "compras/reportePeriodo.jsp?tipoReporte=" + tipoReporte + "&fechaInicio=" + $("#comprasFechaInicio").val() + "&fechaFin=" + $("#comprasFechaFin").val());
            }
            if ($boton.attr("id") == "aProveedor") {
                if ($.trim($("#comprasCodProveedor").val()) != "") {
                    $(this).attr("href", "compras/reporteProveedor.jsp?fechaInicio=" + $("#comprasFechaInicio").val() + "&fechaFin=" + $("#comprasFechaFin").val() + "&codProveedor=" + $("#comprasCodProveedor").val());
                } else {
                    alert("Seleccione proveedor");
                    event.preventDefault();
                }
            }
        } else {
            alert("Seleccione periodo");
            event.preventDefault();
        }
    });

    $(".aProveedor").click(function(event) {

    });

    $(".aArticulos").click(function(event) {
        var articuloOrden = $("input[name=articuloOrden]:checked").val();
        var pCompra = $('input[name=articuloPrecioCompra]').is(':checked') ? ("&pCompra=" + $('input[name=articuloPrecioCompra]').val()) : "";
        var pVenta = $('input[name=articuloPrecioVenta]').is(':checked') ? ("&pVenta=" + $('input[name=articuloPrecioVenta]').val()) : "";
        var sn = $('input[name=articuloSerieNumero]').is(':checked') ? ("&sn=ON") : "";
        var familia = "&codFamilia=" + $("#codFamilia").val();
        var direccion;
        var direccion2;
        var articuloControl = $("input[name=articulosControl]:checked").val();
        var fechaInicio = $("#articulosFechaInicio").val();
        var fechaFin = $("#articulosFechaFin").val();
        switch ($('input[name=articuloTipoInventario]:checked').val()) {
            case 'articuloInventarioGeneral':
                direccion = "reporteArticuloInventarioGeneral";
                direccion2 = "reporteArticuloInventarioGeneral.jsp";
                break;
            case 'articuloConStock':
                direccion = "reporteArticuloConStock";
                direccion2 = "reporteArticuloConStock.jsp";
                break;
            case 'articuloSinStock':
                direccion = "reporteArticuloSinStock";
                direccion2 = "reporteArticuloSinStock.jsp";
                break;
        }
//        event.preventDefault();
        switch ($(this).attr("id")) {
            case 'aArticulosInventario':
                $(this).attr("target", direccion).attr("href", "articuloProducto/" + direccion + ".jsp?orden=" + articuloOrden + pCompra + pVenta+sn);
                break;
            case 'aArticulosInventarioFamilia':
                $(this).attr("target", direccion + "Familia").attr("href", "articuloProducto/" + direccion + "Familia.jsp?orden=" + articuloOrden + familia + pCompra + pVenta+sn);
                if ($("#codFamilia").val() == "") {
                    alert("Seleccione familia");
                    event.preventDefault();
                }
                break;
            case 'aArticulosControl':
                $(this).attr("target", articuloControl).attr("href", "articuloProducto/" + articuloControl + ".jsp?articulosFechaInicio=" + fechaInicio + "&articulosFechaFin=" + fechaFin);
                break;
            default :
                alert("Opción no implementada");
                event.preventDefault();
        }

    });
    $(".aOtros").click(function(event) {

    });
});

function comprasProveedorSeleccionado(event, ui) {
    var proveedor = ui.item.value;

    $("#comprasCodProveedor").val(proveedor.codProveedor);
    $("#comprasProveedor").val(proveedor.ruc + " " + proveedor.razonSocial);
    event.preventDefault();
}
;

function comprasProveedorMarcado(event, ui) {
    var proveedor = ui.item.value;
    $("#comprasProveedorSeleccionar").val(proveedor.ruc + " " + proveedor.razonSocial);
    event.preventDefault();
}
;

function clientesCobradorSeleccionado(event, ui) {
    var cobrador = ui.item.value;
    $('#clienteCodCobrador').val(cobrador.codPersona);
    $('#clienteCobradorBuscar').val(cobrador.nombresC);
    event.preventDefault();
}
;

function clientesCobradorMarcado(event, ui) {
    var cobrador = ui.item.value;
    $('#clienteCobradorBuscar').val(cobrador.nombresC);
    event.preventDefault();
}
;

function cobranzaCobradorSeleccionado(event, ui) {
    var cobrador = ui.item.value;
    $('#cobranzaCodCobrador').val(cobrador.codPersona);
    $('#cobranzaCobradorBuscar').val(cobrador.nombresC);
    event.preventDefault();
}
;

function cobranzaCobradorMarcado(event, ui) {
    var cobrador = ui.item.value;
    $('#cobranzaCobradorBuscar').val(cobrador.nombresC);
    event.preventDefault();
}
;
