/* 
 * To change this template, choose Tools | Templates
 * and open the template in the editor.
 */

$(document).ready(function() {

    $('input,textarea').blur(function() {
        $(this).val($(this).val().toUpperCase());
    });
    $('input[name=tipoRecibo]').click(function(event) {
        if ($(this).val() == 'TKR') {
            $('#lDocSerieNumeroRecibo').text($(this).val() + '-');
        } else {
            if ($('#lCodCobranza').text() == '') {
                $('#lDocSerieNumeroRecibo').text('XXX-');
            } else {
                $('#lDocSerieNumeroRecibo').text($('#lCodCobranza').text() + '-');
            }
        }
    });
    $('input[name=version]').click(function(event) {
        if ($(this).val() == 'nueva') {
            $('#docSerieNumero').addClass('ocultar');
            $('#dNueva').removeClass('ocultar');
        } else {
            $('#docSerieNumero').removeClass('ocultar');
            $('#dNueva').addClass('ocultar');
        }
    });

    $('#bClienteBuscar').click(function(event) {
        $('#codPersona').focus();
        $('#dClienteBuscar').dialog('open');
        event.preventDefault();
    });

    $('#dClienteBuscar').dialog({
        autoOpen: false,
        modal: true,
        resizable: true,
        height: 120,
        width: 800,
        close: function() {
            $(this).dialog("close");
        },
    });

    $('#dErrores').dialog({
        autoOpen: false,
        modal: true,
        resizable: true,
        height: 200,
        width: 500,
        buttons: {
            Cerrar: function() {
                $(this).dialog("close");
            }
        }
    });

    $('#dAmortizarConfirmar').dialog({
        autoOpen: false,
        modal: true,
        resizable: true,
        height: 180,
        width: 500,
        buttons: {
            Si: function() {
                amortizar();
            },
            No: function() {
                $('#bAmortizar').removeClass('disabled').removeAttr('disabled');
                $(this).dialog("close");
            }
        },
        close: function() {
            $('#bAmortizar').removeClass('disabled').removeAttr('disabled');
        },
    });

    $('#dConfirmarSaldoFavor').dialog({
        autoOpen: false,
        modal: true,
        resizable: true,
        height: 200,
        width: 500,
        buttons: {
            Si: function() {
                $('#dAmortizarConfirmar').dialog('open');
                $(this).dialog("close");
            },
            No: function() {
                $('#bAmortizar').removeClass('disabled').removeAttr('disabled');
                $(this).dialog("close");
            }
        },
        close: function() {
            $('#bAmortizar').removeClass('disabled').removeAttr('disabled');
        },
    });

    $('#dConfirmarFiltro').dialog({
        autoOpen: false,
        modal: true,
        resizable: true,
        height: 150,
        width: 500,
        buttons: {
            Si: function() {
                $('#codVentas').val($('#aux').val());
                $('#lFiltro').text('Se esta filtrando por Doc: ' + $('#auxDocSerieNumero').val());
                $(this).dialog("close");
            },
            No: function() {
                $('#lFiltro').text('No se esta filtrando el pago');
                $('#codVentas').val('0');
                $(this).dialog("close");
            }
        },
        close: function() {
            $(this).dialog("close");
        },
    });

    $('#codPersona').numeric({decimal: false, negative: false});
    $('#codPersona').keyup(function(event) {
        if (event.which == 13 & $(this).val() > 0) {
            persona($(this).val());
            $(this).val('');
        }
    });

    $('#docSerieNumero').mask('a-999-999999');
    $('#serie').mask('999');
    $('#fechaCobranza').mask('99/99/9999');
    $('#fechaCobranza').blur(function() {
        if (!verficarFecha($(this).val())) {

        }
    });
    $('#fechaCobranza').datepicker({
        changeMonth: true,
        changeYear: true,
    });

    $('#montoAmortizar').numeric(",");

    $('#dniPasaporteRuc').autocomplete({
        source: "autocompletado/datoClienteDniPasaporteRuc.jsp",
        minLength: 3,
        select: personaSeleccionado,
        focus: personaMarcado
    });

    $('#nombresC').autocomplete({
        source: "autocompletado/datoClienteNombresC.jsp",
        minLength: 3,
        select: personaSeleccionado,
        focus: personaMarcado
    });

    $('#bSaldoFavorUsar').click(function(event) {
        var saldoFavor = parseFloat($('#auxSaldoFavor').val());
        if (saldoFavor <= 0) {
            alert('No hay saldo a favor a usar');
            return;
        }
        $('#dSaldoFavorConfirmar').dialog('open');
    });

    $('#dSaldoFavorConfirmar').dialog({
        autoOpen: false,
        modal: true,
        resizable: true,
        height: 180,
        width: 500,
        buttons: {
            Si: function() {
                $('#docSerieNumero').val('X-111-999999').attr('readonly', 'readonly');
                $('#montoAmortizar').val($('#auxSaldoFavor').val());
                $('#marcaSaldoFavor').val('1');
                $(this).dialog("close");
            },
            No: function() {
                $(this).dialog("close");
            }
        },
        close: function() {
        },
    });

    $('#dCobranzaEliminar').dialog({
        autoOpen: false,
        modal: true,
        resizable: true,
        height: 150,
        width: 500,
        buttons: {
            Si: function() {
                eliminarCobranza();
                $(this).dialog("close");
            },
            No: function() {
                $(this).dialog("close");
            }
        },
        close: function() {
        },
    });

    function personaSeleccionado(event, ui) {
        var personaDato = ui.item.value;
        persona(personaDato.codPersona);
        $('#dniPasaporteRuc').val('');
        $('#nombresC').val('');
        event.preventDefault();
    }

    function personaMarcado(event, ui) {
        var personaDato = ui.item.value;
        $('#dniPasaporteRuc').val(personaDato.dniPasaporte + " " + personaDato.ruc);
        $('#nombresC').val(personaDato.nombresC);
        event.preventDefault();
    }

    $('#bAmortizar').click(function(event) {
        $(this).addClass('disabled').attr('disabled', 'disabled');
        var mensaje = '';
        var estado = true;
        $('#evento').find('label').remove();
//        $('#evento').append('<label>Inciando registro<br></label>');
        //verificar si hay cliente
        if ($('#codPersonaAux').val() == 0) {
            mensaje += '<label>Cliente no seleccionado<br></label>';
            estado = false;
        }
        $('input[name=version]').each(function() {
            var checkbox = $(this);
            if (checkbox.is(':checked')) {
                if ($(this).val() == 'nueva') {
                    if ($('#serie').val() == '') {
                        mensaje += '<label>Ingrese número de serie para documento en version nueva<br></label>';
                        estado = false;
                    }
                } else {
                    if ($('#docSerieNumero').val() == '') {
                        mensaje += '<label>Ingrese número de documento<br></label>';
                        estado = false;
                    }
                }
            }
        });
        if ($('#fechaCobranza').val() == '') {
            mensaje += '<label>Ingrese fecha de cobro<br></label>';
            estado = false;
        } else {
            if (!verficarFecha($('#fechaCobranza').val())) {
                mensaje += '<label>Formato de fecha incorrecta<br></label>';
                estado = false;
            }
        }
        if ($('#montoAmortizar').val() == '' || $('#montoAmortizar').val() < 1) {
            mensaje += '<label>Especifique monto y/o monto debe ser mayor<br></label>';
            estado = false;
        }

        if (!estado) {
            $(this).removeClass('disabled').removeAttr('disabled');
            $('#evento').append(mensaje);
            $('#dErrores').dialog('open');
        } else {
            $('#lTipoOperacion').text('').text($("input[name=tipoPago]:checked").val().toUpperCase());
            if ($("input[name=tipoPago]:checked").val() == 'normal') {
                if (parseFloat($('#montoAmortizar').val()) > parseFloat($('#lSaldo').text())) {
                    $('#dConfirmarSaldoFavor').dialog('open');
                } else {
                    $('#dAmortizarConfirmar').dialog('open');
                }
            } else {
                $('#dAmortizarConfirmar').dialog('open');
            }
        }
    });

    function persona(codPersona) {
        $('#lMensajeBuscarCliente').text('Iniciando búsqueda por código:' + codPersona);
        try {
            var data = "codPersona=" + codPersona;
            $.ajax({
                type: "post",
                url: "ajax/personaDatos.jsp",
                data: data,
                error: callback_error,
                success: personaDatosRecuperar_callback
            });
        } catch (ex) {
            $('#lMensajeBuscarCliente').text('(Error ajax) ' + ex);
        }
    }
    ;

    function ventaCreditoLetra(codPersona) {
        try {
            var data = "codPersona=" + codPersona;
            $.ajax({
                type: "post",
                url: "ajax/ventaCreditoLetra.jsp",
                data: data,
                error: callback_error,
                success: ventaCreditoLetraRecuperar_callback
            });
        } catch (ex) {
            $('#lMensajeBuscarCliente').text('(Error ajax) ' + ex);
        }
    }
    ;

    function fCobranza(codPersona) {
        var data = "codPersona=" + codPersona;
        try {
            $.ajax({
                type: "post",
                url: "ajax/cobranza.jsp",
                data: data,
                error: callback_error,
                success: cobranzaRecuperar_callback
            });
        } catch (ex) {
            alert(ex);
        }
    }
    ;

    function personaDatosRecuperar_callback(ajaxResponse, textStatus) {
        reiniciarTablas();
        var personaDatos = procesarRespuesta(ajaxResponse);
        if (personaDatos[0].error) {
            $('#lMensajeBuscarCliente').text(personaDatos[0].error);
            $('#codPersonaAux').val('0');
            return;
        }
        $('#lCodPersona').text(personaDatos[0].codPersona);
        $('#codPersonaAux').val(personaDatos[0].codPersona);
        $('#lNombresC').text(personaDatos[0].nombresC);
        $('#lDireccion').text(personaDatos[0].direccion);

        $('#lEmpresaConvenio').text(personaDatos[0].empresaConvenio);
        $('#lCodCobranza').text(personaDatos[0].codCobranza);
        $('input[name=tipoRecibo]').each(function() {
            var checkbox = $(this);
            if (checkbox.is(':checked')) {
                if ($(this).val() == 'TKR') {
                    $('#lDocSerieNumeroRecibo').text('TKR-');
                } else {
                    $('#lDocSerieNumeroRecibo').text(personaDatos[0].codCobranza + '-');
                }
            }
        });
        $('#lCondicion').text(personaDatos[0].condicion);
        $('#lSaldoFavor').text(personaDatos[0].saldoFavor);
        $('#auxSaldoFavor').val(personaDatos[0].saldoFavor);
        $('#marcaSaldoFavor').val('0');

        ventaCreditoLetra(personaDatos[0].codPersona);
        $('#tbVentasDetalle').find('tr').remove();//remover datos
        fCobranza(personaDatos[0].codPersona);
    }

    function ventaCreditoLetraRecuperar_callback(ajaxResponse, textStatus) {
//        alert(ajaxResponse);
        var $tbVentaCreditoLetras = $('#tbVentaCreditoLetras');
        var ventaCreditoLetraArray = procesarRespuesta(ajaxResponse);
        if (!ventaCreditoLetraArray) {
            alert("Error en consulta de letras credito");
            return;
        }
        $tbVentaCreditoLetras.find('tr').remove();
//        alert(ventaCreditoLetraArray.length);
        if (ventaCreditoLetraArray.length == 1) {//si no hay venta al credito
            $tbVentaCreditoLetras.append(
                    '<tr>' +
                    '<td colspan="9">No hay ventas al crédito para este cliente.</td>' +
                    '</tr>'
                    );
        }
        var ventaCreditoLetraItem;
        for (var idx = 0; idx < ventaCreditoLetraArray.length; idx++) {
            ventaCreditoLetraItem = ventaCreditoLetraArray[idx];
            if (idx == ventaCreditoLetraArray.length - 1) {
                $('#lTotal').text(ventaCreditoLetraItem.mTotal);
                $('#lAmortizado').text(ventaCreditoLetraItem.mAmortizado);
                $('#lSaldo').text(ventaCreditoLetraItem.mSaldo);
            } else {
                $tbVentaCreditoLetras.append(
                        '<tr id="' + ventaCreditoLetraItem.codVentaCreditoLetra + '" class="' + ventaCreditoLetraItem.codVentas + '" title="' + ventaCreditoLetraItem.docNumeroSerie + '">' +
                        '<td style="width: 80px; background-color:' + ventaCreditoLetraItem.estilo + '">' + ventaCreditoLetraItem.docNumeroSerie + '</td>' +
                        '<td style="width: 65px; background-color:' + ventaCreditoLetraItem.estilo + '">' + ventaCreditoLetraItem.detalleLetra + '</td>' +
                        '<td style="width: 65px; background-color:' + ventaCreditoLetraItem.estilo + '">' + ventaCreditoLetraItem.fechaVencimiento + '</td>' +
                        '<td style="width: 45px; text-align: right;background-color:' + ventaCreditoLetraItem.estilo + '">' + ventaCreditoLetraItem.monto + '</td>' +
                        '<td style="width: 45px; text-align: right;background-color:' + ventaCreditoLetraItem.estilo + '">' + ventaCreditoLetraItem.totalPago + '</td>' +
                        '<td style="width: 65px; background-color:' + ventaCreditoLetraItem.estilo + '">' + ventaCreditoLetraItem.fechaPago + '</td>' +
                        '<td style="width: 25px; text-align: right;background-color:' + ventaCreditoLetraItem.estilo + '">' + ventaCreditoLetraItem.diasRetraso + '</td>' +
                        '<td style="width: 45px; text-align: right;background-color:' + ventaCreditoLetraItem.estilo + '">' + '0' + '</td>' +
                        '<td style="text-align: right; background-color:' + ventaCreditoLetraItem.estilo + '">' + ventaCreditoLetraItem.saldo + '</td>' +
                        '</tr>'
                        );
                $('#' + ventaCreditoLetraItem.codVentaCreditoLetra).bind('click', function(event) {
                    ventasDetalle($(this).attr('id'));
                });
                $('#' + ventaCreditoLetraItem.codVentaCreditoLetra).bind('dblclick', function(event) {
                    $('#aux').val($(this).attr('class'));
                    $('#auxDocSerieNumero').val($(this).attr('title'));
                    $('#dConfirmarFiltro').dialog('open');
                });
//                $('#EmpresaConvenio').
            }
        }

    }

    function ventasDetalle(codVentaCreditoLetra) {
        try {
            var data = "codVentaCreditoLetra=" + codVentaCreditoLetra;
            $.ajax({
                type: "post",
                url: "ajax/ventasDetalle.jsp",
                data: data,
                error: callback_error,
                success: ventasDetalleRecuperar_callback
            });
        } catch (ex) {
            alert(ex);
        }
    }

    function ventasDetalleRecuperar_callback(ajaxResponse, textStatus) {
        var ventasDetalleArray = procesarRespuesta(ajaxResponse);
        var $tbVentasDetalle = $('#tbVentasDetalle');
        $tbVentasDetalle.find('tr').remove();
        var ventasDetalleItem;
        for (var idx = 0; idx < ventasDetalleArray.length; idx++) {
            ventasDetalleItem = ventasDetalleArray[idx];
            $tbVentasDetalle.append(
                    '<tr>' +
                    '<td style="width: 80px;height: 14px;">' + ventasDetalleItem.docSerieNumero + '</td>' +
                    '<td style="width: 25px;">' + ventasDetalleItem.cantidad + '</td>' +
                    '<td style="width: 225px;">' + ventasDetalleItem.descripcion + '</td>' +
                    '<td style="width: 50px;text-align: right;">' + ventasDetalleItem.precioVenta + '</td>' +
                    '<td style="text-align: right;">' + ventasDetalleItem.valorVenta + '</td>' +
                    '</tr>'
                    );
        }
    }
    ;

    function cobranzaRecuperar_callback(ajaxResponse, textStatus) {
        var cobranzaArray = procesarRespuesta(ajaxResponse);
        var $tCobranza = $('#tCobranza');
        var cobranzaItem;
        for (var idx = 0; idx < cobranzaArray.length; idx++) {
            cobranzaItem = cobranzaArray[idx];
            $tCobranza.append(
                    '<tr id="' + cobranzaItem.codCobranza + '" class="' + cobranzaItem.observacion + '">' +
                    '<td style="width: 65px;">' + cobranzaItem.fechaCobranza + '</td>' +
                    '<td style="width: 45px;text-align: right;">' + cobranzaItem.importe + '</td>' +
                    '<td style="width: 80px;">' + cobranzaItem.docSerieNumero + '</td>' +
                    '<td style="text-align: right;">' + cobranzaItem.saldo + '</td>' +
                    '</tr>'
                    );
            $('#' + cobranzaItem.codCobranza).bind('click', function(event) {
                $('#tCobranzaDetalle').find('tr').remove();
                $('#tCobranzaDetalle').append(
                        '<tr>' +
                        '<td>' + $(this).attr('class') + '</td>' +
                        '</tr>'
                        );
                $('#cobranzaImprimir').attr('href', 'reporte/cobranzaImprimir.jsp?codCobranza=' + $(this).attr('id'));
            });
            $('#' + cobranzaItem.codCobranza).bind('dblclick', function(event) {
                $('#auxCodCobranza').val($(this).attr('id'));
                $('#dCobranzaEliminar').dialog('open');
            });
        }
    }

    function callback_error(XMLHttpRequest, textStatus, errorThrown) {
        // en ambientes serios esto debe manejarse con mucho cuidado, aqui optamos por una solucion simple
        $('#lMensajeBuscarCliente').text('(Error servidor) ' + errorThrown);
    }
    ;
    // recuperamos la informacion que nos ha enviado el servidor
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

    function reiniciarTablas() {
        $('#tCobranza').find('tr').remove();
        $('#tCobranzaDetalle').find('tr').remove();
        $('#tbVentaCreditoLetras').find('tr').remove();
        $('#tCobranzaDetalle').find('tr').remove();
        $('#lSaldoFavor').text('0.00');
        $('#auxSaldoFavor').val('0.00');
        $('#marcaSaldoFavor').val('0');
        $('#lTotal').text('');
        $('#lAmortizado').text('');
        $('#lSaldo').text('');


        $('#lCodPersona').text('Cod Cliente');
        $('#codPersonaAux').val('0');
        $('#codVentas').val('0');
        $('#lNombresC').text('Nombres/Razón Social');
        $('#lDireccion').text('Dirección');

        $('#lEmpresaConvenio').text('Empresa/Convenio');
        $('#lCondicion').text('Condición');
        $('#cobranzaImprimir').attr('href', 'reporte/cobranzaImprimir.jsp');
    }
    ;

    function verficarFecha(value) {
        var check = false;
        var re = /^\d{1,2}\/\d{1,2}\/\d{4}$/;
        if (re.test(value)) {
            var adata = value.split('/');
            var gg = parseInt(adata[0], 10);
            var mm = parseInt(adata[1], 10);
            var aaaa = parseInt(adata[2], 10);
            var xdata = new Date(aaaa, mm - 1, gg);
            if ((xdata.getFullYear() == aaaa) && (xdata.getMonth() == mm - 1) && (xdata.getDate() == gg))
                check = true;
            else
                check = false;
        } else {
            check = false;
        }
        return check;
    }
    ;

    function amortizar() {
        $('#bAmortizar').addClass('disabled').attr('disabled', 'disabled');
        var accion = 'accionCobranza=r';
        var codPersona = '&codPersona=' + $('#codPersonaAux').val();
        var docSerieNumero = '&docSerieNumero=' + $('#docSerieNumero').val();
        var fechaCobranza = '&fechaCobranza=' + $('#fechaCobranza').val();
        var montoAmortizar = '&montoAmortizar=' + $('#montoAmortizar').val();
        var tipo = '&tipo=' + $("input[name=tipoPago]:checked").val();
        var version = '&version=' + $("input[name=version]:checked").val();
        if ($("input[name=version]:checked").val() == 'nueva') {
            accion = 'accionCobranza=registrarVersionNueva';
            alert('hola');
        }
        var tipoRecibo = '&tipoRecibo=' + $("input[name=tipoRecibo]:checked").val();
        var codVentas = '&codVentas=' + $('#codVentas').val();
        var saldoFavor = '&saldoFavor=' + $('#marcaSaldoFavor').val();
        if ($('#marcaSaldoFavor').val() == '1') {
            if ($("input[name=tipoPago]:checked").val() == 'anticipo') {
                alert('No se puede usar saldo a favor en un anticipo');
                return;
            }
            if ($('#montoAmortizar').val() > $('#auxSaldoFavor').val()) {
                alert('El monto especificado supera al saldo a favor actual');
                return;
            }
        }
        var data = accion + codPersona + docSerieNumero + fechaCobranza + montoAmortizar + tipo + version + tipoRecibo + codVentas + saldoFavor;
        return;
        try {
            $.ajax({
                type: "get",
                url: "../sCobranza",
                data: data,
                beforeSend: guardandoCobranza,
                error: callback_error,
                success: cobranza_callback
            });
        } catch (ex) {
            alert(ex);
        }
    }
    ;

    function eliminarCobranza() {
        var data = 'accionCobranza=eliminar&codCobranza=' + $('#auxCodCobranza').val();
        try {
            $.ajax({
                type: "get",
                url: "../sCobranza",
                data: data,
//                beforeSend: guardandoCobranza,
                error: callback_error,
                success: cobranzaEliminar_callback
            });
        } catch (ex) {
            alert(ex);
        }
    }

    function cobranzaEliminar_callback(respuesta) {
        var expresion = /^-?(?:\d+|\d{1,3}(?:,\d{3})+)?(?:\.\d+)?$/;
        if (respuesta.match(expresion)) {
            persona($('#codPersonaAux').val());
            $('#tipo2').removeAttr('checked');
            $('#tipo1').attr('checked', 'checked');
            $('#docSerieNumero').val('').removeAttr('readonly');
            $('#fechaCobranza').val($('#auxFecha').val());
            $('#montoAmortizar').val('');
//            $('#cobranzaImprimir').attr('href', 'reporte/cobranzaImprimir.jsp?codCobranza=' + respuesta);
            $('#bAmortizar').removeClass('disabled').removeAttr('disabled');
            $('#lMensajeAlerta').text("Eliminación exitosa.");
            $('#dMensajeAlerta').dialog('open');
//            $('#dAmortizarConfirmar').dialog('close');
        } else {
            $('#lMensajeAlerta').text(respuesta);
            $('#dMensajeAlerta').dialog('open');
        }
    }
    ;
    function guardandoCobranza() {

    }
    ;

    function cobranza_callback(respuesta) {
        var expresion = /^-?(?:\d+|\d{1,3}(?:,\d{3})+)?(?:\.\d+)?$/;
        if (respuesta.match(expresion)) {
//            alert(respuesta)
            persona($('#codPersonaAux').val());
            $('#tipo2').removeAttr('checked');
            $('#tipo1').attr('checked', 'checked');
            $('#docSerieNumero').val('').removeAttr('readonly');
            $('#fechaCobranza').val($('#auxFecha').val());
            $('#montoAmortizar').val('');
            $('#cobranzaImprimir').attr('href', 'reporte/cobranzaImprimir.jsp?codCobranza=' + respuesta);
            $('#bAmortizar').removeClass('disabled').removeAttr('disabled');
            $('#dAmortizarConfirmar').dialog('close');
        }
        else {
            $('#lMensajeAlerta').text(respuesta);
            $('#dMensajeAlerta').dialog('open');
        }
    }
    ;

});
