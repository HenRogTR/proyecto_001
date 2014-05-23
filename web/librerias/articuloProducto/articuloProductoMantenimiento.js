/* 
 * To change this template, choose Tools | Templates
 * and open the template in the editor.
 */
$(document).ready(function() {
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

    $('#precioNuevo')
            .mask('0999999999999.99')
            .blur(function(event) {
                //si no esta vacio, se de formato al número ingresado (0.00)
                if (this.value != '') {
                    this.value = fNumeroFormato(this.value, 2, false);
                }
            });

    $('#precioCashNuevo')
            .mask('0999999999999.99')
            .blur(function(event) {
                //si no esta vacio, se de formato al número ingresado (0.00)
                if (this.value != '') {
                    this.value = fNumeroFormato(this.value, 2, false);
                }
            });
    $('#bPrecioVentaModificar').click(function(event) {
        $('#precioNuevo').val('');
        $('#dPrecioVentaModificar').dialog('open');
        event.preventDefault();
    });
    $('#bPrecioCashModificar').click(function(event) {
        $('#precioCashNuevo').val('');
        $('#dPrecioCashModificar').dialog('open');
        event.preventDefault();
    });
    $('#codArticuloProductoBuscar')
            //solo permite números enteros
            .mask('#', {maxlength: false})
            .keyup(function(e) {
                var key = e.charCode ? e.charCode : (e.keyCode ? e.keyCode : 0);
                if (key == 13) {
                    //si existe un número en la entrada se busca cliente
                    if ($.isNumeric(this.value)) {
                        fAPLeer(parseInt(this.value, 10), '');
                        $(this).val('');
                    }
                    e.preventDefault();
                }
            });
    $('#bStock').click(function(event) {
        fKAPSNStock();
        event.preventDefault();
    });
});

//<editor-fold defaultstate="collapsed" desc="$(function() {}). Clic en  + para más detalles.">
$(function() {
    $('#dAPAccordion').accordion({
        heightStyle: "content",
        collapsible: true
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
    $('#dPrecioCashModificar').dialog({
        autoOpen: false,
        modal: true,
        resizable: true,
        height: 180,
        width: 340,
        buttons: {
            Modificar: function() {
                precioCashModificar();
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

    $('#descripcionBuscar').autocomplete({
        source: 'autocompletado/articuloProductoDescripcion.jsp',
        minLength: 4,
        select: fAPSeleccionado,
        focus: fAPMarcado
    });
});
//</editor-fold>

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
                    $('#lPrecioCash').append('S/. ' + aPItem.precioCash);
                    $('#lPrecioCashAux').append('S/. ' + aPItem.precioCash);
                    $('#bPrecioVentaModificar').prop('disabled', false).removeClass('disabled');
                    $('#bPrecioCashModificar').prop('disabled', false).removeClass('disabled');
                    $("#lCodReferencia").append(aPItem.codReferencia);
                    $("#lUsarSerieNumero").append(aPItem.usarSerieNumero);
                    aPItem.usarSerieNumero == 'HABILITADO' ? ($('#bStock').removeClass('disabled').prop('disabled', false)) : ($('#bStock').addClass('disabled').prop('disabled', true));
                    $('#lStock').append(aPItem.stock);
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

function precioCashModificar() {
    var data = {
        codArticuloProducto: $('#codArticuloProducto').val(),
        precioCash: $('#precioCashNuevo').val(),
        accionArticuloProducto: 'editarPrecioCash'
    };
    if (!$.isNumeric(data.precioCash)) {
        fAlerta('Ingrese precio cash.');
        return;
    }
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
                if ($.isNumeric(ajaxResponse)) {
                    $('#lPrecioCash').empty().append('S/. ' + $('#precioCashNuevo').val());
                    $('#lPrecioCashAux').text($('#precioCashNuevo').val());
                    $('#dPrecioCashModificar').dialog('close');
                } else {
                    fAlerta(ajaxResponse);
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
                    for (var idx = 0; idx < apIngresoArray.length; idx++) {
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
                    for (var idx = 0; idx < apSalidaArray.length; idx++) {
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

function fKAPSNStock() {
    if ($('#lUsarSerieNumero').text() == 'DESABILITADO') {
        fAlerta('El artículo no maneja S/N');
        return;
    }
    fDLibreAbrir();
    var data = {codAP: $('#codArticuloProducto').val()};
    var url = 'ajax/ap/ksn.jsp';
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
                fDLibreEditar(500, 900, 'S/N en stock.', ajaxResponse);
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

function fPaginaActual() {
    $('#dProcesandoPeticion').dialog('open');
    fAPLeer(parseInt($('#codArticuloProducto').val(), 10), '');
}
;

