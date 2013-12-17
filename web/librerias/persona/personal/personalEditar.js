/* 
 * To change this template, choose Tools | Templates
 * and open the template in the editor.
 */
$(document).ready(function() {
    $("#accordion").accordion({
        heightStyle: "content",
        collapsible: true
    });
    $('#fechaNacimiento').mask('99/99/9999');
    $('#fechaNacimiento').datepicker({
        changeMonth: true,
        changeYear: true,
        numberOfMonths: 2
    });
    $('#fechaInicioActividades').mask('99/99/9999');
    $('#fechaInicioActividades').datepicker({
        changeMonth: true,
        changeYear: true,
        numberOfMonths: 2,
        onClose: function(selectedDate) {
            $('#fechaFinActividades').datepicker('option', 'minDate', selectedDate);
        }
    });
    $('#fechaFinActividades').mask('99/99/9999');
    $('#fechaFinActividades').datepicker({
        changeMonth: true,
        changeYear: true,
        numberOfMonths: 2,
        onClose: function(selectedDate) {
            $('#fechaInicioActividades').datepicker('option', 'maxDate', selectedDate);
        }
    });    
    $('.mayuscula').blur(function() {
        $(this).val($.trim($(this).val().toUpperCase()));
    });
    $('.limpiar').blur(function() {
        $.trim($(this).val().toUpperCase());
    });
    $('#formPersonalEditar').validate({
        ignore: "",
        submitHandler: function() {
            fPersonalEditar();
        },
        onkeyup: function(element) {
            $(element).valid();
        },
        rules: {
            dniPasaporte: {
                required: true,
                minlength: 8,
                remote: {
                    url: "validacion/personalEditarDniPasaporte.jsp",
                    type: "post",
                    data: {
                        codPersona: $('#codPersona').val()
                    }
                }
            },
            ruc: {
                number: true,
                minlength: 11,
                remote: {
                    url: "validacion/personalEditarRuc.jsp",
                    type: "post",
                    data: {
                        codPersona: $('#codPersona').val()
                    }
                }
            },
//            apePaterno: {
//                required: true,
//                minlength: 1
//            },
//            apeMaterno: {
//                required: true,
//                minlength: 1
//            },
            nombres: {
                required: true,
                minlength: 2
            },
            sexo: 'required',
            fechaNacimiento: 'dateITA',
            estadoCivil: 'required',
            direccion: {
                required: true,
                minlength: 10
            },
            codZona: 'required',
            email: 'email',
            observacionPersona: {
                minlength: 10
            },
            estado: 'required',
            codCargo: 'required',
            codArea: 'required',
            fechaInicioActividades: 'dateITA',
            fechaFinActividades: 'dateITA',
            observacionPersonal: {
                minlength: 10
            }
        },
        messages: {
            dniPasaporte: {
                remote: 'Ya se encuentra registrado.'
            },
            ruc: {
                remote: 'Ya se encuentra registrado.'
            },
            sexo: 'Seleccione sexo',
            estado: 'Seleccione estado',
            fechaNacimiento: 'Por favor ingrese una fecha correcta dd/mm/yyyy',
            codZona: 'Seleccione zona',
            codCargo: 'Seleccione cargo',
            codArea: 'Seleccione área',
            fechaInicioActividades: 'Por favor ingrese una fecha correcta dd/mm/yyyy',
            fechaFinActividades: 'Por favor ingrese una fecha correcta dd/mm/yyyy'
        }
    });
});

function fPersonalEditar() {
    var $form = $("#formPersonalEditar");
    try {
        $.ajax({
            type: 'POST',
            url: $form.attr('action'),
            data: $form.serialize(),
            beforeSend: function() {

            },
            error: function(XMLHttpRequest, textStatus, errorThrown) {
                $('#lServidorError').text(errorThrown + '(sPersonal)');
                $('#dServidorError').dialog('open');
            },
            success: function(ajaxResponse, textStatus) {
                if (isNaN(ajaxResponse)) {//no se registro
                    $('#dMensajeAlertaDiv').empty().append(ajaxResponse);
                    $('#dMensajeAlerta').dialog('open');
                } else {
                    $(location).attr('href', '../sPersonal?accionPersonal=mantenimiento&codPersonal=' + $('#codPersonal').val());
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
}
;


function fReiniciarForm() {
    $('.limpiar').val('');
    $('#estado').val('1');
}
;

function fPaginaActual() {
//    fReiniciarForm();
}
;

