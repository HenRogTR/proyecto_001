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
        autoOpen: true,
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
});
$.validator.setDefaults({
    submitHandler: function() {
        $("#cancelar").attr("disabled", "disabled").addClass("disabled");
        $("#restaurar").attr("disabled", "disabled").addClass("disabled");
        $("#accion").attr("disabled", "disabled").addClass("disabled");
        var form = $("#articuloProductoFrm");
        var url = form.attr('action');  //la url del action del formulario
        var datos = form.serialize(); // los datos del formulario
        $.ajax({
            type: 'POST',
            url: url,
            data: datos,
            beforeSend: mostrarLoader, //funciones que definimos más abajo
            error: callback_error,
            success: mostrarRespuesta  //funciones que definimos más abajo
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
    // utilizar información sobre herramientas personalizada, 
    // desactivar las animaciones de momento de solucionar la falta 
    // de método de actualización de información sobre herramientas.
    $("#articuloProductoFrm").tooltip({
        show: false,
        hide: false
    });
    //para mostrar los mensajes de los errores,

    // validar el formulario de comentarios cuando se presenten.
    //                $("#commentForm").validate();

    // validar registrarse en forma soltar tecla y enviar
    $("#articuloProductoFrm").validate({
        rules: {
            descripcion: {
                required: true,
                minlength: 5,
                remote: "articuloProductoVerificar.jsp"
            },
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
            descripcion: {
                remote: 'Ya se encuetra registrado el <b>Artículo</b>.',
            },
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
function mostrarLoader() {
    $('#loader_gif').fadeIn("slow");
    $('#men').fadeIn("slow");
}
;
function callback_error(XMLHttpRequest, textStatus, errorThrown) {
//                        alert(errorThrown);
    $("#loader_gif").fadeOut("slow");
    $("#men").fadeOut("slow");
    $("#mensaje").text("Error en el servidor, contacte al administrador");
    $("#basic-modal-content").modal();
}
;
function mostrarRespuesta(respuesta, textStatus) {
    $("#loader_gif").fadeOut("slow");
    $("#men").fadeOut("slow");
    $("#descripcion").val("");
    $("#cancelar").removeAttr("disabled").removeClass("disabled");
    $("#restaurar").removeAttr("disabled").removeClass("disabled");
    $("#accion").removeAttr("disabled").removeClass("disabled");
//                        if (respuesta.estado == "1") {
//                            $("#mensaje").text(respuesta.mensaje);
//                            $("#basic-modal-content").modal();
//                        }
//                        else {
//                            $("#mensaje").text("Falló el registro");
//                            $("#basic-modal-content").modal();
//                        }
    var mensajes = procesarRespuesta(respuesta);
    for (var idx=0; idx < mensajes.length; idx++) {
        var deta = mensajes[idx];
        $("#mensaje").text(deta.mensaje);
    }

    $("#basic-modal-content").modal();
}
function procesarRespuesta(ajaxResponse) {
    var response;
    try {
        eval('response=' + ajaxResponse);
    } catch (ex) {
        response = null;
    }

    return response;
}

