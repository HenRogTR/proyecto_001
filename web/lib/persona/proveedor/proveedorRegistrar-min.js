$().ready(function(){$("input,textarea").blur(function(){$(this).val($.trim($(this).val().toUpperCase()))});$.validator.setDefaults({submitHandler:function(){var d=$("#formProveedor");var a=d.attr("action");var c=d.serialize();try{$.ajax({type:"POST",url:a,data:c,beforeSend:callback_espera,error:callback_error,success:callback_proveedorRegistrar})}catch(b){$("#lErrorServidor").text(b);$("#dErrorServidor").dialog("open")}},showErrors:function(c,b){var a=document.activeElement;if(a&&$(a).is("input, textarea")){$(this.currentForm).tooltip("close",{currentTarget:a},true)}this.currentElements.removeAttr("title").removeClass("ui-state-highlight");$.each(b,function(e,d){$(d.element).attr("title",d.message).addClass("ui-state-highlight")});if(a&&$(a).is("input, textarea")){$(this.currentForm).tooltip("open",{target:a})}}});$("#formProveedor").tooltip({show:false,hide:false});$("#formProveedor").validate({rules:{ruc:{required:true,number:true,minlength:11,maxlength:11,remote:"validacion/proveedorRucVerificar.jsp"},razonSocial:{required:true,minlength:4,remote:"validacion/proveedorRazonSocialVerificar.jsp",},direccion:{required:true,minlength:8,},telefono1:{minlength:6,},telefono2:{minlength:9,},email:{email:true,},paginaWeb:{url:true,}},messages:{ruc:{number:"Escriba solo numeros",remote:jQuery.format("El N° de <b>RUC: {0}</b> ya se encuentra registrado."),},razonSocial:{remote:jQuery.format("<b>{0}</b> se encuentra registrado."),},}})});function callback_espera(){$("#trBotones").addClass("ocultar");$("#lProcesandoPeticion").text("Regsitrando proveedor.<br>");$("#dProcesandoPeticion").dialog("open")}function callback_proveedorRegistrar(a,b){$("#loader_gif").fadeOut("slow");$("#men").fadeOut("slow");$("#descripcion").val("");$("#cancelar").removeAttr("disabled").removeClass("disabled");$("#restaurar").removeAttr("disabled").removeClass("disabled");$("#accion").removeAttr("disabled").removeClass("disabled");if(a=="1"){$("#mensaje").text("Registro exitoso");$("#basic-modal-content").modal()}else{$("#mensaje").text("Falló el registro");$("#basic-modal-content").modal()}};