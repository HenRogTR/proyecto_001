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

$(function() {

});

function fAPLeer(codArticuloProducto) {
    var data = '';
    var url = '';
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
}
;