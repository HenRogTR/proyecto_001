/* 
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */

$(document).ready(function() {


    $('#fecha_interesFijar')
            .mask('00/00/0000')
            .blur(function(e) {
                if (!fValidarFecha(this.value)) {
                    this.value = '';
                }
            })
            .val($('#fechaActual').val());

    $('#esperaDia').mask('#', {maxlength: false});

    $('#b_interesCambiar').click(function(e) {
        $('#interesAnterior').text($('#interesFactor').text());
        $('#interesNuevo').val('');
        $('#d_interesCambiar').dialog('open');
        e.preventDefault();
    });

    $('#b_interes_actualizar').click(function(e) {
        if (!fValidarFecha($('#fecha_interesFijar').val())) {
            $.growl.warning({title: 'Éxito', message: 'Formato de fecha incorrecta o no ingresada.', size: 'large'});
            return;
        }
        if (!f_validarPositivo($('#esperaDia').val())) {
            $.growl.warning({title: 'Éxito', message: 'Ingrese dias de espera.', size: 'large'});
            return;
        }
        $('#d_interesGeneralActualizar').dialog('open');
        e.preventDefault();
    });

    $('#interesNuevo')
            .mask('099.99')
            .blur(function(e) {
                if ($.isNumeric(this.value)) {
                    this.value = fNumeroFormato(this.value, 2, false);
                }
            });
});

$(function() {
    $('#d_configuracion').accordion({
        heightStyle: 'content',
        collapsible: true
    });

    $('#d_interesCambiar').dialog({
        autoOpen: false,
        modal: true,
        resizable: false,
        height: 180,
        width: 300,
        buttons: {
            Continuar: function() {
                var $interesNuevo = $('#interesNuevo');
                if (!f_validar_menorIgual($interesNuevo.val(), 100)) {
                    $.growl.warning({title: 'Alerta', message: 'Ingrese un valor válido entre 0.00 - 100.00.', size: 'large'});
                    $interesNuevo.focus();
                    return;
                }
                f_interesFactorActualizar(
                        $interesNuevo.val(),
                        function(estado, mensaje) {
                            if (estado) {
                                $('#interesFactor').text($interesNuevo.val());
                                $.growl.notice({title: 'Éxito', message: 'El factor de interés se actualizó con exito.', size: 'large'});
                                $('#d_interesCambiar').dialog('close');
                            } else {
                                $.growl.error({title: 'Error', message: mensaje, size: 'large'});
                            }
                        }
                );
            }
        },
        close: function() {
            $(this).dialog('close');
        }
    });
    $('#d_interesGeneralActualizar').dialog({
        autoOpen: false,
        modal: true,
        resizable: false,
        height: 250,
        width: 400,
        buttons: {
            Cerrar: function() {
                $(this).dialog('close');
            },
            Continuar: function() {
                f_interesActualizar();
            }
        },
        close: function() {
            $(this).dialog('close');
        }
    });
});

//<editor-fold defaultstate="collapsed" desc="funcion f_empresaConvenio(). Clic en + para mas detalles.">
/**
 * Contruye la tabla con los datos de todas la empresas convenios existentes.
 * @returns {undefined}
 */
function f_empresaConvenio() {
    var data = '';
    var url = 'ajax/empresaConvenio.jsp';
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
                var arr = procesarRespuesta(ajaxResponse);
                var tam = arr.length;
                var $t_empresaConvenio = $('#t_empresaConvenio');
                var $tb_empresaConvenio = $('#tb_empresaConvenio');
                for (var i = 0; i < tam; i++) {
                    var it = arr[i];
                    var $tr = $('<tr/>').appendTo($tb_empresaConvenio);
                    var $td1 = $('<td/>', {html: '<strong>' + it.codCobranza + '</strong> ' + it.nombre}).appendTo($tr);
                    var $td2 = $('<td/>').appendTo($tr);
                    var $input2 = $('<input/>', {id: 'interesAsigando_' + it.codEmpresaConvenio, name: it.codEmpresaConvenio, type: 'checkbox', 'class': 'interesAsigando', prop: {'checked': it.interesAsigando}}).appendTo($td2);
                    var $td3 = $('<td/>').appendTo($tr);
                    var $input3 = $('<input/>', {id: 'interesAutomatico_' + it.codEmpresaConvenio, name: it.codEmpresaConvenio, type: 'checkbox', 'class': 'interesAutomatico', prop: {'checked': it.interesAutomatico, 'disabled': !it.interesAsigando}}).appendTo($td3);
                }
                $t_empresaConvenio.find('tfoot').addClass('ocultar');
                $('.interesAsigando').bind('click', f_interesAsigando_click);
                $('.interesAutomatico').bind('click', f_interesAutomatico_click);
                fProcesandoPeticionCerrar();
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

//<editor-fold defaultstate="collapsed" desc="function f_interesFactor(). Clic en + para mas detalles.">
function f_interesFactorLeer() {
    $('#interesFactor').addClass('ocultar').next().removeClass('ocultar');
    var url = 'ajax/interesFactor.jsp';
    try {
        $.ajax({
            type: 'post',
            url: url,
            error: function(XMLHttpRequest, textStatus, errorThrown) {
                $('#lServidorError').text(errorThrown + '()');
                $('#dServidorError').dialog('open');
            },
            success: function(ajaxResponse, textStatus) {
                $('#interesFactor').text(ajaxResponse).removeClass('ocultar').next().addClass('ocultar');
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

function f_interesFactorActualizar(interesNuevo, callback) {
    var data = {
        accion: 'interesFactorActualizar',
        interesNuevo: interesNuevo
    };
    var url = '../sDatosExtras';
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
                callback($.isNumeric(ajaxResponse), ajaxResponse);
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

//<editor-fold defaultstate="collapsed" desc="funcion f_interesAsigando_click(). Clic en + para mas detalles.">
/**
 * Funcion asiganda al evento click en el checkbox de interés asigando.
 * @returns {undefined}
 */
function f_interesAsigando_click() {
    var cEC = this.id.split('_')[1];
    var $this = $(this);
    //true o false
    var estadoChecked = $this.prop('checked');
    //actualizamos el estado del check
    f_interesAsigando_actualizar(
            cEC,
            estadoChecked,
            function(estado) {  //calback
                //si no se registra el cambio se vuelve a su forma inicial
                if (!estado) {
                    $this.prop('checked', !estadoChecked);
                } else {
                    if (estadoChecked) {
                        $('#interesAutomatico_' + cEC).prop('disabled', false);
                    } else {
                        $('#interesAutomatico_' + cEC).prop('disabled', true).prop('checked', false);
                        //si se quita el check tambien hay que quitar el chek al interes automático.
                        f_interesAutomatico_actualizar(cEC, false);
                    }
                }
            }
    );
}
;
//</editor-fold>

//<editor-fold defaultstate="collapsed" desc="funcion f_interesAutomatico_click(). Clic en + para mas detalles.">
/**
 * Funcion asiganda al evento click en el checkbox de interés automatico.
 * @returns {undefined}
 */
function f_interesAutomatico_click() {
    //obtenemos el id la cua les de la forma text_id
    var cEC = this.id.split('_')[1];
    var $this = $(this);
    //cambiamos estado de check
    var estadoChecked = $this.prop('checked');
    //actualizamos en la bd
    f_interesAutomatico_actualizar(cEC, estadoChecked);
}
;
//</editor-fold>

//<editor-fold defaultstate="collapsed" desc="funcion f_interesAsigando_actualizar(cEC, estadoChecked, callback). Clic en + para mas detalles.">
/**
 * Función que actualiza los datos en la BD.
 * @param {type} cEC
 * @param {type} estadoChecked
 * @param {function} callback
 * @returns {Boolean}
 */
function f_interesAsigando_actualizar(cEC, estadoChecked, callback) {
    var estado = false;
    var data = {
        accion: 'interesAsigando',
        codEmpresaConvenio: cEC,
        interesAsigando: estadoChecked
    };
    var url = '../sEmpresaConvenio';
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
                if ($.isNumeric(ajaxResponse)) {
                    estado = true;
                    $.growl.notice({title: 'Éxito', message: 'El interés asigando se cambió con exito.', size: 'large'});
                } else {
                    estado = false;
                    fAlerta(ajaxResponse);
                }
                callback(estado);
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
    return estado;
}
;
//</editor-fold>

//<editor-fold defaultstate="collapsed" desc="function f_interesAutomatico_actualizar(cEC, estadoChecked). Clic en + para mas detalles.">
/**
 * 
 * @param {type} cEC
 * @param {type} estadoChecked
 * @returns {undefined}
 */
function f_interesAutomatico_actualizar(cEC, estadoChecked) {
    var data = {
        accion: 'interesAutomatico',
        codEmpresaConvenio: cEC,
        interesAutomatico: estadoChecked
    };
    var url = '../sEmpresaConvenio';
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
                if (!$.isNumeric(ajaxResponse)) {
                    $('#interesAutomatico_' + cEC).prop('checked', !estadoChecked);
                    fAlerta(ajaxResponse);
                } else {
                    $.growl.notice({title: 'Éxito', message: 'El interés automático se cambió con exito.', size: 'large'});
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

//<editor-fold defaultstate="collapsed" desc="function f_interesActualizar(). Clic en + para mas detalles.">
function f_interesActualizar() {
    fProcesandoPeticion('No cierre ni actualize la página.');
    $('#d_interesGeneralActualizar').dialog('close');
    var data = {
        accion: 'interesActualizar',
        esperaDia: $('#esperaDia').val(),
        fecha: $('#fecha_interesFijar').val()
    };
    var url = '../sVentaCreditoLetra';
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
                fProcesandoPeticionCerrar();
                if($.isNumeric(ajaxResponse)){
                    $.growl.notice({title: 'Éxito', message: 'Se actualizó con exito' , size: 'large'});
                }else{
                    $.growl.error({title: 'Éxito', message: ajaxResponse, size: 'large'});
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

//<editor-fold defaultstate="collapsed" desc="function fPaginaActual(). Clic en + para mas detalles.">
/**
 * 
 * @returns {undefined}
 */
function fPaginaActual() {
    fProcesandoPeticion();
    f_interesFactorLeer();
    f_empresaConvenio();
}
;
//</editor-fold>o