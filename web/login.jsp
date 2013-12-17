<%-- 
    Document   : login
    Created on : 27/11/2012, 11:49:02 AM
    Author     : Henrri
--%>
<script>
    $(function() {
        //                $( "#menu" ).menu();
        $("#login").menu();
    });
</script>
<h3 class="titulo">INICIAR SESIÓN</h3>
<br>
<ul id="login">
    <form class="cmxform" id="frmUsuario" method="post" action="sUsuario">
        <!--            <fieldset class="ui-widget ui-widget-content ui-corner-all">
                        <legend class="ui-widget ui-widget-header ui-corner-all"> sesion</legend>                -->
        <p>
            <label for="usuario">Usuario</label>
            <input id="usuario" name="usuario" type="text" value=""/>
        </p>
        <p>
            <label for="contrasenia">Contraseña</label>
            <input id="contrasenia" name="contrasenia" type="password" value=""/>
        </p>
        <p>
            <input type="hidden" name="accionUsuario" value="i" />
            <button class="submit" type="submit">Ingresar</button>
        </p>
        <!--</fieldset>-->
    </form>
    <script type="text/javascript" src="lib/jquery-validation/jquery-validation-1.10.0/js/jquery.validate.min.js"></script>
    <script type="text/javascript" src="lib/jquery-validation/localization/messages_es.js"></script>

    <script type="text/javascript">
        $.validator.setDefaults({
            //                submitHandler: function() { alert("submitted!"); },
            showErrors: function(map, list) {
                // there's probably a way to simplify this
                var focussed = document.activeElement;
                if (focussed && $(focussed).is("input, textarea")) {
                    $(this.currentForm).tooltip("close", {currentTarget: focussed}, true)
                }
                this.currentElements.removeAttr("title").removeClass("ui-state-highlight");
                $.each(list, function(index, error) {
                    $(error.element).attr("title", error.message).addClass("ui-state-highlight");
                });
                if (focussed && $(focussed).is("input, textarea")) {
                    $(this.currentForm).tooltip("open", {target: focussed});
                }
            }
        });

        (function() {
            // utilizar información sobre herramientas personalizada, 
            // desactivar las animaciones de momento de solucionar la falta 
            // de método de actualización de información sobre herramientas.
            $("#frmUsuario").tooltip({
                show: false,
                hide: false
            });
            //para mostrar los mensajes de los errores,

            // validar el formulario de comentarios cuando se presenten.
            //                $("#commentForm").validate();

            // validar registrarse en forma soltar tecla y enviar
            $("#frmUsuario").validate({
                rules: {
                    usuario: {
                        required: true,
                        minlength: 4
                    },
                    contrasenia: {
                        required: true,
                        minlength: 4
                    }
                },
                messages: {
                    usuario: {
                        required: "Por favor, introduzca un nombre de <b>Usuario</b>",
                        minlength: "El nombre área debe consistir de por lo menos <b>{0}</b> caracteres"
                    },
                    contrasenia: {
                        required: "Por favor, introduzca su <b>Contraseña</b>",
                        minlength: "El nombre área debe consistir de por lo menos <b>{0}</b> caracteres"
                    }
                }
            });

            $("#frmUsuario input:not(:submit)").addClass("ui-widget-content");

            $(":submit").button();
        })();
    </script>
</ul>