/* 
 * To change this template, choose Tools | Templates
 * and open the template in the editor.
 */
$(document).ready(function() {
    $('#dAPAccordion').accordion({
        heightStyle: "content",
        collapsible: true
    });
    $('#bPrimero').click(function(event) {
        fAPLeer(-1, '');
        event.preventDefault();
    });
    $('#bAnterior').click(function(event) {
        fAPLeer(parseInt($('#codArticuloProducto').val(), 10) - 1, 'anterior');
        event.preventDefault();
    });
    $('#bSiguiente').click(function(event) {
        fAPLeer(parseInt($('#codArticuloProducto').val(), 10) + 1, 'siguiente');
        event.preventDefault();
    });
    $('#bUltimo').click(function(event) {
        fAPLeer(0, '');
        event.preventDefault();
    });
    $('#bAPBuscar').click(function(event) {
        $("#dAPBuscar").dialog('open');
        event.preventDefault();
    });
    $('#bNuevo').click(function(event) {
        $(this).attr('href', 'articuloProductoRegistrar.jsp');
//        event.preventDefault();
    });
    $('#bEditar').click(function(event) {
        $(location).attr('href', 'articuloProductoEditar.jsp?codArticuloProducto=' + $('#codArticuloProducto').val());
        event.preventDefault();
    });

    $('#precioNuevo').numeric({negative: false});
    $('#bPrecioVentaModificar').click(function(event) {
        $('#precioNuevo').val('');
        $('#dPrecioVentaModificar').dialog('open');
        event.preventDefault();
    });
    $('#dPrecioVentaModificar').dialog({
        autoOpen: false,
        modal: true,
        resizable: true,
        height: 180,
        width: 340,
        buttons: {
            Modificar: function() {
                precioVentaModificar();
            }, Cancelar: function() {
                $(this).dialog("close");
            }
        },
        close: function() {
            $(this).dialog("close");
        }
    });
    $('#dAPBuscar').dialog({
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
    $('#codArticuloProductoBuscar').numeric({negative: false, decimal: false});
    $('#codArticuloProductoBuscar').keypress(function(e) {
        var key = e.charCode ? e.charCode : e.keyCode ? e.keyCode : 0;
        if (key == 13) {
            if (!isNaN($(this).val()) & $(this).val() > 0) {
                fAPLeer($(this).val(), '');
                $('#codArticuloProductoBuscar').val('').focus();
            }
        }
    });

    $('#descripcionBuscar').autocomplete({
        source: 'autocompletado/articuloProductoDescripcion.jsp',
        minLength: 4,
        select: fAPSeleccionado,
        focus: fAPMarcado
    });
});

function fAPSeleccionado(event, ui) {
    var articuloProducto = ui.item.value;
    $('#descripcionBuscar').val('');
    $('#codArticuloProductoBuscar').val('');
    fAPLeer(articuloProducto.codArticuloProducto, '');
    $('#dAPBuscar').dialog('close');
    event.preventDefault();
}
;

function fAPMarcado(event, ui) {
    var articuloProducto = ui.item.value;
    $('#descripcionBuscar').val(articuloProducto.descripcion);
    $('#codArticuloProductoBuscar').val(articuloProducto.codArticuloProducto);
    event.preventDefault();
}
;

function fAPLeer(codAP, parametro) {
    var data = {codArticuloProducto: codAP, parametro: parametro};
    try {
        $.ajax({
            type: "post",
            url: "ajax/articuloProducto.jsp",
            data: data,
            error: function(XMLHttpRequest, textStatus, errorThrown) {
                $('#dProcesandoPeticion').dialog('close');
                $('#lServidorError').text(errorThrown);
                $('#dServidorError').dialog('open');
            },
            success: function(ajaxResponse, textStatus) {
                var aPArray = procesarRespuesta(ajaxResponse);
                if (aPArray.length == 0) {
                    $('#dProcesandoPeticion').dialog('close');
                    $('#dMensajeAlertaDiv').empty().append('Artículo no encontrado');
                    $('#dMensajeAlerta').dialog('open');
                } else {
                    $('.vaciar').empty();
                    var aPItem = aPArray[0];
                    $("#codArticuloProducto").val(aPItem.codArticuloProducto);
                    $('#lCodArticuloProducto').append(aPItem.codArticuloProducto);
                    $("#lDescripcion").append(aPItem.descripcion);
                    $('#lPrecioVenta').append('S/. ' + aPItem.precioVenta);
                    $('#lPrecioActualAux').append('S/. ' + aPItem.precioVenta);
                    $('#bPrecioVentaModificar').removeAttr('disabled').removeClass('disabled');
                    $("#lCodReferencia").append(aPItem.codReferencia);
                    $("#lUsarSerieNumero").append(aPItem.usarSerieNumero);
                    aPItem.usarSerieNumero == 'HABILITADO' ? ($('#lStock').append('<a href="articuloProductoStock.jsp?codArticuloProducto=' + aPItem.codArticuloProducto + '">' + aPItem.stock + '</a>')) : ($('#lStock').append(aPItem.stock));
                    $("#lReintegroTributario").append(aPItem.reintegroTributario);
                    $("#lFamilia").append(aPItem.familia);
                    $("#lMarca").append(aPItem.marca);
                    $("#lObservacion").append(aPItem.observaciones);
                    $('#lUnidadMedida').append(aPItem.unidadMedida);
                    $("#bEditar").attr("href", "articuloProductoEditar.jsp?codArticuloProducto=" + aPItem.codArticuloProducto);
                    $("#bBorrar").attr("href", "../sArticuloProducto?accionArticuloProducto=d&codArticuloProducto=" + aPItem.codArticuloProducto);
                    $("#codArticuloProductoBuscar").val("");
                    $("#descripcionBuscar").val("");
                    $('#dProcesandoPeticion').dialog('close');
                    fAPIngreso(aPItem.codArticuloProducto);
                    fAPSalida(aPItem.codArticuloProducto);
                }
            },
            statusCode: {
                404: function() {
                    $('#dProcesandoPeticion').dialog('close');
                    $('#lServidorError').text('Página no encontrada(articuloProducto.jsp).');
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

function precioVentaModificar() {
    var data = "codArticuloProducto=" + $('#codArticuloProducto').val() + "&precioVenta=" + $('#precioNuevo').val() + '&accionArticuloProducto=editarPrecioVenta';
    try {
        $.ajax({
            type: "post",
            url: "../sArticuloProducto",
            data: data,
            error: function(XMLHttpRequest, textStatus, errorThrown) {
                $('#dProcesandoPeticion').dialog('close');
                $('#lServidorError').text(errorThrown);
                $('#dServidorError').dialog('open');
            },
            success: function(ajaxResponse, textStatus) {
                $('#dMensajeAlertaDiv').empty();
                if (isNaN(ajaxResponse)) {
                    $('#dMensajeAlertaDiv').append(ajaxResponse);
                    $('#dMensajeAlerta').dialog('open');
                } else {
                    $('#lPrecioVenta').empty().append('S/. ' + $('#precioNuevo').val());
                    $('#lPrecioActualAux').text($('#precioNuevo').val());
                    $('#dPrecioVentaModificar').dialog('close');
                }
            },
            statusCode: {
                404: function() {
                    $('#dProcesandoPeticion').dialog('close');
                    $('#lServidorError').text('Página no encontrada(articuloProducto.jsp).');
                    $('#dServidorError').dialog('open');
                }
            }
        });
    } catch (ex) {
        $('#lErrorServidor').text(ex);
        $('#dErrorServidor').dialog('open');
    }
}
;

function fAPIngreso(codArticuloProducto) {
    try {
        $.ajax({
            type: "post",
            url: "ajax/articuloProductoIngreso.jsp",
            data: {codArticuloProducto: codArticuloProducto},
            error: function(XMLHttpRequest, textStatus, errorThrown) {
                $('#dProcesandoPeticion').dialog('close');
                $('#lServidorError').text(errorThrown);
                $('#dServidorError').dialog('open');
            },
            success: function(ajaxResponse, textStatus) {
                var apIngresoArray = procesarRespuesta(ajaxResponse);
                $('#tbAPCompraResumen').empty();
                if (apIngresoArray.length == 0) {
                    $('#tbAPCompraResumen').append(
                            +'<tr>'
                            + '<td colspan="5" style="color:red;">Artículo sin movimiento</td>'
                            + '</tr>'
                            );
                } else {
                    for (var idx=0; idx < apIngresoArray.length; idx++) {
                        var apIngresoItem = apIngresoArray[idx];
                        $('#tbAPCompraResumen').append(
                                '<tr>' +
                                '<td style=" padding-left:10px;">' + apIngresoItem.fecha + '</td>' +
                                '<td style=" padding-left:10px;"><a href="../sCompra?accionCompra=mantenimiento&codCompra=' + apIngresoItem.codCompra + '">' + apIngresoItem.docSerieNumero + '</a></td>' +
                                '<td style=" padding-left:10px;">' + apIngresoItem.tipo + '</td>' +
                                '<td style="text-align:right; padding-right:10px;">' + apIngresoItem.precioUnitario + '</td>' +
                                '<td style=" padding-left:10px;"><a href="../sProveedor?accionProveedor=mantenimiento&codProveedor=' + apIngresoItem.codProveedor + '">' + apIngresoItem.proveedor + '<a></td>' +
                                '</tr>'
                                );
                    }
                }
            },
            statusCode: {
                404: function() {
                    $('#dProcesandoPeticion').dialog('close');
                    $('#lServidorError').text('Página no encontrada(articuloProductoIngreso.jsp).');
                    $('#dServidorError').dialog('open');
                }
            }
        });
    } catch (ex) {
        $('#lErrorServidor').text(ex);
        $('#dErrorServidor').dialog('open');
    }
}
;

function fAPSalida(codArticuloProducto) {
    try {
        $.ajax({
            type: "post",
            url: "ajax/articuloProductoSalida.jsp",
            data: {codArticuloProducto: codArticuloProducto},
            error: function(XMLHttpRequest, textStatus, errorThrown) {
                $('#dProcesandoPeticion').dialog('close');
                $('#lServidorError').text(errorThrown);
                $('#dServidorError').dialog('open');
            },
            success: function(ajaxResponse, textStatus) {
                var apSalidaArray = procesarRespuesta(ajaxResponse);
                $('#tbAPVentaResumen').empty();
                if (apSalidaArray.length == 0) {
                    $('#tbAPVentaResumen').append(
                            +'<tr>'
                            + '<td colspan="5" style="color:red;">Artículo sin movimiento</td>'
                            + '</tr>'
                            );
                } else {
                    for (var idx=0; idx < apSalidaArray.length; idx++) {
                        var apSalidaItem = apSalidaArray[idx];
                        $('#tbAPVentaResumen').append(
                                '<tr>' +
                                '<td style="padding-left:10px;">' + apSalidaItem.fecha + '</td>' +
                                '<td style="padding-left:10px;"><a href="../sVenta?accionVenta=mantenimiento&codVenta=' + apSalidaItem.codVenta + '">' + apSalidaItem.docSerieNumero + '</a></td>' +
                                '<td style="padding-left:10px;">' + apSalidaItem.tipo + '</td>' +
                                '<td style="text-align:right; padding-right:10px;">' + apSalidaItem.precioVenta + '</td>' +
                                '<td style="padding-left:10px;"><a href="../sDatoCliente?accionDatoCliente=mantenimiento&codPersona=' + apSalidaItem.codPersona + '">' + apSalidaItem.nombresC + '</a></td>' +
                                '</tr>'
                                );
                    }
                }
            },
            statusCode: {
                404: function() {
                    $('#dProcesandoPeticion').dialog('close');
                    $('#lServidorError').text('Página no encontrada(articuloProductoSalida.jsp).');
                    $('#dServidorError').dialog('open');
                }
            }
        });
    } catch (ex) {
        $('#lErrorServidor').text(ex);
        $('#dErrorServidor').dialog('open');
    }
}
;

function fPaginaActual() {
    $('#dProcesandoPeticion').dialog('open');
    fAPLeer(parseInt($('#codArticuloProducto').val(), 10), '');
}
;

