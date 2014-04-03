/* 
 * To change this template, choose Tools | Templates
 * and open the template in the editor.
 */

$(document).ready(function() {
    $('#accordion').accordion({
        heightStyle: 'content'
    });
    $('#bPrimero').click(function(event) {
        fUsuarioLeer(-1, '');
        event.preventDefault();
    });
    $('#bAnterior').click(function(event) {
        fUsuarioLeer(parseInt($('#codUsuario').val(), 10) - 1, 'anterior');
        event.preventDefault();
    });
    $('#bSiguiente').click(function(event) {
        fUsuarioLeer(parseInt($('#codUsuario').val(), 10) + 1, 'siguiente');
        event.preventDefault();
    });
    $('#bUltimo').click(function(event) {
        fUsuarioLeer(0, '');
        event.preventDefault();
    });

    $('#bEditar').click(function(e) {
        if ($.isNumeric($('#codUsuario').val())) {
            $(this).attr('href', 'usuarioPrivilegios.jsp?codUsuario=' + $('#codUsuario').val());
        } else {
            fAlerta('No hay usuario.');
            e.preventDefault();
        }
    });
});

function fPaginaActual() {
    $('#dProcesandoPeticion').dialog('open');
    fUsuarioLeer(parseInt($('#codUsuario').val(), 10), '');
}
;

function fUsuarioLeer(codUsuario, parametro) {
    var data = {codUsuario: codUsuario, parametro: parametro};
    try {
        $.ajax({
            type: "post",
            url: "ajax/usuario.jsp",
            data: data,
            error: function(XMLHttpRequest, textStatus, errorThrown) {
                $('#lServidorError').text(errorThrown + '(usuario.jsp)');
                $('#dServidorError').dialog('open');
            },
            success: function(ajaxResponse, textStatus) {
                var arrayUsuario = procesarRespuesta(ajaxResponse);
                if (arrayUsuario.length == 0) {
                    $('#dMensajeAlertaDiv').empty().append('Usuario no encontrado');
                    $('#dMensajeAlerta').dialog('open');
                } else {
                    var itemUsuario = arrayUsuario[0];
                    $('.vaciar').empty();
                    $('#codUsuario').val(itemUsuario.codUsuario);
                    $('#lCodUsuario').append(itemUsuario.codUsuario);
                    $('#lEstado').append(itemUsuario.estado ? 'HABILITADO' : 'DESHABILITADO');
                    $('#lUsuario').append(itemUsuario.usuario);
                    $('#lPersonal').append(itemUsuario.personal);
                }
                $('#dProcesandoPeticion').dialog('close');
            },
            statusCode: {
                404: function() {
                    $('#lServidorError').text('Página no encontrada(cliente.jsp).');
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