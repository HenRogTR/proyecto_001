/* 
 * To change this template, choose Tools | Templates
 * and open the template in the editor.
 */

$(document).ready(function() {
    $('#codProveedorBuscar').numeric({negative: false, decimal: false});
    $('#codProveedorBuscar').keypress(function(event) {
        if (event.which == 13 & $(this).val() > 0) {
            fProveedor($(this).val());
        }
    });
    fProveedor($('#codProveedorAux').val());
    $("#rucRazonSocialBuscar").autocomplete({
        source: "autocompletado/autocompletarProveedorRucRazonSocialBuscar.jsp", /* este es el formulario que realiza la busqueda */
        minLength: 3, /* le decimos que espere hasta que haya 2 caracteres escritos */
        focus: proveedorMarcado,
        select: proveedorSeleccionado /* esta es la rutina que extrae la informacion del registro seleccionado */
    });
    $("#eliminar").click(function(event) {
        $('#dProveedorEliminarConfirmar').dialog('open');
        event.preventDefault();
    });
    $('#editar').click(function(event) {
        $(location).attr('href', '../sProveedor?accionProveedor=editarVar&codProveedor=' + parseInt($('#codProveedor').val(), 10));
        event.preventDefault();
    });
    $('#bPrimero').click(function(event) {
        fProveedor(-1);
        event.preventDefault();
    });
    $('#bAnterior').click(function(event) {
        if (parseInt($('#codProveedor').val(), 10) - 1 == 0) {
            fProveedor(parseInt($('#codProveedor').val(), 10));
        } else {
            fProveedor(parseInt($('#codProveedor').val(), 10) - 1);
        }
        event.preventDefault();
    });
    $('#bSiguiente').click(function(event) {
        fProveedor(parseInt($('#codProveedor').val(), 10) + 1);
        event.preventDefault();
    });
    $('#bUltimo').click(function(event) {
        fProveedor(0);
        event.preventDefault();
    });

    $('#dProveedorEliminarConfirmar').dialog({
        autoOpen: false,
        modal: true,
        resizable: false,
        height: 160,
        width: 300,
        buttons: {
            Si: function() {
                fEliminar(parseInt($('#codProveedor').val(), 10));
                $(this).dialog("close");
            },
            No: function() {
                $(this).dialog("close");
            }
        },
        close: function() {
            $(this).dialog("close");
        },
    });
});

function proveedorMarcado(event, ui) {
    var proveedor = ui.item.value;
    $("#rucRazonSocialBuscar").val(proveedor.ruc + " " + proveedor.razonSocial);
    event.preventDefault();
}
;

function proveedorSeleccionado(event, ui) {
    var proveedor = ui.item.value;
    fProveedor(proveedor.codProveedor);
    $('#rucRazonSocialBuscar').val('');
    event.preventDefault();
}
;

function fProveedor(codProveedor) {
    $('#codProveedorBuscar').val('');
    var data = 'codProveedor=' + codProveedor;
    $.ajax({
        type: 'post',
        url: 'ajax/proveedor.jsp',
        data: data,
        error: callback_error,
        success: callback_proveedor
    });
}
;

function callback_proveedor(ajaxResponse, textStatus) {
    $('#dMensajeAlertaDiv').empty();
    var proveedorArray = procesarRespuesta(ajaxResponse);
    if (proveedorArray.length == 0) {
        $('#dMensajeAlertaDiv').append('Proveedor no encontrado<br>Se cerrará automaticamente.');
        $('#dMensajeAlerta').dialog('open');
        setTimeout(function() {
            $('#dMensajeAlerta').dialog('close');
        }, 1000);
        $('#codProveedorBuscar').val('').focus();
    } else {
        var proveedorItem = proveedorArray[0];
        $("#codProveedor").val(proveedorItem.codProveedor);
        $('#lCodProveedor').text(proveedorItem.codProveedor);
        $("#lRuc").text(proveedorItem.ruc);
        $("#lRazonSocial").text(proveedorItem.razonSocial);
        $("#lDireccion").text(proveedorItem.direccion);
        $("#lTelefono1").text(proveedorItem.telefono1);
        $("#lTelefono2").text(proveedorItem.telefono2);
        $("#lEmail").text(proveedorItem.email);
        $("#lPaginaWeb").text(proveedorItem.paginaWeb);
        $("#lObservaciones").text(proveedorItem.observaciones);
        if (proveedorItem.registro.substring(0, 1) == 1) {
            $('#trBotones').removeClass('ocultar');
        } else {
            $('#trBotones').addClass('ocultar');
        }

    }
}
;

function procesarRespuesta(ajaxResponse) {
    var response;
    try {
        eval('response=' + ajaxResponse);
    } catch (ex) {
        response = null;
    }
    return response;
}
;

function fEliminar(codProveedor) {
    var data = 'accionProveedor=eliminar' + '&codProveedor=' + codProveedor;
    try {
        $.ajax({
            type: 'post',
            url: '../sProveedor',
            data: data,
            error: callback_error,
            success: callback_proveedorEliminar
        });
    } catch (ex) {
        $('#lErrorServidor').text(ex);
        $('#dErrorServidor').dialog('open');
    }
}
;

function callback_proveedorEliminar(ajaxResponse, textStatus) {
    $('#dMensajeAlertaDiv').empty();
    if (isNaN(ajaxResponse)) {
        $('#dMensajeAlertaDiv').append(ajaxResponse);
        $('#dMensajeAlerta').dialog('open');
    } else {
        $('#trBotones').addClass('ocultar');
        $('#dMensajeAlertaDiv').append('Eliminación exitosa.');
        $('#dMensajeAlerta').dialog('open');
    }
}
;