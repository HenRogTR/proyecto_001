/*
 * To change this template, choose Tools | Templates
 * and open the template in the editor.
 */
package cobranzaServlets;

import cobranzaClases.cCobranza;
import cobranzaClases.cCobranzaDetalle;
import cobranzaClases.cImprimirTicket;
import java.io.BufferedWriter;
import java.io.FileInputStream;
import java.io.FileNotFoundException;
import java.io.FileWriter;
import java.io.IOException;
import java.io.PrintWriter;
import java.util.Date;
import java.util.Iterator;
import java.util.List;
import javax.print.Doc;
import javax.print.DocFlavor;
import javax.print.DocPrintJob;
import javax.print.PrintService;
import javax.print.PrintServiceLookup;
import javax.print.SimpleDoc;
import javax.print.attribute.AttributeSet;
import javax.print.attribute.HashAttributeSet;
import javax.print.attribute.HashPrintRequestAttributeSet;
import javax.print.attribute.PrintRequestAttributeSet;
import javax.print.attribute.standard.ColorSupported;
import javax.print.attribute.standard.PrinterName;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;
import otrasTablasClases.cComprobantePago;
import otrasTablasClases.cComprobantePagoDetalle;
import otrasTablasClases.cDatosExtras;
import personaClases.cDatosCliente;
import tablas.Cobranza;
import tablas.CobranzaDetalle;
import tablas.ComprobantePago;
import tablas.ComprobantePagoDetalle;
import tablas.DatosCliente;
import tablas.DatosExtras;
import tablas.Persona;
import tablas.Usuario;
import tablas.VentaCreditoLetra;
import utilitarios.cManejoFechas;
import utilitarios.cNumeroLetra;
import utilitarios.cOtros;
import ventaClases.cVentaCreditoLetra;

/**
 *
 * @author Henrri
 */
@WebServlet(name = "sCobranza", urlPatterns = {"/sCobranza"})
public class sCobranza extends HttpServlet {

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

        cDatosCliente objcCliente = new cDatosCliente();
        cManejoFechas objcManejoFechas = new cManejoFechas();
        cOtros objcOtros = new cOtros();
        cComprobantePagoDetalle objcComprobantePagoDetalle = new cComprobantePagoDetalle();

        if (objUsuario == null) {
            out.print("No se ha iniciado sesión.");
            return;
        }

        String accion = request.getParameter("accionCobranza");
        if (accion == null) {
            out.print("Error en acción");
            return;
        }
        if (accion.equals("registrar")) {
            if (!objUsuario.getP35()) {
                out.print("No tiene permisos para esta acción.");
                return;
            }
            try {
                //iniciamos variables
                int codCliente = Integer.parseInt(request.getParameter("codCliente"));
                DatosCliente objCliente = objcCliente.leer_cod(codCliente);
                String tipoPago = request.getParameter("tipoPago").toString();
                String tipoCobro = request.getParameter("tipoCobro").toString();
                Double montoAmortizar = Double.parseDouble(request.getParameter("montoAmortizar"));
                Date fechaCobranza = objcManejoFechas.StringADate(request.getParameter("fechaCobranza"));
                int codVenta = Integer.parseInt(request.getParameter("codVenta"));
                String saldoFavorUsar = request.getParameter("saldoFavor").toString();
                //en caso de que el ingreso sea manual
                String docSerieNumero = "";
                String tipo = "R", serie = "";
                //el documento que se actualizará
                ComprobantePagoDetalle objCPD = null;
                //si se usa el saldo a favor
                if (saldoFavorUsar.equals("1")) {
                    //se asigna como documento
                    docSerieNumero = "XXX-999-111111";
                } else {
                    //si el cobro es manual se asigna lo ingresado, teniendo en cuenta el formato
                    if (tipoCobro.equals("manual")) {
                        docSerieNumero = request.getParameter("docSerieNumero");
                    } else {
                        //buscar el numero disponible siguiente//            
                        if (tipoCobro.equals("caja")) {
                            tipo = request.getParameter("docRecCaja").toString();
                            serie = request.getParameter("serieSelect").toString();
                        } else if (tipoCobro.equals("descuento")) {//buscar el siguiente teniendo en cuenta el codigo de cobranza
                            tipo = request.getParameter("docRecDesc").toString();
                            serie = request.getParameter("serie").toString();
                        }
                        ComprobantePago objCP = new cComprobantePago().leer_tipoSerie_SC(tipo, serie);
                        if (objCP == null) {
                            out.print("Serie no encontrada");
                            return;
                        }
                        objCPD = objcComprobantePagoDetalle.leer_disponible_SC(objCP.getCodComprobantePago());
                        if (objCPD == null) {
                            out.print("No hay documentos disponibles para esta serie. Genere nuevos.");
                            return;
                        }
                        docSerieNumero = objCPD.getDocSerieNumero();
                        //comprobar que no se repita;
                        int marca = 0;
                        while (marca == 0) { //hasta encontrar uno libre
                            Boolean tem = new cCobranza().siExiste_SC(objCPD.getDocSerieNumero());  //comprobamos si el obtenido no este registrado o marcado con check
                            if (tem) {  // si esta usado se busca el siguiente no usado
                                objCPD = new cComprobantePagoDetalle().leer_disponible_siguiente_SC(objCP.getCodComprobantePago(), objCPD.getCodComprobantePagoDetalle() + 1);
                                if (objCPD == null) {   // si en caso no hay ninguno se termina en bucle
                                    out.print("No hay documentos disponibles para esta serie. Genere nuevos.");
                                    return;
                                }
                            } else {
                                marca = 1;
                            }
                        }
                        docSerieNumero = objCPD.getDocSerieNumero();
                    }
                }
                //si el pago es anticipo
                if (tipoPago.equals("anticipo")) {
                    if (saldoFavorUsar.equals("0") & !tipoCobro.equals("manual")) {//que no sea un saldo a favor y que no sea manual
                        objcComprobantePagoDetalle.actualizar_estado(objCPD.getCodComprobantePagoDetalle(), true);
                    }
                    //datos de la persona
                    if (objcCliente.actualizar_saldoFavor(objCliente.getCodDatosCliente(), montoAmortizar)) {
                        Cobranza objCobranza = new Cobranza();
                        Persona objPersona = new Persona();
                        objPersona.setCodPersona(objCliente.getPersona().getCodPersona());
                        objCobranza.setPersona(objPersona);
                        objCobranza.setFechaCobranza(fechaCobranza);
                        objCobranza.setDocSerieNumero(docSerieNumero);
                        objCobranza.setSaldoAnterior(0.00);
                        objCobranza.setImporte(0.00);
                        objCobranza.setSaldo(montoAmortizar);
                        objCobranza.setMontoPagado(montoAmortizar);
                        objCobranza.setObservacion("Anticipo " + new cOtros().decimalFormato(montoAmortizar, 2));
                        objCobranza.setRegistro(objcOtros.registro("1", objUsuario.getCodUsuario().toString()));
                        int codCobranza = new cCobranza().crear(objCobranza);
                        if (codCobranza != 0) {
                            out.print(codCliente);
                        }
                    } else {
                        out.print("Error en registro contacte con el AD del sistema.");
                    }
                } else {//es un pago normal                    

                    String observacion = "";//para actualizar la observacion del objCobranza
                    Cobranza objCobranza = new Cobranza();
                    Persona objPersona = new Persona();
                    objPersona.setCodPersona(objCliente.getPersona().getCodPersona());
                    objCobranza.setPersona(objPersona);
                    objCobranza.setFechaCobranza(fechaCobranza);
                    objCobranza.setDocSerieNumero(docSerieNumero);
                    objCobranza.setSaldoAnterior(0.00);
                    objCobranza.setImporte(montoAmortizar);
                    objCobranza.setMontoPagado(montoAmortizar);
                    objCobranza.setSaldo(0.00);
                    objCobranza.setObservacion("");
                    objCobranza.setRegistro(objcOtros.registro("1", objUsuario.getCodUsuario().toString()));
                    Double deudaClientePorVenta = new cVentaCreditoLetra().leer_deudaCliente_codCliente_codVentas_SC(objCliente.getPersona().getCodPersona(), codVenta);
                    if (codVenta != 0 & deudaClientePorVenta == 0) {
                        out.print("El cliente no tiene deuda alguna, ingrese como anticipo.");
                        return;
                    }
                    if (saldoFavorUsar.equals("0") & !tipoCobro.equals("manual")) {
                        objcComprobantePagoDetalle.actualizar_estado(objCPD.getCodComprobantePagoDetalle(), true);
                    }
                    int codCobranza = new cCobranza().crear(objCobranza);
                    objCobranza.setCodCobranza(codCobranza);
                    boolean cobrarInteres = true;
                    //si no paga interes permanente
                    if (objCliente.getInteresEvitarPermanente()) {
                        cobrarInteres = false;
                    } else {
                        cobrarInteres = objCliente.getInteresEvitar() == null ? true : (objCliente.getInteresEvitar().compareTo(new cManejoFechas().fecha_actual()) != 0);
                    }
                    Double montoAmortizarAux = montoAmortizar;
                    while (montoAmortizarAux > 0) {
                        VentaCreditoLetra objVentaCreditoLetra = null;
                        //se buscan deuda con intereses
                        if (cobrarInteres) {
                            //si esta por venta el filtro
                            if (codVenta != 0) {
                                objVentaCreditoLetra = new cVentaCreditoLetra().leer_letraVencidaAntigua_codVenta(objCliente.getPersona().getCodPersona(), codVenta);//letra actual
                            } else {    //si es general
                                objVentaCreditoLetra = new cVentaCreditoLetra().leer_letraVencidaAntigua(objCliente.getPersona().getCodPersona());//letra actual
                            }
                        } else {//solo se buscan deudas sin intereses
                            if (codVenta != 0) {
                                objVentaCreditoLetra = new cVentaCreditoLetra().leer_letraVencidaAntigua_interesEvitar_codVenta(objCliente.getPersona().getCodPersona(), codVenta);//letra actual
                            } else {    //si es general
                                objVentaCreditoLetra = new cVentaCreditoLetra().leer_letraVencidaAntigua_interesEvitar(objCliente.getPersona().getCodPersona());//letra actual
                            }
                        }
                        if (objVentaCreditoLetra == null) {//en caso ya no hayan letras por pagar
                            break;
                        }
                        //obtenemos la deuda para esta letra
                        Double deudaLetra = objVentaCreditoLetra.getMonto() - objVentaCreditoLetra.getTotalPago();
                        //obtenemos la deuda de interes
                        Double interesDeuda = objVentaCreditoLetra.getInteres() - objVentaCreditoLetra.getInteresPagado();

                        //si se cobran intereses
                        if (cobrarInteres) {
                            System.out.println("Se cobran intereses.");
                            //se cancela toda la letra actual y los interes
                            //se actualiza la fecha de pago
                            if (montoAmortizarAux >= deudaLetra + interesDeuda) {
                                System.out.println("se cancela toda la deuda");
                                CobranzaDetalle objCobranzaDetalle = new CobranzaDetalle();
                                objCobranzaDetalle.setCobranza(objCobranza);
                                objCobranzaDetalle.setImporte(deudaLetra);
                                objCobranzaDetalle.setInteres(interesDeuda);
                                objCobranzaDetalle.setObservacion(objVentaCreditoLetra.getDetalleLetra());
                                observacion += objVentaCreditoLetra.getDetalleLetra() + " " + objVentaCreditoLetra.getVentaCredito().getVentas().getDocSerieNumero() + " " + objcOtros.agregarCerosNumeroFormato(objcOtros.redondearDecimales(deudaLetra, 2), 2) + "\n";
                                if (interesDeuda > 0) {
                                    observacion += "Interés " + objVentaCreditoLetra.getDetalleLetra() + " " + objVentaCreditoLetra.getVentaCredito().getVentas().getDocSerieNumero() + " " + objcOtros.decimalFormato(interesDeuda, 2) + "\n";
                                }
                                objCobranzaDetalle.setRegistro(objcOtros.registro("1", objUsuario.getCodUsuario().toString()));
                                objCobranzaDetalle.setVentaCreditoLetra(objVentaCreditoLetra);
                                new cCobranzaDetalle().crear(objCobranzaDetalle);//creamos el detalle de la cobranza
                                //damos por pagado en su totalidad la letra
                                new cVentaCreditoLetra().actualizar_pago(objVentaCreditoLetra.getCodVentaCreditoLetra(), deudaLetra, interesDeuda, fechaCobranza);
                                montoAmortizarAux -= deudaLetra + interesDeuda;//quitamos el monto

                                //cancelamos todo el interes que se debe y se procede amortizar parte de la deuda de la letra
                                //y actualizamos la fecha de pago. Usamos > para indicar que se amortizara la letra ya sea en un centimo
                                //teniendo en cuenta que el monto queda en 0.00
                            } else if (montoAmortizarAux >= interesDeuda) {
                                System.out.println("Se cancela todo los interes");
                                CobranzaDetalle objCobranzaDetalle = new CobranzaDetalle();
                                objCobranzaDetalle.setCobranza(objCobranza);
                                objCobranzaDetalle.setImporte(montoAmortizarAux - interesDeuda);
                                objCobranzaDetalle.setInteres(interesDeuda);
                                objCobranzaDetalle.setObservacion(objVentaCreditoLetra.getDetalleLetra());
                                observacion += objVentaCreditoLetra.getDetalleLetra() + " " + objVentaCreditoLetra.getVentaCredito().getVentas().getDocSerieNumero() + " " + objcOtros.decimalFormato(montoAmortizarAux - interesDeuda, 2) + "\n";
                                if (interesDeuda > 0) {
                                    observacion += "Interés " + objVentaCreditoLetra.getDetalleLetra() + " " + objVentaCreditoLetra.getVentaCredito().getVentas().getDocSerieNumero() + " " + objcOtros.decimalFormato(interesDeuda, 2) + "\n";
                                }
                                objCobranzaDetalle.setRegistro(objcOtros.registro("1", objUsuario.getCodUsuario().toString()));
                                objCobranzaDetalle.setVentaCreditoLetra(objVentaCreditoLetra);
                                new cCobranzaDetalle().crear(objCobranzaDetalle);//creamos el detalle de la cobranza
                                //pagamos el resto del montoExistente-interesDeuda
                                new cVentaCreditoLetra().actualizar_pago(objVentaCreditoLetra.getCodVentaCreditoLetra(), montoAmortizarAux - interesDeuda, interesDeuda, fechaCobranza);
                                montoAmortizarAux = 0.00;//quitamos el monto

                                //solo pagamos parte de la deudaInteres sin actualizar la fecha de pago
                            } else {
                                System.out.println("se paga parte de los intereses");
                                CobranzaDetalle objCobranzaDetalle = new CobranzaDetalle();
                                objCobranzaDetalle.setCobranza(objCobranza);
                                objCobranzaDetalle.setImporte(0.00);
                                objCobranzaDetalle.setInteres(montoAmortizarAux);
                                objCobranzaDetalle.setObservacion(objVentaCreditoLetra.getDetalleLetra());
                                observacion += objVentaCreditoLetra.getDetalleLetra() + " " + objVentaCreditoLetra.getVentaCredito().getVentas().getDocSerieNumero() + " " + objcOtros.decimalFormato(0.00, 2) + "\n";
                                if (interesDeuda > 0) {
                                    observacion += "Interés " + objVentaCreditoLetra.getDetalleLetra() + " " + objVentaCreditoLetra.getVentaCredito().getVentas().getDocSerieNumero() + " " + objcOtros.decimalFormato(montoAmortizarAux, 2) + "\n";
                                }
                                objCobranzaDetalle.setRegistro(objcOtros.registro("1", objUsuario.getCodUsuario().toString()));
                                objCobranzaDetalle.setVentaCreditoLetra(objVentaCreditoLetra);
                                new cCobranzaDetalle().crear(objCobranzaDetalle);//creamos el detalle de la cobranza
                                //pagamos el resto del montoExistente-interesDeuda
                                new cVentaCreditoLetra().actualizar_pago(objVentaCreditoLetra.getCodVentaCreditoLetra(), 0.00, montoAmortizarAux, null);
                                montoAmortizarAux = 0.00;//quitamos el monto
                            }
                        } else {
                            System.out.println("No se cobran intereses.");
                            //si no se cobran intereses
                            if (montoAmortizarAux >= deudaLetra) {
                                //*******creamos cobranzaDetalle
                                CobranzaDetalle objCobranzaDetalle = new CobranzaDetalle();
                                objCobranzaDetalle.setCobranza(objCobranza);
                                objCobranzaDetalle.setImporte(deudaLetra);
                                objCobranzaDetalle.setInteres(0.00);
                                objCobranzaDetalle.setObservacion(objVentaCreditoLetra.getDetalleLetra());
                                observacion += objVentaCreditoLetra.getDetalleLetra() + " " + objVentaCreditoLetra.getVentaCredito().getVentas().getDocSerieNumero() + " " + objcOtros.agregarCerosNumeroFormato(objcOtros.redondearDecimales(deudaLetra, 2), 2) + "\n";
                                objCobranzaDetalle.setRegistro(objcOtros.registro("1", objUsuario.getCodUsuario().toString()));
                                objCobranzaDetalle.setVentaCreditoLetra(objVentaCreditoLetra);
                                new cCobranzaDetalle().crear(objCobranzaDetalle);//creamos el detalle de la cobranza
                                new cVentaCreditoLetra().actualizar_totalPago(objVentaCreditoLetra.getCodVentaCreditoLetra(), deudaLetra, fechaCobranza);
                                montoAmortizarAux -= deudaLetra;//quitamos el moto
                            } else {
                                CobranzaDetalle objCobranzaDetalle = new CobranzaDetalle();
                                objCobranzaDetalle.setCobranza(objCobranza);
                                objCobranzaDetalle.setImporte(montoAmortizarAux);//se asigna el monto restante
                                objCobranzaDetalle.setInteres(0.00);
                                objCobranzaDetalle.setObservacion(objVentaCreditoLetra.getDetalleLetra());
                                observacion += objVentaCreditoLetra.getDetalleLetra() + " " + objVentaCreditoLetra.getVentaCredito().getVentas().getDocSerieNumero() + " " + objcOtros.agregarCerosNumeroFormato(objcOtros.redondearDecimales(montoAmortizarAux, 2), 2) + "\n";
                                objCobranzaDetalle.setRegistro(objcOtros.registro("1", objUsuario.getCodUsuario().toString()));
                                objCobranzaDetalle.setVentaCreditoLetra(objVentaCreditoLetra);
                                new cCobranzaDetalle().crear(objCobranzaDetalle);//creamos el detalle de la cobranza
                                new cVentaCreditoLetra().actualizar_totalPago(objVentaCreditoLetra.getCodVentaCreditoLetra(), montoAmortizarAux, fechaCobranza);
                                montoAmortizarAux = 0.00;//no queda saldo
                            }
                        }
                        //solucion temporal
                        montoAmortizarAux = Double.parseDouble(new cOtros().decimalFormato(montoAmortizarAux, 2));
                    }
                    //Una vez concluido los pagos se proceden a actualizar los interes y agregamos intereses pendientes. Solo para las letras con 0 de deuda.
                    if (!cobrarInteres) {
                        List vCLetraList = new cVentaCreditoLetra().leer_letras_deudaSoloInteres_SC(codCliente);
                        new cVentaCreditoLetra().actualizar_interesPendiente(vCLetraList);
                    }

                    if (saldoFavorUsar.equals("0")) {
                        if (montoAmortizarAux > 0) {//decimos que sobro y se tiene que poner como saldo a favor
                            observacion += "Saldo favor " + new cOtros().decimalFormato(montoAmortizarAux, 2);
                            new cDatosCliente().actualizar_saldoFavor(objCliente.getCodDatosCliente(), montoAmortizarAux);//aactualizamos saldo a favor cliente
                            new cCobranza().actualizar_observacion_saldo(codCobranza, observacion, montoAmortizar - montoAmortizarAux, montoAmortizarAux);
                        } else {//si en caso no hay saldo a favor
                            new cCobranza().actualizar_observacion_saldo(codCobranza, observacion, montoAmortizar, montoAmortizarAux);
                        }
                    } else {
                        if (montoAmortizarAux > 0) {//decimos que sobro y se tiene que poner como saldo a favor
                            observacion += "Saldo favor " + new cOtros().decimalFormato(montoAmortizarAux, 2);
                            new cDatosCliente().actualizar_saldoFavor(objCliente.getCodDatosCliente(), -(montoAmortizar - montoAmortizarAux));//aactualizamod saldo a favor cliente
                            new cCobranza().actualizar_observacion_saldo(codCobranza, observacion, montoAmortizar - montoAmortizarAux, montoAmortizarAux);
                        } else {//si en caso no hay saldo a favor
                            new cDatosCliente().actualizar_saldoFavor(objCliente.getCodDatosCliente(), -montoAmortizar);
                            new cCobranza().actualizar_observacion_saldo(codCobranza, observacion, montoAmortizar, montoAmortizarAux);
                        }
                    }
                    out.print(codCliente);
                }
            } catch (Exception e) {
                out.print("Error en parametros. " + e.getMessage());
                return;
            }

        }//fin accion registrar
        if (accion.equals("eliminar")) {//eliminar cobranza
            if (!objUsuario.getP24()) {
                out.print("No tiene permiso para esta operación. ");
                return;
            }
            Cobranza objCobranza = null;
            cCobranza objcCobranza = new cCobranza();
            cCobranzaDetalle objcCobranzaDetalle = new cCobranzaDetalle();
            cVentaCreditoLetra objcVentaCreditoLetra = new cVentaCreditoLetra();
            int codCobranza = 0;
            try {
                codCobranza = Integer.parseInt(request.getParameter("codCobranza"));
                objCobranza = new cCobranza().leer_codCobranza(codCobranza);
                if (objCobranza == null) {
                    out.print("No hay cobranza con ese parametro");
                    return;
                }
                if (objCobranza.getRegistro().substring(0, 1).equals("0")) {
                    out.print("El recibo y/o ticket se encuentra eliminado. Verifique o actualice");
                    return;
                }
            } catch (NumberFormatException e) {
                out.print("Error en parametros.");
                return;
            }
            for (CobranzaDetalle objCobranzaDetalle : objCobranza.getCobranzaDetalles()) {
                if (objCobranzaDetalle.getRegistro().substring(0, 1).equals("1")) {
                    //actualizamos el pago
                    objcVentaCreditoLetra.actualizar_pago(objCobranzaDetalle.getVentaCreditoLetra().getCodVentaCreditoLetra(), -objCobranzaDetalle.getImporte(), -objCobranzaDetalle.getInteres(), objCobranza.getFechaCobranza());
                    //reponemos si hay interes pendiente.
                    objcVentaCreditoLetra.actualizar_interesPendiente_retornar(objCobranzaDetalle.getVentaCreditoLetra().getCodVentaCreditoLetra());
                    objcCobranzaDetalle.actualizar_registro(objCobranzaDetalle.getCodCobranzaDetalle(), "0", objUsuario.getCodUsuario().toString());
                    //actualizar ultima fecha de pago
                    objcVentaCreditoLetra.actualizar_fechaUltimoPago(objCobranzaDetalle.getVentaCreditoLetra().getCodVentaCreditoLetra());
                }
            }
            DatosCliente objCliente = new cDatosCliente().leer_codPersona(objCobranza.getPersona().getCodPersona());// se lee a la persona
            System.out.println("Saldo actual= " + objCliente.getSaldoFavor());
            if (objCobranza.getDocSerieNumero().substring(0, 1).equals("X")) {//si en caso se uso el saldo a favor
                new cDatosCliente().actualizar_saldoFavor(objCliente.getCodDatosCliente(), objCobranza.getImporte());
            } else {
                new cDatosCliente().actualizar_saldoFavor(objCliente.getCodDatosCliente(), -objCobranza.getSaldo());
            }
            objcCobranza.actualizar_importe_saldo_registro(codCobranza, new cOtros().registro("0", objUsuario.getCodUsuario().toString()));// de la cobranza
            out.print(codCobranza);
        }//fin eliminar

        if (accion.equals("imprimirTicket")) {//inicio imprrmir ticket
            if (!objUsuario.getP36()) {
                out.print("No tiene permisos para esre acción.");
                return;
            }
            int codCobranza = 0;
            List cobranzaDetalleList = null;
            Cobranza objCobranza = null;
            cCobranzaDetalle objcCobranzaDetalle = new cCobranzaDetalle();
            cImprimirTicket objcImprimirTicket = new cImprimirTicket();
            cNumeroLetra objcNumeroLetra = new cNumeroLetra();
            try {
                codCobranza = Integer.parseInt(request.getParameter("codCobranza"));
                objCobranza = new cCobranza().leer_codCobranza(codCobranza);
                cobranzaDetalleList = objcCobranzaDetalle.leer_codCobranza(codCobranza);
            } catch (Exception e) {
                out.print("Error en parametros");
                return;
            }
            Iterator cobranzaDetalleIt = cobranzaDetalleList.iterator();

            FileWriter file = new FileWriter("c:/texto.txt");
            BufferedWriter buffer = new BufferedWriter(file);
            PrintWriter ps = new PrintWriter(buffer);

            objcImprimirTicket.setFormato(2, ps);
            //2-> 33
            //1-> 40
            cDatosExtras objcDatosExtras = new cDatosExtras();
            String cabecera = "******GRUPO YUCRA******";
            String nombreEmpresa = objcDatosExtras.nombreEmpresa().getLetras();
            String ruc = "RUC " + objcDatosExtras.rucEmpresa().getLetras();
            String direccion = objcDatosExtras.direccionEmpresa().getLetras();
            objcImprimirTicket.escribir(objcOtros.centrar(cabecera.toUpperCase(), 33), ps);   //cabecera
            objcImprimirTicket.escribir(objcOtros.centrar(nombreEmpresa.toUpperCase(), 33), ps);  //nombre empresa
            objcImprimirTicket.escribir(objcOtros.centrar(ruc.toUpperCase(), 33), ps);       //ruc
            objcImprimirTicket.escribir(objcOtros.centrar(direccion.toUpperCase(), 33), ps);   //direccion
            objcImprimirTicket.setFormato(1, ps);
            objcImprimirTicket.escribir("                 F. " + objcManejoFechas.fechaHoraAString(new Date()), ps);
            objcImprimirTicket.correr(1, ps);
            objcImprimirTicket.escribir("N. RECIBO: " + objCobranza.getDocSerieNumero(), ps);
            objcImprimirTicket.escribir("CLIEN: " + objCobranza.getPersona().getNombresC(), ps);
            String neto = objcOtros.agregarCerosNumeroFormato((objCobranza.getImporte() + objCobranza.getSaldo()), 2);
            objcImprimirTicket.escribir("IMPORTE: S/. " + neto, ps);
            objcImprimirTicket.escribir("SON: " + objcNumeroLetra.importeNumeroALetra(neto, true, "N.S."), ps);
            objcImprimirTicket.correr(1, ps);
            objcImprimirTicket.escribir("DETALLE                       MONTO", ps);
            objcImprimirTicket.Dibuja_Linea(ps);

//            int cont = 0;
            while (cobranzaDetalleIt.hasNext()) {
                CobranzaDetalle objCobranzaDetalle = (CobranzaDetalle) cobranzaDetalleIt.next();
                String letraDetalle = objCobranzaDetalle.getVentaCreditoLetra().getNumeroLetra() == 0 ? "INICIAL" : "LET. " + objCobranzaDetalle.getVentaCreditoLetra().getNumeroLetra().toString();
                String monto = objcOtros.agregarCerosNumeroFormato(objCobranzaDetalle.getImporte(), 2);
                int montoExt = monto.length();
                for (int i = 0; i < 15 - montoExt; i++) {
                    monto = "*" + monto;
                }
                monto = "   " + monto;
                objcImprimirTicket.escribir(letraDetalle + " " + objCobranzaDetalle.getVentaCreditoLetra().getVentaCredito().getVentas().getDocSerieNumero() + monto, ps);
                //para agregar detalle de interés
                if (objCobranzaDetalle.getInteres() > 0) {
                    String interesDetalle = letraDetalle;
                    String montoInteres = objcOtros.agregarCerosNumeroFormato(objCobranzaDetalle.getInteres(), 2);
                    int montoInt = montoInteres.length();
                    for (int i = 0; i < 13 - montoInt; i++) {
                        montoInteres = "*" + montoInteres;
                    }
//                    montoInteres = " " + montoInteres;
                    objcImprimirTicket.escribir(interesDetalle + " " + objCobranzaDetalle.getVentaCreditoLetra().getVentaCredito().getVentas().getDocSerieNumero() + " INT.", ps);
                    objcImprimirTicket.escribir("       Venc. " + new cManejoFechas().DateAString(objCobranzaDetalle.getVentaCreditoLetra().getFechaVencimiento()) + " " + montoInteres, ps);
                }
            }
            if (objCobranza.getSaldo() > 0) {
                String anticipo = objcOtros.agregarCerosNumeroFormato(objCobranza.getSaldo(), 2);
                int tem = anticipo.length();
                for (int j = 0; j < 15 - tem; j++) {
                    anticipo = "*" + anticipo;
                }
                objcImprimirTicket.escribir("ANTICIPO              " + anticipo, ps);
            }
            objcImprimirTicket.Dibuja_Linea(ps);
            objcImprimirTicket.escribir("OP: " + objcOtros.agregarCeros_int(codCobranza, 8) + "       USUARIO: " + objUsuario.getUsuario(), ps);
            objcImprimirTicket.correr(1, ps);
            objcImprimirTicket.escribir(" YUCRA ...PENSAMOS EN TI.", ps);
            objcImprimirTicket.escribir("    VISITE NUESTRA WEB WWW.YUCRA.COM", ps);
            objcImprimirTicket.correr(1, ps);
            objcImprimirTicket.correr(10, ps);
            objcImprimirTicket.cortar(ps);
            ps.close();

            FileInputStream inputStream = null;
            try {
                inputStream = new FileInputStream("c:/texto.txt");
            } catch (FileNotFoundException e) {
                e.printStackTrace();
            }
            if (inputStream == null) {
                out.print("error al imprimir ticket");
                return;
            }

            DocFlavor docFormat = DocFlavor.INPUT_STREAM.AUTOSENSE;
            Doc document = new SimpleDoc(inputStream, docFormat, null);

            PrintRequestAttributeSet attributeSet = new HashPrintRequestAttributeSet();
            PrintService ticketeraImp = PrintServiceLookup.lookupDefaultPrintService();

            //*********************************************************************
            List lTick = new cDatosExtras().leer_ticketera();
            DatosExtras objDatosExtras = (DatosExtras) lTick.get(0);
            String ticket = objDatosExtras.getLetras();
//            String ticket = "\\\\CAJA-PC\\EPSON TM-U220 Receipt";
            PrintService[] services = null;
//
//            // buscar por el nombre de la impresora (nombre que le diste en tu S.O.)
//            // en "aset" puedes agregar mas atributos de busqueda
            AttributeSet aset = new HashAttributeSet();
            aset.add(new PrinterName(ticket, null));
            aset.add(ColorSupported.SUPPORTED); // si quisieras buscar ademas las que soporten color
//
            services = PrintServiceLookup.lookupPrintServices(null, aset);
            if (services.length == 0) {
                out.print("No hay ticketera instalada " + ticket);
                return;
            }
            for (PrintService printService : services) {
                ticketeraImp = printService;
                System.out.println("******************************" + printService.getName());
            }
            //*********************************************************************
            if (ticketeraImp != null) {
                System.out.println(ticketeraImp.getName());
                DocPrintJob printJob = ticketeraImp.createPrintJob();
                try {
                    printJob.print(document, attributeSet);
                    inputStream.close();
                } catch (Exception e) {
                    e.printStackTrace();
                }
            } else {
                out.print("error al imprimir ticket(no hay impresora instalada)");
                return;
            }
            out.print(codCobranza);
        }//fin imprimir ticket
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
