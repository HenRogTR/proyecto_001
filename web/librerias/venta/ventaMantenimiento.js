/* 
 * To change this template, choose Tools | Templates
 * and open the template in the editor.
 */

$(document).ready(function() {
//botones de navegacion para ventas

//<editor-fold defaultstate="collapsed" desc="BOTONES. Clic en el signo + de la izquierda para mas detalles.">
    $('#bPrimero').click(function(event) {
        fVentaLeer(-1, 'primero');
        $('#numeroOperacion').val('');
    });
    $('#bAnterior').click(function(event) {
        var codVenta = parseInt($('#codVenta').val(), 10) - 1;
        if (codVenta < 1) {
            fAlerta('Este es el primer registro.');
            codVenta = 1;
        }
        fVentaLeer(codVenta, 'anterior');
    });
    $('#bSiguiente').click(function(event) {
        fVentaLeer((parseInt($('#codVenta').val(), 10) + 1), 'siguiente');
    });
    $('#bUltimo').click(function(event) {
        fVentaLeer(0, '');
    });

    $('#bVentaRegistrar').click(function(event) {
//        $('#seleccionTipoVenta').dialog('open');
        $(location).attr('href', 'ventaRegistrar.jsp');
        event.preventDefault();
    });
    $('#bVentaBuscar').click(function(event) {
        $('#dVentaBuscar').dialog('open');
        event.preventDefault();
    });
    $('#bGuia').click(function(event) {
        var $direccion = $('#direccion3');
        if ($direccion.val() == '') {
            $direccion.val($('#lDireccion').text());
        }
        $('#dGuiaRemision').dialog('open');
        event.preventDefault();
    });
    $('#cronogramaOpcion').click(function(event) {
        fVentaCreditoLetraActual();
        event.preventDefault();
    });

    $('#bAnular').click(function(event) {
        if ($('#codVenta').val() < 0 || $.trim($('#codVenta').val()) == '') {
            $('#lMensajeAlerta').text('*No hay venta seleccionada para anular.');
            $('#dMensajeAlerta').dialog('open');
            return;
        }
        $('#dVentaAnularConfirmar').dialog('open');
        event.preventDefault();
    });
//</editor-fold>

    $('#codVentaBuscar')
            .mask('#', {maxlength: false})
            .keypress(function(e) {
                var key = e.charCode ? e.charCode : e.keyCode ? e.keyCode : 0;
                if (key == 13) {
                    if ($.isNumeric(this.value) & this.value > 0) {
                        $('#docSerieNumeroBuscar').val('');
                        fVentaLeer(this.value, 'exacto');
                        this.value = '';
                    }
                    e.preventDefault();
                }
            });

    $('#docSerieNumeroGuia').mask('S-000-000000');

});

$(function() {

//<editor-fold defaultstate="collapsed" desc="DIALOG'S. Clic en el signo + de la izquierda para mas detalles.">

    $('#dVentaAnularConfirmar').dialog({
        autoOpen: false,
        modal: true,
        resizable: true,
        height: 200,
        width: 400,
        buttons: {
            Confirmar: function() {
                fVentaAnular();
                $(this).dialog('close');
            },
            Cancelar: function() {
                $(this).dialog('close');
            }
        }
    });

    $('#dVentaBuscar').dialog({
        autoOpen: false,
        modal: true,
        resizable: true,
        height: 200,
        width: 440,
        buttons: {
            Cerrar: function() {
                $(this).dialog('close');
            }
        },
        position: {my: 'center', at: 'right'}
    });

    $('#dVentaCreditoLetraOpcion').dialog({
        autoOpen: false,
        modal: true,
        resizable: false,
        height: 600,
        width: 800,
        buttons: {
            Modificar: function() {
                fAlerta('Implementando');
//                if (fVentaCreditoLetraComprobar()) {

//                }
            },
            Reprogramar: function() {
                fAlerta('Implementando');
            },
            Imprimir: function() {
                window.open('reporte/cronogramaImprimir.jsp?codVenta=' + $('#codVenta').val(), '_blank');
                $(this).dialog('close');
            }
        }
    });
    $("#dLetrasCreditoModificar").dialog({
        autoOpen: false,
        modal: true,
        resizable: true,
        height: 570,
        width: 600,
        buttons: {
            'Modificar letras': function() {
                if (fLetrasCreditoValidar()) {
                    fLetrasCreditoGenerar();
                }
            },
            Aceptar: function() {
                if ($('#auxiliarGenerarLetraCredito').val() == '0') {
                    fAlerta('Genere las letras de credito');
                    return;
                }
                $(this).dialog("close");
            }
        },
        close: function() {

        }
    });

    $('#dGuiaRemision').dialog({
        autoOpen: false,
        modal: true,
        resizable: false,
        height: 400,
        width: 760,
        buttons: {
            Adjuntar: function() {
                if (fGuiaRemisionValidar()) {
                    fGuiaRemisionAdjuntar();
                }
            },
            Imprimir: function() {
                if ($('#docSerieNumeroGuiaAux').val() != '') {
                    window.open('reporte/guiaImprimir.jsp', '_blank');
                    $(this).dialog('close');
                } else {
                    fAlerta('Guía no adjuntada');
                }
            },
            Cerrar: function() {
                $(this).dialog('close');
            }
        }
    });
//</editor-fold>

//<editor-fold defaultstate="collapsed" desc="AUTOCOMPLETE'S. Clic en el signo + de la izquierda para mas detalles.">
    $('#docSerieNumeroBuscar').autocomplete({
        source: 'autocompletado/ventasListarDocSerieNumero.jsp',
        minLength: 4,
        focus: ventaMarcado,
        select: ventaSeleccionado
    });
//</editor-fold>
});

//<editor-fold defaultstate="collapsed" desc="function fPaginaActual(). Clic en el signo + de la izquierda para mas detalles.">
function fPaginaActual() {
    $('#dProcesandoPeticion').dialog('open');
    fVentaLeer(parseInt($('#codVenta').val(), 10));
}
;
//</editor-fold>

//<editor-fold defaultstate="collapsed" desc="function ventaMarcado(event, ui). Clic en el signo + de la izquierda para mas detalles.">
function ventaMarcado(event, ui) {
    var ventas = ui.item.value;
    $('#docSerieNumeroBuscar').val(ventas.docSerieNumero);
    event.preventDefault();
}
;
//</editor-fold>

//<editor-fold defaultstate="collapsed" desc="function ventaSeleccionado(event, ui). Clic en el signo + de la izquierda para mas detalles.">
function ventaSeleccionado(event, ui) {
    var ventas = ui.item.value;
    $('#docSerieNumeroBuscar').val('');
    $('#codVentaBsucar').val('');
    fVentaLeer(ventas.codVenta, 'exacto');
    event.preventDefault();
}
;
//</editor-fold>

//<editor-fold defaultstate="collapsed" desc="function fVentaLeer(codVenta, parametro). Clic en el signo + de la izquierda para mas detalles.">
function fVentaLeer(codVenta, parametro) {
    var data = 'codVenta=' + codVenta + '&parametro=' + parametro;
    try {
        $.ajax({
            type: 'post',
            url: 'ajax/venta.jsp',
            data: data,
            error: function(XMLHttpRequest, textStatus, errorThrown) {
                $('#lServidorError').text(errorThrown + '(venta.jsp)');
                $('#dServidorError').dialog('open');
            },
            success: function(ajaxResponse, textStatus) {
                var ventaArray = procesarRespuesta(ajaxResponse);
                if (ventaArray.length == 0) {
                    $('#dProcesandoPeticion').dialog('close');
                    fAlerta('Venta no encontradAo');
                } else {
                    $('.vaciar').empty();
                    var ventaItem = ventaArray[0];
                    $('#lCodVenta').append(ventaItem.codVenta);
                    $('#lRegistroDetalle').append('<a href="../otros/registroDetalle.jsp?registro=' + ventaItem.registro + '&historial=" target="_blank">Ver detalles</a>');
                    //inicio datos cliente
                    $('#lCliente').append('<a href="../sDatoCliente?accionDatoCliente=mantenimiento&codDatoCliente=' + ventaItem.codDatoCliente + '">' + ventaItem.cliente + '</a>');
                    $('#lClienteNombresCGuia').append(ventaItem.cliente);
                    $('#lDireccion').append(ventaItem.direccion);
                    $('#direccion2').val(ventaItem.direccion2);
                    $('#direccion3').val(ventaItem.direccion3);
                    $('#lDniPasaporte').append(ventaItem.dniPasaporte);
                    $('#lRuc').append(ventaItem.ruc);
                    //fin datos cliente
                    $('#lDocSerieNumero').append(ventaItem.docSerieNumero);
                    $('#lDocSerieNumero2').append(ventaItem.docSerieNumero);
                    $('#docSerieNumeroGuia').val(ventaItem.docSerieNumeroGuia);
                    $('#docSerieNumeroGuiaAux').val(ventaItem.docSerieNumeroGuia);
                    $('#codVenta').val(ventaItem.codVenta);
                    $('#lTipo').append(ventaItem.tipo);
                    $('#lFecha').append(ventaItem.fecha);
                    $('#lMoneda').append(ventaItem.moneda);
                    $('#lSubTotal').append(ventaItem.subTotal);
                    $('#lDescuento').append(ventaItem.descuento);
                    $('#lTotal').append(ventaItem.total);
                    $('#lMontoIgv').append(ventaItem.ValorIgv);
                    $('#lNeto').append(ventaItem.neto);
                    $('#lSon').append(ventaItem.son);
                    $('#lVendedor').append(ventaItem.vendedor);
                    $('#lEmpresaConvenio').append(ventaItem.empresaConvenio);
                    $('#lObservacion').append(ventaItem.observacion);
                    //datos de venta
                    if (ventaItem.registro.substring(0, 1) == '1') {
                        $('#ventaAnulada').addClass('ocultar');
                        $('#ventaSinAnular').removeClass('ocultar');
                        if (ventaItem.tipo == 'CREDITO') {
                            $('#cronograma').removeClass('ocultar');
                        } else {
                            $('#cronograma').addClass('ocultar');
                        }
                        $('#contratoImprimir').attr('href', 'reporte/contratoCompraVenta.jsp?codVentas=' + ventaItem.codVenta);
                        $('#clausulaImprimir').attr('href', 'reporte/clausulaPago.jsp?codVentas=' + ventaItem.codVenta);
                        $('#bImprimir').attr('target', '_blank').attr('href', 'reporte/ventasImprimir.jsp?codVentas=' + ventaItem.codVenta);
                    } else {
                        $('#ventaAnulada').removeClass('ocultar');
                        $('#ventaSinAnular').addClass('ocultar');
                        $('#imprimir').removeAttr('href');
                    }
                    fVentaDetalle(ventaItem.codVenta);
                }
                $('#dProcesandoPeticion').dialog('close');
            },
            statusCode: {
                404: function() {
                    $('#lServidorError').text('Página no encontrada(venta.jsp).');
                    $('#dServidorError').dialog('open');
                }
            }
        });
    } catch (ex) {
        $('#lServidorError').text(ex);
        $('#dServidorError').dialog('open');
    }
}
;
//</editor-fold>

//<editor-fold defaultstate="collapsed" desc="function fVentaDetalle(codVenta). Clic en el signo + de la izquierda para mas detalles.">
function fVentaDetalle(codVenta) {
    var data = 'codVenta=' + codVenta;
    try {
        $.ajax({
            type: 'post',
            url: 'ajax/ventaDetalle.jsp',
            data: data,
            error: function(XMLHttpRequest, textStatus, errorThrown) {
                $('#lServidorError').text(errorThrown + '(ventaDetalle.jsp)');
                $('#dServidorError').dialog('open');
            },
            success: function(ajaxResponse, textStatus) {
                $('#tbVentaDetalle').empty();
                var ventaDetalleArray = procesarRespuesta(ajaxResponse);
                for (var idx = 0; idx < ventaDetalleArray.length; idx++) {
                    var ventaDetalleItem = ventaDetalleArray[idx];
                    $('#tbVentaDetalle').append(
                            '<tr>' +
                            '<td style="text-align: right;">' + ventaDetalleItem.item + '</td>' +
                            '<td style="text-align: right;">' + ventaDetalleItem.codArticuloProducto + '</td>' +
                            '<td style="text-align: right;">' + ventaDetalleItem.cantidad + '</td>' +
                            '<td>' + ventaDetalleItem.unidadMedida + '</td>' +
                            '<td>' + ventaDetalleItem.descripcion + ventaDetalleItem.serie + '</td>' +
                            '<td style="text-align: right;">' + ventaDetalleItem.precioVenta + '</td>' +
                            '<td style="text-align: right;">' + ventaDetalleItem.valorVenta + '</td>' +
                            '</tr>'
                            );
                }
            }
        });
    } catch (ex) {
        $('#lServidorError').text(ex);
        $('#dServidorError').dialog('open');
    }
}
;
//</editor-fold>

//<editor-fold defaultstate="collapsed" desc="function fVentaAnular(). Clic en el signo + de la izquierda para mas detalles.">
function fVentaAnular() {
    var url = '../sVenta';
    var data = 'codVenta=' + $('#codVenta').val() + '&accionVenta=anular';
    try {
        $.ajax({
            type: 'post',
            url: url,
            data: data,
            error: function(XMLHttpRequest, textStatus, errorThrown) {
                $('#lServidorError').text(errorThrown + '(ventaDetalle.jsp)');
                $('#dServidorError').dialog('open');
            },
            success: function(ajaxResponse, textStatus) {
                if (!isNaN(ajaxResponse)) {
                    fVentaLeer(ajaxResponse, 'exacto');
                } else {
                    $('#dMensajeAlertaDiv').empty().append(ajaxResponse);
                    $('#dMensajeAlerta').dialog('open');
                }
            }
        });
    } catch (ex) {
        $('#lServidorError').text(ex);
        $('#dServidorError').dialog('open');
    }
}
;
//</editor-fold>

//<editor-fold defaultstate="collapsed" desc="fVentaCreditoLetraComprobar(). Clic en el signo + de la izquierda para mas detalles">
function fVentaCreditoLetraComprobar() {
    var estado = true;
    var data = {codVenta: $('#codVenta').val()};
    var url = 'ajax/ventaCreditoLetraComprobar.jsp';
    try {
        $.ajax({
            type: 'post',
            url: url,
            data: data,
            beforeSend: function() {
                fProcesandoPeticion('Comprobando. ');
            },
            error: function(XMLHttpRequest, textStatus, errorThrown) {
                $('#lServidorError').text(errorThrown + '()');
                $('#dServidorError').dialog('open');
            },
            success: function(ajaxResponse, textStatus) {
                $('#dProcesandoPeticion').dialog('close');
                if (ajaxResponse == 1) {
                    fVentaCreditoLetraCargar();
                } else {
                    fAlerta(ajaxResponse);
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
    return estado;
}
;
//</editor-fold>

//<editor-fold defaultstate="collapsed" desc="fLetrasCreditoValidar(). Clic en el signo + de la izquierda para mas detalles">
function fLetrasCreditoValidar() {
    var estado = true;
    var mensaje = '';
    var $numeroLetras = $('#numeroLetras');
    var $fechaInicio = $('#fechaInicio');
    var $fechaVencimiento = $('#fechaVencimiento');
    if (!$.isNumeric($numeroLetras.val()) || $numeroLetras.val() < 1) {
        mensaje += '*El numero de letra debe ser mayor a 0.<br>';
        estado = false;
    }
    if (!$fechaInicio.length || !fValidarFecha($fechaInicio.val())) {
        mensaje += '*Ingrese fecha inicio<br>';
        estado = false;
    }
    if (!$fechaVencimiento.length || !fValidarFecha($fechaVencimiento.val())) {
        mensaje += '*Ingrese fecha vencimiento - formato de f. de vencimiento incorrecto.<br>';
        estado = false;
    }
    if (!estado) {
        fAlerta(mensaje);
    }
    return estado;
}
;
//</editor-fold>

function fVentaCreditoLetraCargar() {
    var data = {codVenta: $('#codVenta').val()};
    var url = 'ajax/ventaCreditoLetraLeer.jsp';
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
                $('#tbDetalleLetras').empty().append(ajaxResponse);
                $('#dVentaCreditoLetraOpcion').dialog('close');
                $('#lNetoLetras').text($('#lNeto').text());
                $('#dLetrasCreditoModificar').dialog('open');
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

function fVentaCreditoLetraActual() {
    var data = {codVenta: $('#codVenta').val()};
    var url = 'ajax/ventaCreditoLetraActual.jsp';
    try {
        $.ajax({
            type: 'post',
            url: url,
            data: data,
            beforeSend: function() {
                fProcesandoPeticion('Preparando. ');
            },
            error: function(XMLHttpRequest, textStatus, errorThrown) {
                $('#lServidorError').text(errorThrown + '()');
                $('#dServidorError').dialog('open');
            },
            success: function(ajaxResponse, textStatus) {
                $('#dVentaCreditoLetraActual').empty().append(ajaxResponse);
                $('#dProcesandoPeticion').dialog('close');
                $('#dVentaCreditoLetraOpcion').dialog('open');
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

function fGuiaRemisionValidar() {
    var est = true;
    var mensaje = '';
    var $direccion2 = $('#direccion2');
    if ($.trim($direccion2.val()) == '') {
        mensaje = '*Ingrese punto de partida.<br>';
        est = false;
    }
    var $direccion3 = $('#direccion3');
    if ($.trim($direccion3.val()) == '') {
        mensaje += '*Ingrese punto de llegada.<br>';
        est = false;
    }
    var $docSerieNumeroGuia = $('#docSerieNumeroGuia');
    if ($.trim($docSerieNumeroGuia.val()).length < 12) {
        mensaje += '*Formato de N° Guía incorrecta (G-XXX-XXXXXX).<br>';
        est = false;
    }
    if (!est) {
        fAlerta(mensaje);
    }
    return est;
}
;

function fGuiaRemisionAdjuntar() {
    var data = {
        accionVenta: 'guiaAdjuntar',
        codVenta: $('#codVenta').val(),
        direccion2: $('#direccion2').val(),
        direccion3: $('#direccion3').val(),
        docSerieNumeroGuia: $('#docSerieNumeroGuia').val()
    };
    var url = '../sVenta';
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
                if ($.isNumeric(ajaxResponse)) {
                    $('#docSerieNumeroGuiaAux').val($('#docSerieNumeroGuia').val());
                    fAlerta('Guia adjuntada exitosamente.');
                } else {
                    fAlerta(ajaxResponse);
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