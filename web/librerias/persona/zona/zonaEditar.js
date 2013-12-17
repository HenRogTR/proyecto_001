/* 
 * To change this template, choose Tools | Templates
 * and open the template in the editor.
 */
$(document).ready(function(event) {
    $('#formZonaEditar').validate({
        submitHandler: function() {
            fZonaEditar();
        },
        onkeyup: function(element) {
            $(element).valid();
        },
        rules: {
            zona: {
                required: true,
                minlength: 4,
                remote: {
                    url: 'validacion/zona/zonaEditarZona.jsp',
                    type: 'post',
                    data: {
                        codZona: $('#codZona').val()
                    }
                }
            }
        },
        messages: {
            zona: {
                remote: 'Ya se encuentra registrado.'
            }
        }
    });
    $('.mayuscula').blur(function() {
        $(this).val($.trim($(this).val().toUpperCase()));
    });
    $('.limpiar').blur(function() {
        $.trim($(this).val().toUpperCase());
    });
});

function fZonaEditar() {
    var data = $('#formZonaEditar').serialize();
    var url = $('#formZonaEditar').attr('action');
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
                    fFormZonaRegistrarReiniciar();
                    $(location).attr('href', '../sZona?accionZona=mantenimiento&codZona=' + ajaxResponse);
                } else {
                    $('#dMensajeAlertaDiv').empty().append('Error en el registro: ' + ajaxResponse);
                    $('#dMensajeAlerta').dialog('open');
                }
            },
            statusCode: {
                404: function() {
                    $('#lServidorError').text('Página no encontrada.');
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

function fFormZonaRegistrarReiniciar() {
    $('.limpiar').val('');
}
;

function fPaginaActual() {
//    fFormZonaRegistrarReiniciar();
}
;