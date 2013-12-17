<script>
    $(function() {
        $("#menu").menu();
    });
</script>
<h3 class="titulo">USUARIO : <%=objUsuario.getUsuario()%></h3>                
<br>
<ul id="menu">
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
    <li id="permiso22"><a href="../cobranza/cobranzaNueva.jsp">Módulo de Cobranza</a></li>
    <li id="permiso19"><a href="../reportes/reporteMenu.jsp">Reportes</a></li>
    <li><a href="#">Almacen</a>
        <ul>
            <li id="permiso3"><a href="../compra/compraListar.jsp">Movimientos y Compras</a></li>
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
            <li id="permiso9"><a href="../sPeronal">Mantenimiento de Personal</a></li>
            <li id="permiso10"><a href="../persona/cargosListar.jsp">Cargos</a></li>
            <li id="permiso11"><a href="../persona/areaListar.jsp">Área</a></li>
        </ul>
    </li>
    <li>
        <a href="#">Otras tablas</a>
        <ul>
            <li id="permiso12"><a href="../persona/empresaConvenioMantenimiento.jsp">Empresa</a></li>
            <li id="permiso13"><a href="../articuloProducto/marcaListar.jsp">Marcas</a></li>
            <li id="permiso14"><a href="../sFamilia">Familias</a></li>
            <li id="permiso15"><a href="">####</a></li>
            <li id="permiso16"><a href="../sZona">Zona</a></li>
            <li id="permiso17"><a href="../controlDocumento/controlDocumento.jsp">Control de documentos</a></li>
        </ul>
    </li>
    <li  id="permiso20">
        <a href="../sUsuario">Usuarios</a>
    </li>
    <li>
        <a href="../sUsuario?accionUsuario=c">Cerrar Sesión</a>
    </li>
</ul>
<%
    if (session.getAttribute("mensaje") != null) {
%>
<div class="ui-widget">
    <div class="ui-state-highlight ui-corner-all" style="margin-top: 10px;">
        <p><span class="ui-icon ui-icon-info" style="float: left; margin-right: .3em;"></span>
            <strong>Mensaje: </strong><%=session.getAttribute("mensaje")%></p>
    </div>
</div>
<%
    }
    if (session.getAttribute("error") != null) {
%>
<div class="ui-widget" style="margin-top: 10px">
    <div class="ui-state-error ui-corner-all" style="padding: 0 .7em;">
        <p><span class="ui-icon ui-icon-alert" style="float: left; margin-right: .3em;"></span>
            <strong>Alerta: </strong><%=session.getAttribute("error")%></p>
    </div>
</div>
<%
    }
%>
<script>
    $(document).ready(function() {
        try {
            var data;
            $.ajax({
                type: "post",
                url: "../otros/permisosUsuarios.jsp",
                data: data,
//            context: {"codArticuloProducto": codArticuloProducto},
                error: callback_error,
                success: permisosUsuarios
            });
        }
        catch (ex) {
            alert(ex.description);
        }
    });

    function callback_error(XMLHttpRequest, textStatus, errorThrown) {
        // en ambientes serios esto debe manejarse con mucho cuidado, aqui optamos por una solucion simple
        $('#lErrorServidor').text(errorThrown);
        $('#dErrorServidor').dialog('open');
    }
    ;
    
    function permisosUsuarios(ajaxResponse, textStatus) {
        var permisos = procesarRespuesta(ajaxResponse);
        if (permisos) {
            var permiso = permisos[0];
            if (!permiso.permiso1) {
                $("#permiso1").addClass("ui-state-disabled");
            }
            if (!permiso.permiso2) {
                $("#permiso2").addClass("ui-state-disabled");
            }
            if (!permiso.permiso3) {
                $("#permiso3").addClass("ui-state-disabled");
            }
            if (!permiso.permiso4) {
                $("#permiso4").addClass("ui-state-disabled");
            }
            if (!permiso.permiso5) {
                $("#permiso5").addClass("ui-state-disabled");
            }
            if (!permiso.permiso6) {
                $("#permiso6").addClass("ui-state-disabled");
            }
            if (!permiso.permiso7) {
                $("#permiso7").addClass("ui-state-disabled");
            }
            if (!permiso.permiso8) {
                $("#permiso8").addClass("ui-state-disabled");
            }
            if (!permiso.permiso9) {
                $("#permiso9").addClass("ui-state-disabled");
            }
            if (!permiso.permiso10) {
                $("#permiso10").addClass("ui-state-disabled");
            }
            if (!permiso.permiso11) {
                $("#permiso11").addClass("ui-state-disabled");
            }
            if (!permiso.permiso12) {
                $("#permiso12").addClass("ui-state-disabled");
            }
            if (!permiso.permiso13) {
                $("#permiso13").addClass("ui-state-disabled");
            }
            if (!permiso.permiso14) {
                $("#permiso14").addClass("ui-state-disabled");
            }
            if (!permiso.permiso15) {
                $("#permiso15").addClass("ui-state-disabled");
            }
            if (!permiso.permiso16) {
                $("#permiso16").addClass("ui-state-disabled");
            }
            if (!permiso.permiso17) {
                $("#permiso17").addClass("ui-state-disabled");
            }
            if (!permiso.permiso18) {
                $("#permiso18").addClass("ui-state-disabled");
            }
            if (!permiso.permiso19) {
                $("#permiso19").addClass("ui-state-disabled");
            }
            if (!permiso.permiso20) {
                $("#permiso20").addClass("ui-state-disabled");
            }
            if (!permiso.permiso21) {
                $("#permiso21").addClass("ui-state-disabled");
            }
            if (!permiso.permiso22) {
                $("#permiso22").addClass("ui-state-disabled");
            }
            if (!permiso.permiso23) {
                $("#permiso23").addClass("ui-state-disabled");
            }
            if (!permiso.permiso24) {
                $("#permiso24").addClass("ui-state-disabled");
            }
            if (!permiso.permiso25) {
                $("#permiso25").addClass("ui-state-disabled");
            }
            if (!permiso.permiso26) {
                $("#permiso26").addClass("ui-state-disabled");
            }
            if (!permiso.permiso27) {
                $("#permiso27").addClass("ui-state-disabled");
            }
            if (!permiso.permiso28) {
                $("#permiso28").addClass("ui-state-disabled");
            }
            if (!permiso.permiso29) {
                $("#permiso29").addClass("ui-state-disabled");
            }
            if (!permiso.permiso30) {
                $("#permiso30").addClass("ui-state-disabled");
            }
        }
    }
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
</script>