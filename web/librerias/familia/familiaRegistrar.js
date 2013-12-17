/* 
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */


$(document).ready(function(event) {
    $('.mayuscula').blur(function(event) {
        $(this).val($.trim($(this).val().toUpperCase()));
    });

    $('#formFamiliaRegistrar').validate({
//    ignore: "", // si en caso no se ingnora los campos ocultos
        submitHandler: function() {
            fFamiliaRegistrar();
        },
        onkeyup: function(element) {
            $(element).valid();
        },
        rules: {
            familia: {
                required: true,
                minlength: 5
            },
            observacion: {
                minlength: 5
            }
        },
        messages: {
        }
    });
});

function fFamiliaRegistrar() {
    $('#trBoton').addClass('ocultar');
    var data = $('#formFamiliaRegistrar').serialize();
    var url = $('#formFamiliaRegistrar').attr('action');
    try {
        $.ajax({
            type: 'post',
            url: url,
            data: data,
            beforeSend: function() {
                fProcesandoPeticion('Registrando.');
            },
            error: function(XMLHttpRequest, textStatus, errorThrown) {
                $('#lServidorError').text(errorThrown + '()');
                $('#dServidorError').dialog('open');
            },
            success: function(ajaxResponse, textStatus) {
                fProcesandoPeticionCerrar();
                if ($.isNumeric(ajaxResponse)) {
                    fFormFamiliaRegistrarReiniciar();
                    fProcesandoPeticion('Registro exitoso. Redireccionando');
                    fRedireccionarEspera('../sFamilia?accion=mantenimiento&codFamilia=' + ajaxResponse, 1000);
                } else {
                    fMensajeAlerta(ajaxResponse);
                }
                $('#trBoton').removeClass('ocultar');
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

function fFormFamiliaRegistrarReiniciar() {
    $('.limpiar').val('');
}
;

function fPaginaActual() {
    fFormFamiliaRegistrarReiniciar();
}
;
