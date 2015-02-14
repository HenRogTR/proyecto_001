/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package Ejb;

import Clase.Fecha;
import Clase.Utilitarios;
import Dao.DaoCliente;
import Dao.DaoCobranza;
import Dao.DaoCobranzaDetalle;
import Dao.DaoComprobantePago;
import Dao.DaoComprobantePagoDetalle;
import Dao.DaoDatosExtras;
import Dao.DaoVentaCreditoLetra;
import HiberanteUtil.HibernateUtil;
import java.util.Date;
import java.util.List;
import javax.ejb.Stateless;
import org.hibernate.Session;
import org.hibernate.Transaction;
import tablas.Cobranza;
import tablas.CobranzaDetalle;
import tablas.ComprobantePago;
import tablas.ComprobantePagoDetalle;
import tablas.DatosCliente;
import tablas.DatosExtras;
import tablas.VentaCreditoLetra;

/**
 *
 * @author Henrri
 */
@Stateless
public class EjbCobranza {

    private Cobranza cobranza;
    private List<Cobranza> cobranzaList;
    private List<ComprobantePago> comprobantePagoList;
    private List<ComprobantePagoDetalle> comprobantePagoDetalleList;
    private List<VentaCreditoLetra> ventaCreditoLetraList;

    private String error;
    private Session session;
    private Transaction transaction;

    private int codUsuarioSession;

    public EjbCobranza() {
        cobranza = new Cobranza();
        cobranzaList = null;
        error = null;
    }

    public List<Cobranza> leerActivoPorCodigoCliente(int codCliente, boolean cerrarSession) {
        this.session = null;
        this.transaction = null;
        try {
            this.session = HibernateUtil.getSessionFactory().openSession();
            this.transaction = session.beginTransaction();
            DaoCobranza daoCobranza = new DaoCobranza();
            //buscamos toda la cobranza hecha por cliente
            this.cobranzaList = daoCobranza.leerPorCodigoCliente(this.session, codCliente);
            //obtener tamaño de lista
            int tam = this.cobranzaList.size();
            //dejar solo activos
            for (int i = 0; i < tam; i++) {
                this.cobranza = this.cobranzaList.get(i);
                //comparar si se encuentra activo
                if (!"1".equals(this.cobranza.getRegistro().substring(0, 1))) {
                    this.cobranzaList.remove(i);
                    //regresamos una posicion
                    i--;
                    /*el tamaño se reduce en uno, se quita uno ya que el tamaño 
                     *del array se calcula solo al inicio y se mantiene constante
                     *cosa que cambiaria si el tam se obtendria dentro del for
                     */
                    tam--;
                }
            }
            this.transaction.commit();
        } catch (Exception e) {
            if (this.transaction != null) {
                this.transaction.rollback();
            }
            this.error = "Contacte al administrador << " + e.getMessage() + " >>";
            e.printStackTrace();
        } finally {
            if (cerrarSession & this.session != null) {
                this.session.close();
            }
        }
        return this.cobranzaList;
    }

    public List<Cobranza> leerActivoPorCodigoVenta(int codCliente, boolean cerrarSession) {
        this.session = null;
        this.transaction = null;
        try {
            this.session = HibernateUtil.getSessionFactory().openSession();
            this.transaction = session.beginTransaction();
            DaoCobranza daoCobranza = new DaoCobranza();
            //buscamos toda la cobranza hecha por cliente
            this.cobranzaList = daoCobranza.leerPorCodigoVenta(this.session, codCliente);
            //obtener tamaño de lista
            int tam = this.cobranzaList.size();
            //dejar solo activos
            for (int i = 0; i < tam; i++) {
                this.cobranza = this.cobranzaList.get(i);
                //comparar si se encuentra activo
                if (!"1".equals(this.cobranza.getRegistro().substring(0, 1))) {
                    this.cobranzaList.remove(i);
                    //regresamos una posicion
                    i--;
                    /*el tamaño se reduce en uno, se quita uno ya que el tamaño 
                     *del array se calcula solo al inicio y se mantiene constante
                     *cosa que cambiaria si el tam se obtendria dentro del for
                     */
                    tam--;
                }
            }
            this.transaction.commit();
        } catch (Exception e) {
            if (this.transaction != null) {
                this.transaction.rollback();
            }
            this.error = "Contacte al administrador << " + e.getMessage() + " >>";
            e.printStackTrace();
        } finally {
            if (cerrarSession & this.session != null) {
                this.session.close();
            }
        }
        return this.cobranzaList;
    }

    public boolean registrar(int codCliente, String tipoPago, String tipoCobro,
            Double montoAmortizar, Date fechaCobranza, int codVenta,
            String saldoFavorUsar, String docSerieNumero, String tipoCaja,
            String tipoDescuento, String serieCaja, String serieDescuento) {
        boolean est = false;
        this.session = null;
        this.transaction = null;
        this.error = null;
        try {
            this.session = HibernateUtil.getSessionFactory().openSession();
            this.transaction = session.beginTransaction();
            //Buscando el documento que se usará
            DaoCobranza daoCobranza = new DaoCobranza();
            DaoCobranzaDetalle daoCobranzaDetalle = new DaoCobranzaDetalle();
            DaoComprobantePago daoComprobantePago = new DaoComprobantePago();
            DaoComprobantePagoDetalle daoComprobantePagoDetalle = new DaoComprobantePagoDetalle();
            DaoCliente daoCliente = new DaoCliente();
            DaoVentaCreditoLetra daoVentaCreditoLetra = new DaoVentaCreditoLetra();

            ComprobantePagoDetalle objComprobantePagoDetalle = null;
            if ("1".equals(saldoFavorUsar)) {
                docSerieNumero = "XXX-999-111111";  //Si en caso se usa saldo a favor, se asignará un documento cualquiera.
            } else {
                //En caso de ser manual, ya se recibió desde el servlet
                if ("manual".equals(tipoCobro)) {
                    //Validar si existe el tipo y serie en la bd
                    String[] a = docSerieNumero.split("-");
                    this.comprobantePagoList
                            = daoComprobantePago.verificarDisponible(this.session, a[0], a[1]);
                    if (this.comprobantePagoList.isEmpty()) {
                        this.error = "Tipo y/o serie no encontrada.";
                        return false;
                    }
                    //validar si no esta usado
                    if (daoCobranza.leerPorDocSerieNumero(this.session, docSerieNumero) != null) {
                        this.error = docSerieNumero + " ya se encuentra en uso";
                        return false;
                    }
                } else {
                    //Iniciar en vacio
                    docSerieNumero = "";
                    //Leer disponibilidad de tipo y serie
                    ComprobantePago objComprobantePago;
                    this.comprobantePagoList
                            = "caja".equals(tipoCobro)
                            ? daoComprobantePago.verificarDisponible(this.session, tipoCaja, serieCaja)
                            : daoComprobantePago.verificarDisponible(this.session, tipoDescuento, serieDescuento);
                    if (this.comprobantePagoList.isEmpty()) {
                        this.error = "Tipo y/o serie no encontrada.";
                        return false;
                    }
                    objComprobantePago = this.comprobantePagoList.get(0);
                    //Leer disponibilidad de número
                    this.comprobantePagoDetalleList = daoComprobantePagoDetalle.leerDisponible(this.session, objComprobantePago.getCodComprobantePago());
                    if (this.comprobantePagoDetalleList.isEmpty()) {
                        this.error = "No hay documentos disponibles para esta serie (" + objComprobantePago.getTipo() + "-" + objComprobantePago.getSerie() + "-XXXXXX). Genere nuevos.";
                        return false;
                    }//
                    //obtener uno válido
                    int tamCPDL = this.comprobantePagoDetalleList.size();
                    for (int i = 0; i < tamCPDL; i++) {
                        ComprobantePagoDetalle objComprobantePagoDetalleAux = this.comprobantePagoDetalleList.get(i);
                        System.out.println(objComprobantePagoDetalleAux.getDocSerieNumero());
                        //Validar que aun estando habilitado ya se encuentre usado, se recomienda actualizarlo.
                        if (daoCobranza.leerPorDocSerieNumero(this.session, objComprobantePagoDetalleAux.getDocSerieNumero()) == null) {
                            docSerieNumero = objComprobantePagoDetalleAux.getDocSerieNumero();
                            objComprobantePagoDetalle = objComprobantePagoDetalleAux;
                            break;
                        }
                    }
                    //Ver si hay disponible
                    if ("".equals(docSerieNumero)) {
                        this.error = "No hay documentos disponibles para esta serie (" + objComprobantePago.getTipo() + "-" + objComprobantePago.getSerie() + "-XXXXXX). Genere nuevos.";
                        return false;
                    }
                }
            }
            //Iniciando proceso de registro
            if ("1".equals(saldoFavorUsar) & "anticipo".equals(tipoPago)) { //validar que no se use el saldo a favor como anticipo
                this.error = "No se puede utilizar el saldo a favor como un anticipo.";
                return false;
            }
            //Actualizar el estado del comprobante solo si no se ha ingresado manualmente y no sea un saldo a favor
            if ("0".equals(saldoFavorUsar) & !"manual".equals(tipoCobro)) {
                objComprobantePagoDetalle.setEstado(true);
                objComprobantePagoDetalle.setRegistro(Utilitarios.registro("1", this.codUsuarioSession) + ":" + objComprobantePagoDetalle.getRegistro());
                daoComprobantePagoDetalle.actualizar(this.session, objComprobantePagoDetalle);
            }
            //Leer el cliente
            DatosCliente objCliente = daoCliente.leerPorCodigo(this.session, codCliente);
            //Inicializar cobranza            
            this.cobranza = new Cobranza();
            if ("anticipo".equals(tipoPago)) {
                //Setear parámetros
                this.cobranza.setPersona(objCliente.getPersona());
                this.cobranza.setFechaCobranza(fechaCobranza);
                this.cobranza.setDocSerieNumero(docSerieNumero);
                this.cobranza.setSaldoAnterior(0.00);
                this.cobranza.setImporte(0.00);
                this.cobranza.setSaldo(montoAmortizar);
                this.cobranza.setMontoPagado(montoAmortizar);
                this.cobranza.setObservacion("Anticipo " + Utilitarios.decimalFormato(montoAmortizar, 2));
                this.cobranza.setRegistro(Utilitarios.registro("1", this.codUsuarioSession));
                //Registro propiamente dicho
                int codCobranza = daoCobranza.registrar(this.session, this.cobranza);
                this.cobranza.setCodCobranza(codCobranza);
                //Actualizar el saldo a favor
                objCliente.setSaldoFavor(objCliente.getSaldoFavor() + montoAmortizar);
                daoCliente.actualizar(this.session, objCliente);
            }
            if ("normal".equals(tipoPago)) {
                //Ver si el cliente tiene deuda alguna.
                this.ventaCreditoLetraList
                        = codVenta == 0
                        ? daoVentaCreditoLetra.leerConDeudaPorCodigoCliente(this.session, codCliente)
                        : daoVentaCreditoLetra.leerConDeudaPorCodigoVenta(this.session, codVenta);
                if (this.ventaCreditoLetraList.isEmpty()) {
                    this.error = (codVenta == 0 ? "El cliente" : "La venta seleccionada") + " no presenta deuda alguna, ingrese como anticipo.";
                    return false;
                }
                //Actualizar despues
                String observacion = "";
                //Setear parámetros
                this.cobranza.setPersona(objCliente.getPersona());
                this.cobranza.setFechaCobranza(fechaCobranza);
                this.cobranza.setDocSerieNumero(docSerieNumero);
                this.cobranza.setSaldoAnterior(0.00);
                this.cobranza.setImporte(montoAmortizar);
                this.cobranza.setSaldo(0.00);
                this.cobranza.setMontoPagado(montoAmortizar);
                this.cobranza.setObservacion("");
                this.cobranza.setRegistro(Utilitarios.registro("1", this.codUsuarioSession));
                //Registro propiamente dicho
                int codCobranza = daoCobranza.registrar(this.session, this.cobranza);
                this.cobranza.setCodCobranza(codCobranza);
                //Ver si se efectuará el pago de intereses
                boolean cobrarInteres;
                //si no paga interes permanente
                if (objCliente.isInteresEvitarPermanente()) {
                    cobrarInteres = false;
                } else {
                    cobrarInteres
                            = objCliente.getInteresEvitar() == null
                            ? true
                            : (objCliente.getInteresEvitar().compareTo(new Fecha().fechaHoraAFecha(new Date())) != 0);
                }
                //Iniciamos el proceso de amoritzaciones tomando las letras mas vencidas
                Double montoAmortizarAux = montoAmortizar;
                //Tamaño de lista
                int tamVCLList = this.ventaCreditoLetraList.size();
                for (int i = 0; i < tamVCLList; i++) {
                    //Obtenemos cada letra
                    VentaCreditoLetra objVentaCreditoLetra = this.ventaCreditoLetraList.get(i);
                    //Permite terminar el for en caso ya no haya monto para seguir reduciendo las cuotas
                    if (montoAmortizarAux == 0) {
                        break;
                    }
                    //obtenemos la deuda para esta letra
                    Double deudaLetra = objVentaCreditoLetra.getMonto() - objVentaCreditoLetra.getTotalPago();
                    //obtenemos la deuda de interes
                    Double interesDeuda = objVentaCreditoLetra.getInteres() - objVentaCreditoLetra.getInteresPagado();
                    //si se cobran intereses
                    if (cobrarInteres) {
                        //se cancela toda la letra actual y los interes
                        if (montoAmortizarAux >= deudaLetra + interesDeuda) {
                            System.out.println("se cancela toda la deuda -> interes");
                            CobranzaDetalle objCobranzaDetalle = new CobranzaDetalle();
                            objCobranzaDetalle.setCobranza(this.cobranza);
                            objCobranzaDetalle.setImporte(deudaLetra);
                            objCobranzaDetalle.setInteres(interesDeuda);
                            objCobranzaDetalle.setObservacion(objVentaCreditoLetra.getDetalleLetra());
                            observacion += objVentaCreditoLetra.getDetalleLetra() + " " + objVentaCreditoLetra.getVentas().getDocSerieNumero() + " " + Utilitarios.decimalFormato(deudaLetra, 2) + "\n";
                            if (interesDeuda > 0) {
                                observacion += "Interés " + objVentaCreditoLetra.getDetalleLetra() + " " + objVentaCreditoLetra.getVentas().getDocSerieNumero() + " " + Utilitarios.decimalFormato(interesDeuda, 2) + "\n";
                            }
                            objCobranzaDetalle.setRegistro(Utilitarios.registro("1", this.codUsuarioSession));
                            objCobranzaDetalle.setVentaCreditoLetra(objVentaCreditoLetra);
                            //Registramos el detalle cobranza
                            daoCobranzaDetalle.pesistir(this.session, objCobranzaDetalle);
                            //Actualizamos datos de VCL                            
                            System.out.println(">><< total pagado:" + objVentaCreditoLetra.getTotalPago() + " lo que se paga ahora:" + deudaLetra);
                            objVentaCreditoLetra.setTotalPago(objVentaCreditoLetra.getTotalPago() + deudaLetra);//montoTotal pagado
                            objVentaCreditoLetra.setFechaPago(fechaCobranza);   //La fecha se actualiza
                            objVentaCreditoLetra.setInteresPagado(objVentaCreditoLetra.getInteresPagado() + interesDeuda);
                            // new cVentaCreditoLetra().actualizar_pago(objVentaCreditoLetra.getCodVentaCreditoLetra(), deudaLetra, interesDeuda, fechaCobranza);
                            //Decimos que la letra fue totalmente pagada
                            daoVentaCreditoLetra.actualizar(this.session, objVentaCreditoLetra);
                            montoAmortizarAux -= deudaLetra + interesDeuda;//quitamos el monto

                            //cancelamos todo el interes que se debe y se procede amortizar parte de la deuda de la letra
                            //y actualizamos la fecha de pago. Usamos > para indicar que se amortizara la letra ya sea en un centimo
                            //teniendo en cuenta que el monto queda en 0.00
                        } else if (montoAmortizarAux >= interesDeuda) {
                            System.out.println("Se cancela todo los interes-> interes");
                            CobranzaDetalle objCobranzaDetalle = new CobranzaDetalle();
                            objCobranzaDetalle.setCobranza(this.cobranza);
                            objCobranzaDetalle.setImporte(montoAmortizarAux - interesDeuda);
                            objCobranzaDetalle.setInteres(interesDeuda);
                            objCobranzaDetalle.setObservacion(objVentaCreditoLetra.getDetalleLetra());
                            observacion += objVentaCreditoLetra.getDetalleLetra() + " " + objVentaCreditoLetra.getVentas().getDocSerieNumero() + " " + Utilitarios.decimalFormato(montoAmortizarAux - interesDeuda, 2) + "\n";
                            if (interesDeuda > 0) {
                                observacion += "Interés " + objVentaCreditoLetra.getDetalleLetra() + " " + objVentaCreditoLetra.getVentas().getDocSerieNumero() + " " + Utilitarios.decimalFormato(interesDeuda, 2) + "\n";
                            }
                            objCobranzaDetalle.setRegistro(Utilitarios.registro("1", this.codUsuarioSession));
                            objCobranzaDetalle.setVentaCreditoLetra(objVentaCreditoLetra);
                            //Registramos el detalle cobranza
                            daoCobranzaDetalle.pesistir(this.session, objCobranzaDetalle);
                            //Actualizamos datos de VCL
                            //pagamos el resto del montoExistente-interesDeuda
                            objVentaCreditoLetra.setTotalPago(objVentaCreditoLetra.getTotalPago() + montoAmortizarAux - interesDeuda);//montoTotal pagado
                            objVentaCreditoLetra.setFechaPago(fechaCobranza);   //La fecha se actualiza
                            objVentaCreditoLetra.setInteresPagado(objVentaCreditoLetra.getInteresPagado() + interesDeuda);
//                            new cVentaCreditoLetra().actualizar_pago(objVentaCreditoLetra.getCodVentaCreditoLetra(), montoAmortizarAux - interesDeuda, interesDeuda, fechaCobranza);
                            //Decimos que el interes fue pagado totalmente 
                            daoVentaCreditoLetra.actualizar(this.session, objVentaCreditoLetra);
                            montoAmortizarAux = 0.00;//quitamos el monto

                            //solo pagamos parte de la deudaInteres sin actualizar la fecha de pago
                        } else {
                            System.out.println("se paga parte de los intereses -> interes");
                            CobranzaDetalle objCobranzaDetalle = new CobranzaDetalle();
                            objCobranzaDetalle.setCobranza(this.cobranza);
                            objCobranzaDetalle.setImporte(0.00);
                            objCobranzaDetalle.setInteres(montoAmortizarAux);
                            objCobranzaDetalle.setObservacion(objVentaCreditoLetra.getDetalleLetra());
                            observacion += objVentaCreditoLetra.getDetalleLetra() + " " + objVentaCreditoLetra.getVentas().getDocSerieNumero() + " " + Utilitarios.decimalFormato(0.00, 2) + "\n";
                            if (interesDeuda > 0) {
                                observacion += "Interés " + objVentaCreditoLetra.getDetalleLetra() + " " + objVentaCreditoLetra.getVentas().getDocSerieNumero() + " " + Utilitarios.decimalFormato(montoAmortizarAux, 2) + "\n";
                            }
                            objCobranzaDetalle.setRegistro(Utilitarios.registro("1", this.codUsuarioSession));
                            objCobranzaDetalle.setVentaCreditoLetra(objVentaCreditoLetra);
                            //Registramos el detalle cobranza
                            daoCobranzaDetalle.pesistir(this.session, objCobranzaDetalle);
                            //Actualizamos datos de VCL
                            //pagamos el parte del interes
                            objVentaCreditoLetra.setInteresPagado(objVentaCreditoLetra.getInteresPagado() + montoAmortizarAux);
//                            new cVentaCreditoLetra().actualizar_pago(objVentaCreditoLetra.getCodVentaCreditoLetra(), 0.00, montoAmortizarAux, null);
                            daoVentaCreditoLetra.actualizar(this.session, objVentaCreditoLetra);
                            montoAmortizarAux = 0.00;//quitamos el monto
                        }
                    }
                    //si no se cobran intereses
                    if (!cobrarInteres) {
                        //si no se cobran intereses
                        if (montoAmortizarAux >= deudaLetra) {
                            //*******creamos cobranzaDetalle
                            CobranzaDetalle objCobranzaDetalle = new CobranzaDetalle();
                            objCobranzaDetalle.setCobranza(this.cobranza);
                            objCobranzaDetalle.setImporte(deudaLetra);
                            objCobranzaDetalle.setInteres(0.00);
                            objCobranzaDetalle.setObservacion(objVentaCreditoLetra.getDetalleLetra());
                            observacion += objVentaCreditoLetra.getDetalleLetra() + " " + objVentaCreditoLetra.getVentas().getDocSerieNumero() + " " + Utilitarios.decimalFormato(deudaLetra, 2) + "\n";
                            objCobranzaDetalle.setRegistro(Utilitarios.registro("1", this.codUsuarioSession));
                            objCobranzaDetalle.setVentaCreditoLetra(objVentaCreditoLetra);
                            //Registramos el detalle cobranza
                            daoCobranzaDetalle.pesistir(this.session, objCobranzaDetalle);
                            //Actualizamos datos de VCL pagamos toda la letra ademas decimos que el interes pagado igual a interes y lo restante a interes deuda
                            //Actualizamos datos de VCL
                            objVentaCreditoLetra.setTotalPago(objVentaCreditoLetra.getTotalPago() + deudaLetra);//montoTotal pagado
                            objVentaCreditoLetra.setFechaPago(fechaCobranza);   //La fecha se actualiza
                            objVentaCreditoLetra.setInteres(objVentaCreditoLetra.getInteresPagado());
                            objVentaCreditoLetra.setInteresPendiente(interesDeuda);
//                            new cVentaCreditoLetra().actualizar_totalPago(objVentaCreditoLetra.getCodVentaCreditoLetra(), deudaLetra, fechaCobranza);
                            daoVentaCreditoLetra.actualizar(this.session, objVentaCreditoLetra);
                            montoAmortizarAux -= deudaLetra;//quitamos el monto
                        } else {
                            CobranzaDetalle objCobranzaDetalle = new CobranzaDetalle();
                            objCobranzaDetalle.setCobranza(this.cobranza);
                            objCobranzaDetalle.setImporte(montoAmortizarAux);//se asigna el monto restante
                            objCobranzaDetalle.setInteres(0.00);
                            objCobranzaDetalle.setObservacion(objVentaCreditoLetra.getDetalleLetra());
                            observacion += objVentaCreditoLetra.getDetalleLetra() + " " + objVentaCreditoLetra.getVentas().getDocSerieNumero() + " " + Utilitarios.decimalFormato(montoAmortizarAux, 2) + "\n";
                            objCobranzaDetalle.setRegistro(Utilitarios.registro("1", this.codUsuarioSession));
                            objCobranzaDetalle.setVentaCreditoLetra(objVentaCreditoLetra);
                            //Registramos el detalle cobranza
                            daoCobranzaDetalle.pesistir(this.session, objCobranzaDetalle);
                            //Actualizamos datos de VCL pagamos parte del monto
                            //Actualizamos datos de VCL
                            objVentaCreditoLetra.setTotalPago(objVentaCreditoLetra.getTotalPago() + montoAmortizarAux);//montoTotal pagado
                            objVentaCreditoLetra.setFechaPago(fechaCobranza);   //La fecha se actualiza
//                            new cVentaCreditoLetra().actualizar_totalPago(objVentaCreditoLetra.getCodVentaCreditoLetra(), montoAmortizarAux, fechaCobranza);
                            daoVentaCreditoLetra.actualizar(this.session, objVentaCreditoLetra);
                            montoAmortizarAux = 0.00;//no queda saldo
                        }
                    }
                    montoAmortizarAux = Double.parseDouble(Utilitarios.decimalFormato(montoAmortizarAux, 2));
                }
                //si no se ha usado el saldo a favor se agrega lo restante
                if ("0".equals(saldoFavorUsar)) {
                    if (montoAmortizarAux > 0) {//decimos que sobro y se tiene que poner como saldo a favor
                        observacion += "Saldo favor " + Utilitarios.decimalFormato(montoAmortizarAux, 2);
                        //seteamos datos del cliente
                        objCliente.setSaldoFavor(objCliente.getSaldoFavor() + montoAmortizarAux);
                        //actualiar
//                        new cDatosCliente().actualizar_saldoFavor(objCliente.getCodDatosCliente(), montoAmortizarAux);//aactualizamos saldo a favor cliente

                        //Setear cobranza
                        this.cobranza.setObservacion(observacion);
                        this.cobranza.setImporte(montoAmortizar - montoAmortizarAux);
                        this.cobranza.setSaldo(montoAmortizarAux);
//                        new cCobranza().actualizar_observacion_saldo(codCobranza, observacion, montoAmortizar - montoAmortizarAux, montoAmortizarAux);
                    } else {//si en caso no hay saldo a favor
                        this.cobranza.setObservacion(observacion);
//                        new cCobranza().actualizar_observacion_saldo(codCobranza, observacion, montoAmortizar, montoAmortizarAux);
                    }
                } else { // si en caso se uso el saldo a favor se quita del saldo a favor
                    if (montoAmortizarAux > 0) {//decimos que sobro y se tiene que poner como saldo a favor
                        observacion += "Saldo favor " + Utilitarios.decimalFormato(montoAmortizarAux, 2);
                        //seteamos datos del cliente
                        objCliente.setSaldoFavor(objCliente.getSaldoFavor() - (montoAmortizar - montoAmortizarAux));
//                        new cDatosCliente().actualizar_saldoFavor(objCliente.getCodDatosCliente(), -(montoAmortizar - montoAmortizarAux));//actualizamod saldo a favor cliente
                        //Setear cobranza
                        this.cobranza.setObservacion(observacion);
                        this.cobranza.setImporte(montoAmortizar - montoAmortizarAux);
                        this.cobranza.setSaldo(montoAmortizarAux);
//                        new cCobranza().actualizar_observacion_saldo(codCobranza, observacion, montoAmortizar - montoAmortizarAux, montoAmortizarAux);
                    } else {//si en caso no hay saldo a favor
                        objCliente.setSaldoFavor(objCliente.getSaldoFavor() - montoAmortizar);
//                        new cDatosCliente().actualizar_saldoFavor(objCliente.getCodDatosCliente(), -montoAmortizar);
                        this.cobranza.setObservacion(observacion);
//                        new cCobranza().actualizar_observacion_saldo(codCobranza, observacion, montoAmortizar, montoAmortizarAux);
                    }
                }
                daoCobranza.actualizar(this.session, this.cobranza);
                daoCliente.actualizar(this.session, objCliente);
            }
            this.transaction.commit();
            est = true;
        } catch (Exception e) {
            if (this.transaction != null) {
                this.transaction.rollback();
            }
            this.error = "Contacte al administrador << " + e.getMessage() + " >>";
            e.printStackTrace();
        } finally {
            if (this.session != null) {
                this.session.close();
            }
        }
        return est;
    }

    /**
     * Imprimir tickets habilitados solamente
     *
     * @param codCobranza
     * @return
     */
    public boolean imprimir(int codCobranza) {
        boolean est = false;
        this.session = null;
        this.transaction = null;
        this.error = null;
        try {
            this.session = HibernateUtil.getSessionFactory().openSession();
            this.transaction = session.beginTransaction();
            //Variables            
            String rutaTemporalTicket = "";
            List<CobranzaDetalle> cobranzaDetalleList;
            //Definir daos
            DaoDatosExtras daoDatosExtras = new DaoDatosExtras();
            DaoCobranza daoCobranza = new DaoCobranza();
            DaoCobranzaDetalle daoCobranzaDetalle = new DaoCobranzaDetalle();
            //Verificar si hay ruta
            DatosExtras objDatosExtras = daoDatosExtras.direccionArchivoTemporalTicketera(this.session);
            //Verificar que haya dato
            if (objDatosExtras == null) {
                this.error = "Dirección de archivo temporal no especificado. Contacte con el administrador del sistema.";
                return false;
            }
            rutaTemporalTicket = objDatosExtras.getLetras();
            //Leer cobranza
            this.cobranza = daoCobranza.leerPorCodigo(this.session, codCobranza);
            if (this.cobranza == null) {
                this.error = "El código de cobranza no se encuentra registrado.";
                return false;
            }
            cobranzaDetalleList = daoCobranzaDetalle.leerPorCodigoCobranza(this.session, codCobranza);
            this.transaction.commit();
        } catch (Exception e) {
            if (this.transaction != null) {
                this.transaction.rollback();
            }
            this.error = "Contacte al administrador << " + e.getMessage() + " >>";
            e.printStackTrace();
        } finally {
            if (this.session != null) {
                this.session.close();
            }
        }
        return est;
    }

    public Cobranza getCobranza() {
        return cobranza;
    }

    public void setCobranza(Cobranza cobranza) {
        this.cobranza = cobranza;
    }

    public List<Cobranza> getCobranzaList() {
        return cobranzaList;
    }

    public void setCobranzaList(List<Cobranza> cobranzaList) {
        this.cobranzaList = cobranzaList;
    }

    public String getError() {
        return error;
    }

    public void setError(String error) {
        this.error = error;
    }

    public int getCodUsuarioSession() {
        return codUsuarioSession;
    }

    public void setCodUsuarioSession(int codUsuarioSession) {
        this.codUsuarioSession = codUsuarioSession;
    }

    public List<ComprobantePago> getComprobantePagoList() {
        return comprobantePagoList;
    }

    public void setComprobantePagoList(List<ComprobantePago> comprobantePagoList) {
        this.comprobantePagoList = comprobantePagoList;
    }

    public List<ComprobantePagoDetalle> getComprobantePagoDetalleList() {
        return comprobantePagoDetalleList;
    }

    public void setComprobantePagoDetalleList(List<ComprobantePagoDetalle> comprobantePagoDetalleList) {
        this.comprobantePagoDetalleList = comprobantePagoDetalleList;
    }

}
