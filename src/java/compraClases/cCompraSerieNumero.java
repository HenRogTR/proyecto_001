/*
 * To change this template, choose Tools | Templates
 * and open the template in the editor.
 */
package compraClases;

import java.util.List;
import org.hibernate.Query;
import org.hibernate.Session;
import org.hibernate.Transaction;
import otros.cUtilitarios;
import tablas.CompraSerieNumero;
import tablas.HibernateUtil;

/**
 *
 * @author Henrri
 */
public class cCompraSerieNumero {

    Session sesion = null;
    public String error;

    public String getError() {
        return error;
    }

    public void setError(String error) {
        this.error = error;
    }

    public cCompraSerieNumero() {
        this.sesion = HibernateUtil.getSessionFactory().getCurrentSession();
        this.error = null;
    }

    /**
     *
     * @param objCompraSerieNumero
     * @return el código con el que se agregó caso contrario 0 en caso de fallar
     * el registro
     */
    public int crear(CompraSerieNumero objCompraSerieNumero) {
        int cod = 0;
        Transaction trns = null;
        sesion = HibernateUtil.getSessionFactory().openSession();
        try {
            trns = sesion.beginTransaction();
            cod = (Integer) sesion.save(objCompraSerieNumero);
            sesion.getTransaction().commit();
        } catch (Exception e) {
            if (trns != null) {
                trns.rollback();
            }
            e.printStackTrace();
        } finally {
            sesion.flush();
            sesion.close();
        }
        return cod;
    }

    /**
     *
     * @return una lista con los datos, caso contrario null.
     */
    public List leer() {
        setError(null);
        try {
            sesion = HibernateUtil.getSessionFactory().openSession();
            Query q = sesion.createQuery("from CompraSerieNumero where substring(registro,1,1)=1");
            return (List) q.list();
        } catch (Exception e) {
            setError(e.getMessage());
        }
        return null;
    }

    /**
     *
     * @param serieNumero
     * @return
     */
    public List leer_serieNumero(String serieNumero) {
        setError(null);
        sesion = HibernateUtil.getSessionFactory().openSession();
        try {
            Query q = sesion.createQuery("from CompraSerieNumero c "
                    + "where substring(registro,1,1)=1 "
                    + "and c.serieNumero like :serieNumero")
                    .setParameter("serieNumero", "%" + serieNumero + "%");
            return q.list();
        } catch (Exception e) {
            setError(e.getMessage());
        }
        return null;
    }

    /**
     *
     * @return una lista con los datos caso contrario null.
     */
    public List leer_admin() {
        return null;
    }

    /**
     * 
     * @param codCompraDetalle
     * @return 
     */
    public List leer_codCompraDetalle(int codCompraDetalle) {
        List l = null;
        Transaction trns = null;
        sesion = HibernateUtil.getSessionFactory().openSession();
        try {
            sesion = HibernateUtil.getSessionFactory().openSession();
            Query q = sesion.createQuery("from CompraSerieNumero csn"
                    + " where csn.compraDetalle = :par1 "
                    + " and substring(csn.registro,1,1) = 1")
                    .setInteger("par1", codCompraDetalle);
            l = q.list();
        } catch (Exception e) {
            e.printStackTrace();
            setError(e.getMessage());
        } finally {
            sesion.flush();
        }
        return l;
    }

    /**
     * Lo mismo que eliminar un registro
     *
     * @param codCompraSerieNumero
     * @param estado
     * @param user
     * @return
     */
    public boolean actualizar_est(int codCompraSerieNumero, String estado, String user) {
        cUtilitarios objUtilitarios = new cUtilitarios();
        setError(null);
        sesion = HibernateUtil.getSessionFactory().openSession();
        sesion.getTransaction().begin();
        CompraSerieNumero objCompraDetalle = (CompraSerieNumero) sesion.get(CompraSerieNumero.class, codCompraSerieNumero);
        objCompraDetalle.setRegistro(objUtilitarios.registro(estado, user));
        try {
            sesion.update(objCompraDetalle);
            sesion.getTransaction().commit();
            return true;
        } catch (Exception e) {
            sesion.getTransaction().rollback();
            setError("CompraSerieNumero_actualizar_est: " + e.getMessage());
        }
        return false;
    }
}
