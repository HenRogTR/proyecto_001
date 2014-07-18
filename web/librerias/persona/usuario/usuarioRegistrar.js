/* 
 * To change this template, choose Tools | Templates
 * and open the template in the editor.
 */
$(document).ready(function() {
    $('.mayuscula').blur(function() {
        $(this).val($.trim($(this).val().toUpperCase()));
    });
    $('.limpiar').blur(function() {
        $.trim($(this).val().toUpperCase());
    });
    $('#accordionUsuario').accordion({
        heightStyle: "content",
        collapsible: true
    });

    $('#bPersonalSeleccionar').click(function(event) {
        $('#lPersonalActual').text($('#lPersonalNombresC').text());
        $('#nombresCPersonal').val('');
        $('#dPersonalSeleccionar').dialog('open');
        event.preventDefault();
    });

    $('#dPersonalSeleccionar').dialog({
        autoOpen: false,
        modal: true,
        resizable: true,
        height: 180,
        width: 800,
        buttons: {
            Cerrar: function() {
                $(this).dialog('close');
            },
            Cambiar: function() {
                $('#codPersona').val($('#codPersonaAux').val());
                $('#lPersonalNombresC').text($('#nombresCPersonal').val());
                $(this).dialog('close');
            }
        },
        close: function() {
            $(this).dialog('close');
        }
    });
    $('#nombresCPersonal').autocomplete({
        minLength: 4,
        source: 'autocompletado/personal.jsp',
        focus: personalMarcado,
        select: personalSeleccionado
    });

    $('#formUsuarioRegistrar').validate({
        submitHandler: function() {
            if ($('#codPersona').val() == '' || $('#codPersona').val() == '0') {
                $('#dMensajeAlertaDiv').empty().append('Seleccione personal a quien se asignará el usuario');
                $('#dMensajeAlerta').dialog('open');
                return;
            }
            fUsuarioRegistrar();
        },
        onkeyup: function(element) {
            $(element).valid();
        },
        rules: {
            estado: 'required',
            usuarioNuevo: {
                required: true,
                alphanumeric: true,
                minlength: 4,
                maxlength: 8,
                remote: 'validacion/usuarioRegistrarUsuario.jsp'
            },
            contraseniaNueva: {
                required: true,
                alphanumeric: true,
                minlength: 4
            },
            repetirContraseniaNueva: {
                required: true,
                alphanumeric: true,
                minlength: 4,
                equalTo: '#contraseniaNueva'
            }
        },
        messages: {
            estado: 'Seleccione estado',
            usuarioNuevo: {
                remote: 'Nombre de usuario no disponible',
                alphanumeric: 'Sólo letras, números y guiones bajos por favor.'
            },
            contraseniaNueva: {
                alphanumeric: 'Sólo letras, números y guiones bajos por favor.'
            },
            repetirContraseniaNueva: {
                alphanumeric: 'Sólo letras, números y guiones bajos por favor.'
            }
        }
    });
});
function personalMarcado(event, ui) {
    var personal = ui.item.value;
    $('#nombresCPersonal').val(personal.nombresC);
    event.preventDefault();
}
;

function personalSeleccionado(event, ui) {
    var cobrador = ui.item.value;
    $('#nombresCPersonal').val(cobrador.nombresC);
    $('#codPersonaAux').val(cobrador.codPersona);
    event.preventDefault();
}
;

function fUsuarioRegistrar() {
    var data = $('#formUsuarioRegistrar').serialize();
    var url = '../sUsuario';
    try {
        $.ajax({
            type: 'post',
            url: url,
            data: data,
            beforeSend: function() {

            },
            error: function(XMLHttpRequest, textStatus, errorThrown) {
                $('#lServidorError').text(errorThrown + '(sUsuario)');
                $('#dServidorError').dialog('open');
            },
            success: function(ajaxResponse, textStatus) {
                if ($.isNumeric(ajaxResponse)) {
                    fReiniciarFormUsuarioRegistrar();
                    $(location).attr('href', '../sUsuario?accionUsuario=mantenimiento&codUsuario=' + ajaxResponse);
                } else {
                    fAlerta(ajaxResponse);
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

function fReiniciarFormUsuarioRegistrar() {
    $('.limpiar').val('');
}
;

function fPaginaActual() {
    fReiniciarFormUsuarioRegistrar();
}
;
