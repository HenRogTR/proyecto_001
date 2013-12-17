/* 
 * To change this template, choose Tools | Templates
 * and open the template in the editor.
 */
/**
 * Convierte una cadena de texto a Date, la entrada tiene que ser de la fomra dd/mm/yyyy .
 * @param {String} value
 * @returns {Date}
 */
function fStringADate(value) {
    var adata = value.split('/');
    var gg = parseInt(adata[0], 10);
    var mm = parseInt(adata[1], 10);
    var aaaa = parseInt(adata[2], 10);
    return new Date(aaaa, mm - 1, gg);

}

/**
 * Valida si una cadena de texto es un formato de fecha incorrecta de la forma dd/mm/yyyy
 * @param {string} value
 * @returns {Boolean}
 */
function fValidarFecha(value) {
    var check = false;
    var re = /^\d{1,2}\/\d{1,2}\/\d{4}$/;
    if (re.test(value)) {
        var adata = value.split('/');
        var gg = parseInt(adata[0], 10);
        var mm = parseInt(adata[1], 10);
        var aaaa = parseInt(adata[2], 10);
        var xdata = new Date(aaaa, mm - 1, gg);
        if ((xdata.getFullYear() === aaaa) && (xdata.getMonth() === mm - 1) && (xdata.getDate() === gg)) {
            check = true;
        } else {
            check = false;
        }
    } else {
        check = false;
    }
    return check;
}