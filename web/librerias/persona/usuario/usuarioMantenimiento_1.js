/* 
 * To change this template, choose Tools | Templates
 * and open the template in the editor.
 */

$(document).ready(function() {
    $('#accordion,#permisos').accordion({
        heightStyle: 'content'
    });
    $("input:checkbox").click(function(event) {
        if ($('#temporal').val() != 'editar') {
            event.preventDefault();
        }
    });
    $('#bPrimero').click(function(event) {
        fUsuarioLeer(-1, '');
        event.preventDefault();
    });
    $('#bAnterior').click(function(event) {
        fUsuarioLeer(parseInt($('#codUsuario').val(), 10) - 1, 'anterior');
        event.preventDefault();
    });
    $('#bSiguiente').click(function(event) {
        fUsuarioLeer(parseInt($('#codUsuario').val(), 10) + 1, 'siguiente');
        event.preventDefault();
    });
    $('#bUltimo').click(function(event) {
        fUsuarioLeer(0, '');
        event.preventDefault();
    });
    
    $('#bSistemaEditar').click(function(event) {
        $('#dSistemaEditar').dialog('open');
        event.preventDefault();
    });
    $('#bClienteEditar').click(function(event) {
        $('#temporal').val('editar');
        $('#dClienteEditar').dialog('open');
        event.preventDefault();
    });
    $('#bVentaEditar').click(function(event) {
        $('#temporal').val('editar');
        $('#dVentaEditar').dialog('open');
        event.preventDefault();
    });
    $('#bCobranzaEditar').click(function(event) {
        $('#temporal').val('editar');
        $('#dCobranzaEditar').dialog('open');
        event.preventDefault();
    });
    $('#bEmpresaConvenioEditar').click(function(event) {
        $('#temporal').val('editar');
        $('#dEmpresaConvenioEditar').dialog('open');
        event.preventDefault();
    });
    $('#bAlmacenEditar').click(function(event) {
        $('#temporal').val('editar');
        $('#dAlmacenEditar').dialog('open');
        event.preventDefault();
    });
    $('#bArticuloProductoEditar').click(function(event) {
        $('#temporal').val('editar');
        $('#dArticuloProductoEditar').dialog('open');
        event.preventDefault();
    });
    $('#bGaranteEditar').click(function(event) {
        $('#temporal').val('editar');
        $('#dGaranteEditar').dialog('open');
        event.preventDefault();
    });
    $('#bMarcaEditar').click(function(event) {
        $('#temporal').val('editar');
        $('#dMarcaEditar').dialog('open');
        event.preventDefault();
    });
    $('#bFamiliaEditar').click(function(event) {
        $('#temporal').val('editar');
        $('#dFamiliaEditar').dialog('open');
        event.preventDefault();
    });
    $('#bZonaEditar').click(function(event) {
        $('#temporal').val('editar');
        $('#dZonaEditar').dialog('open');
        event.preventDefault();
    });
    $('#bCompraEditar').click(function(event) {
        $('#temporal').val('editar');
        $('#dCompraEditar').dialog('open');
        event.preventDefault();
    });
    $('#bProveedorEditar').click(function(event) {
        $('#temporal').val('editar');
        $('#dProveedorEditar').dialog('open');
        event.preventDefault();
    });
    $('#bPersonalEditar').click(function(event) {
        $('#temporal').val('editar');
        $('#dPersonalEditar').dialog('open');
        event.preventDefault();
    });
    $('#bReporteEditar').click(function(event) {
        $('#temporal').val('editar');
        $('#dReporteEditar').dialog('open');
        event.preventDefault();
    });
    $('#bPropietarioEditar').click(function(event) {
        $('#temporal').val('editar');
        $('#dPropietarioEditar').dialog('open');
        event.preventDefault();
    });
    $('#bUsuarioEditar').click(function(event) {
        $('#temporal').val('editar');
        $('#dUsuarioEditar').dialog('open');
        event.preventDefault();
    });
    $('#bCargoEditar').click(function(event) {
        $('#temporal').val('editar');
        $('#dCargoEditar').dialog('open');
        event.preventDefault();
    });
    $('#bAreaEditar').click(function(event) {
        $('#temporal').val('editar');
        $('#dAreaEditar').dialog('open');
        event.preventDefault();
    });
    
    $('#dSistemaEditar').dialog({
        autoOpen: false,
        modal: true,
        resizable: true,
        height: 400,
        width: 350,
        buttons: {
            Cerrar: function() {
                $(this).dialog('close');
            }
        },
        close: function() {
            $(this).dialog('close');
        }
    });
    $('#dClienteEditar').dialog({
        autoOpen: false,
        modal: true,
        resizable: true,
        height: 400,
        width: 350,
        buttons: {
            Modificar: function() {
                fClienteEditar();
            },
            Cancelar: function() {
                $(this).dialog('close');
            }
        },
        close: function() {
            fUsuarioLeer(parseInt($('#codUsuario').val(), 10), '');
            $('#temporal').val('');
            $(this).dialog('close');
        }
    });
    $('#dVentaEditar').dialog({
        autoOpen: false,
        modal: true,
        resizable: true,
        height: 400,
        width: 350,
        buttons: {
            Modificar: function() {
                fVentaEditar();
            },
            Cerrar: function() {
                $(this).dialog('close');
            }
        },
        close: function() {
            fUsuarioLeer(parseInt($('#codUsuario').val(), 10), '');
            $('#temporal').val('');
            $(this).dialog('close');
        }
    });
    $('#dCobranzaEditar').dialog({
        autoOpen: false,
        modal: true,
        resizable: true,
        height: 400,
        width: 350,
        buttons: {
            Modificar: function() {
                fCobranzaEditar();
            },
            Cerrar: function() {
                $(this).dialog('close');
            }
        },
        close: function() {
            fUsuarioLeer(parseInt($('#codUsuario').val(), 10), '');
            $('#temporal').val('');
            $(this).dialog('close');
        }
    });
    $('#dEmpresaConvenioEditar').dialog({
        autoOpen: false,
        modal: true,
        resizable: true,
        height: 400,
        width: 350,
        buttons: {
            Modificar: function() {
                fEmpresaConvenioEditar();
            },
            Cerrar: function() {
                $(this).dialog('close');
            }
        },
        close: function() {
            fUsuarioLeer(parseInt($('#codUsuario').val(), 10), '');
            $('#temporal').val('');
            $(this).dialog('close');
        }
    });
    $('#dAlmacenEditar').dialog({
        autoOpen: false,
        modal: true,
        resizable: true,
        height: 400,
        width: 350,
        buttons: {
            Modificar: function() {
                fAlmacenEditar();
            },
            Cerrar: function() {
                $(this).dialog('close');
            }
        },
        close: function() {
            fUsuarioLeer(parseInt($('#codUsuario').val(), 10), '');
            $('#temporal').val('');
            $(this).dialog('close');
        }
    });
    $('#dArticuloProductoEditar').dialog({
        autoOpen: false,
        modal: true,
        resizable: true,
        height: 400,
        width: 350,
        buttons: {
            Modificar: function() {
                fArticuloProductoEditar();
            },
            Cerrar: function() {
                $(this).dialog('close');
            }
        },
        close: function() {
            fUsuarioLeer(parseInt($('#codUsuario').val(), 10), '');
            $('#temporal').val('');
            $(this).dialog('close');
        }
    });
    $('#dGaranteEditar').dialog({
        autoOpen: false,
        modal: true,
        resizable: true,
        height: 400,
        width: 350,
        buttons: {
            Modificar: function() {
                fGaranteEditar();
            },
            Cerrar: function() {
                $(this).dialog('close');
            }
        },
        close: function() {
            fUsuarioLeer(parseInt($('#codUsuario').val(), 10), '');
            $('#temporal').val('');
            $(this).dialog('close');
        }
    });
    $('#dMarcaEditar').dialog({
        autoOpen: false,
        modal: true,
        resizable: true,
        height: 400,
        width: 350,
        buttons: {
            Modificar: function() {
                fMarcaEditar();
            },
            Cerrar: function() {
                $(this).dialog('close');
            }
        },
        close: function() {
            fUsuarioLeer(parseInt($('#codUsuario').val(), 10), '');
            $('#temporal').val('');
            $(this).dialog('close');
        }
    });
    $('#dFamiliaEditar').dialog({
        autoOpen: false,
        modal: true,
        resizable: true,
        height: 400,
        width: 350,
        buttons: {
            Modificar: function() {
                fFamiliaEditar();
            },
            Cerrar: function() {
                $(this).dialog('close');
            }
        },
        close: function() {
            fUsuarioLeer(parseInt($('#codUsuario').val(), 10), '');
            $('#temporal').val('');
            $(this).dialog('close');
        }
    });
    $('#dZonaEditar').dialog({
        autoOpen: false,
        modal: true,
        resizable: true,
        height: 400,
        width: 350,
        buttons: {
            Modificar: function() {
                fZonaEditar();
            },
            Cerrar: function() {
                $(this).dialog('close');
            }
        },
        close: function() {
            fUsuarioLeer(parseInt($('#codUsuario').val(), 10), '');
            $('#temporal').val('');
            $(this).dialog('close');
        }
    });
    $('#dCompraEditar').dialog({
        autoOpen: false,
        modal: true,
        resizable: true,
        height: 400,
        width: 350,
        buttons: {
            Modificar: function() {
                fCompraEditar();
            },
            Cerrar: function() {
                $(this).dialog('close');
            }
        },
        close: function() {
            fUsuarioLeer(parseInt($('#codUsuario').val(), 10), '');
            $('#temporal').val('');
            $(this).dialog('close');
        }
    });
    $('#dProveedorEditar').dialog({
        autoOpen: false,
        modal: true,
        resizable: true,
        height: 400,
        width: 350,
        buttons: {
            Modificar: function() {
                fProveedorEditar();
            },
            Cerrar: function() {
                $(this).dialog('close');
            }
        },
        close: function() {
            fUsuarioLeer(parseInt($('#codUsuario').val(), 10), '');
            $('#temporal').val('');
            $(this).dialog('close');
        }
    });
    $('#dPersonalEditar').dialog({
        autoOpen: false,
        modal: true,
        resizable: true,
        height: 400,
        width: 350,
        buttons: {
            Modificar: function() {
                fPersonalEditar();
            },
            Cerrar: function() {
                $(this).dialog('close');
            }
        },
        close: function() {
            fUsuarioLeer(parseInt($('#codUsuario').val(), 10), '');
            $('#temporal').val('');
            $(this).dialog('close');
        }
    });
    $('#dReporteEditar').dialog({
        autoOpen: false,
        modal: true,
        resizable: true,
        height: 400,
        width: 350,
        buttons: {
            Modificar: function() {
                fReporteEditar();
            },
            Cerrar: function() {
                $(this).dialog('close');
            }
        },
        close: function() {
            fUsuarioLeer(parseInt($('#codUsuario').val(), 10), '');
            $('#temporal').val('');
            $(this).dialog('close');
        }
    });
    $('#dPropietarioEditar').dialog({
        autoOpen: false,
        modal: true,
        resizable: true,
        height: 400,
        width: 350,
        buttons: {
            Modificar: function() {
                fPropietarioEditar();
            },
            Cerrar: function() {
                $(this).dialog('close');
            }
        },
        close: function() {
            fUsuarioLeer(parseInt($('#codUsuario').val(), 10), '');
            $('#temporal').val('');
            $(this).dialog('close');
        }
    });
    $('#dUsuarioEditar').dialog({
        autoOpen: false,
        modal: true,
        resizable: true,
        height: 400,
        width: 350,
        buttons: {
            Modificar: function() {
                fUsuarioEditar();
            },
            Cerrar: function() {
                $(this).dialog('close');
            }
        },
        close: function() {
            fUsuarioLeer(parseInt($('#codUsuario').val(), 10), '');
            $('#temporal').val('');
            $(this).dialog('close');
        }
    });
    $('#dCargoEditar').dialog({
        autoOpen: false,
        modal: true,
        resizable: true,
        height: 400,
        width: 350,
        buttons: {
            Modificar: function() {
                fCargoEditar();
            },
            Cerrar: function() {
                $(this).dialog('close');
            }
        },
        close: function() {
            fUsuarioLeer(parseInt($('#codUsuario').val(), 10), '');
            $('#temporal').val('');
            $(this).dialog('close');
        }
    });
    $('#dAreaEditar').dialog({
        autoOpen: false,
        modal: true,
        resizable: true,
        height: 400,
        width: 350,
        buttons: {
            Modificar: function() {
                fAreaEditar();
            },
            Cerrar: function() {
                $(this).dialog('close');
            }
        },
        close: function() {
            fUsuarioLeer(parseInt($('#codUsuario').val(), 10), '');
            $('#temporal').val('');
            $(this).dialog('close');
        }
    });
    
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
                    $('#dMensajeAlertaDiv').empty().append('Usuario no encontrado');
                    $('#dMensajeAlerta').dialog('open');
                } else {
                    var itemUsuario = arrayUsuario[0];
                    $('.vaciar').empty();
                    $('#codUsuario').val(itemUsuario.codUsuario);
                    $('#lCodUsuario').append(itemUsuario.codUsuario);
                    $('#lEstado').append(itemUsuario.estado ? 'HABILITADO' : 'DESHABILITADO');
                    $('#lUsuario').append(itemUsuario.usuario);
                    $('#lPersonal').append(itemUsuario.personal);
                    $('input[name=p1]').prop('checked', itemUsuario.permiso1 ? 'cheked' : '');
                    $('input[name=p2]').prop('checked', itemUsuario.permiso2 ? 'cheked' : '');
                    $('input[name=p3]').prop('checked', itemUsuario.permiso3 ? 'cheked' : '');
                    $('input[name=p4]').prop('checked', itemUsuario.permiso4 ? 'cheked' : '');
                    $('input[name=p5]').prop('checked', itemUsuario.permiso5 ? 'cheked' : '');
                    $('input[name=p6]').prop('checked', itemUsuario.permiso6 ? 'cheked' : '');
                    $('input[name=p7]').prop('checked', itemUsuario.permiso7 ? 'cheked' : '');
                    $('input[name=p8]').prop('checked', itemUsuario.permiso8 ? 'cheked' : '');
                    $('input[name=p9]').prop('checked', itemUsuario.permiso9 ? 'cheked' : '');
                    $('input[name=p10]').prop('checked', itemUsuario.permiso10 ? 'cheked' : '');
                    $('input[name=p11]').prop('checked', itemUsuario.permiso11 ? 'cheked' : '');
                    $('input[name=p12]').prop('checked', itemUsuario.permiso12 ? 'cheked' : '');
                    $('input[name=p13]').prop('checked', itemUsuario.permiso13 ? 'cheked' : '');
                    $('input[name=p14]').prop('checked', itemUsuario.permiso14 ? 'cheked' : '');
                    $('input[name=p15]').prop('checked', itemUsuario.permiso15 ? 'cheked' : '');
                    $('input[name=p16]').prop('checked', itemUsuario.permiso16 ? 'cheked' : '');
                    $('input[name=p17]').prop('checked', itemUsuario.permiso17 ? 'cheked' : '');
                    $('input[name=p18]').prop('checked', itemUsuario.permiso18 ? 'cheked' : '');
                    $('input[name=p19]').prop('checked', itemUsuario.permiso19 ? 'cheked' : '');
                    $('input[name=p20]').prop('checked', itemUsuario.permiso20 ? 'cheked' : '');
                    $('input[name=p21]').prop('checked', itemUsuario.permiso21 ? 'cheked' : '');
                    $('input[name=p22]').prop('checked', itemUsuario.permiso22 ? 'cheked' : '');
                    $('input[name=p23]').prop('checked', itemUsuario.permiso23 ? 'cheked' : '');
                    $('input[name=p24]').prop('checked', itemUsuario.permiso24 ? 'cheked' : '');
                    $('input[name=p25]').prop('checked', itemUsuario.permiso25 ? 'cheked' : '');
                    $('input[name=p26]').prop('checked', itemUsuario.permiso26 ? 'cheked' : '');
                    $('input[name=p27]').prop('checked', itemUsuario.permiso27 ? 'cheked' : '');
                    $('input[name=p28]').prop('checked', itemUsuario.permiso28 ? 'cheked' : '');
                    $('input[name=p29]').prop('checked', itemUsuario.permiso29 ? 'cheked' : '');
                    $('input[name=p30]').prop('checked', itemUsuario.permiso30 ? 'cheked' : '');
                    $('input[name=p31]').prop('checked', itemUsuario.permiso31 ? 'cheked' : '');
                    $('input[name=p32]').prop('checked', itemUsuario.permiso32 ? 'cheked' : '');
                    $('input[name=p33]').prop('checked', itemUsuario.permiso33 ? 'cheked' : '');
                    $('input[name=p34]').prop('checked', itemUsuario.permiso34 ? 'cheked' : '');
                    $('input[name=p35]').prop('checked', itemUsuario.permiso35 ? 'cheked' : '');
                    $('input[name=p36]').prop('checked', itemUsuario.permiso36 ? 'cheked' : '');
                    $('input[name=p37]').prop('checked', itemUsuario.permiso37 ? 'cheked' : '');
                    $('input[name=p38]').prop('checked', itemUsuario.permiso38 ? 'cheked' : '');
                    $('input[name=p39]').prop('checked', itemUsuario.permiso39 ? 'cheked' : '');
                    $('input[name=p40]').prop('checked', itemUsuario.permiso40 ? 'cheked' : '');
                    $('input[name=p41]').prop('checked', itemUsuario.permiso41 ? 'cheked' : '');
                    $('input[name=p42]').prop('checked', itemUsuario.permiso42 ? 'cheked' : '');
                    $('input[name=p43]').prop('checked', itemUsuario.permiso43 ? 'cheked' : '');
                    $('input[name=p44]').prop('checked', itemUsuario.permiso44 ? 'cheked' : '');
                    $('input[name=p45]').prop('checked', itemUsuario.permiso45 ? 'cheked' : '');
                    $('input[name=p46]').prop('checked', itemUsuario.permiso46 ? 'cheked' : '');
                    $('input[name=p47]').prop('checked', itemUsuario.permiso47 ? 'cheked' : '');
                    $('input[name=p48]').prop('checked', itemUsuario.permiso48 ? 'cheked' : '');
                    $('input[name=p49]').prop('checked', itemUsuario.permiso49 ? 'cheked' : '');
                    $('input[name=p50]').prop('checked', itemUsuario.permiso50 ? 'cheked' : '');
                    $('input[name=p51]').prop('checked', itemUsuario.permiso51 ? 'cheked' : '');
                    $('input[name=p52]').prop('checked', itemUsuario.permiso52 ? 'cheked' : '');
                    $('input[name=p53]').prop('checked', itemUsuario.permiso53 ? 'cheked' : '');
                    $('input[name=p54]').prop('checked', itemUsuario.permiso54 ? 'cheked' : '');
                    $('input[name=p55]').prop('checked', itemUsuario.permiso55 ? 'cheked' : '');
                    $('input[name=p56]').prop('checked', itemUsuario.permiso56 ? 'cheked' : '');
                    $('input[name=p57]').prop('checked', itemUsuario.permiso57 ? 'cheked' : '');
                    $('input[name=p58]').prop('checked', itemUsuario.permiso58 ? 'cheked' : '');
                    $('input[name=p59]').prop('checked', itemUsuario.permiso59 ? 'cheked' : '');
                    $('input[name=p60]').prop('checked', itemUsuario.permiso60 ? 'cheked' : '');
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

function fClienteEditar() {
    var data = 'codUsuario=' + $('#codUsuario').val() + '&' + $('#formClienteEditar').serialize();
    var url = "../sUsuario";
    try {
        $.ajax({
            type: "post",
            url: url,
            data: data,
            error: function(XMLHttpRequest, textStatus, errorThrown) {
                $('#lServidorError').text(errorThrown + '()');
                $('#dServidorError').dialog('open');
            },
            success: function(ajaxResponse, textStatus) {
                if (isNaN(ajaxResponse)) {
                    $('#dMensajeAlertaDiv').empty().append(ajaxResponse);
                    $('#dMensajeAlerta').dialog('open');
                } else {
                    fUsuarioLeer(ajaxResponse, '');
                }
                $('#dClienteEditar').dialog('close');
            },
            statusCode: {
                404: function() {
                    $('#lServidorError').text('Página no encontrada.');
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

function fVentaEditar() {
    var data = 'codUsuario=' + $('#codUsuario').val() + '&' + $('#formVentaEditar').serialize();
    var url = "../sUsuario";
    try {
        $.ajax({
            type: "post",
            url: url,
            data: data,
            error: function(XMLHttpRequest, textStatus, errorThrown) {
                $('#lServidorError').text(errorThrown + '()');
                $('#dServidorError').dialog('open');
            },
            success: function(ajaxResponse, textStatus) {
                if (isNaN(ajaxResponse)) {
                    $('#dMensajeAlertaDiv').empty().append(ajaxResponse);
                    $('#dMensajeAlerta').dialog('open');
                } else {
                    fUsuarioLeer(ajaxResponse, '');
                }
                $('#dVentaEditar').dialog('close');
            },
            statusCode: {
                404: function() {
                    $('#lServidorError').text('Página no encontrada.');
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

function fCobranzaEditar() {
    var data = 'codUsuario=' + $('#codUsuario').val() + '&' + $('#formCobranzaEditar').serialize();
    var url = "../sUsuario";
    try {
        $.ajax({
            type: "post",
            url: url,
            data: data,
            error: function(XMLHttpRequest, textStatus, errorThrown) {
                $('#lServidorError').text(errorThrown + '()');
                $('#dServidorError').dialog('open');
            },
            success: function(ajaxResponse, textStatus) {
                if (isNaN(ajaxResponse)) {
                    $('#dMensajeAlertaDiv').empty().append(ajaxResponse);
                    $('#dMensajeAlerta').dialog('open');
                } else {
                    fUsuarioLeer(ajaxResponse, '');
                }
                $('#dCobranzaEditar').dialog('close');
            },
            statusCode: {
                404: function() {
                    $('#lServidorError').text('Página no encontrada.');
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

function fEmpresaConvenioEditar() {
    var data = 'codUsuario=' + $('#codUsuario').val() + '&' + $('#formEmpresaConvenioEditar').serialize();
    var url = "../sUsuario";
    try {
        $.ajax({
            type: "post",
            url: url,
            data: data,
            error: function(XMLHttpRequest, textStatus, errorThrown) {
                $('#lServidorError').text(errorThrown + '()');
                $('#dServidorError').dialog('open');
            },
            success: function(ajaxResponse, textStatus) {
                if (isNaN(ajaxResponse)) {
                    $('#dMensajeAlertaDiv').empty().append(ajaxResponse);
                    $('#dMensajeAlerta').dialog('open');
                } else {
                    fUsuarioLeer(ajaxResponse, '');
                }
                $('#dEmpresaConvenioEditar').dialog('close');
            },
            statusCode: {
                404: function() {
                    $('#lServidorError').text('Página no encontrada.');
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

function fAlmacenEditar() {
    var data = 'codUsuario=' + $('#codUsuario').val() + '&' + $('#formAlmacenEditar').serialize();
    var url = "../sUsuario";
    try {
        $.ajax({
            type: "post",
            url: url,
            data: data,
            error: function(XMLHttpRequest, textStatus, errorThrown) {
                $('#lServidorError').text(errorThrown + '()');
                $('#dServidorError').dialog('open');
            },
            success: function(ajaxResponse, textStatus) {
                if (isNaN(ajaxResponse)) {
                    $('#dMensajeAlertaDiv').empty().append(ajaxResponse);
                    $('#dMensajeAlerta').dialog('open');
                } else {
                    fUsuarioLeer(ajaxResponse, '');
                }
                $('#dAlmacenEditar').dialog('close');
            },
            statusCode: {
                404: function() {
                    $('#lServidorError').text('Página no encontrada.');
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

function fArticuloProductoEditar() {
    var data = 'codUsuario=' + $('#codUsuario').val() + '&' + $('#formArticuloProductoEditar').serialize();
    var url = "../sUsuario";
    try {
        $.ajax({
            type: "post",
            url: url,
            data: data,
            error: function(XMLHttpRequest, textStatus, errorThrown) {
                $('#lServidorError').text(errorThrown + '()');
                $('#dServidorError').dialog('open');
            },
            success: function(ajaxResponse, textStatus) {
                if (isNaN(ajaxResponse)) {
                    $('#dMensajeAlertaDiv').empty().append(ajaxResponse);
                    $('#dMensajeAlerta').dialog('open');
                } else {
                    fUsuarioLeer(ajaxResponse, '');
                }
                $('#dArticuloProductoEditar').dialog('close');
            },
            statusCode: {
                404: function() {
                    $('#lServidorError').text('Página no encontrada.');
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

function fGaranteEditar() {
    var data = 'codUsuario=' + $('#codUsuario').val() + '&' + $('#formGaranteEditar').serialize();
    var url = "../sUsuario";
    try {
        $.ajax({
            type: "post",
            url: url,
            data: data,
            error: function(XMLHttpRequest, textStatus, errorThrown) {
                $('#lServidorError').text(errorThrown + '()');
                $('#dServidorError').dialog('open');
            },
            success: function(ajaxResponse, textStatus) {
                if (isNaN(ajaxResponse)) {
                    $('#dMensajeAlertaDiv').empty().append(ajaxResponse);
                    $('#dMensajeAlerta').dialog('open');
                } else {
                    fUsuarioLeer(ajaxResponse, '');
                }
                $('#dGaranteEditar').dialog('close');
            },
            statusCode: {
                404: function() {
                    $('#lServidorError').text('Página no encontrada.');
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

function fMarcaEditar() {
    var data = 'codUsuario=' + $('#codUsuario').val() + '&' + $('#formMarcaEditar').serialize();
    var url = "../sUsuario";
    try {
        $.ajax({
            type: "post",
            url: url,
            data: data,
            error: function(XMLHttpRequest, textStatus, errorThrown) {
                $('#lServidorError').text(errorThrown + '()');
                $('#dServidorError').dialog('open');
            },
            success: function(ajaxResponse, textStatus) {
                if (isNaN(ajaxResponse)) {
                    $('#dMensajeAlertaDiv').empty().append(ajaxResponse);
                    $('#dMensajeAlerta').dialog('open');
                } else {
                    fUsuarioLeer(ajaxResponse, '');
                }
                $('#dMarcaEditar').dialog('close');
            },
            statusCode: {
                404: function() {
                    $('#lServidorError').text('Página no encontrada.');
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

function fFamiliaEditar() {
    var data = 'codUsuario=' + $('#codUsuario').val() + '&' + $('#formFamiliaEditar').serialize();
    var url = "../sUsuario";
    try {
        $.ajax({
            type: "post",
            url: url,
            data: data,
            error: function(XMLHttpRequest, textStatus, errorThrown) {
                $('#lServidorError').text(errorThrown + '()');
                $('#dServidorError').dialog('open');
            },
            success: function(ajaxResponse, textStatus) {
                if (isNaN(ajaxResponse)) {
                    $('#dMensajeAlertaDiv').empty().append(ajaxResponse);
                    $('#dMensajeAlerta').dialog('open');
                } else {
                    fUsuarioLeer(ajaxResponse, '');
                }
                $('#dFamiliaEditar').dialog('close');
            },
            statusCode: {
                404: function() {
                    $('#lServidorError').text('Página no encontrada.');
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

function fZonaEditar() {
    var data = 'codUsuario=' + $('#codUsuario').val() + '&' + $('#formZonaEditar').serialize();
    var url = "../sUsuario";
    try {
        $.ajax({
            type: "post",
            url: url,
            data: data,
            error: function(XMLHttpRequest, textStatus, errorThrown) {
                $('#lServidorError').text(errorThrown + '()');
                $('#dServidorError').dialog('open');
            },
            success: function(ajaxResponse, textStatus) {
                if (isNaN(ajaxResponse)) {
                    $('#dMensajeAlertaDiv').empty().append(ajaxResponse);
                    $('#dMensajeAlerta').dialog('open');
                } else {
                    fUsuarioLeer(ajaxResponse, '');
                }
                $('#dZonaEditar').dialog('close');
            },
            statusCode: {
                404: function() {
                    $('#lServidorError').text('Página no encontrada.');
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

function fCompraEditar() {
    var data = 'codUsuario=' + $('#codUsuario').val() + '&' + $('#formCompraEditar').serialize();
    var url = "../sUsuario";
    try {
        $.ajax({
            type: "post",
            url: url,
            data: data,
            error: function(XMLHttpRequest, textStatus, errorThrown) {
                $('#lServidorError').text(errorThrown + '()');
                $('#dServidorError').dialog('open');
            },
            success: function(ajaxResponse, textStatus) {
                if (isNaN(ajaxResponse)) {
                    $('#dMensajeAlertaDiv').empty().append(ajaxResponse);
                    $('#dMensajeAlerta').dialog('open');
                } else {
                    fUsuarioLeer(ajaxResponse, '');
                }
                $('#dCompraEditar').dialog('close');
            },
            statusCode: {
                404: function() {
                    $('#lServidorError').text('Página no encontrada.');
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

function fProveedorEditar() {
    var data = 'codUsuario=' + $('#codUsuario').val() + '&' + $('#formProveedorEditar').serialize();
    var url = "../sUsuario";
    try {
        $.ajax({
            type: "post",
            url: url,
            data: data,
            error: function(XMLHttpRequest, textStatus, errorThrown) {
                $('#lServidorError').text(errorThrown + '()');
                $('#dServidorError').dialog('open');
            },
            success: function(ajaxResponse, textStatus) {
                if (isNaN(ajaxResponse)) {
                    $('#dMensajeAlertaDiv').empty().append(ajaxResponse);
                    $('#dMensajeAlerta').dialog('open');
                } else {
                    fUsuarioLeer(ajaxResponse, '');
                }
                $('#dProveedorEditar').dialog('close');
            },
            statusCode: {
                404: function() {
                    $('#lServidorError').text('Página no encontrada.');
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

function fPersonalEditar() {
    var data = 'codUsuario=' + $('#codUsuario').val() + '&' + $('#formPersonalEditar').serialize();
    var url = "../sUsuario";
    try {
        $.ajax({
            type: "post",
            url: url,
            data: data,
            error: function(XMLHttpRequest, textStatus, errorThrown) {
                $('#lServidorError').text(errorThrown + '()');
                $('#dServidorError').dialog('open');
            },
            success: function(ajaxResponse, textStatus) {
                if (isNaN(ajaxResponse)) {
                    $('#dMensajeAlertaDiv').empty().append(ajaxResponse);
                    $('#dMensajeAlerta').dialog('open');
                } else {
                    fUsuarioLeer(ajaxResponse, '');
                }
                $('#dPersonalEditar').dialog('close');
            },
            statusCode: {
                404: function() {
                    $('#lServidorError').text('Página no encontrada.');
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

function fReporteEditar() {
    var data = 'codUsuario=' + $('#codUsuario').val() + '&' + $('#formReporteEditar').serialize();
    var url = "../sUsuario";
    try {
        $.ajax({
            type: "post",
            url: url,
            data: data,
            error: function(XMLHttpRequest, textStatus, errorThrown) {
                $('#lServidorError').text(errorThrown + '()');
                $('#dServidorError').dialog('open');
            },
            success: function(ajaxResponse, textStatus) {
                if (isNaN(ajaxResponse)) {
                    $('#dMensajeAlertaDiv').empty().append(ajaxResponse);
                    $('#dMensajeAlerta').dialog('open');
                } else {
                    fUsuarioLeer(ajaxResponse, '');
                }
                $('#dReporteEditar').dialog('close');
            },
            statusCode: {
                404: function() {
                    $('#lServidorError').text('Página no encontrada.');
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

function fPropietarioEditar() {
    var data = 'codUsuario=' + $('#codUsuario').val() + '&' + $('#formPropietarioEditar').serialize();
    var url = "../sUsuario";
    try {
        $.ajax({
            type: "post",
            url: url,
            data: data,
            error: function(XMLHttpRequest, textStatus, errorThrown) {
                $('#lServidorError').text(errorThrown + '()');
                $('#dServidorError').dialog('open');
            },
            success: function(ajaxResponse, textStatus) {
                if (isNaN(ajaxResponse)) {
                    $('#dMensajeAlertaDiv').empty().append(ajaxResponse);
                    $('#dMensajeAlerta').dialog('open');
                } else {
                    fUsuarioLeer(ajaxResponse, '');
                }
                $('#dPropietarioEditar').dialog('close');
            },
            statusCode: {
                404: function() {
                    $('#lServidorError').text('Página no encontrada.');
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

function fUsuarioEditar() {
    var data = 'codUsuario=' + $('#codUsuario').val() + '&' + $('#formUsuarioEditar').serialize();
    var url = "../sUsuario";
    try {
        $.ajax({
            type: "post",
            url: url,
            data: data,
            error: function(XMLHttpRequest, textStatus, errorThrown) {
                $('#lServidorError').text(errorThrown + '()');
                $('#dServidorError').dialog('open');
            },
            success: function(ajaxResponse, textStatus) {
                if (isNaN(ajaxResponse)) {
                    $('#dMensajeAlertaDiv').empty().append(ajaxResponse);
                    $('#dMensajeAlerta').dialog('open');
                } else {
                    fUsuarioLeer(ajaxResponse, '');
                }
                $('#dUsuarioEditar').dialog('close');
            },
            statusCode: {
                404: function() {
                    $('#lServidorError').text('Página no encontrada.');
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

function fCargoEditar() {
    var data = 'codUsuario=' + $('#codUsuario').val() + '&' + $('#formCargoEditar').serialize();
    var url = "../sUsuario";
    try {
        $.ajax({
            type: "post",
            url: url,
            data: data,
            error: function(XMLHttpRequest, textStatus, errorThrown) {
                $('#lServidorError').text(errorThrown + '()');
                $('#dServidorError').dialog('open');
            },
            success: function(ajaxResponse, textStatus) {
                if (isNaN(ajaxResponse)) {
                    $('#dMensajeAlertaDiv').empty().append(ajaxResponse);
                    $('#dMensajeAlerta').dialog('open');
                } else {
                    fUsuarioLeer(ajaxResponse, '');
                }
                $('#dCargoEditar').dialog('close');
            },
            statusCode: {
                404: function() {
                    $('#lServidorError').text('Página no encontrada.');
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

function fAreaEditar() {
    var data = 'codUsuario=' + $('#codUsuario').val() + '&' + $('#formAreaEditar').serialize();
    var url = "../sUsuario";
    try {
        $.ajax({
            type: "post",
            url: url,
            data: data,
            error: function(XMLHttpRequest, textStatus, errorThrown) {
                $('#lServidorError').text(errorThrown + '()');
                $('#dServidorError').dialog('open');
            },
            success: function(ajaxResponse, textStatus) {
                if (isNaN(ajaxResponse)) {
                    $('#dMensajeAlertaDiv').empty().append(ajaxResponse);
                    $('#dMensajeAlerta').dialog('open');
                } else {
                    fUsuarioLeer(ajaxResponse, '');
                }
                $('#dAreaEditar').dialog('close');
            },
            statusCode: {
                404: function() {
                    $('#lServidorError').text('Página no encontrada.');
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