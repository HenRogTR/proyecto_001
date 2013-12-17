/*
 * To change this template, choose Tools | Templates
 * and open the template in the editor.
 */
package articuloProductoClases;

import java.util.List;
import org.hibernate.Query;
import org.hibernate.Session;
import otros.cUtilitarios;
import tablas.Familia;
import tablas.HibernateUtil;

/**
 *
 * @author Henrri
 */
public class cFamilia {

    Session sesion = null;
    public String error;

    public String getError() {
        return error;
    }

    public void setError(String error) {
        this.error = error;
    }

    public cFamilia() {
        this.sesion = HibernateUtil.getSessionFactory().getCurrentSession();
    }

    public int Crear(Familia objFamilia) {
        setError(null);
        sesion = HibernateUtil.getSessionFactory().openSession();
        sesion.getTransaction().begin();
        try {
            int cod = (Integer) sesion.save(objFamilia);
            sesion.getTransaction().commit();
            return cod;
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
            Query q = sesion.createQuery("from Familia where substring(registro,1,1)=1");
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
            Query q = sesion.createQuery("from Familia");
            return (List) q.list();
        } catch (Exception e) {
            setError(e.getMessage());
        }
        return null;
    }

    public Familia leer_cod(int codFamilia) {
        sesion = HibernateUtil.getSessionFactory().openSession();
        return (Familia) sesion.get(Familia.class, codFamilia);
    }

    public boolean verficarFamilia(String familia) {
        setError(null);
        try {
            sesion = HibernateUtil.getSessionFactory().openSession();
            Query q = sesion.createQuery("from Familia where substring(registro,1,1)=1 and familia=:familia")
                    .setParameter("familia", familia);
            Familia objFamilia = (Familia) q.list().iterator().next();
            if (objFamilia != null) {
                return true;
            }
        } catch (Exception e) {
            setError(e.getMessage());
        }
        return false;
    }

    public boolean actualizar_registro(int codFamilia, String estado, String user) {
        cUtilitarios objUtilitarios = new cUtilitarios();
        setError(null);
        sesion = HibernateUtil.getSessionFactory().openSession();
        sesion.getTransaction().begin();
        Familia obj = (Familia) sesion.get(Familia.class, codFamilia);
        obj.setRegistro(objUtilitarios.registro(estado, user));
        try {
            sesion.update(obj);
            sesion.getTransaction().commit();
            return true;
        } catch (Exception e) {
            sesion.getTransaction().rollback();
            setError("Familia_actualizar_registro: " + e.getMessage());
        }
        return false;
    }

    public Familia leer_primero() {
        setError(null);
        sesion = HibernateUtil.getSessionFactory().openSession();
        try {
            sesion = HibernateUtil.getSessionFactory().openSession();
            Query q = sesion.createQuery("from Familia f "
                    + "where substring(f.registro,1,1)=1 "
                    + "order by f.codFamilia asc")
                    .setMaxResults(1);
            return ((Familia) q.list().iterator().next());
        } catch (Exception e) {
            setError(e.getMessage());
        }
        return null;
    }

    public Familia leer_ultimo() {
        setError(null);
        sesion = HibernateUtil.getSessionFactory().openSession();
        try {
            sesion = HibernateUtil.getSessionFactory().openSession();
            Query q = sesion.createQuery("from Familia f "
                    + "where substring(f.registro,1,1)=1 "
                    + "order by f.codFamilia desc")
                    .setMaxResults(1);
            return ((Familia) q.list().iterator().next());
        } catch (Exception e) {
            setError(e.getMessage());
        }
        return null;
    }

    public boolean actualizar(Familia objFamilia) {
        sesion = HibernateUtil.getSessionFactory().openSession();
        sesion.getTransaction().begin();
        try {
            sesion.update(objFamilia);
            sesion.getTransaction().commit();
            return true;
        } catch (Exception e) {
            sesion.getTransaction().rollback();
            setError(e.getMessage());
            return false;
        }
    }
}
