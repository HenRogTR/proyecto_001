/* 
 * To change this template, choose Tools | Templates
 * and open the template in the editor.
 */

$(document).ready(function() {


    $('#docRecCaja').change(function(event) {
        fTipoCambiar(this.value);
    });
    $('#fechaCobranza')
            .mask('00/00/0000')
            .datepicker({
                changeMonth: true,
                changeYear: true
            })
            .blur(function() {
                if (!fValidarFecha(this.value)) {
                    this.value = '';
                }
            });
    $('#serie').mask('000');

    $('#montoAmortizar')
            .mask('0999999999999.99')
            .blur(function(event) {
                if (this.value != '') {
                    this.value = fNumeroFormato(this.value, 2, false);
                }
            });

    $('#docSerieNumero').mask('SZZ-000-000000', {translation: {'Z': {pattern: /[a-zA-Z0-9]/, optional: true}}});

    $("input[name=tipoCobro]").click(function(event) {
        $('#dDescuento').addClass('ocultar');
        $('#dCaja').addClass('ocultar');
        $('#dManual').addClass('ocultar');
        switch (this.value) {
            case 'caja':
                $('#dCaja').removeClass('ocultar');
                break;
            case 'descuento':
                $('#dDescuento').removeClass('ocultar');
                break;
            case 'manual':
                $('#dManual').removeClass('ocultar');
                break;
        }
    });

    //<editor-fold defaultstate="collapsed" desc="BOTONES. Clic en el signo + de la izquierda para mas detalles.">
    $('#bBuscarCliente').click(function(event) {
        $("#dClienteBuscar").dialog('open');
        event.preventDefault();
    });

    $('#bAmortizar').click(function(event) {
        $(this).addClass('disabled').attr('disabled', 'disabled');
        fVerificarDatos();
    });

    $('#bSaldoFavorUsar').click(function(event) {
        var saldoFavor = parseFloat($('#auxSaldoFavor').val());
        if (saldoFavor <= 0) {
            fAlerta('No hay saldo a favor disponible');
            return;
        }
        $('#dSaldoFavorConfirmar').dialog('open');
    });

    $('#bImprimirTicket').click(function(event) {
        event.preventDefault();
        if ($('#auxCodCobranza2').val() == '' || $('#auxCodCobranza2').val() < 1) {
            fAlerta('No se puede imprimir ticket');
            return;
        }
        var data = {
            accionCobranza: 'imprimirTicket',
            codCobranza: $('#auxCodCobranza2').val()
        };
        var url = '../sCobranza';
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
                    if ($.isNumeric(ajaxResponse)) {
                        fAlerta('Impresion exitosa');
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
    });
    //</editor-fold>

    $('#codClienteBuscar')
            .mask('#', {maxlength: false})
            .keyup(function(e) {
                var key = e.charCode ? e.charCode : (e.keyCode ? e.keyCode : 0);
                if (key == 13) {
                    if (!isNaN($(this).val()) & $(this).val() > 0) {
                        fClienteLeer(parseInt($(this).val(), 10), '');
//                        $("#dClienteBuscar").dialog('close');
                        $(this).val('');
                    }
                    e.preventDefault();
                }
            });
});
//<editor-fold defaultstate="collapsed" desc="$(function(){}). Clic en el signo + de la izquierda para mas detalles.">
$(function() {
    $("#dClienteBuscar").dialog({
        autoOpen: false,
        modal: true,
        resizable: true,
        height: 200,
        width: 800,
        buttons: {
            Cerrar: function() {
                $(this).dialog("close");
            }
        },
        close: function() {
            $(this).dialog("close");
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
                fAmortizar();
                $(this).dialog("close");
            },
            No: function() {
                $('#bAmortizar').removeClass('disabled').removeAttr('disabled');
                $(this).dialog("close");
            }
        },
        close: function() {
            $('#bAmortizar').removeClass('disabled').removeAttr('disabled');
        }
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
        }
    });

    $('#dConfirmarFiltro').dialog({
        autoOpen: false,
        modal: true,
        resizable: true,
        height: 150,
        width: 500,
        buttons: {
            Si: function() {
                $('#codVenta').val($('#aux').val());
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
        }
    });

    $('#dSaldoFavorConfirmar').dialog({
        autoOpen: false,
        modal: true,
        resizable: true,
        height: 180,
        width: 500,
        buttons: {
            Si: function() {
                $('#dUsarSaldoFavor').removeClass('ocultar');
                $('#dNoUsarSaldoFavor').addClass('ocultar');
                $('#montoAmortizar').val($('#auxSaldoFavor').val());
                $('#marcaSaldoFavor').val('1');
                $(this).dialog("close");
            },
            No: function() {
                $(this).dialog("close");
            }
        },
        close: function() {
        }
    });

    $('#dCobranzaEliminar').dialog({
        autoOpen: false,
        modal: true,
        resizable: true,
        height: 150,
        width: 500,
        buttons: {
            Si: function() {
                fEliminarCobranza();
                $(this).dialog("close");
            },
            No: function() {
                $(this).dialog("close");
            }
        },
        close: function() {
        }
    });

    $('#dniPasaporteRucNombresCBuscar').autocomplete({
        source: 'autocompletado/dniPasaporteRucNombresCBuscar.jsp',
        minLength: 4,
        focus: clienteMarcado,
        select: clienteSeleccionado
    });
});
//</editor-fold>

//<editor-fold defaultstate="collapsed" desc="function clienteMarcado(event, ui). Clic en el signo + de la izquierda para mas detalles.">
function clienteMarcado(event, ui) {
    var cliente = ui.item.value;
    $('#codClienteBuscar').val(cliente.codCliente);
    $('#dniPasaporteRucNombresCBuscar').val(cliente.nombresC);
    event.preventDefault();
}
;
//</editor-fold>

//<editor-fold defaultstate="collapsed" desc="function clienteSeleccionado(event, ui). Clic en el signo + de la izquierda para mas detalles.">
function clienteSeleccionado(event, ui) {
    var cliente = ui.item.value;
    $('#codClienteBuscar').val('');
    $('#dniPasaporteRucNombresCBuscar').val('');
    fClienteLeer(parseInt(cliente.codCliente, 10), '');
    event.preventDefault();
}
;
//</editor-fold>

//<editor-fold defaultstate="collapsed" desc="function fClienteLeer(codCliente). Clic en el signo + de la izquierda para mas detalles.">
function fClienteLeer(codCliente) {
    $('#dClienteBuscar').dialog('close');
    var data = {codCliente: codCliente};
    var url = 'ajax/clienteLeer.jsp';
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
                var clienteArray = procesarRespuesta(ajaxResponse);
                if (clienteArray.length > 0) {
                    $('.vaciar').empty();
                    fReiniciarCobranza();
                    var clienteItem = clienteArray[0];
                    $('#codCliente').val(clienteItem.codCliente);
                    $('#sCodCliente').append(clienteItem.codCliente);
                    $('#sNombresC').append(clienteItem.nombresC);
                    $('#sDireccion').append(clienteItem.direccion);
                    $('#sEmpresaConvenio').append(clienteItem.empresaConvenio);
                    $('#sCodCobranza').append(clienteItem.codCobranza);
                    $('#auxCodCobranza').val(clienteItem.codCobranza);
                    $('#docRecDesc').empty().append('<option value="' + clienteItem.codCobranza + '">' + clienteItem.codCobranza + '</option>');
                    fCodCobranzaOtrosBuscar(clienteItem.codEmpresaConvenio);
                    $('#sCondicion').append(clienteItem.condicion);
                    $('#sTipoD').append(clienteItem.codCobranza);
                    $('#sSaldoFavor').append(clienteItem.saldoFavor);
                    $('#auxSaldoFavor').val(clienteItem.saldoFavor);
                    $('#marcaSaldoFavor').val('0');
                    fDeudaResumen(codCliente);
                    $('#tCobranza').empty();
                    fCobranzaResumen(codCliente);
                    $('#dProcesandoPeticion').dialog('close');
                    $('#tbVentaCreditoLetras').empty();
                    fVentaCreditoLetraResumen(codCliente);
                    vCLResumenMensual(codCliente);
                } else {
                    fAlerta('Cliente no encontrada.');
                }
            },
            statusCode: {
                404: function() {
                    $('#lServidorError').text('Página no encontrada(clienteLeer.jsp).');
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

//<editor-fold defaultstate="collapsed" desc="function fVentaDetalle(codVenta). Clic en el signo + de la izquierda para mas detalles.">
function fVentaDetalle(codVenta) {
    var data = {codVenta: codVenta};
    var url = 'ajax/ventaDetalleLeer.jsp';
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
                var VDArray = procesarRespuesta(ajaxResponse);
                var $tbVentasDetalle = $('#tbVentasDetalle');
                $tbVentasDetalle.empty();
                var VDItem;
                for (var i = 0; i < VDArray.length; i++) {
                    VDItem = VDArray[i];
                    $tbVentasDetalle.append(
                            '<tr>' +
                            '<td style="width: 80px;height: 14px;">' + VDItem.docSerieNumero + '</td>' +
                            '<td style="width: 25px;">' + VDItem.cantidad + '</td>' +
                            '<td style="width: 225px;">' + VDItem.descripcion + '</td>' +
                            '<td style="width: 50px;text-align: right;">' + VDItem.precioVenta + '</td>' +
                            '<td style="text-align: right;">' + VDItem.valorVenta + '</td>' +
                            '</tr>'
                            );
                }
            },
            statusCode: {
                404: function() {
                    $('#lServidorError').text('Página no encontrada(ajax/ventaDetalleLeer.jsp).');
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

//<editor-fold defaultstate="collapsed" desc="function fDeudaResumen(codCliente). Clic en el signo + de la izquierda para mas detalles.">
function fDeudaResumen(codCliente) {
    var data = {codCliente: codCliente};
    var url = 'ajax/deudaResumenLeer.jsp';
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
                var DRItem = procesarRespuesta(ajaxResponse)[0];
                $('#lTotal').text(DRItem.mTotal);
                $('#lAmortizado').text(DRItem.mAmortizado);
                $('#lSaldo').text(DRItem.mSaldo);
            },
            statusCode: {
                404: function() {
                    $('#lServidorError').text('Página no encontrada(ajax/deudaResumenLeer.jsp).');
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

//<editor-fold defaultstate="collapsed" desc="fCobranzaResumen(codCliente). Clic en el signo + de la izquierda para mas detalles.">
function fCobranzaResumen(codCliente) {
    var data = {codCliente: codCliente};
    var url = 'ajax/cobranzaResumen.jsp';
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
                var CArray = procesarRespuesta(ajaxResponse);
                var $tCobranza = $('#tCobranza');
                var CItem;
                $('#tCobranzaDetalle').find('tr').remove();
                for (var i = 0; i < CArray.length; i++) {
                    CItem = CArray[i];
                    $tCobranza.append(
                            '<tr id="' + CItem.codCobranza + '" class="' + CItem.observacion + '">' +
                            '<td style="width: 65px;">' + CItem.fechaCobranza + '</td>' +
                            '<td style="width: 45px;text-align: right;">' + CItem.importe + '</td>' +
                            '<td style="width: 90px;">' + CItem.docSerieNumero + '</td>' +
                            '<td style="text-align: right;">' + CItem.saldo + '</td>' +
                            '</tr>'
                            );
                    $('#' + CItem.codCobranza).bind('click', function(event) {
                        $('#tCobranzaDetalle').find('tr').remove();
                        $('#tCobranzaDetalle').append(
                                '<tr>' +
                                '<td>' + $(this).attr('class') + '</td>' +
                                '</tr>'
                                );
                        $('#cobranzaImprimir').attr('href', 'reporte/cobranzaImprimir.jsp?codCobranza=' + $(this).attr('id'));
                        $('#auxCodCobranza2').val($(this).attr('id'));
                    });
                    $('#' + CItem.codCobranza).bind('dblclick', function(event) {
                        $('#auxCodCobranza').val($(this).attr('id'));
                        $('#dCobranzaEliminar').dialog('open');
                    });
                    if (i == CArray.length - 1) {
                        $('#tCobranzaDetalle').find('tr').remove();
                        $('#tCobranzaDetalle').append(
                                '<tr>' +
                                '<td>' + CItem.observacion + '</td>' +
                                '</tr>'
                                );
                        $('#cobranzaImprimir').attr('href', 'reporte/cobranzaImprimir.jsp?codCobranza=' + CItem.codCobranza);
                        $('#auxCodCobranza2').val(CItem.codCobranza);
                    }
                }
            },
            statusCode: {
                404: function() {
                    $('#lServidorError').text('Página no encontrada(ajax/cobranzaResumen.jsp).');
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

//<editor-fold defaultstate="collapsed" desc="fVerificarDatos(). Clic en el signo + de la izquierda para mas detalles.">
function fVerificarDatos() {
    var estado = false;
    $('#dMensajeAlertaDiv').empty();
    if (!$.isNumeric($('#codCliente').val())) {
        estado = true;
        $('#dMensajeAlertaDiv').append('*Seleccione cliente.<br>');
    }
    if (!fValidarFecha($('#fechaCobranza').val())) {
        estado = true;
        $('#dMensajeAlertaDiv').append('*Formato de fecha incorrecta.<br>');
    }
    if (!$.isNumeric($('#montoAmortizar').val())) {
        estado = true;
        $('#dMensajeAlertaDiv').append('*Ingrese monto.<br>');
    } else {
        if ($('#montoAmortizar').val() <= 1) {
            estado = true;
            $('#dMensajeAlertaDiv').append('*El monto a pagar debe ser mayor a 1.00.<br>');
        }
    }
    //tipo de doc
    if ($('#marcaSaldoFavor').val() == '0') {
        if ($("#rdCaja").is(":checked")) {
            if ($('#serieSelect').val() == '') {
                estado = true;
                $('#dMensajeAlertaDiv').append('*Seleccione serie del documento a generar.<br>');
            }
        }
        if ($("#rdDescuento").is(":checked")) {
            var $serie = $('#serie');
            if ($serie.val() == '' || $serie.val().length < 3) {
                estado = true;
                $('#dMensajeAlertaDiv').append('*Escriba la un formato de serie correcta para el descuento(XXX).<br>');
            }
        }
        if ($('#rdManual').is(':checked')) {
            if ($('#docSerieNumero').val() == '' || $('#docSerieNumero').val().length < 12) {
                estado = true;
                $('#dMensajeAlertaDiv').append('*Error en ingreso de documento manual (R-002-123456).<br>');
            }
        }
    }

    if (estado) {
        $('#bAmortizar').removeClass('disabled').removeAttr('disabled');
        $('#dMensajeAlerta').dialog('open');
    } else {
        $('#lTipoOperacion').text($("input[name=tipoPago]:checked").val());
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
}
;
//</editor-fold>

//<editor-fold defaultstate="collapsed" desc="function fAmortizar(. Clic en el signo + de la izquierda para mas detalles.">
function fAmortizar() {
    var data = {
        accionCobranza: 'registrar',
        codCliente: $('#codCliente').val(),
        tipoPago: $("input[name=tipoPago]:checked").val(),
        tipoCobro: $("input[name=tipoCobro]:checked").val(),
        montoAmortizar: $('#montoAmortizar').val(),
        saldoFavor: $('#marcaSaldoFavor').val(),
        codVenta: $('#codVenta').val(),
        docRecCaja: $('#docRecCaja').val(),
        docRecDesc: $('#docRecDesc').val(),
        serieSelect: $('#serieSelect').val(),
        serie: $('#serie').val(),
        fechaCobranza: $('#fechaCobranza').val(),
        docSerieNumero: $('#docSerieNumero').val()

    };
    if (data.saldoFavor == '1') {
        if ($("input[name=tipoPago]:checked").val() == 'anticipo') {
            fAlerta('No se puede usar saldo a favor en un anticipo');
            return;
        }
        if ($('#montoAmortizar').val() > $('#auxSaldoFavor').val()) {
            fAlerta('El monto especificado supera al saldo a favor actual');
            return;
        }
    }
    var url = '../sCobranza';
    try {
        $.ajax({
            type: 'post',
            url: url,
            data: data,
            beforeSend: function() {
                $('#dProcesandoPeticion').dialog('open');
            },
            error: function(XMLHttpRequest, textStatus, errorThrown) {
                $('#lServidorError').text(errorThrown + '()');
                $('#dServidorError').dialog('open');
            },
            success: function(ajaxResponse, textStatus) {
                $('#dProcesandoPeticion').dialog('close');
                if ($.isNumeric(ajaxResponse)) {
                    fReiniciarCobranza();
                    fClienteLeer(ajaxResponse);
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
;
//</editor-fold>

//<editor-fold defaultstate="collapsed" desc="fVentaCreditoLetraResumen(codCliente). Clic en el signo + de la izquierda para mas detalles.">
function fVentaCreditoLetraResumen(codCliente) {
    var data = {codCliente: codCliente};
    var url = 'ajax/ventaCreditoLetraResumenLeer.jsp';
    try {
        $.ajax({
            type: 'post',
            url: url,
            data: data,
            beforeSend: function() {

            },
            error: function(XMLHttpRequest, textStatus, errorThrown) {
                $('#lServidorError').text(errorThrown + '(ajax/ventaCreditoLetraResumenLeer.jsp)');
                $('#dServidorError').dialog('open');
            },
            success: function(ajaxResponse, textStatus) {
                var $tbVentaCreditoLetras = $('#tbVentaCreditoLetras');
                var VCLResumenArray = procesarRespuesta(ajaxResponse);
                $('#tbVentasDetalle').empty();
                for (var i = 0; i < VCLResumenArray.length; i++) {
                    var VCLResumenItem = VCLResumenArray[i];
                    $tbVentaCreditoLetras.append(
                            '<tr id="' + VCLResumenItem.codVentaCreditoLetra + '" class="' + VCLResumenItem.codVenta + '" title="' + VCLResumenItem.docNumeroSerie + '">' +
                            '<td style="width: 80px; background-color:' + VCLResumenItem.estilo + '" class="' + VCLResumenItem.finalVenta + '">' + VCLResumenItem.docNumeroSerie + '</td>' +
                            '<td style="width: 65px; background-color:' + VCLResumenItem.estilo + '" class="' + VCLResumenItem.finalVenta + '">' + VCLResumenItem.detalleLetra + '</td>' +
                            '<td style="width: 65px; background-color:' + VCLResumenItem.estilo + '" class="' + VCLResumenItem.finalVenta + '">' + VCLResumenItem.fechaVencimiento + '</td>' +
                            '<td style="width: 45px; text-align: right;background-color:' + VCLResumenItem.estilo + '" class="' + VCLResumenItem.finalVenta + '">' + VCLResumenItem.monto + '</td>' +
                            '<td style="width: 45px; text-align: right;background-color:' + VCLResumenItem.estilo + '" class="' + VCLResumenItem.finalVenta + '">' + VCLResumenItem.totalPago + '</td>' +
                            '<td style="width: 65px; background-color:' + VCLResumenItem.estilo + '" class="' + VCLResumenItem.finalVenta + '">' + VCLResumenItem.fechaPago + '</td>' +
                            '<td style="width: 25px; text-align: right;background-color:' + VCLResumenItem.estilo + '" class="' + VCLResumenItem.finalVenta + '">' + VCLResumenItem.diasRetraso + '</td>' +
                            '<td style="width: 45px; text-align: right;background-color:' + VCLResumenItem.estilo + '" class="' + VCLResumenItem.finalVenta + '">' + '0' + '</td>' +
                            '<td style="text-align: right; background-color:' + VCLResumenItem.estilo + '" class="' + VCLResumenItem.finalVenta + '">' + VCLResumenItem.saldo + '</td>' +
                            '</tr>'
                            );
                    $('#' + VCLResumenItem.codVentaCreditoLetra).bind('click', function(event) {
                        fVentaDetalle($(this).attr('class'));
                    });
                    $('#' + VCLResumenItem.codVentaCreditoLetra).bind('dblclick', function(event) {
                        $('#aux').val($(this).attr('class'));
                        $('#auxDocSerieNumero').val($(this).attr('title'));
                        $('#dConfirmarFiltro').dialog('open');
                    });
                    if (i == 0) {
                        fVentaDetalle(VCLResumenItem.codVenta);
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

//<editor-fold defaultstate="collapsed" desc="fEliminarCobranza(). Clic en el signo + de la izquierda para mas detalles.">
function fEliminarCobranza() {
    var data = {
        accionCobranza: 'eliminar',
        codCobranza: $('#auxCodCobranza').val()
    };
    var url = '../sCobranza';
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
                if ($.isNumeric(ajaxResponse)) {
                    fAlerta('Se ha eliminado con exito');
                    fClienteLeer($('#codCliente').val());
                } else {
                    fAlerta('Error: ' + ajaxResponse);
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

//<editor-fold defaultstate="collapsed" desc="fTipoCambiar(tipo). Clic en el signo + de la izquierda para mas detalles.">
function fTipoCambiar(tipo) {
    var data = {tipo: tipo};
    var url = 'ajax/tipoCambiar.jsp';
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
                var $serieSelect = $('#serieSelect');
                $serieSelect.empty();
                var array = procesarRespuesta(ajaxResponse);
                for (var i = 0; i < array.length; i++) {
                    var item = array[i];
                    $serieSelect.append(
                            '<option value="' + item.serie + '">' + item.serie + '</option>'
                            );
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

//<editor-fold defaultstate="collapsed" desc="function fCodCobranzaOtrosBuscar(codEmpresaConvenio). Clic en el signo + de la izquierda para mas detalles.">
function fCodCobranzaOtrosBuscar(codEmpresaConvenio) {
    var data = {codEmpresaConvenio: codEmpresaConvenio};
    var url = 'ajax/codCobranzaOtros.jsp';
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
                var $serieSelect = $('#docRecDesc');
                var array = procesarRespuesta(ajaxResponse);
                for (var i = 0; i < array.length; i++) {
                    var item = array[i];
                    $serieSelect.append(
                            '<option value="' + item.tipo + '">' + item.tipo + '</option>'
                            );
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

//<editor-fold defaultstate="collapsed" desc="function fReiniciarCobranza(). Clic en el signo + de la izquierda para mas detalles.">
function fReiniciarCobranza() {
    $('#tipo1').prop('checked', true);
    $('#tipo2').prop('checked', false);
//    $('#rdCaja').prop('checked', true);
//    $('#rdDescuento').prop('checked', false);
//    $('#rdManual').prop('checked', false);
    $('#dUsarSaldoFavor').addClass('ocultar');
    $('#dNoUsarSaldoFavor').removeClass('ocultar');
//    $('#dCaja').removeClass('ocultar');
//    $('#dDescuento').addClass('ocultar');
//    $('#dManual').addClass('ocultar');
    $('#docSerieNumero').val('');
    $('#serieSelect').val('001');
    $('#montoAmortizar').val('');
    $('#fechaCobranza').val($('#auxFecha').val());
    $('#codVenta').val('0');
    $('#codPersonaAux').val('0');
    $('#aux').val('0');
    $('#auxDocSerieNumero').val('');
    $('#marcaSaldoFavor').val('0');
    $('#auxCodCobranza2').val('');
    $('#lFiltro').text('No se esta flitrando el pago.');
    $('#montoAmortizar').focus();
}
;
//</editor-fold>

function vCLResumenMensual(codCliente) {
    var data = {codCliente: codCliente};
    var url = 'ajax/ventaCreditoLetraResumenMensual.jsp';
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
                $('#dVentaCreditoLetraResumenMensual').empty().append(ajaxResponse);
            },
            statusCode: {
                404: function() {
                    $('#lServidorError').text('Página no encontrada(ventaCreditoLetraResumenMensual.jsp).');
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

//<editor-fold defaultstate="collapsed" desc=". Clic en el signo + de la izquierda para mas detalles.">

//</editor-fold>
function fPaginaActual() {
    $('#dProcesandoPeticion').dialog('open');
    fReiniciarCobranza();
    fClienteLeer($('#codCliente').val());
}
;