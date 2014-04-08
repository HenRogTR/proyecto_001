/*
 * To change this template, choose Tools | Templates
 * and open the template in the editor.
 */
package otrasTablasClases;

import java.util.List;
import org.hibernate.Query;
import org.hibernate.Session;
import org.hibernate.Transaction;
import tablas.DatosExtras;
import tablas.HibernateUtil;

/**
 *
 * @author Henrri
 */
public class cDatosExtras {

    Session sesion = null;
    public String error;

    public String getError() {
        return error;
    }

    public void setError(String error) {
        this.error = error;
    }

    public cDatosExtras() {
        this.sesion = HibernateUtil.getSessionFactory().getCurrentSession();
        this.error = null;
    }

    public List leer_cobranza() {
        List l = null;
        Transaction trns = null;
        sesion = HibernateUtil.getSessionFactory().openSession();
        try {
            trns = sesion.beginTransaction();
            Query q = sesion.createQuery("from DatosExtras de"
                    + " where substring(de.registro,1,1) = 1"
                    + " and de.descripcionDato = 'serieCobranza'");
            l = q.list();
        } catch (Exception e) {
            e.printStackTrace();
            setError(e.getMessage());
        } finally {
            sesion.flush();
            sesion.close();
        }
        return l;
    }

    public List leer_ticketera() {
        List l = null;
        Transaction trns = null;
        sesion = HibernateUtil.getSessionFactory().openSession();
        try {
            trns = sesion.beginTransaction();
            Query q = sesion.createQuery("from DatosExtras de"
                    + " where substring(de.registro,1,1) = 1"
                    + " and de.descripcionDato = 'ticketera1'");
            l = q.list();
        } catch (Exception e) {
            e.printStackTrace();
            setError(e.getMessage());
        } finally {
            sesion.flush();
            sesion.close();
        }
        return l;
    }

    public List leer_documentoCaja() {
        List l = null;
        Transaction trns = null;
        sesion = HibernateUtil.getSessionFactory().openSession();
        try {
            trns = sesion.beginTransaction();
            Query q = sesion.createQuery("from DatosExtras de"
                    + " where substring(de.registro,1,1) = 1"
                    + " and de.descripcionDato = 'documentoCaja'");
            l = q.list();
        } catch (Exception e) {
            e.printStackTrace();
            setError(e.getMessage());
        } finally {
            sesion.flush();
            sesion.close();
        }
        return l;
    }

    public List leer_documentoDescuento() {
        List l = null;
        Transaction trns = null;
        sesion = HibernateUtil.getSessionFactory().openSession();
        try {
            trns = sesion.beginTransaction();
            Query q = sesion.createQuery("from DatosExtras de"
                    + " where substring(de.registro,1,1) = 1"
                    + " and de.descripcionDato = 'documentoDescuento'");
            l = q.list();
        } catch (Exception e) {
            e.printStackTrace();
            setError(e.getMessage());
        } finally {
            sesion.flush();
            sesion.close();
        }
        return l;
    }

    /**
     *
     * @return getEntero() -> codCobrador asigando por defecto
     */
    public DatosExtras cobradorDefecto() {
        DatosExtras obj = null;
        Transaction trns = null;
        sesion = HibernateUtil.getSessionFactory().openSession();
        try {
            trns = sesion.beginTransaction();
            Query q = sesion.createQuery("from DatosExtras de"
                    + " where substring(de.registro,1,1) = 1"
                    + " and de.descripcionDato = 'cobradorDefecto'");
            obj = (DatosExtras) q.list().get(0);
        } catch (Exception e) {
            e.printStackTrace();
            setError(e.getMessage());
        } finally {
            sesion.flush();
            sesion.close();
        }
        return obj;
    }

    public DatosExtras nombreEmpresa() {
        sesion = HibernateUtil.getSessionFactory().openSession();
        return (DatosExtras) sesion.get(DatosExtras.class, 1);
    }

    public DatosExtras rucEmpresa() {
        sesion = HibernateUtil.getSessionFactory().openSession();
        return (DatosExtras) sesion.get(DatosExtras.class, 2);
    }

    public DatosExtras direccionEmpresa() {
        sesion = HibernateUtil.getSessionFactory().openSession();
        return (DatosExtras) sesion.get(DatosExtras.class, 3);
    }

    public DatosExtras gerenteEmpresa() {
        sesion = HibernateUtil.getSessionFactory().openSession();
        return (DatosExtras) sesion.get(DatosExtras.class, 4);
    }

    public DatosExtras dniGerenteEmpresa() {
        sesion = HibernateUtil.getSessionFactory().openSession();
        return (DatosExtras) sesion.get(DatosExtras.class, 5);
    }

    public DatosExtras rucGerenteEmpresa() {
        sesion = HibernateUtil.getSessionFactory().openSession();
        return (DatosExtras) sesion.get(DatosExtras.class, 6);
    }
}
