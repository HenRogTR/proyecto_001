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
    $('input[name=tCliente_cobrador]').click(function(event) {
        switch (this.value) {
            case 'todos':
                $('#tdClienteCobrador').addClass('ocultar');
                break;
            case 'cobrador':
                $('#tdClienteCobrador').removeClass('ocultar');
                $('#dVendedorCobradorBuscar').dialog('open');
                break;
        }
    });

    $('#tCliente_bCobradorBuscar').click(function(e) {
        $('#dVendedorCobradorBuscar').dialog('open');
        e.preventDefault();
    });

    $('.aCliente').click(function(e) {
        var clienteOrden = $('input[name=tCliente_orden]:checked').val();   //obteniendo orden
        var codEmpresaConvenio = $('#clienteCodEmpresaConvenio').val();
        var tipo = $('#clienteTipo').val();
        var condicion = $('#clienteCondicion').val();
        var clienteCobrador = $('input[name=tCliente_cobrador]:checked').val();
        var codCobrador = $('#clienteCodCobrador').val();
        var cobrador = '';
        if (clienteCobrador == 'cobrador') {
            if (codCobrador == '') {
                fAlerta('Seleccione cobrador.');
                return;
            }
            cobrador = 'cobrador/';
        }
        switch ($(this).attr('id')) {
            case 'rClienteOrden':
                $(this).attr('target', '_blank').attr('href', 'cliente/' + cobrador + clienteOrden + '.jsp?codCobrador=' + codCobrador);
                break;
            case 'rClienteOrdenVCL':
                var $clienteFVLOrden = $('#clienteFVLOrden');
                if (!fValidarFecha($clienteFVLOrden.val())) {
                    fAlerta('Ingrese fecha.');
                    return;
                }
                $(this).attr('target', '_blank').attr('href', 'cliente/' + cobrador + clienteOrden + 'LV.jsp?fechaVencimiento=' + $clienteFVLOrden.val() + '&codCobrador=' + codCobrador);
                break;
            case 'rClienteOrdenVCLExcel':
                var $clienteFVLOrden = $('#clienteFVLOrden');
                if (!fValidarFecha($clienteFVLOrden.val())) {
                    fAlerta('Ingrese fecha.');
                    return;
                }
                $(this).attr('target', '_blank').attr('href', 'cliente/' + cobrador + clienteOrden + 'LVExcel.jsp?fechaVencimiento=' + $clienteFVLOrden.val() + '&codCobrador=' + codCobrador);
                break;
            case 'rClienteOrdenVCLTExcel':
                var $clienteFVLOrden = $('#clienteFVLOrden');
                if (!fValidarFecha($clienteFVLOrden.val())) {
                    fAlerta('Ingrese fecha.');
                    return;
                }
                $(this).attr('target', '_blank').attr('href', 'cliente/' + cobrador + clienteOrden + 'LVTExcel.jsp?fechaVencimiento=' + $clienteFVLOrden.val() + '&codCobrador=' + codCobrador);
                break;
            case 'rClienteOrdenEC':
                var $cEC = $('#tClienteCodEC');
                if (!fValidarRequerido($cEC.val())) {
                    fAlerta('Seleccione Empresa/Convenio.');
                    return;
                }
                $(this).attr('target', '_blank').attr('href', 'cliente/' + cobrador + clienteOrden + 'EC.jsp?codEC=' + $cEC.val() + '&codCobrador=' + codCobrador);
                break;
            default :
                fAlerta('No implementado');
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
        changeYear: true
    });

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

    $('#cobradorVendedorBuscar').autocomplete({
        source: 'autocompletado/cobradorVendedor.jsp',
        minLength: 4,
        select: fVendedorCobradorSeleccionado,
        focus: fVendedorCobradorMarcado
    });
});

function fPaginaActual() {
}
;

//<editor-fold defaultstate="collapsed" desc="fVendedorCobradorSeleccionado(event, ui). Clic en el signo + de la izquierda para mas detalles.">
function fVendedorCobradorSeleccionado(event, ui) {
    var vendedor = ui.item.value;
    $('#cobradorVendedorBuscar').val('');
    $('#tCliente_cobradorNombresC').text(vendedor.nombresC);
    $('#clienteCodCobrador').val(vendedor.codPersona);
    $('#dVendedorCobradorBuscar').dialog('close');
    event.preventDefault();
}
;
//</editor-fold>

//<editor-fold defaultstate="collapsed" desc="fVendedorCobradorMarcado(event, ui). Clic en el signo + de la izquierda para mas detalles.">
function fVendedorCobradorMarcado(event, ui) {
    var vendedor = ui.item.value;
    $("#cobradorVendedorBuscar").val(vendedor.nombresC);
    event.preventDefault();
}
;

//</editor-fold>