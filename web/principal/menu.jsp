<%-- 
    Document   : menu
    Created on : 20/08/2013, 04:34:32 PM
    Author     : Henrri
--%>
<h3 class="titulo">USUARIO : <label id="lUsuarioMenu"></label></h3>
<!--menu-->
<ul id="ulMenu">
    <li><a href="../index.jsp">Inicio</a></li>
    <li><a href="#">Clientes</a>
        <ul>
            <li id="permiso1"><a href="../sDatoCliente">Cartera de clientes</a></li>
            <li id="permiso2"><a href="../persona/clienteKardex.jsp">Kardex</a></li>
            <li id="permiso24"><a href="">Garante</a></li>
            <li id="permiso25"><a href="#">Propietario</a></li>
        </ul>
    </li>
    <li id="permiso18"><a href="../sVenta?accionVenta=mantenimiento">Módulo de Ventas</a></li>
    <li id="permiso22"><a href="../cobranza/cobranza.jsp">Módulo de Cobranza</a></li>
    <li id="permiso19"><a href="../reportes/reporte.jsp">Reporte</a></li>
    <li><a href="#">Almacen</a>
        <ul>
            <li id="permiso3"><a href="../compra/compraMantenimiento.jsp">Movimientos y Compras</a></li>
            <li id="permiso4"><a href="../sArticuloProducto">Artículos y Productos</a></li>
            <li id="permiso5"><a href="../sProveedor">Proveedores</a></li>
            <li id="permiso6"><a href="#">Actualizacion manual de almacén</a></li>
            <li id="permiso7"><a href="../articuloProducto/kardexArticuloProducto.jsp">Kardex de Productos</a></li>
            <li id="permiso21"><a href="../articuloProducto/kardexArticuloProductoPorSN.jsp">Kardex de Producto X S/N</a></li>
            <li id="permiso8"><a href="../compra/almacenListar.jsp">Listar almacén</a></li>
        </ul>
    </li>
    <li><a href="#">Personal</a>
        <ul>
            <li id="permiso9"><a href="../sPersonal">Mantenimiento de Personal</a></li>
            <li id="permiso10"><a href="../persona/cargosListar.jsp">Cargos</a></li>
            <li id="permiso11"><a href="../persona/areaListar.jsp">Área</a></li>
        </ul>
    </li>
    <li>
        <a href="#">Otras tablas</a>
        <ul>
            <li id="permiso12"><a href="../sEmpresaConvenio">Empresa</a></li>
            <li id="permiso13"><a href="../articuloProducto/marcaListar.jsp">Marcas</a></li>
            <li id="permiso14"><a href="../sFamilia">Familias</a></li>
            <li id="permiso60"><a href="../configuracion/configuracion.jsp">Configuraciones</a></li>
            <li id="permiso16"><a href="../sZona">Zona</a></li>
            <li id="permiso17"><a href="../controlDocumento/controlDocumento.jsp">Control de documentos</a></li>
            <li id="permiso50"><a href="../controlDocumento/controlReciboIngresos.jsp">Control de recibo ingresos</a></li>
        </ul>
    </li>
    <li id="permiso20">
        <a href="../sUsuario">Usuarios</a>
    </li>
    <li>
        <a href="../persona/usuarioContraseniaCambiar.jsp">Cambiar contraseña</a>
    </li>
    <li>
        <a href="#" id="aUsuarioCerrarSesion">Cerrar Sesión</a>
    </li>
</ul>
<!--mensaje alerta-->
<div id="d_mensajeAlerta" class="ui-state-highlight ui-corner-all" style="margin-top: 11px; padding: 0 .7em;">
    <p><span class="ui-icon ui-icon-info" style="float: left; margin-right: .3em;"></span>
        <strong>Hey!</strong> Sample ui-state-highlight style.</p>
</div>
<!--mensaje error-->
<div id="d_mensajeError" class="ui-state-error ui-corner-all" style="margin-top: 11px; padding: 0 .7em;">
    <p><span class="ui-icon ui-icon-alert" style="float: left; margin-right: .3em;"></span>
        <strong>Alert:</strong> Sample ui-state-error style.</p>
</div>
<!--d iniciar sesion-->
<div id="dIniciarSesion" style="text-align: center;" title="Iniciar sesión">
    <form action="sUsuario" method="post" id="formUsuarioIniciar" name="formUsuarioIniciar">
        <br>
        <br>
        <input type="text" name="usuario" id="usuario" placeholder="Usuario" class="login"/>
        <br>
        <input type="password" name="contrasenia" id="contrasenia" placeholder="Contraseña" class="login"/>
        <br>
        <input type="hidden" name="accionUsuario" id="accionUsuario" value="ingresar" />
        <label id="lUsuarioErrorInicio" class="alerta"></label>
        <br>
        <button class="sexybutton" id="bCerrarSistema" type="button"><span><span><img src="../librerias/botonesIconos/images/icons/silk/decline.png">Cerrar</span></span></button>
        <button class="sexybutton" id="bLimpiarLogin" type="button"><span><span><img src="../librerias/botonesIconos/images/icons/silk/erase.png">Limpiar</span></span></button>
        <button class="sexybutton" id="bIngresar" type="button"><span><span><img src="../librerias/botonesIconos/images/icons/silk/key_go.png">Ingresar</span></span></button>
    </form>
</div>

<!--d cerrar sesion confirmar-->
<div id="dUsuarioCerrarSesionConfirmar" title="Cerrar sesion">
    <div class="ui-state-highlight ui-corner-all" style="margin-top: 20px; padding: 0 .7em;">
        <p><span class="ui-icon ui-icon-info" style="float: left; margin-right: .3em;"></span>
            <strong>Aviso</strong> ¿Está seguro que desea cerrar la sesión?</p>
    </div>
</div>


