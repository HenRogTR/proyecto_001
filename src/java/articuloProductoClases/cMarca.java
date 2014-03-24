/*
 * To change this template, choose Tools | Templates
 * and open the template in the editor.
 */
package articuloProductoClases;

import java.util.List;
import org.hibernate.Query;
import org.hibernate.Session;
import org.hibernate.Transaction;
import otros.cUtilitarios;
import tablas.HibernateUtil;
import tablas.Marca;

/**
 *
 * @author Henrri
 */
public class cMarca {

    Session sesion = null;
    public String error;

    public String getError() {
        return error;
    }

    public void setError(String error) {
        this.error = error;
    }

    public cMarca() {
        this.sesion = HibernateUtil.getSessionFactory().getCurrentSession();
        this.error = null;
    }

    public int Crear(Marca objMarca) {
        int cod = 0;
        Transaction trns = null;
        sesion = HibernateUtil.getSessionFactory().openSession();
        try {
            trns = sesion.beginTransaction();
            cod = (Integer) sesion.save(objMarca);
            sesion.getTransaction().commit();
        } catch (Exception e) {
            if (trns != null) {
                trns.rollback();
            }
            setError(e.getMessage());
        } finally {
            sesion.flush();
            sesion.close();
        }
        return cod;
    }

    public List leer() {
        setError(null);
        sesion = HibernateUtil.getSessionFactory().openSession();
        try {
            sesion.flush();
            Query q = sesion.createQuery("from Marca m where substring(m.registro,1,1)=1");
            return (List) q.list();
        } catch (Exception e) {
            setError(e.getMessage());
        }
        return null;
    }

    public Marca leer_cod(int codMarca) {
        sesion = HibernateUtil.getSessionFactory().openSession();
        return (Marca) sesion.get(Marca.class, codMarca);
    }

    public List leer_admin() {
        setError(null);
        try {
            sesion = HibernateUtil.getSessionFactory().openSession();
            Query q = sesion.createQuery("from Marca");
            return (List) q.list();
        } catch (Exception e) {
            setError(e.getMessage());
        }
        return null;
    }

    /**
     *
     * @param marca
     * @return
     */
    public List leer_coincidencia_SC(String marca) {
        List l = null;
        Transaction trns = null;
        sesion = HibernateUtil.getSessionFactory().openSession();
        try {
            trns = sesion.beginTransaction();
            Query q = sesion.createQuery("from Marca m"
                    + " where m.descripcion like :par1")
                    .setString("par1", "%" + marca.replace(" ", "%") + "%");
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

    public boolean verficarMarca(String descripcion) {
        setError(null);
        try {
            sesion = HibernateUtil.getSessionFactory().openSession();
            Query q = sesion.createQuery("from Marca where substring(registro,1,1)=1 and descripcion=:descripcion")
                    .setParameter("descripcion", descripcion);
            Marca objMarca = (Marca) q.list().iterator().next();
            if (objMarca != null) {
                return true;
            }
        } catch (Exception e) {
            setError(e.getMessage());
        }
        return false;
    }

    public boolean actualizar_registro(int codMarca, String estado, String user) {
        cUtilitarios objUtilitarios = new cUtilitarios();
        setError(null);
        sesion = HibernateUtil.getSessionFactory().openSession();
        sesion.getTransaction().begin();
        Marca obj = (Marca) sesion.get(Marca.class, codMarca);
        obj.setRegistro(objUtilitarios.registro(estado, user));
        try {
            sesion.update(obj);
            sesion.getTransaction().commit();
            return true;
        } catch (Exception e) {
            sesion.getTransaction().rollback();
            setError("Marca_actualizar_registro: " + e.getMessage());
        }
        return false;
    }
}
