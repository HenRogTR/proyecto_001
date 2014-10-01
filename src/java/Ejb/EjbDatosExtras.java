/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package Ejb;

import Dao.DaoDatosExtras;
import HiberanteUtil.HibernateUtil;
import java.util.List;
import javax.ejb.Stateless;
import org.hibernate.Session;
import org.hibernate.Transaction;
import tablas.DatosExtras;

/**
 *
 * @author Henrri
 */
@Stateless
public class EjbDatosExtras {

    public DatosExtras datosExtras;
    public List<DatosExtras> datosExtrasList;

    private String error;
    private Session session;
    private Transaction transaction;

    public EjbDatosExtras() {
        this.datosExtras = new DatosExtras();
        this.datosExtrasList = null;
    }

    /**
     * Interes de factor mensualmente.
     *
     * @return Interés 2.5%
     */
    public Double interesFactor() {
        Double interes = 0.00;
        this.session = null;
        this.transaction = null;
        this.error = null;
        try {
            this.session = HibernateUtil.getSessionFactory().openSession();
            this.transaction = session.beginTransaction();
            DaoDatosExtras daoDatosExtras = new DaoDatosExtras();
            this.datosExtras = daoDatosExtras.interesFactor(this.session);
            //Verificar que haya dato
            if (this.datosExtras != null) {
                interes = this.datosExtras.getDecimalDato();
            }
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
        return interes;
    }
    
    public int diaEspera() {
        int diaEspera = 0;
        this.session = null;
        this.transaction = null;
        this.error = null;
        try {
            this.session = HibernateUtil.getSessionFactory().openSession();
            this.transaction = session.beginTransaction();
            DaoDatosExtras daoDatosExtras = new DaoDatosExtras();
            this.datosExtras = daoDatosExtras.diaEspera(this.session);
            //Verificar que haya dato
            if (this.datosExtras != null) {
                diaEspera = this.datosExtras.getEntero();
            }
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
        return diaEspera;
    }

    public DatosExtras getDatosExtras() {
        return datosExtras;
    }

    public void setDatosExtras(DatosExtras datosExtras) {
        this.datosExtras = datosExtras;
    }

    public List<DatosExtras> getDatosExtrasList() {
        return datosExtrasList;
    }

    public void setDatosExtrasList(List<DatosExtras> datosExtrasList) {
        this.datosExtrasList = datosExtrasList;
    }

    public String getError() {
        return error;
    }

    public void setError(String error) {
        this.error = error;
    }

}
