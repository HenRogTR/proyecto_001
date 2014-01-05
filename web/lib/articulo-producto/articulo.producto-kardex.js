/* 
 * To change this template, choose Tools | Templates
 * and open the template in the editor.
 */

$(document).ready(function() {
    var cod, desc, stock;
    $("#codArticuloProducto").keypress(function(e) {
        if (e.which == 13) {
            var a = $("#codArticuloProducto").val();
            if (a == null || a == "" || $.trim(a) == "" || $("#codAlmacen").val() == "") {
//                                    $("#codArticuloProducto").val("");
                return;
            }
            kardexArticuloProductoRecuperar($("#codArticuloProducto").val(), $("#codAlmacen").val());
            $("#codArticuloProducto").val("");
        }
    });
    $("#codAlmacen").change(function() {
        var a = $("#codArticuloProducto").val();
        if (a == null || a == "" || $.trim(a) == "" || $("#codAlmacen").val() == "") {
//                                    $("#codArticuloProducto").val("");
            return;
        }
        kardexArticuloProductoRecuperar($("#codArticuloProducto").val(), $("#codAlmacen").val());
        $("#codArticuloProducto").val("");
    });
//        $("#codArticuloProducto").autocomplete({
//            source: "autocompletado/articuloProductoCodBuscar.jsp", /* este es el formulario que realiza la busqueda */
//            minLength: 1, /* le decimos que espere hasta que haya 2 caracteres escritos */
//            select: articuloProductoSeleccionado, /* esta es la rutina que extrae la informacion del registro seleccionado */
//            focus: articuloProductoMarcado
//        });
    $("#descripcion").autocomplete({
        source: "autocompletado/articuloProductoDescripcionBuscar.jsp", /* este es el formulario que realiza la busqueda */
        minLength: 3, /* le decimos que espere hasta que haya 2 caracteres escritos */
        select: articuloProductoSeleccionado, /* esta es la rutina que extrae la informacion del registro seleccionado */
        focus: articuloProductoMarcado
    });

});

function articuloProductoSeleccionado(event, ui) {
    var articuloProducto = ui.item.value;
    $("#codArticuloProducto").val(articuloProducto.codArticuloProducto);
    $("#descripcion").val(articuloProducto.descripcion);
    cod = articuloProducto.codArticuloProducto;
    event.preventDefault();
    if ($("#codAlmacen").val() == "")
        return;
    kardexArticuloProductoRecuperar(articuloProducto.codArticuloProducto, $("#codAlmacen").val());
}
;

// tras seleccionar un producto, calculamos el importe correspondiente
function articuloProductoMarcado(event, ui) {
    var articuloProducto = ui.item.value;
    $("#codArticuloProducto").val(articuloProducto.codArticuloProducto);
    $("#descripcion").val(articuloProducto.descripcion);
    event.preventDefault();
}
;

function kardexArticuloProductoRecuperar(codArticuloProducto, codAlmacen) {
    try {
        var data = "codArticuloProducto=" + codArticuloProducto + "&codAlmacen=" + codAlmacen;
        $.ajax({
            type: "post",
            url: "ajax/articuloProductoKardexRecuperar.jsp",
            data: data,
            context: {"codArticuloProducto": codArticuloProducto},
            error: callback_error,
            success: kardexArticuloProductoRecuperar_callback
        });
        cod = codArticuloProducto;
    }
    catch (ex) {
        alert(ex.description);
    }
}
;

// mostramos un mensaje con la causa del problema
function callback_error(XMLHttpRequest, textStatus, errorThrown) {
    // en ambientes serios esto debe manejarse con mucho cuidado, aqui optamos por una solucion simple
    alert(errorThrown);
}
;

function kardexArticuloProductoRecuperar_callback(ajaxResponse, textStatus) {
    var kardexArticuloProducto = procesarRespuesta(ajaxResponse);
    var $tabla = $("#kardexArticuloProducto");
    if (!kardexArticuloProducto) {
        $tabla.find("tr").remove();
        $tabla.append(
                "<tr>" +
                "<td colspan='9'>No hay movimiento de artículo</td>" +
                "</tr>");
        $("#arti").text("COD:");
        $("#codArticuloProducto").val("");
        $("#descripcion").val("");
        return;
    }
    var articuloProducto;
    $tabla.find("tr").remove();
    for (var idx=0; idx < kardexArticuloProducto.length; idx++) {
        articuloProducto = kardexArticuloProducto[idx];
        $tabla.append(
                "<tr>" +
                "<td>" + articuloProducto.registro + "</td>" +
                "<td>" + articuloProducto.docSerieNumero + "</td>" +
                "<td style='font-size:10px;'>" + articuloProducto.detalle + "</td>" +
                "<td style='text-align: right'>" + articuloProducto.entrada + "</td>" +
                "<td style='text-align: right'>" + articuloProducto.salida + "</td>" +
                "<td style='text-align: right'>" + articuloProducto.stock + "</td>" +
                "<td style='text-align: right'>" + articuloProducto.precio + "</td>" +
                "<td style='text-align: right'>" + articuloProducto.precioPonderado + "</td>" +
                "<td style='text-align: right'>" + articuloProducto.total + "</td>" +
                "</tr>");
        desc = articuloProducto.descripcion;
        stock = articuloProducto.stock;
    }
    $("#arti").text("COD: " + cod + " ==== DESC: " + desc + " ====" + " STOCK: " + stock);
    $("#codArticuloProducto").val("");
    $("#descripcion").val("");
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
