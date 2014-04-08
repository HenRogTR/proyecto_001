/* 
 * To change this template, choose Tools | Templates
 * and open the template in the editor.
 */
$(document).ready(function() {
    $("#accordion").accordion({
        heightStyle: "content",
        collapsible: true
    });
    $('#dniPasaporte').keyup(function(event) {
        if ($('#marcador').val() == 'dniPasaporte' || $('#marcador').val() == '') {
            fPersonaObtenerDniPasaporte($(this).val());
        }
    });
    $('#dniPasaporte').blur(function(event) {
        if ($(this).val() == '') {
            $('#marcador').val('ruc');
        }
        if ($('#marcador').val() == '') {
            $('#marcador').val('dniPasaporte');
        }
    });
    $('#ruc').keyup(function(event) {
        if ($('#marcador').val() == 'ruc' || $('#marcador').val() == '') {
            fPersonaObtenerRuc($(this).val());
        }
    });
    $('#ruc').blur(function(event) {
        if ($(this).val() == '') {
            $('#marcador').val('dniPasaporte');
        }
        if ($('#marcador').val() == '') {
            $('#marcador').val('ruc');
        }
    });
    $('#codEmpresaConvenio').change(function() {
        if ($(this).val() == '1') {
            $('#tipo').val('4');
            $('#condicion').val('3');
        }
    });
    
    $('#fechaNacimiento').mask('99/99/9999');
    $('#fechaNacimiento').datepicker({
        changeMonth: true,
        changeYear: true,
        numberOfMonths: 2
    });    
    $("#dClienteRegistrarExito").dialog({
        autoOpen: false,
        modal: true,
        resizable: true,
        height: 150,
        width: 350,
        buttons: {
            Ver: function() {
                $(location).attr('href', '../sDatoCliente?accionDatoCliente=mantenimiento&codDatoCliente=' + $('#codDatoCliente').val());
            },
            'Registrar otro': function() {
                $(this).dialog("close");
            }
        }
    });

    $('.mayuscula').blur(function() {
        $(this).val($.trim($(this).val().toUpperCase()));
    });
    $('.limpiar').blur(function() {
        $.trim($(this).val().toUpperCase());
    });
    $('#formClienteNaturalRegistrar').validate({
        ignore: "",
        submitHandler: function() {
            fClienteNaturalRegistrar();
        },
        onkeyup: function(element) {
            $(element).valid();
        },
        rules: {
            dniPasaporte: {
                required: true,
                minlength: 8,
                remote: 'validacion/clienteNaturalRegistrarDniPasaporte.jsp'
            },
            ruc: {
                number: true,
                minlength: 11,
                remote: 'validacion/clienteNaturalRegistrarRuc.jsp'
            },
            apePaterno: {
                required: true,
                minlength: 1
            },
            apeMaterno: {
                required: true,
                minlength: 1
            },
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
            codEmpresaConvenio: 'required',
            tipo: 'required',
            condicion: 'required',
            observacionDatoCliente: {
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
            codEmpresaConvenio: 'Selecione empresa',
            tipo: 'Seleccione tipo',
            condicion: 'Seleccione condición'
        }
    });
});

function fClienteNaturalRegistrar() {
    var $form = $("#formClienteNaturalRegistrar");
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
                    fReiniciarForm();
                    $('#codDatoCliente').val(ajaxResponse);
                    $('#dClienteRegistrarExito').dialog('open');
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

function fPersonaObtenerDniPasaporte(dniPasaporte) {
    var data = {dniPasaporte: dniPasaporte};
    try {
        $.ajax({
            type: 'POST',
            url: 'ajax/personaDniPasaporte.jsp',
            data: data,
            beforeSend: function() {

            },
            error: function(XMLHttpRequest, textStatus, errorThrown) {
                $('#lServidorError').text(errorThrown + '(persona.jsp)');
                $('#dServidorError').dialog('open');
            },
            success: function(ajaxResponse, textStatus) {
                var personaArray = procesarRespuesta(ajaxResponse);
                if (personaArray.length > 0) {
                    $('#marcador').val('dniPasaporte');
                    var personaItem = personaArray[0];
                    $('#codPersona').val(personaItem.codPersona);
                    $('#codNatural').val(personaItem.codNatural);
                    $('#ruc').val(personaItem.ruc);
                    $('#apePaterno').val(personaItem.apePaterno);
                    $('#apeMaterno').val(personaItem.apeMaterno);
                    $('#nombres').val(personaItem.nombres);
                    $('#sexo').val(personaItem.sexo);
                    $('#fechaNacimiento').val(personaItem.fechaNacimiento);
                    $('#estadoCivil').val(personaItem.estadoCivil);
                    $('#telefono1').val(personaItem.telefono1P);
                    $('#telefono2').val(personaItem.telefono2P);
                    $('#direccion').val(personaItem.direccion);
                    $('#codZona').val(personaItem.codZona);
                    $('#email').val(personaItem.email);
                    $('#observacionPersona').val(personaItem.observacionPersona);

                } else {
                    fReiniciarForm();
                    $('#dniPasaporte').val(dniPasaporte);
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

function fPersonaObtenerRuc(ruc) {
    var data = {ruc: ruc};
    try {
        $.ajax({
            type: 'POST',
            url: 'ajax/personaRuc.jsp',
            data: data,
            beforeSend: function() {

            },
            error: function(XMLHttpRequest, textStatus, errorThrown) {
                $('#lServidorError').text(errorThrown + '(persona.jsp)');
                $('#dServidorError').dialog('open');
            },
            success: function(ajaxResponse, textStatus) {
                var personaArray = procesarRespuesta(ajaxResponse);
                if (personaArray.length > 0) {
                    $('#marcador').val('ruc');
                    var personaItem = personaArray[0];
                    $('#codPersona').val(personaItem.codPersona);
                    $('#codNatural').val(personaItem.codNatural);
                    $('#dniPasaporte').val(personaItem.dniPasaporte);
                    $('#apePaterno').val(personaItem.apePaterno);
                    $('#apeMaterno').val(personaItem.apeMaterno);
                    $('#nombres').val(personaItem.nombres);
                    $('#sexo').val(personaItem.sexo);
                    $('#fechaNacimiento').val(personaItem.fechaNacimiento);
                    $('#estadoCivil').val(personaItem.estadoCivil);
                    $('#telefono1P').val(personaItem.telefono1P);
                    $('#telefono2P').val(personaItem.telefono2P);
                    $('#direccion').val(personaItem.direccion);
                    $('#codZona').val(personaItem.codZona);
                    $('#email').val(personaItem.email);
                    $('#observacionPersona').val(personaItem.observacionPersona);

                } else {
                    fReiniciarForm();
                    $('#ruc').val(ruc);
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

function fReiniciarForm() {
    $('.limpiar').val('');
    $('#saldoMax').val('5000.00');
    $('.vaciar').empty();
}
;

function fPaginaActual() {
    fReiniciarForm();
}
;

