/* 
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */

$(document).ready(function(e) {
    //fecha de cobranza que se seleccionará o ingresará
    $('#fechaCobranza')
            .mask('00/00/0000')
            .datepicker({
                changeMonth: true,
                changeYear: true
            })
            //valida si pierde el foco
            .blur(function() {
                if (!fValidarFecha(this.value)) {
                    this.value = '';
                }
            });
    //Solo permite 3 números
    $('#serie').mask('000');
    //Permite un numero y los demas opcionales
    $('#montoAmortizar')
            .mask('0999999999999.99')
            .blur(function(event) {
                //si no esta vacio, se de formato al número ingresado (0.00)
                if (this.value != '') {
                    this.value = fNumeroFormato(this.value, 2, false);
                }
            })
            .keypress(function(e) {
                var key = e.charCode ? e.charCode : (e.keyCode ? e.keyCode : 0);
                //pasar el foco a bAmortizar
                if (key == 13) {
                    $('#bAmortizar').focus();
                    e.preventDefault();
                }
            });
    //permite una letra seguido de 2 letras-números+...
    $('#docSerieNumero').mask('SZZ-000-000000', {translation: {'Z': {pattern: /[a-zA-Z0-9]/, optional: true}}});
    //clic en uno de las tres formas de cobranza (descuento, caja o manual)
    $("input[name=tipoCobro]").click(function(event) {
        //se ocultan todos los div
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
    //obtiene todas las series asigandas a ese tipo de documento
    $('#docRecCaja').change(function(event) {
        fLeerSerieGenerada(this.value);
    });
    //Abre el dialog para buscar cliente
    $('#bClienteBuscar').click(function(event) {
        $("#dClienteBuscar").dialog('open');
        event.preventDefault();
    });
    //boton amortizar
    $('#bAmortizar').click(function(e) {
        if (!($(this).hasClass('disabled'))) {
            $(this).addClass('disabled').prop('disabled', true);
            $('#d_estadoProceso').html('Se estan validando los datos antes de amortizar.<br>Espere por favor.');
            fVerificarDatos();
        } else {
            fAlerta($('#d_estadoProceso').html());
        }
        e.preventDefault();
    });
    //boton saldo a favor
    $('#bSaldoFavorUsar').click(function(event) {
        var saldoFavor = parseFloat($('#auxSaldoFavor').val());
        if (saldoFavor <= 0) {
            fAlerta('No hay saldo a favor disponible');
            return;
        }
        $('#dSaldoFavorConfirmar').dialog('open');
    });
    //boton imprimir ticket
    $('#bImprimirTicket').click(function(event) {
        event.preventDefault();
        var $auxCodCobranza2 = $('#auxCodCobranza2');
        if (!$.isNumeric($auxCodCobranza2.val()) || $auxCodCobranza2.val() <= 0) {
            fAlerta('Ticket no seleccionado/cliente sin pago realizado.');
            return;
        }
        var data = {
            accionCobranza: 'imprimirTicket',
            codCobranza: $auxCodCobranza2.val()
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
    // input código cliente buscar
    $('#codClienteBuscar')
            //solo permite números enteros
            .mask('#', {maxlength: false})
            .keyup(function(e) {
                var key = e.charCode ? e.charCode : (e.keyCode ? e.keyCode : 0);
                if (key == 13) {
                    //si existe un número en la entrada se busca cliente
                    if ($.isNumeric(this.value)) {
                        fClienteLeer(parseInt(this.value, 10));
                        $(this).val('');
                    }
                    e.preventDefault();
                }
            });
});

//<editor-fold defaultstate="collapsed" desc="$(function() {}). Clic en  + para más detalles.">
$(function() {
    $('#fechaCobranza')
            .datepicker({
                changeMonth: true,
                changeYear: true
            });

    $('#dClienteBuscar').dialog({
        autoOpen: false,
        modal: true,
        resizable: true,
        height: 200,
        width: 800,
        buttons: {
            Cerrar: function() {
                $(this).dialog('close');
            }
        },
        close: function() {
            $(this).dialog("close");
        }
    });

    $('#d_filtroConfirmar').dialog({
        autoOpen: false,
        modal: true,
        resizable: true,
        height: 170,
        width: 500,
        buttons: {
            Si: function() {
                //docSerieDocumento que se hizo doble clic
                var docSerieNumero = $('#auxDocSerieNumero').val();
                //se asigna el codVenta para registrarlo.
                $('#codVenta').val($('#aux').val());
                $('#lFiltro').text('Se esta filtrando por Doc: ' + $('#auxDocSerieNumero').val());
                //actualizar los montos totales
                var deudaTotal = 0.00;
                var pagadoTotal = 0.00;
                var saldoTotal = 0.00;
                $("#tVentaCreditoLetra tbody tr").each(function(index) {
                    var $tr = $(this);
                    if ($tr.hasClass(docSerieNumero)) {
                        deudaTotal += parseFloat($tr.find('td.montoLetra').text()) + parseFloat($tr.find('td.interes').text());
                        pagadoTotal += parseFloat($tr.find('td.pagoLetra').text());
                        saldoTotal += parseFloat($tr.find('td.saldoLetra').text());
                    } else {
                        $tr.addClass('ocultar');
                    }
                });
                $('#lTotal').text(fNumeroFormato(deudaTotal, 2, false));
                $('#lAmortizado').text(fNumeroFormato(pagadoTotal, 2, false));
                $('#lSaldo').text(fNumeroFormato(saldoTotal, 2, false));
                $('#tabla_deudaResumen')
                        .find('.vaciar').removeClass('ocultar')
                        .next('.esperando').addClass('ocultar');
                $(this).dialog('close');
            },
            No: function() {
                $('#lFiltro').text('No se esta filtrando el pago');
                $('#codVenta').val('0');
                //desocultar todos las letras
                var $tbVentaCreditoLetra = $('#tVentaCreditoLetra');
                $tbVentaCreditoLetra.find('tr').removeClass('ocultar');
                //se toman los datos de las varaibles auxiliares
                $('#lTotal').text($('#lTotalAuxiliar').text());
                $('#lAmortizado').text($('#lAmortizadoAuxiliar').text());
                $('#lSaldo').text($('#lSaldoAuxiliar').text());
                $(this).dialog('close');
            }
        },
        close: function() {
            $(this).dialog("close");
        }
    });

    //Diálogo en la cual pide confirmar que el saldo restante se usará como saldo favor.
    $('#dConfirmarSaldoFavor').dialog({
        autoOpen: false,
        modal: true,
        resizable: true,
        height: 200,
        width: 500,
        buttons: {
            Si: function() {
                $('#dAmortizarConfirmar').dialog('open');
                $(this).dialog('close');
                $('#bAmortizar').addClass('disabled').prop('disabled', true);
            },
            No: function() {
                $('#bAmortizar').removeClass('disabled').prop('disabled', false);
                $(this).dialog('close');
            }
        },
        close: function() {
            $('#bAmortizar').removeClass('disabled').prop('disabled', false);
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
                $('#bAmortizar').addClass('disabled').prop('disabled', true);
                fAmortizar();
                $(this).dialog('close');
            },
            No: function() {
                $('#bAmortizar').removeClass('disabled').prop('disabled', false);
                $(this).dialog("close");
            }
        },
        close: function() {
            $('#bAmortizar').removeClass('disabled').prop('disabled', false);
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
                $(this).dialog('close');
            },
            No: function() {
                $(this).dialog('close');
            }
        },
        close: function() {
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

    $('#nombresCDniPasaporteRucBuscar').autocomplete({
        source: 'autocompletado/dniPasaporteRucNombresCBuscar.jsp',
        minLength: 4,
        focus: clienteMarcado,
        select: clienteSeleccionado
    });

});
//</editor-fold>

//<editor-fold defaultstate="collapsed" desc="fClienteLeer(codCliente). Clic en  + para más detalles.">
function fClienteLeer(codCliente) {
    var data = {codCliente: codCliente};
    var url = 'ajax/cliente_codCliente.jsp';
    try {
        $.ajax({
            type: 'post',
            url: url,
            data: data,
            beforeSend: function() {
                $('.vaciar').addClass('ocultar');
                $('.esperando').removeClass('ocultar');
                $('.tablaDato').addClass('ocultar');
                $('.esperando_contenedor').removeClass('ocultar');
                $('.tabla_dato').addClass('ocultar');
            },
            error: function(XMLHttpRequest, textStatus, errorThrown) {
                $('#lServidorError').text(errorThrown + '()');
                $('#dServidorError').dialog('open');
            },
            success: function(ajaxResponse, textStatus) {
                var clienteArray = procesarRespuesta(ajaxResponse);
                var tamanio = clienteArray.length;
                if (tamanio == 0) {
                    $('.vaciar').removeClass('ocultar');
                    $('.esperando').addClass('ocultar');
                    $('.tablaDato').removeClass('ocultar');
                    $('.esperando_contenedor').addClass('ocultar');
                    $('.tabla_dato').removeClass('ocultar');
                    fAlerta('Cliente no encontrado.');
                } else {
                    var clienteItem = clienteArray[0];
                    $('#codCliente').val(clienteItem.codCliente);
                    $('#sCodCliente').text(clienteItem.codCliente);
                    $('#sNombresC').text(clienteItem.nombresC);
                    $('#sInteresEvitar').text(clienteItem.interesEvitar);
                    $('#sDireccion').text(clienteItem.direccion);
                    $('#sEmpresaConvenio').text(clienteItem.empresaConvenio);
                    $('#sCodCobranza').text(clienteItem.codCobranza);
                    $('#sCondicion').text(clienteItem.condicion);
                    $('#sTipoD').text(clienteItem.codCobranza);
                    $('#tabla_clienteDato')
                            .find('.vaciar').removeClass('ocultar')
                            .next('.esperando').addClass('ocultar'); //tabla clienteDato
                    $('#sSaldoFavor').text(clienteItem.saldoFavor);
                    $('#auxSaldoFavor').val(clienteItem.saldoFavor);
                    $('#tabla_tipo_saldoFavor')
                            .find('.vaciar').removeClass('ocultar')
                            .next('.esperando').addClass('ocultar'); //tabla tabla_tipo_saldoFavor
                    $('#auxCodCobranza').val(clienteItem.codCobranza);
                    $('#docRecDesc').empty().append('<option value="' + clienteItem.codCobranza + '">' + clienteItem.codCobranza + '</option>');
                    fProcesandoPeticionCerrar();
                    fCodCobranzaOtrosBuscar(clienteItem.codEmpresaConvenio);
                    $('#marcaSaldoFavor').val('0');
                    fCobranzaResumen(clienteItem.codCliente);
                    fVentaCreditoLetraResumen(clienteItem.codCliente);
                    fDeudaMes(clienteItem.codCliente);
                    $('#dClienteBuscar').dialog('close');
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

//<editor-fold defaultstate="collapsed" desc="function fLeerDocumentoCaja(). Clic en  + para más detalles.">
/**
 * 
 * @returns {undefined}
 */
function fLeerDocumentoCaja() {
    var url = 'ajax/documentoCaja.jsp';
    try {
        $.ajax({
            type: 'post',
            url: url,
            error: function(XMLHttpRequest, textStatus, errorThrown) {
                $('#lServidorError').text(errorThrown + '()');
                $('#dServidorError').dialog('open');
            },
            success: function(ajaxResponse, textStatus) {
                var $docRecCaja = $('#docRecCaja');
                var documentoArray = procesarRespuesta(ajaxResponse);
                var tam = documentoArray.length;
                $docRecCaja.empty();
                for (var i = 0; i < tam; i++) {
                    var documentoItem = documentoArray[i];
                    var $op1 = $('<option/>', {value: documentoItem.documentoCaja, text: documentoItem.documentoCaja}).appendTo($docRecCaja);
                    if (i == 0) {
                        fLeerSerieGenerada($op1.val());
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

//<editor-fold defaultstate="collapsed" desc="function fCodCobranzaOtrosBuscar(codEmpresaConvenio). Clic en  + para más detalles.">
/**
 * Busca otros códigos de descuento asigandos al cliente.
 * @param {String} codEmpresaConvenio
 * @returns {undefined}
 */
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
                var tam = array.length;
                for (var i = 0; i < tam; i++) {
                    var item = array[i];
                    var $op = $('<option/>', {value: item.tipo, text: item.tipo}).appendTo($serieSelect);
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

//<editor-fold defaultstate="collapsed" desc="function fCobranzaResumen(codCliente). Clic en  + para más detalles.">
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
                $tCobranza.empty().removeClass('ocultar');
                var tamanio = CArray.length;
                if (tamanio == 0) {             //si en caso no se ha hecho ningun pago
                    $('#tCobranzaDetalle').empty().removeClass('ocultar').next('.esperando_contenedor').addClass('ocultar');
                }
                for (var i = 0; i < tamanio; i++) {
                    var CItem = CArray[i];
                    var $tr = $('<tr/>', {id: CItem.codCobranza, 'class': 'tr_cobranza manoPuntero', title: CItem.observacion.replace(/<br>/gi, '\n')}).appendTo($tCobranza);
                    var $td1 = $('<td/>', {text: CItem.fechaCobranza, css: {'width': '65px'}}).appendTo($tr);
                    var $td2 = $('<td/>', {text: CItem.importe, 'class': 'derecha ancho100px', css: {'width': '45px'}}).appendTo($tr);
                    var $td3 = $('<td/>', {text: CItem.docSerieNumero, css: {'width': '90px'}}).appendTo($tr);
                    var $td4 = $('<td/>', {text: CItem.saldo, 'class': 'derecha'}).appendTo($tr);
                    var $cobranzaDetalle = $('<div/>', {html: CItem.observacion, 'class': 'cobranzaDetalle ocultar'}).appendTo($td4);
                    //el ultimo dato
                    if (i == tamanio - 1) {
                        f_cobranza_click($tr);
                    }
                }
                $('.tr_cobranza').bind('click', f_cobranza_click);
                $('.tr_cobranza').bind('dblclick', f_cobranza_dblclick);
                $tCobranza.next('.esperando_contenedor').addClass('ocultar');
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

//<editor-fold defaultstate="collapsed" desc="function fVentaCreditoLetraResumen(codCliente). Clic en  + para más detalles.">
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
                var $tbVentaCreditoLetra = $('#tVentaCreditoLetra');
                var VCLResumenArray = procesarRespuesta(ajaxResponse);
                $tbVentaCreditoLetra.empty().removeClass('ocultar');
                var tamanio = VCLResumenArray.length;
                if (tamanio == 0) {                                             //si en caso no hay ventas al crédito
                    $('#t_ventaDetalle').empty().removeClass('ocultar').next('.esperando_contenedor').addClass('ocultar');
                }
                var deudaTotal = 0.00;
                var pagadoTotal = 0.00;
                var saldoTotal = 0.00;
                for (var i = 0; i < tamanio; i++) {
                    var VCLResumenItem = VCLResumenArray[i];
                    var $tr = $('<tr/>', {id: VCLResumenItem.codVentaCreditoLetra, 'class': 'tr_ventaCreditoLetra manoPuntero ' + VCLResumenItem.docNumeroSerie, title: VCLResumenItem.docNumeroSerie}).appendTo($tbVentaCreditoLetra);
                    var $td1 = $('<td/>', {html: VCLResumenItem.docNumeroSerie, 'class': VCLResumenItem.finalVenta, css: {'width': 75, 'background-color': VCLResumenItem.estilo}}).appendTo($tr);
                    var $td2 = $('<td/>', {html: VCLResumenItem.detalleLetra, 'class': VCLResumenItem.finalVenta, css: {'width': 72, 'background-color': VCLResumenItem.estilo}}).appendTo($tr);
                    var $td3 = $('<td/>', {html: VCLResumenItem.fechaVencimiento, 'class': VCLResumenItem.finalVenta, css: {'width': 60, 'background-color': VCLResumenItem.estilo}}).appendTo($tr);
                    var $td4 = $('<td/>', {html: VCLResumenItem.monto, 'class': VCLResumenItem.finalVenta + ' derecha montoLetra', css: {'width': 45, 'background-color': VCLResumenItem.estilo}}).appendTo($tr);
                    var $td5 = $('<td/>', {html: VCLResumenItem.interes, 'class': VCLResumenItem.finalVenta + ' derecha interes', css: {'width': 45, 'background-color': VCLResumenItem.estilo}}).appendTo($tr);
                    var $td6 = $('<td/>', {html: VCLResumenItem.totalPago, 'class': VCLResumenItem.finalVenta + ' derecha pagoLetra', css: {'width': 45, 'background-color': VCLResumenItem.estilo}}).appendTo($tr);
                    var $td7 = $('<td/>', {html: VCLResumenItem.fechaPago, 'class': VCLResumenItem.finalVenta + ' derecha', css: {'width': 60, 'background-color': VCLResumenItem.estilo}}).appendTo($tr);
                    var $td8 = $('<td/>', {html: VCLResumenItem.diasRetraso, 'class': VCLResumenItem.finalVenta + ' derecha', css: {'width': 25, 'background-color': VCLResumenItem.estilo}}).appendTo($tr);
                    var $td9 = $('<td/>', {html: VCLResumenItem.saldo, 'class': VCLResumenItem.finalVenta + ' derecha saldoLetra', css: {'background-color': VCLResumenItem.estilo}}).appendTo($tr);
                    //asigna al 6 pq marcaba error
                    var $codVenta = $('<span/>', {'class': 'codVenta ocultar', html: VCLResumenItem.codVenta}).appendTo($td7);
                    if (i == 0) {
                        f_ventaCreditoLetra_click($tr);
                    }
                    deudaTotal += (parseFloat(VCLResumenItem.monto) + parseFloat(VCLResumenItem.interes));
                    pagadoTotal += parseFloat(VCLResumenItem.totalPago);
                    saldoTotal += parseFloat(VCLResumenItem.saldo);
                }
                $('.tr_ventaCreditoLetra').bind('click', f_ventaCreditoLetra_click);
                $('.tr_ventaCreditoLetra').bind('dblclick', f_ventaCreditoLetra_dblclick);
                $tbVentaCreditoLetra.next('.esperando_contenedor').addClass('ocultar');

                $('#lTotal').text(fNumeroFormato(deudaTotal, 2, false));
                $('#lAmortizado').text(fNumeroFormato(pagadoTotal, 2, false));
                $('#lSaldo').text(fNumeroFormato(saldoTotal, 2, false));
                $('#tabla_deudaResumen')
                        .find('.vaciar').removeClass('ocultar')
                        .next('.esperando').addClass('ocultar');
                //Auxiliares para cuando se quite el filtro por venta
                $('#lTotalAuxiliar').text(fNumeroFormato(deudaTotal, 2, false));
                $('#lAmortizadoAuxiliar').text(fNumeroFormato(pagadoTotal, 2, false));
                $('#lSaldoAuxiliar').text(fNumeroFormato(saldoTotal, 2, false));
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

//<editor-fold defaultstate="collapsed" desc="function vCLResumenMensual(codCliente). Clic en  + para más detalles.">
function fDeudaMes(codCliente) {
    var data = {codCliente: codCliente};
    var url = 'ajax/deudaMes_codCliente.jsp';
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
                var $t_deudaMes = $('#t_deudaMes');
                var deudaMesArray = procesarRespuesta(ajaxResponse);
                var tamanio = deudaMesArray.length;
                $t_deudaMes.empty().removeClass('ocultar');
                for (var i = 0; i < tamanio; i++) {
                    var deudaMesItem = deudaMesArray[i];
                    var $tr = $('<tr/>').appendTo($t_deudaMes);
                    var $td1 = $('<td/>', {html: deudaMesItem.anioMes, 'class': 'derecha', css: {'width': 45}}).appendTo($tr);
                    var $td2 = $('<td/>', {html: deudaMesItem.monto, 'class': 'derecha', css: {'width': 55}}).appendTo($tr);
                    var $td3 = $('<td/>', {html: deudaMesItem.totalPago, 'class': 'derecha', css: {'width': 45}}).appendTo($tr);
                    var $td4 = $('<td/>', {html: deudaMesItem.saldo, 'class': 'derecha'}).appendTo($tr);
                }
                $t_deudaMes.next('.esperando_contenedor').addClass('ocultar');
            },
            statusCode: {
                404: function() {
                    $('#lServidorError').text('Página no encontrada(deudaMes_codCliente.jsp).');
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

//<editor-fold defaultstate="collapsed" desc="function fVentaDetalle(codVenta). Clic en  + para más detalles.">
function fVentaDetalle(codVenta) {
    var $tbVentaDetalle = $('#t_ventaDetalle');
    var data = {codVenta: codVenta};
    var url = 'ajax/ventaDetalleLeer.jsp';
    try {
        $.ajax({
            type: 'post',
            url: url,
            data: data,
            beforeSend: function() {
                $tbVentaDetalle.addClass('ocultar').next('.esperando_contenedor').removeClass('ocultar');
            },
            error: function(XMLHttpRequest, textStatus, errorThrown) {
                $('#lServidorError').text(errorThrown + '()');
                $('#dServidorError').dialog('open');
            },
            success: function(ajaxResponse, textStatus) {
                var VDArray = procesarRespuesta(ajaxResponse);
                $tbVentaDetalle.empty().removeClass('ocultar');
                var VDItem;
                for (var i = 0; i < VDArray.length; i++) {
                    VDItem = VDArray[i];
                    var $tr = $('<tr/>', {'class': 'manoPuntero'}).appendTo($tbVentaDetalle);
                    var $td1 = $('<td/>', {html: VDItem.docSerieNumero, css: {'width': 80}}).appendTo($tr);
                    var $td2 = $('<td/>', {html: VDItem.cantidad, 'class': 'derecha', css: {'width': 25}}).appendTo($tr);
                    var $td3 = $('<td/>', {html: VDItem.descripcion, css: {'width': 260}}).appendTo($tr);
                    var $td4 = $('<td/>', {html: VDItem.precioVenta, 'class': 'derecha', css: {'width': 60}}).appendTo($tr);
                    var $td5 = $('<td/>', {html: VDItem.valorVenta, 'class': 'derecha'}).appendTo($tr);
                }
                $tbVentaDetalle.next('.esperando_contenedor').addClass('ocultar');
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

//<editor-fold defaultstate="collapsed" desc="function fLeerSerieGenerada(tipo). Clic en  + para más detalles.">
function fLeerSerieGenerada(tipo) {
    var data = {tipo: tipo};
    var url = 'ajax/serieCaja_tipo.jsp';
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
                var serieArray = procesarRespuesta(ajaxResponse);
                var tam = serieArray.length;
                for (var i = 0; i < tam; i++) {
                    var serieItem = serieArray[i];
                    var $op1 = $('<option/>', {value: serieItem.serie, text: serieItem.serie}).appendTo($serieSelect);
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

//<editor-fold defaultstate="collapsed" desc="function fVerificarDatos(). Clic en  + para más detalles.">
function fVerificarDatos() {
    var mensaje = "";
    var estado = false;
    $('#dMensajeAlertaDiv').empty();
    if (!$.isNumeric($('#codCliente').val())) {
        mensaje += '* Seleccione cliente.<br>';
        estado = true;
    }
    if (!fValidarFecha($('#fechaCobranza').val())) {
        mensaje += '* Formato de fecha incorrecta.<br>';
        estado = true;
    }
    if (!$.isNumeric($('#montoAmortizar').val())) {
        mensaje += '* Ingrese monto.<br>';
        estado = true;
    } else {
        if (parseFloat($('#montoAmortizar').val()) < 1) {
            mensaje += '* El monto a pagar debe ser mayor o igual a S/. 1.00.<br>';
            estado = true;
        }
    }
    //Si en caso se usa un cobranza o descuento normal.
    if ($('#marcaSaldoFavor').val() == '0') {
        if ($("#rdCaja").is(":checked")) {
            if (!fValidarRequerido($('#serieSelect').val())) {
                mensaje += '* Seleccione serie del documento.<br>';
                estado = true;
            }
        }
        if ($("#rdDescuento").is(":checked")) {
            if (!fValidarMinimo($('#serie').val(), 3)) {
                mensaje += '* Escriba un formato de serie correcta para el descuento(XXX).<br>';
                estado = true;
            }
        }
        if ($('#rdManual').is(':checked')) {
            var docSerieNumero = $('#docSerieNumero').val();
            if (fValidarRequerido(docSerieNumero)) {
                if (fValidarCobranzaDocSerieNumero(docSerieNumero)) {
                } else {
                    mensaje += '* Error en ingreso de documento manual (R-002-123456).<br>';
                    estado = true;
                }
            } else {
                mensaje += '* Error en ingreso de documento manual (R-002-123456).<br>';
                estado = true;
            }
        }
    }
    if (estado) {
        $('#bAmortizar').removeClass('disabled').prop('disabled', false);
        fAlerta(mensaje);
    } else {
        var tipoPago = $("input[name=tipoPago]:checked").val();
        $('#lTipoOperacion').text(tipoPago);
        if (tipoPago == 'normal') {
            //si en caso el monto a pagar supera a la deuda fijada ya sea filtrado o no por venta.
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

//<editor-fold defaultstate="collapsed" desc="function fAmortizar(). Clic en  + para más detalles.">
function fAmortizar() {
    $('#bAmortizar').addClass('disabled').prop('disabled', true);
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
            $('#bAmortizar').removeClass('disabled');
            return;
        }
        if (parseFloat($('#montoAmortizar').val()) > parseFloat($('#auxSaldoFavor').val())) {
            fAlerta('El monto especificado supera al saldo a favor actual');
            $('#bAmortizar').removeClass('disabled');
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
                    $('#bAmortizar').removeClass('disabled').prop('disabled', false);
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

//<editor-fold defaultstate="collapsed" desc="function fEliminarCobranza(). Clic en  + para más detalles.">
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
            beforeSend: function() {
                $('#dProcesandoPeticion').dialog('open');
            },
            error: function(XMLHttpRequest, textStatus, errorThrown) {
                $('#lServidorError').text(errorThrown + '()');
                $('#dServidorError').dialog('open');
            },
            success: function(ajaxResponse, textStatus) {
                if ($.isNumeric(ajaxResponse)) {
                    fAlerta('Se ha eliminado con exito');
                    fClienteLeer($('#codCliente').val());
                    $('#dProcesandoPeticion').dialog('close');
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

//<editor-fold defaultstate="collapsed" desc="function fTipoCambiar(tipo). Clic en  + para más detalles.">
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

//<editor-fold defaultstate="collapsed" desc="function fCodCobranzaOtrosBuscar(codEmpresaConvenio). Clic en  + para más detalles.">
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

//<editor-fold defaultstate="collapsed" desc="function fReiniciarCobranza(). Clic en  + para más detalles.">
function fReiniciarCobranza() {
    $('#tipo1').prop('checked', true);
    $('#tipo2').prop('checked', false);
    $('#dUsarSaldoFavor').addClass('ocultar');
    $('#dNoUsarSaldoFavor').removeClass('ocultar');
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

//<editor-fold defaultstate="collapsed" desc="function f_cobranza_click(objeto). Clic en  + para más detalles.">
function f_cobranza_click(objeto) {
    var $this = $(this).attr('id') ? $(this) : objeto;
    var $tCobranzaDetalle = $('#tCobranzaDetalle');
    $tCobranzaDetalle.find('.cobranzaDetalle').addClass('ocultar').next('.esperando_contenedor').removeClass('ocultar');
    $tCobranzaDetalle.empty();
    var $tr = $('<tr/>').appendTo($tCobranzaDetalle);
    var $td = $('<td/>', {html: $this.find('.cobranzaDetalle').html()}).appendTo($tr);
    $('#cobranzaImprimir').attr('target', '_blank').attr('href', 'reporte/cobranzaImprimir.jsp?codCobranza=' + $this.attr('id'));
    $('#auxCodCobranza2').val($this.attr('id'));
    $tCobranzaDetalle.removeClass('ocultar').next('.esperando_contenedor').addClass('ocultar');
}
;
;
//</editor-fold>

//<editor-fold defaultstate="collapsed" desc="function f_cobranza_dblclick(). Clic en  + para más detalles.">
function f_cobranza_dblclick() {
    $('#auxCodCobranza').val(this.id);
    $('#dCobranzaEliminar').dialog('open');
}
;
;
//</editor-fold>

//<editor-fold defaultstate="collapsed" desc="function f_ventaCreditoLetra_click(objeto). Clic en  + para más detalles.">
function f_ventaCreditoLetra_click(objeto) {
    var $this = $(this).attr('id') ? $(this) : objeto;
    fVentaDetalle($this.find('.codVenta').text());
}
;
//</editor-fold>

//<editor-fold defaultstate="collapsed" desc="function f_ventaCreditoLetra_dblclick(). Clic en  + para más detalles.">
function f_ventaCreditoLetra_dblclick() {
    $('#aux').val($(this).find('.codVenta').text());
    $('#auxDocSerieNumero').val($(this).attr('title'));
    $('#d_filtroConfirmar').dialog('open');
}
;
//</editor-fold>

//<editor-fold defaultstate="collapsed" desc="function clienteMarcado(event, ui). Clic en  + para más detalles.">
function clienteMarcado(event, ui) {
    var cliente = ui.item.value;
    $('#codClienteBuscar').val(cliente.codCliente);
    $('#nombresCDniPasaporteRucBuscar').val(cliente.nombresC);
    event.preventDefault();
}
;
//</editor-fold>

//<editor-fold defaultstate="collapsed" desc="function clienteSeleccionado(event, ui). Clic en el + para más detalles.">
function clienteSeleccionado(event, ui) {
    var cliente = ui.item.value;
    $('#codClienteBuscar').val('');
    $('#nombresCDniPasaporteRucBuscar').val('');
    fClienteLeer(parseInt(cliente.codCliente, 10));
    event.preventDefault();
}
;
//</editor-fold>

//<editor-fold defaultstate="collapsed" desc="function fPaginaActual(). Clic en el + para más detalles.">
function fPaginaActual() {
    fProcesandoPeticion();
    fClienteLeer($('#codCliente').val());
    fLeerDocumentoCaja();
}
;
//</editor-fold>