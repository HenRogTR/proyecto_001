/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package Ejb;

import Dao.DaoPersonal;
import HiberanteUtil.HibernateUtil;
import java.util.ArrayList;
import java.util.List;
import javax.ejb.Stateless;
import org.hibernate.Session;
import org.hibernate.Transaction;
import tablas.Personal;

/**
 *
 * @author Henrri
 */
@Stateless
public class EjbPersonal {

    private Personal personal;
    private List<Personal> personalList;

    private String error;
    private Session session;
    private Transaction transaction;

    public EjbPersonal() {
        this.personal = new Personal();
        this.personalList = new ArrayList<Personal>();
        this.error = null;
    }

    public Personal leerPorCodigoPersonal(int codPersonal, boolean cerrarSession) {
        this.session = null;
        this.transaction = null;
        this.error = null;
        try {
            this.session = HibernateUtil.getSessionFactory().openSession();
            this.transaction = session.beginTransaction();
            DaoPersonal daoPersonal = new DaoPersonal();
            //leer un personal por código de cliente
            this.personal = daoPersonal.leerPorCodigoPersonal(this.session, codPersonal);
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
        return this.personal;
    }

    public Personal leerPorCodigoPersona(int codPersona, boolean cerrarSession) {
        this.session = null;
        this.transaction = null;
        this.error = null;
        try {
            this.session = HibernateUtil.getSessionFactory().openSession();
            this.transaction = session.beginTransaction();
            DaoPersonal daoPersonal = new DaoPersonal();
            //leer un personal por código de cliente
            this.personal = daoPersonal.leerPorCodigoPersona(this.session, codPersona);
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
        return this.personal;
    }

    public Personal getPersonal() {
        return personal;
    }

    public void setPersonal(Personal personal) {
        this.personal = personal;
    }

    public List<Personal> getPersonalList() {
        return personalList;
    }

    public void setPersonalList(List<Personal> personalList) {
        this.personalList = personalList;
    }

    public String getError() {
        return error;
    }

    public void setError(String error) {
        this.error = error;
    }

}
