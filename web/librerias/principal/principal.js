/* 
 * To change this template, choose Tools | Templates
 * and open the template in the editor.
 */

$(document).ready(function() {

    $('.mayuscula').blur(function() {
        this.value = $.trim(this.value.toUpperCase());
    });

    $('#equipoTrabajo').click(function(event) {
        $('#dEquipoTrabajo').dialog('open');
        event.preventDefault();
    });
    $('#novedades').click(function(event) {
        $('#dNovedades').dialog('open');
        event.preventDefault();
    });

    $('#bAccesoAbrir').click(function(event) {
        $('#dIniciarSesion').dialog('open');
        event.preventDefault();
    });

    $('#bCerrarSistema').click(function(event) {
        event.preventDefault();
    });

    $('#bLimpiarLogin').click(function(event) {
        $('.login').val('');
        event.preventDefault();
    });

    $('#usuario, #contrasenia').keyup(function(event) {
        var key = event.charCode ? event.charCode : event.keyCode ? event.keyCode : 0;
        if (key == 13) {
            fLoginBotonesDeshabilitar();
            fUsuarioIngresar();
            event.preventDefault();
        }
    });

    $('#bIngresar').click(function(event) {
        fLoginBotonesDeshabilitar();
        fUsuarioIngresar();
        event.preventDefault();
    });

    $('#aUsuarioCerrarSesion').click(function(event) {
        $('#dUsuarioCerrarSesionConfirmar').dialog('open');
        event.preventDefault();
    });

    fComprobarSesion(true);
    // comprobar sesion activa
    var tiempo = 10000; //1000=1s ; 10000=10s
    $.timer(tiempo, function() {
        fComprobarSesion(false);
    });


    $.ui.autocomplete.prototype._renderItem = function(ul, item) {
        var term = this.term.split(' ').join('|');
        var re = new RegExp("(" + term + ")", "gi");
        var t = item.label.replace(re, "<strong>$1</strong>");
        return $("<li></li>")
                .data("item.autocomplete", item)
                .append("<a>" + t + "</a>")
                .appendTo(ul);
    };
});

$(function() {

    $("#ulMenu").menu();

    $('.fecha_datepicker').datepicker({
        showAnim: 'drop',
        changeMonth: true,
        changeYear: true,
        numberOfMonths: 2
    });

//<editor-fold defaultstate="collapsed" desc="dialog's. Clic en el signo + de la izquierda para mas detalles.">
    $('#dEquipoTrabajo').dialog({
        autoOpen: false,
        modal: true,
        resizable: true,
        height: 180,
        width: 600,
        buttons: {
            Aceptar: function() {
                $(this).dialog("close");
            }
        },
        close: function() {
            $(this).dialog("close");
        }
    });
    $('#dNovedades').dialog({
        autoOpen: false,
        modal: true,
        resizable: true,
        height: 500,
        width: 600,
        buttons: {
            Aceptar: function() {
                $(this).dialog("close");
            }
        },
        close: function() {
            $(this).dialog("close");
        }
    });

    $('#dIniciarSesion').dialog({
        autoOpen: false,
        modal: true,
        resizable: false,
        height: 230,
        width: 400,
        close: function() {
            $(this).dialog("close");
        }
    });

    $('#dUsuarioCerrarSesionConfirmar').dialog({
        autoOpen: false,
        modal: true,
        resizable: false,
        height: 200,
        width: 300,
        buttons: {
            Si: function() {
                fUsuarioCerrarSesion();
                $(this).dialog("close");
            },
            No: function() {
                $(this).dialog("close");
            }
        },
        close: function() {
            $(this).dialog("close");
        }
    });

    $('#dServidorError').dialog({
        autoOpen: false,
        modal: true,
        resizable: true,
        height: 250,
        width: 600,
        buttons: {
            Aceptar: function() {
                $(this).dialog('close');
            }
        },
        close: function() {
            $(this).dialog('close');
        }
    });

    $("#dMensajeAlerta").dialog({
        autoOpen: false,
        modal: true,
        resizable: true,
        height: 250,
        width: 400,
        buttons: {
            Aceptar: function() {
                $(this).dialog("close");
            }
        },
        close: function() {
            $(this).dialog("close");
        }
    });

    $("#dAlerta").dialog({
        autoOpen: false,
        modal: true,
        resizable: true,
        height: 300,
        width: 500,
        buttons: {
            Aceptar: function() {
                $(this).dialog("close");
            }
        },
        close: function() {
            $(this).dialog("close");
        }
    });

    $("#dProcesandoPeticion").dialog({
        autoOpen: false,
        modal: true,
        resizable: true,
        height: 250,
        width: 400,
        close: function() {
            $(this).dialog("close");
        }
    });

    $('#dLibre').dialog({
        autoOpen: false,
        modal: true,
        resizable: true,
        height: 155,
        width: 150,
        close: function() {
            fDLibreReiniciar();
            $(this).dialog('close');
        },
        buttons: {
            Aceptar: function() {
                $(this).dialog('close');
            }
        }
    });
//</editor-fold>

});

//<editor-fold defaultstate="collapsed" desc="fComprobarSesion(valor). Clic en el signo + de la izquierda para mas detalles.">
function fComprobarSesion(valor) {
    var data = 'accionUsuario=sesionComprobar';
    try {
        $.ajax({
            type: "post",
            url: "../sUsuario",
            data: data,
            error: function(XMLHttpRequest, textStatus, errorThrown) {
                $('#dIniciarSesion').dialog('open');
                $('#lServidorError').text(errorThrown + '(Sesión comprobar)');
                $('#dServidorError').dialog('open');
            },
            success: function(ajaxResponse, textStatus) {
                if (ajaxResponse == '1') {
                    //sin hay sesion iniciada
                    if (valor) {
                        fPaginaActual();
                    }
                    fUsuarioPermiso(function() {
                        if ($('input[name=paginaActualPermiso]').val() == '1') {
                            $('#rightSub1').removeClass('ocultar');
                            $('#rightSub2').addClass('ocultar');
                            $('#dMensajeAlerta').dialog('close');
                        } else {
                            $('#rightSub1').addClass('ocultar');
                            $('#rightSub2').removeClass('ocultar');
                            $('#dMensajeAlertaDiv').empty().append('No tiene permiso ' +
                                    'para acceder a <b>' + $('input[name=paginaActualPermiso]').attr('title') + '</b>, si en caso ya le fué asignado ' +
                                    'cierre y vuelva a iniciar sesíon, caso contrario ' +
                                    'solicite el permiso al Administrador del sistema.');
                            $('#dMensajeAlerta').dialog('open');
                        }
                    });

                    $('.acceso').addClass('ocultar');
                    $('#menu').removeClass('ocultar');
                    $('#dIniciarSesion').dialog('close');
                    $('#dServidorError').dialog('close');
                } else {
                    $('.acceso').removeClass('ocultar');
                    $('#menu').addClass('ocultar');
                    $('#dIniciarSesion').dialog('open');
                    $('#rightSub1').addClass('ocultar');
                    $('#rightSub2').removeClass('ocultar');
                }
            },
            statusCode: {
                404: function() {
                    $('#dIniciarSesion').dialog('open');
                    $('#lServidorError').text('Página no encontrada.');
                    $('#dServidorError').dialog('open');
                }
            }
        });
    }
    catch (ex) {
        $('#dIniciarSesion').dialog('open');
        $('#lServidorError').text(ex);
        $('#dServidorError').dialog('open');
    }
}
;
//</editor-fold>

//<editor-fold defaultstate="collapsed" desc="fUsuarioPermiso(callback). Clic en el signo + de la izquierda para mas detalles.">
function fUsuarioPermiso(callback) {
    var data = 'accionUsuario=permisos';
    try {
        $.ajax({
            type: "post",
            url: "../sUsuario",
            data: data,
            error: function(XMLHttpRequest, textStatus, errorThrown) {
                $('#lServidorError').text(errorThrown + '(Usuario permisos)');
                $('#dServidorError').dialog('open');
            },
            success: function(ajaxResponse, textStatus) {
                var usuarioArray = procesarRespuesta(ajaxResponse);
                for (var idx = 0; idx < usuarioArray.length; idx++) {
                    var usuarioItem = usuarioArray[idx];
                    $('#lUsuarioMenu').text(usuarioItem.usuario);

                    $('#permisoPaginaP1').val(usuarioItem.permiso1 ? '1' : '0');
                    $('#permisoPaginaP2').val(usuarioItem.permiso2 ? '1' : '0');
                    $('#permisoPaginaP3').val(usuarioItem.permiso3 ? '1' : '0');
                    $('#permisoPaginaP4').val(usuarioItem.permiso4 ? '1' : '0');
                    $('#permisoPaginaP5').val(usuarioItem.permiso5 ? '1' : '0');
                    $('#permisoPaginaP6').val(usuarioItem.permiso6 ? '1' : '0');
                    $('#permisoPaginaP7').val(usuarioItem.permiso7 ? '1' : '0');
                    $('#permisoPaginaP8').val(usuarioItem.permiso8 ? '1' : '0');
                    $('#permisoPaginaP9').val(usuarioItem.permiso9 ? '1' : '0');
                    $('#permisoPaginaP10').val(usuarioItem.permiso10 ? '1' : '0');
                    $('#permisoPaginaP11').val(usuarioItem.permiso11 ? '1' : '0');
                    $('#permisoPaginaP12').val(usuarioItem.permiso12 ? '1' : '0');
                    $('#permisoPaginaP13').val(usuarioItem.permiso13 ? '1' : '0');
                    $('#permisoPaginaP14').val(usuarioItem.permiso14 ? '1' : '0');
                    $('#permisoPaginaP15').val(usuarioItem.permiso15 ? '1' : '0');
                    $('#permisoPaginaP16').val(usuarioItem.permiso16 ? '1' : '0');
                    $('#permisoPaginaP17').val(usuarioItem.permiso17 ? '1' : '0');
                    $('#permisoPaginaP18').val(usuarioItem.permiso18 ? '1' : '0');
                    $('#permisoPaginaP19').val(usuarioItem.permiso19 ? '1' : '0');
                    $('#permisoPaginaP20').val(usuarioItem.permiso20 ? '1' : '0');
                    $('#permisoPaginaP21').val(usuarioItem.permiso21 ? '1' : '0');
                    $('#permisoPaginaP22').val(usuarioItem.permiso22 ? '1' : '0');
                    $('#permisoPaginaP23').val(usuarioItem.permiso23 ? '1' : '0');
                    $('#permisoPaginaP24').val(usuarioItem.permiso24 ? '1' : '0');
                    $('#permisoPaginaP25').val(usuarioItem.permiso25 ? '1' : '0');
                    $('#permisoPaginaP26').val(usuarioItem.permiso26 ? '1' : '0');
                    $('#permisoPaginaP27').val(usuarioItem.permiso27 ? '1' : '0');
                    $('#permisoPaginaP28').val(usuarioItem.permiso28 ? '1' : '0');
                    $('#permisoPaginaP29').val(usuarioItem.permiso29 ? '1' : '0');
                    $('#permisoPaginaP30').val(usuarioItem.permiso30 ? '1' : '0');
                    $('#permisoPaginaP31').val(usuarioItem.permiso31 ? '1' : '0');
                    $('#permisoPaginaP32').val(usuarioItem.permiso32 ? '1' : '0');
                    $('#permisoPaginaP33').val(usuarioItem.permiso33 ? '1' : '0');
                    $('#permisoPaginaP34').val(usuarioItem.permiso34 ? '1' : '0');
                    $('#permisoPaginaP35').val(usuarioItem.permiso35 ? '1' : '0');
                    $('#permisoPaginaP36').val(usuarioItem.permiso36 ? '1' : '0');
                    $('#permisoPaginaP37').val(usuarioItem.permiso37 ? '1' : '0');
                    $('#permisoPaginaP38').val(usuarioItem.permiso38 ? '1' : '0');
                    $('#permisoPaginaP39').val(usuarioItem.permiso39 ? '1' : '0');
                    $('#permisoPaginaP40').val(usuarioItem.permiso40 ? '1' : '0');
                    $('#permisoPaginaP41').val(usuarioItem.permiso41 ? '1' : '0');
                    $('#permisoPaginaP42').val(usuarioItem.permiso42 ? '1' : '0');
                    $('#permisoPaginaP43').val(usuarioItem.permiso43 ? '1' : '0');
                    $('#permisoPaginaP44').val(usuarioItem.permiso44 ? '1' : '0');
                    $('#permisoPaginaP45').val(usuarioItem.permiso45 ? '1' : '0');
                    $('#permisoPaginaP46').val(usuarioItem.permiso46 ? '1' : '0');
                    $('#permisoPaginaP47').val(usuarioItem.permiso47 ? '1' : '0');
                    $('#permisoPaginaP48').val(usuarioItem.permiso48 ? '1' : '0');
                    $('#permisoPaginaP49').val(usuarioItem.permiso49 ? '1' : '0');
                    $('#permisoPaginaP50').val(usuarioItem.permiso50 ? '1' : '0');
                    $('#permisoPaginaP51').val(usuarioItem.permiso51 ? '1' : '0');
                    $('#permisoPaginaP52').val(usuarioItem.permiso52 ? '1' : '0');
                    $('#permisoPaginaP53').val(usuarioItem.permiso53 ? '1' : '0');
                    $('#permisoPaginaP54').val(usuarioItem.permiso54 ? '1' : '0');
                    $('#permisoPaginaP55').val(usuarioItem.permiso55 ? '1' : '0');
                    $('#permisoPaginaP56').val(usuarioItem.permiso56 ? '1' : '0');
                    $('#permisoPaginaP57').val(usuarioItem.permiso57 ? '1' : '0');
                    $('#permisoPaginaP58').val(usuarioItem.permiso58 ? '1' : '0');
                    $('#permisoPaginaP59').val(usuarioItem.permiso59 ? '1' : '0');
                    $('#permisoPaginaP60').val(usuarioItem.permiso60 ? '1' : '0');
                    usuarioItem.permiso1 ? $("#permiso1").removeClass("ui-state-disabled") : $("#permiso1").addClass("ui-state-disabled");
                    usuarioItem.permiso2 ? $("#permiso2").removeClass("ui-state-disabled") : $("#permiso2").addClass("ui-state-disabled");
                    usuarioItem.permiso3 ? $("#permiso3").removeClass("ui-state-disabled") : $("#permiso3").addClass("ui-state-disabled");
                    usuarioItem.permiso4 ? $("#permiso4").removeClass("ui-state-disabled") : $("#permiso4").addClass("ui-state-disabled");
                    usuarioItem.permiso5 ? $("#permiso5").removeClass("ui-state-disabled") : $("#permiso5").addClass("ui-state-disabled");
                    usuarioItem.permiso6 ? $("#permiso6").removeClass("ui-state-disabled") : $("#permiso6").addClass("ui-state-disabled");
                    usuarioItem.permiso7 ? $("#permiso7").removeClass("ui-state-disabled") : $("#permiso7").addClass("ui-state-disabled");
                    usuarioItem.permiso8 ? $("#permiso8").removeClass("ui-state-disabled") : $("#permiso8").addClass("ui-state-disabled");
                    usuarioItem.permiso9 ? $("#permiso9").removeClass("ui-state-disabled") : $("#permiso9").addClass("ui-state-disabled");
                    usuarioItem.permiso10 ? $("#permiso10").removeClass("ui-state-disabled") : $("#permiso10").addClass("ui-state-disabled");
                    usuarioItem.permiso11 ? $("#permiso11").removeClass("ui-state-disabled") : $("#permiso11").addClass("ui-state-disabled");
                    usuarioItem.permiso12 ? $("#permiso12").removeClass("ui-state-disabled") : $("#permiso12").addClass("ui-state-disabled");
                    usuarioItem.permiso13 ? $("#permiso13").removeClass("ui-state-disabled") : $("#permiso13").addClass("ui-state-disabled");
                    usuarioItem.permiso14 ? $("#permiso14").removeClass("ui-state-disabled") : $("#permiso14").addClass("ui-state-disabled");
                    usuarioItem.permiso15 ? $("#permiso15").removeClass("ui-state-disabled") : $("#permiso15").addClass("ui-state-disabled");
                    usuarioItem.permiso16 ? $("#permiso16").removeClass("ui-state-disabled") : $("#permiso16").addClass("ui-state-disabled");
                    usuarioItem.permiso17 ? $("#permiso17").removeClass("ui-state-disabled") : $("#permiso17").addClass("ui-state-disabled");
                    usuarioItem.permiso18 ? $("#permiso18").removeClass("ui-state-disabled") : $("#permiso18").addClass("ui-state-disabled");
                    usuarioItem.permiso19 ? $("#permiso19").removeClass("ui-state-disabled") : $("#permiso19").addClass("ui-state-disabled");
                    usuarioItem.permiso20 ? $("#permiso20").removeClass("ui-state-disabled") : $("#permiso20").addClass("ui-state-disabled");
                    usuarioItem.permiso21 ? $("#permiso21").removeClass("ui-state-disabled") : $("#permiso21").addClass("ui-state-disabled");
                    usuarioItem.permiso22 ? $("#permiso22").removeClass("ui-state-disabled") : $("#permiso22").addClass("ui-state-disabled");
                    usuarioItem.permiso23 ? $("#permiso23").removeClass("ui-state-disabled") : $("#permiso23").addClass("ui-state-disabled");
                    usuarioItem.permiso24 ? $("#permiso24").removeClass("ui-state-disabled") : $("#permiso24").addClass("ui-state-disabled");
                    usuarioItem.permiso25 ? $("#permiso25").removeClass("ui-state-disabled") : $("#permiso25").addClass("ui-state-disabled");
                    usuarioItem.permiso26 ? $("#permiso26").removeClass("ui-state-disabled") : $("#permiso26").addClass("ui-state-disabled");
                    usuarioItem.permiso27 ? $("#permiso27").removeClass("ui-state-disabled") : $("#permiso27").addClass("ui-state-disabled");
                    usuarioItem.permiso28 ? $("#permiso28").removeClass("ui-state-disabled") : $("#permiso28").addClass("ui-state-disabled");
                    usuarioItem.permiso29 ? $("#permiso29").removeClass("ui-state-disabled") : $("#permiso29").addClass("ui-state-disabled");
                    usuarioItem.permiso30 ? $("#permiso30").removeClass("ui-state-disabled") : $("#permiso30").addClass("ui-state-disabled");
                    usuarioItem.permiso31 ? $("#permiso31").removeClass("ui-state-disabled") : $("#permiso31").addClass("ui-state-disabled");
                    usuarioItem.permiso32 ? $("#permiso32").removeClass("ui-state-disabled") : $("#permiso32").addClass("ui-state-disabled");
                    usuarioItem.permiso33 ? $("#permiso33").removeClass("ui-state-disabled") : $("#permiso33").addClass("ui-state-disabled");
                    usuarioItem.permiso34 ? $("#permiso34").removeClass("ui-state-disabled") : $("#permiso34").addClass("ui-state-disabled");
                    usuarioItem.permiso35 ? $("#permiso35").removeClass("ui-state-disabled") : $("#permiso35").addClass("ui-state-disabled");
                    usuarioItem.permiso36 ? $("#permiso36").removeClass("ui-state-disabled") : $("#permiso36").addClass("ui-state-disabled");
                    usuarioItem.permiso37 ? $("#permiso37").removeClass("ui-state-disabled") : $("#permiso37").addClass("ui-state-disabled");
                    usuarioItem.permiso38 ? $("#permiso38").removeClass("ui-state-disabled") : $("#permiso38").addClass("ui-state-disabled");
                    usuarioItem.permiso39 ? $("#permiso39").removeClass("ui-state-disabled") : $("#permiso39").addClass("ui-state-disabled");
                    usuarioItem.permiso40 ? $("#permiso40").removeClass("ui-state-disabled") : $("#permiso40").addClass("ui-state-disabled");
                    usuarioItem.permiso41 ? $("#permiso41").removeClass("ui-state-disabled") : $("#permiso41").addClass("ui-state-disabled");
                    usuarioItem.permiso42 ? $("#permiso42").removeClass("ui-state-disabled") : $("#permiso42").addClass("ui-state-disabled");
                    usuarioItem.permiso43 ? $("#permiso43").removeClass("ui-state-disabled") : $("#permiso43").addClass("ui-state-disabled");
                    usuarioItem.permiso44 ? $("#permiso44").removeClass("ui-state-disabled") : $("#permiso44").addClass("ui-state-disabled");
                    usuarioItem.permiso45 ? $("#permiso45").removeClass("ui-state-disabled") : $("#permiso45").addClass("ui-state-disabled");
                    usuarioItem.permiso46 ? $("#permiso46").removeClass("ui-state-disabled") : $("#permiso46").addClass("ui-state-disabled");
                    usuarioItem.permiso47 ? $("#permiso47").removeClass("ui-state-disabled") : $("#permiso47").addClass("ui-state-disabled");
                    usuarioItem.permiso48 ? $("#permiso48").removeClass("ui-state-disabled") : $("#permiso48").addClass("ui-state-disabled");
                    usuarioItem.permiso49 ? $("#permiso49").removeClass("ui-state-disabled") : $("#permiso49").addClass("ui-state-disabled");
                    usuarioItem.permiso50 ? $("#permiso50").removeClass("ui-state-disabled") : $("#permiso50").addClass("ui-state-disabled");
                    usuarioItem.permiso51 ? $("#permiso51").removeClass("ui-state-disabled") : $("#permiso51").addClass("ui-state-disabled");
                    usuarioItem.permiso52 ? $("#permiso52").removeClass("ui-state-disabled") : $("#permiso52").addClass("ui-state-disabled");
                    usuarioItem.permiso53 ? $("#permiso53").removeClass("ui-state-disabled") : $("#permiso53").addClass("ui-state-disabled");
                    usuarioItem.permiso54 ? $("#permiso54").removeClass("ui-state-disabled") : $("#permiso54").addClass("ui-state-disabled");
                    usuarioItem.permiso55 ? $("#permiso55").removeClass("ui-state-disabled") : $("#permiso55").addClass("ui-state-disabled");
                    usuarioItem.permiso56 ? $("#permiso56").removeClass("ui-state-disabled") : $("#permiso56").addClass("ui-state-disabled");
                    usuarioItem.permiso57 ? $("#permiso57").removeClass("ui-state-disabled") : $("#permiso57").addClass("ui-state-disabled");
                    usuarioItem.permiso58 ? $("#permiso58").removeClass("ui-state-disabled") : $("#permiso58").addClass("ui-state-disabled");
                    usuarioItem.permiso59 ? $("#permiso59").removeClass("ui-state-disabled") : $("#permiso59").addClass("ui-state-disabled");
                    usuarioItem.permiso60 ? $("#permiso60").removeClass("ui-state-disabled") : $("#permiso60").addClass("ui-state-disabled");
                }
            },
            statusCode: {
                404: function() {
                    $('#dIniciarSesion').dialog('open');
                    $('#lServidorError').text('Página no encontrada.');
                    $('#dServidorError').dialog('open');
                }
            },
            complete: function() {
                callback();
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

//<editor-fold defaultstate="collapsed" desc="fUsuarioIngresar(). Clic en el signo + de la izquierda para mas detalles.">
function fUsuarioIngresar() {
    var usuario = $('#usuario').val();
    var contrasenia = $('#contrasenia').val();
    if (!usuario.match(/^[a-zA-Z0-9._-]{4,16}$/)) {
        $('#lUsuarioErrorInicio').text('*Usuario entre 4-16 caracteres alfanuméricos.');
        $('#usuario').val($.trim($('#usuario').val())).focus();
        fLoginBotonesHabilitar();
        return;
    }
    if (!contrasenia.match(/^[a-zA-Z0-9._-]{4,16}$/)) {
        $('#lUsuarioErrorInicio').text('*Contraseña entre 4-16 caracteres alfanuméricos.');
        $('#contrasenia').val($.trim($('#contrasenia').val())).focus();
        fLoginBotonesHabilitar();
        return;
    }
    var data = $('#formUsuarioIniciar').serialize();
    try {
        $.ajax({
            type: 'post',
            url: '../sUsuario',
            data: data,
            beforeSend: function() {

            },
            error: function(XMLHttpRequest, textStatus, errorThrown) {
                $('#lServidorError').text(errorThrown + '(Página-usuario ingresar)');
                $('#dServidorError').dialog('open');
            },
            success: function(ajaxResponse, textStatus) {
                if (ajaxResponse != '1') {
                    fLoginBotonesHabilitar();
                    $('#contrasenia').val('');
                    $('#lUsuarioErrorInicio').text(ajaxResponse);
                    $('#usuario').focus();
                } else {
                    fUsuarioPermiso(function() {
                        if ($('input[name=paginaActualPermiso]').val() == '1') {
                            $('#rightSub1').removeClass('ocultar');
                            $('#rightSub2').addClass('ocultar');
                            $('#dMensajeAlerta').dialog('close');
                        } else {
                            $('#rightSub1').addClass('ocultar');
                            $('#rightSub2').removeClass('ocultar');
                            $('#dMensajeAlertaDiv').empty().append('No tiene permiso ' +
                                    'para acceder a <b>' + $('input[name=paginaActualPermiso]').attr('title') + '</b>, si en caso ya le fué asignado ' +
                                    'cierre y vuelva a iniciar sesíon, caso contrario ' +
                                    'solicite el permiso al Administrador del sistema.');
                            $('#dMensajeAlerta').dialog('open');
                        }
                    });
                    fPaginaActual();
                    $('#rightSub1').removeClass('ocultar');
                    $('#rightSub2').addClass('ocultar');
                    $('#dIniciarSesion').dialog('close');
                    $('.acceso').addClass('ocultar');
                    $('#menu').removeClass('ocultar');
                    $('.login').val('');
                    $('#dNovedades').dialog('open');
                    fLoginBotonesHabilitar();
                }
            },
            statusCode: {
                404: function() {
                    $('#dIniciarSesion').dialog('open');
                    $('#lServidorError').text('Página no encontrada.');
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
//</editor-fold>

//<editor-fold defaultstate="collapsed" desc="function fUsuarioCerrarSesion(). Clic en el signo + de la izquierda para mas detalles.">
function fUsuarioCerrarSesion() {
    var data = 'accionUsuario=sesionCerrar';
    try {
        $.ajax({
            type: 'post',
            url: '../sUsuario',
            data: data,
            beforeSend: function() {

            },
            error: function(XMLHttpRequest, textStatus, errorThrown) {
                $('#lServidorError').text(errorThrown + '(sUsuario-cerrar sesion)');
                $('#dServidorError').dialog('open');
            },
            success: function(ajaxResponse, textStatus) {
                if (ajaxResponse) {
                    fLoginBotonesHabilitar();
                    $('#rightSub1').addClass('ocultar');
                    $('#rightSub2').removeClass('ocultar');
                    $('#menu').addClass('ocultar');
                    $('.acceso').removeClass('ocultar');
                    $('#dIniciarSesion').dialog('open');
                }
                ;
            }
        });
    } catch (ex) {
        $('#lServidorError').text(ex);
        $('#dServidorError').dialog('open');
    }
}
;
//</editor-fold>

//<editor-fold defaultstate="collapsed" desc="procesarRespuesta(ajaxResponse). Clic en el signo + de la izquierda para mas detalles.">
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
//</editor-fold>

//<editor-fold defaultstate="collapsed" desc="fMensajeAlerta(mensaje). Clic en el signo + de la izquierda para mas detalles.">
function fMensajeAlerta(mensaje) {
    $('#dMensajeAlertaDiv').empty().append(mensaje);
    $('#dMensajeAlerta').dialog('open');
}
;
//</editor-fold>

//<editor-fold defaultstate="collapsed" desc="fAlerta(mensaje). Clic en el signo + de la izquierda para mas detalles.">
function fAlerta(mensaje) {
    $('#dAlertaDiv').empty().append('<br>' + mensaje);
    $('#dAlerta').dialog('open');
}
;
//</editor-fold>

//<editor-fold defaultstate="collapsed" desc="fAlertaCerrar(). Clic en el signo + de la izquierda para mas detalles.">
function fAlertaCerrar() {
    $('#dAlerta').dialog('close');
}
;
//</editor-fold>

//<editor-fold defaultstate="collapsed" desc="fProcesandoPeticion(mensaje). Clic en el signo + de la izquierda para mas detalles.">
function fProcesandoPeticion(mensaje) {
    $('#lProcesandoPeticion').text(mensaje);
    $('#dProcesandoPeticion').dialog('open');
}
;
//</editor-fold>

//<editor-fold defaultstate="collapsed" desc="fProcesandoPeticionCerrar(). Clic en el signo + de la izquierda para mas detalles.">
function fProcesandoPeticionCerrar() {
    $('#dProcesandoPeticion').dialog('close');
}
;
//</editor-fold>

//<editor-fold defaultstate="collapsed" desc="fRedireccionarEspera(direccion, tiempo). Clic en el signo + de la izquierda para mas detalles.">
function fRedireccionarEspera(direccion, tiempo) {
    setTimeout(function() {
        $(location).attr('href', direccion);
    }, tiempo);
}
;
//</editor-fold>

//<editor-fold defaultstate="collapsed" desc="fEspererarGif(). Clic en el signo + de la izquierda para mas detalles.">
function  fEspererarGif() {
    return '<div class="esperando"><img alt="not found" src="../imagenes/loading.gif" style="height: 11px;"></div>';
}
;
//</editor-fold>

//<editor-fold defaultstate="collapsed" desc="fDLibreAbrir(). Clic en el signo + de la izquierda para mas detalles.">
function fDLibreAbrir() {
    var $dLibre = $('#dLibre').dialog('open');
}
;
//</editor-fold>

//<editor-fold defaultstate="collapsed" desc="fDLibreCerrar(). Clic en el signo + de la izquierda para mas detalles.">
function fDLibreCerrar() {
    var $dLibre = $('#dLibre').dialog('close');
}
;
//</editor-fold>

//<editor-fold defaultstate="collapsed" desc="fDLibreEditar(alto, ancho, titulo, contenido). Clic en el signo + de la izquierda para mas detalles.">
/**
 * 
 * @param {type} alto
 * @param {type} ancho
 * @param {type} titulo
 * @param {type} contenido
 * @returns {undefined}
 */
function fDLibreEditar(alto, ancho, titulo, contenido) {
    var $dLibreSub = $('#dLibreSub');
    var $dLibre = $('#dLibre');
    $dLibreSub.empty().append(contenido);
    $dLibre.dialog('option', 'height', alto);
    $dLibre.dialog('option', 'width', ancho);
    $dLibre.dialog('option', 'title', titulo);
}
;
//</editor-fold>

//<editor-fold defaultstate="collapsed" desc="fDLibreReiniciar(). Clic en el signo + de la izquierda para mas detalles.">
function fDLibreReiniciar() {
    var $dLibreSub = $('#dLibreSub');
    var $dLibre = $('#dLibre');
    $dLibreSub.empty().append('<img src="../imagenes/loading_1.gif" style="height: 50px;"/>');
    $dLibre.dialog('option', 'height', 155);
    $dLibre.dialog('option', 'width', 150);
    $dLibre.dialog('option', 'title', '');
}
;
//</editor-fold>

function fLoginBotonesDeshabilitar() {
    $('#bCerrarSistema').addClass('disabled').prop('disabled', true);
    $('#bLimpiarLogin').addClass('disabled').prop('disabled', true);
    $('#bIngresar').addClass('disabled').prop('disabled', true);
}
;

function fLoginBotonesHabilitar() {
    $('#bCerrarSistema').removeClass('disabled').prop('disabled', false);
    $('#bLimpiarLogin').removeClass('disabled').prop('disabled', false);
    $('#bIngresar').removeClass('disabled').prop('disabled', false);
}
;
