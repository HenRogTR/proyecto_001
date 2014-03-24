/* 
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */


function fValidarRequerido(value) {
    if (value == null)
        return false;
    return fTrim(value).length > 0;
}
;

function fValidarMinimo(value, minimo) {
    if (value == null)
        return false;
    return fTrim(value).length >= minimo;
}
;

function fValidarMaximo(value, maximo) {
    if (value == null)
        return false;
    return fTrim(value).length <= maximo;
}
;

function fValidarVentaDocSerieNumero(value) {
    var re = /^[a-zA-Z]{1}\-\d{3}\-\d{6}$/;
    return re.test(value);
}
;

function fValidarCobranzaDocSerieNumero(value) {
    var re = /^[a-zA-Z]{1}[a-zA-Z0-9]{0,2}\-\d{3}\-\d{6}$/;
    return re.test(value);
}
;

function fValidarCompraDocSerieNumero(value) {
    var re = /^[a-zA-Z]{1}\-\d{3}\-\d{6,10}$/;
    return re.test(value);
}
;

/**
 * Valida si una cadena de texto es un formato de fecha incorrecta de la forma dd/mm/yyyy
 * @param {string} value
 * @returns {Boolean}
 */
function fValidarFecha(value) {
    var check = false;
    var re = /^\d{2}\/\d{2}\/\d{4}$/;
    if (re.test(value)) {
        var adata = value.split('/');
        var dd = parseInt(adata[0], 10);
        var mm = parseInt(adata[1], 10);
        var aaaa = parseInt(adata[2], 10);
        var xdata = new Date(aaaa, mm - 1, dd);
        if ((xdata.getFullYear() === aaaa) && (xdata.getMonth() === mm - 1) && (xdata.getDate() === dd)) {
            check = true;
        } else {
            check = false;
        }
    } else {
        check = false;
    }
    return check;
}
;

function fTrim(str) {
    str = str.toString();
    return str.replace(/^\s+|\s+$/g, "");
}