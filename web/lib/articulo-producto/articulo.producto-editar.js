/* 
 * To change this template, choose Tools | Templates
 * and open the template in the editor.
 */
$(document).ready(function() {
    $(".requerido").append(" *").attr("style", "color: red; font-size: 12px;");
    $("input,textarea").blur(function() {
        $(this).val($(this).val().toUpperCase());
    });
    $("input,textarea").blur(function() {
        $(this).val($.trim($(this).val()));
    });
    $("#serieNumeroInfo").click(function(event) {
        $("#dSerieNumeroInfo").dialog("open");
        event.preventDefault();
    });
    $("#dSerieNumeroInfo").dialog({
        autoOpen: false,
        modal: true,
        resizable: true,
        height: 200,
        width: 400,
        buttons: {
            Cerrar: function() {
                $(this).dialog("close");
            }
        }
    });
    $('#cancelar').click(function(event) {
        $(location).attr('href', 'articuloProductoMantenimiento.jsp?codArticuloProducto=' + $('#codArticuloProducto').val());
        event.preventDefault();
    });
});
$.validator.setDefaults({
    submitHandler: function() {
        $('#trBoton').addClass('ocultar');
        var form = $("#articuloProductoFrm");
        var url = form.attr('action');  //la url del action del formulario
        var datos = form.serialize(); // los datos del formulario
        $.ajax({
            type: 'POST',
            url: url,
            data: datos,
            beforeSend: callback_espera, //funciones que definimos más abajo
            error: callback_error,
            success: callback_articuloProductoEditar  //funciones que definimos más abajo
        });
//                            alert("submitted!");
    },
    showErrors: function(map, list) {
        // there's probably a way to simplify this
        var focussed = document.activeElement;
        if (focussed && $(focussed).is("input, textarea")) {
            $(this.currentForm).tooltip("close", {currentTarget: focussed}, true)
        }
        this.currentElements.removeAttr("title").removeClass("ui-state-highlight");
        $.each(list, function(index, error) {
            $(error.element).attr("title", error.message).addClass("ui-state-highlight");
        });
        if (focussed && $(focussed).is("input, textarea")) {
            $(this.currentForm).tooltip("open", {target: focussed});
        }
    }
});
(function() {
    $("#articuloProductoFrm").tooltip({
        show: false,
        hide: false
    });
    $("#articuloProductoFrm").validate({
        rules: {
            codFamilia: {
                required: true
            },
            codMarca: {
                required: true
            },
            reintegroTributario: {
                required: true
            },
            observaciones: {
                required: false,
                minlength: 10
            }
        },
        messages: {
            codFamilia: {
                required: "Seleccione familia"
            },
            codMarca: {
                required: "Seleccione marca"
            },
            usarSerieNumero: {
                required: "Seleccione si los Artículos se controlan por Serie/Número"
            },
            reintegroTributario: {
                required: "Seleccione si el Artículo tiene reintegro tributario"
            }
        }
    });


})();
function callback_espera() {
    $('#lProcesandoPeticion').text('Editando artículo.<br>');
    $('#dProcesandoPeticion').dialog('open');
}
function callback_error(XMLHttpRequest, textStatus, errorThrown) {
    $('#dProcesandoPeticion').dialog('close');
    $('#dErrorServidor').dialog('open');
    $('#trBoton').removeClass('ocultar');
}

function callback_articuloProductoEditar(ajaxResponse, textStatus) {
    $('#dMensajeAlertaDiv').empty();
    $('#dProcesandoPeticion').dialog('close');
    $('#trBoton').removeClass('ocultar');
    if (isNaN(ajaxResponse)) {
        $('#dMensajeAlertaDiv').append(ajaxResponse);
        $('#dMensajeAlerta').dialog('open');
    } else {
        $('#lProcesandoPeticion').text('Edición exitosa, redireccionando... ');
        $('#dProcesandoPeticion').dialog('open');
        setTimeout(function() {
            $(location).attr('href', '../sArticuloProducto?accionArticuloProducto=mantenimiento&codArticuloProducto=' + ajaxResponse);
        }, 2000);
    }
}
