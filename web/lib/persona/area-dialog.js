/* 
 * To change this template, choose Tools | Templates
 * and open the template in the editor.
 */
$(function() {
    $("#cancelar").click(function() {
        $("#registroCancelar").dialog("open");
        event.preventDefault();
    });
    $("input,textarea").blur(function() {
        $(this).val($.trim($(this).val().toUpperCase()));
    });
    $("input,textarea").focus(function() {
    });
    $("#registroCancelar").dialog({
        autoOpen: false,
        modal: true,
        resizable: false,
        height: 200,
        width: 400,
        show: {
            effect: "blind",
            duration: 500
        },
        hide: {
            effect: "explode",
            duration: 500
        },
        buttons: {
            Aceptar: function() {
                $("#areaFrm").find(':input').each(function() {
                    $(this).val("");
                });
                $("#codArea").val("Autogenerado");
                $(this).dialog("close");
            },
            Cancelar: function() {
                $(this).dialog("close");
            }
        },
    });
    $("#registroConfirmar").dialog({
        autoOpen: false,
        modal: true,
        resizable: true,
        height: 400,
        width: 380,
        show: {
            effect: "blind",
            duration: 500
        },
//        hide: {
//            effect: "explode",
//            duration: 500
//        },
        buttons: {
            Aceptar: function() {
                var form = $("#areaFrm");
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
                $(this).dialog("close");
            },
            Cancelar: function() {
                $(this).dialog("close");
            }
        },
        close: function() {
            $("#cancelar").removeAttr("disabled").removeClass("disabled");
            $("#restaurar").removeAttr("disabled").removeClass("disabled");
            $("#accion").removeAttr("disabled").removeClass("disabled");
        },
    });
    $("#registroExitoso").dialog({
        autoOpen: false,
        modal: true,
        resizable: false,
        height: 200,
        width: 400,
        show: {
            effect: "blind",
            duration: 500
        },
        buttons: {
            "Nuevo": function() {
                $(this).dialog("close");
            },
            "Listar áreas": function() {

            }

        }
    });
    $("#registroError").dialog({
        autoOpen: false,
        modal: true,
        show: {
            effect: "blind",
            duration: 500
        },
        buttons: {
            "Aceptar": function() {
                $(this).dialog("close");
            },
        },
    });
    $("#registroErrorServidor").dialog({
        autoOpen: false,
        modal: true,
        show: {
            effect: "blind",
            duration: 500
        },
        buttons: {
            "Aceptar": function() {
                $(this).dialog("close");
            },
        },
    });
});


