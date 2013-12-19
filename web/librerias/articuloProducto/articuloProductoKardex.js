/* 
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */

$(document).ready(function() {
    $('#codArticuloProducto')
            .mask('#', {maxlength: false})
            .keypress(function(event) {
                var key = event.charCode ? event.charCode : (event.keyCode ? event.keyCode : 0);
                if (key == 13) {
                    if ($.isNumeric(this.value) & this.value > 0) {
                        fAPLeer(this.value);
                    }
                    event.preventDefault();//para el caso de ie se ejecuta como enter al boton y se cerraba el dialog.
                }
            }); //fin codArticuloProducto
});

/**
 * 
 * @returns {undefined}
 */
$(function() {
    $("#descripcion").autocomplete({
        source: "autocompletado/articuloProductoDescripcionBuscar.jsp", /* este es el formulario que realiza la busqueda */
        minLength: 3, /* le decimos que espere hasta que haya 2 caracteres escritos */
        select: articuloProductoSeleccionado, /* esta es la rutina que extrae la informacion del registro seleccionado */
        focus: articuloProductoMarcado
    });
});

/**
 * 
 * @param {type} codArticuloProducto
 * @returns {undefined}
 */
function fAPLeer(codArticuloProducto) {
    var data = {codArticuloProducto: codArticuloProducto};
    var url = 'ajax/ap.jsp';
    try {
        $.ajax({
            type: 'post',
            url: url,
            data: data,
            beforeSend: function() {
                $('.vaciar').empty().append(fEspererarGif());
                $('#tbArticuloProductoKardex').empty().append(
                        '<tr>' +
                        '<td colspan="9">' + fEspererarGif() + '</td>' +
                        '</tr>'
                        );
            },
            error: function(XMLHttpRequest, textStatus, errorThrown) {
                $('#lServidorError').text(errorThrown + '()');
                $('#dServidorError').dialog('open');
            },
            success: function(ajaxResponse, textStatus) {
                fProcesandoPeticionCerrar();
                var apArray = procesarRespuesta(ajaxResponse);
                if (apArray.length == 0) {
                    $('.vaciar').empty();
                    fAlerta('Código <strong>' + codArticuloProducto + '</strong>  no encontrado.');
                } else {
                    var apItem = apArray[0];
                    $('#codDescripcion').empty().append(apItem.codArticuloProducto + ' / ' + apItem.descripcion);
                    APKardex(apItem.codArticuloProducto);
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
/**
 * 
 * @param {type} codArticuloProducto
 * @returns {undefined}
 */
function APKardex(codArticuloProducto) {
    var data = {
        codArticuloProducto: codArticuloProducto,
        codAlmacen: $('#codAlmacen').val()
    };
    var url = 'ajax/apk.jsp';
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
                $('#tbArticuloProductoKardex').empty().append(ajaxResponse);
                $('#descripcion').val('');
                $('#codArticuloProducto').val('').focus();
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

/**
 * 
 * @param {type} event
 * @param {type} ui
 * @returns {undefined}
 */
function articuloProductoSeleccionado(event, ui) {
    var articuloProducto = ui.item.value;
    $("#codArticuloProducto").val(articuloProducto.codArticuloProducto);
    $("#descripcion").val(articuloProducto.descripcion);
    fAPLeer(articuloProducto.codArticuloProducto);
    event.preventDefault();
}
;


/**
 * Luego de  seleccionar un producto, calculamos el importe correspondiente
 * @param {type} event
 * @param {type} ui
 * @returns {undefined}
 */
function articuloProductoMarcado(event, ui) {
    var articuloProducto = ui.item.value;
    $("#codArticuloProducto").val(articuloProducto.codArticuloProducto);
    $("#descripcion").val(articuloProducto.descripcion);
    event.preventDefault();
}
;

/**
 * 
 * @returns {undefined}
 */
function fPaginaActual() {
    fProcesandoPeticion();
    var $codAP = $("#codArticuloProducto");
    if ($.isNumeric($codAP.val())) {
        fAPLeer($codAP.val());
    } else {
        fProcesandoPeticionCerrar();
    }
}
;