/* 
 * To change this template, choose Tools | Templates
 * and open the template in the editor.
 */


$(document).ready(function() {

    $('#bClienteBuscar').click(function(event) {
        $('#codPersona').focus();
        $('#dClienteBuscar').dialog('open');
        event.preventDefault();
    });
    $('#codPersona').keyup(function(event) {
        if (event.which == 13 & $(this).val() > 0) {
            persona($(this).val());
            $(this).val('');
        }
    });

    $('#bResumenPagosImprimir').click(function(event) {
        if (true) {

        } else {
            event.preventDefault();
        }
    });
    $("#dDatosCliente").dialog({
        autoOpen: false,
        modal: true,
        resizable: false,
        height: 500,
        width: 600,
        show: {
            effect: "blind",
            duration: 500
        },
        hide: {
            effect: "blind",
            duration: 500
        }
    });
    $('#dClienteBuscar').dialog({
        autoOpen: true,
        modal: true,
        resizable: true,
        height: 120,
        width: 800,
        close: function() {
            $(this).dialog("close");
        },
    });

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

    function persona(codPersona) {
        reiniciarDatosKardex();
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
            $('#lErrorServidor').text(ex);
            $('#dErrorServidor').dialog('open');
        }
    }
    ;

    function personaDatosRecuperar_callback(ajaxResponse, textStatus) {
        var personaDatos = procesarRespuesta(ajaxResponse);
        if (personaDatos[0].error) {
            $('#lMensajeBuscarCliente').text(personaDatos[0].error);
            return;
        }
        $('#lCodPersona').text(personaDatos[0].codPersona);
        $('#bDatosCliente').attr('href', '../sDatoCliente?accionDatoCliente=mantenimiento&codDatoCliente=' + personaDatos[0].codDatoCliente);
        $('#bResumenPagosImprimir').attr('target', 'resumenPagosImprimir').attr('href', 'reporte/resumenPagos.jsp?codPesona=' + personaDatos[0].codPersona);
        $('#lNombresC').text(personaDatos[0].nombresC);
        $('#lDireccion').text(personaDatos[0].direccion);

        $('#lEmpresaConvenio').text(personaDatos[0].empresaConvenio);
        $('#lCondicion').text(personaDatos[0].condicion);

        ventasRecuperar(personaDatos[0].codPersona);
        fCobranza(personaDatos[0].codPersona);
        fResumenPagos(personaDatos[0].codPersona);
//        $('#tbVentasDetalle').find('tr').remove();//remover datos de detalle de ventas
    }
});

function procesarRespuesta(ajaxResponse) {
    var response;
    try {
        eval('response=' + ajaxResponse);
    } catch (ex) {
        alert("Error proceso respuesta: " + ex)
        response = null;
    }
    return response;
}

function nombresCSeleccionado(event, ui) {
    var cliente = ui.item.value;
    $("#nombresC").val("");
    $("#lNombresC").text(cliente.nombresC);
    $("#dDatosCliente").dialog({title: cliente.nombresC});
    //recoger ventas hechas
    ventasRecuperar(cliente.codPersona);
    event.preventDefault();
}

function ventasRecuperar(codPersona) {
    try {
        var data = "codPersona=" + codPersona;
        $.ajax({
            type: "post",
            url: "ajax/ventas.jsp",
            data: data,
            context: {"codPersona": codPersona},
            error: callback_error,
            success: ventasRecuperar_callback
        });
    }
    catch (ex) {
        alert(ex);
    }
}



function ventasRecuperar_callback(ajaxResponse, textStatus) {
    var ventasDetalles = procesarRespuesta(ajaxResponse);
    var $ventasCuerpo = $("#ventasCuerpo");
    var $ventasPie = $("#ventasPie");
//    $ventasCuerpo.find("tr").remove();
    $ventasPie.find("tr").remove();
    if (!ventasDetalles) {
        $ventasPie.append(
                "<tr>" +
                "<td colspan='9'>¡No se realizado ninguna venta al Cliente!</td>" +
                "</tr>");
        return;
    }
    var ventasItem;
    for (var idx=0; idx < ventasDetalles.length; idx++) {
        ventasItem = ventasDetalles[idx];
        var fondo = '';
        if (ventasItem.registro.substring(0, 1) == '0') {
            fondo = '#ff6666';
        }
        $ventasCuerpo.append(
                "<tr id='" + ventasItem.codVentas + "' class='" + ventasItem.serie + "' name='" + ventasItem.codPersona + "'>" +
                "<td style='width: 80px;'><a href='../sVenta?accionVenta=mantenimiento&codVenta=" + ventasItem.codVentas + "' target='_blank'>" + ventasItem.docSerieNumero + "</a></td>" +
                "<td style='width: 80px;background-color: " + fondo + ";'>" + ventasItem.fecha + "</td>" +
                "<td style='text-align: right;width: 60px;background-color: " + fondo + ";'>" + ventasItem.neto + "</td>" +
                "<td style='text-align: right;width: 60px;background-color: " + fondo + ";'>" + ventasItem.interesGenerado + "</td>" +
                "<td style='text-align: right;width: 60px;background-color: " + fondo + ";'>" + ventasItem.montoAmortizado + "</td>" +
                "<td style='text-align: right;width: 60px;background-color: " + fondo + ";'>" + ventasItem.deudaTotal + "</td>" +
                "<td style='text-align: right;width: 50px;background-color: " + fondo + ";'>" + ventasItem.numeroLetras + "</td>" +
                "<td style='width: 50px; background-color: " + fondo + ";'>" + ventasItem.tVenta + "</td>" +
                "<td style='text-align: right;background-color: " + fondo + ";'>" + ventasItem.tCambio + "</td>" +
                "</tr>"
                );
        $('#' + ventasItem.codVentas).bind('click', function(event) {
            fVentasDetalle($(this).attr('id'));
            fVentaCreditoLetra($(this).attr('id'), $(this).attr('name'));
            $('#tVentasDetalle').find('tr').remove();
            $('#tVentasDetalle').append(
                    '<tr>' +
                    '<td>' + $(this).attr('class') + '</td>' +
                    '</tr>'
                    );
        });
        if (idx == 0) {
            fVentasDetalle(ventasItem.codVentas);
            fVentaCreditoLetra(ventasItem.codVentas, ventasItem.codPersona);
        }

    }
}
;

function fVentasDetalle(codVentas) {
    try {
        var data = "codVentas=" + codVentas;
        $.ajax({
            type: "post",
            url: "ajax/ventasDetalle.jsp",
            data: data,
            error: callback_error,
            success: fVentasDetalleRecuperar_callback
        });
    }
    catch (ex) {
        alert(ex);
    }
}
;
function fVentasDetalleRecuperar_callback(ajaxResponse, textStatus) {
    var ventasDetalleArray = procesarRespuesta(ajaxResponse);
    var $tbVentasDetalle = $('#tbVentasDetalle');
//    alert($('#tVentasDetalle').attr('id'));
    $tbVentasDetalle.find('tr').remove();
    var ventasDetalleItem;
    for (var idx=0; idx < ventasDetalleArray.length; idx++) {
        ventasDetalleItem = ventasDetalleArray[idx];
        $tbVentasDetalle.append(
                '<tr>' +
                '<td style="width: 100px;"></td>' +
                '<td style="width: 40px;text-align: right;">' + ventasDetalleItem.cantidad + '</td>' +
                '<td style="width: 370px;">' + ventasDetalleItem.descripcion + '</td>' +
                '<td style="width: 60px;text-align: right;">' + ventasDetalleItem.precioVenta + '</td>' +
                '<td style="text-align: right;">' + ventasDetalleItem.valorVenta + '</td>' +
                '</tr>'
                );
    }
}
;

function fVentaCreditoLetra(codVentas, codPersona) {
    try {
        var data = "codVentas=" + codVentas + '&codPersona=' + codPersona;
        $.ajax({
            type: "post",
            url: "ajax/ventasCreditoLetra.jsp",
            data: data,
            error: callback_error,
            success: fventasCreditoLetraRecuperar_callback
        });
    }
    catch (ex) {
        alert(ex + 'eee');
    }
}
;

function fventasCreditoLetraRecuperar_callback(ajaxResponse, textStatus) {
    var ventaCreditoLetraArray = procesarRespuesta(ajaxResponse);
    $('#tbVentasCreditoLetras').find('tr').remove();
    for (var idx=0; idx < ventaCreditoLetraArray.length; idx++) {
        var auxiliar = ventaCreditoLetraArray[idx];
        if (idx == ventaCreditoLetraArray.length - 1) {
            $('#lTotal').text(auxiliar.mTotal);
            $('#lAmortizado').text(auxiliar.mAmortizado);
            $('#lSaldo').text(auxiliar.mSaldo);
        } else {
            $('#tbVentasCreditoLetras').append(
                    '<tr>' +
                    '<td style="width: 90px; background-color:' + auxiliar.estilo + '">' + auxiliar.docNumeroSerie + '</td>' +
                    '<td style="width: 90px; background-color:' + auxiliar.estilo + '">' + auxiliar.detalleLetra + '</td>' +
                    '<td style="width: 70px; background-color:' + auxiliar.estilo + '">' + auxiliar.fechaVencimiento + '</td>' +
                    '<td style="width: 60px; background-color:' + auxiliar.estilo + '">' + auxiliar.monto + '</td>' +
                    '<td style="width: 60px; background-color:' + auxiliar.estilo + '">' + auxiliar.totalPago + '</td>' +
                    '<td style="width: 70px; background-color:' + auxiliar.estilo + '">' + auxiliar.fechaPago + '</td>' +
                    '<td style="width: 40px; background-color:' + auxiliar.estilo + '">' + auxiliar.diasRetraso + '</td>' +
                    '<td style="width: 60px; background-color:' + auxiliar.estilo + '">' + auxiliar.interes + '</td>' +
                    '<td style=" background-color:' + auxiliar.estilo + '">' + auxiliar.saldo + '</td>' +
                    '</tr>'
                    );
        }
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

function cobranzaRecuperar_callback(ajaxResponse, textStatus) {
    var cobranzaArray = procesarRespuesta(ajaxResponse);
    var $tCobranza = $('#tCobranza');
    var cobranzaItem;
    for (var idx=0; idx < cobranzaArray.length; idx++) {
        cobranzaItem = cobranzaArray[idx];
        $tCobranza.append(
                '<tr id="' + cobranzaItem.codCobranza + '" class="' + cobranzaItem.observacion + '">' +
                '<td style="width: 100px;">' + cobranzaItem.docSerieNumero + '</td>' +
                '<td style="width: 70px;text-align: right;">' + cobranzaItem.importe + '</td>' +
                '<td style="width: 70px;">' + cobranzaItem.fechaCobranza + '</td>' +
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
//            $('#cobranzaImprimir').attr('href', 'reporte/cobranzaImprimir.jsp?codCobranza=' + $(this).attr('id'));
        });
    }
}

function fResumenPagos(codPersona) {
    var data = "codPersona=" + codPersona;
    try {
        $.ajax({
            type: "post",
            url: "ajax/ventaCreditoLetraResumenPagos.jsp",
            data: data,
            error: callback_error,
            success: callback_resumenPagos
        });
    } catch (ex) {
        alert(ex);
    }
}
;

function callback_resumenPagos(ajaxResponse, textStatus) {
    var resumenPagosArray = procesarRespuesta(ajaxResponse);
    for (var idx=0; idx < resumenPagosArray.length; idx++) {
        var resumenPagosItem = resumenPagosArray[idx];
        $('#tResumenPagos').append(
                '<tr>' +
                '<td style="width: 70px;">' + resumenPagosItem.mesAnio + '</td>' +
                '<td style="width: 70px;text-align: right;">' + resumenPagosItem.monto + '</td>' +
                '<td style="width: 70px;text-align: right;">' + resumenPagosItem.interes + '</td>' +
                '<td style="width: 70px;text-align: right;">' + resumenPagosItem.pagos + '</td>' +
                '<td style="text-align: right;">' + resumenPagosItem.saldo + '</td>' +
                '</tr>'
                );
    }
}

function reiniciarDatosKardex() {
    $('#ventasCuerpo').find('tr').remove();
    $('#tbVentasDetalle').find('tr').remove();
    $('#tVentasDetalle').find('tr').remove();
    $('#tbVentasCreditoLetras').find('tr').remove();
    $('#tPagosRealizados').find('tr').remove();
    $('#tCobranza').find('tr').remove();
    $('#tCobranzaDetalle').find('tr').remove();
    $('#tResumenPagos').find('tr').remove();
    $('#bDatosCliente').removeAttr('href');
}
;

function callback_error(XMLHttpRequest, textStatus, errorThrown) {
    // en ambientes serios esto debe manejarse con mucho cuidado, aqui optamos por una solucion simple
    $('#lErrorServidor').text(errorThrown);
    $('#dErrorServidor').dialog('open');
}
;