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
    $('#formEmpresaConvenioEditar').validate({
        //    ignore: '', // si en caso no se ingnora los campos ocultos
        submitHandler: function() {
            $('#trBotones').addClass('ocultar');
            fEmpresaConvenioEditar();
        },
        onkeyup: function(element) {
            $(element).valid();
        },
        rules: {
            nombre: {
                required: true,
                minlength: 5,
                remote: {
                    url: 'validacion/empresaConvenio/empresaConvenioEditarNombre.jsp',
                    type: 'post',
                    data: {codEmpresaConvenio: $('#codEmpresaConvenio').val()}
                }
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

function fEmpresaConvenioEditar() {
    var data = $('#formEmpresaConvenioEditar').serialize();
    var url = $('#formEmpresaConvenioEditar').attr('action');
    try {
        $.ajax({
            type: 'post',
            url: url,
            data: data,
            beforeSend: function() {
                fProcesandoPeticion('Editando, ');
            },
            error: function(XMLHttpRequest, textStatus, errorThrown) {
                $('#lServidorError').text(errorThrown + '()');
                $('#dServidorError').dialog('open');
            },
            success: function(ajaxResponse, textStatus) {
                $('#trBotones').removeClass('ocultar');
                if ($.isNumeric(ajaxResponse)) {
                    fEmpresaConvenioRegistroReiniciar();
                    fProcesandoPeticion('Redireccionando...');
                    fRedireccionarEspera('../sEmpresaConvenio?accion=mantenimiento&codEmpresaConvenio=' + ajaxResponse, 1000);
                } else {
                    fProcesandoPeticionCerrar();
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
//    fEmpresaConvenioRegistroReiniciar();
}
;