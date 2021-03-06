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

    $('#compra_bProveedorBuscar').click(function(e) {
        $('#compra_dProveedorBuscar').dialog('open');
        e.preventDefault();
    });
    //bloquenado fechas fuera de rango para ventaFechaInicio-Fin
    //clientes

    //ventas
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

    $('#compra_fechaInicio').change(function(e) {
        $('#compra_fechaFin').datepicker('option', 'minDate', fValidarFecha(this.value) ? fStringADate(this.value) : null);
    });
    $('#compra_fechaFin').change(function(e) {
        $('#compra_fechaInicio').datepicker('option', 'maxDate', fValidarFecha(this.value) ? fStringADate(this.value) : null);
    });

    $('#ventaSerieDoc').mask('000');

    $('.aCliente').click(function(e) {
        var clienteOrden = $('input[name=tCliente_orden]:checked').val();       //obteniendo orden
        var clienteCobrador = $('input[name=tCliente_cobrador]:checked').val(); //si se filtrará por cobrador
        var codCobrador = $('#clienteCodCobrador').val();
        var cobradorNombresC = $('#cobranza_cobradorNombresC').text();
        if (clienteCobrador == 'cobrador' & codCobrador == '') {
            fAlerta('Seleccione cobrador.');
            e.preventDefault();
            return;
        }
        var codZona = $('#tClienteZona').val();
        var zona = $('#tClienteZona option:selected').text();
        var codEmpresaConvenio = $('#tClienteCodEC').val();
        var empresaConvenio = $('#tClienteCodEC option:selected').text();
        var codTipo = $('#tClienteTipo').val();
        var tipo = $('#tClienteTipo option:selected').text();
        var codCondicion = $('#tClienteCondicion').val();
        var condicion = $('#tClienteCondicion option:selected').text();

        var $clienteFVLInicio = $('#clienteFVLInicio');
        var $clienteFVLFin = $('#clienteFVLFin');
        var fechaFinalUsar = $('#clienteFVLFinalUsar').is(":checked");

        var hrefDetalle
                = 'cliente/letraVencidaDetalleExcel.jsp'
                + '?orden=' + clienteOrden
                + '&clienteCobrador=' + clienteCobrador
                + '&codCobrador=' + codCobrador
                + '&cobradorNombresC=' + cobradorNombresC
                + '&codZona=' + codZona
                + '&zona=' + zona
                + '&empresaConvenio=' + empresaConvenio
                + '&tipo=' + tipo
                + '&condicion=' + condicion
                + '&fechaInicio=' + $clienteFVLInicio.val()
                + '&fechaFin=' + $clienteFVLFin.val()
                + '&fechaFinalUsar=' + fechaFinalUsar;

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
                if (!fValidarFecha($clienteFVLFin.val())) {
                    fAlerta('Ingrese fecha.');
                    return;
                }
                $(this)
                        .attr('target', '_blank')
                        .attr('href', 'cliente/letraVencida.jsp?reporte=' + clienteOrden + "_" + clienteCobrador +
                                '&fechaVencimientoInicio=' + $clienteFVLInicio.val() +
                                '&fechaVencimiento=' + $clienteFVLFin.val() +
                                '&codCobrador=' + codCobrador +
                                '&fechaFinalUsar=' + fechaFinalUsar +
                                '&codZona=' + codZona +
                                '&zona=' + zona);
                break;
            case 'rClienteECOrdenVCL':
                var $cEC = $('#tClienteCodEC');
                if (!fValidarRequerido($cEC.val())) {
                    fAlerta('Seleccione Empresa/Convenio.');
                    return;
                }
                if (!fValidarFecha($clienteFVLFin.val())) {
                    fAlerta('Ingrese fecha correspondiente.');
                    return;
                }
                $(this)
                        .attr('target', '_blank')
                        .attr('href', 'cliente/letraVencida.jsp?reporte=' + clienteOrden + '_EC_' + clienteCobrador +
                                '&fechaVencimientoInicio=' + $clienteFVLInicio.val() +
                                '&fechaVencimiento=' + $clienteFVLFin.val() +
                                '&codEC=' + $cEC.val() +
                                '&codCobrador=' + codCobrador +
                                '&fechaFinalUsar=' + fechaFinalUsar +
                                '&codZona=' + codZona +
                                '&zona=' + zona);
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
                if (!fValidarFecha($clienteFVLFin.val())) {
                    fAlerta('Ingrese fecha correspondiente.');
                    return;
                }
                $(this)
                        .attr('target', '_blank')
                        .attr('href', 'cliente/letraVencida.jsp?reporte=' + clienteOrden + '_EC_tipo_' + clienteCobrador +
                                '&fechaVencimientoInicio=' + $clienteFVLInicio.val() +
                                '&fechaVencimiento=' + $clienteFVLFin.val() +
                                '&codEC=' + $cEC.val() +
                                '&tipo=' + $tipo.val() +
                                '&codCobrador=' + codCobrador +
                                '&fechaFinalUsar=' + fechaFinalUsar +
                                '&codZona=' + codZona +
                                '&zona=' + zona);
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
                if (!fValidarFecha($clienteFVLFin.val())) {
                    fAlerta('Ingrese fecha correspondiente.');
                    return;
                }
                $(this)
                        .attr('target', '_blank')
                        .attr('href', 'cliente/letraVencida.jsp?reporte=' + clienteOrden + '_EC_tipo_condicion_' + clienteCobrador +
                                '&fechaVencimientoInicio=' + $clienteFVLInicio.val() +
                                '&fechaVencimiento=' + $clienteFVLFin.val() +
                                '&codEC=' + $cEC.val() +
                                '&tipo=' + $tipo.val() +
                                '&condicion=' + $condicion.val() +
                                '&codCobrador=' + codCobrador +
                                '&fechaFinalUsar=' + fechaFinalUsar +
                                '&codZona=' + codZona +
                                '&zona=' + zona);
                break;
                //===============Reporte letras vencidas Excel==================
            case 'rClienteOrdenVCLExcel':
                if (!fValidarFecha($clienteFVLFin.val())) {
                    fAlerta('Ingrese fecha.');
                    return;
                }
                $(this)
                        .attr('target', '_blank')
                        .attr('href', 'cliente/letraVencidaExcel.jsp?reporte=' + clienteOrden + "_" + clienteCobrador +
                                '&fechaVencimientoInicio=' + $clienteFVLInicio.val() +
                                '&fechaVencimiento=' + $clienteFVLFin.val() +
                                '&codCobrador=' + codCobrador +
                                '&fechaFinalUsar=' + fechaFinalUsar +
                                '&codZona=' + codZona +
                                '&zona=' + zona);
                break;
            case 'rClienteECOrdenVCLExcel':
                var $cEC = $('#tClienteCodEC');
                if (!fValidarRequerido($cEC.val())) {
                    fAlerta('Seleccione Empresa/Convenio.');
                    return;
                }
                if (!fValidarFecha($clienteFVLFin.val())) {
                    fAlerta('Ingrese fecha correspondiente.');
                    return;
                }
                $(this)
                        .attr('target', '_blank')
                        .attr('href', 'cliente/letraVencidaExcel.jsp?reporte=' + clienteOrden + '_EC_' + clienteCobrador +
                                '&fechaVencimientoInicio=' + $clienteFVLInicio.val() +
                                '&fechaVencimiento=' + $clienteFVLFin.val() +
                                '&codEC=' + $cEC.val() +
                                '&codCobrador=' + codCobrador +
                                '&fechaFinalUsar=' + fechaFinalUsar +
                                '&codZona=' + codZona +
                                '&zona=' + zona);
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
                if (!fValidarFecha($clienteFVLFin.val())) {
                    fAlerta('Ingrese fecha correspondiente.');
                    return;
                }
                $(this)
                        .attr('target', '_blank')
                        .attr('href', 'cliente/letraVencidaExcel.jsp?reporte=' + clienteOrden + '_EC_tipo_' + clienteCobrador +
                                '&fechaVencimientoInicio=' + $clienteFVLInicio.val() +
                                '&fechaVencimiento=' + $clienteFVLFin.val() +
                                '&codEC=' + $cEC.val() +
                                '&tipo=' + $tipo.val() +
                                '&codCobrador=' + codCobrador +
                                '&fechaFinalUsar=' + fechaFinalUsar +
                                '&codZona=' + codZona +
                                '&zona=' + zona);
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
                if (!fValidarFecha($clienteFVLFin.val())) {
                    fAlerta('Ingrese fecha correspondiente.');
                    return;
                }
                $(this)
                        .attr('target', '_blank')
                        .attr('href', 'cliente/letraVencidaExcel.jsp?reporte=' + clienteOrden + '_EC_tipo_condicion_' + clienteCobrador +
                                '&fechaVencimientoInicio=' + $clienteFVLInicio.val() +
                                '&fechaVencimiento=' + $clienteFVLFin.val() +
                                '&codEC=' + $cEC.val() +
                                '&tipo=' + $tipo.val() +
                                '&condicion=' + $condicion.val() +
                                '&codCobrador=' + codCobrador +
                                '&fechaFinalUsar=' + fechaFinalUsar +
                                '&codZona=' + codZona +
                                '&zona=' + zona);
                break;
                //===============Reporte letras vencidas Detalles Excel==================
            case 'rClienteOrdenVCLDetalleExcel':
                if (!fValidarFecha($clienteFVLFin.val())) {
                    fAlerta('Ingrese fecha.');
                    e.preventDefault();
                    return;
                }
                hrefDetalle
                        += '&codEmpresaConvenio='
                        + '&codTipo='
                        + '&codCondicion=';
                $(this)
                        .attr('target', '_blank')
                        .attr('href', hrefDetalle);
                break;
            case 'rClienteECOrdenVCLDetalleExcel':
                var $cEC = $('#tClienteCodEC');
                if (!fValidarRequerido($cEC.val())) {
                    fAlerta('Seleccione Empresa/Convenio.');
                    e.preventDefault();
                    return;
                }
                if (!fValidarFecha($clienteFVLFin.val())) {
                    fAlerta('Ingrese fecha correspondiente.');
                    e.preventDefault();
                    return;
                }
                hrefDetalle
                        += '&codEmpresaConvenio=' + codEmpresaConvenio
                        + '&codTipo='
                        + '&codCondicion=';
                $(this)
                        .attr('target', '_blank')
                        .attr('href', hrefDetalle);
                break;
            case 'rClienteECTipoOrdenVCLDetalleExcel':
                var $cEC = $('#tClienteCodEC');
                if (!fValidarRequerido($cEC.val())) {
                    fAlerta('Seleccione Empresa/Convenio.');
                    e.preventDefault();
                    return;
                }
                var $tipo = $('#tClienteTipo');
                if (!fValidarRequerido($tipo.val())) {
                    fAlerta('Seleccione tipo.');
                    e.preventDefault();
                    return;
                }
                if (!fValidarFecha($clienteFVLFin.val())) {
                    fAlerta('Ingrese fecha correspondiente.');
                    e.preventDefault();
                    return;
                }
                hrefDetalle
                        += '&codEmpresaConvenio=' + codEmpresaConvenio
                        + '&codTipo=' + codTipo
                        + '&codCondicion=';
                $(this)
                        .attr('target', '_blank')
                        .attr('href', hrefDetalle);
                break;
            case 'rClienteECTipoCondicionOrdenVCLDetalleExcel':
                var $cEC = $('#tClienteCodEC');
                if (!fValidarRequerido($cEC.val())) {
                    fAlerta('Seleccione Empresa/Convenio.');
                    e.preventDefault();
                    return;
                }
                var $tipo = $('#tClienteTipo');
                if (!fValidarRequerido($tipo.val())) {
                    fAlerta('Seleccione tipo.');
                    e.preventDefault();
                    return;
                }
                var $condicion = $('#tClienteCondicion');
                if (!fValidarRequerido($condicion.val())) {
                    fAlerta('Seleccione condición.');
                    e.preventDefault();
                    return;
                }
                if (!fValidarFecha($clienteFVLFin.val())) {
                    fAlerta('Ingrese fecha correspondiente.');
                    e.preventDefault();
                    return;
                }
                hrefDetalle
                        += '&codEmpresaConvenio=' + codEmpresaConvenio
                        + '&codTipo=' + codTipo
                        + '&codCondicion=' + codCondicion;
                $(this)
                        .attr('target', '_blank')
                        .attr('href', hrefDetalle);
                break;
                //======================== Tramo Excel==========================
            case 'rClienteOrdenVCLTExcel':
                if (!fValidarFecha($clienteFVLFin.val())) {
                    fAlerta('Ingrese fecha.');
                    return;
                }
                $(this)
                        .attr('target', '_blank')
                        .attr('href', 'cliente/tramoExcel.jsp?reporte=' + clienteOrden + "_" + clienteCobrador +
                                '&fechaVencimientoInicio=' + $clienteFVLInicio.val() +
                                '&fechaVencimiento=' + $clienteFVLFin.val() +
                                '&codCobrador=' + codCobrador +
                                '&fechaFinalUsar=' + fechaFinalUsar +
                                '&codZona=' + codZona +
                                '&zona=' + zona);
                break;
            case 'rClienteOrdenECVCLTExcel':
                var $cEC = $('#tClienteCodEC');
                if (!fValidarRequerido($cEC.val())) {
                    fAlerta('Seleccione Empresa/Convenio.');
                    return;
                }
                if (!fValidarFecha($clienteFVLFin.val())) {
                    fAlerta('Ingrese fecha correspondiente.');
                    return;
                }
                $(this)
                        .attr('target', '_blank')
                        .attr('href', 'cliente/tramoExcel.jsp?reporte=' + clienteOrden + '_EC_' + clienteCobrador +
                                '&fechaVencimientoInicio=' + $clienteFVLInicio.val() +
                                '&fechaVencimiento=' + $clienteFVLFin.val() +
                                '&codEC=' + $cEC.val() +
                                '&codCobrador=' + codCobrador +
                                '&fechaFinalUsar=' + fechaFinalUsar +
                                '&codZona=' + codZona +
                                '&zona=' + zona);
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

    $('.aCompra').click(function(e) {

        var tipo = $('input[name=compra_tipo]:checked').val();
        var $fechaInicio = $('#compra_fechaInicio');
        var $fechaFin = $('#compra_fechaFin');
        var codProveedor = $('#compra_codProveedor').val();

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
            case 'compra_rTipo':
                $(this).attr('target', '_blank').attr('href', 'compra/' + tipo + '.jsp?reporte=documento&fechaInicio=' + $fechaInicio.val() + '&fechaFin=' + $fechaFin.val() + '&codProveedor=' + codProveedor);
                break;
            case 'compra_rProveedor':
                if (!fValidarRequerido(codProveedor)) {
                    fAlerta('Seleccione proveedor.');
                    return;
                }
                $(this).attr('target', '_blank').attr('href', 'compra/documento.jsp?reporte=proveedor_documento&fechaInicio=' + $fechaInicio.val() + '&fechaFin=' + $fechaFin.val() + '&codProveedor=' + codProveedor);
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
        var codFamiliaStock = $('#articuloProducto_codFamiliaStock').val();
        var codMarcaStock = $('#articuloProducto_codMarcaStock').val();
        var codFamiliaMovimiento = $('#articuloProducto_codFamiliaMovimiento').val();
        var codMarcaMovimiento = $('#articuloProducto_codMarcaMovimiento').val();
        var codAPMovimiento = $('#articuloProducto_codArticuloProductoMovimiento').val();

        var pCompra = $('input[name=articulo_precioCompra]').is(':checked') ? ("&pCompra=" + $('input[name=articuloPrecioCompra]').val()) : "";
        var pVenta = $('input[name=articulo_precioVenta]').is(':checked') ? ("&pVenta=" + $('input[name=articuloPrecioVenta]').val()) : "";
        var sn = $('input[name=articulo_serieNumero]').is(':checked') ? ("&sn=ON") : "";

        var movimiento = $('input[name=articuloProducto_control]:checked').val();
        var $fechaInicio = $('#articuloProducto_fechaInicio');
        var $fechaFin = $('#articuloProducto_fechaFin');

        if ($(this).hasClass('aArticuloProductoFechaPeriodo')) {
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
        }

        switch ($(this).attr('id')) {
            case 'articulo_rInventario':
                $(this).attr('target', '_blank')
                        .attr('href', 'articuloProducto/articuloProducto.jsp?reporte=' + orden + '_' + stock + '&codFamilia=' + codFamiliaStock + '&codMarca=' + codMarcaStock + pCompra + pVenta + sn);
                break;
            case 'articulo_rInventarioExcel':
                $(this).attr('target', '_blank')
                        .attr('href', 'articuloProducto/articuloProductoExcel.jsp?reporte=' + orden + '_' + stock + '&codFamilia=' + codFamiliaStock + '&codMarca=' + codMarcaStock + pCompra + pVenta + sn);
                break;
            case 'articulo_rFamiliaInventario':
                if (!fValidarRequerido(codFamiliaStock)) {
                    fAlerta('Seleccione familia.');
                    return;
                }
                $(this).attr('target', '_blank')
                        .attr('href', 'articuloProducto/articuloProducto.jsp?reporte=' + orden + '_familia_' + stock + '&codFamilia=' + codFamiliaStock + '&codMarca=' + codMarcaStock + pCompra + pVenta + sn);
                break;
            case 'articulo_rFamiliaInventarioExcel':
                if (!fValidarRequerido(codFamiliaStock)) {
                    fAlerta('Seleccione familia.');
                    return;
                }
                $(this).attr('target', '_blank')
                        .attr('href', 'articuloProducto/articuloProductoExcel.jsp?reporte=' + orden + '_familia_' + stock + '&codFamilia=' + codFamiliaStock + '&codMarca=' + codMarcaStock + pCompra + pVenta + sn);
                break;
            case 'articulo_rFamiliaMarcaInventario':
                if (!fValidarRequerido(codFamiliaStock) || !fValidarRequerido(codMarcaStock)) {
                    fAlerta('Seleccione familia y/o marca.');
                    return;
                }
                $(this).attr('target', '_blank')
                        .attr('href', 'articuloProducto/articuloProducto.jsp?reporte=' + orden + '_familia_marca_' + stock + '&codFamilia=' + codFamiliaStock + '&codMarca=' + codMarcaStock + pCompra + pVenta + sn);
                break;
            case 'articulo_rFamiliaMarcaInventarioExcel':
                if (!fValidarRequerido(codFamiliaStock) || !fValidarRequerido(codMarcaStock)) {
                    fAlerta('Seleccione familia y/o marca.');
                    return;
                }
                $(this).attr('target', '_blank')
                        .attr('href', 'articuloProducto/articuloProductoExcel.jsp?reporte=' + orden + '_familia_marca_' + stock + '&codFamilia=' + codFamiliaStock + '&codMarca=' + codMarcaStock + pCompra + pVenta + sn);
                break;
            case 'articulo_rMovimiento':
                $(this).attr('target', '_blank')
                        .attr('href', 'articuloProducto/' + movimiento + '.jsp?reporte=' + movimiento + '&fechaInicio=' + $fechaInicio.val() + '&fechaFin=' + $fechaFin.val() + '&codFamilia=' + codFamiliaStock + '&codMarca=' + codMarcaStock + '&codAP=' + codAPMovimiento);
                break;
            case 'articulo_rMovimientoExcel':
                $(this).attr('target', '_blank')
                        .attr('href', 'articuloProducto/' + movimiento + 'Excel.jsp?reporte=' + movimiento + '&fechaInicio=' + $fechaInicio.val() + '&fechaFin=' + $fechaFin.val() + '&codFamilia=' + codFamiliaMovimiento + '&codMarca=' + codMarcaMovimiento + '&codAP=' + codAPMovimiento);
                break;
            case 'articulo_rFamiliaMovimiento':
                if (!fValidarRequerido(codFamiliaMovimiento)) {
                    fAlerta('Seleccione familia.');
                    return;
                }
                $(this).attr('target', '_blank')
                        .attr('href', 'articuloProducto/' + movimiento + '.jsp?reporte=' + movimiento + '_familia&fechaInicio=' + $fechaInicio.val() + '&fechaFin=' + $fechaFin.val() + '&codFamilia=' + codFamiliaMovimiento + '&codMarca=' + codMarcaMovimiento + '&codAP=' + codAPMovimiento);
                break;
            case 'articulo_rFamiliaMovimientoExcel':
                if (!fValidarRequerido(codFamiliaMovimiento)) {
                    fAlerta('Seleccione familia.');
                    return;
                }
                $(this).attr('target', '_blank')
                        .attr('href', 'articuloProducto/' + movimiento + 'Excel.jsp?reporte=' + movimiento + '_familia&fechaInicio=' + $fechaInicio.val() + '&fechaFin=' + $fechaFin.val() + '&codFamilia=' + codFamiliaMovimiento + '&codMarca=' + codMarcaMovimiento + '&codAP=' + codAPMovimiento);
                break;
            case 'articulo_rFamiliaMarcaMovimiento':
                if (!fValidarRequerido(codFamiliaMovimiento) || !fValidarRequerido(codMarcaMovimiento)) {
                    fAlerta('Seleccione familia y/o marca.');
                    return;
                }
                $(this).attr('target', '_blank')
                        .attr('href', 'articuloProducto/' + movimiento + '.jsp?reporte=' + movimiento + '_familia_marca&fechaInicio=' + $fechaInicio.val() + '&fechaFin=' + $fechaFin.val() + '&codFamilia=' + codFamiliaMovimiento + '&codMarca=' + codMarcaMovimiento + '&codAP=' + codAPMovimiento);
                break;
            case 'articulo_rFamiliaMarcaMovimientoExcel':
                if (!fValidarRequerido(codFamiliaMovimiento) || !fValidarRequerido(codMarcaMovimiento)) {
                    fAlerta('Seleccione familia y/o marca.');
                    return;
                }
                $(this).attr('target', '_blank')
                        .attr('href', 'articuloProducto/' + movimiento + 'Excel.jsp?reporte=' + movimiento + '_familia_marca&fechaInicio=' + $fechaInicio.val() + '&fechaFin=' + $fechaFin.val() + '&codFamilia=' + codFamiliaMovimiento + '&codMarca=' + codMarcaMovimiento + '&codAP=' + codAPMovimiento);
                break;
            case 'articulo_rAPMovimiento':
                if (!fValidarRequerido(codAPMovimiento)) {
                    fAlerta('Seleccione artículo.');
                    return;
                }
                $(this).attr('target', '_blank')
                        .attr('href', 'articuloProducto/' + movimiento + '.jsp?reporte=' + movimiento + '_ap&fechaInicio=' + $fechaInicio.val() + '&fechaFin=' + $fechaFin.val() + '&codFamilia=' + codFamiliaStock + '&codMarca=' + codMarcaStock + '&codAP=' + codAPMovimiento);
                break;
            case 'articulo_rAPMovimientoExcel':
                if (!fValidarRequerido(codAPMovimiento)) {
                    fAlerta('Seleccione artículo.');
                    return;
                }
                $(this).attr('target', '_blank')
                        .attr('href', 'articuloProducto/' + movimiento + 'Excel.jsp?reporte=' + movimiento + '_ap&fechaInicio=' + $fechaInicio.val() + '&fechaFin=' + $fechaFin.val() + '&codFamilia=' + codFamiliaStock + '&codMarca=' + codMarcaStock + '&codAP=' + codAPMovimiento);
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
    //cartera clientes
    $('#clienteFVLInicio')
            .val('')
            .datepicker(
                    'option',
                    'onClose',
                    function(selectedDate) {
                        $('#clienteFVLFin').datepicker('option', 'minDate', selectedDate);
                    })
            .datepicker('option', 'maxDate', fStringADate($('#clienteFVLFin').val()));
    ;
    $('#clienteFVLFin')
            .datepicker(
                    'option',
                    'onClose',
                    function(selectedDate) {
                        $('#clienteFVLInicio').datepicker('option', 'maxDate', selectedDate);
                    });
    ;
    //ventas
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

    $('#compra_fechaInicio')
            .val(fDateAString(fSumarMes(fStringADate($('#compra_fechaFin').val()), -1)))
            .datepicker('option', 'maxDate', fStringADate($('#compra_fechaFin').val()));
    $('#compra_fechaFin')
            .datepicker('option', 'minDate', fStringADate($('#compra_fechaInicio').val()));

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

    $('#compra_dProveedorBuscar').dialog({
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

    $('#compra_proveedorBuscar').autocomplete({
        source: 'autocompletado/proveedor_rucRazonSocial.jsp',
        minLength: 4,
        focus: fMarca_proveedor_marcado,
        select: fMarca_proveedor_seleccionado
    });

    //</editor-fold>

});

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

//<editor-fold defaultstate="collapsed" desc="fFamiliaStock_marcado(event, ui). Clic en + para más detalles.">
function fFamiliaStock_marcado(event, ui) {
    var familia = ui.item.value;
    $('#articuloProducto_familiaStockBuscar').val(familia.familia);
    event.preventDefault();
}
;
//</editor-fold>

//<editor-fold defaultstate="collapsed" desc="fFamiliaStock_seleccionado(event, ui). Clic en + para más detalles.">
function fFamiliaStock_seleccionado(event, ui) {
    var familia = ui.item.value;
    $('#articuloProducto_codFamiliaStock').val(familia.codFamilia);
    $('#articuloProducto_familiaStock').text(familia.familia);
    $('#articuloProducto_familiaStockBuscar').val('');
    $('#articuloProducto_dFamiliaStockBuscar').dialog('close');
    event.preventDefault();
}
;
//</editor-fold>

//<editor-fold defaultstate="collapsed" desc="fMarcaStock_marcado(event, ui). Clic en + para más detalles.">
function fMarcaStock_marcado(event, ui) {
    var marca = ui.item.value;
    $('#articuloProducto_marcaStockBuscar').val(marca.descripcion);
    event.preventDefault();
}
;
//</editor-fold>

//<editor-fold defaultstate="collapsed" desc="fMarcaStock_seleccionado(event, ui). Clic en + para más detalles.">
function fMarcaStock_seleccionado(event, ui) {
    var marca = ui.item.value;
    $('#articuloProducto_codMarcaStock').val(marca.codMarca);
    $('#articuloProducto_marcaStock').text(marca.descripcion);
    $('#articuloProducto_marcaStockBuscar').val('');
    $('#articuloProducto_dMarcaStockBuscar').dialog('close');
    event.preventDefault();
}
;
//</editor-fold>

//<editor-fold defaultstate="collapsed" desc="fFamiliaMovimiento_marcado(event, ui). Clic en + para más detalles.">
function fFamiliaMovimiento_marcado(event, ui) {
    var familia = ui.item.value;
    $('#articuloProducto_familiaMovimientoBuscar').val(familia.familia);
    event.preventDefault();
}
;
//</editor-fold>

//<editor-fold defaultstate="collapsed" desc="fFamiliaMovimiento_seleccionado(event, ui). Clic en + para más detalles.">
function fFamiliaMovimiento_seleccionado(event, ui) {
    var familia = ui.item.value;
    $('#articuloProducto_codFamiliaMovimiento').val(familia.codFamilia);
    $('#articuloProducto_familiaMovimiento').text(familia.familia);
    $('#articuloProducto_familiaMovimientoBuscar').val('');
    $('#articuloProducto_dFamiliaMovimientoBuscar').dialog('close');
    event.preventDefault();
}
;
//</editor-fold>

//<editor-fold defaultstate="collapsed" desc="fMarcaMovimiento_marcado(event, ui). Clic en + para más detalles.">
function fMarcaMovimiento_marcado(event, ui) {
    var marca = ui.item.value;
    $('#articuloProducto_marcaMovimientoBuscar').val(marca.descripcion);
    event.preventDefault();
}
;
//</editor-fold>

//<editor-fold defaultstate="collapsed" desc="fMarcaMovimiento_seleccionado(event, ui). Clic en + para más detalles.">
function fMarcaMovimiento_seleccionado(event, ui) {
    var marca = ui.item.value;
    $('#articuloProducto_codMarcaMovimiento').val(marca.codMarca);
    $('#articuloProducto_marcaMovimiento').text(marca.descripcion);
    $('#articuloProducto_marcaMovimientoBuscar').val('');
    $('#articuloProducto_dMarcaMovimientoBuscar').dialog('close');
    event.preventDefault();
}
;
//</editor-fold>

//<editor-fold defaultstate="collapsed" desc="fArticuloProductoMovimiento_marcado(event, ui). Clic en + para más detalles.">
function fArticuloProductoMovimiento_marcado(event, ui) {
    var articuloProducto = ui.item.value;
    $('#articuloProducto_codArticuloProductoMovimientoBuscar').val(articuloProducto.codArticuloProducto);
    $('#articuloProducto_articuloProductoMovimientoBuscar').val(articuloProducto.descripcion);
    event.preventDefault();
}
;
//</editor-fold>

//<editor-fold defaultstate="collapsed" desc="fArticuloProductoMovimiento_seleccionado(event, ui). Clic en + para más detalles.">
function fArticuloProductoMovimiento_seleccionado(event, ui) {
    var articuloProducto = ui.item.value;
    $('#articuloProducto_codArticuloProductoMovimiento').val(articuloProducto.codArticuloProducto);
    $('#articuloProducto_articuloProductoMovimiento').text(articuloProducto.codArticuloProducto + ' / ' + articuloProducto.descripcion);
    $('#articuloProducto_articuloProductoMovimientoBuscar').val('');
    $('#articuloProducto_codArticuloProductoMovimientoBuscar').val('');
    $('#articuloProducto_dArticuloProductoMovimientoBuscar').dialog('close');
    event.preventDefault();
}
;
//</editor-fold>

//<editor-fold defaultstate="collapsed" desc="fAPLeer(codArticuloProducto). Clic en el signo + de la izquierda para mas detalles.">
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
                    $('#articuloProducto_articuloProductoMovimiento').text(APItem.codArticuloProducto + ' / ' + APItem.descripcion);
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

//<editor-fold defaultstate="collapsed" desc="fMarca_proveedor_marcado(event, ui). Clic en + para más detalles.">
function fMarca_proveedor_marcado(event, ui) {
    var proveedor = ui.item.value;
    $('#compra_proveedorBuscar').val(proveedor.razonSocial);
    event.preventDefault();
}
;
//</editor-fold>

//<editor-fold defaultstate="collapsed" desc="fMarca_proveedor_seleccionado(event, ui). Clic en + para más detalles.">
function fMarca_proveedor_seleccionado(event, ui) {
    var proveedor = ui.item.value;
    $('#compra_codProveedor').val(proveedor.codProveedor);
    $('#compra_proveedor').text(proveedor.ruc + ' / ' + proveedor.razonSocial);
    $('#compra_proveedorBuscar').val('');
    $('#compra_dProveedorBuscar').dialog('close');
    event.preventDefault();
}
;
//</editor-fold>

//<editor-fold defaultstate="collapsed" desc="fEmpresaConvenioCargar(). Clic en + para más detalles.">
function fEmpresaConvenioCargar() {
    var url = '../ajax/empresaConvenio.jsp';
    try {
        $.ajax({
            type: 'post',
            url: url,
            error: function(XMLHttpRequest, textStatus, errorThrown) {
                $('#lServidorError').text(errorThrown + '()');
                $('#dServidorError').dialog('open');
            },
            success: function(ajaxResponse, textStatus) {
                //trasformar a datos Json
                var empresaConvenioJSon = procesarRespuesta(ajaxResponse);
                /*
                 *En caso la respuesta del servidor no tenga la forma para 
                 *converitir a json.
                 */
                if (empresaConvenioJSon == null) {
                    $.growl.error({title: 'Error', message: ajaxResponse, size: 'large'});
                    return;
                }
                //tomamos tamaño de datos
                var tam = empresaConvenioJSon.length;
                //vaciar el contenedor
                var $tClienteCodEC = $('#tClienteCodEC');
                for (var i = 0; i < tam; i++) {
                    var empresaConvenio = empresaConvenioJSon[i];
                    var $option = $('<option>', {value: empresaConvenio.codEmpresaConvenio, html: empresaConvenio.nombre}).appendTo($tClienteCodEC);
                }
            },
            statusCode: {
                404: function() {
                    $('#lServidorError').text('Página no encontrada(' + url + ').');
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

//<editor-fold defaultstate="collapsed" desc="fZonaCargar(). Clic en + para más detalles.">
function fZonaCargar($zona) {
    var url = '../ajax/zona.jsp';
    try {
        $.ajax({
            type: 'post',
            url: url,
            error: function(XMLHttpRequest, textStatus, errorThrown) {
                $('#lServidorError').text(errorThrown + '()');
                $('#dServidorError').dialog('open');
            },
            success: function(ajaxResponse, textStatus) {
                //trasformar a datos Json
                var zonaJSon = procesarRespuesta(ajaxResponse);
                /*
                 *En caso la respuesta del servidor no tenga la forma para 
                 *converitir a json.
                 */
                if (zonaJSon == null) {
                    $.growl.error({title: 'Error', message: ajaxResponse, size: 'large'});
                    return;
                }
                //tomamos tamaño de datos
                var tam = zonaJSon.length;
                //vaciar el contenedor
                for (var i = 0; i < tam; i++) {
                    var zona = zonaJSon[i];
                    var $option = $('<option>', {value: zona.codZona, html: zona.zona}).appendTo($zona);
                }
            },
            statusCode: {
                404: function() {
                    $('#lServidorError').text('Página no encontrada(' + url + ').');
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
//</editor-fold>

function fPaginaActual() {
    fEmpresaConvenioCargar();
    fZonaCargar($('#tClienteZona'));
}
;