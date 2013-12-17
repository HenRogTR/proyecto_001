/* 
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */


$(document).ready(function() {
    //uso desarrollo
    $('.auxiliar').addClass('ocultar');
    //incializaciones de pagina
    $('input, textarea').placeholder();

    $('#docSerieNumero')
            .mask('S-000-000000')
            .blur(function(event) {
                fFacturaValidar();
//        fBoletaValidar();
            });
    $('#tipo').change(function(event) {
        if ($(this).val() == 'credito') {
            $('#bLetraCreditoGenerar').prop('disabled', '').removeClass('disabled');
        } else {
            $('#bLetraCreditoGenerar').prop('disabled', 'disabled').addClass('disabled');
        }
    });
    $('#fecha')
            .mask('00/00/0000')
            .blur(function() {
                if (!fValidarFecha(this.value)) {
                    this.value = '';
                }
            });
    $('#descuento')
            .mask('0999999999999.99')
            .blur(function(event) {
                if (this.value != '') {
                    this.value = fNumeroFormato(this.value, 2, false);
                } else {
                    this.value = '0.00';
                }
            });
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
    $('#cantidad')
            .mask('#', {maxlength: false})
            .blur(function(event) {
                if (this.value == '') {
                    this.value = '1';
                }
            })
            .keyup(function(event) {
                var key = event.charCode ? event.charCode : (event.keyCode ? event.keyCode : 0);
                if (key == 13) {
                    return;
                }
                for (var i = 1; i <= fCantidadStockItemActual(); i++) {
                    $("#" + i).prop('checked', false);
                }
                if (this.value > fCantidadStockItemActual()) {    //comprobar que no se permita ingresar mas del actual
                    this.value = fCantidadStockItemActual();
                    for (var i = 1; i <= fCantidadStockItemActual(); i++) {
                        $("#" + i).prop('checked', true);
                    }
                    fAlerta('Excedió la cantidad sobre el stock actual, se seleccionara el máximo permitido.');
                }
            });
    $('#precioContadoNuevo')
            .mask('0999999999999.99')
            .blur(function(event) {
                if (this.value != '') {
                    this.value = fNumeroFormato(this.value, 2, false);
                }
            })
            .keyup(function(event) {
                var key = event.charCode ? event.charCode : (event.keyCode ? event.keyCode : 0);
                if (key == 13) {
                    var $precioContadoNuevo = $('#precioContadoNuevo');
                    if ($.isNumeric($precioContadoNuevo.val())) {
                        $('#lPrecioContado').text(fNumeroFormato($precioContadoNuevo.val(), 2, false));
                        $('#dPrecioContadoEditar').dialog('close');
                    }
                }
            });

    $('#precioVenta')
            .mask('0999999999999.99')
            .blur(function(event) {
                if (this.value != '') {
                    this.value = fNumeroFormato(this.value, 2, false);
                }
            });

    $('#serieNumero').click(function(event) {
        event.preventDefault();
    });
    //letras de credito
    //<editor-fold defaultstate="collapsed" desc="#numeroLetras">
    $('#numeroLetras')
            .mask('#', {maxlength: false})
            .blur(function(event) {
                if (this.value == '') {
                    this.value = '1';
                }
            })
            .keyup(function(event) {
                var key = event.charCode ? event.charCode : (event.keyCode ? event.keyCode : 0);
                if (key == 13) {
                    return;
                }
                $('#auxiliarGenerarLetraCredito').val('0');
                if ($.isNumeric(this.value) && this.value > 0) {
                    var resto = parseInt($('#lNetoLetras').text()) - parseInt($('#montoInicial').val());
                    var num = parseInt(this.value);
                    $('#lMontoCuota').text(fNumeroFormato(resto / num, 2, false));
                } else {
                    $('#lMontoCuota').text($('#lNetoLetras').text());
                }
            });
    //</editor-fold>

    $('#fechaInicio')
            .mask('00/00/0000')
            .blur(function() {
                if (!fValidarFecha(this.value)) {
                    this.value = '';
                }
            });
    $('#fechaVencimiento')
            .mask('00/00/0000')
            .blur(function() {
                if (!fValidarFecha(this.value)) {
                    this.value = '';
                }
            });

    //<editor-fold defaultstate="collapsed" desc="#montoInicial">
    $('#montoInicial')
            .mask('0999999999999.99')
            .blur(function(event) {
                if (this.value != '') {
                    this.value = fNumeroFormato(this.value, 2, false);
                } else {
                    this.value = '0.00';
                }
            })
            .keyup(function(event) {
                var key = event.charCode ? event.charCode : (event.keyCode ? event.keyCode : 0);
                if (key == 13) {
                    return;
                }
                $('#auxiliarGenerarLetraCredito').val('0');
                //comprobar que el monto inicial no sobrepase el netoFa
                if (parseFloat(this.value) > parseFloat($('#lNetoLetras').text())) {
                    this.value = $('#lNetoLetras').text();
                    fAlerta('El monto inicial no debe superar el neto de la venta.');
                    return;
                }
                var montoInicial = 0;
                if ($.isNumeric(this.value)) {
                    montoInicial = this.value;
                }
                if ($('#numeroLetras').val() != '' & $('#numeroLetras').val() > 0) {
                    var resto = parseInt($('#lNetoLetras').text(), 10) - parseInt(montoInicial, 10);
                    var num = parseInt($('#numeroLetras').val(), 10);
                    $('#lMontoCuota').text(fNumeroFormato(resto / num, 2, false));
                } else {
                    $('#lMontoCuota').text($('#lNetoLetras').text());
                }
            });
    //</editor-fold>

    $('input[name=periodoLetra]').click(function(event) {
        $('#auxiliarGenerarLetraCredito').val('0');
        var cantDias = 0;
        switch (this.value) {
            case 'mensual':
                $('#periodoLetra').val('mensual');
                cantDias = 30;
                break;
            case 'quincenal':
                $('#periodoLetra').val('quincenal');
                cantDias = 14;
                break;
            case 'semanal':
                cantDias = 7;
                $('#periodoLetra').val('semanal');
                break;
        }
        var fecha = $('#fecha').val();
        var fechaSumado = fSumarDia(fStringADate(fecha), cantDias);
        $('#fechaInicio').val(fDateAString(fechaSumado));
        $('#fechaVencimiento').val(fecha);
    });

    //<editor-fold defaultstate="collapsed" desc="BOTONES. Clic en el signo + de la izquierda para mas detalles.">
    $('#bClienteBuscar').click(function(event) {
        $('#clienteBuscar').focus();
        $('#dClienteBuscar').dialog('open');
        event.preventDefault();
    });

    $('#bVendedorBuscar').click(function(event) {
        $('#vendedorBuscar').focus();
        $('#dVendedorBuscar').dialog('open');
        event.preventDefault();
    });

    $('#bArticuloProducto').click(function(event) {
        $('#bDAPEditar').prop('disabled', true).addClass('ui-state-disabled');
        $('#bDAPAgregar').prop('disabled', false).removeClass('ui-state-disabled');
        $('#bDAPLimpiar').prop('disabled', false).removeClass('ui-state-disabled');
        $('#lItem').text(parseInt($('#itemCantidad').val(), 10) + 1);
        $('#dArticuloProducto').dialog('open');
        event.preventDefault();
    });

    $('#bLetraCreditoGenerar').click(function(event) {
        var estado = true;
        var mensaje = '';
        var $itemCantidad = $('#itemCantidad');
        if (!$.isNumeric(fCantidadItemActual()) || $itemCantidad.val() == 0) {
            mensaje += '*Antes agregue articulos.<br>';
            estado = false;
        }
        var $neto = $('#lNeto');
        if (!$.isNumeric($neto.text()) || $neto.text() <= 0) {
            mensaje += '*El importe neto tiene que ser mayor' + $('lNeto').text() + '<br>';
            estado = false;
        }
        var $fecha = $('#fecha');
        if (!fValidarFecha($fecha.val())) {
            mensaje += '*Primero seleccione fecha de venta o corriga.<br>';
            estado = false;
        }
        if (!estado) {
            fAlerta(mensaje);
        } else {
            var fecha = $('#fecha').val();
            var cantDias = 30;
            var tipo = $("input[name=periodoLetra]:checked").val();
            switch (tipo) {
                case 'mensual':
                    cantDias = 30;
                    break;
                case 'quincenal':
                    cantDias = 15;
                    break;
                case 'semanal':
                    cantDias = 7;
                    break;
            }
            var fechaSumado = fSumarDia(fStringADate(fecha), cantDias);
            $('#fechaInicio').val(fDateAString(fechaSumado));
            $('#fechaVencimiento').val(fecha);
            $('#fechaVencimiento').datepicker('option', 'minDate', fecha);
            $('#fechaInicio').datepicker('option', 'minDate', fecha);
            $('#dGenerarLetrasCredito').dialog('open');
        }
        event.preventDefault();
    });

    $('#bPrecioContadoEditar').click(function(event) {
        $('#lPrecioContadoActual').text($('#lPrecioContado').text());
        $('#precioContadoNuevo').val('');
        $('#dPrecioContadoEditar').dialog('open');
    });

    //</editor-fold>

});

//<editor-fold defaultstate="collapsed" desc="$(function(){}). Clic en el signo + de la izquierda para mas detalles.">
$(function() {
    $('#fecha')
            .datepicker({
                changeMonth: true,
                changeYear: true,
                numberOfMonths: 2
            });

    $('#fechaInicio')
            .datepicker({
                changeMonth: true,
                changeYear: true,
                numberOfMonths: 3})
            .datepicker('option', 'minDate', $('#fecha').val());
    $('#fechaVencimiento')
            .datepicker({
                changeMonth: true,
                changeYear: true,
                numberOfMonths: 2})
            .datepicker('option', 'minDate', $('#fecha').val());

    //<editor-fold defaultstate="collapsed" desc="DIALOG'S. Clic en el signo + de la izquierda para mas detalles...">
    $('#dVentaRegistrarExito').dialog({
        autoOpen: false,
        modal: true,
        resizable: true,
        height: 150,
        width: 350,
        buttons: {
            Ver: function() {
                $(location).attr('href', '../sVenta?accionVenta=mantenimiento&codVenta=' + $('#codVenta').val());
            },
            'Registrar otro': function() {
                $(this).dialog("close");
            }
        }
    });
    $('#dClienteBuscar').dialog({
        autoOpen: false,
        modal: true,
        resizable: true,
        height: 100,
        width: 800,
        close: function() {
            fFacturaValidar();
        }
    });

    $('#dVendedorBuscar').dialog({
        autoOpen: false,
        modal: true,
        resizable: true,
        height: 100,
        width: 800,
        close: function() {

        }
    });

    $('#dArticuloProducto').dialog({
        autoOpen: false,
        modal: true,
        resizable: true,
        height: 550,
        width: 1100,
        buttons: [
            {
                id: 'bDAPLimpiar',
                text: 'Limpiar',
                click: function(event) {
//                    event.preventDefault();
                }
            },
            {
                id: 'bDAPAgregar',
                text: 'Agregar',
                click: function(event) {
                    if (fArticuloProductoValidar()) {
                        fArticuloProductoAgregar();
                    }
                }
            },
            {
                id: 'bDAPEditar',
                text: 'Editar',
                click: function(event) {
//                    event.preventDefault();
                }
            }
        ],
        close: function() {

        }
    });

    $('#dPrecioContadoEditar').dialog({
        autoOpen: false,
        modal: true,
        resizable: true,
        height: 180,
        width: 450,
        buttons: {
            Modificar: function() {
                var $precioContadoNuevo = $('#precioContadoNuevo');
                if ($.isNumeric($precioContadoNuevo.val())) {
                    $('#lPrecioContado').text($precioContadoNuevo.val());
                } else {
                    $('#lPrecioContado').text('0.00');
                }
                $(this).dialog('close');
            },
            Cancelar: function() {
                $(this).dialog('close');
            }
        },
        close: function() {
            $(this).dialog("close");
        }
    });

    $("#dItemAccionDobleClic").dialog({
        autoOpen: false,
        modal: true,
        resizable: true,
        height: 250,
        width: 600,
        buttons: {
            Editar: function() {
                fAlerta('Función en desarrollo');
            },
            Eliminar: function(event) {
                var actualEl = $("#itemCantidadAux");//numero de item que esta editando input-hidden
                var cantidadAP = $("#itemCantidad"); //cantidad de articulo agregados input-hidden
                if (parseInt(actualEl.val()) == parseInt(cantidadAP.val())) {
                    $("#trArticuloProducto" + cantidadAP.val()).remove(); //removemos el ultimo despues de actualizar los datos
                    cantidadAP.val(parseInt(cantidadAP.val()) - 1);//actualizamos contador de productos que sera 1 menos al actual
                    fCalcularImportes();
                } else {
                    fAlerta("Para eliminar, tiene que hacerlo desde el último agregado.");
                }

                $("#dItemAccionDobleClic").dialog("close");
                event.preventDefault();
            },
            Cerrar: function() {
                $(this).dialog('close');
            }
        }
    });

    $("#dGenerarLetrasCredito").dialog({
        autoOpen: false,
        modal: true,
        resizable: true,
        height: 570,
        width: 600,
        buttons: {
            'Generar letras': function() {
                if (fLetrasCreditoValidar()) {
                    fLetrasCreditoGenerar();
                }
            },
            'Aceptar': function() {
                if ($('#auxiliarGenerarLetraCredito').val() == '0') {
                    fAlerta('Genere las letras de credito');
                    return;
                }
                $(this).dialog("close");
            }
        },
        close: function() {

        }
    });
    $('#dVentaRegistrarConfirmar').dialog({
        autoOpen: false,
        modal: true,
        resizable: true,
        height: 600,
        width: 800,
        buttons: {
            Cancelar: function() {
                $(this).dialog('close');
            },
            Continuar: function() {
                fVentaRegistrar();
            }
        }
    });
    //</editor-fold>

    //<editor-fold defaultstate="collapsed" desc="AUTOCOMPLETE. Clic en el signo + de la izquierda para mas detalles.">
    $('#clienteBuscar').autocomplete({
        source: 'autocompletado/clienteLeer.jsp',
        minLength: 4,
        select: clienteSeleccionado,
        focus: clienteCMarcado
    });

    $('#vendedorBuscar').autocomplete({
        source: 'autocompletado/cobradorVendedorLeer.jsp',
        minLength: 4,
        select: vendedorSeleccionado,
        focus: vendedorMarcado
    });

    $('#descripcion').autocomplete({
        source: 'autocompletado/articuloProductoDescripcion.jsp',
        minLength: 4,
        select: fAPSeleccionado,
        focus: fAPMarcado
    });
    //</editor-fold>

    $('#formVentaRegistrar').validate({
        submitHandler: function() {
            if (fVentaRegistrarVerificar()) {
//                fVentaRegistrar();
                fVentaRegistrarConfirmar();
            } else {
                return;
            }
        },
        onkeyup: function(element) {
            $(element).valid();
        },
        rules: {
            docSerieNumero: {
                required: true,
                remote: 'validacion/ventasVerificarDocSerieNumero.jsp'
            },
            tipo: 'required',
            fecha: {required: true, dateITA: true},
            moneda: 'required'
        },
        messages: {
            docSerieNumero: {
                remote: 'El documento ya está usado.'
            },
            tipo: 'Seleccione <strong>TIPO</strong> de venta',
            moneda: 'Seleccione <strong>MONEDA</strong>',
            fecha: {dateITA: 'Ingrese un formato de fecha correcta'}
        }
    });
});
//</editor-fold>

//<editor-fold defaultstate="collapsed" desc="FUNCIONES. Clic en el signo + de la izquierda para mas detalles.">
//<editor-fold defaultstate="collapsed" desc="fAPLeer(codArticuloProducto)...">
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
                fArticuloProductoReiniciar();
                var APArray = procesarRespuesta(ajaxResponse);
                if (APArray.length == 0) {
                    fAlerta('Artículo no encontrado');
                } else {
                    var APItem = APArray[0];
                    $('#lStock').text(APItem.stock);
                    $("#codArticuloProducto").val(APItem.codArticuloProducto);
                    $("#descripcion").val(APItem.descripcion);
                    $("#lPrecioContado").text(APItem.precioVenta);
                    $("#precioVenta").val(APItem.precioVenta);
                    $("#lUnidadMedida").text(APItem.unidadMedida);
                    $('#serieNumero').prop('checked', APItem.usarSerieNumero ? 'checked' : '');
                    if (APItem.stock < 1) {
                        fAlerta('No hay articulo en stock.');
                    }
                    if (APItem.usarSerieNumero) {
                        $('#dSerieNumero').removeClass('ocultar');
                        fSerieNumeroStock(codArticuloProducto);
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
//</editor-fold>

//<editor-fold defaultstate="collapsed" desc="fSerieNumeroStock(codArticuloProducto)">
function fSerieNumeroStock(codArticuloProducto) {
    var data = {codArticuloProducto: codArticuloProducto, codAlmacen: 1};
    var url = 'ajax/serieNumeroStockLeer.jsp';
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
                var SNSArray = procesarRespuesta(ajaxResponse);
                for (var i = 1; i <= SNSArray.length; i++) {
                    var SNSItem = SNSArray[i - 1];
                    $('#tSerieNumero').append(
                            '<tr>' +
                            '<td  class="ancho40px centrado">' +
                            '<input type="hidden"  id="codKardexSerieNumero' + i + '" value="' + SNSItem.codKardexSerieNumero + '"/>' +
                            '<input type="checkbox" name="cSerieNumero" id="' + i + '"/>' +
                            '</td>' +
                            '<td class="ancho400px"><label id="serieNumero' + i + '" for="' + i + '">' + SNSItem.serieNumero + '</label></td>' +
                            '<td><label id="serieNumeroObservacion' + i + '" for="' + i + '">' + SNSItem.observacion + '</label></td>' +
                            '</tr>'
                            );
                    $('#' + i).bind('click', function(event) {
                        var cantidadSNSeleccionado = 0;
                        for (var j = 1; j <= fCantidadStockItemActual(); j++) {
                            if ($('#' + j).is(':checked')) {
                                cantidadSNSeleccionado++;
                            }
                        }
                        if (cantidadSNSeleccionado > fCantidadItemActual()) {
                            fAlerta('Se ha sobrepasado la cantidad de series.');
                            event.preventDefault();
                        }
                    });
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
//</editor-fold>

//<editor-fold defaultstate="collapsed" desc="clienteSeleccionado(event, ui). Clic en el signo + de la izquierda para mas detalles">
function clienteSeleccionado(event, ui) {
    var cliente = ui.item.value;
    $("#clienteBuscar").val("");
    $("#lClienteNombresC").text(cliente.nombresC);
    $("#codPersona").val(cliente.codPersona);
    $("#codCliente").val(cliente.codCliente);
    $("#lClienteDireccion").text(cliente.direccion);
    $("#lClienteDniPasaporte").text(cliente.dniPasaporte);
    $("#lClienteRuc").text(cliente.ruc);
    $('#lClienteCreditoMax').text(cliente.creditoMax);
    $('#lClienteEmpresaConvenio').text(cliente.empresaConvenio);
    $('#lClienteCondicion').text(cliente.condicion);
    $("#dClienteBuscar").dialog("close");
    event.preventDefault();
}
;

//</editor-fold>

//<editor-fold defaultstate="collapsed" desc="clienteCMarcado(event, ui). Clic en el signo + de la izquierda para mas detalles">
function clienteCMarcado(event, ui) {
    var cliente = ui.item.value;
    $("#clienteBuscar").val(cliente.nombresC);
    event.preventDefault();
}
;

//</editor-fold>

//<editor-fold defaultstate="collapsed" desc="vendedorSeleccionado(event, ui). Clic en el signo + de la izquierda para mas detalles.">
function vendedorSeleccionado(event, ui) {
    var vendedor = ui.item.value;
    $("#vendedorBuscar").val("");
    $("#lVendedorNombresC").text(vendedor.nombresC);
    $("#codVendedor").val(vendedor.codPersona);
    $("#dVendedorBuscar").dialog("close");
    event.preventDefault();
}
;

//</editor-fold>

//<editor-fold defaultstate="collapsed" desc="vendedorMarcado(event, ui). Clic en el signo + de la izquierda para mas detalles.">
function vendedorMarcado(event, ui) {
    var vendedor = ui.item.value;
    $("#vendedorBuscar").val(vendedor.nombresC);
    event.preventDefault();
}
;

//</editor-fold>

//<editor-fold defaultstate="collapsed" desc="fAPSeleccionado(event, ui) . Clic en el signo + de la izquierda para mas detalles">
function fAPSeleccionado(event, ui) {
    var articuloProducto = ui.item.value;
    $('#descripcionBuscar').val('');
    $('#codArticuloProductoBuscar').val('');
    fAPLeer(articuloProducto.codArticuloProducto, '');
    $('#dAPBuscar').dialog('close');
    event.preventDefault();
}
;

//</editor-fold>

//<editor-fold defaultstate="collapsed" desc="fAPMarcado(event, ui). Clic en el signo + de la izquierda para mas detalles">
function fAPMarcado(event, ui) {
    var articuloProducto = ui.item.value;
    $('#descripcionBuscar').val(articuloProducto.descripcion);
    $('#codArticuloProductoBuscar').val(articuloProducto.codArticuloProducto);
    event.preventDefault();
}
;

//</editor-fold>

//<editor-fold defaultstate="collapsed" desc="fCantidadStockItemActual(). Clic en el signo + de la izquierda para mas detalles.">
function fCantidadStockItemActual() {
    return parseInt($("#lStock").text(), 10);
}
;

//</editor-fold>

//<editor-fold defaultstate="collapsed" desc="fCantidadItemActual(). Clic en el signo + de la izquierda para mas detalles">
function fCantidadItemActual() {
    var cantidad = $("#cantidad").val();
    if (!$.isNumeric(cantidad)) {
        return 0;
    } else {
        return cantidad;
    }
}
;

//</editor-fold>

//<editor-fold defaultstate="collapsed" desc="fVentaRegistrarVerificar(). Clic en el signo + de la izquierda para mas detalles">
function fVentaRegistrarVerificar() {
    var estado = true;
    var mensaje = "<strong>ERROR(ES) EN REGISTRO DE VENTA</strong><br>";
    if ($('#codPersona').val() == '') {
        mensaje += '*Seleccione cliente<br>';
        estado = false;
    }
    if ($('#codVendedor').val() == '') {
        mensaje += '*Seleccione vendedor<br>';
        estado = false;
    }
    if ($('#itemCantidad').val() == '0') {
        mensaje += '*Seleccione al menos un artículo para realizar la venta.<br>';
        estado = false;
    }
    if ($('#tipo').val() == 'credito') {
        if ($('#auxiliarGenerarLetraCredito').val() == '0') {
            mensaje += '*Primero genere las letras de credito.<br>';
            estado = false;
        }
    }
    if (!estado) {
        fAlerta(mensaje);
    }
    return estado;
}
;

//</editor-fold>

//<editor-fold defaultstate="collapsed" desc="fVentaRegistrar(). Clic en el signo + de la izquierda para mas detalles.">
function fVentaRegistrar() {
    $('#dVentaRegistrarConfirmar').dialog('close');
    var formVentaRegistrar = $('#formVentaRegistrar');
    var data = formVentaRegistrar.serialize() + '&accionVenta=registrar';
    var url = formVentaRegistrar.attr('action');
    try {
        $.ajax({
            type: 'post',
            url: url,
            data: data,
            beforeSend: function() {
                $('#trBoton').addClass('ocultar');
                fProcesandoPeticion('Registrando venta.');
            },
            error: function(XMLHttpRequest, textStatus, errorThrown) {
                $('#lServidorError').text(errorThrown + '()');
                $('#dServidorError').dialog('open');
            },
            success: function(ajaxResponse, textStatus) {
                $('#trBoton').removeClass('ocultar');
                $('#dProcesandoPeticion').dialog('close');
                if ($.isNumeric(ajaxResponse)) {
                    fVentaReiniciar();
                    fArticuloProductoReiniciar();
                    $('#dVentaRegistrarExito').dialog('open');
                } else {
                    fAlerta(ajaxResponse);
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
//</editor-fold>

//<editor-fold defaultstate="collapsed" desc="fFacturaValidar(). Clic en el signo + de la izquierda para mas detalles">
function fFacturaValidar() {
    var docSerieNumero = $('#docSerieNumero').val();
    if (docSerieNumero.substring(0, 1) == "F" && $('#codPersona').val() != '' && $('#lClienteRuc').text() == '') {
        fAlerta('El cliente no tiene <strong>RUC</strong> para asignar este tipo'
                + ' de documento (<strong>FACTURA</strong>), se recomienda...<br>'
                + '*Actualizar el dato del cliente.<br>'
                + '*Ingresar el comprobante correcto.<br>'
                + '... por segurida se procedera a reiniciar el campo del comprobante.'
                );
        $('#docSerieNumero').val('');
    }
}
;

//</editor-fold>

//<editor-fold defaultstate="collapsed" desc="fArticuloProductoAgregar(). Clic en el signo + de la izquierda para mas detalles">
function fArticuloProductoAgregar() {
    var $item = $('#lItem');//$item=numero de item que ademas será nuestro id
    var $cantidad = $('#cantidad'); //$cantidad=cantidad comprada de articulo
    var $codArticuloProducto = $('#codArticuloProducto');   //
    var $descripcion = $('#descripcion');
    var $unidadMedidaT = $('#lUnidadMedida');
    var $precioContadoT = $('#lPrecioContado');
    var $precioVenta = $('#precioVenta');

    $('#tbArticuloProducto').append(
            '<tr id="trArticuloProducto' + $item.text() + '">' +
            '<td class="derecha"><span id="lItem' + $item.text() + '" class="vaciar">' + $item.text() + '</span></td>' +
            '<td class="derecha">' +
            '<input type="text" name="codArticuloProducto' + $item.text() + '" id="codArticuloProducto' + $item.text() + '" value="' + $codArticuloProducto.val() + '" class="limpiar ocultar" />' +
            '<span id="lCodArticuloProducto' + $item.text() + '" class="vaciar">' + $codArticuloProducto.val() + '</span>' +
            '</td>' +
            '<td class="derecha">' +
            '<input type="text" name="cantidad' + $item.text() + '" id="cantidad' + $item.text() + '" value="' + parseInt($cantidad.val(), 10) + '" class="limpiar ocultar" />' +
            '<span id="lCantidad' + $item.text() + '" class="vaciar">' + parseInt($cantidad.val(), 10) + '</span>' +
            '</td>' +
            '<td class="derecha">' +
            '<span id="lUnidad' + $item.text() + '" class="vaciar">' + $unidadMedidaT.text() + '</span>' +
            '</td>' +
            '<td class="izquierda">' +
            '<span id="lDescripcion' + $item.text() + '" class="vaciar" title="' + $item.text() + '">' + $descripcion.val() + '</span>' +
            '<div id="dSerieNumeroMostrar' + $item.text() + '" style="padding-left: 15px;">' +
            '</div>' +
            '<div id="dSerieNumero' + $item.text() + '">' +
            '</div>' +
            '</td>' +
            '<td class="derecha">' +
            '<input type="text" name="precioContado' + $item.text() + '" id="precioContado' + $item.text() + '" value="' + fNumeroFormato($precioContadoT.text(), 2, false) + '" class="limpiar ocultar" />' +
            '<input type="text" name="precioVenta' + $item.text() + '" id="precioVenta' + $item.text() + '" value="' + fNumeroFormato(parseFloat($precioVenta.val()), 2, false) + '" class="limpiar ocultar" />' +
            '<span id="lPrecioVenta' + $item.text() + '" class="vaciar">' + fNumeroFormato(parseFloat($precioVenta.val()), 2, false) + '</span>' +
            '</td>' +
            '<td class="derecha">' +
            '<input type="text" name="precioTotal' + $item.text() + '" id="precioTotal' + $item.text() + '" value="' + fNumeroFormato(parseFloat($precioVenta.val()) * parseInt($cantidad.val(), 10), 2, false) + '" class="limpiar ocultar"/>' +
            '<span id="lPrecioTotal' + $item.text() + '" class="vaciar">' + fNumeroFormato(parseFloat($precioVenta.val()) * parseInt($cantidad.val(), 10), 2, false) + '</span>' +
            '</td>' +
            '</tr>'
            );
    //agregamos las series en caso de tener
    if (fSerieNumeroEstado()) {
        var temCant = 1;
        for (var i = 1; i <= fCantidadStockItemActual(); i++) {  //se agregar las series
            if ($('#' + i).is(':checked')) {
                $('#dSerieNumeroMostrar' + $item.text()).append(
                        $('#serieNumero' + i).text() + '&nbsp;&nbsp;&nbsp;&nbsp;'
                        );
                $('#dSerieNumero' + $item.text()).append(
                        '<input type="text" name="item' + $item.text() + 'codKardexSerieNumero' + temCant + '" value="' + $('#codKardexSerieNumero' + i).val() + '" class="ocultar"/>'
                        );

                temCant++;
            }
        }
    }
    //asignamos la opciones de editar o eliminar
    $('#lDescripcion' + $item.text()).bind('dblclick', function(event) {
        var actual = $(this).attr('title'); //captuarmos el numero de item tomando el dato del atributo class
        $('#itemCantidadAux').val(actual);
        $('#lItemMostrar').text(actual);
        $('#lDescripcionMostrar').text($('#lDescripcion' + actual).text());
        $('#dItemAccionDobleClic')
                .dialog({title: 'Item ' + actual})
                .dialog('open');
        event.preventDefault();
    });
    $("#itemCantidad").val(parseInt($item.text()), 10);//actualizamos contador de productos
    $('#lItem').text(parseInt($('#itemCantidad').val(), 10) + 1);
    fArticuloProductoReiniciar();
    fCalcularImportes();
    //recalculamos los datos de total, etc
    $('#codArticuloProducto').focus();
}
;

//</editor-fold>

//<editor-fold defaultstate="collapsed" desc="fArticuloProductoValidar(). Clic en el signo + de la izquierda para mas detalles">
/**
 * Valida que antes de agregar/modificar todos los datos esten correctamente.
 * @returns {Boolean}
 */
function fArticuloProductoValidar() {
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
    var $precioVenta = $('#precioVenta');
    if (!$precioVenta.length || !$.isNumeric($precioVenta.val())) {
        mensaje += '*Ingrese precio de venta.<br>';
        estado = false;
    }
    if (fSerieNumeroEstado()) {
        var cantidadSNSeleccionado = 0;
        for (var i = 1; i <= fCantidadStockItemActual(); i++) {
            if ($("#" + i).is(":checked")) {
                cantidadSNSeleccionado++;
            }
        }
        if (cantidadSNSeleccionado < fCantidadItemActual()) {
            mensaje += '*Seleccione la misma cantidad de series a vender.<br>';
            estado = false;
        }
    }
    if (fCantidadStockItemActual() <= 0) {
        mensaje += '*No hay stock del producto a vender.<br>';
        estado = false;
    }
    if (!estado) {
        fAlerta(mensaje);
    }
    return estado;
}
;

//</editor-fold>

//<editor-fold defaultstate="collapsed" desc="fSerieNumeroEstado(). Clic en el signo + de la izquierda para mas detalles">
function fSerieNumeroEstado() {
    var estado = false;
    if ($("#serieNumero").is(":checked")) {
        estado = true;
    }
    return estado;
}
;

//</editor-fold>

//<editor-fold defaultstate="collapsed" desc="fCalcularImportes(). Clic en el signo + de la izquierda para mas detalles">
function fCalcularImportes() {
    var subTotal = 0.00;
    var itemCantidad = parseInt($('#itemCantidad').val(), 10);
    for (var i = 1; i <= itemCantidad; i++) {
        subTotal = parseFloat(subTotal) + parseFloat($("#precioTotal" + i).val());
    }
    $("#lSubTotal").text(fNumeroFormato(subTotal, 2, false));
    var total = 0.00;
    var descuento = 0.00;
    var $descuento = $('#descuento');
    if ($.isNumeric($descuento.val())) {
        descuento = parseFloat($descuento.val());
    }
    total = subTotal - descuento;
    $("#lTotal").text(fNumeroFormato(total, 2, false));   //asignamos total
    var montoIgv = 0.00;
    var $montoIgv = $('#lMontoIgv');
    if ($.isNumeric($montoIgv.val())) {
        montoIgv = parseFloat($montoIgv.val());
    }
    var neto = total * (1 + montoIgv);
    $('#auxiliarGenerarLetraCredito').val('0');
    $("#lNeto").text(fNumeroFormato(neto, 2, false)); //asignamos neto
    $("#lNetoLetras").text(fNumeroFormato(neto, 2, false));
    $('#lMontoCuota').text(fNumeroFormato(neto, 2, false));
    $('#numeroLetras').val('1');
}
;

//</editor-fold>

//<editor-fold defaultstate="collapsed" desc="fLetrasCreditoValidar(). Clic en el signo + de la izquierda para mas detalles">
function fLetrasCreditoValidar() {
    var estado = true;
    var mensaje = '';
    var $numeroLetras = $('#numeroLetras');
    var $fechaInicio = $('#fechaInicio');
    var $fechaVencimiento = $('#fechaVencimiento');
    if (!$.isNumeric($numeroLetras.val()) || $numeroLetras.val() < 1) {
        mensaje += '*El numero de letra debe ser mayor a 0<br>';
        estado = false;
    }
    if (!$fechaInicio.length || !fValidarFecha($fechaInicio.val())) {
        mensaje += '*Ingrese fecha inicio<br>';
        estado = false;
    }
    if (!$fechaVencimiento.length || !fValidarFecha($fechaVencimiento.val())) {
        mensaje += '*Ingrese fecha vencimiento - formato de f. de vencimiento incorrecto.<br>';
        estado = false;
    }
    if (!estado) {
        fAlerta(mensaje);
    }
    return estado;
}
;

//</editor-fold>

//<editor-fold defaultstate="collapsed" desc="fLetrasCreditoGenerar(). Clic en el signo + de la izquierda para mas detalles.">
function fLetrasCreditoGenerar() {
//    var $lNetoLetras = $('#lNetoLetras');
//    var $numeroLetras = $('#numeroLetras');
//    var $fechaInicio = $('#fechaInicio');
//    var $montoInicial = $('#montoInicial');
//    var $fechaVencimiento = $('#fechaVencimiento');
    var data = {
        neto: $('#lNetoLetras').text(),
        inicial: $('#montoInicial').val(),
        numeroCuotas: $('#numeroLetras').val(),
        fechaInicio: $('#fechaInicio').val(),
        fechaVencimiento: $('#fechaVencimiento').val(),
        periodoLetra: $('#periodoLetra').val()
    };
    var url = 'ajax/letraCreditoGenerar.jsp';
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
                var letras = procesarRespuesta(ajaxResponse);
                var $detallesLetras = $('#tbDetalleLetras');
                if (!letras) {
                    fAlerta('Error al generar las letras-' + ajaxResponse);
                } else {
                    var letrasDetalles;
                    $detallesLetras.empty();
                    for (var i = 0; i < letras.length; i++) {
                        letrasDetalles = letras[i];
                        if (i == 1) {
                            $('#lMostrar8').text(letrasDetalles.monto);
                        }
                        $detallesLetras.append(
                                '<tr>' +
                                '<td style="width: 33%;">' + letrasDetalles.letra + '</td>' +
                                '<td style="width: 35%;">' + letrasDetalles.fechaVencimiento + '</td>' +
                                '<td>' + letrasDetalles.monto + '</td>' +
                                '</tr>'
                                );
                    }
                    $('#auxiliarGenerarLetraCredito').val('1');
                    $('#cantidadLetras').val($('#numeroLetras').val());
                    $('#fechaInicioLetras').val($('#fechaInicio').val());
                    $('#montoInicialLetra').val($('#montoInicial').val());
                    $('#fechaVencimientoInicial').val($('#fechaVencimiento').val());
                }
            },
            statusCode: {
                404: function() {
                    $('#lServidorError').text('Página no encontrada(letraCreditoGenerar.jsp).');
                    $('#dServidorError').dialog('open');
                }
            }
        });
    }
    catch (ex) {
        $('#lServidorError').text(ex);
        $('#dServidorError').dialog('open');
    }

    //asignar los input con los datos a enviar
}
;

//</editor-fold>

//<editor-fold defaultstate="collapsed" desc="fArticuloProductoReiniciar(). Clic en el signo + de la izquierda para mas detalles">
function fArticuloProductoReiniciar() {
    $('#lStock').text('');
    $("#codArticuloProducto").val('');
    $("#descripcion").val('');
    $("#lPrecioContado").text('0.00');
    $("#precioVenta").val('');
    $("#lUnidadMedida").text('');
    $('#serieNumero').prop('checked', '');
    $('#cantidad').val('1');
    $('#tSerieNumero').empty();
    $('#dSerieNumero').addClass('ocultar');
}
;

//</editor-fold>

//<editor-fold defaultstate="collapsed" desc="fVentaReiniciar(). Clic en el signo + de la izquierda para mas detalles">
function fVentaReiniciar() {
    $('#bLetraCreditoGenerar').prop('disabled', 'disabled').addClass('disabled');
    $('.limpiar').val('');
    $('.vaciar').empty();
    $('#fecha').val($('#fechaAux').val());
    $('#moneda').val('soles');
    $('#itemCantidad').val('0');
    $('#auxiliarGenerarLetraCredito').val('0');
    $('#periodoLetra').val('mensual');
    $('#cantidadLetras').val('1');
    var fecha = $('#fecha').val();
    $('#fechaInicioLetras').val(fDateAString(fSumarDia(fStringADate(fecha), 30)));
    $('#montoInicialLetra').val('0');
    $('#fechaVencimientoInicial').val(fecha);
    $('#descuento').val('0.00');
}
;

//</editor-fold>

//<editor-fold defaultstate="collapsed" desc="fPaginaActual(). Clic en el signo + de la izquierda para mas detalles">
function fPaginaActual() {
    fVentaReiniciar();
}
;
//</editor-fold>

//<editor-fold defaultstate="collapsed" desc="fVentaRegistrarConfirmar(). Clic en el signo + de la izquierda para mas detalles.">
function fVentaRegistrarConfirmar() {
    var $dVRC = $('#dVentaRegistrarConfirmar');
    $dVRC.find('.vaciar').empty();

    $('#lMostrar1').text($('#docSerieNumero').val());
    $('#lMostrar2').text($('#tipo option:selected').text());
    $('#lMostrar3').text($('#fecha').val());
    $('#trMostrarVC').addClass('ocultar');
    if ($('#tipo').val() == 'credito') {
        $('#trMostrarVC').removeClass('ocultar');
        $('#lMostrar4').text($('#montoInicialLetra').val());
        $('#lMostrar5').text($('#fechaVencimientoInicial').val());
        $('#lMostrar6').text($('#cantidadLetras').val());
        $('#lMostrar7').text($('#periodoLetra').val().toUpperCase());
//        $('#lMostrar8').text() al momento de generar
        $('#lMostrar9').text($('#fechaInicioLetras').val());
    }
    $('#lMostrar10').text($('#lClienteNombresC').text());
    $('#lMostrar11').text($('#lVendedorNombresC').text());
    $('#lMostrar12').text($('#lNeto').text());
    var itemCantidad = $('#itemCantidad').val();
    for (var i = 1; i <= itemCantidad; i++) {
        $('#tbAPMostrar').append(
                '<tr>' +
                '<td class="derecha">' + $('#lItem' + i).text() + '</td>' +
                '<td class="derecha">' + $('#lCodArticuloProducto' + i).text() + '</td>' +
                '<td>' + $('#lDescripcion' + i).text() + '</td>' +
                '<td class="derecha">' + $('#lPrecioTotal' + i).text() + '</td>' +
                '</tr>'
                );
    }
    $dVRC.dialog('open');
}
;
//</editor-fold>

//</editor-fold>
