/* 
 * To change this template, choose Tools | Templates
 * and open the template in the editor.
 */

$(document).ready(function() {
    $("#accordion").accordion({
        heightStyle: "content",
        collapsible: true
    });
    $('#bPrimero').click(function(event) {
        fPersonalLeer(-1, '');
        event.preventDefault();
    });
    $('#bAnterior').click(function(event) {
        fPersonalLeer(parseInt($('#codPersonal').val(), 10) - 1, 'anterior');
        event.preventDefault();
    });
    $('#bSiguiente').click(function(event) {
        fPersonalLeer(parseInt($('#codPersonal').val(), 10) + 1, 'siguiente');
        event.preventDefault();
    });
    $('#bUltimo').click(function(event) {
        fPersonalLeer(0, '');
        event.preventDefault();
    });
});
function fPaginaActual() {
    $('#dProcesandoPeticion').dialog('open');
    fPersonalLeer(parseInt($('#codPersonal').val(), 10), '');
}
;

function fPersonalLeer(codPersonal, parametro) {
    var data = {codPersonal: codPersonal, parametro: parametro};
    try {
        $.ajax({
            type: 'post',
            url: 'ajax/personal.jsp',
            data: data,
            beforeSend: function() {

            },
            error: function(XMLHttpRequest, textStatus, errorThrown) {
                $('#lServidorError').text(errorThrown + '(Página)');
                $('#dServidorError').dialog('open');
            },
            success: function(ajaxResponse, textStatus) {
                var personalArray = procesarRespuesta(ajaxResponse);
                if (personalArray.length == 0) {
                    $('#dMensajeAlertaDiv').empty().append('Personal no encontrado');
                    $('#dMensajeAlerta').dialog('open');
                } else {
                    $('.vaciar').empty();
                    var personaItem = personalArray[0];
                    $('#codPersona').val(personaItem.codPersona);
                    $('#lNombres').append(personaItem.nombres);
                    $('#lDireccion').append(personaItem.direccion);
                    $('#lDniPasaporte').append(personaItem.dniPasaporte);
                    $('#lRuc').append(personaItem.ruc);
                    $('#lTelefono1P').append(personaItem.telefono1P);
                    $('#lTelefono2P').append(personaItem.telefono2P);
                    $('#lEmail').append(personaItem.email);
                    $('#lFechaNacimiento').append(personaItem.fechaNacimiento);
                    $('#lObservacionPersona').append(personaItem.observacionPersona);
                    $('#lZona').append(personaItem.zona);

                    var naturalItem = personalArray[1];
                    $('#codNatural').val(naturalItem.codNatural);
                    $('#lCodNatural').append(naturalItem.codNatural);
                    $('#lApePaterno').append(naturalItem.apePaterno);
                    $('#lApeMaterno').append(naturalItem.apeMaterno);
                    $('#lSexo').append(naturalItem.sexo);
                    $('#lEstadoCivil').append(naturalItem.estadoCivil);
                    $('#lConyuge').append(naturalItem.conyuge);
//
                    var personalItem = personalArray[2];
                    $('#codPersonal').val(personalItem.codPersonal);
                    $('#lCodPersonal').append(personalItem.codPersonal);
                    $('#lFechaInicioActividades').append(personalItem.fechaInicioActividades);
                    $('#lFechaFinActividades').append(personalItem.fechaFinActividades);
                    $('#lEstado').append(personalItem.estado);
                    $('#lCargo').append(personalItem.cargo);
                    $('#lArea').append(personalItem.area);
                    $('#lObservacionPersonal').append(personalItem.observacionPersonal);
                }
                $('#dProcesandoPeticion').dialog('close');
            },
            statusCode: {
                404: function() {
                    $('#lServidorError').text('Página no encontrada(personal.jsp).');
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
