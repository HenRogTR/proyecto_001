/* 
 * To change this template, choose Tools | Templates
 * and open the template in the editor.
 */

$().ready(function() {
    $("input,textarea").blur(function() {
        $(this).val($.trim($(this).val().toUpperCase()));
    });
    //i validacion
    $.validator.setDefaults({
        submitHandler: function() {
            var form = $("#formProveedor");
            var url = form.attr('action');
            var datos = form.serialize();
            try {
                $.ajax({
                    type: 'POST',
                    url: url,
                    data: datos,
                    beforeSend: callback_espera,
                    error: callback_error_,
                    success: callback_proveedorRegistrar
                });
            } catch (ex) {
                $('#trBotones').removeClass('ocultar');
                $('#lErrorServidor').text(ex);
                $('#dErrorServidor').dialog('open');
            }
        },
        showErrors: function(map, list) {
            var focussed = document.activeElement;
            if (focussed && $(focussed).is("input, textarea")) {
                $(this.currentForm).tooltip("close", {currentTarget: focussed}, true);
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
    $("#formProveedor").tooltip({
        show: false,
        hide: false
    });
    $("#formProveedor").validate({
        rules: {
            ruc: {
                required: true,
                number: true,
                minlength: 11,
                maxlength: 11,
                remote: "validacion/proveedorRucVerificar.jsp"
            },
            razonSocial: {
                required: true,
                minlength: 4,
                remote: "validacion/proveedorRazonSocialVerificar.jsp",
            },
            direccion: {
                required: true,
                minlength: 8,
            },
            telefono1: {
                minlength: 6,
            },
            telefono2: {
                minlength: 9,
            },
            email: {
                email: true,
            },
            paginaWeb: {
                url: true,
            }
        },
        messages: {
            ruc: {
                number: "Escriba solo numeros",
                remote: jQuery.format("El N° de <b>RUC: {0}</b> ya se encuentra registrado."),
            },
            razonSocial: {
                remote: jQuery.format('<b>{0}</b> se encuentra registrado.'),
            },
        }
    });
    //    f validacion
});

function callback_espera() {
    $('#trBotones').addClass('ocultar');
    $('#lProcesandoPeticion').text('Registrando proveedor.');
    $('#dProcesandoPeticion').dialog('open');
}
;

function callback_error_(XMLHttpRequest, textStatus, errorThrown) {
    $('#trBotones').removeClass('ocultar');
    $('#dProcesandoPeticion').dialog('close');
    $('#lErrorServidor').text(errorThrown);
    $('#dErrorServidor').dialog('open');
}
;

function callback_proveedorRegistrar(ajaxResponse, textStatus) {
    $('#trBotones').removeClass('ocultar');
    $('#dMensajeAlertaDiv').empty();
    $('#dProcesandoPeticion').dialog('close');
    if (isNaN(ajaxResponse)) {
        $('#dMensajeAlertaDiv').append(ajaxResponse);
        $('#dMensajeAlerta').dialog('open');
    } else {
        $('#lProcesandoPeticion').text('Registro exitoso, redireccionando... ');
        $('#dProcesandoPeticion').dialog('open');
        setTimeout(function() {
            $(location).attr('href', '../sProveedor?codArticuloProducto=' + ajaxResponse);
        }, 2000);
    }
}
;
