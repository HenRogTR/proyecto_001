/* 
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */

$(document).ready(function(event) {
    $('#bPrimero').click(function(event) {
        fFamiliaLeer(-1, '');
        event.preventDefault();
    });
    $('#bAnterior').click(function(event) {
        fFamiliaLeer(parseInt($('#codFamilia').val(), 10) - 1, 'anterior');
        event.preventDefault();
    });
    $('#bSiguiente').click(function(event) {
        fFamiliaLeer(parseInt($('#codFamilia').val(), 10) + 1, 'siguiente');
        event.preventDefault();
    });
    $('#bUltimo').click(function(event) {
        fFamiliaLeer(0, '');
        event.preventDefault();
    });
    $('#bNuevo').click(function(event) {
        $(location).attr('href', 'familiaRegistrar.jsp');
    });

    $('#bEditar').click(function(event) {
        $(location).attr('href', 'familiaEditar.jsp');
    });
});

function fFamiliaLeer(codFamilia, parametro) {
    var data = {
        codFamilia: codFamilia,
        parametro: parametro
    };
    var url = 'ajax/familia/familiaLeer.jsp';
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
                var familiaArray = procesarRespuesta(ajaxResponse);
                var cant = familiaArray.length;
                if (cant == 0) {
                    fMensajeAlerta('Familia no encontrada.');
                } else {
                    $('.vaciar').empty();
                    $('.limpiar').val('');
                    var familiaItem = familiaArray[0];
                    $('#codFamilia').val(familiaItem.codFamilia);
                    $('#lCodFamilia').append(familiaItem.codFamilia);
                    $('#lFamilia').append(familiaItem.familia);
                    $('#lObservacion').append(familiaItem.observacion);
                    $('#lRegistro').append('<a href="../otros/registroDetalle.jsp?registro=' + familiaItem.registro + '&historial=" target="_blank">Ver detalles</a>');
                }
                fProcesandoPeticionCerrar();
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

function fPaginaActual() {
    $('#dProcesandoPeticion').dialog('open');
    fFamiliaLeer(parseInt($('#codFamilia').val(), 10), '');
}
;