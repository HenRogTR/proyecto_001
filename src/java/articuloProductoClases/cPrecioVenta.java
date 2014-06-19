/*
 * To change this template, choose Tools | Templates
 * and open the template in the editor.
 */
package articuloProductoClases;

import java.util.List;
import org.hibernate.Query;
import org.hibernate.Session;
import org.hibernate.Transaction;
import HiberanteUtil.HibernateUtil;
import tablas.PrecioVenta;
import utilitarios.cOtros;

/**
 *
 * @author Henrri
 */
public class cPrecioVenta {

    Session sesion = null;
    public String error;

    public String getError() {
        return error;
    }

    public void setError(String error) {
        this.error = error;
    }

    public cPrecioVenta() {
        this.sesion = HibernateUtil.getSessionFactory().getCurrentSession();
        this.error = null;
    }

    public boolean crear(PrecioVenta objPrecioVenta) {
        Boolean est = false;
        Transaction trns = null;
        sesion = HibernateUtil.getSessionFactory().openSession();
        try {
            trns = sesion.beginTransaction();
            sesion.save(objPrecioVenta);
            sesion.getTransaction().commit();
            est = true;
        } catch (Exception e) {
            if (trns != null) {
                trns.rollback();
            }
            e.printStackTrace();
        } finally {
            sesion.flush();
            sesion.close();
        }
        return est;
    }

    public List leer() {
        try {
            sesion = HibernateUtil.getSessionFactory().openSession();
            Query q = sesion.createQuery("from PrecioVenta where substring(registro,1,1)=1");
            return (List) q.list();
        } catch (Exception e) {
            e.printStackTrace();
            setError(e.getMessage());
        }
        return null;
    }

    public List leer_admin() {
        try {
            sesion = HibernateUtil.getSessionFactory().openSession();
            Query q = sesion.createQuery("from PrecioVenta");
            return (List) q.list();
        } catch (Exception e) {
            e.printStackTrace();
            setError(e.getMessage());
        }
        return null;
    }

    public boolean actualizar_registro(int codPrecioVenta, String estado, String user) {
        cOtros objcOtros = new cOtros();
        sesion = HibernateUtil.getSessionFactory().openSession();
        sesion.getTransaction().begin();
        PrecioVenta obj = (PrecioVenta) sesion.get(PrecioVenta.class, codPrecioVenta);
        obj.setRegistro(objcOtros.registro(estado, user));
        try {
            sesion.update(obj);
            sesion.getTransaction().commit();
            return true;
        } catch (Exception e) {
            sesion.getTransaction().rollback();
            e.printStackTrace();
            setError(e.getMessage());
        }
        return false;
    }
}
