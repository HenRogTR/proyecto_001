/*
 * To change this template, choose Tools | Templates
 * and open the template in the editor.
 */
package compraClases;

import java.util.List;
import org.hibernate.Query;
import org.hibernate.Session;
import otros.cUtilitarios;
import tablas.Almacen;
import tablas.HibernateUtil;

/**
 *
 * @author Henrri
 */
public class cAlmacen {

    Session sesion = null;
    public String error;

    public String getError() {
        return error;
    }

    public void setError(String error) {
        this.error = error;
    }

    public cAlmacen() {
        this.sesion = HibernateUtil.getSessionFactory().getCurrentSession();
    }

    public int Crear(Almacen objAlmacen) {
        setError(null);
        sesion = HibernateUtil.getSessionFactory().openSession();
        sesion.getTransaction().begin();
        try {
            int codPersona = (Integer) sesion.save(objAlmacen);
            sesion.getTransaction().commit();
            return codPersona;
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
            Query q = sesion.createQuery("from Almacen where substring(registro,1,1)=1");
            return (List) q.list();
        } catch (Exception e) {
            setError(e.getMessage());
        }
        return null;
    }

    public Almacen leer_cod(int codAlmacen) {
        sesion = HibernateUtil.getSessionFactory().openSession();
        return (Almacen) sesion.get(Almacen.class, codAlmacen);
    }

    public List leer_admin() {
        setError(null);
        try {
            sesion = HibernateUtil.getSessionFactory().openSession();
            Query q = sesion.createQuery("from Almacen");
            return (List) q.list();
        } catch (Exception e) {
            setError(e.getMessage());
        }
        return null;
    }

    public boolean actualizar_registro(int codAlmacen, String estado, String user) {
        cUtilitarios objUtilitarios = new cUtilitarios();
        setError(null);
        sesion = HibernateUtil.getSessionFactory().openSession();
        sesion.getTransaction().begin();
        Almacen obj = (Almacen) sesion.get(Almacen.class, codAlmacen);
        obj.setRegistro(objUtilitarios.registro(estado, user));
        try {
            sesion.update(obj);
            sesion.getTransaction().commit();
            return true;
        } catch (Exception e) {
            sesion.getTransaction().rollback();
            setError("Almacen_actualizar_registro: " + e.getMessage());
        }
        return false;
    }
}
