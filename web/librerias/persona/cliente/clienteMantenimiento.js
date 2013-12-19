/* 
 * To change this template, choose Tools | Templates
 * and open the template in the editor.
 */
$(document).ready(function(event) {

    $('#bPrimero').click(function(event) {
        fClienteLeer(-1, '');
        event.preventDefault();
    });
    $('#bAnterior').click(function(event) {
        fClienteLeer(parseInt($('#codDatoCliente').val(), 10) - 1, 'anterior');
        event.preventDefault();
    });
    $('#bSiguiente').click(function(event) {
        fClienteLeer(parseInt($('#codDatoCliente').val(), 10) + 1, 'siguiente');
        event.preventDefault();
    });
    $('#bUltimo').click(function(event) {
        fClienteLeer(0, '');
        event.preventDefault();
    });
    $('#bBuscarCliente').click(function(event) {
        $("#dClienteBuscar").dialog('open');
        event.preventDefault();
    });

    $('#codDatoClienteBuscar')
            .numeric({decimal: false, negative: false})
            .keyup(function(e) {
                var key = e.charCode ? e.charCode : (e.keyCode ? e.keyCode : 0);
                if (key == 13) {
                    if (!isNaN($(this).val()) & $(this).val() > 0) {
                        fClienteLeer(parseInt($(this).val(), 10), '');
                        $("#dClienteBuscar").dialog('close');
                        $(this).val('');
                    }
                }
            });

    $('#bDocumentoNotificacion').click(function(event) {
        $('#bDNEditar').prop('disabled', true).addClass('ui-state-disabled');
        $('#bDNRegistrar').prop('disabled', false).removeClass('ui-state-disabled');
        $('#dDocumentoNotificacion').dialog('open');
        event.preventDefault();
    });
    $('#fech1')
            .mask('00/00/0000')
            .blur(function() {
                if (!fValidarFecha(this.value)) {
                    this.value = '';
                }
            });

});

$(function() {
    $('#accordionNatural').accordion({
        heightStyle: 'content',
        collapsible: true
    });
    $('#accordionJuridico').accordion({
        heightStyle: 'content',
        collapsible: true
    });

    $('#fech1').datepicker({
        changeMonth: true, changeYear: true, numberOfMonths: 2, showButtonPanel: true
    });
    $("#dClienteBuscar").dialog({
        autoOpen: false,
        modal: true,
        resizable: true,
        height: 200,
        width: 800,
        buttons: {
            Cerrar: function() {
                $(this).dialog("close");
            }
        },
        close: function() {
            $(this).dialog("close");
        }
    });

    $("#dDocumentoNotificacion").dialog({
        autoOpen: false,
        modal: true,
        resizable: true,
        height: 500,
        width: 1000,
        buttons: [
            {
                id: 'bDNEditar',
                text: 'Editar',
                click: function() {
                    if (fDNValidar()) {
                        fDNEditar();
                    }
                }
            },
            {
                id: 'bDNRegistrar',
                text: 'Registrar',
                click: function() {
                    if (fDNValidar()) {
                        fDNRegistrar();
                    }
                }
            },
            {
                id: 'bDNCerrar',
                text: 'Cerrar',
                click: function() {
                    $(this).dialog('close');
                }
            }
        ]
        ,
        close: function() {
            $(this).dialog("close");
        }
    });


    $("#dDocumentoNotificacionBorrarConfirmar").dialog({
        autoOpen: false,
        modal: true,
        resizable: true,
        height: 100,
        width: 300,
        buttons: {
            Si: function() {
                fDNEliminar();
            },
            No: function() {
                $(this).dialog("close");
            }
        },
        close: function() {
            $(this).dialog("close");
        }
    });

    $('#nombresCBuscar').autocomplete({
        source: "autocompletado/datoClienteNombresC.jsp",
        minLength: 3,
        focus: datoClienteMarcado,
        select: datoClienteSeleccionado

    });

    $('#dniPasaporteRucBuscar').autocomplete({
        source: "autocompletado/datoClienteDniPasaporteRuc.jsp",
        minLength: 4,
        focus: datoClienteMarcado,
        select: datoClienteSeleccionado
    });

});
function fPaginaActual() {
    $('#dProcesandoPeticion').dialog('open');
    fClienteLeer(parseInt($('#codDatoCliente').val(), 10), '');
}
;

function datoClienteSeleccionado(event, ui) {
    var personaDato = ui.item.value;
    $('#dniPasaporteRucBuscar').val('');
    $('#nombresCBuscar').val('');
    fClienteLeer(parseInt(personaDato.codDatoCliente, 10), '');
    $('#dClienteBuscar').dialog('close');
    event.preventDefault();
}
;

function datoClienteMarcado(event, ui) {
    var personaDato = ui.item.value;
    $('#rucRazonSocialBuscar').val(personaDato.dniPasaporte + " " + personaDato.ruc);
    $('#nombresCBuscar').val(personaDato.nombresC);
    event.preventDefault();
}
;

function fClienteLeer(codDatoCliente, parametro) {
    var data = {
        codDatoCliente: codDatoCliente,
        parametro: parametro
    };
    try {
        $.ajax({
            type: "post",
            url: "ajax/cliente.jsp",
            data: data,
            error: function(XMLHttpRequest, textStatus, errorThrown) {
                $('#dIniciarSesion').dialog('open');
                $('#lServidorError').text(errorThrown + '(cliente.jsp)');
                $('#dServidorError').dialog('open');
            },
            success: function(ajaxResponse, textStatus) {
                var clienteArray = procesarRespuesta(ajaxResponse);
                if (clienteArray.length == 0) {
                    $('#dProcesandoPeticion').dialog('close');
                    fAlerta('Cliente no encontrado');
                } else {
                    $('.vaciar').empty();
                    var personaItem = clienteArray[0];
                    $('.lCodPersona').append(personaItem.codPersona);
                    $('.lNombres').append(personaItem.nombres);
                    $('.lDireccion').append(personaItem.direccion);
                    $('.lDni').append(personaItem.dni);
                    $('.lRuc').append(personaItem.ruc);
                    $('.lTelefono1P').append(personaItem.telefono1P);
                    $('.lTelefono2P').append(personaItem.telefono2P);
                    $('.lEmail').append(personaItem.email);
                    $('.lFechaNacimiento').append(personaItem.fechaNacimiento);
                    $('.lObservacionPersona').append(personaItem.observacionPersona);
                    $('.lZona').append(personaItem.zona);

                    var datoCliente = clienteArray[1];
                    $('#codDatoCliente').val(datoCliente.codDatoCliente);
                    $('.lCodDatoCliente').append(datoCliente.codDatoCliente);
                    var tipoCliente = datoCliente.tipoCliente;
                    $('.lEmpresa').append(datoCliente.empresaConvenio);
                    $('.lCentroTrabajo').append(datoCliente.centroTrabajo);
                    $('.lTelefono1T').append(datoCliente.telefeno1T);
                    $('.lTelefono2T').append(datoCliente.telefeno2T);
                    $('.lTipo').append(datoCliente.tipo);
                    $('.lCondicion').append(datoCliente.condicion);
                    $('.lCreditoMax').append(datoCliente.creditoMax);
                    $('.lSaldoFavor').append(datoCliente.saldoFavor);
                    $('.lObservacionLaboral').append(datoCliente.observacionCliente);
                    $('.lRegistro').append(datoCliente.registro);
                    $('.lCobrador').append(datoCliente.cobrador);
                    if (tipoCliente == 1) {
                        var natural = clienteArray[2];
                        $('.lCodNatural').append(natural.codNatural);
                        $('.lCodModular').append(natural.codModular);
                        $('.lCargo').append(natural.cargo);
                        $('.lCarben').append(natural.carben);
                        $('.lApePaterno').append(natural.apePaterno);
                        $('.lApeMaterno').append(natural.apeMaterno);
                        $('.lSexo').append(natural.sexo);
                        $('.lEstadoCivil').append(natural.estadoCivil);
                        $('.lConyuge').append(natural.conyuge);
                        $('#bEditar').attr('href', 'clienteNaturalEditar.jsp');
                        //ocultar desoculatar
                        $('.clienteJuridico').addClass('ocultar');
                        $('.clienteNatural').removeClass('ocultar');
                    } else {
                        $('#bEditar').attr('href', 'clienteJuridicoEditar.jsp');
                        $('.clienteJuridico').removeClass('ocultar');
                        $('.clienteNatural').addClass('ocultar');
                    }
                    $('#cliente').removeClass('ocultar');
                    $('#dProcesandoPeticion').dialog('close');
                    fClienteVentaResumen(personaItem.codPersona);
                    fClienteDocumentoNotificacion(datoCliente.codDatoCliente);
                }
            },
            statusCode: {
                404: function() {
                    $('#lServidorError').text('Página no encontrada(cliente.jsp).');
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

function fClienteVentaResumen(codPersona) {
    var data = 'codPersona=' + codPersona;
    try {
        $.ajax({type: "post",
            url: "ajax/clienteVentaResumen.jsp",
            data: data,
            error: function(XMLHttpRequest, textStatus, errorThrown) {
                $('#dIniciarSesion').dialog('open');
                $('#lServidorError').text(errorThrown + '(clienteVentaResumen.jsp)');
                $('#dServidorError').dialog('open');
            },
            success: function(ajaxResponse, textStatus) {
                $('#tbClienteVentaResumen').empty();
                var resumenVentaArray = procesarRespuesta(ajaxResponse);
                if (resumenVentaArray.length == 0) {
                    $('#tbClienteVentaResumen').append();
                } else {
                    for (var idx = 0; idx < resumenVentaArray.length; idx++) {
                        var resumenVentaItem = resumenVentaArray[idx];
                        $('#tbClienteVentaResumen').append(
                                '<tr>' +
                                '<td style=" padding-left:10px;">' + resumenVentaItem.fecha + '</td>' +
                                '<td><a href="../sVenta?accionVenta=mantenimiento&codVenta=' + resumenVentaItem.codVenta + '" target="_blank">' + resumenVentaItem.docSerieNumero + '</a></td>' +
                                '<td>' + resumenVentaItem.tipo + '</td>' +
                                '<td style="text-align:right; padding-right:10px;">' + resumenVentaItem.neto + '</td>' +
                                '<td>' + resumenVentaItem.vendedor + '</td>' +
                                '</tr>'
                                );
                    }
                }
            },
            statusCode: {
                404: function() {
                    $('#lServidorError').text('Página no encontrada(clienteVentaResumen.jsp).');
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

function fClienteDocumentoNotificacion(codCliente) {
    var data = {codCliente: codCliente};
    var url = 'ajax/documentoNotificacionLeer.jsp';
    try {
        $.ajax({
            type: 'post',
            url: url,
            data: data,
            beforeSend: function() {
                $('#tbClienteDocumentoNotificacion').append(
                        '<tr>' +
                        '<td class="centrado"><img alt="not found" src="../imagenes/loading.gif" style="height: 11px;"></td>' +
                        '<td class="centrado"><img alt="not found" src="../imagenes/loading.gif" style="height: 11px;"></td>' +
                        '<td class="centrado"><img alt="not found" src="../imagenes/loading.gif" style="height: 11px;"></td>' +
                        '<td class="centrado"><img alt="not found" src="../imagenes/loading.gif" style="height: 11px;"></td>' +
                        '</tr>'
                        );
            },
            error: function(XMLHttpRequest, textStatus, errorThrown) {
                $('#lServidorError').text(errorThrown + '()');
                $('#dServidorError').dialog('open');
            },
            success: function(ajaxResponse, textStatus) {
                var DNArray = procesarRespuesta(ajaxResponse);
                var $tb = $('#tbClienteDocumentoNotificacion');
                $tb.empty();
                for (var i = 0; i < DNArray.length; i++) {
                    var DNItem = DNArray[i];
                    $tb.append(
                            '<tr id="trDN' + DNItem.codDocumentoNotificacion + '">' +
                            '<td><span id="varchar1' + DNItem.codDocumentoNotificacion + '">' + DNItem.varchar1 + '</span></td>' +
                            '<td><span id="fech1' + DNItem.codDocumentoNotificacion + '">' + DNItem.fech1 + '</span></td>' +
                            '<td><span id="text1' + DNItem.codDocumentoNotificacion + '">' + DNItem.text1 + '<span></td>' +
                            '<td><span id="text2' + DNItem.codDocumentoNotificacion + '">' + DNItem.text2 + '</span></td>' +
                            '<td class="centrado">' +
                            '<button class="sexybutton sexyicononly sexysimple sexysmall sexypropio" id="bEditarCDN' + i + '" type="button" title="' + DNItem.codDocumentoNotificacion + '"><span class="edit"></span></button> ' +
                            '<button class="sexybutton sexyicononly sexysimple sexysmall sexypropio" id="bBorrarCDN' + i + '" type="button" title="' + DNItem.codDocumentoNotificacion + '"><span class="delete"></span></button>' +
                            '</td>' +
                            '</tr>'
                            );
                    $('#bEditarCDN' + i).bind('click', function(event) {
                        var $codDNAux = $('#codDocumentoNotificacionAux');
                        $codDNAux.val($(this).attr('title'));
                        var id = $(this).attr('title');
                        $('#varchar1').val($('#varchar1' + id).text());
                        $('#fech1').val($('#fech1' + id).text());
                        $('#text1').val($('#text1' + id).text());
                        $('#text2').val($('#text2' + id).text());
                        $('#bDNRegistrar').prop('disabled', true).addClass('ui-state-disabled');
                        $('#bDNEditar').prop('disabled', false).removeClass('ui-state-disabled');
                        $('#dDocumentoNotificacion').dialog('open');
                    });

                    $('#bBorrarCDN' + i).bind('click', function(event) {
                        var $codDNAux = $('#codDocumentoNotificacionAux');
                        $codDNAux.val($(this).attr('title'));
                        $('#dDocumentoNotificacionBorrarConfirmar').dialog('open');
                    });
                }
            },
            statusCode: {
                404: function() {
                    $('#lServidorError').text('Página no encontrada(documentoNotificacionLeer.jsp).');
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

function fDNValidar() {
    var estado = true;
    var mensaje = "<strong>CORREGIR LOS ERRORES<br></strong>";
    var $varchar1 = $('#varchar1');
    if (!$varchar1.length || $varchar1.val().length < 4) {
        mensaje += '*El título debe contener como mínimo 4 caracteres<br>';
        estado = false;
    }
    var $fech1 = $('#fech1');
    if (!$fech1.length || !fValidarFecha($fech1.val())) {
        mensaje += '*Formato de <strong>fecha</strong> incorrecta (<strong>dd/mm/yyyy</strong>)<br>';
        estado = false;
    }
    var $text1 = $('#text1');
    if (!$text1.length || $text1.val().length < 6) {
        mensaje += '*La descripcion debe contener como mínimo 6 caracteres<br>';
        estado = false;
    }
    if (!estado) {
        fAlerta(mensaje);
    }
    return estado;
}
;

function fDNRegistrar() {
    var $documentoNotificacion = $('#formDocumentoNotificacion');
    var data = $documentoNotificacion.serialize() + '&accion=registrar&codCliente=' + $('#codDatoCliente').val();
    var url = $documentoNotificacion.attr('action');
    try {
        $.ajax({
            type: 'post',
            url: url,
            data: data,
            beforeSend: function() {
                $('#dDocumentoNotificacion').dialog('close');
                fProcesandoPeticion('Registrando');
            },
            error: function(XMLHttpRequest, textStatus, errorThrown) {
                $('#lServidorError').text(errorThrown + '()');
                $('#dServidorError').dialog('open');
            },
            success: function(ajaxResponse, textStatus) {
                $('#dProcesandoPeticion').dialog('close');
                if ($.isNumeric(ajaxResponse)) {
                    $('#formDocumentoNotificacion').find('.limpiar').val('');
                    fClienteDocumentoNotificacion(ajaxResponse);
                } else {
                    $('#dDocumentoNotificacion').dialog('open');
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

function fDNEditar() {
    var $documentoNotificacion = $('#formDocumentoNotificacion');
    var data = $documentoNotificacion.serialize() + '&accion=editar&codCliente=' + $('#codDatoCliente').val() + '&codDocumentoNotificacion=' + $('#codDocumentoNotificacionAux').val();
    var url = $documentoNotificacion.attr('action');
    try {
        $.ajax({
            type: 'post',
            url: url,
            data: data,
            beforeSend: function() {
                $('#dDocumentoNotificacion').dialog('close');
                fProcesandoPeticion('Registrando');
            },
            error: function(XMLHttpRequest, textStatus, errorThrown) {
                $('#lServidorError').text(errorThrown + '()');
                $('#dServidorError').dialog('open');
            },
            success: function(ajaxResponse, textStatus) {
                $('#dProcesandoPeticion').dialog('close');
                if ($.isNumeric(ajaxResponse)) {
                    $('#formDocumentoNotificacion').find('.limpiar').val('');
                    fClienteDocumentoNotificacion(ajaxResponse);
                } else {
                    $('#dDocumentoNotificacion').dialog('open');
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

function fDNEliminar() {
    var data = {
        codDocumentoNotificacion: $('#codDocumentoNotificacionAux').val(),
        accion: 'eliminar'
    };
    var url = '../sDocumentoNotificacion';
    try {
        $.ajax({
            type: 'post',
            url: url,
            data: data,
            beforeSend: function() {
                $('#dDocumentoNotificacionBorrarConfirmar').dialog('close');
                fProcesandoPeticion('Borrando');
            },
            error: function(XMLHttpRequest, textStatus, errorThrown) {
                $('#lServidorError').text(errorThrown + '()');
                $('#dServidorError').dialog('open');
            },
            success: function(ajaxResponse, textStatus) {
                $('#dProcesandoPeticion').dialog('close');
                if ($.isNumeric(ajaxResponse)) {
                    $('#trDN' + data.codDocumentoNotificacion).remove();
                } else {
                    $('#dDocumentoNotificacionBorrarConfirmar').dialog('open');
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