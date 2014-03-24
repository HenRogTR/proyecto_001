/*
 * To change this template, choose Tools | Templates
 * and open the template in the editor.
 */
package articuloProductoClases;

import java.util.List;
import org.hibernate.Query;
import org.hibernate.Session;
import org.hibernate.Transaction;
import tablas.HibernateUtil;
import tablas.KardexSerieNumero;

/**
 *
 * @author Henrri
 */
public class cKardexSerieNumero {

    Session sesion = null;
    public String error;

    public String getError() {
        return error;
    }

    public void setError(String error) {
        this.error = error;
    }

    public cKardexSerieNumero() {
        this.sesion = HibernateUtil.getSessionFactory().getCurrentSession();
    }

    public int crear(KardexSerieNumero objKardexSerieNumero) {
        int cod = 0;
        Transaction trns = null;
        sesion = HibernateUtil.getSessionFactory().openSession();
        try {
            trns = sesion.beginTransaction();
            cod = (Integer) sesion.save(objKardexSerieNumero);
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
        return null;
    }

    public KardexSerieNumero leer_codKardexSerieNumero(int codKardexSerieNumero) {
        sesion = HibernateUtil.getSessionFactory().openSession();
        return (KardexSerieNumero) sesion.get(KardexSerieNumero.class, codKardexSerieNumero);
    }

    /**
     *
     * @param codKardexArticuloProducto
     * @return
     */
    public List leer_por_codKardexArticuloProducto(int codKardexArticuloProducto) {
        List l = null;
        Transaction trns = null;
        sesion = HibernateUtil.getSessionFactory().openSession();
        try {
            sesion = HibernateUtil.getSessionFactory().openSession();
            Query q = sesion.createQuery("from KardexSerieNumero ksn "
                    + "where ksn.kardexArticuloProducto.codKardexArticuloProducto = :cod "
                    + "and substring(ksn.registro,1,1) = 1")
                    .setParameter("cod", codKardexArticuloProducto);
            l = (List) q.list();
        } catch (Exception e) {
            e.printStackTrace();
        } finally {
            sesion.flush();
        }
        return l;
    }

    public List leer_admin() {
        return null;
    }

    public boolean actualizar(KardexSerieNumero objKardexSerieNumero) {
        sesion = HibernateUtil.getSessionFactory().openSession();
        sesion.getTransaction().begin();
        try {
            sesion.update(objKardexSerieNumero);
            sesion.getTransaction().commit();
            return true;
        } catch (Exception e) {
            sesion.getTransaction().rollback();
            e.printStackTrace();
            setError("KardexSerieNumero_actualizar: " + e.getMessage());
        }
        return false;
    }
}
