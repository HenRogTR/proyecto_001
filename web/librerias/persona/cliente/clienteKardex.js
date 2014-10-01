/* 
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */

var DELAY = 500;
var clicks = 0;
var timer = null;

$(document).ready(function() {
    //buscar cliente
    $('#bClienteBuscar').click(function(event) {
        $('#dClienteBuscar').dialog('open');
        $('#dniPasaporteRucNombresCBuscar').focus();
        event.preventDefault();
    });
    //actualizamos la lista de clientes
    $('#bClienteActualizar').click(function(e) {
        e.preventDefault();
        //destruimos el método para volver a inicializarlo de nuevo
        $('#dniPasaporteRucNombresCBuscar').autocomplete('destroy');
        fClienteObtener();
    });
    //botones para imprimir
    $('#bVentaCreditoLetraResumen').click(function(e) {
        var codCliente = $('#codCliente').val();
        if ($.isNumeric(codCliente)) {
            $(this).attr('target', '_blank').attr('href', '../reporte/vclrm.jsp?codCliente=' + parseInt(codCliente, 10));
        } else {
            e.preventDefault();
        }
    });
    $('#bVentaImprimir').click(function(e) {
        var codCliente = $('#codCliente').val();
        if ($.isNumeric(codCliente)) {
            $(this).attr('target', '_blank').attr('href', '../sCliente?accion=imprimirVenta&codCliente=' + parseInt(codCliente, 10));
        } else {
            e.preventDefault();
        }
    });
    //Imprimir VCL
    $('#bVentaCreditoLetra').click(function(e) {
        if (!$.isNumeric($('#codVentaAux').val())) {
            $.growl.warning({title: 'Alerta', message: 'No se ha realizado ventas al cliente actual.', size: 'large'});
            return;
        }
        $('#dVentaCreditoLetraSeleccionar').dialog('open');
    });    
    //Imprimir VCL
    $('#bCobranza').click(function(e) {
        if (!$.isNumeric($('#codVentaAux').val())) {
            $.growl.warning({title: 'Alerta', message: 'El cliente no ha realizado ningún pago.', size: 'large'});
            return;
        }
        $('#dCobranzaSeleccionar').dialog('open');
    });
    //modificar el interes evitar
    $('#bInteresEvitarEditar').click(function(e) {
        $('#dInteresAsignadoEditar').dialog('open');
        e.preventDefault();
    });
    // input código cliente buscar
    $('#codClienteBuscar')
            //solo permite números enteros
            .mask('#', {maxlength: false})
            .keyup(function(e) {
                var key = e.charCode ? e.charCode : (e.keyCode ? e.keyCode : 0);
                if (key == 13) {
                    e.preventDefault();
                    //si existe un número en la entrada se busca cliente
                    if (!f_validar_mayorIgual(this.value, 1)) {
                        $.growl.warning({title: 'Alerta', message: 'Ingrese un código valido.', size: 'large'});
                        return;
                    }
                    fClienteLeer(parseInt(this.value, 10));
                    $(this).val('');
                }
            });
});

$(function() {
    //dialogo para buscar un cliente
    $('#dClienteBuscar').dialog({
        autoOpen: false,
        modal: true,
        resizable: false,
        height: 200,
        width: 800,
        buttons: {
            Aceptar: function() {
                $(this).dialog('close');
            }
        },
        close: function() {
            $(this).dialog('close');
        }
    });
    //interesAsignar
    $('#dInteresAsignadoEditar').dialog({
        autoOpen: false,
        modal: true,
        resizable: false,
        height: 280,
        width: 650,
        buttons: {
            'Deshabilitar interés (Solo hoy)': function() {
                fInteresAsigandoDeshabilitar();
            },
            'Deshabilitar interés (Permanente)': function() {
                fInteresAsigandoPermanenteDeshabilitar();
            },
            'Habilitar intereses': function() {
                fInteresAsigandoHabilitar();
            }
        },
        close: function() {
            $(this).dialog('close');
        }
    });
    //seleccion VCL
    $('#dVentaCreditoLetraSeleccionar').dialog({
        autoOpen: false,
        modal: true,
        resizable: false,
        height: 200,
        width: 400,
        buttons: {
            'Continuar': function() {
                var dato = 'accionVentaCreditoLetra=imprimirVentaCreditoLetra&';
                dato += 'codCliente=' + $('#codCliente').val() + '&';
                dato += 'codVenta=' + $('#codVentaAux').val() + '&';
                dato += 'tipo=' + $('input[name=ventaCreditoLetraImprimirOpcion]:checked').val();
                window.open('../sVentaCreditoLetra?' + dato, '_blank');
            },
            'Cerrrar': function() {
                $(this).dialog('close');
            }
        },
        close: function() {
            $(this).dialog('close');
        }
    });
    //seleccion VCL
    $('#dCobranzaSeleccionar').dialog({
        autoOpen: false,
        modal: true,
        resizable: false,
        height: 200,
        width: 400,
        buttons: {
            'Continuar': function() {
                var dato = 'accionCobranza=imprimirCobranzaReporte&';
                dato += 'codCliente=' + $('#codCliente').val() + '&';
                dato += 'codVenta=' + $('#codVentaAux').val() + '&';
                dato += 'tipo=' + $('input[name=cobranzaImprimirOpcion]:checked').val();
                window.open('../sCobranza?' + dato, '_blank');
            },
            'Cerrrar': function() {
                $(this).dialog('close');
            }
        },
        close: function() {
            $(this).dialog('close');
        }
    });
});

//<editor-fold defaultstate="collapsed" desc="function fClienteMarcado(event, ui). Clic en el signo + de la izquierda para mas detalles.">
function fClienteMarcado(event, ui) {
    var cliente = ui.item.value;
    $('#codClienteBuscar').val(cliente.codCliente);
    $('#dniPasaporteRucNombresCBuscar').val(cliente.nombresC);
    event.preventDefault();
}
;
//</editor-fold>

//<editor-fold defaultstate="collapsed" desc="fClienteSeleccionado(event, ui). Clic en el signo + de la izquierda para mas detalles.">
function fClienteSeleccionado(event, ui) {
    var cliente = ui.item.value;
    $('#codClienteBuscar').val('');
    $('#dniPasaporteRucNombresCBuscar').val('');
    fClienteLeer(parseInt(cliente.codCliente, 10));
    event.preventDefault();
}
;
//</editor-fold>

//<editor-fold defaultstate="collapsed" desc="fClienteLeer(codCliente). Clic en + para más detalles.">
function fClienteLeer(codCliente) {
    var data = {codCliente: codCliente};
    var url = '../ajax/clientePorCodCliente.jsp';
    try {
        $.ajax({
            type: 'post',
            url: url,
            data: data,
            beforeSend: function() {
                //datos independientes
                $('.datoMostrar').addClass('ocultar').next().removeClass('ocultar');
                ////Se vacia, remueve el class ocultar y agregar class ocultar
                $('.tbDato').addClass('ocultar').next().removeClass('ocultar');
            },
            error: function(XMLHttpRequest, textStatus, errorThrown) {
                $('#lServidorError').text(errorThrown + '()');
                $('#dServidorError').dialog('open');
            },
            success: function(ajaxResponse, textStatus) {
                //trasformar a datos Json
                var jsonCliente = procesarRespuesta(ajaxResponse);
                /*
                 *En caso la respuesta del servidor no tenga la forma para 
                 *converitir a json.
                 */
                if (jsonCliente == null) {
                    $.growl.error({title: 'Error', message: ajaxResponse, size: 'large'});
                    //quitar los gif de espera en las otras tablas y retornar los datos anteirores
                    //quitamos para los span independientes
                    $('.datoMostrar').removeClass('ocultar');
                    //mostramos los span con gif junto al anterior descrito
                    $('.esperando').addClass('ocultar');
                    //ocultamos los datos con gif por lo general son tbody
                    $('.tbDato').removeClass('ocultar');
                    //quitamos toda el contenedor tfoot
                    $('.tfContenedor').addClass('ocultar');
                    return;
                }
                fProcesandoPeticionCerrar();
                //tomamos tamaño de datos
                var tam = jsonCliente.length;
                //si tamaño = 0 indica que no se encontro cliente con el dato llamado
                if (tam == 0) {
                    $.growl.warning({title: 'Alerta', message: 'Cliente no encontrado.', size: 'large'});
                    //quitar los gif de espera en las otras tablas y retornar los datos anteirores
                    //quitamos para los span independientes
                    $('.datoMostrar').removeClass('ocultar');
                    //mostramos los span con gif junto al anterior descrito
                    $('.esperando').addClass('ocultar');
                    //ocultamos los datos con gif por lo general son tbody
                    $('.tbDato').removeClass('ocultar');
                    //quitamos toda el contenedor tfoot
                    $('.tfContenedor').addClass('ocultar');
                } else {
                    var itemCliente = jsonCliente[0];
                    $('#codVentaAux').val('');
                    $('#codCliente').val(itemCliente.codCliente);
                    $('#sCodCliente').text(itemCliente.codCliente).removeClass('ocultar')
                            .next('.esperando').addClass('ocultar');
                    $('#sNombresC').html('<a href="../sDatoCliente?accionDatoCliente=mantenimiento&codDatoCliente=' + itemCliente.codCliente + '" target="_blank">' + itemCliente.nombresC + '</a>').removeClass('ocultar')
                            .next('.esperando').addClass('ocultar');
                    $('#sInteresEvitarEstado').text(itemCliente.interesEvitarEstado ? 'Afectado a pago de intereses.' : 'No afectado a pago de intereses (' + (itemCliente.interesEvitarPermanente ? 'permanente' : 'solo hoy') + ').').removeClass('ocultar')
                            .next('.esperando').addClass('ocultar');
                    $('#interesEvitarEstado').val(itemCliente.interesEvitarEstado);
                    /*
                     * Obtenemos todas las ventas hechas ademas de mandar parseado
                     * el int ya que el json retorna con ceros adelante
                     */
                    fVenta(itemCliente.codCliente);
                    fCobranza(itemCliente.codCliente);
                    fVentaCreditoLetraResumen(itemCliente.codCliente);
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

//<editor-fold defaultstate="collapsed" desc="fVenta(codCliente). Clic en + para más detalles.">
function fVenta(codCliente) {
    //parsear el codCliente ya que llega en formato 0000000
    codCliente = parseInt(codCliente, 10);
    var data = {codCliente: codCliente};
    var url = '../ajax/ventaPorCodCliente.jsp';
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
                //trasformar a datos Json
                var ventaJson = procesarRespuesta(ajaxResponse);
                /*
                 *En caso la respuesta del servidor no tenga la forma para 
                 *converitir a json.
                 */
                if (ventaJson == null) {
                    $.growl.error({title: 'Error', message: ajaxResponse, size: 'large'});
                    return;
                }
                //tomamos tamaño de datos
                var tam = ventaJson.length;
                //obtener los totales respecto a ventas la credito
                var total = 0.00;
                var interes = 0.00;
                var interesPagado = 0.00;
                var amortizado = 0.00;
                var saldo = 0.00;
                var saldoSinInteres = 0.00;
                //obtener el objeto
                var $tVentaTbody = $('#tVenta tbody');
                //si tamaño = 0 indica que no se encontro cliente con el dato llamado
                $tVentaTbody.empty();
                if (tam == 0) {
                    //Se vacia, remueve el class ocultar y agregar class ocultar
                    $('#tVentaCreditoLetra tbody').empty().removeClass('ocultar').next().addClass('ocultar');
                    //Se vacia, remueve el class ocultar y agregar class ocultar
                    $tVentaTbody.removeClass('ocultar').next().addClass('ocultar');
                    //Se vacia, remueve el class ocultar y agregar class ocultar
                    $('#tVentaDetalle tbody').empty().removeClass('ocultar').next().addClass('ocultar');
                    //poner en cero
                } else {
                    //recoremos cada posicion
                    for (var i = 0; i < tam; i++) {
                        //obtenemos posicion [i]
                        var ventaItem = ventaJson[i];
                        //para evento clic y doble clic
                        var trClass = 'trVenta';
                        //para cambiar el puntero al tener el foco
                        trClass += ' manoPuntero';
                        //fondo si esta anulado
                        trClass += '0' == ventaItem.registro.substring(0, 1) ? ' fondoVentaAnulada' : '';
                        //tr contenedor, class trVenta para evento clic y doble clic
                        var $tr = $('<tr>', {id: 'codVenta_' + ventaItem.codVenta + '_' + ventaItem.docSerieNumero, 'class': trClass}).appendTo($tVentaTbody);
                        //creamos los td
                        var $td1 = $('<td>', {css: {'width': 80}}).appendTo($tr);
                        var $a11 = $('<a>', {html: ventaItem.docSerieNumero, href: '../sVenta?accionVenta=mantenimiento&codVenta=' + ventaItem.codVenta, target: '_blank'}).appendTo($td1);
                        var $td2 = $('<td>', {html: ventaItem.fecha, css: {'width': 80}}).appendTo($tr);
                        var $td3 = $('<td>', {html: ventaItem.neto, 'class': 'derecha', css: {'width': 60}}).appendTo($tr);
                        var $td4 = $('<td>', {'class': 'derecha', css: {'width': 60}}).appendTo($tr);
                        //intereses auxiliares
                        var $div41 = $('<div>', {html: 'CREDITO' == ventaItem.tipo ? ventaItem.interes : '', 'class': 'ocultar interesAfectado'}).appendTo($td4);
                        var $div42 = $('<div>', {html: 'CREDITO' == ventaItem.tipo ? ventaItem.interesPagado : '', 'class': 'ocultar interesNoAfectado'}).appendTo($td4);
                        var $td5 = $('<td>', {html: 'CREDITO' == ventaItem.tipo ? ventaItem.pagoVenta : '', 'class': 'derecha', css: {'width': 60}}).appendTo($tr);
                        var $td6 = $('<td>', {'class': 'derecha', css: {'width': 60}}).appendTo($tr);
                        //saldo auxiliares
                        var $div61 = $('<div>', {html: 'CREDITO' == ventaItem.tipo ? ventaItem.saldoVenta : '', 'class': 'ocultar interesAfectado'}).appendTo($td6);
                        var $div62 = $('<div>', {html: 'CREDITO' == ventaItem.tipo ? ventaItem.saldoVentaSinInteres : '', 'class': 'ocultar interesNoAfectado'}).appendTo($td6);
                        var $td7 = $('<td>', {html: 'CREDITO' == ventaItem.tipo ? ventaItem.cantidadLetras : '', 'class': 'derecha', css: {'width': 40}}).appendTo($tr);
                        var $td8 = $('<td>', {html: ventaItem.tipo, css: {'width': 60}}).appendTo($tr);
                        var $td9 = $('<td>', {html: '1.00', 'class': 'derecha'}).appendTo($tr);
                        //obtener ventaCreditoLetra, ventaDetalle de la primera venta
                        if (i == 0) {
                            //obtener todas VCL
                            fVentaCreditoLetra(ventaItem.codVenta, ventaItem.docSerieNumero);
                            //obtener detalle venta
                            fVentaDetalle(ventaItem.codVenta, ventaItem.docSerieNumero);
                        }
                        //sumar los totales y dar formato #.##
                        total += parseFloat(ventaItem.neto);
                        interes += parseFloat(ventaItem.interes);
                        interesPagado += parseFloat(ventaItem.interesPagado);
                        amortizado += parseFloat(ventaItem.pagoVenta);
                        saldo += parseFloat(ventaItem.saldoVenta);
                        saldoSinInteres += parseFloat(ventaItem.saldoVentaSinInteres);
                    }
                    //como diferenciar si es un simple click o doble click
                    $('.trVenta')
                            .bind('click', trVentaEventoClick)
                            //quitar evento doble clic
                            .bind('dblclick', function(e) {
                                e.preventDefault();
                            });
                }
                //asignar los totales
                $('#lTotal').text(fNumeroFormato(total, 2, false));
                $('#lInteres').text(fNumeroFormato(interes, 2, false));
                $('#lInteresInteresNoAfectado').text(fNumeroFormato(interesPagado, 2, false));
                $('#lAmortizado').text(fNumeroFormato(amortizado, 2, false));
                $('#lSaldo').text(fNumeroFormato(saldo, 2, false));
                $('#lSaldoInteresNoAfectado').text(fNumeroFormato(saldoSinInteres, 2, false));
                //llamamos a la funcion para mostrar o no
                fMostrarNoMostarInteresAfecto();
                //remover los ocultos
                $('#tTotales')
                        .find('.datoMostrar').removeClass('ocultar')
                        .next().addClass('ocultar');
                //remover y asignar class
                $tVentaTbody.removeClass('ocultar').next().addClass('ocultar');
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

//<editor-fold defaultstate="collapsed" desc="fClienteObtener(). Clic en el signo + de la izquierda para mas detalles.">
/**
 * Obtenemos la lista de datos de la BD para hacer la busqueda de autocompletado por cliente.
 * @returns {Array}
 */
function fClienteObtener() {
    var url = '../autocompletado/cliente.jsp';
    try {
        $.ajax({
            type: 'post',
            url: url,
            error: function(XMLHttpRequest, textStatus, errorThrown) {
                $('#lServidorError').text(errorThrown + '()');
                $('#dServidorError').dialog('open');
            },
            success: function(ajaxResponse, textStatus) {
                //iniciamos el autocompletado con los datos cargados para hacer las busquedas en el cliente y no saturar el servidor
                var clienteArray = procesarRespuesta(ajaxResponse);
                $('#dniPasaporteRucNombresCBuscar').autocomplete({
                    source: function(request, response) {
                        procesarCoincidencia(request, response, clienteArray);
                    },
                    minLength: 4,
                    focus: fClienteMarcado,
                    select: fClienteSeleccionado
                });
                $('#dniPasaporteRucNombresCBuscar').val('');
                $('#codClienteBuscar').val('');
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

//<editor-fold defaultstate="collapsed" desc="fVentaCreditoLetra(codVenta, docSerieNumero). Clic en + para más detalles.">
function fVentaCreditoLetra(codVenta, docSerieNumero) {
    //parsear el codVenta ya que llega en formato 0000000
    codVenta = parseInt(codVenta, 10);
    var data = {codVenta: codVenta};
//    var url = '../ajax/ventaCreditoLetraPorCodVenta.jsp';
    var url = '../ajax/ventaCreditoLetraPorCodigoVenta.jsp';
    //obtenemos el tag
    var $tVentaCreditoLetraTbody = $('#tVentaCreditoLetra tbody');
    try {
        $.ajax({
            type: 'post',
            url: url,
            data: data,
            beforeSend: function() {
                //poner gif 
                $tVentaCreditoLetraTbody.addClass('ocultar').next().removeClass('ocultar');
            },
            error: function(XMLHttpRequest, textStatus, errorThrown) {
                $('#lServidorError').text(errorThrown + '()');
                $('#dServidorError').dialog('open');
            },
            success: function(ajaxResponse, textStatus) {
                //trasformar a datos Json
                var ventaCreditoLetraJson = procesarRespuesta(ajaxResponse);
                /*
                 *En caso la respuesta del servidor no tenga la forma para 
                 *converitir a json.
                 */
                if (ventaCreditoLetraJson == null) {
                    $.growl.error({title: 'Error', message: ajaxResponse, size: 'large'});
                    return;
                }
                //tomamos tamaño de datos
                var tam = ventaCreditoLetraJson.length;
                //vaciar la tabla
                $tVentaCreditoLetraTbody.empty();
                //asignamos el codVentaAux
                $('#codVentaAux').val(codVenta);
                //recorremos cada posicion
                for (var i = 0; i < tam; i++) {
                    //obtenemos posicion [i]
                    var ventaCreditoLetraItem = ventaCreditoLetraJson[i];
                    //obtener el fondo que tendra
                    //class fondo tr
                    var trClass = '';
                    //dias retrasos de pago
                    var diaRetraso = '';
                    //si tiene saldo pendiente y (tenga dia retraso o sea la inicial)
                    if (ventaCreditoLetraItem.saldoLetra > 0 & (ventaCreditoLetraItem.diaRetraso > 0 || ventaCreditoLetraItem.numeroLetra == 0)) {
                        trClass = 'ventaCreditoLetraVencida';
                        diaRetraso = ventaCreditoLetraItem.diaRetraso;
                    }
                    // si tiene saldo pendiente y esta dentro de la semana
                    if (ventaCreditoLetraItem.saldoLetra > 0 & ventaCreditoLetraItem.diaRetraso < 0 & ventaCreditoLetraItem.diaRetraso > -6) {
                        trClass = 'ventaCreditoLetraPorVencer';
                    }
                    //tr contenedor, class trVenta para evento clic y doble clic
                    var $tr = $('<tr>', {id: 'codVentaCreditoLetra_' + ventaCreditoLetraItem.codVentaCreditoLetra, 'class': trClass}).appendTo($tVentaCreditoLetraTbody);
                    //creamos los td
                    var $td1 = $('<td>', {html: docSerieNumero, css: {'width': 90}}).appendTo($tr);
                    var $td2 = $('<td>', {html: ventaCreditoLetraItem.detalleLetra, css: {'width': 90}}).appendTo($tr);
                    var $td3 = $('<td>', {html: ventaCreditoLetraItem.fechaVencimiento, css: {'width': 70}}).appendTo($tr);
                    var $td4 = $('<td>', {html: ventaCreditoLetraItem.monto, 'class': 'derecha', css: {'width': 60}}).appendTo($tr);
                    //indicar el interes afecto o no afecto
                    var $td5 = $('<td>', {'class': 'derecha', css: {'width': 60}}).appendTo($tr);
                    var $d51 = $('<div>', {html: ventaCreditoLetraItem.interes, 'class': 'ocultar interesAfectado'}).appendTo($td5);
                    var $d52 = $('<div>', {html: ventaCreditoLetraItem.interesPagado, 'class': 'ocultar interesNoAfectado'}).appendTo($td5);
                    var $td6 = $('<td>', {html: ventaCreditoLetraItem.pagoLetra, 'class': 'derecha', css: {'width': 60}}).appendTo($tr);
                    var $td7 = $('<td>', {html: ventaCreditoLetraItem.fechaPago, css: {'width': 70}}).appendTo($tr);
                    var $td8 = $('<td>', {html: diaRetraso, 'class': 'derecha', css: {'width': 40}}).appendTo($tr);
                    //indicar el saldo afecto o no afecto
                    var $td9 = $('<td>', {'class': 'derecha', css: {}}).appendTo($tr);
                    var $d91 = $('<div>', {html: ventaCreditoLetraItem.saldoLetra, 'class': 'ocultar interesAfectado'}).appendTo($td9);
                    var $d92 = $('<div>', {html: ventaCreditoLetraItem.saldoLetraSinInteres, 'class': 'ocultar interesNoAfectado'}).appendTo($td9);
                }
                //interes afectado
                fMostrarNoMostarInteresAfecto();
                //quitamos lo oculto y ocultamos el gif de espera
                $tVentaCreditoLetraTbody.removeClass('ocultar').next().addClass('ocultar');
            },
            statusCode: {
                404: function() {
                    $('#lServidorError').text('Página no encontrada(' + url + ').');
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

//<editor-fold defaultstate="collapsed" desc="trVentaEventoClick(). Clic en + para más detalles.">
function trVentaEventoClick() {
    var id = this.id.split('_');
    var codVenta = id[1];
    var docSerieNumero = id[2];
    clicks++;  //count clicks
    if (clicks === 1) {
        timer = setTimeout(function() {
            fVentaCreditoLetra(codVenta, docSerieNumero);
            fVentaDetalle(codVenta, docSerieNumero);
            clicks = 0;  //after action performed, reset counter
        }, DELAY);
    } else {
        clearTimeout(timer);  //prevent single-click action
        fVentaSerieNumero(codVenta, docSerieNumero);
        clicks = 0;  //after action performed, reset counter
    }
}
;
//</editor-fold>

//<editor-fold defaultstate="collapsed" desc="fVentaDetalle(codVenta, docSerieNumero). Clic en + para más detalles.">
function fVentaDetalle(codVenta, docSerieNumero) {
    //parsear el codVenta ya que llega en formato 0000000
    codVenta = parseInt(codVenta, 10);
    var data = {codVenta: codVenta};
    var url = '../ajax/ventaDetallePorCodVenta.jsp';
    //obtenemos el tag
    var $tVentaDetalleTbody = $('#tVentaDetalle tbody');
    try {
        $.ajax({
            type: 'post',
            url: url,
            data: data,
            beforeSend: function() {
                $tVentaDetalleTbody.addClass('ocultar').next().removeClass('ocultar');
            },
            error: function(XMLHttpRequest, textStatus, errorThrown) {
                $('#lServidorError').text(errorThrown + '()');
                $('#dServidorError').dialog('open');
            },
            success: function(ajaxResponse, textStatus) {
                //trasformar a datos Json
                var ventaDetalleJson = procesarRespuesta(ajaxResponse);
                /*
                 *En caso la respuesta del servidor no tenga la forma para 
                 *converitir a json.
                 */
                if (ventaDetalleJson == null) {
                    $.growl.error({title: 'Error', message: ajaxResponse, size: 'large'});
                    return;
                }
                //tomamos tamaño de datos
                var tam = ventaDetalleJson.length;
                //vaciar la tabla
                $tVentaDetalleTbody.empty();
                //recorrer el array
                for (var i = 0; i < tam; i++) {
                    //obtenemos posicion [i]
                    var ventaDetalleItem = ventaDetalleJson[i];
                    //tr contenedor, class trVenta para evento clic y doble clic
                    var $tr = $('<tr>', {id: 'codVentaDetalle_' + ventaDetalleItem.codVentaDetalle}).appendTo($tVentaDetalleTbody);
                    //td
                    var $td1 = $('<td>', {html: docSerieNumero, css: {'width': 80}}).appendTo($tr);
                    var $td2 = $('<td>', {html: ventaDetalleItem.cantidad, 'class': 'derecha', css: {'width': 40}}).appendTo($tr);
                    var $td3 = $('<td>', {html: ventaDetalleItem.descripcion, css: {'width': 380}}).appendTo($tr);
                    var $td4 = $('<td>', {html: ventaDetalleItem.precioVenta, 'class': 'derecha', css: {'width': 70}}).appendTo($tr);
                    var $td5 = $('<td>', {html: ventaDetalleItem.valorVenta, 'class': 'derecha'}).appendTo($tr);
                }
                //remover
                $tVentaDetalleTbody.removeClass('ocultar').next().addClass('ocultar');
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

//<editor-fold defaultstate="collapsed" desc="fCobranza(codCliente). Clic en + para más detalles.">
function fCobranza(codCliente) {
    //parsear
    codCliente = parseInt(codCliente, 10);
    var data = {codCliente: codCliente};
    var url = '../ajax/cobranzaPorCodCliente.jsp';
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
                //trasformar a datos Json
                var cobranzaJSon = procesarRespuesta(ajaxResponse);
                /*
                 *En caso la respuesta del servidor no tenga la forma para 
                 *converitir a json.
                 */
                if (cobranzaJSon == null) {
                    $.growl.error({title: 'Error', message: ajaxResponse, size: 'large'});
                    return;
                }
                //tomamos tamaño de datos
                var tam = cobranzaJSon.length;
                //vaciar la tabla
                var $tCobranzaTbody = $('#tCobranza tbody');
                $tCobranzaTbody.empty();
                //si en caso no hay ninguna cobranza limpiar la tabla cobranza detalle
                if (tam == 0) {
                    $('#tCobranzaDetalle tbody').empty().removeClass('ocultar').next().addClass('ocultar');
                }
                //recorrer el array
                for (var i = 0; i < tam; i++) {
                    //obtenemos posicion [i]
                    var cobranza = cobranzaJSon[i];
                    //tr contenedor, class trVenta para evento clic y doble clic
                    var $tr = $('<tr>', {id: 'codCobranza_' + cobranza.codCobranza + '_' + cobranza.docSerieNumero, 'class': 'trCobranza manoPuntero', title: cobranza.observacion.replace(/<br>/gi, '\n')}).appendTo($tCobranzaTbody);
                    //td
                    var $td1 = $('<td>', {html: cobranza.docSerieNumero, css: {'width': 110}}).appendTo($tr);
                    var $td2 = $('<td>', {html: cobranza.importe, 'class': 'derecha', css: {'width': 70}}).appendTo($tr);
                    var $td3 = $('<td>', {html: cobranza.fechaCobranza, 'class': 'derecha', css: {'width': 70}}).appendTo($tr);
                    var $td4 = $('<td>', {html: cobranza.saldo, 'class': 'derecha'}).appendTo($tr);
                    var $cobranzaDetalle = $('<div>', {html: cobranza.observacion, 'class': 'cobranzaDetalle ocultar'}).appendTo($td4);
                    //fijar detalle de cobranza al ultimo
                    if (i == tam - 1) {
                        fCobranzaDetalle(cobranza.docSerieNumero, cobranza.observacion);
                    }

                }
                //evento clic para mostrar detalle de cobranza
                $('.trCobranza').bind('click', fCobranzaDetalleClick);
                //evento clic
                //quitamos el class
                $tCobranzaTbody.removeClass('ocultar').next().addClass('ocultar');
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

//<editor-fold defaultstate="collapsed" desc="fCobranzaDetalleClick(). Clic en + para más detalles.">
function fCobranzaDetalleClick() {
    //id de la forma codCobranza_00000000_tkr-001-000000
    var id = this.id.split('_');
    var codCobranza = id[1];
    var docSerieNumero = id[2];
    var observacion = $(this).find('.cobranzaDetalle').html();
    fCobranzaDetalle(docSerieNumero, observacion);
}
;
//</editor-fold>

//<editor-fold defaultstate="collapsed" desc="fCobranzaDetalle(docSerieNumero, observacion). Clic en + para más detalles.">
function fCobranzaDetalle(docSerieNumero, observacion) {
    var $tCobrazaDetalleTbody = $('#tCobranzaDetalle tbody');
    //vaciamos tabla
    $tCobrazaDetalleTbody.empty();
    //crear el tr contenedor
    var $tr = $('<tr>').appendTo($tCobrazaDetalleTbody);
    //td
    var $td1 = $('<td>', {html: docSerieNumero, css: {'width': 100}}).appendTo($tr);
    var $td2 = $('<td>', {html: observacion}).appendTo($tr);
    //mostrar
    $tCobrazaDetalleTbody.removeClass('ocultar').next().addClass('ocultar');
}
;
//</editor-fold>

//<editor-fold defaultstate="collapsed" desc="fVentaCreditoLetraResumen(codCliente). Clic en + para más detalles.">
function fVentaCreditoLetraResumen(codCliente) {
    //parsear
    codCliente = parseInt(codCliente, 10);
    var data = {codCliente: codCliente};
//    var url = '../ajax/ventaCreditoLetraResumenPorCodCliente.jsp';
    var url = '../ajax/ventaCreditoLetraResumenMensualPorCodigoCliente.jsp';
    try {
        $.ajax({
            type: 'post',
            url: url,
            data: data,
            beforeSend: function() {

            },
            error: function(XMLHttpRequest, textStatus, errorThrown) {
                $('#lServidorError').text(errorThrown + '(' + url + ')');
                $('#dServidorError').dialog('open');
            },
            success: function(ajaxResponse, textStatus) {
                //trasformar a datos Json
                var VCLResumenJson = procesarRespuesta(ajaxResponse);
                /*
                 *En caso la respuesta del servidor no tenga la forma para 
                 *converitir a json.
                 */
                if (VCLResumenJson == null) {
                    $.growl.error({title: 'Error', message: ajaxResponse, size: 'large'});
                    return;
                }
                //tomamos tamaño de datos
                var tam = VCLResumenJson.length;
                //vaciar la tabla
                var $tVentaCreditoLetraResumenTbody = $('#tVentaCreditoLetraResumen tbody');
                $tVentaCreditoLetraResumenTbody.empty();
                for (var i = 0; i < tam; i++) {
                    //obtenemos posicion [i]
                    var VCLResumenItem = VCLResumenJson[i];
                    //tr contenedor, class trVenta para evento clic y doble clic
                    var $tr = $('<tr>').appendTo($tVentaCreditoLetraResumenTbody);
                    //td
//                    var $td1 = $('<td>', {html: VCLResumenItem.mes + '-' + VCLResumenItem.anio, css: {'width': 70}}).appendTo($tr);
//                    var $td2 = $('<td>', {html: VCLResumenItem.monto, 'class': 'derecha', css: {'width': 70}}).appendTo($tr);
//                    var $td3 = $('<td>', {html: VCLResumenItem.interes, 'class': 'derecha', css: {'width': 70}}).appendTo($tr);
//                    var $td4 = $('<td>', {html: VCLResumenItem.pagoCliente, 'class': 'derecha', css: {'width': 70}}).appendTo($tr);
//                    var $td5 = $('<td>', {html: VCLResumenItem.saldoCliente, 'class': 'derecha'}).appendTo($tr);
                    var $td1 = $('<td>', {html: VCLResumenItem.mes + '-' + VCLResumenItem.anio, css: {'width': 70}}).appendTo($tr);
                    var $td2 = $('<td>', {html: VCLResumenItem.capital, 'class': 'derecha', css: {'width': 70}}).appendTo($tr);
                    var $td3 = $('<td>', {html: VCLResumenItem.interes, 'class': 'derecha', css: {'width': 70}}).appendTo($tr);
                    var $td4 = $('<td>', {html: VCLResumenItem.pagoTotal, 'class': 'derecha', css: {'width': 70}}).appendTo($tr);
                    var $td5 = $('<td>', {html: VCLResumenItem.saldoConInteres, 'class': 'derecha'}).appendTo($tr);
                }
                //quitar lo ocultado
                $tVentaCreditoLetraResumenTbody.removeClass('ocultar').next().addClass('ocultar');
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

//<editor-fold defaultstate="collapsed" desc="fVentaObtenerUltimo(). Clic en + para más detalles.">
function fVentaObtenerUltimo() {
    var url = '../ajax/ventaLeerUltimo.jsp';
    try {
        $.ajax({
            type: 'post',
            url: url,
            error: function(XMLHttpRequest, textStatus, errorThrown) {
                $('#lServidorError').text(errorThrown + '()');
                $('#dServidorError').dialog('open');
            },
            success: function(ajaxResponse, textStatus) {
                //trasformar a datos Json
                var ventaUltimoCreditoJson = procesarRespuesta(ajaxResponse);
                /*
                 *En caso la respuesta del servidor no tenga la forma para 
                 *converitir a json.
                 */
                if (ventaUltimoCreditoJson == null) {
                    $.growl.error({title: 'Error', message: ajaxResponse, size: 'large'});
                    return;
                }
                //tomamos tamaño de datos
                var tam = ventaUltimoCreditoJson.length;
                //decimos que no hay venta al crédito ultima hecha
                if (tam == 0) {
                    $.growl.warning({title: 'Alerta', message: 'No hay ninguna venta al crédito.', size: 'large'});
                    //quitar los gif de espera en las otras tablas y retornar los datos anteirores
                    //quitamos para los span independientes
                    $('.datoMostrar').removeClass('ocultar');
                    //mostramos los span con gif junto al anterior descrito
                    $('.esperando').addClass('ocultar');
                    //ocultamos los datos con gif por lo general son tbody
                    $('.tbDato').removeClass('ocultar');
                    //quitamos toda el contenedor tfoot
                    $('.tfContenedor').addClass('ocultar');
                    fProcesandoPeticionCerrar();
                    return;
                } else {
                    var venta = ventaUltimoCreditoJson[0];
                    fClienteLeer(venta.codCliente);
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

//<editor-fold defaultstate="collapsed" desc="fVentaSerieNumero(codVenta, docSerieNumero). Clic en + para más detalles.">
function fVentaSerieNumero(codVenta, docSerieNumero) {
    //parsear
    codVenta = parseInt(codVenta, 10);
    var data = {codVenta: codVenta};
    var url = '../ajax/ventaSerieNumeroPorCodVenta.jsp';
    try {
        $.ajax({
            type: 'post',
            url: url,
            data: data,
            beforeSend: function() {
                fDLibreAbrir();
            },
            error: function(XMLHttpRequest, textStatus, errorThrown) {
                $('#lServidorError').text(errorThrown + '()');
                $('#dServidorError').dialog('open');
            },
            success: function(ajaxResponse, textStatus) {
                //trasformar a datos Json
                var ventaJson = procesarRespuesta(ajaxResponse);
                /*
                 *En caso la respuesta del servidor no tenga la forma para 
                 *converitir a json.
                 */
                if (ventaJson == null) {
                    $.growl.error({title: 'Error', message: ajaxResponse, size: 'large'});
                    return;
                }
                //tomamos tamaño de datos
                var tam = ventaJson.length;
                //tabla contenedora
                var $tabla = $('<tabla>', {'class': 'reporte-tabla-1 anchoTotal'});
                var $tr1 = $('<tr>').appendTo($tabla);
                $('<th>', {html: 'Serie/Número', css: {'width': 350}}).appendTo($tr1);
                $('<th>', {html: 'Observación', css: {'width': 300}}).appendTo($tr1);
                //recuperar
                for (var i = 0; i < tam; i++) {
                    var ventaSerieNumeroItem = ventaJson[i];
                    var $tr = $('<tr>').appendTo($tabla);
                    var $td1 = $('<td>', {html: ventaSerieNumeroItem.serieNumero}).appendTo($tr);
                    var $td2 = $('<td>', {html: ventaSerieNumeroItem.observacion}).appendTo($tr);
                }
                fDLibreEditar('500', '700', docSerieNumero, $tabla);
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

//<editor-fold defaultstate="collapsed" desc="function fInteresAsigandoHabilitar(). Clic en + para más detalles.">
function fInteresAsigandoHabilitar() {
    var codCliente = $('#codCliente').val();
    if (!$.isNumeric(codCliente)) {
        $.growl.warning({title: 'Alerta', message: 'Cliente no seleccionado', size: 'large'});
        return;
    }
    var data = {
        codCliente: codCliente,
        accion: 'actualizarInteresAsignar',
        estado: 'habilitar'
    };
    var url = '../sCliente';
    try {
        $.ajax({
            type: 'post',
            url: url,
            data: data,
            beforeSend: function() {
                fProcesandoPeticion();
            },
            error: function(XMLHttpRequest, textStatus, errorThrown) {
                $('#lServidorError').text(errorThrown + '()');
                $('#dServidorError').dialog('open');
            },
            success: function(ajaxResponse, textStatus) {
                if ($.isNumeric(ajaxResponse)) {
                    $('.interesNoAfectado').addClass('ocultar');
                    $('.interesAfectado').removeClass('ocultar');
                    $('#sInteresEvitarEstado').text('Afectado a pago de intereses.');
                    $('#dInteresAsignadoEditar').dialog('close');
                } else {
                    $.growl.warning({title: 'Alerta', message: ajaxResponse, size: 'large'});
                }
                fProcesandoPeticionCerrar();
            },
            statusCode: {
                404: function() {
                    $('#lServidorError').text('Página no encontrada(' + url + ').');
                    $('#dServidorError').dialog('open');
                }
            }
        });
    } catch (ex) {
        $('#lServidorError').text(ex);
        $('#dServidorError').dialog('open');
    }
}
;
//</editor-fold>

//<editor-fold defaultstate="collapsed" desc="fInteresAsigandoDeshabilitar(). Clic en + para más detalles.">
function fInteresAsigandoDeshabilitar() {
    var codCliente = $('#codCliente').val();
    if (!$.isNumeric(codCliente)) {
        $.growl.warning({title: 'Alerta', message: 'Cliente no seleccionado', size: 'large'});
        return;
    }
    var data = {
        codCliente: codCliente,
        accion: 'actualizarInteresAsignar',
        estado: 'deshabilitar'
    };
    var url = '../sCliente';
    try {
        $.ajax({
            type: 'post',
            url: url,
            data: data,
            beforeSend: function() {
                fProcesandoPeticion();
            },
            error: function(XMLHttpRequest, textStatus, errorThrown) {
                $('#lServidorError').text(errorThrown + '()');
                $('#dServidorError').dialog('open');
            },
            success: function(ajaxResponse, textStatus) {
                if ($.isNumeric(ajaxResponse)) {
                    $('.interesAfectado').addClass('ocultar');
                    $('.interesNoAfectado').removeClass('ocultar');
                    $('#sInteresEvitarEstado').text('No afectado a pago de intereses (solo hoy).');
                    $('#dInteresAsignadoEditar').dialog('close');
                } else {
                    $.growl.warning({title: 'Alerta', message: ajaxResponse, size: 'large'});
                }
                fProcesandoPeticionCerrar();
            },
            statusCode: {
                404: function() {
                    $('#lServidorError').text('Página no encontrada(' + url + ').');
                    $('#dServidorError').dialog('open');
                }
            }
        });
    } catch (ex) {
        $('#lServidorError').text(ex);
        $('#dServidorError').dialog('open');
    }
}
;
//</editor-fold>

//<editor-fold defaultstate="collapsed" desc="fInteresAsigandoPermanenteDeshabilitar(). Clic en + para más detalles.">
function fInteresAsigandoPermanenteDeshabilitar() {
    var codCliente = $('#codCliente').val();
    if (!$.isNumeric(codCliente)) {
        $.growl.warning({title: 'Alerta', message: 'Cliente no seleccionado', size: 'large'});
        return;
    }
    var data = {
        codCliente: codCliente,
        accion: 'actualizarInteresAsignar',
        estado: 'deshabilitarPermanente'
    };
    var url = '../sCliente';
    try {
        $.ajax({
            type: 'post',
            url: url,
            data: data,
            beforeSend: function() {
                fProcesandoPeticion();
            },
            error: function(XMLHttpRequest, textStatus, errorThrown) {
                $('#lServidorError').text(errorThrown + '()');
                $('#dServidorError').dialog('open');
            },
            success: function(ajaxResponse, textStatus) {
                if ($.isNumeric(ajaxResponse)) {
                    $('.interesAfectado').addClass('ocultar');
                    $('.interesNoAfectado').removeClass('ocultar');
                    $('#sInteresEvitarEstado').text('No afectado a pago de intereses (permanente).');
                    $('#dInteresAsignadoEditar').dialog('close');
                } else {
                    $.growl.warning({title: 'Alerta', message: ajaxResponse, size: 'large'});
                }
                fProcesandoPeticionCerrar();
            },
            statusCode: {
                404: function() {
                    $('#lServidorError').text('Página no encontrada(' + url + ').');
                    $('#dServidorError').dialog('open');
                }
            }
        });
    } catch (ex) {
        $('#lServidorError').text(ex);
        $('#dServidorError').dialog('open');
    }
}
;
//</editor-fold>

//<editor-fold defaultstate="collapsed" desc="fMostrarNoMostarInteresAfecto(). Clic en + para más detalles.">
function fMostrarNoMostarInteresAfecto() {
    var interesEvitarEstado = $('#interesEvitarEstado').val() == 'true';//
    if (interesEvitarEstado) {
        $('.interesNoAfectado').addClass('ocultar');
        $('.interesAfectado').removeClass('ocultar');
    } else {
        $('.interesAfectado').addClass('ocultar');
        $('.interesNoAfectado').removeClass('ocultar');
    }
}
;
//</editor-fold>

//<editor-fold defaultstate="collapsed" desc="fPaginaActual(). Clic en + para más detalles.">
function fPaginaActual() {
    fProcesandoPeticion();
    /*obtener todos los clientes y almacenarlos para hacer la busqueda por
     autocompletado desde el cliente
     */
    fClienteObtener();
    //obtener el codCliente de la última venta al credito hecha
    fVentaObtenerUltimo();
}
;
//</editor-fold>