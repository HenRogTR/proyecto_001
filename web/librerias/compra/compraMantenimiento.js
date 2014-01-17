/* 
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */


$(document).ready(function() {

    $('#codCompraBuscar').keyup(function(event) {
        var key = event.charCode ? event.charCode : (event.keyCode ? event.keyCode : 0);
        if (key == 13) {
            if ($.isNumeric(this.value) & this.value > 0) {
                fCompra(this.value, '');
            }
            event.preventDefault();//para el caso de ie se ejecuta como enter al boton y se cerraba el dialog.
        }
    });
    $('#bPrimero').click(function(event) {
        fCompra(-1, '');
        event.preventDefault();
    });
    $('#bAnterior').click(function(event) {
        fCompra(parseInt($('#codCompra').val(), 10) - 1, 'anterior');
        event.preventDefault();
    });
    $('#bSiguiente').click(function(event) {
        fCompra((parseInt($('#codCompra').val(), 10) + 1), 'siguiente');
        event.preventDefault();
    });
    $('#bUltimo').click(function(event) {
        fCompra(0, '');
        event.preventDefault();
    });
});

$(function() {
    $("#docSerieNumeroBuscar").autocomplete({
        source: "autocompletado/compraDocNumeroSerieBuscarAutocompletado.jsp", /* este es el formulario que realiza la busqueda */
        minLength: 4, /* le decimos que espere hasta que haya 2 caracteres escritos */
        select: compraSeleccionado, /* esta es la rutina que extrae la informacion del registro seleccionado */
        focus: compraMarcado
    });
});

function fCompra(codCompra, parametro) {
    var data = {
        codCompra: codCompra,
        parametro: parametro
    };
    var url = 'ajax/compra.jsp';
    try {
        $.ajax({
            type: 'post',
            url: url,
            data: data,
            beforeSend: function() {
                fProcesandoPeticionCerrar();
                $('.vaciar').addClass('esperando');
                var $tbCompraDetalle = $('#tbCompraDetalle');
                $tbCompraDetalle.find('tr').addClass('ocultar');
                $tbCompraDetalle.append(
                        '<tr class="temp">' +
                        '<td class="derecha"><div class="esperando"></div></td>' +
                        '<td class="derecha"><div class="esperando"></div></td>' +
                        '<td class="derecha"><div class="esperando"></div></td>' +
                        '<td class="derecha"><div class="esperando"></div></td>' +
                        '<td><div class="esperando"></div></td>' +
                        '<td class="derecha"><div class="esperando"></div></td>' +
                        '<td class="derecha"><div class="esperando"></div></td>' +
                        '</tr>'
                        );
            },
            error: function(XMLHttpRequest, textStatus, errorThrown) {
                $('#lServidorError').text(errorThrown + '()');
                $('#dServidorError').dialog('open');
            },
            success: function(ajaxResponse, textStatus) {
                var CArray = procesarRespuesta(ajaxResponse);
                var tamanio = CArray.length;
                if (tamanio == 0) {
                    $('.vaciar').removeClass('esperando');
                    var $tbCompraDetalle = $('#tbCompraDetalle');
                    $tbCompraDetalle.find('tr').removeClass('ocultar');
                    $tbCompraDetalle.find('.temp').remove();
                    $('#codCompraBuscar').val('');
                    fAlerta('Código <strong>' + codCompra + '</strong> no encontrado.');
                } else {
                    var CItem = CArray[0];
                    $("#codCompra").val(CItem.codCompra);
                    $('#lCodCompra').empty().append(CItem.codCompra).removeClass('esperando');
                    $("#lDocSerieNumero").empty().append(CItem.docSerieNumero).removeClass('esperando');
                    $("#lFechaFactura").empty().append(CItem.fechaFactura).removeClass('esperando');
                    $("#lTipo").empty().append(CItem.tipo).removeClass('esperando');
                    $("#lFechaFactura").empty().append(CItem.fechaFactura).removeClass('esperando');
                    $("#lFechaVencimiento").empty().append(CItem.fechaVencimiento).removeClass('esperando');
                    $("#lFechaLlegada").empty().append(CItem.fechaLlegada).removeClass('esperando');
                    $("#lSubTotal").empty().append(CItem.subTotal).removeClass('esperando');
                    $("#lDescuento").empty().append(CItem.descuento).removeClass('esperando');
                    $("#lTotal").empty().append(CItem.total).removeClass('esperando');
                    $("#lMontoIgv").empty().append(CItem.montoIgv).removeClass('esperando');
                    $("#lNeto").empty().append(CItem.neto).removeClass('esperando');
                    $("#lSon").empty().append(CItem.son).removeClass('esperando');
                    $("#lMoneda").empty().append(CItem.docSerieNumero).removeClass('esperando');
                    $("#lObservacion").empty().append(CItem.observacion).removeClass('esperando');
                    $("#lRuc").empty().append(CItem.ruc).removeClass('esperando');
                    $("#lRazonSocial").empty().append(CItem.razonSocial).removeClass('esperando');
                    $("#lDireccion").empty().append(CItem.direccion).removeClass('esperando');
                    $("#lRegistro").empty().append(CItem.registro).removeClass('esperando');
                    $("#bImprimir").attr("href", "compraImprimir.jsp?codCompra=" + CItem.codCompra).attr("target", "_imprimir");
                    fCompraDetalle(CItem.codCompra);
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

function fCompraDetalle(codCompra) {
    var data = {codCompra: codCompra};
    var url = 'ajax/compraDetalle.jsp';
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
                $('#tbCompraDetalle').empty().append(ajaxResponse);
                $('#codCompraBuscar').val('');
                $('#docSerieNumeroBuscar').val('');
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

function compraSeleccionado(event, ui) {
    var compra = ui.item.value;
    fCompra(compra.codCompra, '');
    event.preventDefault();
}
;

function compraMarcado(event, ui) {
    var compra = ui.item.value;
    $('#codCompraBuscar').val(compra.codCompra);
    $("#docSerieNumero").val(compra.docSerieNumero);
    event.preventDefault();
}
;

function fPaginaActual() {
    fProcesandoPeticion();
    fCompra(parseInt($('#codCompra').val(), 10), '');
}
;
