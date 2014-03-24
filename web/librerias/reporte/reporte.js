/* 
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */

$(document).ready(function() {

    $('.fechaEntrada')
            .mask('00/00/0000')
            .blur(function(e) {
                if (!fValidarFecha(this.value)) {
                    this.value = '';
                }
            })
            .val($('#fechaActual').val());

    $('#cobranza_tipoDocumento').mask('SZZ', {translation: {'Z': {pattern: /[a-zA-Z0-9]/, optional: true}}});
    $('#cobranza_serieDocumento').mask('000');
    $('#articuloProducto_codArticuloProductoMovimientoBuscar')
            .mask('09999999')
            .keypress(function(event) {
                var key = event.charCode ? event.charCode : (event.keyCode ? event.keyCode : 0);
                if (key == 13) {
                    if ($.isNumeric(this.value) & this.value > 0) {
                        fAPLeer(this.value);
                    }
                    event.preventDefault();//para el caso de ie se ejecuta como enter al boton y se cerraba el dialog.
                }
            });

    $('input[name=tCliente_cobrador]').click(function(event) {
        switch (this.value) {
            case 'todos':
                $('#tdClienteCobrador').addClass('ocultar');
                break;
            case 'cobrador':
                $('#tdClienteCobrador').removeClass('ocultar');
                break;
        }
    });
    $('input[name=cobranza_cobrador]').click(function(event) {
        switch (this.value) {
            case 'todos':
                $('#td_cobranza_cobrador').addClass('ocultar');
                break;
            case 'cobrador':
                $('#td_cobranza_cobrador').removeClass('ocultar');
                break;
        }
    });

    $('#tCliente_bCobradorBuscar').click(function(e) {
        $('#dVendedorCobradorBuscar').dialog('open');
        e.preventDefault();
    });

    $('#venta_bVendedorBuscar').click(function(e) {
        $('#venta_dVendedorBuscar').dialog('open');
        e.preventDefault();
    });

    $('#cobranza_bCobradorBuscar').click(function(e) {
        $('#cobranza_dCobradorBuscar').dialog('open');
        e.preventDefault();
    });

    $('#cobranza_bCobradorBuscar').click(function(e) {
        $('#cobranza_dCobradorBuscar').dialog('open');
        e.preventDefault();
    });

    $('#articuloProducto_bFamiliaStockBuscar').click(function(e) {
        $('#articuloProducto_dFamiliaStockBuscar').dialog('open');
        e.preventDefault();
    });

    $('#articuloProducto_bMarcaStockBuscar').click(function(e) {
        $('#articuloProducto_dMarcaStockBuscar').dialog('open');
        e.preventDefault();
    });

    $('#articuloProducto_bFamiliaMovimientoBuscar').click(function(e) {
        $('#articuloProducto_dFamiliaMovimientoBuscar').dialog('open');
        e.preventDefault();
    });

    $('#articuloProducto_bMarcaMovimientoBuscar').click(function(e) {
        $('#articuloProducto_dMarcaMovimientoBuscar').dialog('open');
        e.preventDefault();
    });

    $('#articuloProducto_bArticuloProductoMovimientoBuscar').click(function(e) {
        $('#articuloProducto_dArticuloProductoMovimientoBuscar').dialog('open');
        e.preventDefault();
    });

    //bloquenado fechas fuera de rango para ventaFechaInicio

    $('#ventaFechaInicio').change(function(e) {
        $('#ventaFechaFin').datepicker('option', 'minDate', fValidarFecha(this.value) ? fStringADate(this.value) : null);
    });
    $('#ventaFechaFin').change(function(e) {
        $('#ventaFechaInicio').datepicker('option', 'maxDate', fValidarFecha(this.value) ? fStringADate(this.value) : null);
    });

    $('#cobranza_fechaInicio').change(function(e) {
        $('#cobranza_fechaFin').datepicker('option', 'minDate', fValidarFecha(this.value) ? fStringADate(this.value) : null);
    });
    $('#cobranza_fechaFin').change(function(e) {
        $('#cobranza_fechaInicio').datepicker('option', 'maxDate', fValidarFecha(this.value) ? fStringADate(this.value) : null);
    });

    $('#articuloProducto_fechaInicio').change(function(e) {
        $('#articuloProducto_fechaFin').datepicker('option', 'minDate', fValidarFecha(this.value) ? fStringADate(this.value) : null);
    });
    $('#articuloProducto_fechaFin').change(function(e) {
        $('#articuloProducto_fechaInicio').datepicker('option', 'maxDate', fValidarFecha(this.value) ? fStringADate(this.value) : null);
    });

    $('#ventaSerieDoc').mask('000');

    $('.aCliente').click(function(e) {
        var clienteOrden = $('input[name=tCliente_orden]:checked').val();   //obteniendo orden
        var clienteCobrador = $('input[name=tCliente_cobrador]:checked').val();
        var codCobrador = $('#clienteCodCobrador').val();
        if (clienteCobrador == 'cobrador') {
            if (codCobrador == '') {
                fAlerta('Seleccione cobrador.');
                return;
            }
        }
        switch ($(this).attr('id')) {
            //============Reporte cartera de cliente.=======================
            case 'rClienteOrden':
                $(this).attr('target', '_blank').attr('href', 'cliente/clienteCartera.jsp?reporte=' + clienteOrden + '_' + clienteCobrador + '&codCobrador=' + codCobrador);
                break;
            case 'rClienteOrdenEC':
                var $cEC = $('#tClienteCodEC');
                if (!fValidarRequerido($cEC.val())) {
                    fAlerta('Seleccione Empresa/Convenio.');
                    return;
                }
                $(this).attr('target', '_blank').attr('href', 'cliente/clienteCartera.jsp?reporte=' + clienteOrden + '_EC_' + clienteCobrador + '&codEC=' + $cEC.val() + '&codCobrador=' + codCobrador);
                break;
            case 'rClienteOrdenECTipo':
                var $cEC = $('#tClienteCodEC');
                if (!fValidarRequerido($cEC.val())) {
                    fAlerta('Seleccione Empresa/Convenio.');
                    return;
                }
                var $tipo = $('#tClienteTipo');
                if (!fValidarRequerido($tipo.val())) {
                    fAlerta('Seleccione tipo.');
                    return;
                }
                $(this).attr('target', '_blank').attr('href', 'cliente/clienteCartera.jsp?reporte=' + clienteOrden + '_EC_tipo_' + clienteCobrador + '&codEC=' + $cEC.val() + '&tipo=' + $tipo.val() + '&codCobrador=' + codCobrador);
                break;
            case 'rClienteOrdenECTipoCondicion':
                var $cEC = $('#tClienteCodEC');
                if (!fValidarRequerido($cEC.val())) {
                    fAlerta('Seleccione Empresa/Convenio.');
                    return;
                }
                var $tipo = $('#tClienteTipo');
                if (!fValidarRequerido($tipo.val())) {
                    fAlerta('Seleccione tipo.');
                    return;
                }
                var $condicion = $('#tClienteCondicion');
                if (!fValidarRequerido($condicion.val())) {
                    fAlerta('Seleccione condición.');
                    return;
                }
                $(this).attr('target', '_blank').attr('href', 'cliente/clienteCartera.jsp?reporte=' + clienteOrden + '_EC_tipo_condicion_' + clienteCobrador + '&codEC=' + $cEC.val() + '&tipo=' + $tipo.val() + '&condicion=' + $condicion.val() + '&codCobrador=' + codCobrador);
                break;
                //===============Reporte letras vencidas========================
            case 'rClienteOrdenVCL':
                var $clienteFVLOrden = $('#clienteFVLOrden');
                if (!fValidarFecha($clienteFVLOrden.val())) {
                    fAlerta('Ingrese fecha.');
                    return;
                }
                $(this).attr('target', '_blank').attr('href', 'cliente/letraVencida.jsp?reporte=' + clienteOrden + "_" + clienteCobrador + '&fechaVencimiento=' + $clienteFVLOrden.val() + '&codCobrador=' + codCobrador);
                break;
            case 'rClienteECOrdenVCL':
                var $cEC = $('#tClienteCodEC');
                if (!fValidarRequerido($cEC.val())) {
                    fAlerta('Seleccione Empresa/Convenio.');
                    return;
                }
                var $clienteFVLECOrden = $('#clienteFVLECOrden');
                if (!fValidarFecha($clienteFVLECOrden.val())) {
                    fAlerta('Ingrese fecha correspondiente.');
                    return;
                }
                $(this).attr('target', '_blank').attr('href', 'cliente/letraVencida.jsp?reporte=' + clienteOrden + '_EC_' + clienteCobrador + '&fechaVencimiento=' + $clienteFVLECOrden.val() + '&codEC=' + $cEC.val() + '&codCobrador=' + codCobrador);
                break;
            case 'rClienteECTipoOrdenVCL':
                var $cEC = $('#tClienteCodEC');
                if (!fValidarRequerido($cEC.val())) {
                    fAlerta('Seleccione Empresa/Convenio.');
                    return;
                }
                var $tipo = $('#tClienteTipo');
                if (!fValidarRequerido($tipo.val())) {
                    fAlerta('Seleccione tipo.');
                    return;
                }
                var $clienteFVLECTipoOrden = $('#clienteFVLECTipoOrden');
                if (!fValidarFecha($clienteFVLECTipoOrden.val())) {
                    fAlerta('Ingrese fecha correspondiente.');
                    return;
                }
                $(this).attr('target', '_blank').attr('href', 'cliente/letraVencida.jsp?reporte=' + clienteOrden + '_EC_tipo_' + clienteCobrador + '&fechaVencimiento=' + $clienteFVLECTipoOrden.val() + '&codEC=' + $cEC.val() + '&tipo=' + $tipo.val() + '&codCobrador=' + codCobrador);
                break;
            case 'rClienteECTipoCondicionOrdenVCL':
                var $cEC = $('#tClienteCodEC');
                if (!fValidarRequerido($cEC.val())) {
                    fAlerta('Seleccione Empresa/Convenio.');
                    return;
                }
                var $tipo = $('#tClienteTipo');
                if (!fValidarRequerido($tipo.val())) {
                    fAlerta('Seleccione tipo.');
                    return;
                }
                var $condicion = $('#tClienteCondicion');
                if (!fValidarRequerido($condicion.val())) {
                    fAlerta('Seleccione condición.');
                    return;
                }
                var $clienteFVLECTipoCondicionOrden = $('#clienteFVLECTipoCondicionOrden');
                if (!fValidarFecha($clienteFVLECTipoCondicionOrden.val())) {
                    fAlerta('Ingrese fecha correspondiente.');
                    return;
                }
                $(this).attr('target', '_blank').attr('href', 'cliente/letraVencida.jsp?reporte=' + clienteOrden + '_EC_tipo_condicion_' + clienteCobrador + '&fechaVencimiento=' + $clienteFVLECTipoCondicionOrden.val() + '&codEC=' + $cEC.val() + '&tipo=' + $tipo.val() + '&condicion=' + $condicion.val() + '&codCobrador=' + codCobrador);
                break;
                //===============Reporte letras vencidas Excel==================
            case 'rClienteOrdenVCLExcel':
                var $clienteFVLOrden = $('#clienteFVLOrden');
                if (!fValidarFecha($clienteFVLOrden.val())) {
                    fAlerta('Ingrese fecha.');
                    return;
                }
                $(this).attr('target', '_blank').attr('href', 'cliente/letraVencidaExcel.jsp?reporte=' + clienteOrden + "_" + clienteCobrador + '&fechaVencimiento=' + $clienteFVLOrden.val() + '&codCobrador=' + codCobrador);
                break;
            case 'rClienteECOrdenVCLExcel':
                var $cEC = $('#tClienteCodEC');
                if (!fValidarRequerido($cEC.val())) {
                    fAlerta('Seleccione Empresa/Convenio.');
                    return;
                }
                var $clienteFVLECOrden = $('#clienteFVLECOrden');
                if (!fValidarFecha($clienteFVLECOrden.val())) {
                    fAlerta('Ingrese fecha correspondiente.');
                    return;
                }
                $(this).attr('target', '_blank').attr('href', 'cliente/letraVencidaExcel.jsp?reporte=' + clienteOrden + '_EC_' + clienteCobrador + '&fechaVencimiento=' + $clienteFVLECOrden.val() + '&codEC=' + $cEC.val() + '&codCobrador=' + codCobrador);
                break;
            case 'rClienteECTipoOrdenVCLExcel':
                var $cEC = $('#tClienteCodEC');
                if (!fValidarRequerido($cEC.val())) {
                    fAlerta('Seleccione Empresa/Convenio.');
                    return;
                }
                var $tipo = $('#tClienteTipo');
                if (!fValidarRequerido($tipo.val())) {
                    fAlerta('Seleccione tipo.');
                    return;
                }
                var $clienteFVLECTipoOrden = $('#clienteFVLECTipoOrden');
                if (!fValidarFecha($clienteFVLECTipoOrden.val())) {
                    fAlerta('Ingrese fecha correspondiente.');
                    return;
                }
                $(this).attr('target', '_blank').attr('href', 'cliente/letraVencidaExcel.jsp?reporte=' + clienteOrden + '_EC_tipo_' + clienteCobrador + '&fechaVencimiento=' + $clienteFVLECTipoOrden.val() + '&codEC=' + $cEC.val() + '&tipo=' + $tipo.val() + '&codCobrador=' + codCobrador);
                break;
            case 'rClienteECTipoCondicionOrdenVCLExcel':
                var $cEC = $('#tClienteCodEC');
                if (!fValidarRequerido($cEC.val())) {
                    fAlerta('Seleccione Empresa/Convenio.');
                    return;
                }
                var $tipo = $('#tClienteTipo');
                if (!fValidarRequerido($tipo.val())) {
                    fAlerta('Seleccione tipo.');
                    return;
                }
                var $condicion = $('#tClienteCondicion');
                if (!fValidarRequerido($condicion.val())) {
                    fAlerta('Seleccione condición.');
                    return;
                }
                var $clienteFVLECTipoCondicionOrden = $('#clienteFVLECTipoCondicionOrden');
                if (!fValidarFecha($clienteFVLECTipoCondicionOrden.val())) {
                    fAlerta('Ingrese fecha correspondiente.');
                    return;
                }
                $(this).attr('target', '_blank').attr('href', 'cliente/letraVencidaExcel.jsp?reporte=' + clienteOrden + '_EC_tipo_condicion_' + clienteCobrador + '&fechaVencimiento=' + $clienteFVLECTipoCondicionOrden.val() + '&codEC=' + $cEC.val() + '&tipo=' + $tipo.val() + '&condicion=' + $condicion.val() + '&codCobrador=' + codCobrador);
                break;
                //======================== Tramo Excel==========================
            case 'rClienteOrdenVCLTExcel':
                var $clienteFVLOrden = $('#clienteFVLOrden');
                if (!fValidarFecha($clienteFVLOrden.val())) {
                    fAlerta('Ingrese fecha.');
                    return;
                }
                $(this).attr('target', '_blank').attr('href', 'cliente/tramoExcel.jsp?reporte=' + clienteOrden + "_" + clienteCobrador + '&fechaVencimiento=' + $clienteFVLOrden.val() + '&codCobrador=' + codCobrador);
                break;
            case 'rClienteOrdenECVCLTExcel':
                var $cEC = $('#tClienteCodEC');
                if (!fValidarRequerido($cEC.val())) {
                    fAlerta('Seleccione Empresa/Convenio.');
                    return;
                }
                var $clienteFVLECOrden = $('#clienteFVLECOrden');
                if (!fValidarFecha($clienteFVLECOrden.val())) {
                    fAlerta('Ingrese fecha correspondiente.');
                    return;
                }
                $(this).attr('target', '_blank').attr('href', 'cliente/tramoExcel.jsp?reporte=' + clienteOrden + '_EC_' + clienteCobrador + '&fechaVencimiento=' + $clienteFVLECOrden.val() + '&codEC=' + $cEC.val() + '&codCobrador=' + codCobrador);
                break;
            default :
                fAlerta('No implementado ID:' + $(this).attr('id'));
                e.preventDefault();
                break;
        }
    });

    $('.aVenta').click(function(e) {
        var tipo = $('input[name=tVenta_tipo]:checked').val();
        var $ventaTipoDoc = $('#ventaTipoDoc');
        var $ventaSerieDoc = $('#ventaSerieDoc');
        var $fechaInicio = $('#ventaFechaInicio');
        var $fechaFin = $('#ventaFechaFin');

        if (!fValidarFecha($fechaInicio.val())) {
            fAlerta('Ingrese fecha de inicio.');
            return;
        }
        if (!fValidarFecha($fechaFin.val())) {
            fAlerta('Ingrese fecha final.');
            return;
        }
        //validar que las fechas no sean fuera de rango
        if (fComparaFecha($fechaInicio.val(), $fechaFin.val()) > 0) {
            fAlerta('Las fechas estan fuera de rango.');
            return;
        }
        switch ($(this).attr('id')) {
            // ======================= impresiones ==============================
            case'rVentaPeriodoTipo':
                $(this).attr('target', '_blank').attr('href', 'venta/venta.jsp?reporte=' + tipo + '_fechas&fechaInicio=' + $fechaInicio.val() + '&fechaFin=' + $fechaFin.val());
                break;
            case 'rVentaPeriodoDocumetoTipo':
                if (!fValidarRequerido($ventaTipoDoc.val())) {
                    fAlerta('Seleccione tipo de documento.');
                    return;
                }
                if (!fValidarMinimo($ventaSerieDoc.val(), 3)) {
                    fAlerta('Ingrese serie de documento, mínimo 3 caracteres.');
                    return;
                }
                $(this).attr('target', '_blank').attr('href', 'venta/venta.jsp?reporte=' + tipo + '_documento_fechas&tipoSerie=' + $ventaTipoDoc.val() + '-' + $ventaSerieDoc.val() + '&fechaInicio=' + $fechaInicio.val() + '&fechaFin=' + $fechaFin.val());
                break;
            case 'rVentaVendedorTipo':
                var $codVendedor = $('#venta_codVendedor');
                if (!fValidarRequerido($codVendedor.val())) {
                    fAlerta('Seleccione vendedor para continuar con el reporte.');
                    return;
                }
                $(this).attr('target', '_blank').attr('href', 'venta/venta.jsp?reporte=' + tipo + '_vendedor_fechas&codVendedor=' + $codVendedor.val() + '&fechaInicio=' + $fechaInicio.val() + '&fechaFin=' + $fechaFin.val());
                break;
            case 'rVentaPeriodoAnuladoTipo':
                $(this).attr('target', '_blank').attr('href', 'venta/venta.jsp?reporte=' + tipo + '_anulado_fechas&fechaInicio=' + $fechaInicio.val() + '&fechaFin=' + $fechaFin.val());
                break;
                // ======================= excel ==============================
            case'rVentaPeriodoTipoExcel':
                $(this).attr('target', '_blank').attr('href', 'venta/ventaExcel.jsp?reporte=' + tipo + '_fechas&fechaInicio=' + $fechaInicio.val() + '&fechaFin=' + $fechaFin.val());
                break;
            case 'rVentaPeriodoDocumetoTipoExcel':
                if (!fValidarRequerido($ventaTipoDoc.val())) {
                    fAlerta('Seleccione tipo de documento.');
                    return;
                }
                if (!fValidarMinimo($ventaSerieDoc.val(), 3)) {
                    fAlerta('Ingrese serie de documento, mínimo 3 caracteres.');
                    return;
                }
                $(this).attr('target', '_blank').attr('href', 'venta/ventaExcel.jsp?reporte=' + tipo + '_documento_fechas&tipoSerie=' + $ventaTipoDoc.val() + '-' + $ventaSerieDoc.val() + '&fechaInicio=' + $fechaInicio.val() + '&fechaFin=' + $fechaFin.val());
                break;
            case 'rVentaVendedorTipoExcel':
                var $codVendedor = $('#venta_codVendedor');
                if (!fValidarRequerido($codVendedor.val())) {
                    fAlerta('Seleccione vendedor para continuar con el reporte.');
                    return;
                }
                $(this).attr('target', '_blank').attr('href', 'venta/ventaExcel.jsp?reporte=' + tipo + '_vendedor_fechas&codVendedor=' + $codVendedor.val() + '&fechaInicio=' + $fechaInicio.val() + '&fechaFin=' + $fechaFin.val());
                break;
            case 'rVentaPeriodoAnuladoTipoExcel':
                $(this).attr('target', '_blank').attr('href', 'venta/ventaExcel.jsp?reporte=' + tipo + '_anulado_fechas&fechaInicio=' + $fechaInicio.val() + '&fechaFin=' + $fechaFin.val());
                break;
            default :
                fAlerta('No implementado ID : ' + $(this).attr('id'));
                e.preventDefault();
                break;
        }
    });

    $('.aCobranza').click(function(e) {
        var cobranza_cobrador = $('input[name=cobranza_cobrador]:checked').val();
        var cobranza_codCobrador = $('#cobranza_codCobrador').val();
        var cobranza_tipo = $('input[name=cobranza_tipo]:checked').val();
        var $fechaInicio = $('#cobranza_fechaInicio');
        var $fechaFin = $('#cobranza_fechaFin');

        if (!fValidarFecha($fechaInicio.val())) {
            fAlerta('Ingrese fecha de inicio.');
            return;
        }
        if (!fValidarFecha($fechaFin.val())) {
            fAlerta('Ingrese fecha final.');
            return;
        }
        //validar que las fechas no sean fuera de rango
        if (fComparaFecha($fechaInicio.val(), $fechaFin.val()) > 0) {
            fAlerta('Las fechas estan fuera de rango.');
            return;
        }
        if (cobranza_cobrador == 'cobrador') {
            if (cobranza_codCobrador == '') {
                fAlerta('Seleccione cobrador.');
                return;
            }
        }
        switch ($(this).attr('id')) {
            case 'cobranza_rTipo':
                $(this).attr('target', '_blank').attr('href', 'cobranza/cobranza.jsp?reporte=' +
                        cobranza_tipo + '_' + cobranza_cobrador + '&fechaInicio=' + $fechaInicio.val() +
                        '&fechaFin=' + $fechaFin.val() + '&codCobrador=' + cobranza_codCobrador);
                break;
            case 'cobranza_rDocumento':
                var $tipoDocumento = $('#cobranza_tipoDocumento');
                var $serieDocumento = $('#cobranza_serieDocumento');
                if (!fValidarRequerido($tipoDocumento.val())) {
                    fAlerta('Ingrese tipo de documento');
                    return;
                }
                if (!fValidarMinimo($serieDocumento.val(), 3)) {
                    fAlerta('Ingrese serie de documento (XXX)');
                    return;
                }
                $(this).attr('target', '_blank').attr('href', 'cobranza/cobranza.jsp?reporte=' +
                        'todo_documento_' + cobranza_cobrador + '&fechaInicio=' + $fechaInicio.val() +
                        '&fechaFin=' + $fechaFin.val() + '&documento=' + $tipoDocumento.val() + '-' + $serieDocumento.val() +
                        '&codCobrador=' + cobranza_codCobrador);
                break;
            case 'cobranza_rAnulado':
                $(this).attr('target', '_blank').attr('href', 'cobranza/cobranza.jsp?reporte=' +
                        'todo_anulado_' + cobranza_cobrador + '&fechaInicio=' + $fechaInicio.val() +
                        '&fechaFin=' + $fechaFin.val() + '&codCobrador=' + cobranza_codCobrador);
                break;
            case 'cobranza_rPago':
                $(this).attr('target', '_blank').attr('href', 'cobranza/clientePagos.jsp?reporte=' +
                        'todo_pago_' + cobranza_cobrador + '&fechaInicio=' + $fechaInicio.val() +
                        '&fechaFin=' + $fechaFin.val() + '&codCobrador=' + cobranza_codCobrador);
                break;
            default :
                fAlerta('No implementado ID : ' + $(this).attr('id'));
                e.preventDefault();
                break;
        }
    });

    $('.aArticuloProducto').click(function(e) {
        var orden = $('input[name=articulo_orden]:checked').val();
        var stock = $('input[name=articulo_tipoInventario]:checked').val();
        var codFamilia = $('#articuloProducto_codFamiliaStock').val();
        var codMarca = $('#articuloProducto_codMarcaStock').val();

        var pCompra = $('input[name=articulo_precioCompra]').is(':checked') ? ("&pCompra=" + $('input[name=articuloPrecioCompra]').val()) : "";
        var pVenta = $('input[name=articulo_precioVenta]').is(':checked') ? ("&pVenta=" + $('input[name=articuloPrecioVenta]').val()) : "";
        var sn = $('input[name=articulo_serieNumero]').is(':checked') ? ("&sn=ON") : "";

        switch ($(this).attr('id')) {
            case 'articulo_rInventario':
                $(this).attr('target', '_blank')
                        .attr('href', 'articuloProducto/articuloProducto.jsp?reporte=' + orden + '_' + stock + '&codFamilia=' + codFamilia + '&codMarca=' + codMarca + pCompra + pVenta + sn);
                break;
            case 'articulo_rInventarioExcel':
                $(this).attr('target', '_blank')
                        .attr('href', 'articuloProducto/articuloProductoExcel.jsp?reporte=' + orden + '_' + stock + '&codFamilia=' + codFamilia + '&codMarca=' + codMarca + pCompra + pVenta + sn);
                break;
            case 'articulo_rFamiliaInventario':
                if (!fValidarRequerido(codFamilia)) {
                    fAlerta('Seleccione familia');
                    return;
                }
                $(this).attr('target', '_blank')
                        .attr('href', 'articuloProducto/articuloProducto.jsp?reporte=' + orden + '_familia_' + stock + '&codFamilia=' + codFamilia + '&codMarca=' + codMarca + pCompra + pVenta + sn);
                break;
            case 'articulo_rFamiliaInventarioExcel':
                if (!fValidarRequerido(codFamilia)) {
                    fAlerta('Seleccione familia');
                    return;
                }
                $(this).attr('target', '_blank')
                        .attr('href', 'articuloProducto/articuloProductoExcel.jsp?reporte=' + orden + '_familia_' + stock + '&codFamilia=' + codFamilia + '&codMarca=' + codMarca + pCompra + pVenta + sn);
                break;
            case 'articulo_rFamiliaMarcaInventario':
                if (!fValidarRequerido(codFamilia) || !fValidarRequerido(codMarca)) {
                    fAlerta('Seleccione familia y/o marca');
                    return;
                }
                $(this).attr('target', '_blank')
                        .attr('href', 'articuloProducto/articuloProducto.jsp?reporte=' + orden + '_familia_marca_' + stock + '&codFamilia=' + codFamilia + '&codMarca=' + codMarca + pCompra + pVenta + sn);
                break;
            case 'articulo_rFamiliaMarcaInventarioExcel':
                if (!fValidarRequerido(codFamilia) || !fValidarRequerido(codMarca)) {
                    fAlerta('Seleccione familia y/o marca');
                    return;
                }
                $(this).attr('target', '_blank')
                        .attr('href', 'articuloProducto/articuloProductoExcel.jsp?reporte=' + orden + '_familia_marca_' + stock + '&codFamilia=' + codFamilia + '&codMarca=' + codMarca + pCompra + pVenta + sn);
                break;
            default :
                fAlerta('No implementado ID : ' + $(this).attr('id'));
                e.preventDefault();
                break;
        }
    });
});

$(function() {
    $('#tabs').tabs();

    $('.fechaEntrada').datepicker({
        showAnim: 'drop',
        changeMonth: true,
        changeYear: true,
        numberOfMonths: 2
    });

    $('#ventaFechaInicio')
            .val(fDateAString(fSumarDia(fStringADate($('#ventaFechaFin').val()), -1)))
            .datepicker('option', 'maxDate', fStringADate($('#ventaFechaFin').val()));
    $('#ventaFechaFin')
            .datepicker('option', 'minDate', fStringADate($('#ventaFechaInicio').val()));

    $('#cobranza_fechaInicio')
            .val(fDateAString(fSumarDia(fStringADate($('#cobranza_fechaFin').val()), -1)))
            .datepicker('option', 'maxDate', fStringADate($('#cobranza_fechaFin').val()));
    $('#cobranza_fechaFin')
            .datepicker('option', 'minDate', fStringADate($('#cobranza_fechaInicio').val()));

    $('#articuloProducto_fechaInicio')
            .val(fDateAString(fSumarMes(fStringADate($('#articuloProducto_fechaFin').val()), -1)))
            .datepicker('option', 'maxDate', fStringADate($('#articuloProducto_fechaFin').val()));
    $('#articuloProducto_fechaFin')
            .datepicker('option', 'minDate', fStringADate($('#articuloProducto_fechaInicio').val()));

    //<editor-fold defaultstate="collapsed" desc="dialog. Clic en el signo + de la izquierda para mas detalles.">
    $('#dVendedorCobradorBuscar').dialog({
        autoOpen: false,
        modal: true,
        resizable: true,
        height: 130,
        width: 800,
        buttons: {
            Cerrar: function() {
                $(this).dialog('close');
            }
        }
    });

    $('#venta_dVendedorBuscar').dialog({
        autoOpen: false,
        modal: true,
        resizable: true,
        height: 130,
        width: 800,
        buttons: {
            Cerrar: function() {
                $(this).dialog('close');
            }
        }
    });

    $('#cobranza_dCobradorBuscar').dialog({
        autoOpen: false,
        modal: true,
        resizable: true,
        height: 130,
        width: 800,
        buttons: {
            Cerrar: function() {
                $(this).dialog('close');
            }
        }
    });

    $('#articuloProducto_dFamiliaStockBuscar').dialog({
        autoOpen: false,
        modal: true,
        resizable: true,
        height: 130,
        width: 600,
        buttons: {
            Cerrar: function() {
                $(this).dialog('close');
            }
        }
    });

    $('#articuloProducto_dMarcaStockBuscar').dialog({
        autoOpen: false,
        modal: true,
        resizable: true,
        height: 130,
        width: 600,
        buttons: {
            Cerrar: function() {
                $(this).dialog('close');
            }
        }
    });

    $('#articuloProducto_dFamiliaMovimientoBuscar').dialog({
        autoOpen: false,
        modal: true,
        resizable: true,
        height: 130,
        width: 600,
        buttons: {
            Cerrar: function() {
                $(this).dialog('close');
            }
        }
    });
    $('#articuloProducto_dMarcaMovimientoBuscar').dialog({
        autoOpen: false,
        modal: true,
        resizable: true,
        height: 130,
        width: 600,
        buttons: {
            Cerrar: function() {
                $(this).dialog('close');
            }
        }
    });


    $('#articuloProducto_dArticuloProductoMovimientoBuscar').dialog({
        autoOpen: false,
        modal: true,
        resizable: true,
        height: 140,
        width: 800,
        buttons: {
            Cerrar: function() {
                $(this).dialog('close');
            }
        }
    });
    //</editor-fold>

    //<editor-fold defaultstate="collapsed" desc="autocompletado. Clic en el signo + de la izquierda para mas detalles.">
    $('#cobradorVendedorBuscar').autocomplete({
        source: 'autocompletado/cobradorVendedor.jsp',
        minLength: 4,
        select: cliente_fVendedorCobradorSeleccionado,
        focus: cliente_fVendedorCobradorMarcado
    });
    $('#venta_vendedorBuscar').autocomplete({
        source: 'autocompletado/cobradorVendedor.jsp',
        minLength: 4,
        select: venta_fVendedorCobradorSeleccionado,
        focus: venta_fVendedorCobradorMarcado
    });
    $('#cobrador_cobradorBuscar').autocomplete({
        source: 'autocompletado/cobradorVendedor.jsp',
        minLength: 4,
        select: cobranza_fVendedorCobradorSeleccionado,
        focus: cobranza_fVendedorCobradorMarcado
    });
    $('#articuloProducto_familiaStockBuscar').autocomplete({
        source: 'autocompletado/familia.jsp',
        minLength: 4,
        focus: fFamiliaStock_marcado,
        select: fFamiliaStock_seleccionado
    });
    $('#articuloProducto_marcaStockBuscar').autocomplete({
        source: 'autocompletado/marca.jsp',
        minLength: 4,
        focus: fMarcaStock_marcado,
        select: fMarcaStock_seleccionado
    });
    $('#articuloProducto_familiaMovimientoBuscar').autocomplete({
        source: 'autocompletado/familia.jsp',
        minLength: 4,
        focus: fFamiliaMovimiento_marcado,
        select: fFamiliaMovimiento_seleccionado
    });
    $('#articuloProducto_marcaMovimientoBuscar').autocomplete({
        source: 'autocompletado/marca.jsp',
        minLength: 4,
        focus: fMarcaMovimiento_marcado,
        select: fMarcaMovimiento_seleccionado
    });
    $('#articuloProducto_articuloProductoMovimientoBuscar').autocomplete({
        source: 'autocompletado/articuloProducto_descripcion.jsp',
        minLength: 4,
        focus: fArticuloProductoMovimiento_marcado,
        select: fArticuloProductoMovimiento_seleccionado
    });

    //</editor-fold>

});

function fPaginaActual() {
}
;

//<editor-fold defaultstate="collapsed" desc="cliente_fVendedorCobradorSeleccionado(event, ui). Clic en el signo + de la izquierda para mas detalles.">
function cliente_fVendedorCobradorSeleccionado(event, ui) {
    var vendedor = ui.item.value;
    $('#cobradorVendedorBuscar').val('');
    $('#tCliente_cobradorNombresC').text(vendedor.nombresC);
    $('#clienteCodCobrador').val(vendedor.codPersona);
    $('#dVendedorCobradorBuscar').dialog('close');
    event.preventDefault();
}
;
//</editor-fold>

//<editor-fold defaultstate="collapsed" desc="cliente_fVendedorCobradorMarcado(event, ui). Clic en el signo + de la izquierda para mas detalles.">
function cliente_fVendedorCobradorMarcado(event, ui) {
    var vendedor = ui.item.value;
    $("#cobradorVendedorBuscar").val(vendedor.nombresC);
    event.preventDefault();
}
;
//</editor-fold>

//<editor-fold defaultstate="collapsed" desc="venta_fVendedorCobradorSeleccionado(event, ui). Clic en el signo + de la izquierda para mas detalles.">
function venta_fVendedorCobradorSeleccionado(event, ui) {
    var vendedor = ui.item.value;
    $('#venta_vendedorBuscar').val('');
    $('#venta_vendedorNombresC').text(vendedor.nombresC);
    $('#venta_codVendedor').val(vendedor.codPersona);
    $('#venta_dVendedorBuscar').dialog('close');
    event.preventDefault();
}
;
//</editor-fold>

//<editor-fold defaultstate="collapsed" desc="venta_fVendedorCobradorMarcado(event, ui). Clic en el signo + de la izquierda para mas detalles.">
function venta_fVendedorCobradorMarcado(event, ui) {
    var vendedor = ui.item.value;
    $("#venta_vendedorBuscar").val(vendedor.nombresC);
    event.preventDefault();
}
;
//</editor-fold>

//<editor-fold defaultstate="collapsed" desc="cobranza_fVendedorCobradorSeleccionado(event, ui). Clic en el signo + de la izquierda para mas detalles.">
function cobranza_fVendedorCobradorSeleccionado(event, ui) {
    var vendedor = ui.item.value;
    $('#cobrador_cobradorBuscar').val('');
    $('#cobranza_cobradorNombresC').text(vendedor.nombresC);
    $('#cobranza_codCobrador').val(vendedor.codPersona);
    $('#cobranza_dCobradorBuscar').dialog('close');
    event.preventDefault();
}
;
//</editor-fold>

//<editor-fold defaultstate="collapsed" desc="cobranza_fVendedorCobradorMarcado(event, ui). Clic en el signo + de la izquierda para mas detalles.">
function cobranza_fVendedorCobradorMarcado(event, ui) {
    var vendedor = ui.item.value;
    $("#cobrador_cobradorBuscar").val(vendedor.nombresC);
    event.preventDefault();
}
;
//</editor-fold>

function fFamiliaStock_marcado(event, ui) {
    var familia = ui.item.value;
    $('#articuloProducto_familiaStockBuscar').val(familia.familia);
    event.preventDefault();
}
;
function fFamiliaStock_seleccionado(event, ui) {
    var familia = ui.item.value;
    $('#articuloProducto_codFamiliaStock').val(familia.codFamilia);
    $('#articuloProducto_familiaStock').text(familia.familia);
    $('#articuloProducto_familiaStockBuscar').val('');
    $('#articuloProducto_dFamiliaStockBuscar').dialog('close');
    event.preventDefault();
}
;
function fMarcaStock_marcado(event, ui) {
    var marca = ui.item.value;
    $('#articuloProducto_marcaStockBuscar').val(marca.descripcion);
    event.preventDefault();
}
;
function fMarcaStock_seleccionado(event, ui) {
    var marca = ui.item.value;
    $('#articuloProducto_codMarcaStock').val(marca.codMarca);
    $('#articuloProducto_marcaStock').text(marca.descripcion);
    $('#articuloProducto_marcaStockBuscar').val('');
    $('#articuloProducto_dMarcaStockBuscar').dialog('close');
    event.preventDefault();
}
;
function fFamiliaMovimiento_marcado(event, ui) {
    var familia = ui.item.value;
    $('#articuloProducto_familiaMovimientoBuscar').val(familia.familia);
    event.preventDefault();
}
;
function fFamiliaMovimiento_seleccionado(event, ui) {
    var familia = ui.item.value;
    $('#articuloProducto_codFamiliaMovimiento').val(familia.codFamilia);
    $('#articuloProducto_familiaMovimiento').text(familia.familia);
    $('#articuloProducto_familiaMovimientoBuscar').val('');
    $('#articuloProducto_dFamiliaMovimientoBuscar').dialog('close');
    event.preventDefault();
}
;
function fMarcaMovimiento_marcado(event, ui) {
    var marca = ui.item.value;
    $('#articuloProducto_marcaMovimientoBuscar').val(marca.descripcion);
    event.preventDefault();
}
;
function fMarcaMovimiento_seleccionado(event, ui) {
    var marca = ui.item.value;
    $('#articuloProducto_codMarcaMovimiento').val(marca.codMarca);
    $('#articuloProducto_marcaMovimiento').text(marca.descripcion);
    $('#articuloProducto_marcaMovimientoBuscar').val('');
    $('#articuloProducto_dMarcaMovimientoBuscar').dialog('close');
    event.preventDefault();
}
;
function fArticuloProductoMovimiento_marcado(event, ui) {
    var articuloProducto = ui.item.value;
    $('#articuloProducto_codArticuloProductoMovimientoBuscar').val(articuloProducto.codArticuloProducto);
    $('#articuloProducto_articuloProductoMovimientoBuscar').val(articuloProducto.descripcion);
    event.preventDefault();
}
;
function fArticuloProductoMovimiento_seleccionado(event, ui) {
    var articuloProducto = ui.item.value;
    $('#articuloProducto_codArticuloProductoMovimiento').val(articuloProducto.codArticuloProducto);
    $('#articuloProducto_articuloProductoMovimiento').text(articuloProducto.descripcion);
    $('#articuloProducto_codArticuloProductoMovimientoT').text(articuloProducto.codArticuloProducto);
    $('#articuloProducto_articuloProductoMovimientoBuscar').val('');
    $('#articuloProducto_codArticuloProductoMovimientoBuscar').val('');
    $('#articuloProducto_dArticuloProductoMovimientoBuscar').dialog('close');
    event.preventDefault();
}
;
//<editor-fold defaultstate="collapsed" desc="fAPLeer(codArticuloProducto)...">
function fAPLeer(codArticuloProducto) {
    var data = {codArticuloProducto: codArticuloProducto};
    var url = 'ajax/articuloProducto_cod.jsp';
    try {
        $.ajax({
            type: 'post',
            url: url,
            data: data,
            error: function(XMLHttpRequest, textStatus, errorThrown) {
                $('#lServidorError').text(errorThrown + '()');
                $('#dServidorError').dialog('open');
            },
            success: function(ajaxResponse, textStatus) {
                var APArray = procesarRespuesta(ajaxResponse);
                if (APArray.length == 0) {
                    fAlerta('Artículo no encontrado');
                } else {
                    var APItem = APArray[0];
                    $('#articuloProducto_codArticuloProductoMovimiento').val(APItem.codArticuloProducto);
                    $('#articuloProducto_articuloProductoMovimiento').text(APItem.descripcion);
                    $('#articuloProducto_codArticuloProductoMovimientoT').text(APItem.codArticuloProducto);
                    $('#articuloProducto_codArticuloProductoMovimientoBuscar').val('');
                }
            },
            statusCode: {
                404: function() {
                    $('#lServidorError').text('Página no encontrada().');
                    $('#dServidorError').dialog('open');
                }
            }
        });
    }
    catch (ex) {
        $('#lServidorError').text(ex);
        $('#dServidorError').dialog('open');
    }
}
;
//</editor-fold>