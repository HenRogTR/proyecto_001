/* 
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
$(document).ready(function(e) {

});

$(function() {
    $('#form_usuarioContraseniaCambiar').validate({
        submitHandler: function() {
            fUsuarioContraseñaCambiar();
        },
        onkeyup: function(element) {
            $(element).valid();
        },
        rules: {
            contraseniaAnterior: {
                required: true,
                alphanumeric: true,
                minlength: 4
            },
            contraseniaNueva: {
                required: true,
                alphanumeric: true,
                minlength: 4
            },
            contraseniaNuevaRepetir: {
                required: true,
                alphanumeric: true,
                minlength: 4,
                equalTo: '#contraseniaNueva'
            }
        },
        messages: {
            contraseniaAnterior: {
                alphanumeric: 'Sólo letras, números y guiones bajos por favor.'
            },
            contraseniaNueva: {
                alphanumeric: 'Sólo letras, números y guiones bajos por favor.'
            },
            contraseniaNuevaRepetir: {
                alphanumeric: 'Sólo letras, números y guiones bajos por favor.'
            }
        }
    });
});

function fUsuarioContraseñaCambiar() {
    var data = {
        accionUsuario: 'contraseniaCambiar',
        contraseniaAnterior: hex_md5($('#contraseniaAnterior').val()),
        contraseniaNueva: hex_md5($('#contraseniaNueva').val()),
        contraseniaNuevaRepetir: hex_md5($('#contraseniaNuevaRepetir').val())
    };
    var url = '../sUsuario';
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
                    fAlerta('Contraseña cambiada, se ha cerrado la sesión y se redireccionará.');
                    fRedireccionarEspera('../', 2000);
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

function fPaginaActual() {
}
;