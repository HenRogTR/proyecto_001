/*
 * To change this template, choose Tools | Templates
 * and open the template in the editor.
 */
package ventaClases;

import java.util.List;
import org.hibernate.Query;
import org.hibernate.Session;
import org.hibernate.Transaction;
import HiberanteUtil.HibernateUtil;
import tablas.VentasSerieNumero;

/**
 *
 * @author Henrri
 */
public class cVentasSerieNumero {

    Session sesion = null;
    public String error;

    public String getError() {
        return error;
    }

    public void setError(String error) {
        this.error = error;
    }

    public cVentasSerieNumero() {
        this.sesion = HibernateUtil.getSessionFactory().getCurrentSession();
    }

    public int crear(VentasSerieNumero objVentasSerieNumero) {
        int cod = 0;
        Transaction trns = null;
        sesion = HibernateUtil.getSessionFactory().openSession();
        try {
            trns = sesion.beginTransaction();
            cod = (Integer) sesion.save(objVentasSerieNumero);
            sesion.getTransaction().commit();
        } catch (Exception e) {
            if (trns != null) {
                trns.rollback();
            }
            e.printStackTrace();
            setError(e.getMessage());
        } finally {
            sesion.flush();
            sesion.close();
        }
        return cod;
    }

    public List leer() {
        setError(null);
        try {
            sesion = HibernateUtil.getSessionFactory().openSession();
            Query q = sesion.createQuery("from VentasSerieNumero where substring(registro,1,1)=1");
            return (List) q.list();
        } catch (Exception e) {
            setError(e.getMessage());
        }
        return null;
    }

    public VentasSerieNumero leer_cod(int codVentasSerieNumero) {
        sesion = HibernateUtil.getSessionFactory().openSession();
        return (VentasSerieNumero) sesion.get(VentasSerieNumero.class, codVentasSerieNumero);
    }
    
    public List leer_serieNumero(String serieNumero) {
        setError(null);
        sesion = HibernateUtil.getSessionFactory().openSession();
        try {
            Query q = sesion.createQuery("from VentasSerieNumero c "
                    + "where substring(registro,1,1)=1 "
                    + "and c.serieNumero like :serieNumero")
                    .setParameter("serieNumero", "%"+serieNumero+"%");
            return q.list();
        } catch (Exception e) {
            setError(e.getMessage());
        }
        return null;
    }
}
