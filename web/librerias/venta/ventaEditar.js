/* 
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */

//<editor-fold defaultstate="collapsed" desc="$(document).ready(function() {});. Clic en el signo + de la izquierda para mas detalles.">
$(document).ready(function() {
});
//</editor-fold>

//<editor-fold defaultstate="collapsed" desc="$(function() {});. Clic en el signo + de la izquierda para mas detalles.">
$(function() {
    $('#formVentaRegistrar').validate({
        submitHandler: function() {
            if (fVentaRegistrarVerificar()) {
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

//<editor-fold defaultstate="collapsed" desc="funciones. Clic en el signo + de la izquierda para mas detalles.">
function fPaginaActual() {
}
;
//</editor-fold>

