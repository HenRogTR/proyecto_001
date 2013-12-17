/* 
 * To change this template, choose Tools | Templates
 * and open the template in the editor.
 */
$(document).ready(function() {
    $("#accordion").accordion({
        heightStyle: "content",
        collapsible: true
    });
//    $('#ruc').keyup(function(event) {
//        if ($('#marcador').val() == 'ruc' || $('#marcador').val() == '') {
//            fPersonaObtenerRuc($(this).val());
//        }
//    });
    $('#codEmpresaConvenio').change(function() {
        if ($(this).val() == '1') {
            $('#tipo').val('4');
            $('#condicion').val('3');
        }
    });

    $('#bCobradorBuscar').click(function(event) {
        $('#lCobradorAsigando').text($('#lCobrador').text());
        $('#dCobradorBuscar').dialog('open');
        event.preventDefault();
    });
    $('#fechaNacimiento').mask('99/99/9999');
    $('#fechaNacimiento').datepicker({
        changeMonth: true,
        changeYear: true,
        numberOfMonths: 2
    });
    $('#dCobradorBuscar').dialog({
        autoOpen: false,
        modal: true,
        resizable: true,
        height: 180,
        width: 800,
        buttons: {
            Cerrar: function() {
                $(this).dialog("close");
            },
            Cambiar: function() {
                $('#lCobrador').text($('#cobradorBuscar').val());
                $('#codCobrador').val($('#codCobradorAux').val());
                $('#cobradorBuscar').val('');
                $(this).dialog("close");
            }
        },
        close: function() {
            $(this).dialog("close");
        }
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

    $('#cobradorBuscar').autocomplete({
        source: "autocompletado/cobradorVendedor.jsp",
        minLength: 3,
        select: cobradorSeleccionado,
        focus: cobradorMarcado
    });
    $('.mayuscula').blur(function() {
        $(this).val($.trim($(this).val().toUpperCase()));
    });
    $('.limpiar').blur(function() {
        $.trim($(this).val().toUpperCase());
    });
    $('#formClienteJuridicoRegistrar').validate({
        ignore: "",
        submitHandler: function() {
            if ($('#codCobrador').val() == 0) {
                $('#dMensajeAlertaDiv').empty().append('Seleccione cobrador');
                $('#dMensajeAlerta').dialog('open');
                return;
            }
            fClienteNaturalRegistrar();
        },
        onkeyup: function(element) {
            $(element).valid();
        },
        rules: {
            ruc: {
                required: true,
                number: true,
                minlength: 11,
                remote: {
                    url: 'validacion/clienteJuridicoEditarRuc.jsp',
                    type: 'post',
                    data: {
                        codPersona: $('#codPersona').val()
                    }
                }
            },
            nombres: {
                required: true,
                minlength: 2
            },
            fechaNacimiento: 'dateITA',
            direccion: {
                required: true,
                minlength: 10
            },
            codZona: 'required',
            email: 'email',
            codEmpresaConvenio: 'required',
            observacionDatoCliente: {
                minlength: 10
            }
        },
        messages: {
            ruc: {
                remote: 'Ya se encuentra registrado.'
            },
            fechaNacimiento: 'Por favor ingrese una fecha correcta dd/mm/yyyy',
            codZona: 'Seleccione zona',
            codEmpresaConvenio: 'Selecione empresa',
        }
    });
});

function fClienteNaturalRegistrar() {
    var $form = $("#formClienteJuridicoRegistrar");
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
                    $(location).attr('href', '../sDatoCliente?accionDatoCliente=mantenimiento&codDatoCliente=' + $('#codDatoCliente').val());
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
    data = {ruc: ruc};
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

function cobradorSeleccionado(event, ui) {
    var cobrador = ui.item.value;
    $('#cobradorBuscar').val(cobrador.nombresC);
    $('#codCobradorAux').val(cobrador.codPersona);
    event.preventDefault();
}
;

function cobradorMarcado(event, ui) {
    var cobrador = ui.item.value;
    $('#cobradorBuscar').val(cobrador.nombresC);
    event.preventDefault();
}
;

function fPaginaActual() {
//    fReiniciarForm();
}
;

