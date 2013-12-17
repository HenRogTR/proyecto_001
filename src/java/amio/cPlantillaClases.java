/*
 * To change this template, choose Tools | Templates
 * and open the template in the editor.
 */
package amio;

import java.util.List;
import org.hibernate.Query;
import org.hibernate.Transaction;
import org.hibernate.classic.Session;
import otros.cUtilitarios;
import tablas.HibernateUtil;

/**
 *
 * @author Henrri
 */
public class cPlantillaClases {

    Session sesion = null;
    public String error;

    public String getError() {
        return error;
    }

    public void setError(String error) {
        this.error = error;
    }

    public cPlantillaClases() {
        this.sesion = HibernateUtil.getSessionFactory().getCurrentSession();
    }

    public int crear(Tabla objTabla) {
        int cod = 0;
        Transaction trns = null;
        sesion = HibernateUtil.getSessionFactory().openSession();
        try {
            trns = sesion.beginTransaction();
            cod = (Integer) sesion.save(objTabla);
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
        List objList = null;
        setError(null);
        Session session = HibernateUtil.getSessionFactory().openSession();
        try {
            session.flush();
            Query q = session.createQuery("from Tabla");
            objList = q.list();
        } catch (Exception e) {
            setError(e.getMessage());
        }
        return objList;
    }

    public List leer_admin() {
        setError(null);
        try {
            sesion = HibernateUtil.getSessionFactory().openSession();
            Query q = sesion.createQuery("from Tabla");
            return (List) q.list();
        } catch (Exception e) {
            setError(e.getMessage());
        }
        return null;
    }

    public boolean actualizar_registro(int codTabla, String estado, String user) {
        cUtilitarios objUtilitarios = new cUtilitarios();
        setError(null);
        sesion = HibernateUtil.getSessionFactory().openSession();
        sesion.getTransaction().begin();
        Tabla obj = (Tabla) sesion.get(Tabla.class, codTabla);
        obj.setRegistro(objUtilitarios.registro(estado, user));
        try {
            sesion.update(obj);
            sesion.getTransaction().commit();
            return true;
        } catch (Exception e) {
            sesion.getTransaction().rollback();
            setError("Tabla_actualizar_registro: " + e.getMessage());
        }
        return false;
    }
}
