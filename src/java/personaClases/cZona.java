/*
 * To change this template, choose Tools | Templates
 * and open the template in the editor.
 */
package personaClases;

import java.util.List;
import org.hibernate.Query;
import org.hibernate.Session;
import otros.cUtilitarios;
import tablas.HibernateUtil;
import tablas.Zona;

/**
 *
 * @author Henrri
 */
public class cZona {

    Session sesion = null;
    public String error;

    public String getError() {
        return error;
    }

    public void setError(String error) {
        this.error = error;
    }

    public int Crear(Zona objZona) {
        setError(null);
        sesion = HibernateUtil.getSessionFactory().openSession();
        sesion.getTransaction().begin();
        try {
            int cod = (Integer) sesion.save(objZona);
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
            Query q = sesion.createQuery("from Zona where substring(registro,1,1)=1");
            return (List) q.list();
        } catch (Exception e) {
            setError(e.getMessage());
        }
        return null;
    }

    public Zona leer_cod(Integer codZona) {
        sesion = HibernateUtil.getSessionFactory().openSession();
        return (Zona) sesion.get(Zona.class, codZona);
    }

    public Zona leer_primero() {
        setError(null);
        sesion = HibernateUtil.getSessionFactory().openSession();
        try {
            Query q = sesion.createQuery("from Zona z where substring(z.registro,1,1)=1 "
                    + "order by z.codZona asc")
                    .setMaxResults(1);
            return (Zona) q.list().iterator().next();
        } catch (Exception e) {
            setError("Zona/leer_primero : " + e.getMessage());
            return null;
        }
    }

    public Zona leer_ultimo() {
        setError(null);
        sesion = HibernateUtil.getSessionFactory().openSession();
        try {
            Query q = sesion.createQuery("from Zona z where substring(z.registro,1,1)=1 "
                    + "order by z.codZona desc")
                    .setMaxResults(1);
            return (Zona) q.list().iterator().next();
        } catch (Exception e) {
            setError("Zona/leer_ultimo : " + e.getMessage());
            return null;
        }
    }

    public Zona leer_zona(String zona) {
        setError(null);
        sesion = HibernateUtil.getSessionFactory().openSession();
        try {
            Query q = sesion.createQuery("from Zona z where substring(z.registro,1,1)=1 "
                    + " and z.zona=:zona")
                    .setParameter("zona", zona)
                    .setMaxResults(1);
            return (Zona) q.list().iterator().next();
        } catch (Exception e) {
            setError("Zona/leer_zona : " + e.getMessage());
            return null;
        }
    }

    public boolean actualizar(Zona objZona) {
        sesion = HibernateUtil.getSessionFactory().openSession();
        sesion.getTransaction().begin();
        try {
            sesion.update(objZona);
            sesion.getTransaction().commit();
            return true;
        } catch (Exception e) {
            sesion.getTransaction().rollback();
            e.printStackTrace();
            setError(e.getMessage());
        }
        return false;
    }
    //***************************************************************

    public List leer_admin() {
        setError(null);
        try {
            sesion = HibernateUtil.getSessionFactory().openSession();
            Query q = sesion.createQuery("from Zona");
            return (List) q.list();
        } catch (Exception e) {
            setError(e.getMessage());
        }
        return null;
    }

    public boolean actualizar_registro(int codZona, String estado, String user) {
        cUtilitarios objUtilitarios = new cUtilitarios();
        setError(null);
        sesion = HibernateUtil.getSessionFactory().openSession();
        sesion.getTransaction().begin();
        Zona obj = (Zona) sesion.get(Zona.class, codZona);
        obj.setRegistro(objUtilitarios.registro(estado, user));
        try {
            sesion.update(obj);
            sesion.getTransaction().commit();
            return true;
        } catch (Exception e) {
            sesion.getTransaction().rollback();
            setError("Zona_actualizar_est: " + e.getMessage());
        }
        return false;
    }
}
