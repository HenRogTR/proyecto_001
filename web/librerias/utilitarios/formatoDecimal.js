/* 
 * To change this template, choose Tools | Templates
 * and open the template in the editor.
 */
/**
 * Permite dar formato a un número decimal
 * @param {todos} numero a convertir
 * @param {int} cantidad decimales
 * @param {Boolean} separador de miles
 * @returns {fNumeroFormato.cad|String}
 */
function fNumeroFormato(numero, dec, miles) {
    var valor = ponValor(numero.toString());
    var num = valor, signo = 3, expr;
    var cad = '' + valor;
    var ceros = '', pos, pdec, i;
    for (i = 0; i < dec; i++) {
        ceros += '0';
    }

    pos = cad.indexOf('.');
    if (pos < 0) {
        cad = cad + '.' + ceros;
    } else {
        pdec = cad.length - pos - 1;

        if (pdec <= dec) {
            for (i = 0; i < (dec - pdec); i++) {

                cad += '0';
            }
        } else {
            num = num * Math.pow(10, dec);
            num = Math.round(num);
            num = num / Math.pow(10, dec);
            cad = new String(num);
        }
    }
    pos = cad.indexOf('.');
    if (pos < 0) {
        pos = cad.lentgh;
    }
    if (cad.substr(0, 1) == '-' || cad.substr(0, 1) == '+') {
        signo = 4;
    }
    if (miles && pos > signo) {
        do {
            expr = /([+-]?\d)(\d{3}[\.\,]\d*)/;
            cad.match(expr);
            cad = cad.replace(expr, RegExp.$1 + ',' + RegExp.$2);
        }
        while (cad.indexOf(',') > signo)
        {
            if (dec <= 0) {
                cad = cad.replace(/\./, '');
            }
        }
    }
    return cad;
}
;

function ponValor(cad) {
    if (cad == '-' || cad == '+')
        return cad
    if (cad.length == 0)
        return cad
    if (cad.indexOf('.') >= 0)
        return parseFloat(cad);
    else
        return parseInt(cad);
}
;