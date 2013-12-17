/* 
 * To change this template, choose Tools | Templates
 * and open the template in the editor.
 */


function mostrarLoader() {

}
function callback_error(XMLHttpRequest, textStatus, errorThrown) {
    $("#registroErrorServidor").dialog("open");
}
function mostrarRespuesta(respuesta) {
    if (respuesta == "1") {
        $("#area").val("");
        $("#detalle").val("");
        $("#registroExitoso").dialog("open");
    } else {
        $("#registroError").dialog("open");
    }
}