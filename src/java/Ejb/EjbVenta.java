/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package Ejb;

import Clase.Fecha;
import Clase.Utilitarios;
import Dao.DaoVenta;
import Dao.DaoVentaCreditoLetra;
import HiberanteUtil.HibernateUtil;
import java.util.Date;
import java.util.List;
import javax.ejb.EJB;
import javax.ejb.Stateless;
import org.hibernate.Transaction;
import org.hibernate.Session;
import otrasTablasClases.cDatosExtras;
import tablas.VentaCreditoLetra;
import tablas.Ventas;

/**
 *
 * @author Henrri
 */
@Stateless
public class EjbVenta {

    @EJB
    private EjbVentaCreditoLetra ejbVentaCreditoLetra;

    private Ventas venta;
    private List<Ventas> ventaList;
    private List<Object[]> ventaObjects;

    private String error;
    private Session session;
    private Transaction transaction;

    private int codUsuarioSession;

    public EjbVenta() {
        this.venta = new Ventas();
        this.ventaList = null;
        this.ventaObjects = null;
        this.error = null;
        this.venta.setMoneda("SOLES");
        this.venta.setEstado(true);
        this.venta.setDuracion("");
        this.venta.setMontoInicial(0.00);
        this.venta.setCantidadLetras(0);
        this.venta.setMontoLetra(0.00);
        this.venta.setInteres(0.00);
        this.venta.setAmortizado(0.00);
        this.venta.setInteresPagado(0.00);
        this.venta.setSaldo(0.00);
    }

    public Ventas leerPorCodigo(int codVenta, boolean cerrarSession) {
        this.session = null;
        this.transaction = null;
        try {
            this.session = HibernateUtil.getSessionFactory().openSession();
            this.transaction = session.beginTransaction();
            DaoVenta daoVenta = new DaoVenta();
            //buscamos toda la cobranza hecha por cliente
            this.venta = daoVenta.leerPorCodigo(this.session, codVenta);
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
        return this.venta;
    }

    /**
     * Este debe actualizar los importes al crédito
     *
     * @param codCliente
     * @param cerrarSession
     * @return
     */
    public List<Ventas> leerPorCodigoCliente(int codCliente, boolean cerrarSession) {
        this.session = null;
        this.transaction = null;
        try {
            this.session = HibernateUtil.getSessionFactory().openSession();
            this.transaction = session.beginTransaction();
            DaoVenta daoVenta = new DaoVenta();
            //Ventas que tiene un cliente
            this.ventaList = daoVenta.leerPorCodigoCliente(this.session, codCliente);
            //Llamar al método que calcula los interes
            this.transaction.commit();
        } catch (Exception e) {
            if (this.transaction != null) {
                this.transaction.rollback();
            }
            this.error = "Contacte al administrador << " + e.getMessage() + " >>";
            e.printStackTrace();
        } finally {
            //la sesión se cerrará si es true el valor
            if (cerrarSession & this.session != null) {
                this.session.close();
            }
        }
        return this.ventaList;
    }

    /**
     * Cuotas de pago
     *
     * @return
     */
    public boolean modificarVentaCreditoLetra() {
        boolean est = false;
        this.session = null;
        this.transaction = null;
        this.error = null;
        try {
            this.session = HibernateUtil.getSessionFactory().openSession();
            this.transaction = session.beginTransaction();
            DaoVentaCreditoLetra daoVentaCreditoLetra = new DaoVentaCreditoLetra();
            //obtener los VCL de la venta
            List<VentaCreditoLetra> ventaCreditoLetraList = daoVentaCreditoLetra.leerPorCodigoVenta(this.session, this.venta.getCodVentas());
            int tam = ventaCreditoLetraList.size();
            for (int i = 0; i < tam; i++) {
                VentaCreditoLetra objVentaCreditoLetra = ventaCreditoLetraList.get(i);
                //Solo las activas
                if (objVentaCreditoLetra.getRegistro().substring(0, 1).equals("1")) {
                    //Si se ha realizado pago se no se debe editar
                    if (objVentaCreditoLetra.getTotalPago() > 0) {
                        this.error = "La venta se encuentra con pagos y no se puede editar. Elimine los pagos realizados o elija la opción reprogramar.";
                        return false;
                    }
                    objVentaCreditoLetra.setRegistro(Utilitarios.registro("0", this.codUsuarioSession) + ":" + objVentaCreditoLetra.getRegistro());
                    daoVentaCreditoLetra.actualizar(this.session, objVentaCreditoLetra);
                }
            }
            //Crear las nuevas VCL
            Double acumulado = 0.0;
            Double montoLetra = Utilitarios.redondearDecimales((this.venta.getNeto() - this.venta.getMontoInicial()) / this.venta.getCantidadLetras(), 1);
            //Actualizamos el monto de la letra
            this.venta.setMontoLetra(montoLetra);
            for (int i = 0; i <= this.venta.getCantidadLetras(); i++) {
                ejbVentaCreditoLetra = new EjbVentaCreditoLetra();
                //Creasmo los VCL
                ejbVentaCreditoLetra.getVentaCreditoLetra().setVentas(this.venta);
                ejbVentaCreditoLetra.getVentaCreditoLetra().setMoneda(this.venta.getMoneda().equals("soles") ? 0 : 1);
                ejbVentaCreditoLetra.getVentaCreditoLetra().setNumeroLetra(i);
                if (i == 0) {
                    ejbVentaCreditoLetra.getVentaCreditoLetra().setDetalleLetra("Pago inicial");
                    ejbVentaCreditoLetra.getVentaCreditoLetra().setFechaVencimiento(this.venta.getFechaInicialVencimiento());
                    ejbVentaCreditoLetra.getVentaCreditoLetra().setMonto(this.venta.getMontoInicial());
                } else {
                    if ("mensual".equals(this.venta.getDuracion())) {
                        ejbVentaCreditoLetra.getVentaCreditoLetra().setDetalleLetra("Letra N° " + i);
                        ejbVentaCreditoLetra.getVentaCreditoLetra().setFechaVencimiento(new Fecha().sumarMes(this.venta.getFechaVencimientoLetraDeuda(), i - 1));
                    }
                    if ("quincenal".equals(this.venta.getDuracion())) {
                        ejbVentaCreditoLetra.getVentaCreditoLetra().setDetalleLetra("Letra N° " + i + " (Q)");
                        ejbVentaCreditoLetra.getVentaCreditoLetra().setFechaVencimiento(new Fecha().sumarDias(this.venta.getFechaVencimientoLetraDeuda(), (i * 14) - 14));
                    }
                    if ("semanal".equals(this.venta.getDuracion())) {
                        ejbVentaCreditoLetra.getVentaCreditoLetra().setDetalleLetra("Letra N° " + i + " (S)");
                        ejbVentaCreditoLetra.getVentaCreditoLetra().setFechaVencimiento(new Fecha().sumarDias(this.venta.getFechaVencimientoLetraDeuda(), (i * 7) - 7));
                    }
                    if (i == this.venta.getCantidadLetras()) {
                        Double ultimaLetra = this.venta.getNeto() - this.venta.getMontoInicial() - acumulado;
                        ejbVentaCreditoLetra.getVentaCreditoLetra().setMonto(ultimaLetra);
                    } else {
                        ejbVentaCreditoLetra.getVentaCreditoLetra().setMonto(montoLetra);
                    }
                    //Cambiamos el formato de la fecha de FechaHora -> Fecha
                    ejbVentaCreditoLetra.getVentaCreditoLetra().setFechaVencimiento(new Fecha().fechaHoraAFecha(ejbVentaCreditoLetra.getVentaCreditoLetra().getFechaVencimiento()));
                    acumulado += montoLetra;
                }
                ejbVentaCreditoLetra.getVentaCreditoLetra().setRegistro(Utilitarios.registro("1", this.codUsuarioSession));
                daoVentaCreditoLetra.crear(this.session, ejbVentaCreditoLetra.getVentaCreditoLetra());
                //Actualizamos la venta
                DaoVenta daoVenta = new DaoVenta();
                this.venta.setRegistro(Utilitarios.registro("1", this.codUsuarioSession));
                daoVenta.actualizar(this.session, this.venta);
            }
            //Ejecutar los cambios
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

    public boolean actualizarVentaDatosCreditoEInteresCuotas(int codCliente) {
        boolean est = false;
        this.session = null;
        this.transaction = null;
        this.error = null;
        try {
            this.session = HibernateUtil.getSessionFactory().openSession();
            this.transaction = session.beginTransaction();
            DaoVenta daoVenta = new DaoVenta();
            this.ventaList = daoVenta.leerPorCodigoCliente(this.session, codCliente);
            int tam = this.ventaList.size();
            for (int i = 0; i < tam; i++) {
                this.venta = this.ventaList.get(i);
                //Temporales
                Double interes = 0.00;
                Double amortizado = "CONTADO".equals(this.venta.getTipo()) ? this.venta.getNeto() : 0.00;
                Double interesPagado = 0.00;
                int cont = 0;
                //Sólo ventas habilitadas
                if (this.venta.getRegistro().substring(0, 1).equals("1")) {
                    //Recorremos cadaVenta al credito
                    for (VentaCreditoLetra objVentaCreditoLetra : this.venta.getVentaCreditoLetras()) {
                        //Sólo VCL activas
                        if ("1".equals(objVentaCreditoLetra.getRegistro().substring(0, 1))) {
                            //===========Actualizar los intereses===================
                            //Obtenemos día actual en el formato dd/mm/yyyy
                            Date fechaBase = new Fecha().fechaHoraAFecha(new Date());
                            //quitar horas a fecha
                            //obtener los días de espera que se restará para no calcular interés: ej las que se vencen hoy
                            int diaEspera = new cDatosExtras().leer_diaEspera().getEntero();//******EJB*****
                            //fecha desde la cual se considera vencida para generar los intereses
                            Date fechaVencimientoConEspera = new Fecha().sumarDias(fechaBase, -diaEspera);
                            //quitar horas a fecha
                            fechaVencimientoConEspera = new Fecha().fechaHoraAFecha(fechaVencimientoConEspera);
                            //variables
                            int diasRetraso;
                            Double interesSumar=0.00;
                            //si tiene deuda en el saldo capital
                            if (objVentaCreditoLetra.getMonto() - objVentaCreditoLetra.getTotalPago() > 0) {
                                cont++;
                                //si ultimocalculo es NULL o es menor a la fecha base<es decir que se hizo calculo hasta ayer>
                                if (null == objVentaCreditoLetra.getInteresUltimoCalculo() || objVentaCreditoLetra.getInteresUltimoCalculo().before(fechaBase)) {
                                    //fechaVencimiento sea anterior a la fecha con espera
                                    if (objVentaCreditoLetra.getFechaVencimiento().before(fechaVencimientoConEspera)) {
                                        //obtenemos el factor de interes
                                        double factorInteres = (new cDatosExtras().leer_interesFactor().getDecimalDato() / 100) / 30;
                                        //calculando dias atrasados
                                        if (null == objVentaCreditoLetra.getInteresUltimoCalculo()) {//se tomara el ultimo pago o la fecha de vencimiento
                                /*
                                             *si se hizo un pago antes de la fecha de vencimiento los dias de retraso seran negativos
                                             */
                                            diasRetraso = new Fecha().diasDiferencia(
                                                    fechaBase,
                                                    objVentaCreditoLetra.getFechaPago() != null
                                                    ? (objVentaCreditoLetra.getFechaPago().before(objVentaCreditoLetra.getFechaVencimiento())
                                                    ? objVentaCreditoLetra.getFechaVencimiento()
                                                    : objVentaCreditoLetra.getFechaPago())
                                                    : objVentaCreditoLetra.getFechaVencimiento());
                                        } else {
                                            diasRetraso = new Fecha().diasDiferencia(fechaBase, objVentaCreditoLetra.getInteresUltimoCalculo());
                                        }
                                        //si sale negativo
                                        diasRetraso = diasRetraso < 0 ? 0 : diasRetraso;
                                        //calculando lo que se sumará
                                        interesSumar = (objVentaCreditoLetra.getMonto() - objVentaCreditoLetra.getTotalPago()) * factorInteres * diasRetraso;
                                        //procedemos a actualizar el interes                            
//                                        objVentaCreditoLetra.setInteres(interesSumar + objVentaCreditoLetra.getInteres());
                                        //setear fecha de interes
//                                        objVentaCreditoLetra.setInteresUltimoCalculo(fechaBase);
                                        //llamar al método update
                                        //No actualizar los VCL
                                        //daoVentaCreditoLetra.persistir(this.session, objVentaCreditoLetra);
                                    }
                                }
                            }//Fin Venta con deudas
                            //===============0Fin Actualizacion intertees=======
                            interes += objVentaCreditoLetra.getInteres() + interesSumar;
                            amortizado += objVentaCreditoLetra.getTotalPago();
                            interesPagado += objVentaCreditoLetra.getInteresPagado();
                        }//Fin solo VCL <1>
                    }//Fin de recorrer VCL
                }//Fin de ventas <1>
                //Actualizamos
                this.venta.setInteres(cont == 0 ? interesPagado : interes);
                this.venta.setAmortizado(amortizado);
                this.venta.setInteresPagado(interesPagado);
                this.venta.setSaldo(this.venta.getNeto() - amortizado);
                //Actualizamos
                daoVenta.actualizar(this.session, this.venta);
            }
            //Ejecutar los cambios
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

    public Ventas leerPrimeraVenta(boolean cerrarSession) {
        return this.venta;
    }

    public Ventas leerAnteriorVenta(int codVenta, boolean cerrarSession) {
        return this.venta;
    }

    public Ventas leerSiguienteVenta(int codVenta, boolean cerrarSession) {
        return this.venta;
    }

    public Ventas leerUltimaVenta(boolean cerrarSession) {
        this.session = null;
        this.transaction = null;
        //en caso de que no haya venta retornará NULL
        this.venta = null;
        try {
            this.session = HibernateUtil.getSessionFactory().openSession();
            this.transaction = session.beginTransaction();
            DaoVenta daoVenta = new DaoVenta();
            //Ventas que tiene un cliente
            this.ventaList = daoVenta.leerTodos(this.session);
            //obtener el la última venta
            int tam = ventaList.size();
            //recorrer en orden inverso
            for (int i = tam - 1; i >= 0; i--) {
                this.venta = ventaList.get(i);
                //obtenemos la ultima venta
                if (("0".equals(this.venta.getRegistro().substring(0, 1)) || "1".equals(this.venta.getRegistro().substring(0, 1)))) {
                    //terminamos el for
                    break;
                }
            }
            this.transaction.commit();
        } catch (Exception e) {
            if (cerrarSession & this.transaction != null) {
                this.transaction.rollback();
            }
            this.error = "Contacte al administrador << " + e.getMessage() + " >>";
            e.printStackTrace();
        } finally {
            //la sesión se cerrará si es true el valor
            if (cerrarSession & this.session != null) {
                this.session.close();
            }
        }
        return this.venta;
    }

    public Ventas leerUltimaVentaACredito(boolean cerrarSession) {
        this.session = null;
        this.transaction = null;
        //en caso de que no haya venta retornará NULL
        this.venta = null;
        try {
            this.session = HibernateUtil.getSessionFactory().openSession();
            this.transaction = session.beginTransaction();
            DaoVenta daoVenta = new DaoVenta();
            //Ventas que tiene un cliente
            this.ventaList = daoVenta.leerTodos(this.session);
            //obtener el la última venta
            int tam = ventaList.size();
            //recorrer en orden inverso
            for (int i = tam - 1; i >= 0; i--) {
                this.venta = ventaList.get(i);
                //si la venta es al crédito y esta activa o eliminada
                if ("CREDITO".equals(this.venta.getTipo())
                        & ("0".equals(this.venta.getRegistro().substring(0, 1)) || "1".equals(this.venta.getRegistro().substring(0, 1)))) {
                    //terminamos el for
                    break;
                }
            }
            this.transaction.commit();
        } catch (Exception e) {
            if (cerrarSession & this.transaction != null) {
                this.transaction.rollback();
            }
            this.error = "Contacte al administrador << " + e.getMessage() + " >>";
            e.printStackTrace();
        } finally {
            //la sesión se cerrará si es true el valor
            if (cerrarSession & this.session != null) {
                this.session.close();
            }
        }
        return this.venta;
    }

    public List<Ventas> leerTodos(boolean cerrarSession) {
        this.session = null;
        this.transaction = null;
        try {
            this.session = HibernateUtil.getSessionFactory().openSession();
            this.transaction = session.beginTransaction();
            DaoVenta daoVenta = new DaoVenta();
            //Ventas que tiene un cliente
            this.ventaList = daoVenta.leerTodos(this.session);
            this.transaction.commit();
        } catch (Exception e) {
            if (this.transaction != null) {
                this.transaction.rollback();
            }
            this.error = "Contacte al administrador << " + e.getMessage() + " >>";
            e.printStackTrace();
        } finally {
            //la sesión se cerrará si es true el valor
            if (cerrarSession & this.session != null) {
                this.session.close();
            }
        }
        return this.ventaList;
    }

    public Ventas getVenta() {
        return venta;
    }

    public void setVenta(Ventas venta) {
        this.venta = venta;
    }

    public List<Ventas> getVentaList() {
        return ventaList;
    }

    public void setVentaList(List<Ventas> ventaList) {
        this.ventaList = ventaList;
    }

    public String getError() {
        return error;
    }

    public void setError(String error) {
        this.error = error;
    }

    public List<Object[]> getVentaObjects() {
        return ventaObjects;
    }

    public void setVentaObjects(List<Object[]> ventaObjects) {
        this.ventaObjects = ventaObjects;
    }

    public int getCodUsuarioSession() {
        return codUsuarioSession;
    }

    public void setCodUsuarioSession(int codUsuarioSession) {
        this.codUsuarioSession = codUsuarioSession;
    }

}
