/* 
 * To change this template, choose Tools | Templates
 * and open the template in the editor.
 */

$(document).ready(function(event) {
    $("#accordionEmpresaConvenioMantenimiento").accordion({
        heightStyle: "content",
        collapsible: true
    });
    $('#bEditar').click(function(event) {
        $(location).attr('href', 'empresaConvenioEditar.jsp');
        event.preventDefault();
    });
    $('#bEliminar').click(function(event) {
    });
    $('#bPrimero').click(function(event) {
        fLeerEmpresaConvenio(-1, '');
        event.preventDefault();
    });
    $('#bAnterior').click(function(event) {
        var cod = parseInt($('#codEmpresaConvenio').val(), 10) - 1;
        if (cod == 0) {
            return;
        }
        fLeerEmpresaConvenio(cod, 'anterior');
        event.preventDefault();
    });
    $('#bSiguiente').click(function(event) {
        fLeerEmpresaConvenio(parseInt($('#codEmpresaConvenio').val(), 10) + 1, 'siguiente');
        event.preventDefault();
    });
    $('#bUltimo').click(function(event) {
        fLeerEmpresaConvenio(0, '');
        event.preventDefault();
    });
});
function fPaginaActual() {
    $('#dProcesandoPeticion').dialog('open');
    fLeerEmpresaConvenio(parseInt($('#codEmpresaConvenio').val()), '');
}
;

function fLeerEmpresaConvenio(codEmpresaConvenio, parametro) {
    var data = {codEmpresaConvenio: codEmpresaConvenio, parametro: parametro};
    var url = 'ajax/empresaConvenio/empresaConvenioLeer.jsp';
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
                var empresaConvenioArray = procesarRespuesta(ajaxResponse);
                if (empresaConvenioArray.length == 0) {
                    fMensajeAlerta('Empresa no encontrada.');
                } else {
                    $('.vaciar').empty();
                    var empresaConvenioItem = empresaConvenioArray[0];
                    $('#codEmpresaConvenio').val(empresaConvenioItem.codEmpresaConvenio);
                    $('#lcodEmpresaConvenio').append(empresaConvenioItem.codEmpresaConvenio);
                    $('#lNombre').append(empresaConvenioItem.nombre);
                    $('#lAbreviatura').append(empresaConvenioItem.abreviatura);
                    $('#lCodCobranza').append(empresaConvenioItem.codCobranza);
                    fSeriesAsignadas(empresaConvenioItem.codCobranza);
                }
                $('#dProcesandoPeticion').dialog('close');
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
;

function fSeriesAsignadas(codCobranza) {
    var data = {codCobranza: codCobranza};
    var url = 'ajax/empresaConvenio/serieGenerada.jsp';
    try {
        $.ajax({
            type: 'post',
            url: url,
            data: data,
            error: function(XMLHttpRequest, textStatus, errorThrown) {
                $('#lServidorError').text(errorThrown + '()');
                $('#dServidorError').dialog('open');
            },
            success: function(ajaxResponse, textStatus) {
                var serieAsignadaArray = procesarRespuesta(ajaxResponse);
                var cant = serieAsignadaArray.length;
                if (cant == 0) {
                    $('#tSerieNumeroGenerado').append(
                            '<tr>' +
                            '<td colspan="4">NO SE HAN GENERADO PARA ESTA EMPRESA... <a href="../sComprobantePago?accionComprobantePago=generarPrimeraVez&codEmpresaConvenio=' + $('#codEmpresaConvenio').val() + '">GENERAR</a></td>' +
                            '</tr>'
                            );
                } else {
                    for (var idx = 0; idx < cant; idx++) {
                        var serieAsignadaItem = serieAsignadaArray[idx];
                        $('#tSerieNumeroGenerado').append(
                                '<tr>' +
                                '<td class="centrado">' + serieAsignadaItem.codCobranza + '</td>' +
                                '<td class="centrado">' + serieAsignadaItem.serie + '</td>' +
                                '<td class="centrado">' + serieAsignadaItem.ultimoGenerado + '</td>' +
                                '<td class="centrado">' + serieAsignadaItem.ultimoUsado + '</td>' +
                                '</tr>'
                                );
                    }
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
;