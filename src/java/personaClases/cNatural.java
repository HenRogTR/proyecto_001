/*
 * To change this template, choose Tools | Templates
 * and open the template in the editor.
 */
package personaClases;

import java.util.List;
import org.hibernate.Query;
import org.hibernate.Session;
import tablas.HibernateUtil;
import tablas.PNatural;
import utilitarios.cOtros;

/**
 *
 * @author Henrri
 */
public class cNatural {

    Session sesion = null;
    public String error;

    public String getError() {
        return error;
    }

    public void setError(String error) {
        this.sesion = HibernateUtil.getSessionFactory().getCurrentSession();
        this.error = error;
    }

    public int Crear(PNatural objNatural) {
        setError(null);
        sesion = HibernateUtil.getSessionFactory().openSession();
        sesion.getTransaction().begin();
        try {
            int codNatural = (Integer) sesion.save(objNatural);
            sesion.getTransaction().commit();
            return codNatural;
        } catch (Exception e) {
            sesion.getTransaction().rollback();
            e.printStackTrace();
            setError(e.getMessage());
        }
        return 0;
    }

    public List leer() {
        setError(null);
        try {
            sesion = HibernateUtil.getSessionFactory().openSession();
            Query q = sesion.createQuery("from PNatural where substring(registro,1,1)=1");
            return (List) q.list();
        } catch (Exception e) {
            setError(e.getMessage());
        }
        return null;
    }

    public List leer_admin() {
        setError(null);
        try {
            sesion = HibernateUtil.getSessionFactory().openSession();
            Query q = sesion.createQuery("from PNatural");
            return (List) q.list();
        } catch (Exception e) {
            setError(e.getMessage());
        }
        return null;
    }

    public boolean actualizar(PNatural objNatural) {
        sesion = HibernateUtil.getSessionFactory().openSession();
        sesion.getTransaction().begin();
        try {
            sesion.update(objNatural);
            sesion.getTransaction().commit();
            return true;
        } catch (Exception e) {
            sesion.getTransaction().rollback();
            e.printStackTrace();
            setError(e.getMessage());
        }
        return false;
    }

    public boolean actualizar_registro(int codNatural, String estado, String user) {
        sesion = HibernateUtil.getSessionFactory().openSession();
        sesion.getTransaction().begin();
        PNatural obj = (PNatural) sesion.get(PNatural.class, codNatural);
        obj.setRegistro(new cOtros().registro(estado, user));
        try {
            sesion.update(obj);
            sesion.getTransaction().commit();
            return true;
        } catch (Exception e) {
            sesion.getTransaction().rollback();
            setError("Natural_actualizar_est: " + e.getMessage());
        }
        return false;
    }
}
