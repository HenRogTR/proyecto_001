/*
 * To change this template, choose Tools | Templates
 * and open the template in the editor.
 */
package compraClases;

/**
 *
 * @author Henrri
 */
import java.util.ArrayList;
import java.util.Date;
import java.util.List;
import org.hibernate.Query;
import org.hibernate.Session;
import org.hibernate.Transaction;
import tablas.CompraDetalle;
import HiberanteUtil.HibernateUtil;
import utilitarios.cOtros;

public class cCompraDetalle {

    Session sesion = null;
    public String error;

    public String getError() {
        return error;
    }

    public void setError(String error) {
        this.error = error;
    }

    public cCompraDetalle() {
        this.sesion = HibernateUtil.getSessionFactory().getCurrentSession();
        this.error = null;
    }
    
    /**
     *
     * @param codArticuloProducto
     * @return
     */
    public List leer_ultimoDiez(int codArticuloProducto) {
        try {
            sesion = HibernateUtil.getSessionFactory().openSession();
            Query q = sesion.createQuery("from CompraDetalle cd "
                    + "where substring(cd.registro,1,1)=1 "
                    + "and cd.articuloProducto.codArticuloProducto=:codArticuloProducto "
                    + "order by cd.codCompraDetalle desc")
                    .setParameter("codArticuloProducto", codArticuloProducto)
                    .setMaxResults(10);
            return (List) q.list();
        } catch (Exception e) {
            setError(e.getMessage());
        }
        return null;
    }

    public int crear(CompraDetalle objCompraDetalle) {
        int cod = 0;
        Transaction trns = null;
        sesion = HibernateUtil.getSessionFactory().openSession();
        try {
            trns = sesion.beginTransaction();
            cod = (Integer) sesion.save(objCompraDetalle);
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

    public List leer() {
        setError(null);
        try {
            sesion = HibernateUtil.getSessionFactory().openSession();
            Query q = sesion.createQuery("from CompraDetalle where substring(registro,1,1)=1");
            return (List) q.list();
        } catch (Exception e) {
            setError(e.getMessage());
        }
        return null;
    }

    public CompraDetalle leer_compraDetalle_codCompra(int codCompra, int codArticuloProducto) {
        setError(null);
        try {
            sesion = HibernateUtil.getSessionFactory().openSession();
            Query q = sesion.createQuery("from CompraDetalle a where substring(registro,1,1)=1 and "
                    + "a.compra.codCompra=:codCompra and "
                    + "a.articuloProducto.codArticuloProducto=:codArticuloProducto "
                    + "order by codCompraDetalle desc")
                    .setParameter("codArticuloProducto", codArticuloProducto)
                    .setParameter("codCompra", codCompra)
                    .setMaxResults(1);
            return (CompraDetalle) q.list().get(0);
        } catch (Exception e) {
            setError(e.getMessage());
        }
        return null;
    }

    public List leer_compraDetalle_codCompra(int codCompra) {
        List list = null;
        setError(null);
        try {
            sesion = HibernateUtil.getSessionFactory().openSession();
            Query q = sesion.createQuery("from CompraDetalle a where substring(registro,1,1)=1 and "
                    + "a.compra.codCompra=:codCompra")
                    .setParameter("codCompra", codCompra);
            list = (List) q.list();
        } catch (Exception e) {
            setError(e.getMessage());
            e.printStackTrace();
        } finally {
//            sesion.close();
        }
        return list;
    }

    public List leer_admin() {
        setError(null);
        try {
            sesion = HibernateUtil.getSessionFactory().openSession();
            Query q = sesion.createQuery("from CompraDetalle");
            return (List) q.list();
        } catch (Exception e) {
            setError(e.getMessage());
        }
        return null;
    }

    public boolean actualizar_est(int codCompraDetalle, String estado, String user) {
        sesion = HibernateUtil.getSessionFactory().openSession();
        sesion.getTransaction().begin();
        CompraDetalle objCompraDetalle = (CompraDetalle) sesion.get(CompraDetalle.class, codCompraDetalle);
        objCompraDetalle.setRegistro(new cOtros().registro(estado, user));
        try {
            sesion.update(objCompraDetalle);
            sesion.getTransaction().commit();
            return true;
        } catch (Exception e) {
            sesion.getTransaction().rollback();
            setError("CompraDetalle_actualizar_est: " + e.getMessage());
        }
        return false;
    }

    public boolean actualizar_descripcion(int codCompraDetalle, String descripcion) {
        setError(null);
        sesion = HibernateUtil.getSessionFactory().openSession();
        sesion.getTransaction().begin();
        CompraDetalle objCompraDetalle = (CompraDetalle) sesion.get(CompraDetalle.class, codCompraDetalle);
        objCompraDetalle.setDescripcion(descripcion);
        try {
            sesion.update(objCompraDetalle);
            sesion.getTransaction().commit();
            return true;
        } catch (Exception e) {
            sesion.getTransaction().rollback();
            setError("CompraDetalle_actualizar_est: " + e.getMessage());
        }
        return false;
    }
}
