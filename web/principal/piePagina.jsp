<%-- 
    Document   : piePagina
    Created on : 20/08/2013, 04:23:48 PM
    Author     : Henrri***
--%>

<div class="ui-widget">
    <div class="ui-state-highlight ui-corner-all" style="margin-top: 20px; padding: 0 .7em;">
        <p>
            <strong><a href="#" id="equipoTrabajo">Equipo de trabajo</a></strong>
        </p>
        <strong><a href="#" id="novedades">Novedades</a></p></strong>
    </div>
</div>
<div id="dEquipoTrabajo" title="Equipo de trabajo">
    <strong>Jefe de proyecto:</strong> Danny Sandoval Pezo<br>
    <strong>Analista de Sistemas:</strong> Danny Sandoval Pezo - Henrri Trujillo Romero<br>
    <strong>Programaci�n:</strong> Henrri Trujillo Romero<br>
    <strong>Prueba de errores y correci�n:</strong> Danny Sandoval Pezo - Henrri Trujillo Romero<br>
    <strong>Colaboradores:</strong> Ignacio Lamberto P. - Richar Lopez M. - Arturo Vargas B.
</div>
<!--Error del servidor-->
<div class="ui-widget" id="dServidorError" title="Error del servidor" style="font-size: 18px;">
    <div class="ui-state-error ui-corner-all" style="padding: 0 .7em;">
        <p><span class="ui-icon ui-icon-alert" style="float: left; margin-right: .3em;"></span>
            <strong>Error interno del servidor </strong><br><label id="lServidorError"></label><br> Si es la primera vez reintente o sino contacte con el administrador.</p>
    </div>
</div>
<!--Mensaje de alerta-->
<div id="dMensajeAlerta" title="Mensaje de alerta.">
    <div class="ui-state-highlight ui-corner-all" style="margin-top: 20px; padding: 0 .7em;">
        <p><span class="ui-icon ui-icon-info" style="float: left; margin-right: .3em;"></span>
            <strong>�Alerta!</strong><br> <div id="dMensajeAlertaDiv"></div></p>
    </div>
</div>

<div id="dAlerta" title="Mensaje de alerta.">
    <div class="ui-state-highlight ui-corner-all" style="margin-top: 20px; padding: 0 .7em;">
        <p><span class="ui-icon ui-icon-info" style="float: left; margin-right: .3em;"></span>
            <strong>�Alerta!</strong><br>
            <span id="dAlertaDiv"></span></p>
    </div>
</div>
<!--Procesando petici�n-->
<div id="dProcesandoPeticion" title="Procesando petici�n">
    <div class="ui-state-highlight ui-corner-all" style="margin-top: 20px; padding: 0 .7em; text-align: center">
        <p>
            <img src="../imagenes/loading_1.gif" style="height: 100px;"/><br>
            <strong><label id="lProcesandoPeticion">�Procesando petici�n!</label> Espere por favor...</strong></p>
    </div>
</div>

<!--div libre-->
<div id="dLibre" style="text-align: center; vertical-align: middle;">
    <div id="dLibreSub" class="izquierda">
        <img src="../imagenes/loading_1.gif" style="height: 50px;"/>
    </div>
</div>

<div id="dNovedades" title="Novedades" style="font-size: 10px;">
    <div style="background: #F1F1F7">
        <h3 class="titulo">24/03/2014</h3>
        <p>            
            * Otras correcciones.<br>
            * Correcci�n en la visualizaci�n de montos en monedas menores a 0.10.<br>
            * Correcci�n de desplazamiento o navegaci�n de los botones primero <> atras <> siguiente <> �ltimo en los diferentes m�dulos.<br>
            * Habilitaci�n de autogenerado para el m�dulo cobranza de el tipo de doc. R-XXX<br>
        </p>
        <h3 class="titulo">22/03/2014</h3>
        <p>            
            * Se a�adio el reporte de articulos comprados � vendidios en un periodo dado<br>
            * Pruebas en este reporte.<br>
        </p>
        <h3 class="titulo">20/03/2014</h3>
        <p>            
            * Se a�ade los reportes de stock por familia, familia-marca<br>
            * Se personaliza los nombres de los archivos exportados<br>
        </p>
        <h3 class="titulo">19/03/2014</h3>
        <p>            
            * Habilitaci�n y mejora de reportes en m�dulo/articulos<br>
            * Antes de generar los reportes de cliente se validaran los datos desde usario y servidor para evitar errores ya sea de fechas y otros.<br>
            * Optimizaci�n de uso de conexiones para reportes, reduciendo de n (conexiones) * cantidadArticulos a s�lo cantidad de articulos.<br>
            * Personalizacion en los nombres de los archivos exportados (excel) de acuerdo al tipo de archivo<br>
        </p>
        <h3 class="titulo">14/03/2014</h3>
        <p>            
            * Habilitaci�n y mejora de reportes en m�dulo/cobranza<br>
            * Correci�n en el bloqueo de fechas anteriores y posteriores en la validacion del calendario<br>
            * Antes de generar los reportes de cliente se validaran los datos desde usario y servidor para evitar errores ya sea de fechas y otros.<br>
            * Optimizaci�n de uso de conexiones para reportes, reduciendo de n (conexiones) * cantidadClientes a s�lo cantidad de clientes.<br>
            * Personalizacion en los nombres de los archivos exportados (excel) de acuerdo al tipo de archivo<br>
        </p>
        <h3 class="titulo">12/03/2014</h3>
        <p>
            * Habilitaci�n y mejora de reportes en m�dulo/cliente<br>
            * Correci�n en el bloqueo de fechas anteriores y posteriores en la validacion del calendario<br>
            * Antes de generar los reportes de cliente se validaran los datos desde usario y servidor para evitar errores ya sea de fechas y otros.<br>
            * Optimizaci�n de uso de conexiones para reportes, reduciendo de n (conexiones) * cantidadClientes a s�lo cantidad de clientes.<br>
            * Personalizacion en los nombres de los archivos exportados (excel) de acuerdo al tipo de archivo<br>
        </p>
        <h3 class="titulo">10/03/2014</h3>
        <p>
            * Habilitaci�n y mejora de reportes/venta<br>
            * Correci�n en el bloqueo de fechas anteriores y posteriores en la validacion del calendario reporte/venta<br>
            * Antes de generar los reportes de cliente se validaran los datos desde usario y servidor para evitar errores ya sea de fechas y otros.<br>
            * Se cambio a la forma de busqueda de cobrador por autocompletado facilitando la b�squeda de un cobrador.<br>
            * Optimizaci�n de uso de conexiones para reportes, reduciendo de n (conexiones) * cantidadClientes a s�lo cantidad de clientes. (reporte/cobranza)<br>
        </p>
        <h3 class="titulo">08/03/2014</h3>
        <p>            
            * Otras correcciones.<br>
        </p>
        <h3 class="titulo">01/03/2014</h3>
        <p>            
            * Otras correcciones.<br>
        </p>
        <h3 class="titulo">17/02/2014</h3>
        <p>
            * Mejora en el inicio de sesi�n.<br>
            * Otras correcciones.<br>
        </p>
        <h3 class="titulo">30/01/2014</h3>
        <p>            
            * Correciones y mejoras.<br>
        </p>
        <h3 class="titulo">29/01/2014</h3>
        <p>
            * La busqueda para los clientes, articulos, vendedores etc se hace por una mejora en 
            coincidencia.<br>
            * Ejm. si busco <strong>JUAN LO</strong><br>
            * Dar� como resultados<br>
            --- ARANGO TATAJE <strong>JUAN</strong> CAR<strong>LO</strong>S <br>
            --- CENTRO MEDICO QUIRURGICO <strong>JUAN</strong> PAB<strong>LO</strong> II E.I.R.L.<br>
            Todas las coincidencias por cada palabra dentro de cada palabra respetando el orden. Parte_primer_apellido+Parte_nombres <br>
        </p>
        <h3 class="titulo">28/01/2014</h3>
        <p>
            * Actualizaci�n y mejora en la la serie de los comprobantes(formato) en venta, compra y cobranza.<br>
            * Otras correcciones.<br>
        </p>
        <h3 class="titulo">17/01/2014</h3>
        <p>
            * Actualizaci�n y mejora de kardex de cliente.<br>
            * Otras correcciones.<br>
        </p>
        <h3 class="titulo">14/01/2014</h3>
        <p>
            * Resaltar la coincidencia en el autocompletado.<br>
            * Correci�n del modulo de cobranza.<br>
        </p>
        <h3 class="titulo">05/01/2014</h3>
        <p>
            * Correcc�on de error en b�squeda e impresi�n de compras.<br>
            * Mejora de estilo visual en compras.<br>
            * Se quito la apertura de vista previa de impresion al imprimir compras.<br>
        </p>
        <h3 class="titulo">31/12/2013</h3>
        <p>
            * Mejorar la vista de clientes.<br>
            * Modificacion de vista de registro de Cliente Natural y Jur�dico.<br>
            * Modificacion de vista de edici�n de Cliente Natural y Jur�dico.<br>
        </p>
        <h3 class="titulo">30/12/2013</h3>
        <p>
            * La(s) S/N en stock para cada art�culo se muestra en un dialogo en la misma p�gina.<br>
            * Se muestra las novedades para cada actualizaci�n.<br>
        </p>
    </div>
</div>