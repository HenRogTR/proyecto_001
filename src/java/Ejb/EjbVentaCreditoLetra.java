/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package Ejb;

import Dao.DaoVentaCreditoLetra;
import HiberanteUtil.HibernateUtil;
import clases.cFecha;
import java.util.Date;
import java.util.List;
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

    private VentaCreditoLetra ventaCreditoLetra;
    private List<VentaCreditoLetra> ventaCreditoLetraList;
    private List<Object[]> ventaCreditoLetraObjects;

    private String error;
    private Session session;
    private Transaction transaction;

    public EjbVentaCreditoLetra() {
        ventaCreditoLetra = new VentaCreditoLetra();
        ventaCreditoLetraList = null;
        ventaCreditoLetraObjects = null;

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
            Date fechaBase = cFecha.fechaHoraAFecha(new Date());
            //quitar horas a fecha
            //obtneer los dias de espera que se restará para no calcular interes: ej las que se vencen hoy
            int diaEspera = new cDatosExtras().leer_diaEspera().getEntero();//******EJB*****
            //fecha desde la cual se considera vencida para generar los intereses
            Date fechaVencimientoConEspera = cFecha.sumarDias(fechaBase, -diaEspera);
            //quitar horas a fecha
            fechaVencimientoConEspera = cFecha.fechaHoraAFecha(fechaVencimientoConEspera);
            //variables
            int diasRetraso = 0;
            Double interesSumar = 0.00;
            for (int i = 0; i < tam; i++) {
                //obtenemos en objVCL
                this.ventaCreditoLetra = this.ventaCreditoLetraList.get(i);
                //si tiene deuda en el saldo capital
                if (this.ventaCreditoLetra.getMonto() - this.ventaCreditoLetra.getTotalPago() > 0) {
                    //si ultimocalculo es NULL o es menor a la fecha base<es decir que se hizo calculo hasta ayer>
                    if (null == this.ventaCreditoLetra.getInteresUltimoCalculo() || this.ventaCreditoLetra.getInteresUltimoCalculo().before(fechaBase)) {
                        //fechaVencimiento sea anterior a la fecha con espera
                        if (this.ventaCreditoLetra.getFechaVencimiento().before(fechaVencimientoConEspera)) {
                            //obtenemos el factor de interes
                            double factorInteres = (new cDatosExtras().leer_interesFactor().getDecimalDato() / 100) / 30;
                            //calculando dias atrasados
                            if (null == this.ventaCreditoLetra.getInteresUltimoCalculo()) {//se tomara el ultimo pago o la fecha de vencimiento
                                /*
                                 *si se hizo un pago antes de la fecha de vencimiento los dias de retraso seran negativos
                                 */
                                diasRetraso = cFecha.diasDiferencia(fechaBase, this.ventaCreditoLetra.getFechaPago() != null ? this.ventaCreditoLetra.getFechaPago() : this.ventaCreditoLetra.getFechaVencimiento());
                            } else {
                                diasRetraso = new cManejoFechas().diferenciaDosDias(fechaBase, this.ventaCreditoLetra.getInteresUltimoCalculo());
                            }
                            //si sale negativo
                            diasRetraso = diasRetraso < 0 ? 0 : diasRetraso;
                            //calculando lo que se sumará
                            interesSumar = (this.ventaCreditoLetra.getMonto() - this.ventaCreditoLetra.getTotalPago()) * factorInteres * diasRetraso;
                            //procedemos a actualizar el interes
                            System.out.println(this.ventaCreditoLetra.getVentaCredito().getVentas().getDocSerieNumero() + "\t" + this.ventaCreditoLetra.getDetalleLetra() + "\t int: " + this.ventaCreditoLetra.getInteres());
                            this.ventaCreditoLetra.setInteres(interesSumar + this.ventaCreditoLetra.getInteres());
                            //setear fecha de interes
                            this.ventaCreditoLetra.setInteresUltimoCalculo(fechaBase);
                            System.out.println(">>>>> " + this.ventaCreditoLetra.getVentaCredito().getVentas().getDocSerieNumero() + "\t" + this.ventaCreditoLetra.getDetalleLetra() + "\t int: " + this.ventaCreditoLetra.getInteres());
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

}
