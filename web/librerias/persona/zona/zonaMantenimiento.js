/* 
 * To change this template, choose Tools | Templates
 * and open the template in the editor.
 */
$(document).ready(function(event) {
    $('#bPrimero').click(function(event) {
        fZonaLeer(-1, '');
        event.preventDefault();
    });
    $('#bAnterior').click(function(event) {
        var cod = parseInt($('#codZona').val(), 10) - 1;
        if (cod == 0) {
            return;
        }
        fZonaLeer(cod, 'anterior');
        event.preventDefault();
    });
    $('#bSiguiente').click(function(event) {
        fZonaLeer(parseInt($('#codZona').val(), 10) + 1, 'siguiente');
        event.preventDefault();
    });
    $('#bUltimo').click(function(event) {
        fZonaLeer(0, '');
        event.preventDefault();
    });
    
    
});

function fZonaLeer(codZona, parametro) {
    var data = {codZona: codZona, parametro: parametro};
    var url = 'ajax/zonaLeer.jsp';
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
                var zonaArray = procesarRespuesta(ajaxResponse);
                if (zonaArray.length == 0) {
                    $('#dProcesandoPeticion').dialog('close');
                    $('#dMensajeAlertaDiv').empty().append('Zona no encontrada');
                    $('#dMensajeAlerta').dialog('open');
                } else {
                    $('.vaciar').empty();
                    var zonaItem = zonaArray[0];
                    $('#codZona').val(zonaItem.codZona);
                    $('#lCodZona').append(zonaItem.codZona);
                    $('#lZona').append(zonaItem.zona);
                    $('#lDescripcion').append(zonaItem.descripcion);
                }
                $('#dProcesandoPeticion').dialog('close');
            },
            statusCode: {
                404: function() {
                    $('#lServidorError').text('Página no encontrada.(zonaLeer.jsp)');
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
    $('#dProcesandoPeticion').dialog('open');
    fZonaLeer(parseInt($('#codZona').val(), 10), '');
}
;