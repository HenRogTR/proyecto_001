/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package Ejb;

import Dao.DaoVentaCreditoLetra;
import HiberanteUtil.HibernateUtil;
import Clase.Fecha;
import Clase.Utilitarios;
import java.util.Date;
import java.util.List;
import javax.ejb.EJB;
import javax.ejb.Stateless;
import org.hibernate.Session;
import org.hibernate.Transaction;
import otrasTablasClases.cDatosExtras;
import tablas.VentaCreditoLetra;
import utilitarios.cManejoFechas;

/**
 *
 * @author Henrri
 */
@Stateless
public class EjbVentaCreditoLetra {

    @EJB
    private EjbDatosExtras ejbDatosExtras;

    private VentaCreditoLetra ventaCreditoLetra;
    private List<VentaCreditoLetra> ventaCreditoLetraList;
    private List<Object[]> ventaCreditoLetraObjects;

    private String error;
    private Session session;
    private Transaction transaction;

    private int codUsuarioSession;

    public EjbVentaCreditoLetra() {
        this.ventaCreditoLetra = new VentaCreditoLetra();
        this.ventaCreditoLetraList = null;
        this.ventaCreditoLetraObjects = null;
        this.ventaCreditoLetra.setMoneda(0);
        this.ventaCreditoLetra.setInteres(0.00);
        this.ventaCreditoLetra.setTotalPago(0.00);
        this.ventaCreditoLetra.setInteresPagado(0.00);
        this.ventaCreditoLetra.setInteresPendiente(0.00);
    }

    /**
     * Retorna solo las VCL activos, ya que también hay anuladas
     *
     * @param codVenta
     * @param cerrarSession
     * @return
     */
    public List<VentaCreditoLetra> leerActivoPorCodigoCliente(int codVenta, boolean cerrarSession) {
        this.session = null;
        this.transaction = null;
        this.error = null;
        try {
            this.session = HibernateUtil.getSessionFactory().openSession();
            this.transaction = session.beginTransaction();
            DaoVentaCreditoLetra daoVentaCreditoLetra = new DaoVentaCreditoLetra();
            //leer ventaCreditoLetra existentes
            this.ventaCreditoLetraList = daoVentaCreditoLetra.leerPorCodigoCliente(this.session, codVenta);
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
        return this.ventaCreditoLetraList;
    }

    /**
     * Retorna solo las VCL activos, ya que también hay anuladas ordenados
     * fechaVencimiento(asc).
     *
     * @param codVenta
     * @param cerrarSession
     * @return
     */
    public List<VentaCreditoLetra> leerActivoPorCodigoClienteOrdenadoFechaVencimiento(int codVenta, boolean cerrarSession) {
        this.session = null;
        this.transaction = null;
        this.error = null;
        try {
            this.session = HibernateUtil.getSessionFactory().openSession();
            this.transaction = session.beginTransaction();
            DaoVentaCreditoLetra daoVentaCreditoLetra = new DaoVentaCreditoLetra();
            //leer ventaCreditoLetra existentes
            this.ventaCreditoLetraList = daoVentaCreditoLetra.leerPorCodigoClienteOrderFechaVencimientoAsc(this.session, codVenta);
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
        return this.ventaCreditoLetraList;
    }

    /**
     * Retorna solo las VCL activos, ya que también hay anuladas
     *
     * @param codVenta
     * @param cerrarSession
     * @return
     */
    public List<VentaCreditoLetra> leerActivoPorCodigoVenta(int codVenta, boolean cerrarSession) {
        this.session = null;
        this.transaction = null;
        this.error = null;
        try {
            this.session = HibernateUtil.getSessionFactory().openSession();
            this.transaction = session.beginTransaction();
            DaoVentaCreditoLetra daoVentaCreditoLetra = new DaoVentaCreditoLetra();
            //leer ventaCreditoLetra existentes
            this.ventaCreditoLetraList = daoVentaCreditoLetra.leerPorCodigoVenta(this.session, codVenta);
            //quitamos los anulados
            int tam = this.ventaCreditoLetraList.size();
            for (int i = 0; i < tam; i++) {
                //obtenemos en objVCL
                this.ventaCreditoLetra = this.ventaCreditoLetraList.get(i);
                //si se encuentra anulado
                if (!"1".equals(this.ventaCreditoLetra.getRegistro().substring(0, 1))) {
                    //regresamos una posicion ya que al ser quitada la posicion actual este será "reemplazada"
                    this.ventaCreditoLetraList.remove(i);
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
        return this.ventaCreditoLetraList;
    }

    /**
     * Retorna solo las VCL activos, ya que también hay anuladas.
     *
     * @param codVenta
     * @param cerrarSession
     * @return
     */
    public List<VentaCreditoLetra> leerActivoPorCodigoVentaActivo(int codVenta, boolean cerrarSession) {
        this.session = null;
        this.transaction = null;
        this.error = null;
        try {
            this.session = HibernateUtil.getSessionFactory().openSession();
            this.transaction = session.beginTransaction();
            DaoVentaCreditoLetra daoVentaCreditoLetra = new DaoVentaCreditoLetra();
            //leer ventaCreditoLetra existentes
            this.ventaCreditoLetraList = daoVentaCreditoLetra.leerPorCodigoVentaActivos(this.session, codVenta);
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
        return this.ventaCreditoLetraList;
    }

    public List<Object[]> leerResumenPorCodigoCliente(int codCliente) {
        this.session = null;
        this.transaction = null;
        this.error = null;
        try {
            this.session = HibernateUtil.getSessionFactory().openSession();
            this.transaction = session.beginTransaction();
            DaoVentaCreditoLetra daoVentaCreditoLetra = new DaoVentaCreditoLetra();
            //obtener resumen
            this.ventaCreditoLetraObjects = daoVentaCreditoLetra.leerResumenPorCodigoCliente(this.session, codCliente);
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
        return this.ventaCreditoLetraObjects;
    }

    public List<Object[]> leerLetrasVencidasOrdenNombresC(Date fechaInicio, Date FechaFin) {
        this.session = null;
        this.transaction = null;
        this.error = null;
        try {
            this.session = HibernateUtil.getSessionFactory().openSession();
            this.transaction = session.beginTransaction();
            DaoVentaCreditoLetra daoVentaCreditoLetra = new DaoVentaCreditoLetra();
            //obtener resumen
            this.ventaCreditoLetraObjects = daoVentaCreditoLetra.leerLetrasVencidasOrdenNombresC(this.session, fechaInicio, FechaFin);
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
        return this.ventaCreditoLetraObjects;
    }
    
    public List<Object[]> leerLetrasVencidasOrdenDireccion(Date fechaInicio, Date FechaFin) {
        this.session = null;
        this.transaction = null;
        this.error = null;
        try {
            this.session = HibernateUtil.getSessionFactory().openSession();
            this.transaction = session.beginTransaction();
            DaoVentaCreditoLetra daoVentaCreditoLetra = new DaoVentaCreditoLetra();
            //obtener resumen
            this.ventaCreditoLetraObjects = daoVentaCreditoLetra.leerLetrasVencidasOrdenDireccion(this.session, fechaInicio, FechaFin);
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
        return this.ventaCreditoLetraObjects;
    }

    public boolean actualizarInteresPorCodigoCliente(int codCliente) {
        boolean est = false;
        this.session = null;
        this.transaction = null;
        this.error = null;
        try {
            this.session = HibernateUtil.getSessionFactory().openSession();
            this.transaction = session.beginTransaction();
            DaoVentaCreditoLetra daoVentaCreditoLetra = new DaoVentaCreditoLetra();
            //leer ventaCreditoLetra existentes
            this.ventaCreditoLetraList = daoVentaCreditoLetra.leerPorCodigoCliente(this.session, codCliente);
            //quitamos los anulados
            int tam = this.ventaCreditoLetraList.size();
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
            Double interesSumar;
            //obtenemos el factor de interes
            double factorInteres = (new cDatosExtras().leer_interesFactor().getDecimalDato() / 100) / 30;
            //
            System.out.println("Antes de for de actualización de intereses.");
            for (int i = 0; i < tam; i++) {
                //obtenemos en objVCL
                this.ventaCreditoLetra = this.ventaCreditoLetraList.get(i);
                //Ver
                System.out.println(this.ventaCreditoLetra.getDetalleLetra() + ":::" + this.ventaCreditoLetra.getMonto());
                //si tiene deuda en el saldo capital
                if (this.ventaCreditoLetra.getMonto() - this.ventaCreditoLetra.getTotalPago() > 0) {
                    //si ultimocalculo es NULL o es menor a la fecha base <es decir que se hizo calculo hasta ayer>
                    if (null == this.ventaCreditoLetra.getInteresUltimoCalculo() || this.ventaCreditoLetra.getInteresUltimoCalculo().before(fechaBase)) {
                        //fechaVencimiento sea anterior a la fecha con espera
                        if (this.ventaCreditoLetra.getFechaVencimiento().before(fechaVencimientoConEspera)) {
                            //calculando dias atrasados
                            if (null == this.ventaCreditoLetra.getInteresUltimoCalculo()) {//se tomara el ultimo pago o la fecha de vencimiento
                                /*
                                 *si se hizo un pago antes de la fecha de vencimiento los dias de retraso seran negativos
                                 */
                                diasRetraso = new Fecha().diasDiferencia(
                                        fechaBase,
                                        this.ventaCreditoLetra.getFechaPago() != null
                                        ? (this.ventaCreditoLetra.getFechaPago().before(this.ventaCreditoLetra.getFechaVencimiento())
                                        ? this.ventaCreditoLetra.getFechaVencimiento()
                                        : this.ventaCreditoLetra.getFechaPago())
                                        : this.ventaCreditoLetra.getFechaVencimiento());
                            } else {
                                diasRetraso = new cManejoFechas().diferenciaDosDias(fechaBase, this.ventaCreditoLetra.getInteresUltimoCalculo());
                            }
                            //si sale negativo
                            diasRetraso = diasRetraso < 0 ? 0 : diasRetraso;
                            //calculando lo que se sumará
                            interesSumar = (this.ventaCreditoLetra.getMonto() - this.ventaCreditoLetra.getTotalPago()) * factorInteres * diasRetraso;
                            //Redondeando interes
                            interesSumar = Double.parseDouble(Utilitarios.decimalFormato(interesSumar, 2));
                            //procedemos a actualizar el interes
                            this.ventaCreditoLetra.setInteres(interesSumar + this.ventaCreditoLetra.getInteres());
                            //setear fecha de interes
                            this.ventaCreditoLetra.setInteresUltimoCalculo(fechaBase);
                            //llamar al método update
                            daoVentaCreditoLetra.persistir(this.session, this.ventaCreditoLetra);
                        }
                    }
                }
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
     *
     * @param ventaCreditoLetraList
     * @param fechaBase formato dd/mm/yyyy
     * @return
     */
    public List<VentaCreditoLetra> VCLInteresesActualizados(List<VentaCreditoLetra> ventaCreditoLetraList, Date fechaBase) {
        ejbDatosExtras = new EjbDatosExtras();
        //leer ventaCreditoLetra existentes
        this.ventaCreditoLetraList = ventaCreditoLetraList;
        //Obtener tamaño
        int tam = this.ventaCreditoLetraList.size();
        //obtener los días de espera que se restará para no calcular interés: ej las que se vencen hoy
        int diaEspera = ejbDatosExtras.diaEspera();//******EJB*****
        //fecha desde la cual se considera vencida para generar los intereses
        Date fechaVencimientoConEspera = new Fecha().sumarDias(fechaBase, -diaEspera);
        //quitar horas a fecha
        fechaVencimientoConEspera = new Fecha().fechaHoraAFecha(fechaVencimientoConEspera);
        //variables
        int diasRetrasoCalculoInteres;
        Double interesSumar;
        //obtenemos el factor de interes
        double interes = ejbDatosExtras.interesFactor(); //Factor de interés
        double factorInteres = (interes / 100) / 30;
        for (int i = 0; i < tam; i++) {
            //obtenemos en objVCL
            this.ventaCreditoLetra = this.ventaCreditoLetraList.get(i);
            //si tiene deuda en el saldo capital
            if (this.ventaCreditoLetra.getMonto() - this.ventaCreditoLetra.getTotalPago() > 0) {
                //si ultimocalculo es NULL o es menor a la fecha base <es decir que se hizo calculo hasta ayer>
                if (null == this.ventaCreditoLetra.getInteresUltimoCalculo() || this.ventaCreditoLetra.getInteresUltimoCalculo().before(fechaBase)) {
                    //fechaVencimiento sea anterior a la fecha con espera
                    if (this.ventaCreditoLetra.getFechaVencimiento().before(fechaVencimientoConEspera)) {
                        //calculando dias atrasados
                        if (null == this.ventaCreditoLetra.getInteresUltimoCalculo()) {//se tomara el ultimo pago o la fecha de vencimiento
                                /*
                             *si se hizo un pago antes de la fecha de vencimiento los dias de retraso seran negativos
                             */
                            diasRetrasoCalculoInteres = new Fecha().diasDiferencia(
                                    fechaBase,
                                    this.ventaCreditoLetra.getFechaPago() != null
                                    ? (this.ventaCreditoLetra.getFechaPago().before(this.ventaCreditoLetra.getFechaVencimiento())
                                    ? this.ventaCreditoLetra.getFechaVencimiento()
                                    : this.ventaCreditoLetra.getFechaPago())
                                    : this.ventaCreditoLetra.getFechaVencimiento());
                        } else {
                            diasRetrasoCalculoInteres = new cManejoFechas().diferenciaDosDias(fechaBase, this.ventaCreditoLetra.getInteresUltimoCalculo());
                        }
                        //si sale negativo
                        diasRetrasoCalculoInteres = diasRetrasoCalculoInteres < 0 ? 0 : diasRetrasoCalculoInteres;
                        //calculando lo que se sumará
                        interesSumar = (this.ventaCreditoLetra.getMonto() - this.ventaCreditoLetra.getTotalPago()) * factorInteres * diasRetrasoCalculoInteres;
                        //Redondeando interes
                        interesSumar = Double.parseDouble(Utilitarios.decimalFormato(interesSumar, 2));
                        //procedemos a actualizar el interes                            
                        this.ventaCreditoLetra.setInteres(interesSumar + this.ventaCreditoLetra.getInteres());
                        //setear fecha de interes
                        this.ventaCreditoLetra.setInteresUltimoCalculo(fechaBase);
                    }
                }
            }
            //Necesitamos actulizar cada posición de la lista
            this.ventaCreditoLetraList.set(i, this.ventaCreditoLetra);
        }//fin for
        return this.ventaCreditoLetraList;
    }

    public VentaCreditoLetra getVentaCreditoLetra() {
        return ventaCreditoLetra;
    }

    public void setVentaCreditoLetra(VentaCreditoLetra ventaCreditoLetra) {
        this.ventaCreditoLetra = ventaCreditoLetra;
    }

    public List<VentaCreditoLetra> getVentaCreditoLetraList() {
        return ventaCreditoLetraList;
    }

    public void setVentaCreditoLetraList(List<VentaCreditoLetra> VentaCreditoLetraList) {
        this.ventaCreditoLetraList = VentaCreditoLetraList;
    }

    public List<Object[]> getVentaCreditoLetraObjects() {
        return ventaCreditoLetraObjects;
    }

    public void setVentaCreditoLetraObjects(List<Object[]> ventaCreditoLetraObjects) {
        this.ventaCreditoLetraObjects = ventaCreditoLetraObjects;
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

}
