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
                        fClienteKardex(this.value);
                        this.value = '';
                    }
                    e.preventDefault();
                }
            });

    $('#bClienteBuscar').click(function(event) {
        $('#dClienteBuscar').dialog('open');
        event.preventDefault();
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

function fClienteKardex(codCliente) {
    fVenta(parseInt(codCliente, 10));
    fDeudaResumen(parseInt(codCliente, 10));
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

            },
            error: function(XMLHttpRequest, textStatus, errorThrown) {
                $('#lServidorError').text(errorThrown + '()');
                $('#dServidorError').dialog('open');
            },
            success: function(ajaxResponse, textStatus) {
                $('#dVenta').empty().append(ajaxResponse);
                $('.tr_venta').bind('click', function(event) {
                    var id = $(this).attr('id');
                    var tam = id.length;
                    var codVenta = id.substring(9, tam);
                    fVentaCreditoLetra(codVenta);
                    fVentaDetalle(codVenta);
                });
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

function fVentaDetalle(codVenta) {
    var data = {codVenta: codVenta};
    var url = 'ajax/clienteKardex/ventaDetalle.jsp';
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
                $('#lTotal').text(DRItem.mTotal);
                $('#lAmortizado').text(DRItem.mAmortizado);
                $('#lSaldo').text(DRItem.mSaldo);
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
    fClienteKardex(parseInt(cliente.codCliente, 10), '');
    event.preventDefault();
}
;
//</editor-fold>
