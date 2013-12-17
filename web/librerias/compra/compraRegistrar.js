/* 
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */

$(document).ready(function() {
    var $docSerieNumero = $('#docSerieNumero');
    $docSerieNumero
            .mask('S-000-000000999'); //fin #docSerieNumero
    var $fechaFactura = $('#fechaFactura');
    var $fechaLlegada = $('#fechaLlegada');
    var $fechaVencimiento = $('#fechaVencimiento');
    $fechaFactura
            .mask('00/00/0000')
            .blur(function() {
                if (!fValidarFecha(this.value)) {
                    this.value = '';
                }
            })
            ; //fin #fechaFactura
    $fechaLlegada
            .mask('00/00/0000')
            .blur(function() {
                if (!fValidarFecha(this.value)) {
                    this.value = '';
                }
            }); //fin #fechaLlegada
    $fechaVencimiento
            .mask('00/00/0000')
            .blur(function() {
                if (!fValidarFecha(this.value)) {
                    this.value = '';
                }
            }); //fin #fechaVencimiento
    $('#codArticuloProducto')
            .mask('#', {maxlength: false})
            .keypress(function(event) {
                var key = event.charCode ? event.charCode : (event.keyCode ? event.keyCode : 0);
                if (key == 13) {
                    if ($.isNumeric(this.value) & this.value > 0) {
                        fAPLeer(this.value);
                    }
                    event.preventDefault();
                }
            })
            .keyup(function(event) {

            }); //fin codArticuloProducto

    $('#cantidad')
            .mask('#', {maxlength: false})
            .blur(function() {
                if (this.value == '' || this.value == '0') {
                    this.value = '1';
                }
            })
            .keyup(function(event) {
                if (fSerieNumeroEstado()) {
                    fSerieNumeroDeshabilitarCampo();
                    fSerieNumeroHabilitarCampo();
                }
            })
            ;
    $('#precioUnitario')
            .mask('0999999999999.9999')
            .blur(function(event) {
                if (this.value != '') {
                    this.value = fNumeroFormato(this.value, 4, false);
                }
            });
    $('#serieNumero').click(function(event) {
        event.preventDefault();
    });
}); //fin $(ready)

$(function() {
    var $fechaFactura = $('#fechaFactura');
    var $fechaLlegada = $('#fechaLlegada');
    var $fechaVencimiento = $('#fechaVencimiento');
    $fechaFactura
            .datepicker({
                defaultDate: '-1m', changeMonth: true, changeYear: true, numberOfMonths: 3,
                onClose: function(selectedDate) {
                    if (fValidarFecha(selectedDate)) {
                        $fechaLlegada.datepicker('option', 'minDate', selectedDate);
                        $fechaLlegada.val(selectedDate);
                        var unMesMas = fSumarMes(fStringADate(selectedDate), 1);
                        $fechaVencimiento.datepicker('option', 'minDate', selectedDate);
                        $fechaVencimiento.val(fDateAString(unMesMas));
                    } else {
                        $fechaFactura.val('');
                        $fechaLlegada.val('');
                        $fechaLlegada.datepicker('option', 'minDate', null);
                        $fechaVencimiento.val('');
                        $fechaVencimiento.datepicker('option', 'minDate', null);
                    }
                }
            });
    $fechaLlegada
            .datepicker({
                defaultDate: '-1m', changeMonth: true, changeYear: true, numberOfMonths: 3
            });
    $fechaVencimiento
            .datepicker({
                defaultDate: '-1m', changeMonth: true, changeYear: true, numberOfMonths: 3
            });
    //---------------botones----------------------------------------------------
    $('#bProveedorBuscar').click(function(event) {
        $('#dProveedorBuscar').dialog('open');
        event.preventDefault();
    });
    $('#bArticuloProductoAgregar').click(function(event) {
        $("#lItem").text(parseInt($("#itemCantidad").val(), 10) + 1);
        $('#bDAPEditar').prop('disabled', true).addClass('ui-state-disabled');
        $('#bDAPAgregar').prop('disabled', false).removeClass('ui-state-disabled');
        $('#bDAPLimpiar').prop('disabled', false).removeClass('ui-state-disabled');
        $('#dArticuloProductoAgregar').dialog('open');
        event.preventDefault();
    });
    $('#bRegistrar').click(function(event) {
        if (fCompraRegistrarValidar()) {
            $('#trBoton').addClass('ocultar');
            fCompraRegistrar();
        }
        event.preventDefault();
    });
    //------------------dialog's------------------------------------------------
    $("#dProveedorBuscar").dialog({
        autoOpen: false,
        modal: true,
        resizable: true,
        height: 80,
        width: 800
    });
    $('#dArticuloProductoAgregar').dialog({
        autoOpen: false,
        modal: true,
        resizable: true,
        height: 600,
        width: 1100,
        buttons: [
            {
                id: "bDAPLimpiar",
                text: "Limpiar",
                click: function() {
                    fArticuloProductoAgregarReiniciar();
                }
            },
            {
                id: "bDAPAgregar",
                text: "Agregar",
                click: function() {
                    if (fArticuloProductoAgregarModificarValidar()) {
                        fArticuloProductoAgregar();
                    }
                }
            },
            {
                id: "bDAPEditar",
                text: "Editar",
                click: function() {
                    if (fArticuloProductoAgregarModificarValidar()) {

                    }
                }
            }
        ]
    });
    $("#dItemAccionDobleClic").dialog({
        autoOpen: false,
        modal: true,
        resizable: true,
        height: 250,
        width: 600,
        buttons: {
            Editar: function() {
                fArticuloProductoEditarPreparar();
            },
            Eliminar: function() {
                fAlerta('Función en desarrollo');
            },
            Cerrar: function() {
                $(this).dialog('close');
            }
        },
        close: function() {
            fArticuloProductoAgregarReiniciar();
        }
    });
    //--------------autocompletes-----------------------------------------------
    $('#proveedorBuscar').autocomplete({
        source: "autocompletado/proveedor.jsp",
        minLength: 2,
        select: proveedorSeleccionado,
        focus: proveedorMarcado
    });
    $('#descripcion').autocomplete({
        source: "autocompletado/articuloProductoDescripcionBuscarAutocompletado.jsp",
        minLength: 4,
        select: articuloProductoSeleccionado,
        focus: articuloProductoMarcado
    });
//    $('.ocultar').removeClass('ocultar');
});
function proveedorSeleccionado(event, ui) {
    var proveedor = ui.item.value;
    $('#codProveedor').val(proveedor.codProveedor);
    $('#lProveedorRuc').text(proveedor.ruc);
    $('#lProveedorRazonSocial').text(proveedor.razonSocial);
    $('#lProveedorDireccion').text(proveedor.direccion);
    $('#proveedorBuscar').val('');
    $('#dProveedorBuscar').dialog('close');
    event.preventDefault();
}
;
function proveedorMarcado(event, ui) {
    var proveedor = ui.item.value;
    $("#proveedorBuscar").val(proveedor.ruc + " " + proveedor.razonSocial);
    event.preventDefault();
}
;
function articuloProductoMarcado(event, ui) {
    var articuloProducto = ui.item.value;
    $("#descripcion").val(articuloProducto.descripcion);
    $('#codArticuloProducto').val(articuloProducto.codArticuloProducto);
    event.preventDefault();
}
;
function articuloProductoSeleccionado(event, ui) {
    var articuloProducto = ui.item.value;
    fAPLeer(articuloProducto.codArticuloProducto);
    event.preventDefault();
}
;
function fCompraRegistrarValidar() {
    var estado = true;
    var mensaje = "<strong>ERROR(ES) EN REGISTRO DE COMPRA</strong><br>";
    var $docSerieNumero = $('#docSerieNumero');
    if (!$docSerieNumero.length || $docSerieNumero.val().length < 12) {
        mensaje += '*Formato de Documento incorrecto (<strong>F-123-456789</strong>)<br>';
        estado = false;
    }
    if ($('#tipo').val() == '') {
        mensaje += '*Seleccione tipo de venta<br>';
        estado = false;
    }
    if ($('#moneda').val() == '') {
        mensaje += '*Seleccione moneda.<br>';
        estado = false;
    }
    var $codProveedor = $('#codProveedor');
    if (!$codProveedor.length || $codProveedor.val() == '') {
        mensaje += '*Seleccione proveedor.<br>';
        estado = false;
    }
    var $fechaFactura = $('#fechaFactura');
    if (!$fechaFactura.length || $fechaFactura.val().length < 10 || !fValidarFecha($fechaFactura.val())) {
        mensaje += '*Formato de <strong>fecha de factura</strong> incorrecta (<strong>dd/mm/yyyy</strong>)<br>';
        estado = false;
    }
    var $fechaLlegada = $('#fechaLlegada');
    if (!$fechaLlegada.length || $fechaLlegada.val().length < 10 || !fValidarFecha($fechaLlegada.val())) {
        mensaje += '*Formato de <strong>fecha de llegada</strong> incorrecta (<strong>dd/mm/yyyy</strong>)<br>';
        estado = false;
    }
    var $fechaVencimiento = $('#fechaVencimiento');
    if (!$fechaVencimiento.length || $fechaVencimiento.val().length < 10 || !fValidarFecha($fechaVencimiento.val())) {
        mensaje += '*Formato de <strong>fecha de vencimiento</strong> incorrecta (<strong>dd/mm/yyyy</strong>)<br>';
        estado = false;
    }
    var $cantidad = $("#itemCantidad");
    if (!$cantidad.length || $cantidad.val() <= 0) {
        mensaje += '*Tiene que seleccionar al menos un artículo para registrar la compra.<br>';
        estado = false;
    }
    if (!estado) {
        fAlerta(mensaje);
    }
    return estado;
}
;
function fAPLeer(codArticuloProducto) {
    var data = {codArticuloProducto: codArticuloProducto};
    var url = 'ajax/articuloProductoLeer.jsp';
    try {
        $.ajax({
            type: 'post',
            url: url,
            data: data,
            error: function(XMLHttpRequest, textStatus, errorThrown) {
                $('#lServidorError').text(errorThrown + '()');
                $('#dServidorError').dialog('open');
            },
            success: function(ajaxResponse, textStatus) {
                fArticuloProductoAgregarReiniciar();
                var APArray = procesarRespuesta(ajaxResponse);
                if (APArray.length == 0) {
                    fAlerta('Artículo no encontrado');
                } else {
                    var APItem = APArray[0];
                    $("#codArticuloProducto").val(parseInt(APItem.codArticuloProducto, 10));
                    $("#descripcion").val(APItem.descripcion);
                    $("#lUnidadMedida").text(APItem.unidadMedida);
                    $('#serieNumero').prop('checked', APItem.usarSerieNumero ? 'checked' : '');
                    if (APItem.usarSerieNumero) {
                        fSerieNumeroDeshabilitarCampo();
                        fSerieNumeroHabilitarCampo();
                    }
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
function fSerieNumeroHabilitarCampo() {
    $('#dSerieNumero').removeClass('ocultar');
    var $cantidad = $('#cantidad');
    if ($.isNumeric($cantidad.val())) {
        if ($cantidad.val() >= 0 && $cantidad.val() <= 50) {
            for (var i = 1; i <= $('#cantidad').val(); i++) {
                $('#trSerieNumero' + i).removeClass('ocultar');
            }
        } else {
            $cantidad.val('50');
            $('#tSerieNumero').find('tr').removeClass('ocultar');
            fAlerta('No se puede registrar mas de 50 artículos con S/N, se colocará por defecto 50.');
        }
    }
}
;
function fSerieNumeroDeshabilitarCampo() {
    $('#dSerieNumero').addClass('ocultar');
    $('#tSerieNumero').find('tr').addClass('ocultar');
}
;
function fSerieNumeroEstado() {
    var estado = false;
    if ($("#serieNumero").is(":checked")) {
        estado = true;
    }
    return estado;
}
;
/**
 * Valida que antes de agregar/modificar todos los datos esten correctamente.
 * @returns {Boolean}
 */
function fArticuloProductoAgregarModificarValidar() {
    var estado = true;
    var mensaje = "<strong>CORRIGA EL(LOS ) SIGUIENTE(S) ERROR(ES)</strong><br>";
    var $codigo = $('#codArticuloProducto');
    if (!$codigo.length || $codigo.val() <= 0 || $codigo.val() == '') {
        mensaje += '*No hay código de producto agregado.<br>';
        estado = false;
    }
    var $cantidad = $('#cantidad');
    if (!$cantidad.length || $cantidad.val() < 1 || $cantidad.val() == '') {
        mensaje += '*Mínimo un artículo.<br>';
        estado = false;
    }
    var $descripcion = $('#descripcion');
    if (!$descripcion.length || $descripcion.val() < 1 || $descripcion.val() == '') {
        mensaje += '*Descripción de articulo esta vacio, corregir.<br>';
        estado = false;
    }
    var $precioUnitario = $('#precioUnitario');
    if (!$precioUnitario.length || !$.isNumeric($precioUnitario.val())) {
        mensaje += '*Ingrese precio de compra.<br>';
        estado = false;
    }
    if (fSerieNumeroEstado()) {
        for (var i = 1; i <= $cantidad.val(); i++) {
            var serieNumero = $("#serieNumero" + i);
            if (serieNumero.val() == null || serieNumero.val() == "" || $.trim(serieNumero.val()) == "") {
                mensaje += '*Ingrese S/N ' + i + '<br>'
                estado = false;
            }
        }
    }
    if (!estado) {
        fAlerta(mensaje);
    }
    return estado;
}
;
function fArticuloProductoAgregar() {
    var $item = $('#lItem'); //$item=numero de item que ademas será nuestro id
    var $cantidad = $('#cantidad'); //$cantidad=cantidad comprada de articulo
    var $codArticuloProducto = $('#codArticuloProducto'); //
    var $descripcion = $('#descripcion');
    var $unidadMedida = $('#lUnidadMedida');
    var $precioUnitario = $('#precioUnitario');
    $('#tbArticuloProducto').append(
            '<tr id="trArticuloProducto' + $item.text() + '">' +
            '<td class="derecha"><span id="lItem' + $item.text() + '" class="vaciar">' + $item.text() + '</span></td>' +
            '<td class="derecha">' +
            '<input type="text" name="cantidad' + $item.text() + '" id="cantidad' + $item.text() + '" value="' + parseInt($cantidad.val(), 10) + '" class="limpiar ocultar" />' +
            '<span id="lCantidad' + $item.text() + '" class="vaciar">' + parseInt($cantidad.val(), 10) + '</span>' +
            '</td>' +
            '<td class="derecha">' +
            '<input type="text" name="codArticuloProducto' + $item.text() + '" id="codArticuloProducto' + $item.text() + '" value="' + $codArticuloProducto.val() + '" class="limpiar ocultar" />' +
            '<span id="lCodArticuloProducto' + $item.text() + '" class="vaciar">' + $codArticuloProducto.val() + '</span>' +
            '</td>' +
            '<td class="derecha">' +
            '<span id="lUnidad' + $item.text() + '" class="vaciar">' + $unidadMedida.text() + '</span>' +
            '</td>' +
            '<td class="izquierda">' +
            '<span id="lDescripcion' + $item.text() + '" class="vaciar">' + $descripcion.val() + '</span>' +
            '<div id="dSerieNumeroMostrar' + $item.text() + '" style="padding-left: 15px;">' +
            '</div>' +
            '<div id="dSerieNumero' + $item.text() + '">' +
            '</div>' +
            '</td>' +
            '<td class="derecha">' +
            '<input type="text" name="precioUnitario' + $item.text() + '" id="precioUnitario' + $item.text() + '" value="' + fNumeroFormato(parseFloat($precioUnitario.val()), 4, false) + '" class="limpiar ocultar" />' +
            '<span id="lPrecioUnitario' + $item.text() + '" class="vaciar">' + fNumeroFormato(parseFloat($precioUnitario.val()), 4, false) + '</span>' +
            '</td>' +
            '<td class="derecha">' +
            '<input type="text" name="precioTotal' + $item.text() + '" id="precioTotal' + $item.text() + '" value="' + fNumeroFormato(parseFloat($precioUnitario.val()) * parseInt($cantidad.val(), 10), 2, false) + '" class="limpiar ocultar"/>' +
            '<span id="lPrecioTotal' + $item.text() + '" class="vaciar">' + fNumeroFormato(parseFloat($precioUnitario.val()) * parseInt($cantidad.val(), 10), 2, false) + '</span>' +
            '</td>' +
            '</tr>'
            );
    if (fSerieNumeroEstado()) {//si en caso es por serie el número
        for (var i = 1; i <= parseInt($cantidad.val(), 10); i++) {
            $('#dSerieNumeroMostrar' + $item.text()).append(
                    $('#serieNumero' + i).val() + '<br>'
                    );
            $('#dSerieNumero' + $item.text()).append(
                    '<textarea id="item' + $item.text() + 'SerieNumero' + i + '" name="item' + $item.text() + 'SerieNumero' + i + '" class="limpiar mayuscula ocultar">' + $('#serieNumero' + i).val() + '</textarea>' +
                    '<textarea id="item' + $item.text() + 'SerieNumeroObservacion' + i + '" name="item' + $item.text() + 'SerieNumeroObservacion' + i + '" class="limpiar mayuscula ocultar">' + $('#serieNumeroObservacion' + i).val() + '</textarea>'
                    );
        }
    }
    //procedemos a reiniciar 
    $('#itemCantidad').val(parseInt($item.text(), 10));
    var item = $item.text();
    fArticuloProductoAgregarReiniciar();//aqui se actualiza todo
    $codArticuloProducto.focus();
    //calculamos los importes
    //calculando subtotal
    //    var subTotal = ;
    $('#lSubTotal').text(fNumeroFormato(fSubTotalCalcular(), 2, false));
    $('#lTotal').text(fNumeroFormato(fTotalCalcular(), 2, false)); //asignamos total
    $('#lNeto').text(fNumeroFormato(fNetoCalcular(), 2, false)); //asignamos neto
    //asignamos los eventos
    $('#lDescripcion' + item).bind('dblclick', function(event) {
        var temp = $(this).attr('id');
        var item = temp.substring(temp.length - 1, temp.length);
        $('#itemCantidadAux').val(item);
        $('#lItemMostrar').text(item);
        $('#lDescripcionMostrar').text($('#' + temp).text());
        $('#dItemAccionDobleClic')
                .dialog({title: 'Item ' + item})
                .dialog('open');
    });
}
;
function fSubTotalCalcular() {
    var itemCantidad = parseInt($('#itemCantidad').val(), 10);
    var subTotal = 0.00;
    for (var i = 1; i <= itemCantidad; i++) {
        subTotal = parseFloat(subTotal) + parseFloat($("#precioTotal" + i).val());
    }
    return subTotal;
}
;
function fTotalCalcular() {
    var total = 0.00;
    var $descuento = $('#descuento');
    var $subTotal = $('#lSubTotal');
    if ($descuento.val() == "" || $descuento.val() == null) {
        $descuento.val("0.00");
    }
    if ($subTotal.text() == "" || $subTotal.text() == null) {
        total = -parseFloat($descuento.val());
    } else {
        total = parseFloat($subTotal.text()) - parseFloat($descuento.val());
    }
    return total;
}
;
function fNetoCalcular() {
    return parseFloat($("#lTotal").text()) * (1 + parseFloat($("#lMontoIgv").text()));
}
;
/**
 * Reinicia el dialog dAriticuloProductoAgregar, inicializando cada uno de los textos de entrada.
 * @returns {undefined}
 */
function fArticuloProductoAgregarReiniciar() {
    $('#dArticuloProductoAgregar').find('.limpiar').val('');
    $('#serieNumero').prop('checked', '');
    $('#cantidad').val('1');
    $("#lItem").text(parseInt($("#itemCantidad").val(), 10) + 1);
    fSerieNumeroDeshabilitarCampo();
}
;

function fCompraRegistrarReiniciar() {
    $('.vaciar').empty();
    $('.limpiar').val('');
    $('#itemCantidad').val('0');
    $('#tbArticuloProducto').empty();
    fCompraRegistrarReiniciar();
}
;

function fArticuloProductoEditarPreparar() {
    var item = $('#itemCantidadAux').val();
    $('#lItem').text($('#lItem' + item).text());
    $('#codArticuloProducto').val($('#codArticuloProducto' + item).val());
    var cantidad = $('#cantidad' + item).val();
    $('#cantidad').val(cantidad);
    $('#lUnidadMedida').text($('#lUnidadMedida' + item).text());
//    callback();
    $('#bDAPEditar').prop('disabled', false).removeClass('ui-state-disabled');
    $('#bDAPAgregar').prop('disabled', true).addClass('ui-state-disabled');
    $('#bDAPLimpiar').prop('disabled', true).addClass('ui-state-disabled');
    $('#dArticuloProductoAgregar').dialog('open');
    $('#dItemAccionDobleClic').dialog('close');
}
;

function fCompraRegistrar() {

}
;
function fPaginaActual() {
}
;