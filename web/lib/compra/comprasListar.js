/* 
 * To change this template, choose Tools | Templates
 * and open the template in the editor.
 */


$(document).ready(function() {
    $("#codCompraBuscar").focus();
    $('#codCompraBuscar').numeric({negative: false, decimal: false});
    $('#codCompraBuscar').keypress(function(event) {
        if (event.which == 13 & $(this).val() > 0) {
            fCompra($(this).val());
            $(this).val('');
        }
    });
    // configuramos el control para realizar la busqueda de los productos
    $("#compraDocNumeroSerieBuscar").autocomplete({
        source: "autocompletado/compraDocNumeroSerieBuscarAutocompletado.jsp", /* este es el formulario que realiza la busqueda */
        minLength: 4, /* le decimos que espere hasta que haya 2 caracteres escritos */
        select: compraSeleccionado, /* esta es la rutina que extrae la informacion del registro seleccionado */
        focus: compraMarcado
    });
    if ($('#codCompraBuscarAux').val() == 0) {
        fCompra(0);
    } else {
        fCompra(parseInt($('#codCompraBuscarAux').val()));
    }

    $('#bPrimero').click(function(event) {
        fCompra(-1);
        event.preventDefault();
    });
    $('#bAnterior').click(function(event) {
        fCompra(parseInt($('#codCompra').val(), 10) - 1);
        event.preventDefault();
    });
    $('#bSiguiente').click(function(event) {
        fCompra((parseInt($('#codCompra').val(), 10) + 1));
        event.preventDefault();
    });
    $('#bUltimo').click(function(event) {
        fCompra(0);
        event.preventDefault();
    });

});
function compraSeleccionado(event, ui) {
    var compra = ui.item.value;
    fCompra(compra.codCompra);
//    $("#codCompra").val(compra.codCompra);
//    $('#lCodCompra').text(compra.codCompra);
//    $("#lDocSerieNumero").text(compra.docSerieNumero);
//    $("#lFechaFactura").text(compra.fechaFactura);
//    $("#lTipo").text(compra.tipo);
//    $("#lFechaFactura").text(compra.fechaFactura);
//    $("#lFechaVencimiento").text(compra.fechaVencimiento);
//    $("#lFechaLlegada").text(compra.fechaLlegada);
//    $("#lSubTotal").text(compra.subTotal);
//    $("#lTotal").text(compra.total);
//    $("#lMontoIgv").text(compra.montoIgv);
//    $("#lNeto").text(compra.neto);
//    $("#lSon").text(compra.son);
//    $("#lMoneda").text(compra.moneda);
//    $("#lObservacion").text("");
//    $("#lObservacion").append(compra.observacion.replace(/\n/gi, "<br>"));
//    $("#lRuc").text(compra.ruc);
//    $("#lRazonSocial").text(compra.razonSocial);
//    $("#lDireccion").text(compra.direccion);
//    $("#compraDocNumeroSerieBuscar").val("");
//    $("#imprimir").attr("href", "compraImprimir.jsp?codCompra=" + compra.codCompra).attr("target", "_imprimir");
//    $("#compraDocNumeroSerieBuscar").focus();
//    compraDetalleRecuperar(compra.codCompra);
//    $("#tCompraListar").attr("style","width: 100%;display:block");
    event.preventDefault();
}
;

function compraMarcado(event, ui) {
    var compra = ui.item.value;
    $("#compraDocNumeroSerieBuscar").val(compra.docSerieNumero);
    event.preventDefault();
}
;

function fCompra(codCompra) {
    var data = 'codCompra=' + codCompra;
    try {
        $.ajax({
            type: 'post',
            url: 'ajax/compra.jsp',
            data: data,
            error: callback_error,
            success: callback_compra
        });
    } catch (ex) {
        $('#lErrorServidor').text(ex);
        $('#dErrorServidor').dialog('open');
    }
}
;

function callback_compra(ajaxResponse, textStatus) {
    $('#dMensajeAlertaDiv').empty();
    var compraProcesada = procesarRespuesta(ajaxResponse);
    if (compraProcesada.length == 0) {
        $('#dMensajeAlertaDiv').append('Compra no encontrada.<br>');
        $('#dMensajeAlerta').dialog('open');
    } else {
        var compraItem = compraProcesada[0];
        $("#codCompra").val(compraItem.codCompra);
        $('#lCodCompra').text(compraItem.codCompra);
        $("#lDocSerieNumero").text(compraItem.docSerieNumero);
        $("#lFechaFactura").text(compraItem.fechaFactura);
        $("#lTipo").text(compraItem.tipo);
        $("#lFechaFactura").text(compraItem.fechaFactura);
        $("#lFechaVencimiento").text(compraItem.fechaVencimiento);
        $("#lFechaLlegada").text(compraItem.fechaLlegada);
        $("#lSubTotal").text(compraItem.subTotal);
        $("#lTotal").text(compraItem.total);
        $("#lMontoIgv").text(compraItem.montoIgv);
        $("#lNeto").text(compraItem.neto);
        $("#lSon").text(compraItem.son);
        $("#lMoneda").text(compraItem.moneda);
        $("#lObservacion").text("");
        $("#lObservacion").append(compraItem.observacion.replace(/\n/gi, "<br>"));
        $("#lRuc").text(compraItem.ruc);
        $("#lRazonSocial").text(compraItem.razonSocial);
        $("#lDireccion").text(compraItem.direccion);
        $("#compraDocNumeroSerieBuscar").val("");
        $("#imprimir").attr("href", "compraImprimir.jsp?codCompra=" + compraItem.codCompra).attr("target", "_imprimir");
        compraDetalleRecuperar(compraItem.codCompra);
    }
}

function compraDetalleRecuperar(codCompra) {
    try {
        var data = "codCompra=" + codCompra;
        $.ajax({
            type: "post",
            url: "ajax/compraDetalleBuscarAjax.jsp",
            data: data,
            error: callback_error,
            success: compraDetalleRecuperar_callback
        });
    }
    catch (ex) {
        alert(ex.description);
    }
}
//function callback_error(XMLHttpRequest, textStatus, errorThrown) {
//    alert("Error en consulta ajax: " + errorThrown);
//}
function compraDetalleRecuperar_callback(ajaxResponse, textStatus) {
    var compraDetalles = procesarRespuesta(ajaxResponse);
    var $tCompraDetalles = $("#tCompraDetalles");
    $tCompraDetalles.find("tr").remove();
    if (!compraDetalles) {
        $tCompraDetalles.append(
                "<tr>" +
                "<td colspan='6'>¡No hay ningun articulo para la compra!</td>" +
                "</tr>");
        return;
    }
    var compraDetalle;
    for (var idx = 0; idx < compraDetalles.length; idx++) {
        compraDetalle = compraDetalles[idx];
        $tCompraDetalles.append(
                "<tr>" +
                "<td style='text-align: right;'><label>" + compraDetalle.item + "</label></td>" +
                "<td style='text-align: right;'><label>" + compraDetalle.cantidad + "</label></td>" +
                "<td style='text-align: right;'><label>" + compraDetalle.unidadMedida + "</label></td>" +
                "<td><label>" + compraDetalle.descripcion + "</label></td>" +
//                "<td><label>" + "compraDetalle descripcion" + "</label></td>" +
                "<td style='text-align: right'><label>" + compraDetalle.precioUnitario + "</label></td>" +
                "<td style='text-align: right'><label>" + compraDetalle.precioTotal + "</label></td>"
                );
    }
}
function procesarRespuesta(ajaxResponse) {
    var response;
    try {
        eval('response=' + ajaxResponse);
    } catch (ex) {
        alert("Error proceso respuesta: " + ex);
        response = null;
    }
    return response;
}