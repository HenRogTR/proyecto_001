/* 
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */


$(document).ready(function(event) {
    $('.mayuscula').blur(function(event) {
        $(this).val($.trim($(this).val().toUpperCase()));
    });
    $("#nombre").keyup(function(event) {
        $("#codCobranza").val($(this).val().substring(0, 1).toUpperCase());
    });
    $('#bRestaurar').click(function(event) {
        var a = confirm('Desea restaurar el formulario.', "Restaurar fomrmulario.");
        if (!a) {
            event.preventDefault();
            return;
        }
    });
    $('#formEmpresaConvenioRegistrar').validate({
        //    ignore: '', // si en caso no se ingnora los campos ocultos
        submitHandler: function() {
            fEmpresaConvenioRegistrar();
        },
        onkeyup: function(element) {
            $(element).valid();
        },
        rules: {
            nombre: {
                required: true,
                minlength: 5,
                remote: 'validacion/empresaConvenio/empresaConvenioRegistrarNombre.jsp'
            },
            codCobranza: {
                required: true,
                minlength: 1,
                maxlength: 1
            },
            abreviatura: {
                minlength: 3
            }
        },
        messages: {
            nombre: {
                remote: 'Ya se encuentra registrado.'
            }
        }
    });
});

function fEmpresaConvenioRegistrar() {
    var data = $('#formEmpresaConvenioRegistrar').serialize();
    var url = $('#formEmpresaConvenioRegistrar').attr('action');
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
                    fEmpresaConvenioRegistroReiniciar();
                    $(location).attr('href', '../sEmpresaConvenio?accion=mantenimiento&codEmpresaConvenio=' + ajaxResponse);
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

function fEmpresaConvenioRegistroReiniciar() {
    $('.limpiar').val('');
}
;

function fPaginaActual() {
    fEmpresaConvenioRegistroReiniciar();
}
;