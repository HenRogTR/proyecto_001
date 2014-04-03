/* 
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */


$(document).ready(function() {

    var checkboxes_sel = "input.checkall:checkbox:enabled";
    /**
     * Watches checkboxes in a form to set the checkall box accordingly
     */
    $(checkboxes_sel).change(function() {
        var $form = $(this.form);
        // total number of checkboxes in current form
        var total_boxes = $form.find(checkboxes_sel).length;
        // number of checkboxes checked in current form
        var checked_boxes = $form.find(checkboxes_sel + ":checked").length;
        var $checkall = $form.find("input.checkall_box");
        if (total_boxes == checked_boxes) {
            $checkall.prop({checked: true, indeterminate: false});
        }
        else if (checked_boxes > 0) {
            $checkall.prop({checked: true, indeterminate: true});
        }
        else {
            $checkall.prop({checked: false, indeterminate: false});
        }
    });

    $('input.checkall_box').change(function() {
        var is_checked = $(this).is(':checked');
        $(this.form).find(checkboxes_sel).prop('checked', is_checked);
    });

    $('#bGuardar').click(function(e) {
        fBotonesClicDeshabilitar();
        fPrivilegiosGuardar();
        e.preventDefault();
    });

});

$(function() {

});

function fPaginaActual() {
    $('#dProcesandoPeticion').dialog('open');
    fUsuarioLeer(parseInt($('#codUsuario').val(), 10), '');
}
;

function fUsuarioLeer(codUsuario, parametro) {
    var data = {codUsuario: codUsuario, parametro: parametro};
    try {
        $.ajax({
            type: "post",
            url: "ajax/usuario.jsp",
            data: data,
            error: function(XMLHttpRequest, textStatus, errorThrown) {
                $('#lServidorError').text(errorThrown + '(usuario.jsp)');
                $('#dServidorError').dialog('open');
            },
            success: function(ajaxResponse, textStatus) {
                var arrayUsuario = procesarRespuesta(ajaxResponse);
                if (arrayUsuario.length == 0) {
                    fAlerta('Usuario no encontrado.');
                } else {
                    var itemUsuario = arrayUsuario[0];
                    $('.vaciar').empty();
                    $('#codUsuario').val(itemUsuario.codUsuario);
                    $('#lCodUsuario').append(itemUsuario.codUsuario);
                    $('#lEstado').append(itemUsuario.estado ? 'HABILITADO' : 'DESHABILITADO');
                    $('#sUsuario').text(itemUsuario.usuario);
                    $('#lPersonal').append(itemUsuario.personal);
                    $('#p1').prop('checked', itemUsuario.permiso1);
                    $('#p2').prop('checked', itemUsuario.permiso2);
                    $('#p3').prop('checked', itemUsuario.permiso3);
                    $('#p4').prop('checked', itemUsuario.permiso4);
                    $('#p5').prop('checked', itemUsuario.permiso5);
                    $('#p6').prop('checked', itemUsuario.permiso6);
                    $('#p7').prop('checked', itemUsuario.permiso7);
                    $('#p8').prop('checked', itemUsuario.permiso8);
                    $('#p9').prop('checked', itemUsuario.permiso9);
                    $('#p10').prop('checked', itemUsuario.permiso10);
                    $('#p11').prop('checked', itemUsuario.permiso11);
                    $('#p12').prop('checked', itemUsuario.permiso12);
                    $('#p13').prop('checked', itemUsuario.permiso13);
                    $('#p14').prop('checked', itemUsuario.permiso14);
                    $('#p15').prop('checked', itemUsuario.permiso15);
                    $('#p16').prop('checked', itemUsuario.permiso16);
                    $('#p17').prop('checked', itemUsuario.permiso17);
                    $('#p18').prop('checked', itemUsuario.permiso18);
                    $('#p19').prop('checked', itemUsuario.permiso19);
                    $('#p20').prop('checked', itemUsuario.permiso20);
                    $('#p21').prop('checked', itemUsuario.permiso21);
                    $('#p22').prop('checked', itemUsuario.permiso22);
                    $('#p23').prop('checked', itemUsuario.permiso23);
                    $('#p24').prop('checked', itemUsuario.permiso24);
                    $('#p25').prop('checked', itemUsuario.permiso25);
                    $('#p26').prop('checked', itemUsuario.permiso26);
                    $('#p27').prop('checked', itemUsuario.permiso27);
                    $('#p28').prop('checked', itemUsuario.permiso28);
                    $('#p29').prop('checked', itemUsuario.permiso29);
                    $('#p30').prop('checked', itemUsuario.permiso30);
                    $('#p31').prop('checked', itemUsuario.permiso31);
                    $('#p32').prop('checked', itemUsuario.permiso32);
                    $('#p33').prop('checked', itemUsuario.permiso33);
                    $('#p34').prop('checked', itemUsuario.permiso34);
                    $('#p35').prop('checked', itemUsuario.permiso35);
                    $('#p36').prop('checked', itemUsuario.permiso36);
                    $('#p37').prop('checked', itemUsuario.permiso37);
                    $('#p38').prop('checked', itemUsuario.permiso38);
                    $('#p39').prop('checked', itemUsuario.permiso39);
                    $('#p40').prop('checked', itemUsuario.permiso40);
                    $('#p41').prop('checked', itemUsuario.permiso41);
                    $('#p42').prop('checked', itemUsuario.permiso42);
                    $('#p43').prop('checked', itemUsuario.permiso43);
                    $('#p44').prop('checked', itemUsuario.permiso44);
                    $('#p45').prop('checked', itemUsuario.permiso45);
                    $('#p46').prop('checked', itemUsuario.permiso46);
                    $('#p47').prop('checked', itemUsuario.permiso47);
                    $('#p48').prop('checked', itemUsuario.permiso48);
                    $('#p49').prop('checked', itemUsuario.permiso49);
                    $('#p50').prop('checked', itemUsuario.permiso50);
                    $('#p51').prop('checked', itemUsuario.permiso51);
                    $('#p52').prop('checked', itemUsuario.permiso52);
                    $('#p53').prop('checked', itemUsuario.permiso53);
                    $('#p54').prop('checked', itemUsuario.permiso54);
                    $('#p55').prop('checked', itemUsuario.permiso55);
                    $('#p56').prop('checked', itemUsuario.permiso56);
                    $('#p57').prop('checked', itemUsuario.permiso57);
                    $('#p58').prop('checked', itemUsuario.permiso58);
                    $('#p59').prop('checked', itemUsuario.permiso59);
                    $('#p60').prop('checked', itemUsuario.permiso60);
                }
                $('#dProcesandoPeticion').dialog('close');
            },
            statusCode: {
                404: function() {
                    $('#lServidorError').text('Página no encontrada(cliente.jsp).');
                    $('#dServidorError').dialog('open');
                }
            }
        });
    } catch (ex) {
        $('#lServidorError').text(ex);
        $('#dServidorError').dialog('open');
    }
}
;

function fPrivilegiosGuardar() {
    var $frm = $('#frm_usuarioPermiso');
    var data = $frm.serialize();
    var url = $frm.attr('action');
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
                fBotonesClicHabilitar();
            },
            success: function(ajaxResponse, textStatus) {
                if ($.isNumeric(ajaxResponse)) {
                    fUsuarioLeer(ajaxResponse, '');
                } else {
                    fAlerta(ajaxResponse);
                }
                fBotonesClicHabilitar();
            },
            statusCode: {
                404: function() {
                    $('#lServidorError').text('Página no encontrada().');
                    $('#dServidorError').dialog('open');
                    fBotonesClicHabilitar();
                }
            }
        });
    }
    catch (ex) {
        $('#lServidorError').text(ex);
        $('#dServidorError').dialog('open');
        fBotonesClicHabilitar();
    }
}
;

function fBotonesClicDeshabilitar() {
    $('.botonClic').addClass('disabled').prop('disabled', true);
}
;

function fBotonesClicHabilitar() {
    $('.botonClic').removeClass('disabled').prop('disabled', false);
}
;