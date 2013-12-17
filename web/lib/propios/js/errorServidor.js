/* 
 * To change this template, choose Tools | Templates
 * and open the template in the editor.
 */

$("#dErrorServidor").dialog({
    autoOpen: false,
    modal: true,
    resizable: true,
    height: 180,
    width: 350,
    buttons: {
        Aceptar: function() {
            $(this).dialog("close");
        },
    },
    close: function() {
        $(this).dialog("close");
    },
});
