<%-- 
    Document   : menu
    Created on : 20/08/2013, 04:34:32 PM
    Author     : Henrri
--%>
<section id="menuPrincipal">
    <div><span><img src="../librerias/imagenes/home_icon.png" alt="IMG" width="35px" height="35px"></span></div>
    <ul>
        <li>
            <a href="#">
                <img src="../librerias/imagenes/icono_menu_superior_usuario.jpg" alt="IMG" width="35px" height="35px">
                ADMIN
            </a>
        </li>
        <hr>
        <li><a href="#"><img src="../librerias/imagenes/descarga.jpg" alt="IMG" width="35px" height="35px">Clientes</a>
            <ul>
                <li id="permiso1"><a href="../sDatoCliente">Cartera de clientes</a></li>
                <li id="permiso2"><a href="../persona/clienteKardex.jsp">Kardex</a></li>
                <li id="permiso24"><a href="">Garante</a></li>
                <li id="permiso25"><a href="#">Propietario</a></li>
            </ul>
        </li>
        <li id="permiso18"><a href="../sVenta?accionVenta=mantenimiento"><img src="../librerias/imagenes/descarga.jpg" alt="IMG" width="35px" height="35px">Módulo de Ventas</a></li>
        <li id="permiso22"><a href="../cobranza/cobranza.jsp"><img src="../librerias/imagenes/descarga.jpg" alt="IMG" width="35px" height="35px">Módulo de Cobranza</a></li>
        <li id="permiso19"><a href="../reportes/reporte.jsp"><img src="../librerias/imagenes/descarga.jpg" alt="IMG" width="35px" height="35px">Reporte</a></li>
        <li><a href="#"><img src="../librerias/imagenes/descarga.jpg" alt="IMG" width="35px" height="35px">Almacén</a>
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
        <!--                        <hr>
                                <li>
                                    <a href="#">
                                        <img src="KAAF.png" alt="IMG" width="35px" height="35px">
                                        Operaciones
                                    </a>
                                </li>
                                <li>
                                    <a href="#">
                                        <img src="KAAF.png" alt="IMG" width="35px" height="35px">
                                        Acerca de...
                                    </a>
                                </li>
                                <hr>
                                <li>
                                    <a href="#">
                                        <img src="KAAF.png" alt="IMG" width="35px" height="35px">
                                        Contáctanos
                                    </a>
                                </li>-->
    </ul>
</section>