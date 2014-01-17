/* 
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */

$(document).ready(function() {
    $('#codClienteBuscar')
            .mask('#', {maxlength: false})
            .keyup(function(e) {
                var key = e.charCode ? e.charCode : (e.keyCode ? e.keyCode : 0);
                if (key == 13) {
                    if (!isNaN(this.value) & this.value > 0) {
                        fCliente(parseInt(this.value, 10));
                        this.value = '';
                    }
                    e.preventDefault();
                }
            });

    $('#bClienteBuscar').click(function(event) {
        $('#dClienteBuscar').dialog('open');
        event.preventDefault();
    });
    $('#bClienteInfo').click(function(event) {
        var codCliente = $('#codCliente').val();
        if ($.isNumeric(codCliente)) {
            $(this).attr('href', '../sDatoCliente?accionDatoCliente=mantenimiento&codDatoCliente=' + parseInt(codCliente, 10)).attr('target', '_blank');
        } else {
            event.preventDefault();
        }
    });
    $('#bVCLRM').click(function(event) {
        var codCliente = $('#codCliente').val();
        if ($.isNumeric(codCliente)) {
            $(this).attr('target', '_blank').attr('href', 'reporte/vclrm.jsp?codCliente=' + parseInt(codCliente, 10));
        } else {
            event.preventDefault();
        }
    });
});

$(function() {
    $('#dClienteBuscar').dialog({
        autoOpen: false,
        modal: true,
        resizable: true,
        height: 180,
        width: 800,
        buttons: {
            Aceptar: function() {
                $(this).dialog('close');
            }
        },
        close: function() {
            $(this).dialog('close');
        }
    });
    $('#dniPasaporteRucNombresCBuscar').autocomplete({
        source: 'autocompletado/kardexCliente/dniPasaporteRucNombresCBuscar.jsp',
        minLength: 4,
        focus: clienteMarcado,
        select: clienteSeleccionado
    });
});

function fPaginaActual() {
}
;

function fCliente(codCliente) {
    var data = {codCliente: codCliente};
    var url = 'ajax/clienteKardex/cliente.jsp';
    try {
        $.ajax({
            type: 'post',
            url: url,
            data: data,
            beforeSend: function() {

            },
            error: function(XMLHttpRequest, textStatus, errorThrown) {
                $('#lServidorError').text(errorThrown + '()');
                $('#dServidorError').dialog('open');
            },
            success: function(ajaxResponse, textStatus) {
                if ($.trim(ajaxResponse) == '') {
                    fAlerta('Cliente no encontrado');
                    var $dVenta = $('#dVenta');
                    $dVenta.find('table').removeClass('ocultar');
                    $dVenta.find('.temp').remove();
                    var $dVCLRM = $('#dVentaCreditoLetraResumenMensual');
                    $dVCLRM.find('table').removeClass('ocultar');
                    $dVCLRM.find('.temp').remove();
                    var $dVCL = $('#dVentaCreditoLetra');
                    $dVCL.find('table').removeClass('ocultar');
                    $dVCL.find('.temp').remove();
                    var $dVD = $('#dVentaDetalle');
                    $dVD.find('table').removeClass('ocultar');
                    $dVD.find('.temp').remove();
                    var $dCobranza = $('#dCobranza');
                    $dCobranza.find('table').removeClass('ocultar');
                    $dCobranza.find('.temp').remove();
                } else {
                    $('#codCliente').val(codCliente);
                    $('#lNombresC').text(ajaxResponse);
                    fClienteKardex(codCliente);
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

function fClienteKardex(codCliente) {
    fVenta(codCliente);
    fDeudaResumen(codCliente);
    fCobranza(codCliente);
    fVentaCreditoLetraResumenMensual(codCliente);
}
;

function fVenta(codCliente) {
    var data = {codCliente: codCliente};
    var url = 'ajax/clienteKardex/ventaCliente.jsp';
    try {
        $.ajax({
            type: 'post',
            url: url,
            data: data,
            beforeSend: function() {
                fAntesEnvioTodo();
            },
            error: function(XMLHttpRequest, textStatus, errorThrown) {
                $('#lServidorError').text(errorThrown + '(' + url + ')');
                $('#dServidorError').dialog('open');
            },
            success: function(ajaxResponse, textStatus) {
                if ($.trim(ajaxResponse) != '') {
                    $('#dVenta').empty().append(ajaxResponse);
                    $('.tr_venta').bind('click', function(event) {
                        var id = $(this).attr('id');
                        var tam = id.length;
                        var codVenta = id.substring(9, tam);
                        fVentaCreditoLetra(codVenta);
                        fVentaDetalle(codVenta);
                    });
                    $('.tr_venta').bind('dblclick', function(event) {
                        fDLibreEditar('300', '400', 'S/N en venta', $(this).find('.info_serieNumero').attr('title'));
                        fDLibreAbrir();
                    });
                    var $primero = $('#dVenta').find('.primero');
                    var id = $primero.attr('id');
                    var tam = id.length;
                    var codVenta = id.substring(9, tam);
                    fVentaCreditoLetra(codVenta);
                    fVentaDetalle(codVenta);
                } else {
                    $('#dVenta').empty();
                    $('#dVentaCreditoLetra').empty();
                    $('#dVentaDetalle').empty();
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

function fVentaDetalle(codVenta) {
    var data = {codVenta: codVenta};
    var url = 'ajax/clienteKardex/ventaDetalle.jsp';
    try {
        $.ajax({
            type: 'post',
            url: url,
            data: data,
            beforeSend: function() {
                fAntesEnvioVentaDetalle();
            },
            error: function(XMLHttpRequest, textStatus, errorThrown) {
                $('#lServidorError').text(errorThrown + '()');
                $('#dServidorError').dialog('open');
            },
            success: function(ajaxResponse, textStatus) {
                $('#dVentaDetalle').empty().append(ajaxResponse);
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

function fVentaCreditoLetra(codVenta) {
    var data = {codVenta: codVenta};
    var url = 'ajax/clienteKardex/ventaCreditoLetra.jsp';
    try {
        $.ajax({
            type: 'post',
            url: url,
            data: data,
            beforeSend: function() {
                fAntesEnvioVentaCreditoLetra();
            },
            error: function(XMLHttpRequest, textStatus, errorThrown) {
                $('#lServidorError').text(errorThrown + '()');
                $('#dServidorError').dialog('open');
            },
            success: function(ajaxResponse, textStatus) {
                $('#dVentaCreditoLetra').empty().append(ajaxResponse);
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

//<editor-fold defaultstate="collapsed" desc="function fDeudaResumen(codCliente). Clic en el signo + de la izquierda para mas detalles.">
function fDeudaResumen(codCliente) {
    var data = {codCliente: codCliente};
    var url = 'ajax/clienteKardex/deudaResumenLeer.jsp';
    try {
        $.ajax({
            type: 'post',
            url: url,
            data: data,
            beforeSend: function() {

            },
            error: function(XMLHttpRequest, textStatus, errorThrown) {
                $('#lServidorError').text(errorThrown + '()');
                $('#dServidorError').dialog('open');
            },
            success: function(ajaxResponse, textStatus) {
                var DRItem = procesarRespuesta(ajaxResponse)[0];
                $('#lTotal').removeClass('esperando').text(DRItem.mTotal);
                $('#lAmortizado').removeClass('esperando').text(DRItem.mAmortizado);
                $('#lSaldo').removeClass('esperando').text(DRItem.mSaldo);
            },
            statusCode: {
                404: function() {
                    $('#lServidorError').text('Página no encontrada(ajax/deudaResumenLeer.jsp).');
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

function fCobranza(codCliente) {
    var data = {codCliente: codCliente};
    var url = 'ajax/clienteKardex/cobranzaCliente.jsp';
    try {
        $.ajax({
            type: 'post',
            url: url,
            data: data,
            beforeSend: function() {

            },
            error: function(XMLHttpRequest, textStatus, errorThrown) {
                $('#lServidorError').text(errorThrown + '()');
                $('#dServidorError').dialog('open');
            },
            success: function(ajaxResponse, textStatus) {
                $('#dCobranza').empty().append(ajaxResponse);
                if ($.trim(ajaxResponse) != '') {
                    $('.tr_cobranza').bind('click', function(event) {
                        $('#tCobranzaDetalle').empty().append(
                                '<tr>' +
                                '<td>' +
                                $(this).find('.info_cobranzaDetalle').attr('title') +
                                '</td>' +
                                '</tr>'
                                );
                    });
                    var $primero = $('#dCobranza').find('tr');
                    $('#tCobranzaDetalle').empty().append(
                            '<tr>' +
                            '<td>' +
                            $primero.find('.info_cobranzaDetalle').attr('title') +
                            '</td>' +
                            '</tr>'
                            );
                } else {
                    $('#tCobranzaDetalle').empty();
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

function fVentaCreditoLetraResumenMensual(codCliente) {
    var data = {codCliente: codCliente};
    var url = 'ajax/clienteKardex/ventaCreditoLetraResumenMensualCliente.jsp';
    try {
        $.ajax({
            type: 'post',
            url: url,
            data: data,
            beforeSend: function() {

            },
            error: function(XMLHttpRequest, textStatus, errorThrown) {
                $('#lServidorError').text(errorThrown + '()');
                $('#dServidorError').dialog('open');
            },
            success: function(ajaxResponse, textStatus) {
                $('#dVentaCreditoLetraResumenMensual').empty().append(ajaxResponse);
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

//<editor-fold defaultstate="collapsed" desc="function clienteMarcado(event, ui). Clic en el signo + de la izquierda para mas detalles.">
function clienteMarcado(event, ui) {
    var cliente = ui.item.value;
    $('#codClienteBuscar').val(cliente.codCliente);
    $('#dniPasaporteRucNombresCBuscar').val(cliente.nombresC);
    event.preventDefault();
}
;
//</editor-fold>

//<editor-fold defaultstate="collapsed" desc="function clienteSeleccionado(event, ui). Clic en el signo + de la izquierda para mas detalles.">
function clienteSeleccionado(event, ui) {
    var cliente = ui.item.value;
    $('#codClienteBuscar').val('');
    $('#dniPasaporteRucNombresCBuscar').val('');
    fCliente(parseInt(cliente.codCliente, 10), '');
    event.preventDefault();
}
;
//</editor-fold>

function fAntesEnvioTodo() {
    $('.vaciar').addClass('esperando');
    var $dVenta = $('#dVenta');
    $dVenta.find('table').addClass('ocultar');
    $dVenta.append(
            '<table class="reporte-tabla-2 anchoTotal temp" style="font-size: 9px;">' +
            '<tr>' +
            '<td class="derecha" style="width: 80px;"><div class="esperando"></div></td>' +
            '<td class="derecha" style="width: 80px;"><div class="esperando"></div></td>' +
            '<td class="derecha" style="width: 60px;"><div class="esperando"></div></td>' +
            '<td class="derecha" style="width: 60px;"><div class="esperando"></div></td>' +
            '<td style="width: 60px;"><div class="esperando"></div></td>' +
            '<td class="derecha" style="width: 60px;"><div class="esperando"></div></td>' +
            '<td class="derecha" style="width: 50px;"><div class="esperando"></div></td>' +
            '<td class="derecha" style="width: 50px;"><div class="esperando"></div></td>' +
            '<td class="derecha"><div class="esperando"></div></td>' +
            '</tr>' +
            '</table>'
            );
    var $dVCLRM = $('#dVentaCreditoLetraResumenMensual');
    $dVCLRM.find('table').addClass('ocultar');
    $dVCLRM.append(
            '<table class="reporte-tabla-2 anchoTotal temp" style="font-size: 9px;">' +
            '<tr>' +
            '<td style="width: 70px;"><div class="esperando"></div></td>' +
            '<td style="width: 70px;" class="derecha"><div class="esperando"></div></td>' +
            '<td style="width: 70px;" class="derecha"><div class="esperando"></div></td>' +
            '<td style="width: 70px;" class="derecha"><div class="esperando"></div></td>' +
            '<td class="derecha"><div class="esperando"></div></td>' +
            '</tr>' +
            '</table>'
            );
    fAntesEnvioVentaCreditoLetra();
    fAntesEnvioVentaDetalle();
    var $tdCobranza = $('#dCobranza');
    $tdCobranza.find('table').addClass('ocultar');
    $tdCobranza.append(
            '<table class="reporte-tabla-2 anchoTotal temp" style="font-size: 9px;">' +
            '<tr>' +
            '<td style="width: 110px;"><div class="esperando"></div></td>' +
            '<td style="width: 70px;" class="derecha"><div class="esperando"></div></td>' +
            '<td style="width: 70px;"><div class="esperando"></div></td>' +
            '<td class="derecha"><div class="esperando"></div></td>' +
            '</tr>' +
            '</table>'
            );
    var $tCobranzaDetalle = $('#tCobranzaDetalle');
    $tCobranzaDetalle.find('tr').addClass('ocultar');
    $tCobranzaDetalle.append(
            '<tr>' +
            '<td class="derecha"><div class="esperando"></div></td>' +
            '</tr>'
            );
}
;

function fAntesEnvioVentaCreditoLetra() {
    var $dVCL = $('#dVentaCreditoLetra');
    $dVCL.find('table').addClass('ocultar');
    $dVCL.append(
            '<table class="reporte-tabla-2 anchoTotal temp" style="font-size: 9px;">' +
            '<tr>' +
            '<td style="width: 90px;"><div class="esperando"></div></td>' +
            '<td style="width: 90px;" class="derecha"><div class="esperando"></div></td>' +
            '<td style="width: 70px;" class="derecha"><div class="esperando"></div></td>' +
            '<td style="width: 60px;" class="derecha"><div class="esperando"></div></td>' +
            '<td style="width: 60px;" class="derecha"><div class="esperando"></div></td>' +
            '<td style="width: 70px;" class="derecha"><div class="esperando"></div></td>' +
            '<td style="width: 40px;" class="derecha"><div class="esperando"></div></td>' +
            '<td style="width: 60px;" class="derecha"><div class="esperando"></div></td>' +
            '<td class="derecha"><div class="esperando"></div></td>' +
            '</tr>' +
            '</table>'
            );
}
;

function fAntesEnvioVentaDetalle() {
    var $dVD = $('#dVentaDetalle');
    $dVD.find('table').addClass('ocultar');
    $dVD.append(
            '<table class="reporte-tabla-2 anchoTotal temp" style="font-size: 9px;">' +
            '<tr>' +
            '<td style="width: 90px;"><div class="esperando"></div></td>' +
            '<td style="width: 40px;" class="derecha"><div class="esperando"></div></td>' +
            '<td style="width: 350px;" class="derecha"><div class="esperando"></div></td>' +
            '<td style="width: 70px;" class="derecha"><div class="esperando"></div></td>' +
            '<td class="derecha"><div class="esperando"></div></td>' +
            '</tr>' +
            '</table>'
            );
}
;