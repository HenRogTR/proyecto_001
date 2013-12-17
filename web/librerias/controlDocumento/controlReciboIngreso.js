/* 
 * To change this template, choose Tools | Templates
 * and open the template in the editor.
 */

$(document).ready(function() {

    $('#tipo').change(function(event) {
        $('#serieCobranza').empty();
        $('.vaciar').empty();
        fComprobantePago($(this).val());
    });
    $('#serieCobranza').change(function(event) {
        fComprobantePagoDetalle($(this).val());
    });
    $('#bGenerarComprobantePagoDetalle').click(function(event) {
        if (parseInt($('#numeroGenerar').val(), 10) <= parseInt($('#numeroAuxSig').val(), 10)) {
            fMensajeAlerta('Imposible generar nuevo(s) documento(s), verifique el rango.');
            return;
        }
        fCombrobantePagoDetalleGenerar();
        event.preventDefault();
    });
    $('#buscar').mask('***-999-999999');
    $('#bBuscarDocumentoSerieNumero').click(function(event) {
        var buscar = $('#buscar').val();
        if (buscar == '') {
            return;
        }
        buscar = buscar.toUpperCase();
        var trEncontrado = $('#' + buscar);
        if (trEncontrado.length) {
            $('#' + buscar).find('td').addClass('documentoEncontrado');
            $(this).attr('href', 'controlReciboIngresos.jsp#' + buscar);
        } else {
            fComprobantePagoDetalleBuscar(buscar);
        }
    });

    $('#numeroGenerar').mask('999999');
});

function fComprobantePago(codCobranza) {
    var data = {codCobranza: codCobranza};
    var url = 'ajax/comprobantePagoLeer.jsp';
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
                var serieArray = procesarRespuesta(ajaxResponse);
                if (serieArray.length == 0) {
                    fMensajeAlerta('No se ha generado las series para esta empresa.')
                } else {
                    var codComprobantePago = 0;
                    for (var idx = 0; idx < serieArray.length; idx++) {
                        var serieItem = serieArray[idx];
                        if (idx == 0) {
                            codComprobantePago = serieItem.codComprobantePago;
                            $('#serieCobranza').append('<option value="' + serieItem.codComprobantePago + '" selected="selected">' + serieItem.serie + '</option>');
                        } else {
                            $('#serieCobranza').append('<option value="' + serieItem.codComprobantePago + '">' + serieItem.serie + '</option>');
                        }
                    }
                    fComprobantePagoDetalle(codComprobantePago);
                }
            },
            statusCode: {
                404: function() {
                    $('#lServidorError').text('Página no encontrada(serieCobranzaLeer.jsp).');
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

function fComprobantePagoDetalle(codComprobantePago) {
    $('.vaciar').empty();
    $('.limpiar').val('');
    var data = {codComprobantePago: codComprobantePago};
    var url = 'ajax/combrobantePagoDetalleLeer.jsp';
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
                var ComprobantePagoDetalleArray = procesarRespuesta(ajaxResponse);
                var cant = ComprobantePagoDetalleArray.length;
                //se definen los auxiliares                
                var ancla = '';
                if (cant == 0) {
                    fMensajeAlerta('No ha se ha generado documento para este serie.');
                } else {
                    for (var i = 0; i < cant; i++) {
                        var ComprobantePagoDetalleItem = ComprobantePagoDetalleArray[i];
                        $('#documentoSerie').append(
                                '<tr id="' + ComprobantePagoDetalleItem.docSerieNumero + '">' +
                                '<td class="centrado" style="width: 88px;">' + ComprobantePagoDetalleItem.tipo + '-' + ComprobantePagoDetalleItem.serie + '</td>' +
                                '<td class="centrado" style="width: 168px;">' + ComprobantePagoDetalleItem.docSerieNumero + '</td>' +
                                '<td class="centrado"><input type="checkbox" id="' + ComprobantePagoDetalleItem.codComprobantePagoDetalle + '" value="' + ComprobantePagoDetalleItem.getCodComprobantePagoDetalle + '" ' + (ComprobantePagoDetalleItem.estado ? ('checked="checked"') : '') + ' /></td>' +
                                '</tr>'
                                );
                        if (!ComprobantePagoDetalleItem.estado & ancla == '') {
                            ancla = ComprobantePagoDetalleItem.docSerieNumero;
                        }
                        $('#' + ComprobantePagoDetalleItem.codComprobantePagoDetalle).bind('click', function(event) {
                            fHabilitarDesabilitar($(this).attr('id'), $(this).is(":checked"), event);
                        });
                    }
                }
                fComprobantePagoDetalleUltimo(codComprobantePago);
                //asignamos lo auxiliares

                $(location).attr('href', 'controlReciboIngresos.jsp#' + ancla);
            },
            statusCode: {
                404: function() {
                    $('#lServidorError').text('Página no encontrada(serieCobranzaDetalleLeer.jsp).');
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

function fCombrobantePagoDetalleGenerar() {
    var data = {
        accion: 'generar',
        codComprobantePago: $('#serieCobranza').val(),
        tipo: $('#tipoAux').val(),
        serie: $('#serieAux').val(),
        numero: $('#numeroAuxSig').val(),
        numeroGenerar: $('#numeroGenerar').val()
    };
    var url = '../sComprobantePagoDetalle';
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
                if ($.isNumeric(ajaxResponse)) {
                    fComprobantePagoDetalle(ajaxResponse);
                } else {
                    fMensajeAlerta(ajaxResponse);
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

function fComprobantePagoDetalleBuscar(docSerieNumero) {
    var data = {docSerieNumero: docSerieNumero};
    var url = 'ajax/comprobantePagoDetalleBuscar.jsp';
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
                var ComprobantePagoDetalleArray = procesarRespuesta(ajaxResponse);
                var cant = ComprobantePagoDetalleArray.length;
                if (cant == 0) {
                    fMensajeAlerta('Documento no encontrado');
                } else {
                    $('.vaciar').empty();
                    $('.limpiar').val('');
                    for (var i = 0; i < cant; i++) {
                        var ComprobantePagoDetalleItem = ComprobantePagoDetalleArray[i];
                        $('#documentoSerie').append(
                                '<tr id="' + ComprobantePagoDetalleItem.docSerieNumero + '">' +
                                '<td class="centrado" style="width: 88px;">' + ComprobantePagoDetalleItem.tipo + '-' + ComprobantePagoDetalleItem.serie + '</td>' +
                                '<td class="centrado" style="width: 168px;">' + ComprobantePagoDetalleItem.docSerieNumero + '</td>' +
                                '<td class="centrado"><input type="checkbox" id="' + ComprobantePagoDetalleItem.getCodComprobantePagoDetalle + '" value="' + ComprobantePagoDetalleItem.getCodComprobantePagoDetalle + '" ' + (ComprobantePagoDetalleItem.estado ? ('checked="checked"') : '') + ' /></td>' +
                                '</tr>'
                                );
                    }
                    $('#' + docSerieNumero).find('td').addClass('documentoEncontrado');
                    $(location).attr('href', 'controlReciboIngresos.jsp#' + docSerieNumero);
                }
            },
            statusCode: {
                404: function() {
                    $('#lServidorError').text('Página no encontrada(comprobantePagoDetalleBuscar.jsp).');
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

function fComprobantePagoDetalleUltimo(codComprobantePago) {
    var data = {codComprobantePago: codComprobantePago};
    var url = 'ajax/comprobantePagoDetalleUltimo.jsp';
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
                var array = procesarRespuesta(ajaxResponse);
                var tipo = $('#tipo option:selected').text();
                var serie = $('#serieCobranza option:selected').text();
                var numeroAuxSig = '000001';
                var nuevo = '000100';
                if (array.length == 0) {
                    $('#numeroGenerar').val('000100');
                } else {
                    var CPD = array[0];
                    numeroAuxSig = CPD.numero;
                    nuevo = parseInt(numeroAuxSig, 10) + 100;
                    nuevo = nuevo < 10 ? '00000' + nuevo : (nuevo < 100 ? '0000' + nuevo : (nuevo < 1000 ? '000' + nuevo : (nuevo < 10000 ? '00' + nuevo : (nuevo < 100000 ? '0' + nuevo : (nuevo)))));

                    numeroAuxSig = parseInt(numeroAuxSig, 10) + 1;
                    numeroAuxSig = numeroAuxSig < 10 ? '00000' + numeroAuxSig : (numeroAuxSig < 100 ? '0000' + numeroAuxSig : (numeroAuxSig < 1000 ? '000' + numeroAuxSig : (numeroAuxSig < 10000 ? '00' + numeroAuxSig : (numeroAuxSig < 100000 ? '0' + numeroAuxSig : (numeroAuxSig)))));

                }

                $('#tipoAux').val($('#tipo option:selected').text());
                $('#serieAux').val($('#serieCobranza option:selected').text());
                $('#numeroAuxSig').val(numeroAuxSig);
                $('#lCodCobranzaSerieNumeroUltimoS').append(tipo + '-' + serie + '-' + numeroAuxSig);
                $('#lCodCobranzaSerie').append(tipo + '-' + serie + '-');
                $('#numeroGenerar').val(nuevo);
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

function fHabilitarDesabilitar(codComprobantePagoDetalle, estado, event) {
    var data = {
        accion: 'habilitarDesabilitar',
        codComprobantePagoDetalle: codComprobantePagoDetalle,
        estado: estado
    };
    var url = '../sComprobantePagoDetalle';
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
                if ($.isNumeric(ajaxResponse)) {
                    fMensajeAlerta('Cambiado.');
                } else {
                    fMensajeAlerta(ajaxResponse);
                    event.preventDefault();
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

function fPaginaActual() {
    fComprobantePago($('#tipo').val());
}
;