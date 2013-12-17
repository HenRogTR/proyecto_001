/* 
 * To change this template, choose Tools | Templates
 * and open the template in the editor.
 */

$(document).ready(function() {
    /*
     * ╔═══ ejecuciones durante todo la pagina
     * ║
     */
    $("#fechaFactura").datepicker({
        defaultDate: "-1m",
        changeMonth: true,
        changeYear: true,
        numberOfMonths: 3,
        onClose: function(selectedDate) {
            $("#fechaLlegada").datepicker("option", "minDate", selectedDate).val(selectedDate);
            var a = new Date(selectedDate.substring(6, 10), selectedDate.substring(3, 5) - 1 + 1, selectedDate.substring(0, 2));   //  01/02/2027 
            var dia = a.getDate() < 10 ? "0" + a.getDate() : a.getDate();
            var mes = (parseInt(a.getMonth()) + 1) < 10 ? "0" + (parseInt(a.getMonth()) + 1) : (parseInt(a.getMonth()) + 1);
            var anio = a.getFullYear();
            $("#fechaVencimiento").datepicker("option", "minDate", selectedDate);
            $("#fechaVencimiento").val(dia + "/" + mes + "/" + anio);
            //para abrir el dialogo al seleccionar la fecha de compra
            $("#lItem").text(parseInt($("#itemCantidad").val(), 10) + 1);
            $("#dArticuloProductoAgregar").dialog("open");
            $("#dArticuloProductoAgregar").dialog("open");
            //modificar la fecha de inicio de letras
        }
    });
    $('#fechaFactura').mask('99/99/9999');
    $("#fechaVencimiento").datepicker({
        changeMonth: true,
        changeYear: true,
        numberOfMonths: 2
    });
    $('#fechaVencimiento').mask('99/99/9999');

    $("#fechaLlegada").datepicker({
        changeMonth: true,
        changeYear: true,
        numberOfMonths: 2
    });
    $('#fechaLlegada').mask('99/99/9999');

    $("#cantidad").numeric({decimal: false, negative: false});  //no permite ingreso negativo o entero en cantidad u otro caracteres

    $("#cantidad").keyup(function() {    //mostrar la cantidad de campos para el ingreso de estos toma como dato la cantidad
        ocultarTodosCamposSeriesNumeros();
        if (comprobarCheckSerieNumero()) {
            if (cantidadItemActual() >= 0 & cantidadItemActual() <= 50) {
                if (cantidadItemActual() <= 7) {
                    $("#dArticuloProductoAgregar").dialog({height: (200 + cantidadItemActual() * 100)});
                } else {
                    $("#dArticuloProductoAgregar").dialog({height: 650});
                }
                $("#tSeriesNumeros").removeClass("ocultar");
                mostrarCamposSeriesNumeros();
            } else {
                alert("El sistema no soporta mas de 50 unidades con series\n y se procederá a poner el máximo (50)");
                $("#tSeriesNumeros").removeClass("ocultar");
                $("#cantidad").val("50");
                $("#dArticuloProductoAgregar").dialog({height: 650});
                mostrarCamposSeriesNumeros();
            }
        } else {
            $("#dArticuloProductoAgregar").dialog({height: 160});
            $("#tSeriesNumeros").addClass("ocultar");
        }
    });

    $("#cantidadE").numeric({decimal: false, negative: false});

    $("#codArticuloProducto").numeric({decimal: false, negative: false});

    $("#precioUnitario").numeric(",");  //precio unitario numerico y decimal positivo

    $("#precioUnitarioE").numeric(",");

    $("#descuento").numeric(",");  //descuento

    $("input,textarea").blur(function() {
        $(this).val($.trim($(this).val().toUpperCase()));   //lleva a amyusculas los datos ingresados al perder el foco
    });

    $("#docSerieNumero").keyup(function() {
        $("#tit").text("DOCUMENTO: " + $("#docSerieNumero").val().toUpperCase());   //actualiza el titulo con el dato ingresado
    });
    $('#docSerieNumero').mask('a-999-999999?999');
    $("#descuento").keyup(function() {
        var total = calculaTotal();
        $("#lTotal").text(numFormat(total.toString(), 2, false));
        var neto = calculaNeto();
        $("#lNeto").text(numFormat(neto.toString(), 2, false));
    });
    //metodo del check agregar
    $("#serieNumero").click(function(event) {
        event.preventDefault();
    });
    /*
     *║
     *╚═══ 
     */
    //==========autocompletados
    //******seleccionar proveedor
    // <editor-fold defaultstate="collapsed" desc="Haga clic en el signo + para mostrar descripción">
    // </editor-fold>
    $("#proveedorSeleccionar").autocomplete({
        source: "autocompletado/proveedorRucRazonSocialBuscarAutocompletado.jsp",
        minLength: 2,
        select: proveedorSeleccionado,
        focus: proveedorMarcado
    });
    $("#descripcion").autocomplete({
        source: "autocompletado/articuloProductoDescripcionBuscarAutocompletado.jsp",
        minLength: 4,
        select: articuloProductoSeleccionado,
        focus: articuloProductoMarcado
    });

    $("#descripcionE").autocomplete({
        source: "autocompletado/articuloProductoDescripcionBuscarAutocompletado.jsp",
        minLength: 4,
        select: articuloProductoESeleccionado,
        focus: articuloProductoEMarcado
    });

    $("#codArticuloProducto").autocomplete({
        source: "autocompletado/articuloProductoCodArticuloProductoBuscarAutocompletado.jsp",
        minLength: 1,
        select: articuloProductoSeleccionado,
        focus: articuloProductoMarcado
    });

    $("#codArticuloProductoE").autocomplete({
        source: "autocompletado/articuloProductoCodArticuloProductoBuscarAutocompletado.jsp",
        minLength: 1,
        select: articuloProductoESeleccionado,
        focus: articuloProductoEMarcado
    });
//    ========================eventos clic=======
//************abrir dialog proveedor seleccionar
    $("#bProveedorSeleccionar").click(function(event) {
        $("#dProveedorSeleccionar").dialog("open");
        event.preventDefault();
    });

    $("#bArticuloProductoAgregarDialogo").click(function(event) {
        $("#lItem").text(parseInt($("#itemCantidad").val(), 10) + 1);
        $("#dArticuloProductoAgregar").dialog("open");
        event.preventDefault();
    });

    $("#bEditarArticuloProducto").click(function(event) {//clic en boton editar del dialogo al hacer clic en nombre del articulo


//        $("#dArticuloProductoAccionClic").dialog("close");//cerramos el dialogo abierto- editar...eliminar
//        var $actual = $("#auxiliarArticuloProductoCambio");//hallamos el numero de item que se esta editando
//        //cargamos los dato al nuevo dialogo
//        $("#lItemE").text($("#lItem" + $actual.val()).text());//numero de item
//        $("#cantidadE").val($("#lCantidad" + $actual.val()).text()); // cantidad de input-text
//        $("#lUnidadMedidaE").text($("#lUnidadMedida" + $actual.val()).text()); //unidad de media label
//        $("#codArticuloProductoE").val($("#codArticuloProducto" + $actual.val()).val()); //codArticuloProducto input-hidden
//        $("#descripcionE").val($("#lDescripcion" + $actual.val()).text()); //descripcion input-text
//        $("#precioUnitarioE").val($("#lPrecioUnitario" + $actual.val()).text());
//        $("#dArticuloProductoEditar").dialog("open");
        alert("No se permite la edición de los datos\n elimine y vuelva a ingresar el artículo.");
        event.preventDefault();
    });

    $("#bEliminarArticuloProducto").click(function(event) {
        var actualEl = $("#auxiliarArticuloProductoCambio");//numero de item que esta editando input-hidden
        var cantidadAP = $("#itemCantidad"); //cantidad de articulo agregados input-hidden
        if (actualEl.val() == cantidadAP.val()) {
            $("#trArticuloProducto" + cantidadAP.val()).remove(); //removemos el ultimo despues de actualizar los datos
            cantidadAP.val(parseInt(cantidadAP.val()) - 1);//actualizamos contador de productos que sera 1 menos al actual
            var subTotal = calcularSubTotal();
            $("#lSubTotal").text(numFormat(subTotal.toString(), 2, false));
            var total = calculaTotal(); //calcualr el importe total
            $("#lTotal").text(numFormat(total.toString(), 2, false));   //asignamos total
            var neto = calculaNeto();   //calculamos neto
            $("#lNeto").text(numFormat(neto.toString(), 2, false)); //asignamos neto
            $("#dArticuloProductoAccionClic").dialog("close");
        } else {
            alert("Para eliminar, tiene que hacerlo desde el último agregado.");
            $("#dArticuloProductoAccionClic").dialog("close");
        }
        event.preventDefault();
    });

//    ============inicializacion de dialogos===========
    $("#dProveedorSeleccionar").dialog({
        autoOpen: false,
        modal: true,
        resizable: true,
        height: 80,
        width: 730,
        close: function() {
            $(this).dialog("close");
        },
    });

    $("#dArticuloProductoAgregar").dialog({
        autoOpen: false,
        modal: true,
        resizable: true,
        height: 160,
        width: 850,
        close: function() {
            $(this).dialog("close");
        },
        buttons: {
            Limpiar: function() {
                articuloProductoAgregarLimpiarCampos();
            },
            Agregar: function() {
                if ($("#cantidad").val() < 0) {    //verificar que de haya comprado al menos un articulo
                    $("#cantidad").focus();
                    return;
                }
                if ($("#codArticuloProducto").val() <= 0) { //verificar que se ha seleccionado un articulo
                    $("#codArticuloProducto").focus();
                    return;
                }
                if ($("#descripcion").val() <= 0) { //verificar que se ha seleccionado un articulo
                    $("#descripcion").focus();
                    return;
                }
                if ($("#precioUnitario").val() <= 0) {  //verificar que el precio unitario sea mayor a 0
                    $("#precioUnitario").val("0.00");
                }
                if (comprobarCheckSerieNumero()) {
                    for (var i = 1; i <= cantidadItemActual(); i++) {
                        var serieNumero = $("#serieNumero" + i);
                        if (serieNumero.val() == null || serieNumero.val() == "" || $.trim(serieNumero.val()) == "") {
                            serieNumero.val("").focus();
                            alert("Ingrese N/S de item (" + i + ")");
                            return;
                        }
                    }
                }
                var $item = $("#lItem");//$item=numero de item que ademas será nuestro id
                var $cantidad = $("#cantidad"); //$cantidad=cantidad comprada de articulo
                var $codArticuloProducto = $("#codArticuloProducto").val();   //
                var $descripcion = $("#descripcion");
                var $unidadMedida = $("#lUnidadMedida");
                var $precioUnitario = $("#precioUnitario");
                $("#tbArticuloProducto").append(
                        "<tr id='trArticuloProducto" + $item.text() + "'>" +
                        "<td style='text-align: right;'>" +
                        "<label id='lItem" + $item.text() + "'>" + $item.text() + "</label>" +
                        "</td>" +
                        "<td style='text-align: right;'>" +
                        "<input type='hidden' name='cantidad" + $item.text() + "' id='cantidad" + $item.text() + "' value='" + $cantidad.val() + "'/>" +
                        "<label id='lCantidad" + $item.text() + "'>" + parseInt($cantidad.val()) + "</label>" +
                        "</td>" +
                        "<td style='text-align: right;'>" +
                        "<label id='lUnidadMedida" + $item.text() + "'>" + $unidadMedida.text() + "</label>" +
                        "</td>" +
                        "<td>" +
                        "<input type='hidden' name='codArticuloProducto" + $item.text() + "' value='" + $codArticuloProducto + "' id='codArticuloProducto" + $item.text() + "'/>" +
                        "<label id='lDescripcion" + $item.text() + "' class='" + $item.text() + "'>" + $descripcion.val() + "</label>" +
                        "</td>" +
                        "<td style='text-align: right'>" +
                        "<input type='hidden' name='precioUnitario" + $item.text() + "' value='" + numFormat($precioUnitario.val(), 4, false) + "' id='precioUnitario" + $item.text() + "'/>" +
                        "<label id='lPrecioUnitario" + $item.text() + "'>" + numFormat($precioUnitario.val(), 4, false) + "</label>" +
                        "</td>" +
                        "<td style='text-align: right'>" +
                        "<input type='hidden' name='precioTotal" + $item.text() + "' value='" + numFormat(($precioUnitario.val() * $cantidad.val()).toString(), 4, false) + "' id='precioTotal" + $item.text() + "'/>" +
                        "<label id='lPrecioTotal" + $item.text() + "'>" + numFormat(($precioUnitario.val() * $cantidad.val()).toString(), 2, false) + "</label>" +
                        "</td>" +
                        '<td style="display:none;">' +
                        '<table id="tItem' + $item.text() + 'SerieNumero">' + //tabla que contendra S/N
                        '</table>' +
                        '</td>' +
                        "</tr>"
                        );
                if (comprobarCheckSerieNumero()) {
                    for (var i = 1; i <= $cantidad.val(); i++) {
                        $('#tItem' + $item.text() + 'SerieNumero').append(
                                '<tr>' +
                                '<td>' +
                                '<textarea name="item' + $item.text() + 'SerieNumero' + i + '" id="item' + $item.text() + 'SerieNumero' + i + '">' + $('#serieNumero' + i).val() + '</textarea>' +
                                '<textarea name="item' + $item.text() + 'SerieNumeroObservacion' + i + '" id="item' + $item.text() + 'SerieNumeroObservacion' + i + '">' + $('#serieNumeroObservacion' + i).val() + '</textarea>' +
                                '</td>' +
                                '</tr>'
                                );
                    }
                }
                $("#itemCantidad").val(parseInt($item.text()));//actualizamos contador de productos
                articuloProductoAgregarLimpiarCampos();//limpiamos los campos para volver a usar
                //calculando subtotal
                var subTotal = calcularSubTotal();
                $("#lSubTotal").text(numFormat(subTotal.toString(), 2, false));
                var total = calculaTotal(); //calcualr el importe total
                $("#lTotal").text(numFormat(total.toString(), 2, false));   //asignamos total
                var neto = calculaNeto();   //calculamos neto
                $("#lNeto").text(numFormat(neto.toString(), 2, false)); //asignamos neto

                //asignamos accion editar
                $("#lDescripcion" + $item.text()).bind("dblclick", function(event) {
                    var actual = $(this).attr("class"); //captuarmos el numero de item tomando el dato del atributo class
                    $("#auxiliarArticuloProductoCambio").val(actual);
                    $("#dArticuloProductoAccionClic").dialog({title: 'Item ' + actual});
                    if ($("#item" + actual + "SerieNumero1").val()) {
                        $("#tSerieNumeroVista").find("tr").remove();
                        $("#tSerieNumeroVista").append(
                                '<tr>' +
                                '<th style="width: 80px;">N° Cantidad</th>' +
                                '<th style="width: 180px;">Serie Número</th>' +
                                '<th style="width: 300px;">Observación</th>' +
                                '</tr>'
                                );
                        for (var i = 1; i <= $("#cantidad" + actual).val(); i++) {
                            $("#tSerieNumeroVista").append(
                                    "<tr>" +
                                    "<td>" + i + "</td>" +
                                    "<td>" + $("#item" + actual + "SerieNumero" + i).val() + "</td>" +
                                    "<td>" + $("#item" + actual + "SerieNumeroObservacion" + i).val() + "</td>" +
                                    "</tr>"
                                    );
                        }

                        $("#dArticuloProductoAccionClic").dialog({height: 600});
                        $("#dArticuloProductoAccionClic").dialog({width: 600});
                        $("#tSerieNumeroVista").removeClass("ocultar");
                    }
                    else {
                        $("#tSerieNumeroVista").addClass("ocultar");
                        $("#dArticuloProductoAccionClic").dialog({height: 90});
                        $("#dArticuloProductoAccionClic").dialog({width: 220});
                    }
                    $("#dArticuloProductoAccionClic").dialog("open");
                    event.preventDefault();
                });

                $item.text(parseInt($("#itemCantidad").val()) + 1);//actualizamos numero de item actual en el dialogo agregar
                $("#codArticuloProducto").focus();//indicamos el focus en cantidad
                $("#serieNumero").removeAttr("checked");    //quitamos el check de serieNumero
                $("#tSeriesNumeros").addClass("ocultar");   //ocultamos tabla serie numero
                ocultarTodosCamposSeriesNumeros();
                limpiarDatosTSerieNumero();
                $("#dArticuloProductoAgregar").dialog({height: 160});   //obtenemo mismo tamaño
            },
        },
    });

    $("#dArticuloProductoEditar").dialog({
        autoOpen: false,
        modal: true,
        resizable: true,
        height: 160,
        width: 850,
        buttons: {
            Cambiar: function() {
                var actualD = $("#auxiliarArticuloProductoCambio").val();
                if ($("#cantidadE").val() <= 0) {    //verificar que de haya comprado al menos un articulo
                    $("#cantidadE").focus();
                    return;
                }
                if ($("#codArticuloProductoE").val() <= 0) { //verificar que se ha seleccionado un articulo
                    $("#codArticuloProductoE").focus();
                    return;
                }
                if ($("#descripcionE").val() <= 0) { //verificar que se ha seleccionado un articulo
                    $("#descripcionE").focus();
                    return;
                }
                if ($("#precioUnitarioE").val() <= 0) {  //verificar que el precio unitario sea mayor a 0
                    $("#precioUnitarioE").focus();
                    return;
                }
                //var $itemE = $("#lItemE");//$item=numero de item que ademas será nuestro id
                var $cantidadE = $("#cantidadE"); //$cantidad=cantidad comprada de articulo
                var $codArticuloProductoE = $("#codArticuloProductoE");   //
                var $descripcionE = $("#descripcionE");
                var $unidadMedidaE = $("#lUnidadMedidaE");
                var $precioUnitarioE = $("#precioUnitarioE");

                //actualizamos con los nuevos campos ya editados
                $("#cantidad" + actualD).val($cantidadE.val());//cantidad toma de input-text a input-hidden
                $("#lCantidad" + actualD).text($cantidadE.val());//cantidad toma de input-text a label
                $("#codArticuloProducto" + actualD).val($codArticuloProductoE.val()); //codArticuloProducto input-hidden a input-hidden
                $("#lDescripcion" + actualD).text($descripcionE.val()); //input-text a label
                $("#lUnidadMedida" + actualD).text($unidadMedidaE.text()); //label a label
                $("#precioUnitario" + actualD).val($precioUnitarioE.val()); //input-text a label
                $("#lPrecioUnitario" + actualD).text(numFormat($precioUnitarioE.val(), 4, false)); //input-text a label
                $("#precioTotal" + actualD).val(numFormat(($precioUnitarioE.val() * $cantidadE.val()).toString(), 2, false)); //precioTotal se calcula
                $("#lPrecioTotal" + actualD).text(numFormat(($precioUnitarioE.val() * $cantidadE.val()).toString(), 2, false)); //precioTotal se calcula
                //calculando subtotal
                var subTotal = calcularSubTotal();
                $("#lSubTotal").text(numFormat(subTotal.toString(), 2, false));
                var total = calculaTotal(); //calcualr el importe total
                $("#lTotal").text(numFormat(total.toString(), 2, false));   //asignamos total
                var neto = calculaNeto();   //calculamos neto
                $("#lNeto").text(numFormat(neto.toString(), 2, false)); //asignamos neto
                $(this).dialog("close");
            },
        },
        close: function() {
            $(this).dialog("close");
        },
    });

    $("#dArticuloProductoAccionClic").dialog({
        autoOpen: false,
        modal: true,
        resizable: true,
        height: 90,
        width: 220,
        close: function() {
            $(this).dialog("close");
        },
    });

});

function proveedorSeleccionado(event, ui) {
    var proveedor = ui.item.value;
    $("#codProveedor").val(proveedor.codProveedor);
    $("#lProveedor").text(proveedor.ruc + " " + proveedor.razonSocial);
    $("#lDireccion").text(proveedor.direccion);
    $("#proveedorSeleccionar").val("");
    $("#sProveedorSeleccionar").removeClass("add").addClass("edit");
    $("#dProveedorSeleccionar").dialog("close");
    $("#fechaFactura").focus();
    event.preventDefault();
}

function proveedorMarcado(event, ui) {
    var proveedor = ui.item.value;
    $("#proveedorSeleccionar").val(proveedor.ruc + " " + proveedor.razonSocial);
    event.preventDefault();
}

function articuloProductoMarcado(event, ui) {
    var articuloProducto = ui.item.value;
    $("#descripcion").val(articuloProducto.descripcion);
    event.preventDefault();
}

function articuloProductoSeleccionado(event, ui) {
    var articuloProducto = ui.item.value;
    $("#codArticuloProducto").val(articuloProducto.codArticuloProducto);
    $("#cantidad").focus();
    $("#descripcion").val(articuloProducto.descripcion);
    $("#lUnidadMedida").text(articuloProducto.unidadMedida);
    if (articuloProducto.usarSerieNumero) {
        $("#serieNumero").attr("checked", "checked");
        if (cantidadItemActual() >= 0 & cantidadItemActual() <= 50) {
            if (cantidadItemActual() <= 9) {
                $("#dArticuloProductoAgregar").dialog({height: (200 + cantidadItemActual() * 50)});
            } else {
                $("#dArticuloProductoAgregar").dialog({height: 650});
            }
            $("#tSeriesNumeros").removeClass("ocultar");
            mostrarCamposSeriesNumeros();
        } else {
            alert("El sistema no soporta mas de 50 unidades con series\n y se procederá a poner el máximo (50)");
            $("#tSeriesNumeros").removeClass("ocultar");
            $("#cantidad").val("50");
            $("#dArticuloProductoAgregar").dialog({height: 650});
            mostrarCamposSeriesNumeros();
        }
        alert("El articulo requiere el ingreso de S/N");
    } else {
        $("#serieNumero").removeAttr("checked");
        $("#tSeriesNumeros").addClass("ocultar");
        $("#dArticuloProductoAgregar").dialog({height: 160});
    }

    event.preventDefault();
}
//funciones de dialog cambiar E
function articuloProductoEMarcado(event, ui) {
    var articuloProducto = ui.item.value;
    $("#descripcionE").val(articuloProducto.descripcion);
    event.preventDefault();
}

function articuloProductoESeleccionado(event, ui) {
    var articuloProducto = ui.item.value;
    $("#codArticuloProductoE").val(articuloProducto.codArticuloProducto);
    $("#precioUnitarioE").focus();
    $("#descripcionE").val(articuloProducto.descripcion);
    $("#lUnidadMedidaE").text(articuloProducto.unidadMedida);
    event.preventDefault();
}

function articuloProductoAgregarLimpiarCampos() {
    $("#cantidad").val("1");
    $("#lUnidadMedida").text("");
    $("#codArticuloProducto").val("");
    $("#descripcion").val("");
    $("#precioUnitario").val("");
}

function calcularSubTotal() {
    var $cantidad = $("#itemCantidad");
    var subTotal = 0.00;
    for (var i = 1; i <= $cantidad.val(); i++) {
        subTotal = parseFloat(subTotal) + parseFloat($("#lPrecioTotal" + i).text());
    }
    return subTotal;
}

function calculaTotal() {
    if ($("#descuento").val() == "" || $("#descuento").val() == null) {
        $("#descuento").val("0.00");
    }
    if ($("#lSubTotal").text() == "" || $("#lSubTotal").text() == null) {
        return -parseFloat($("#descuento").val());
    } else {
        return parseFloat($("#lSubTotal").text()) - parseFloat($("#descuento").val());
    }
}

function calculaNeto() {
    return parseFloat($("#lTotal").text()) * (1 + parseFloat($("#lMontoIgv").text()));
}

/**
 * Comprueba que el check de <b>S/N</b> este o no marcado.
 * @returns {Boolean}
 */
function comprobarCheckSerieNumero() {
    if ($(".serieNumero").is(":checked")) {
        return true;
    } else {
        return false;
    }
}

/**
 * Obtener la cantidad de articulos que se van a agregar
 * @returns {Number}
 */
function cantidadItemActual() {
    var cantidad = $("#cantidad").val();
    if (isNaN(cantidad)) {
        return 0;
    }
    if (cantidad == null || cantidad == "" || cantidad == 0) {
        return 0;
    } else {
        return cantidad;
    }
}

function mostrarCamposSeriesNumeros() {
    for (var i = 1; i <= cantidadItemActual(); i++) {
        $("#trSerieNumero" + i).removeClass("ocultar");
    }
}

function ocultarTodosCamposSeriesNumeros() {
    $("#seriesNumeros").find("tr").addClass("ocultar");
}

function limpiarDatosTSerieNumero() {
    for (var i = 1; i <= 50; i++) {
        $('#serieNumero' + i).val('');
        $('#serieNumeroObservacion' + i).val('');
    }
}