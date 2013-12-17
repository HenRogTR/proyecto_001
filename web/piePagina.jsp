<div class="ui-widget">
    <div class="ui-state-highlight ui-corner-all" style="margin-top: 20px; padding: 0 .7em;">
        <p>
            <strong><a href="#" id="equipoTrabajo">Equipo de trabajo</a></p></strong>
    </div>
</div>
<div id="dEquipoTrabajo" title="Equipo de trabajo">
    <strong>Jefe de proyecto:</strong> Danny Sandoval Pezo<br>
    <strong>Analista de Sistemas:</strong> Danny Sandoval Pezo - Henrri Trujillo Romero<br>
    <strong>Programación:</strong> Henrri Trujillo Romero<br>
    <strong>Prueba de errores y correción:</strong> Danny Sandoval Pezo - Henrri Trujillo Romero<br>
    <strong>Colaboradores:</strong> Ignacio Lamberto P. - Richar Lopez M. - Arturo Vargas B.
</div>

<!--Error del servidor-->
<div class="ui-widget" id="dErrorServidor" title="Error" style="font-size: 18px;">
    <div class="ui-state-error ui-corner-all" style="padding: 0 .7em;">
        <p><span class="ui-icon ui-icon-alert" style="float: left; margin-right: .3em;"></span>
            <strong>Error interno del servidor: </strong><label id="lErrorServidor"></label><br> Si es la primera vez reintente o sino contacte con el administrador.</p>
    </div>
</div>

<!--Mensaje de alerta-->
<div id="dMensajeAlerta" title="Mensaje de alerta.">
    <div class="ui-state-highlight ui-corner-all" style="margin-top: 20px; padding: 0 .7em;">
        <p><span class="ui-icon ui-icon-info" style="float: left; margin-right: .3em;"></span>
            <strong>¡Alerta!</strong><br> <label id="lMensajeAlerta"></label><div id="dMensajeAlertaDiv"></div></p>
    </div>
</div>

<!--Procesando petición-->
<div id="dProcesandoPeticion" title="Procesando petición">
    <div class="ui-state-highlight ui-corner-all" style="margin-top: 20px; padding: 0 .7em; text-align: center">
        <p>
            <img src="../imagenes/loading_1.gif" style="height: 100px;"/><br>
            <strong><label id="lProcesandoPeticion">¡Procesando petición!</label> Espere por favor...</strong></p>
    </div>
</div>

<!--Implementando-->
<div id="dImplementando" title="Mensaje de alerta.">
    <div class="ui-state-highlight ui-corner-all" style="margin-top: 20px; padding: 0 .7em;">
        <p><span class="ui-icon ui-icon-info" style="float: left; margin-right: .3em;"></span>
            <strong>¡Alerta!</strong><br> Implementando...</p>
    </div>
</div>
<script>
    $(document).ready(function() {
        $('#equipoTrabajo').click(function(event) {
            $('#dEquipoTrabajo').dialog('open');
            event.preventDefault();
        });
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
            },
        });

        $("#dErrorServidor").dialog({
            autoOpen: false,
            modal: true,
            resizable: true,
            height: 250,
            width: 600,
            buttons: {
                Aceptar: function() {
                    $(this).dialog("close");
                },
            },
            close: function() {
                $(this).dialog("close");
            },
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
                },
            },
            close: function() {
                $(this).dialog("close");
            },
        });

        $("#dImplementando").dialog({
            autoOpen: false,
            modal: true,
            resizable: true,
            height: 250,
            width: 400,
            buttons: {
                Aceptar: function() {
                    $(this).dialog("close");
                },
            },
            close: function() {
                $(this).dialog("close");
            },
        });
        $("#dErrorServidor").dialog({
            autoOpen: false,
            modal: true,
            resizable: true,
            height: 250,
            width: 600,
            buttons: {
                Aceptar: function() {
                    $(this).dialog("close");
                },
            },
            close: function() {
                $(this).dialog("close");
            },
        });

        $("#dProcesandoPeticion").dialog({
            autoOpen: false,
            modal: true,
            resizable: true,
            height: 250,
            width: 400,
            buttons: {
//                Aceptar: function() {
//                    $(this).dialog("close");
//                },
            },
            close: function() {
                $(this).dialog("close");
            },
        });
    });
    
   
</script>