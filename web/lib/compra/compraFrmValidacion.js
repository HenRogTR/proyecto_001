/* 
 * To change this template, choose Tools | Templates
 * and open the template in the editor.
 */
$(document).ready(function() {
    //════════════════
    $("#bRegistroExitoNuevo").click(function(event) {
        $("#dRegistroExitoso").dialog("close");
        event.preventDefault();
    });

//═══════════ inicializando dialogos ══════════
//dialogo proveedor no seleccionado
    $("#dProveedorNoSeleccionado").dialog({
        autoOpen: false,
        modal: true,
        resizable: true,
        height: 180,
        width: 350,
        buttons: {
            Aceptar: function() {
                $(this).dialog("close");
            }
        },
        close: function() {
            $("#dProveedorSeleccionar").dialog("open");
            $(this).dialog("close");
        }
    });
    //dialogo ningun articulo
    $("#dArticuloProductoNoSeleccionado").dialog({
        autoOpen: false,
        modal: true,
        resizable: true,
        height: 180,
        width: 400,
        buttons: {
            Aceptar: function() {
                $(this).dialog("close");
            }
        },
        close: function() {
            $("#lItem").text(parseInt($("#itemCantidad").val(), 10) + 1);
            $("#dArticuloProductoAgregar").dialog("open");
            $(this).dialog("close");
        }
    });
    $("#dRegistroExitoso").dialog({
        autoOpen: false,
        modal: true,
        resizable: true,
        height: 100,
        width: 250,
        close: function() {
            $(this).dialog("close");
        }
    });
    //═════════════════
});

$.validator.setDefaults({
    submitHandler: function() {
        $("#botones").addClass("ocultar");
        var cant = $("#itemCantidad").val(); //obtenemos la cantidad de articulos agregados
        var codProveedor = $("#codProveedor").val(); // obtenemos el codigo del proveedor
        if (codProveedor <= 0) {    //si no se ha seleccionado proveedor
            $("#dProveedorNoSeleccionado").dialog("open");
            $("#botones").removeClass("ocultar");
            return;
        }
        if (cant <= 0) {//si no se ha seleccionado ningun articulo para la compra
            $("#dArticuloProductoNoSeleccionado").dialog("open");   //se abre dialogo en caso no hay articulos
            $("#botones").removeClass("ocultar");
            return;
        }
        var $compraFrm = $("#compraFrm");
        var url = $compraFrm.attr("action");
        var datos = $compraFrm.serialize();
        $.ajax({
            type: 'POST',
            url: url,
            data: datos,
            beforeSend: mostrarLoader, //funciones que definimos más abajo
            error: callback_error,
            success: mostrarRespuesta  //funciones que definimos más abajo
        });
    },
    showErrors: function(map, list) {
        // there's probably a way to simplify this
        var focussed = document.activeElement;
        if (focussed && $(focussed).is("input, textarea")) {
            $(this.currentForm).tooltip("close", {currentTarget: focussed}, true)
        }
        this.currentElements.removeAttr("title").removeClass("ui-state-highlight");
        $.each(list, function(index, error) {
            $(error.element).attr("title", error.message).addClass("ui-state-highlight");
        });
        if (focussed && $(focussed).is("input, textarea")) {
            $(this.currentForm).tooltip("open", {target: focussed});
        }
    }
});
(function() {
    $("#compraFrm").tooltip({
        show: false,
        hide: false
    });
    $("#compraFrm").validate({
        rules: {
            docSerieNumero: {
                required: true,
                minlength: 4,
                remote: "validacion/verificarCompraDocSerieNumero.jsp",
            },
            tipo: {
                required: true
            },
            moneda: {
                required: true
            },
            fechaFactura: {
                required: true,
                dateITA: true
            },
            fechaVencimiento: {
                required: true,
                dateITA: true
            },
            fechaLlegada: {
                required: true,
                dateITA: true
            }
        },
        messages: {
            docSerieNumero: {
                remote: "El numero de documento ya fue registrado para este proveedor"
            },
            fechaFactura:{
                dateITA:'Por favor ingrese una fecha correcta'
            },
            fechaVencimiento:{
                dateITA:'Por favor ingrese una fecha correcta'
            },
            fechaLlegada:{
                dateITA:'Por favor ingrese una fecha correcta'
            }
        }
    });
})();
function mostrarLoader() {

}
function callback_error(XMLHttpRequest, textStatus, errorThrown) {
    alert(errorThrown);
    $("#botones").removeClass("ocultar");
}
function mostrarRespuesta(respuesta) {
    $("#botones").removeClass("ocultar");
    if (respuesta) {   //si se realizo exitosamente el registro
        reiniciarCompraFrm();
        $("#bRegistroExitoVer").attr("href", "../compra/compraMantenimiento.jsp?docSerieNumero=" + respuesta);
        $("#dRegistroExitoso").dialog("open");
    } else {
//        if (respuesta == "error") {
        $("#dErrorServidor").dialog("open");
//        }
    }
}
function reiniciarCompraFrm() {
    $("#docSerieNumero").val("");
    $("#tipo").val("1");
    $("#moneda").val("0");
    $("#codProveedor").val("");
    $("#lProveedor").text("");
    $("#lDireccion").text("");
    $("#fechaFactura").val("");
    $("#fechaVencimiento").val("");
    $("#fechaLlegada").val("");
    $("#itemCantidad").val("0");
    $("#tbArticuloProducto").find("tr").remove();
    $("#lSon").text("");
    $("#lSubTotal").text("");
    $("#descuento").val("");
    $("#observacion").val("");
    $("#lTotal").text("");
    $("#lNeto").text("");
}