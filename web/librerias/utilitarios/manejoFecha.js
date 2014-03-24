/**
 * Convierte una cadena de texto a Date, la entrada tiene que ser de la fomra dd/mm/yyyy .
 * @param {String} value
 * @returns {Date}
 */
function fStringADate(value) {
    var adata = value.split('/');
    var dd = parseInt(adata[0], 10);
    var mm = parseInt(adata[1], 10);
    var aaaa = parseInt(adata[2], 10);
    return new Date(aaaa, mm - 1, dd);
}
;

/**
 * Convierte una fecha de tipo a Date a String de la fomra dd/mm/yyyy.
 * @param {Date} fechaDate
 * @returns {String} dd/mm/yyyy
 */
function fDateAString(fechaDate) {
    var dd = fechaDate.getDate();
    var mm = fechaDate.getMonth() + 1;
    var yyyy = fechaDate.getFullYear();
    return '' + (dd < 9 ? '0' + dd : dd) + '/' + (mm < 9 ? '0' + mm : mm) + '/' + yyyy;
}
;

/**
 * 
 * @param {Date} value
 * @param {integer} nDia
 * @returns {Date}
 */
function fSumarDia(value, nDia) {
    var adata = fDateAString(value).split('/');
    var dd = parseInt(adata[0], 10);
    var mm = parseInt(adata[1], 10);
    var aaaa = parseInt(adata[2], 10);
    return new Date(aaaa, mm - 1, dd + nDia);
}
;

/**
 * 
 * @param {Date} value
 * @param {integer} nMes
 * @returns {Date}
 */
function fSumarMes(value, nMes) {
    var adata = fDateAString(value).split('/');
    var dd = parseInt(adata[0], 10);
    var mm = parseInt(adata[1], 10);
    var aaaa = parseInt(adata[2], 10);
    return new Date(aaaa, (mm - 1) + nMes, dd);
}
;

/**
 * 
 * @param {Date} value
 * @param {integer} nAnio
 * @returns {Date}
 */
function fSumarAnio(value, nAnio) {
    var adata = fDateAString(value).split('/');
    var dd = parseInt(adata[0], 10);
    var mm = parseInt(adata[1], 10);
    var aaaa = parseInt(adata[2], 10);
    return new Date(aaaa + nAnio, mm - 1, dd);
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

/**
 * 
 * @param {String} fecha1
 * @param {String} fecha2
 * @returns {int}
 */
function fComparaFecha(fecha1, fecha2) {
    var f1 = fStringADate(fecha1).getTime();
    var f2 = fStringADate(fecha2).getTime();
    return (f1 < f2 ? -1 : (f1 == f2 ? 0 : 1));

}
;