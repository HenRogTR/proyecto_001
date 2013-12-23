/*
 * To change this template, choose Tools | Templates
 * and open the template in the editor.
 */
package compraServlets;

import articuloProductoClases.cArticuloProducto;
import articuloProductoClases.cKardexArticuloProducto;
import articuloProductoClases.cKardexSerieNumero;
import articuloProductoClases.cPrecioVenta;
import compraClases.cAlmacen;
import compraClases.cCompra;
import compraClases.cCompraDetalle;
import compraClases.cCompraSerieNumero;
import java.io.IOException;
import java.io.PrintWriter;
import java.util.ArrayList;
import java.util.List;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;
import otros.cManejoFechas;
import otros.cNumeroLetra;
import otros.cUtilitarios;
import personaClases.cProveedor;
import tablas.Compra;
import tablas.CompraDetalle;
import tablas.CompraSerieNumero;
import tablas.KardexArticuloProducto;
import tablas.KardexSerieNumero;
import tablas.PrecioVenta;
import tablas.Usuario;

/**
 *
 * @author Henrri
 */
@WebServlet(name = "sCompra", urlPatterns = {"/sCompra"})
public class sCompra extends HttpServlet {

    /**
     * Processes requests for both HTTP <code>GET</code> and <code>POST</code>
     * methods.
     *
     * @param request servlet request
     * @param response servlet response
     * @throws ServletException if a servlet-specific error occurs
     * @throws IOException if an I/O error occurs
     */
    protected void processRequest(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        response.setContentType("text/html;charset=UTF-8");
        PrintWriter out = response.getWriter();

        String accion = request.getParameter("accionCompra");
        HttpSession session = request.getSession();

        int codCompra = 0;

        cCompra objcCompra = new cCompra();
        cCompraDetalle objcCompraDetalle = new cCompraDetalle();
        cProveedor objcProveedor = new cProveedor();
        cUtilitarios objcUtilitarios = new cUtilitarios();
        cManejoFechas objcManejoFechas = new cManejoFechas();
        cKardexArticuloProducto objcKardexArticuloProducto = new cKardexArticuloProducto();
        cAlmacen objcAlmacen = new cAlmacen();
        cArticuloProducto objcArticuloProducto = new cArticuloProducto();
        cNumeroLetra objcNumeroLetra = new cNumeroLetra();
        cCompraSerieNumero objcCompraSerieNumero = new cCompraSerieNumero();
        cKardexSerieNumero objcKardexSerieNumero = new cKardexSerieNumero();
        cPrecioVenta objcPrecioVenta = new cPrecioVenta();

        Usuario objUsuario = (Usuario) session.getAttribute("usuario");

        if (accion == null) {
            session.removeAttribute("codCompraMantenimiento");
            response.sendRedirect("compra/compraMantenimiento.jsp");
        } else {
            if (accion.equals("mantenimiento")) {
                session.removeAttribute("codCompraMantenimiento");
                try {
                    codCompra = Integer.parseInt(request.getParameter("codCompra"));
                    session.setAttribute("codCompraMantenimiento", codCompra);
                } catch (NumberFormatException e) {
                }
                response.sendRedirect("compra/compraMantenimiento.jsp");
            }
            if (accion.equals("registrar")) {
                try {
                    Compra objCompra = new Compra();
                    objCompra.setProveedor(objcProveedor.leer_cod(Integer.parseInt(request.getParameter("codProveedor"))));
                    objCompra.setTipo(request.getParameter("tipo").toString().equals("0") ? "Contado" : "Crédito");
                    objCompra.setItemCantidad(Integer.parseInt(request.getParameter("itemCantidad")));  //cantidad de item's comprados
                    objCompra.setDocSerieNumero(request.getParameter("docSerieNumero"));
                    objCompra.setFechaFactura(objcManejoFechas.caracterADate(request.getParameter("fechaFactura")));
                    objCompra.setFechaVencimiento(objcManejoFechas.caracterADate(request.getParameter("fechaVencimiento")));
                    objCompra.setFechaLlegada(objcManejoFechas.caracterADate(request.getParameter("fechaLlegada")));
                    objCompra.setRegistro(objcUtilitarios.registro("1", objUsuario.getCodUsuario().toString()));    //recogemos los datos para la columna registro.
                    objCompra.setObservacion(request.getParameter("observacion"));
                    objCompra.setMoneda(request.getParameter("moneda").equals("0") ? "Soles" : "Dólares");
                    double descuento = Double.parseDouble(request.getParameter("descuento") != null
                            ? (request.getParameter("descuento").equals("") ? "0.0000" : request.getParameter("descuento")) : "0.0000");
                    double igv = 0;
                    codCompra = 0;
                    //listas
                    List compraDetalleList = new ArrayList();
                    List compraSerieNumeroNuevoList = new ArrayList(); //lista que contendra las lsitas para cada uno de los items
                    List kardexSerieNumeroNuevoList = new ArrayList();
                    for (int i = 1; i <= objCompra.getItemCantidad(); i++) {
                        CompraDetalle objCompraDetalle = new CompraDetalle();
                        objCompraDetalle.setArticuloProducto(objcArticuloProducto.leer_cod(Integer.parseInt(request.getParameter("codArticuloProducto" + i))));
                        objCompraDetalle.setCantidad(Integer.parseInt(request.getParameter("cantidad" + i)));
                        objCompraDetalle.setDescripcion(objCompraDetalle.getArticuloProducto().getDescripcion());
                        objCompraDetalle.setPrecioUnitario(Double.parseDouble(request.getParameter("precioUnitario" + i)));
                        objCompraDetalle.setPrecioTotal(objCompraDetalle.getCantidad() * objCompraDetalle.getPrecioUnitario()); //cantidad * PU
                        objCompraDetalle.setItem(i);
                        objCompraDetalle.setAlmacen(objcAlmacen.leer_cod(1));   // toda compra se ingresara al almacen principal.
                        objCompraDetalle.setDetalle(request.getParameter("detalle" + i) != null ? (request.getParameter("detalles" + i).equals("") ? "Sin datos" : request.getParameter("detalle" + i)) : "Sin datos");
                        objCompraDetalle.setRegistro(objcUtilitarios.registro("1", objUsuario.getCodUsuario().toString()));
                        objCompra.setSubTotal(objCompra.getSubTotal() + objCompraDetalle.getPrecioTotal()); //vamos sumando los precios
                        compraDetalleList.add(objCompraDetalle);//asiganmos el detalle a la lista
                        //guardar S/N para cada item del articulo
                        List lCompraSerieNumeroNuevoItem = new ArrayList();    //lista que contendra objetos CompraSerieNumero
                        List lKardexSerieNumeroNuevoItem = new ArrayList();    //lista que contendra objetos KardexSerieNumero
                        if (objCompraDetalle.getArticuloProducto().getUsarSerieNumero()) {

                            for (int j = 1; j <= objCompraDetalle.getCantidad(); j++) {
                                //para t_compraSerieNumero
                                CompraSerieNumero objCompraSerieNumero = new CompraSerieNumero();
                                objCompraSerieNumero.setSerieNumero(request.getParameter("item" + i + "SerieNumero" + j));
                                objCompraSerieNumero.setObservacion(request.getParameter("item" + i + "SerieNumeroObservacion" + j));
                                objCompraSerieNumero.setRegistro(objcUtilitarios.registro("1", objUsuario.getCodUsuario().toString()));
                                lCompraSerieNumeroNuevoItem.add(objCompraSerieNumero);
                                //para t_kardexSerieNuemro
                                KardexSerieNumero objKardexSerieNumeroItem = new KardexSerieNumero();
                                objKardexSerieNumeroItem.setSerieNumero(request.getParameter("item" + i + "SerieNumero" + j));
                                objKardexSerieNumeroItem.setObservacion(request.getParameter("item" + i + "SerieNumeroObservacion" + j));
                                objKardexSerieNumeroItem.setRegistro(objcUtilitarios.registro("1", objUsuario.getCodUsuario().toString()));
                                lKardexSerieNumeroNuevoItem.add(objKardexSerieNumeroItem);
                            }
                        }
                        compraSerieNumeroNuevoList.add(lCompraSerieNumeroNuevoItem);//asignamos lista lCompraSerieNumeroNuevo, aun así este no tenga datos
                        kardexSerieNumeroNuevoList.add(lKardexSerieNumeroNuevoItem);//asignamos lista lKardexSerieNumeroNuevo, aun así este no tenga datos
                    }//fin for lCompraDetalle.add(objCompraDetalle);
                    objCompra.setTotal(objCompra.getSubTotal() - descuento);
                    objCompra.setMontoIgv(objCompra.getTotal() * igv);
                    objCompra.setNeto(objCompra.getTotal() + objCompra.getMontoIgv());
                    objCompra.setSon(objcNumeroLetra.importeNumeroALetra(String.valueOf(objcUtilitarios.redondearDecimales(objCompra.getNeto(), 2)), true));
                    // fin de recojo de datos para una compra
                    //inicio de proceso de grabacion
                    codCompra = new cCompra().Crear(objCompra);    // se registra la compra
                    if (codCompra != 0) {
                        objCompra.setCodCompra(codCompra);  //actualizamos el objeto compra
                        for (int i = 0; i < compraDetalleList.size(); i++) {   //comenzamos a a registrar las comprasDetalles recorriendo la lista
                            CompraDetalle objCompraDetalle = (CompraDetalle) compraDetalleList.get(i); //cogemos cada detalle
                            objCompraDetalle.setCompra(objCompra);  //agregamos el idCompra a la t_compra_detalle, para ellos se agrega todo el objeto
                            int codCompraDetalle = objcCompraDetalle.Crear(objCompraDetalle); //registramos compraDetalle
                            objCompraDetalle.setCodCompraDetalle(codCompraDetalle); //seteamos el codCompraDetalle

                            KardexArticuloProducto objKardexArticuloProducto = new KardexArticuloProducto();    //creamos nueva variable para subir los datos del nuevo kardex
                            //precio sugerido de venta
//                            PrecioVenta objPrecioVenta = new PrecioVenta();
                            objKardexArticuloProducto.setArticuloProducto(objCompraDetalle.getArticuloProducto());
                            objKardexArticuloProducto.setCodOperacion(objCompra.getCodCompra());
                            objKardexArticuloProducto.setCodOperacionDetalle(objCompraDetalle.getCodCompraDetalle());
                            System.out.println(objCompraDetalle.getCodCompraDetalle());
                            objKardexArticuloProducto.setTipoOperacion(1);
                            objKardexArticuloProducto.setDetalle("C/" + objCompra.getTipo() + " " + objCompra.getProveedor().getRazonSocial());
                            objKardexArticuloProducto.setEntrada(objCompraDetalle.getCantidad());
                            objKardexArticuloProducto.setSalida(0);
                            objKardexArticuloProducto.setPrecio(objCompraDetalle.getPrecioUnitario());
                            //tendremos dos situacion para Kardex.
                            KardexArticuloProducto objKardexArticuloProducto1 = objcKardexArticuloProducto.leer_articuloProductoStock(objCompraDetalle.getArticuloProducto().getCodArticuloProducto(), objCompraDetalle.getAlmacen().getCodAlmacen());
                            List lKardexSerieNumeroStock = new ArrayList();
                            if (objKardexArticuloProducto1 == null) {   // si se ingresa por primera vez el articulo
                                objKardexArticuloProducto.setStock(objKardexArticuloProducto.getEntrada()); //igual a los articulos que entran
                                objKardexArticuloProducto.setPrecioPonderado(objCompraDetalle.getPrecioUnitario());
                            } else {    // en caso haya kardex en t_kap
                                //leemos las series en stock
                                lKardexSerieNumeroStock = objcKardexSerieNumero.leer_por_codKardexArticuloProducto(objKardexArticuloProducto1.getCodKardexArticuloProducto());
                                objKardexArticuloProducto.setStock(objKardexArticuloProducto1.getStock() + objKardexArticuloProducto.getEntrada());
                                objKardexArticuloProducto.setPrecioPonderado((objKardexArticuloProducto1.getTotal() + objKardexArticuloProducto.getEntrada() * objKardexArticuloProducto.getPrecio()) / objKardexArticuloProducto.getStock());

                            }
                            objKardexArticuloProducto.setTotal(objKardexArticuloProducto.getPrecioPonderado() * objKardexArticuloProducto.getStock());
                            objKardexArticuloProducto.setAlmacen(objCompraDetalle.getAlmacen());
                            objKardexArticuloProducto.setRegistro(objcUtilitarios.registro("1", objUsuario.getCodUsuario().toString()));
                            int codKardexArticuloProducto = objcKardexArticuloProducto.crear(objKardexArticuloProducto);
                            objKardexArticuloProducto.setCodKardexArticuloProducto(codKardexArticuloProducto);
                            //iniciamos la grabacion de las serie tanto para tabla kardex como kdsn
//                            if (codCompraDetalle != 0) {

                            //inicio de regsitro de series numero
                            List lCompraSNItem = (List) compraSerieNumeroNuevoList.get(i); //lCompraDetalleSN contendra objetos de tipo Compra Serie numero
                            List lKardexSNItem = (List) kardexSerieNumeroNuevoList.get(i);
                            for (int j = 0; j < lCompraSNItem.size(); j++) {
                                CompraSerieNumero objCompraSerieNumero = (CompraSerieNumero) lCompraSNItem.get(j);
                                objCompraSerieNumero.setCompraDetalle(objCompraDetalle);
                                int codCompraSerieNumero = objcCompraSerieNumero.crear(objCompraSerieNumero);

                                KardexSerieNumero objKardexSerieNumero = (KardexSerieNumero) lKardexSNItem.get(j);
                                objKardexSerieNumero.setKardexArticuloProducto(objKardexArticuloProducto);
                                objKardexSerieNumero.setCompraSerieNumeroCodCompraSerieNumero(codCompraSerieNumero);
                                objcKardexSerieNumero.crear(objKardexSerieNumero);
                            }//fin de registro de SN para cada compra detalle

//                            if (codKardexArticuloProducto != 0) {
                            objKardexArticuloProducto.setCodKardexArticuloProducto(codKardexArticuloProducto);
                            // registramos series iniciando por los que hay en la BD
                            for (int j = 0; j < lKardexSerieNumeroStock.size(); j++) {
                                KardexSerieNumero objKardexSerieNumero = (KardexSerieNumero) lKardexSerieNumeroStock.get(j);//recuperamos de la lista
                                objKardexSerieNumero.setKardexArticuloProducto(objKardexArticuloProducto);
                                objKardexSerieNumero.setRegistro(objcUtilitarios.registro("1", objUsuario.getCodUsuario().toString()));
                                objcKardexSerieNumero.crear(objKardexSerieNumero);
                            }
                            //registramos el precio de venta para cada articulo comprado
                            if (objCompraDetalle.getArticuloProducto().getPrecioVentaRango() == 0) {
                                Double auxPrecioVenta = objCompraDetalle.getPrecioUnitario() * 1.3;
                                if (auxPrecioVenta > objCompraDetalle.getArticuloProducto().getPrecioVenta()) {//si en caso el precio sea mayor
                                    //actualizamos el precio en el articulo

                                    objcArticuloProducto.actualizar_precio_venta(objCompraDetalle.getArticuloProducto().getCodArticuloProducto(), auxPrecioVenta, 0);
                                    //creamos registro de venta
                                    PrecioVenta objPrecioVenta = new PrecioVenta();
                                    objPrecioVenta.setCodCompraDetalle(objCompraDetalle.getCodCompraDetalle());
                                    objPrecioVenta.setPrecioVenta(auxPrecioVenta);
                                    objPrecioVenta.setObservacion("Actualización de PV(" + objcUtilitarios.agregarCerosNumeroFormato(objcUtilitarios.redondearDecimales(objCompraDetalle.getPrecioUnitario(), 2), 2) + ") en tArticuloProducto con Compra reciente");
                                    objPrecioVenta.setArticuloProducto(objCompraDetalle.getArticuloProducto());
                                    objPrecioVenta.setRegistro(objcUtilitarios.registro("1", objUsuario.getCodUsuario().toString()));
                                    objcPrecioVenta.Crear(objPrecioVenta);
                                } else {
                                    PrecioVenta objPrecioVenta = new PrecioVenta();
                                    objPrecioVenta.setCodCompraDetalle(objCompraDetalle.getCodCompraDetalle());
                                    objPrecioVenta.setPrecioVenta(auxPrecioVenta);
                                    objPrecioVenta.setObservacion("No se actualiza PV(" + objcUtilitarios.agregarCerosNumeroFormato(objcUtilitarios.redondearDecimales(objCompraDetalle.getPrecioUnitario(), 2), 2) + ")");
                                    objPrecioVenta.setArticuloProducto(objCompraDetalle.getArticuloProducto());
                                    objPrecioVenta.setRegistro(objcUtilitarios.registro("1", objUsuario.getCodUsuario().toString()));
                                    objcPrecioVenta.Crear(objPrecioVenta);
                                }
                            }
                        }
                        out.print(codCompra);
                    } else {
                        out.print("Error en registro de la compra ver detalles de error con el administrador: " + new cCompra().error);
                    }
                } catch (NumberFormatException e) {
                    out.print("Error en parámetros. " + e.getMessage());
                }
            }
            if (accion.equals("r")) {
                try {
                    Compra objCompra = new Compra();
                    objCompra.setProveedor(objcProveedor.leer_cod(Integer.parseInt(request.getParameter("codProveedor"))));
                    objCompra.setTipo(request.getParameter("tipo").toString().equals("0") ? "Contado" : "Crédito");
                    objCompra.setItemCantidad(Integer.parseInt(request.getParameter("itemCantidad")));  //cantidad de item's comprados
                    objCompra.setDocSerieNumero(request.getParameter("docSerieNumero"));
                    objCompra.setFechaFactura(objcManejoFechas.caracterADate(request.getParameter("fechaFactura")));
                    objCompra.setFechaVencimiento(objcManejoFechas.caracterADate(request.getParameter("fechaVencimiento")));
                    objCompra.setFechaLlegada(objcManejoFechas.caracterADate(request.getParameter("fechaLlegada")));
                    objCompra.setRegistro(objcUtilitarios.registro("1", objUsuario.getCodUsuario().toString()));    //recogemos los datos para la columna registro.
                    objCompra.setObservacion(request.getParameter("observacion"));
                    objCompra.setMoneda(request.getParameter("moneda").equals("0") ? "Soles" : "Dólares");
                    double descuento = Double.parseDouble(request.getParameter("descuento") != null
                            ? (request.getParameter("descuento").equals("") ? "0.0000" : request.getParameter("descuento")) : "0.0000");
                    double igv = 0;
                    codCompra = 0;
                    //listas
                    List compraDetalleList = new ArrayList();
                    List compraSerieNumeroNuevoList = new ArrayList(); //lista que contendra las lsitas para cada uno de los items
                    List kardexSerieNumeroNuevoList = new ArrayList();
                    for (int i = 1; i <= objCompra.getItemCantidad(); i++) {
                        CompraDetalle objCompraDetalle = new CompraDetalle();
                        objCompraDetalle.setArticuloProducto(objcArticuloProducto.leer_cod(Integer.parseInt(request.getParameter("codArticuloProducto" + i))));
                        objCompraDetalle.setCantidad(Integer.parseInt(request.getParameter("cantidad" + i)));
                        objCompraDetalle.setDescripcion(objCompraDetalle.getArticuloProducto().getDescripcion());
                        objCompraDetalle.setPrecioUnitario(Double.parseDouble(request.getParameter("precioUnitario" + i)));
                        objCompraDetalle.setPrecioTotal(objCompraDetalle.getCantidad() * objCompraDetalle.getPrecioUnitario()); //cantidad * PU
                        objCompraDetalle.setItem(i);
                        objCompraDetalle.setAlmacen(objcAlmacen.leer_cod(1));   // toda compra se ingresara al almacen principal.
                        objCompraDetalle.setDetalle(request.getParameter("detalle" + i) != null ? (request.getParameter("detalles" + i).equals("") ? "Sin datos" : request.getParameter("detalle" + i)) : "Sin datos");
                        objCompraDetalle.setRegistro(objcUtilitarios.registro("1", objUsuario.getCodUsuario().toString()));
                        objCompra.setSubTotal(objCompra.getSubTotal() + objCompraDetalle.getPrecioTotal()); //vamos sumando los precios
                        compraDetalleList.add(objCompraDetalle);//asiganmos el detalle a la lista
                        //guardar S/N para cada item del articulo
                        List lCompraSerieNumeroNuevoItem = new ArrayList();    //lista que contendra objetos CompraSerieNumero
                        List lKardexSerieNumeroNuevoItem = new ArrayList();    //lista que contendra objetos KardexSerieNumero
                        if (objCompraDetalle.getArticuloProducto().getUsarSerieNumero()) {

                            for (int j = 1; j <= objCompraDetalle.getCantidad(); j++) {
                                //para t_compraSerieNumero
                                CompraSerieNumero objCompraSerieNumero = new CompraSerieNumero();
                                objCompraSerieNumero.setSerieNumero(request.getParameter("item" + i + "SerieNumero" + j));
                                objCompraSerieNumero.setObservacion(request.getParameter("item" + i + "SerieNumeroObservacion" + j));
                                objCompraSerieNumero.setRegistro(objcUtilitarios.registro("1", objUsuario.getCodUsuario().toString()));
                                lCompraSerieNumeroNuevoItem.add(objCompraSerieNumero);
                                //para t_kardexSerieNuemro
                                KardexSerieNumero objKardexSerieNumeroItem = new KardexSerieNumero();
                                objKardexSerieNumeroItem.setSerieNumero(request.getParameter("item" + i + "SerieNumero" + j));
                                objKardexSerieNumeroItem.setObservacion(request.getParameter("item" + i + "SerieNumeroObservacion" + j));
                                objKardexSerieNumeroItem.setRegistro(objcUtilitarios.registro("1", objUsuario.getCodUsuario().toString()));
                                lKardexSerieNumeroNuevoItem.add(objKardexSerieNumeroItem);
                            }
                        }
                        compraSerieNumeroNuevoList.add(lCompraSerieNumeroNuevoItem);//asignamos lista lCompraSerieNumeroNuevo, aun así este no tenga datos
                        kardexSerieNumeroNuevoList.add(lKardexSerieNumeroNuevoItem);//asignamos lista lKardexSerieNumeroNuevo, aun así este no tenga datos
                    }//fin for lCompraDetalle.add(objCompraDetalle);
                    objCompra.setTotal(objCompra.getSubTotal() - descuento);
                    objCompra.setMontoIgv(objCompra.getTotal() * igv);
                    objCompra.setNeto(objCompra.getTotal() + objCompra.getMontoIgv());
                    objCompra.setSon(objcNumeroLetra.importeNumeroALetra(String.valueOf(objcUtilitarios.redondearDecimales(objCompra.getNeto(), 2)), true));
                    // fin de recojo de datos para una compra
                    //inicio de proceso de grabacion
                    codCompra = new cCompra().Crear(objCompra);    // se registra la compra
                    if (codCompra != 0) {
                        objCompra.setCodCompra(codCompra);  //actualizamos el objeto compra
                        for (int i = 0; i < compraDetalleList.size(); i++) {   //comenzamos a a registrar las comprasDetalles recorriendo la lista
                            CompraDetalle objCompraDetalle = (CompraDetalle) compraDetalleList.get(i); //cogemos cada detalle
                            objCompraDetalle.setCompra(objCompra);  //agregamos el idCompra a la t_compra_detalle, para ellos se agrega todo el objeto
                            int codCompraDetalle = objcCompraDetalle.Crear(objCompraDetalle); //registramos compraDetalle
                            objCompraDetalle.setCodCompraDetalle(codCompraDetalle); //seteamos el codCompraDetalle

                            KardexArticuloProducto objKardexArticuloProducto = new KardexArticuloProducto();    //creamos nueva variable para subir los datos del nuevo kardex
                            //precio sugerido de venta
//                            PrecioVenta objPrecioVenta = new PrecioVenta();
                            objKardexArticuloProducto.setArticuloProducto(objCompraDetalle.getArticuloProducto());
                            objKardexArticuloProducto.setCodOperacion(objCompra.getCodCompra());
                            objKardexArticuloProducto.setCodOperacionDetalle(objCompraDetalle.getCodCompraDetalle());
                            System.out.println(objCompraDetalle.getCodCompraDetalle());
                            objKardexArticuloProducto.setTipoOperacion(1);
                            objKardexArticuloProducto.setDetalle("C/" + objCompra.getTipo() + " " + objCompra.getProveedor().getRazonSocial());
                            objKardexArticuloProducto.setEntrada(objCompraDetalle.getCantidad());
                            objKardexArticuloProducto.setSalida(0);
                            objKardexArticuloProducto.setPrecio(objCompraDetalle.getPrecioUnitario());
                            //tendremos dos situacion para Kardex.
                            KardexArticuloProducto objKardexArticuloProducto1 = objcKardexArticuloProducto.leer_articuloProductoStock(objCompraDetalle.getArticuloProducto().getCodArticuloProducto(), objCompraDetalle.getAlmacen().getCodAlmacen());
                            List lKardexSerieNumeroStock = new ArrayList();
                            if (objKardexArticuloProducto1 == null) {   // si se ingresa por primera vez el articulo
                                objKardexArticuloProducto.setStock(objKardexArticuloProducto.getEntrada()); //igual a los articulos que entran
                                objKardexArticuloProducto.setPrecioPonderado(objCompraDetalle.getPrecioUnitario());
                            } else {    // en caso haya kardex en t_kap
                                //leemos las series en stock
                                lKardexSerieNumeroStock = objcKardexSerieNumero.leer_por_codKardexArticuloProducto(objKardexArticuloProducto1.getCodKardexArticuloProducto());
                                objKardexArticuloProducto.setStock(objKardexArticuloProducto1.getStock() + objKardexArticuloProducto.getEntrada());
                                objKardexArticuloProducto.setPrecioPonderado((objKardexArticuloProducto1.getTotal() + objKardexArticuloProducto.getEntrada() * objKardexArticuloProducto.getPrecio()) / objKardexArticuloProducto.getStock());

                            }
                            objKardexArticuloProducto.setTotal(objKardexArticuloProducto.getPrecioPonderado() * objKardexArticuloProducto.getStock());
                            objKardexArticuloProducto.setAlmacen(objCompraDetalle.getAlmacen());
                            objKardexArticuloProducto.setRegistro(objcUtilitarios.registro("1", objUsuario.getCodUsuario().toString()));
                            int codKardexArticuloProducto = objcKardexArticuloProducto.crear(objKardexArticuloProducto);
                            objKardexArticuloProducto.setCodKardexArticuloProducto(codKardexArticuloProducto);
                            //iniciamos la grabacion de las serie tanto para tabla kardex como kdsn
//                            if (codCompraDetalle != 0) {

                            //inicio de regsitro de series numero
                            List lCompraSNItem = (List) compraSerieNumeroNuevoList.get(i); //lCompraDetalleSN contendra objetos de tipo Compra Serie numero
                            List lKardexSNItem = (List) kardexSerieNumeroNuevoList.get(i);
                            for (int j = 0; j < lCompraSNItem.size(); j++) {
                                CompraSerieNumero objCompraSerieNumero = (CompraSerieNumero) lCompraSNItem.get(j);
                                objCompraSerieNumero.setCompraDetalle(objCompraDetalle);
                                int codCompraSerieNumero = objcCompraSerieNumero.crear(objCompraSerieNumero);

                                KardexSerieNumero objKardexSerieNumero = (KardexSerieNumero) lKardexSNItem.get(j);
                                objKardexSerieNumero.setKardexArticuloProducto(objKardexArticuloProducto);
                                objKardexSerieNumero.setCompraSerieNumeroCodCompraSerieNumero(codCompraSerieNumero);
                                objcKardexSerieNumero.crear(objKardexSerieNumero);
                            }//fin de registro de SN para cada compra detalle

//                            if (codKardexArticuloProducto != 0) {
                            objKardexArticuloProducto.setCodKardexArticuloProducto(codKardexArticuloProducto);
                            // registramos series iniciando por los que hay en la BD
                            for (int j = 0; j < lKardexSerieNumeroStock.size(); j++) {
                                KardexSerieNumero objKardexSerieNumero = (KardexSerieNumero) lKardexSerieNumeroStock.get(j);//recuperamos de la lista
                                objKardexSerieNumero.setKardexArticuloProducto(objKardexArticuloProducto);
                                objKardexSerieNumero.setRegistro(objcUtilitarios.registro("1", objUsuario.getCodUsuario().toString()));
                                objcKardexSerieNumero.crear(objKardexSerieNumero);
                            }
                            //registramos el precio de venta para cada articulo comprado
                            if (objCompraDetalle.getArticuloProducto().getPrecioVentaRango() == 0) {
                                Double auxPrecioVenta = objCompraDetalle.getPrecioUnitario() * 1.3;
                                if (auxPrecioVenta > objCompraDetalle.getArticuloProducto().getPrecioVenta()) {//si en caso el precio sea mayor
                                    //actualizamos el precio en el articulo

                                    objcArticuloProducto.actualizar_precio_venta(objCompraDetalle.getArticuloProducto().getCodArticuloProducto(), auxPrecioVenta, 0);
                                    //creamos registro de venta
                                    PrecioVenta objPrecioVenta = new PrecioVenta();
                                    objPrecioVenta.setCodCompraDetalle(objCompraDetalle.getCodCompraDetalle());
                                    objPrecioVenta.setPrecioVenta(auxPrecioVenta);
                                    objPrecioVenta.setObservacion("Actualización de PV(" + objcUtilitarios.agregarCerosNumeroFormato(objcUtilitarios.redondearDecimales(objCompraDetalle.getPrecioUnitario(), 2), 2) + ") en tArticuloProducto con Compra reciente");
                                    objPrecioVenta.setArticuloProducto(objCompraDetalle.getArticuloProducto());
                                    objPrecioVenta.setRegistro(objcUtilitarios.registro("1", objUsuario.getCodUsuario().toString()));
                                    objcPrecioVenta.Crear(objPrecioVenta);
                                } else {
                                    PrecioVenta objPrecioVenta = new PrecioVenta();
                                    objPrecioVenta.setCodCompraDetalle(objCompraDetalle.getCodCompraDetalle());
                                    objPrecioVenta.setPrecioVenta(auxPrecioVenta);
                                    objPrecioVenta.setObservacion("No se actualiza PV(" + objcUtilitarios.agregarCerosNumeroFormato(objcUtilitarios.redondearDecimales(objCompraDetalle.getPrecioUnitario(), 2), 2) + ")");
                                    objPrecioVenta.setArticuloProducto(objCompraDetalle.getArticuloProducto());
                                    objPrecioVenta.setRegistro(objcUtilitarios.registro("1", objUsuario.getCodUsuario().toString()));
                                    objcPrecioVenta.Crear(objPrecioVenta);
                                }
                            }
                        }
                        out.print(codCompra);
                    } else {
                        out.print("Error en registro de la compra ver detalles de error con el administrador: " + new cCompra().error);
                    }
                } catch (NumberFormatException e) {
                    out.print("Error en parámetros. " + e.getMessage());
                }
            }
        }

    }

    // <editor-fold defaultstate="collapsed" desc="HttpServlet methods. Click on the + sign on the left to edit the code.">
    /**
     * Handles the HTTP <code>GET</code> method.
     *
     * @param request servlet request
     * @param response servlet response
     * @throws ServletException if a servlet-specific error occurs
     * @throws IOException if an I/O error occurs
     */
    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        processRequest(request, response);
    }

    /**
     * Handles the HTTP <code>POST</code> method.
     *
     * @param request servlet request
     * @param response servlet response
     * @throws ServletException if a servlet-specific error occurs
     * @throws IOException if an I/O error occurs
     */
    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        processRequest(request, response);
    }

    /**
     * Returns a short description of the servlet.
     *
     * @return a String containing servlet description
     */
    @Override
    public String getServletInfo() {
        return "Short description";
    }// </editor-fold>
}
