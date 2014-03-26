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
import tablas.PrecioVenta;

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

    // <editor-fold defaultstate="collapsed" desc="Haga clic en el signo + para mostrar descripción">
    /**
     * precio de venta de un articulo en un determinado almacen
     *
     * @param codArticuloProducto
     * @param codAlmacen
     * @return
     */
    // </editor-fold>
    public PrecioVenta leer_precioVenta(int codArticuloProducto, int codAlmacen) {
        try {
            sesion = HibernateUtil.getSessionFactory().openSession();
            Query q = sesion.createQuery("from PrecioVenta a where "
                    + "a.kardexArticuloProducto.almacen.codAlmacen=:codAlmacen and "
                    + "a.kardexArticuloProducto.articuloProducto.codArticuloProducto=:codArticuloProducto and "
                    + "substring(registro,1,1)=1 order by codPrecioVenta desc")
                    .setParameter("codAlmacen", codAlmacen)
                    .setParameter("codArticuloProducto", codArticuloProducto);
            return (PrecioVenta) q.list().get(0);
        } catch (Exception e) {
            e.printStackTrace();
            setError(e.getMessage());
        }
        sesion.close();
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
        cUtilitarios objUtilitarios = new cUtilitarios();
        sesion = HibernateUtil.getSessionFactory().openSession();
        sesion.getTransaction().begin();
        PrecioVenta obj = (PrecioVenta) sesion.get(PrecioVenta.class, codPrecioVenta);
        obj.setRegistro(objUtilitarios.registro(estado, user));
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
