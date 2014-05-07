/* 
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */


$('#formClienteJuridicoRegistrar').validate({
//    ignore: "", // si en caso no se ingnora los campos ocultos
    submitHandler: function() {

    },
    onkeyup: function(element) {
        $(element).valid();
    },
    rules: {
    },
    messages: {
    }
});