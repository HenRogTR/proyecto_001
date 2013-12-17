/* 
 * To change this template, choose Tools | Templates
 * and open the template in the editor.
 */

$(document).ready(function() {
    $('.dato').blur(function() {
        $(this).val($.trim($(this).val().toUpperCase()));
    });
    $("#bSerieNumeroInfo").click(function(event) {
        $("#dSerieNumeroInfo").dialog("open");
        event.preventDefault();
    });
    $("#dSerieNumeroInfo").dialog({
        autoOpen: false,
        modal: true,
        resizable: true,
        height: 250,
        width: 450,
        buttons: {
            Cerrar: function() {
                $(this).dialog("close");
            }
        }
    });
    $("#dAPRegistrarExito").dialog({
        autoOpen: false,
        modal: true,
        resizable: true,
        height: 150,
        width: 350,
        buttons: {
            Ver: function() {
                $(location).attr('href', '../sArticuloProducto?accionArticuloProducto=mantenimiento&codArticuloProducto=' + $('#codArticuloProducto').val());
            },
            'Registrar otro': function() {
                $(this).dialog("close");
            }
        }
    });

    var f = $('#formArticuloProducto').validate({
        submitHandler: function(form) {
            $('#codArticuloProducto').val('sdsk');
            fArticuloProductoRegistrar(f, form);
        },
        onkeyup: function(element) {
            $(element).valid();
        },
        rules: {
            descripcion: {
                required: true,
                minlength: 5,
                remote: 'validacion/descripcion.jsp'
            },
            usarSerieNumero: 'required',
            unidadMedida: {
                required: true,
                minlength: 4
            },
            reintegroTributario: 'required',
            codFamilia: 'required',
            codMarca: 'required'
        },
        messages: {
            descripcion: {
                remote: jQuery.format('<b> {0}</b> ya registrado.')
            },
            usarSerieNumero: 'Seleccione un opción.',
            reintegroTributario: 'Seleccione un opción.',
            codFamilia: 'Seleccione un opción.',
            codMarca: 'Seleccione un opción.'
        }
    });
});
function fArticuloProductoRegistrar(formValidate, form) {
    var $form = $("#formArticuloProducto");
    try {
        $.ajax({
            type: 'POST',
            url: $form.attr('action'),
            data: $form.serialize(),
            beforeSend: function() {

            },
            error: function(XMLHttpRequest, textStatus, errorThrown) {
                $('#lServidorError').text(errorThrown + '(sArticuloProducto)');
                $('#dServidorError').dialog('open');
            },
            success: function(ajaxResponse, textStatus) {
                if (isNaN(ajaxResponse)) {//no se registro
                    $('#dMensajeAlertaDiv').append(ajaxResponse);
                    $('#dMensajeAlerta').dialog('open');
                } else {
                    formValidate.resetForm();
                    form.reset();
                    $('#codArticuloProducto').val(ajaxResponse);
                    $('#dAPRegistrarExito').dialog('open');
                }
            },
            statusCode: {
                404: function() {
                    $('#lServidorError').text('Página no encontrada.');
                    $('#dServidorError').dialog('open');
                }
            }
        });
    } catch (ex) {
        $('#lServidorError').text(ex);
        $('#dServidorError').dialog('open');
    }
};

function fPaginaActual() {
    $("#dSerieNumeroInfo").dialog('open');
}
;

