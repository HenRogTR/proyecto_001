/*
 * To change this template, choose Tools | Templates
 * and open the template in the editor.
 */
package ventaServlets;

import articuloProductoClases.cArticuloProducto;
import articuloProductoClases.cKardexArticuloProducto;
import articuloProductoClases.cKardexSerieNumero;
import compraClases.cAlmacen;
import java.io.IOException;
import java.io.PrintWriter;
import java.util.ArrayList;
import java.util.Date;
import java.util.Iterator;
import java.util.List;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;
import otrasTablasClases.cDatosExtras;
import personaClases.cPersona;
import tablas.Almacen;
import tablas.KardexArticuloProducto;
import tablas.KardexSerieNumero;
import tablas.Usuario;
import tablas.VentaCredito;
import tablas.VentaCreditoLetra;
import tablas.Ventas;
import tablas.VentasDetalle;
import tablas.VentasSerieNumero;
import utilitarios.cManejoFechas;
import utilitarios.cNumeroLetra;
import utilitarios.cOtros;
import ventaClases.cVenta;
import ventaClases.cVentaCredito;
import ventaClases.cVentaCreditoLetra;
import ventaClases.cVentasDetalle;
import ventaClases.cVentasSerieNumero;

/**
 *
 * @author Henrri
 */
@WebServlet(name = "sVenta", urlPatterns = {"/sVenta"})
public class sVenta extends HttpServlet {

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

        HttpSession session = request.getSession();
        Usuario objUsuario = (Usuario) session.getAttribute("usuario");
        if (objUsuario == null) {
            out.print("No ha iniciado sesión.");
            return;
        }
        //validar usuario y permisos respectivos        
        String accion = request.getParameter("accionVenta");

        int codVenta = 0;

        cKardexArticuloProducto objcKardexArticuloProducto = new cKardexArticuloProducto();
        cKardexSerieNumero objcKardexSerieNumero = new cKardexSerieNumero();
        Almacen objAlmacen = new cAlmacen().leer_cod(1);
        cOtros objcOtros = new cOtros();
        cVenta objcVenta = new cVenta();
        cVentasDetalle objcVentasDetalle = new cVentasDetalle();

        if (accion == null) {
            session.removeAttribute("codVentaMantenimiento");
            response.sendRedirect("ventas/ventaMantenimiento.jsp");
        } else {
            if (accion.equals("mantenimiento")) {
                session.removeAttribute("codVentaMantenimiento");
                try {
                    codVenta = Integer.parseInt(request.getParameter("codVenta"));
                    session.setAttribute("codVentaMantenimiento", codVenta);
                } catch (Exception e) {
                }
                response.sendRedirect("ventas/ventaMantenimiento.jsp");
            }
            if (accion.equals("anular")) {
                if (!objUsuario.getP23()) {
                    out.print("No tiene permiso para esta operación. ");
                    return;
                }
                codVenta = Integer.parseInt(request.getParameter("codVenta"));
                Ventas objVentas = objcVenta.leer_cod(codVenta);
                if (objVentas.getRegistro().substring(0, 1).equals("0")) {
                    out.print("La venta ya se encuentra anulada.");
                    return;
                }
                /*en tabla ventas: sub_total, descuento, total, monto_igv, neto =0
                 * son = *** DOCUMENTO ANULADO ***
                 * registr=0??????
                 * T_ventaDetalle: valor venta=0
                 */
                if (objVentas.getTipo().equals("CONTADO")) {
                    List lVentasDetalle = objcVentasDetalle.leer_ventas_porCodVentas(codVenta);
                    Iterator iVentaDetalle = lVentasDetalle.iterator();
                    while (iVentaDetalle.hasNext()) {
                        VentasDetalle objVentaDetalle = (VentasDetalle) iVentaDetalle.next();
                        //kardex actual
                        KardexArticuloProducto objKardexArticuloProductoAlmacen = objcKardexArticuloProducto.leer_articuloProductoStock(objVentaDetalle.getArticuloProducto().getCodArticuloProducto(), objAlmacen.getCodAlmacen());
                        KardexArticuloProducto objKardexArticuloProductoNuevo = new KardexArticuloProducto();//a registrar
                        objKardexArticuloProductoNuevo.setArticuloProducto(new cArticuloProducto().leer_cod(objVentaDetalle.getArticuloProducto().getCodArticuloProducto()));
                        objKardexArticuloProductoNuevo.setCodOperacion(objVentaDetalle.getVentas().getCodVentas());
                        objKardexArticuloProductoNuevo.setCodOperacionDetalle(objVentaDetalle.getCodVentasDetalle());
                        objKardexArticuloProductoNuevo.setTipoOperacion(5);
                        objKardexArticuloProductoNuevo.setDetalle("REPOSICIÓN X ANULACIÓN " + objVentaDetalle.getVentas().getDocSerieNumero() + " " + objVentaDetalle.getVentas().getCliente());
                        objKardexArticuloProductoNuevo.setEntrada(objVentaDetalle.getCantidad());
                        objKardexArticuloProductoNuevo.setSalida(0);
                        objKardexArticuloProductoNuevo.setPrecio(objVentaDetalle.getPrecioVenta());
                        objKardexArticuloProductoNuevo.setStock(objKardexArticuloProductoAlmacen.getStock() + objKardexArticuloProductoNuevo.getEntrada());
                        objKardexArticuloProductoNuevo.setPrecioPonderado(objKardexArticuloProductoAlmacen.getPrecioPonderado());
                        objKardexArticuloProductoNuevo.setTotal(objKardexArticuloProductoNuevo.getPrecioPonderado() * objKardexArticuloProductoNuevo.getStock());
                        objKardexArticuloProductoNuevo.setAlmacen(objAlmacen);
                        objKardexArticuloProductoNuevo.setRegistro(objcOtros.registro("1", objUsuario.getCodUsuario().toString()));
                        int codKardexArticuloProducto = objcKardexArticuloProducto.crear(objKardexArticuloProductoNuevo);
                        //out.print(objKardexArticuloProductoNuevo.getDetalle());
                        if (codKardexArticuloProducto != 0) {
                            objKardexArticuloProductoNuevo.setCodKardexArticuloProducto(codKardexArticuloProducto);

                            //registramos las series en stock
                            for (KardexSerieNumero objKardexSerieNumero : objKardexArticuloProductoAlmacen.getKardexSerieNumeros()) {
                                objKardexSerieNumero.setCodKardexSerieNumero(null);
                                objKardexSerieNumero.setKardexArticuloProducto(objKardexArticuloProductoNuevo);
                                objKardexSerieNumero.setRegistro(objcOtros.registro("1", objUsuario.getCodUsuario().toString()));
                                objcKardexSerieNumero.crear(objKardexSerieNumero);
                            }

                            //registramos las series que se devuelven
                            for (VentasSerieNumero objVentasSerieNumero : objVentaDetalle.getVentasSerieNumeros()) {
                                KardexSerieNumero objKardexSerieNumeroReposicion = new KardexSerieNumero();
                                objKardexSerieNumeroReposicion.setKardexArticuloProducto(objKardexArticuloProductoNuevo);
                                objKardexSerieNumeroReposicion.setSerieNumero(objVentasSerieNumero.getSerieNumero());
                                objKardexSerieNumeroReposicion.setObservacion(objVentasSerieNumero.getObservacion());
                                objKardexSerieNumeroReposicion.setRegistro(objcOtros.registro("1", objUsuario.getCodUsuario().toString()));
                                objcKardexSerieNumero.crear(objKardexSerieNumeroReposicion);
                            }
                        }//fin de registros de series

                        //actualizar datos
                        objcVentasDetalle.actualizar_valorVenta(objVentaDetalle.getCodVentasDetalle(), 0.00);
                    }
                    objcVenta.actualizar_anularVenta(objVentas.getCodVentas(), 0.00, 0.00, 0.00, 0.00, 0.00, "*** DOCUMENTO ANULADO ***", objcOtros.registro("0", objUsuario.getCodUsuario().toString()));
                    out.print(objVentas.getCodVentas());
                }//fin tipo de venta contado
                if (objVentas.getTipo().equals("CREDITO")) {
                    cVentaCredito objcVentaCredito = new cVentaCredito();
                    cVentaCreditoLetra objcVentaCreditoLetra = new cVentaCreditoLetra();
                    Boolean temLetraPagadas = true;
                    VentaCredito objVentaCreditoTemp = null;
                    for (VentaCredito objVentaCredito : objVentas.getVentaCreditos()) {
                        if (objVentaCredito.getRegistro().substring(0, 1).equals("1")) {
                            objVentaCreditoTemp = objVentaCredito;
                            for (VentaCreditoLetra objVentaCreditoLetra : objVentaCredito.getVentaCreditoLetras()) {
                                if (objVentaCreditoLetra.getTotalPago() > 0) {
                                    temLetraPagadas = false;
                                }
                            }
                        }
                    }
                    if (temLetraPagadas) {
                        //cambiar los datos antes vistos, ademas de poner en 0 las letras pendientes de pagos
                        //venta creditp, registro a 0 y todas las letras de credito a 0 en los registros.
                        objcVentaCredito.actualizar_registro(objVentaCreditoTemp.getCodVentaCredito(), "0", objUsuario.getCodUsuario().toString());
                        for (VentaCreditoLetra objVentaCreditoLetra : objVentaCreditoTemp.getVentaCreditoLetras()) {
                            objcVentaCreditoLetra.actualizar_registro(objVentaCreditoLetra.getCodVentaCreditoLetra(), "0", objUsuario.getCodUsuario().toString());
                        }

                        List lVentasDetalle = objcVentasDetalle.leer_ventas_porCodVentas(codVenta);
                        Iterator iVentaDetalle = lVentasDetalle.iterator();
                        while (iVentaDetalle.hasNext()) {
                            VentasDetalle objVentaDetalle = (VentasDetalle) iVentaDetalle.next();
                            //kardex actual
                            KardexArticuloProducto objKardexArticuloProductoAlmacen = objcKardexArticuloProducto.leer_articuloProductoStock(objVentaDetalle.getArticuloProducto().getCodArticuloProducto(), objAlmacen.getCodAlmacen());
                            KardexArticuloProducto objKardexArticuloProductoNuevo = new KardexArticuloProducto();//a registrar
                            objKardexArticuloProductoNuevo.setArticuloProducto(new cArticuloProducto().leer_cod(objVentaDetalle.getArticuloProducto().getCodArticuloProducto()));
                            objKardexArticuloProductoNuevo.setCodOperacion(objVentaDetalle.getVentas().getCodVentas());
                            objKardexArticuloProductoNuevo.setCodOperacionDetalle(objVentaDetalle.getCodVentasDetalle());
                            objKardexArticuloProductoNuevo.setTipoOperacion(5);
                            objKardexArticuloProductoNuevo.setDetalle("REPOSICIÓN X ANULACIÓN " + objVentaDetalle.getVentas().getDocSerieNumero() + " " + objVentaDetalle.getVentas().getCliente());
                            objKardexArticuloProductoNuevo.setEntrada(objVentaDetalle.getCantidad());
                            objKardexArticuloProductoNuevo.setSalida(0);
                            objKardexArticuloProductoNuevo.setPrecio(objVentaDetalle.getPrecioVenta());
                            objKardexArticuloProductoNuevo.setStock(objKardexArticuloProductoAlmacen.getStock() + objKardexArticuloProductoNuevo.getEntrada());
                            objKardexArticuloProductoNuevo.setPrecioPonderado(objKardexArticuloProductoAlmacen.getPrecioPonderado());
                            objKardexArticuloProductoNuevo.setTotal(objKardexArticuloProductoNuevo.getPrecioPonderado() * objKardexArticuloProductoNuevo.getStock());
                            objKardexArticuloProductoNuevo.setAlmacen(objAlmacen);
                            objKardexArticuloProductoNuevo.setRegistro(objcOtros.registro("1", objUsuario.getCodUsuario().toString()));
                            int codKardexArticuloProducto = objcKardexArticuloProducto.crear(objKardexArticuloProductoNuevo);
                            //out.print(objKardexArticuloProductoNuevo.getDetalle());
                            if (codKardexArticuloProducto != 0) {
                                objKardexArticuloProductoNuevo.setCodKardexArticuloProducto(codKardexArticuloProducto);

                                //registramos las series en stock
                                for (KardexSerieNumero objKardexSerieNumero : objKardexArticuloProductoAlmacen.getKardexSerieNumeros()) {
                                    objKardexSerieNumero.setCodKardexSerieNumero(null);
                                    objKardexSerieNumero.setKardexArticuloProducto(objKardexArticuloProductoNuevo);
                                    objKardexSerieNumero.setRegistro(objcOtros.registro("1", objUsuario.getCodUsuario().toString()));
                                    objcKardexSerieNumero.crear(objKardexSerieNumero);
                                }

                                //registramos las series que se devuelven
                                for (VentasSerieNumero objVentasSerieNumero : objVentaDetalle.getVentasSerieNumeros()) {
                                    KardexSerieNumero objKardexSerieNumeroReposicion = new KardexSerieNumero();
                                    objKardexSerieNumeroReposicion.setKardexArticuloProducto(objKardexArticuloProductoNuevo);
                                    objKardexSerieNumeroReposicion.setSerieNumero(objVentasSerieNumero.getSerieNumero());
                                    objKardexSerieNumeroReposicion.setObservacion(objVentasSerieNumero.getObservacion());
                                    objKardexSerieNumeroReposicion.setRegistro(objcOtros.registro("1", objUsuario.getCodUsuario().toString()));
                                    objcKardexSerieNumero.crear(objKardexSerieNumeroReposicion);
                                }
                            }//fin de registros de series
                            else {
                                out.print("Error en crer kardex:" + objcKardexArticuloProducto.getError());
                            }

                            //actualizar datos
                            objcVentasDetalle.actualizar_valorVenta(objVentaDetalle.getCodVentasDetalle(), 0.00);
                            objcVenta.actualizar_anularVenta(objVentas.getCodVentas(), 0.00, 0.00, 0.00, 0.00, 0.00, "*** DOCUMENTO ANULADO ***", objcOtros.registro("0", objUsuario.getCodUsuario().toString()));
                        }
                        out.print(objVentas.getCodVentas());
                    } else {
                        out.print("La venta contiene pagos realizados, elimine antes los pagos realizados.");
                    }
                }
            }
            if (accion.equals("registrar")) {
                try {
                    Ventas objVenta = new Ventas();
                    VentaCredito objVentaCredito = new VentaCredito();
                    //inicio recogiendo datos
                    objVenta.setPersona(new cPersona().leer_cod(Integer.parseInt(request.getParameter("codPersona"))));
                    objVenta.setItemCantidad(Integer.parseInt(request.getParameter("itemCantidad")));
                    objVenta.setDocSerieNumero(request.getParameter("docSerieNumero"));
                    objVenta.setTipo(request.getParameter("tipo").toString().toUpperCase());
                    objVenta.setFecha(new cManejoFechas().StringADate(request.getParameter("fecha")));
                    objVenta.setMoneda(request.getParameter("moneda").toString().toUpperCase());
                    objVenta.setSubTotal(0.00);
                    objVenta.setDescuento(Double.parseDouble(request.getParameter("descuento")));
                    objVenta.setTotal(0.00);
                    objVenta.setValorIgv(0.00);
                    objVenta.setNeto(0.00);
                    objVenta.setSon("");
                    objVenta.setPersonaCodVendedor(Integer.parseInt(request.getParameter("codVendedor")));
                    objVenta.setEstado(true);
                    objVenta.setCliente(objVenta.getPersona().getNombresC());
                    objVenta.setDireccion(objVenta.getPersona().getDireccion());
                    if (objVenta.getDocSerieNumero().substring(0, 1).equals("F")) {
                        objVenta.setIdentificacion(objVenta.getPersona().getRuc());
                    } else {
                        if (objVenta.getPersona().getDniPasaporte().equals("")) {
                            objVenta.setIdentificacion(objVenta.getPersona().getRuc());
                        } else {
                            objVenta.setIdentificacion(objVenta.getPersona().getDniPasaporte());
                        }
                    }
                    objVenta.setObservacion(request.getParameter("observacion").toString());
                    objVenta.setRegistro(new cOtros().registro("1", objUsuario.getCodUsuario().toString()));
                    objVenta.setDireccion2(new cDatosExtras().direccionEmpresa().getLetras().toUpperCase());
                    //en caso de ser credito
                    int cantidadLetras = Integer.parseInt(request.getParameter("cantidadLetras"));
                    Date fechaInicioLetras = new cManejoFechas().StringADate(request.getParameter("fechaInicioLetras"));
                    Double montoInicialLetra = Double.parseDouble(request.getParameter("montoInicialLetra"));
                    Date fechaVencimientoInicial = new cManejoFechas().StringADate(request.getParameter("fechaVencimientoInicial"));
                    String periodoLetra = request.getParameter("periodoLetra");

                    if (objcVenta.leer_docSerieNumero(objVenta.getDocSerieNumero()) != null) {
                        out.print("El documento ya se encuentra en uso");
                        return;
                    }
//
                    List ventaDetalleList = new ArrayList();
                    List controlStockList = new ArrayList();
                    List verificarSerieList = new ArrayList();
                    List ventaSerieNumeroList = new ArrayList();
                    List ventaCreditoLetraList = new ArrayList();
                    boolean continuarRegistro = true;
                    for (int i = 1; i <= objVenta.getItemCantidad(); i++) {
                        VentasDetalle objVentaDetalle = new VentasDetalle();
                        objVentaDetalle.setItem(i);
                        objVentaDetalle.setCantidad(Integer.parseInt(request.getParameter("cantidad" + i)));
                        objVentaDetalle.setPrecioProforma(Double.parseDouble(request.getParameter("precioContado" + i)));
                        objVentaDetalle.setPrecioVenta(Double.parseDouble(request.getParameter("precioVenta" + i)));
                        //viendo que no sea mayor el precio de proforma al precio de venta
                        if (objVentaDetalle.getPrecioProforma() > objVentaDetalle.getPrecioVenta()) {
                            objVentaDetalle.setPrecioProforma(objVentaDetalle.getPrecioVenta());
                        }
                        objVentaDetalle.setValorVenta(objVentaDetalle.getCantidad() * objVentaDetalle.getPrecioVenta());
                        objVentaDetalle.setArticuloProducto(new cArticuloProducto().leer_cod(Integer.parseInt(request.getParameter("codArticuloProducto" + i))));
                        objVentaDetalle.setPrecioReal(objVentaDetalle.getArticuloProducto().getPrecioVenta());
                        objVentaDetalle.setDescripcion(objVentaDetalle.getArticuloProducto().getDescripcion());
                        objVentaDetalle.setRegistro(objcOtros.registro("1", objUsuario.getCodUsuario().toString()));
//
                        objVenta.setSubTotal(objVenta.getSubTotal() + objVentaDetalle.getValorVenta()); //vamos sumando los precios
                        objVenta.setTotal(objVenta.getSubTotal() - objVenta.getDescuento());
                        objVenta.setValorIgv(objVenta.getTotal() * objVenta.getValorIgv());
                        objVenta.setNeto(objVenta.getTotal() + objVenta.getValorIgv());
                        ventaDetalleList.add(objVentaDetalle);
//
                        KardexArticuloProducto objKardexArticuloProducto = objcKardexArticuloProducto.leer_articuloProductoStock(objVentaDetalle.getArticuloProducto().getCodArticuloProducto(), objAlmacen.getCodAlmacen());
//                        //verificar que si hay stock cuando hay 2 ventas de el mismo aritculo
                        int marcador = 0;   //si ya se tiene dato del articulo actual
                        for (int a = 0; a < controlStockList.size(); a++) {    //todos los datos
                            int as[] = (int[]) controlStockList.get(a);
                            if (as[0] == objVentaDetalle.getArticuloProducto().getCodArticuloProducto()) {    // en caso ya este en el array
                                marcador = 1;   // se marca 1 para no registrar en el array
                                if (objVentaDetalle.getCantidad() <= as[1]) {  //si la cantidad es monor o igual al stock
                                    as[1] = as[1] - objVentaDetalle.getCantidad();//se actualiza el stock restante
                                } else {
                                    out.print("La cantidad a vender supera el stock actual: " + objVentaDetalle.getArticuloProducto().getDescripcion() + "  /// disponible ahora:" + objKardexArticuloProducto.getStock() + "<br>");
                                    continuarRegistro = false;
                                }
                            }
                        }
                        if (marcador == 0) {
                            int a[] = {objVentaDetalle.getArticuloProducto().getCodArticuloProducto(), objKardexArticuloProducto.getStock() - objVentaDetalle.getCantidad()};
                            controlStockList.add(a);
                        }
////                        //******series
                        List lVentaSerieNumeroItem = new ArrayList();
                        if (objVentaDetalle.getArticuloProducto().getUsarSerieNumero()) { //si en caso se maneje por series numeros
                            for (int j = 1; j <= objVentaDetalle.getCantidad(); j++) {//inicio para tomar cadad uno de las series
                                KardexSerieNumero objKardexSerieNumero = objcKardexSerieNumero.leer_codKardexSerieNumero(Integer.parseInt(request.getParameter("item" + i + "codKardexSerieNumero" + j)));
                                VentasSerieNumero objVentasSerieNumero = new VentasSerieNumero();
                                objVentasSerieNumero.setCodVentasSerieNumero(objKardexSerieNumero.getCodKardexSerieNumero());
                                objVentasSerieNumero.setSerieNumero(objKardexSerieNumero.getSerieNumero());
                                objVentasSerieNumero.setObservacion(objKardexSerieNumero.getObservacion());
                                objVentasSerieNumero.setRegistro(objcOtros.registro("1", objUsuario.getCodUsuario().toString()));
                                lVentaSerieNumeroItem.add(objVentasSerieNumero);
                                if (verificarSerieList.contains(objKardexSerieNumero.getCodKardexSerieNumero())) {
                                    out.print("Se esta intentando vender una misma serie (" + objKardexSerieNumero.getSerieNumero() + ")<br>");
                                    continuarRegistro = false;
                                } else {
                                    verificarSerieList.add(objKardexSerieNumero.getCodKardexSerieNumero());
                                }
                            }
                        }
                        ventaSerieNumeroList.add(lVentaSerieNumeroItem);//asi no naya series se registra
                    }
                    objVenta.setSon(new cNumeroLetra().importeNumeroALetra(new cOtros().decimalFormato(objVenta.getNeto(), 2), true));
                    //si en caso es al credito
                    if (objVenta.getTipo().equals("CREDITO")) {
                        Double neto = objVenta.getNeto();
                        Double montoLetra = objcOtros.redondearDecimales((neto - montoInicialLetra) / cantidadLetras, 1);
                        Double acumulado = 0.0;
//
                        objVentaCredito.setPersonaCodGarante(0);
                        objVentaCredito.setCantidadLetras(cantidadLetras);
                        objVentaCredito.setMontoInicial(montoInicialLetra);
                        objVentaCredito.setFechaInicial(fechaVencimientoInicial);
                        objVentaCredito.setEstado(true);
                        objVentaCredito.setDuracion(periodoLetra);
                        objVentaCredito.setFechaVencimientoLetra(fechaInicioLetras);
                        objVentaCredito.setRegistro(objcOtros.registro("1", objUsuario.getCodUsuario().toString()));
                        objVentaCredito.setMontoLetra(montoLetra);
                        for (int m = 0; m <= cantidadLetras; m++) {
                            VentaCreditoLetra objVentaCreditoLetra = new VentaCreditoLetra();
                            objVentaCreditoLetra.setTotalPago(0.00);
                            objVentaCreditoLetra.setMoneda(objVenta.getMoneda().equals("soles") ? 0 : 1);
                            objVentaCreditoLetra.setInteres(0.00);
                            objVentaCreditoLetra.setRegistro(objcOtros.registro("1", objUsuario.getCodUsuario().toString()));
                            if (m == 0) {
                                objVentaCreditoLetra.setNumeroLetra(m);
                                objVentaCreditoLetra.setDetalleLetra("Pago inicial");
                                objVentaCreditoLetra.setFechaVencimiento(fechaVencimientoInicial);
                                objVentaCreditoLetra.setMonto(montoInicialLetra);
                            } else {
                                objVentaCreditoLetra.setNumeroLetra(m);
                                if (periodoLetra.equals("mensual")) {
                                    objVentaCreditoLetra.setDetalleLetra("Letra N° " + m);
                                    objVentaCreditoLetra.setFechaVencimiento(new cManejoFechas().StringADate(new cManejoFechas().fechaSumarMes(fechaInicioLetras, m - 1)));
                                }
                                if (periodoLetra.equals("quincenal")) {
                                    objVentaCreditoLetra.setDetalleLetra("Letra N° " + m + " (Q)");
                                    objVentaCreditoLetra.setFechaVencimiento(new cManejoFechas().StringADate(new cManejoFechas().fechaSumarDias(fechaInicioLetras, (m * 14) - 14)));
                                }
                                if (periodoLetra.equals("semanal")) {
                                    objVentaCreditoLetra.setDetalleLetra("Letra N° " + m + " (S)");
                                    objVentaCreditoLetra.setFechaVencimiento(new cManejoFechas().StringADate(new cManejoFechas().fechaSumarDias(fechaInicioLetras, (m * 7) - 7)));
                                }
                                if (m == cantidadLetras) {
                                    Double ultimaLetra = neto - montoInicialLetra - acumulado;
                                    objVentaCreditoLetra.setMonto(ultimaLetra);
                                } else {
                                    objVentaCreditoLetra.setMonto(montoLetra);
                                }
                                acumulado += montoLetra;
                            }
                            ventaCreditoLetraList.add(objVentaCreditoLetra);
                        }
                    }
                    if (!continuarRegistro) {
                        return;
                    }
                    //--fin recogo datos
                    //**********************************************************
                    //iniciando grabacion
                    codVenta = objcVenta.crear(objVenta);
                    if (codVenta != 0) {
                        objVenta.setCodVentas(codVenta);
                        for (int i = 0; i < ventaDetalleList.size(); i++) {
                            VentasDetalle objVentaDetalle = (VentasDetalle) ventaDetalleList.get(i);
                            objVentaDetalle.setVentas(objVenta);
                            int codVentaDetalle = objcVentasDetalle.crear(objVentaDetalle);//registrar ventaDetalle
                            objVentaDetalle.setCodVentasDetalle(codVentaDetalle);//asignar al objeto
                            List lVentasDetalleSerieNumeroItem = (List) ventaSerieNumeroList.get(i);
                            List contenedorSerieItemList = new ArrayList();
                            for (int j = 0; j < lVentasDetalleSerieNumeroItem.size(); j++) {
                                VentasSerieNumero objVentasSerieNumero = (VentasSerieNumero) lVentasDetalleSerieNumeroItem.get(j);
                                objVentasSerieNumero.setVentasDetalle(objVentaDetalle);
                                contenedorSerieItemList.add(objVentasSerieNumero.getSerieNumero());
                                objVentasSerieNumero.setCodVentasSerieNumero(null);
                                int codVentasSerieNumero = new cVentasSerieNumero().crear(objVentasSerieNumero);
                            }
                            //===========actualizacion de los kardex
                            //kardex actual
                            KardexArticuloProducto objKardexArticuloProducto = objcKardexArticuloProducto.leer_articuloProductoStock(objVentaDetalle.getArticuloProducto().getCodArticuloProducto(), objAlmacen.getCodAlmacen());
                            KardexArticuloProducto objKardexAPNuevo = new KardexArticuloProducto();//nuevo kardex
                            objKardexAPNuevo.setArticuloProducto(new cArticuloProducto().leer_cod(objVentaDetalle.getArticuloProducto().getCodArticuloProducto()));
                            objKardexAPNuevo.setCodOperacion(objVenta.getCodVentas());
                            objKardexAPNuevo.setCodOperacionDetalle(objVentaDetalle.getCodVentasDetalle());
                            objKardexAPNuevo.setTipoOperacion(2);//ventas
                            objKardexAPNuevo.setDetalle("V/Crédito " + objVenta.getPersona().getNombresC());
                            objKardexAPNuevo.setEntrada(0);
                            objKardexAPNuevo.setSalida(objVentaDetalle.getCantidad());
                            objKardexAPNuevo.setStock(objKardexArticuloProducto.getStock() - objKardexAPNuevo.getSalida());
                            objKardexAPNuevo.setPrecio(objVentaDetalle.getPrecioVenta());
                            objKardexAPNuevo.setPrecioPonderado(objKardexArticuloProducto.getPrecioPonderado());
                            objKardexAPNuevo.setTotal(objKardexAPNuevo.getPrecioPonderado() * objKardexAPNuevo.getStock());
                            objKardexAPNuevo.setAlmacen(objAlmacen);
                            objKardexAPNuevo.setObservacion("");
                            objKardexAPNuevo.setRegistro(objcOtros.registro("1", objUsuario.getCodUsuario().toString()));
                            int codKardexAPNuevo = objcKardexArticuloProducto.crear(objKardexAPNuevo);//cerar kardex
                            objKardexAPNuevo.setCodKardexArticuloProducto(codKardexAPNuevo);

                            //******************las series
                            for (KardexSerieNumero objKardexSerieNumero : objKardexArticuloProducto.getKardexSerieNumeros()) {
                                System.out.println("Cant S/N vendidas para comparar=" + lVentasDetalleSerieNumeroItem.size());
                                int marcaSerie = 0;
//                                List lVentasDetalleSerieNumeroItem2 = (List) lVentasSerieNumero.get(i);
                                for (int j = 0; j < contenedorSerieItemList.size(); j++) {
                                    String tem = (String) contenedorSerieItemList.get(j);
                                    if (objKardexSerieNumero.getSerieNumero().equals(tem)) {
                                        marcaSerie = 1;
                                        contenedorSerieItemList.remove(j);//removemos de la lista si en caso es igual
                                    }
                                }
                                if (marcaSerie == 0) {
                                    objKardexSerieNumero.setCodKardexSerieNumero(null);
                                    objKardexSerieNumero.setKardexArticuloProducto(objKardexAPNuevo);
                                    objKardexSerieNumero.setRegistro(objcOtros.registro("1", objUsuario.getCodUsuario().toString()));
                                    objcKardexSerieNumero.crear(objKardexSerieNumero);
                                }
                            }
                        }
                        if (objVenta.getTipo().equals("CREDITO")) {
                            objVentaCredito.setVentas(objVenta);//asignamos a objeto 
                            int codVentaCredito = new cVentaCredito().Crear(objVentaCredito);
                            if (codVentaCredito != 0) {
                                objVentaCredito.setCodVentaCredito(codVentaCredito);
                                for (int i = 0; i < ventaCreditoLetraList.size(); i++) {
                                    VentaCreditoLetra objVentaCreditoLetra = (VentaCreditoLetra) ventaCreditoLetraList.get(i);
                                    objVentaCreditoLetra.setVentaCredito(objVentaCredito);
                                    int a = new cVentaCreditoLetra().crear(objVentaCreditoLetra);
                                }
                            }
                        }
                        out.print(codVenta);
                    } else {
                        out.print(objcVenta.getError());
                    }

                } catch (Exception e) {
                    out.print("Error en parametros");
                }
            }
            if (accion.equals("editar")) {
                try {

                } catch (Exception e) {
                    out.print("Error en parametros");
                }
            }
            if (accion.equals("guiaAdjuntar")) {
                if (!objUsuario.getP31()) {
                    out.print("No tiene permiso para esta operación.");
                    return;
                }
                codVenta = 0;
                String direccion2 = "";
                String direccion3 = "";
                String docSerieNumeroGuia = "";
                try {
                    codVenta = Integer.parseInt(request.getParameter("codVenta"));
                    direccion2 = request.getParameter("direccion2").toString();
                    direccion3 = request.getParameter("direccion3").toString();
                    docSerieNumeroGuia = request.getParameter("docSerieNumeroGuia").toString();
                } catch (Exception e) {
                    out.print("Error en parámetros.");
                    return;
                }
                //comprobar que la guia no este usada
                if (objcVenta.leer_docSerieNumeroGuia(docSerieNumeroGuia) != null) {
                    out.print("La guía ya se encuentra en uso.");
                    return;
                }
                if (objcVenta.actualizar_docSerieNumeroGuia(codVenta, direccion2, direccion3, docSerieNumeroGuia)) {
                    out.print(codVenta);
                } else {
                    out.print("Error al asiganr guia.");
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
