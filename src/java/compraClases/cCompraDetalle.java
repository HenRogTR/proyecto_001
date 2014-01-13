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
import otros.cUtilitarios;
import tablas.CompraDetalle;
import tablas.HibernateUtil;

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
    }

    //*********************************************************************
    /**
     *
     * @param codArticuloProducto
     * @return
     */
    public List leer_ultimoDiez(int codArticuloProducto) {
        setError(null);
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
    //*********************************************************************

    public int Crear(CompraDetalle objCompraDetalle) {
        setError(null);
        sesion = HibernateUtil.getSessionFactory().openSession();
        sesion.getTransaction().begin();
        try {
            int codCompraDetalle = (Integer) sesion.save(objCompraDetalle);
            sesion.getTransaction().commit();
            return codCompraDetalle;
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
//    public List leer_compraDetalle_codCompra(int codCompra) {
//        List l=new ArrayList();
//        setError(null);
//        try {
//            sesion = HibernateUtil.getSessionFactory().openSession();
//            Query q = sesion.createQuery("from CompraDetalle a where substring(registro,1,1)=1 and "
//                    + "a.compra.codCompra=:codCompra")
//                    .setParameter("codCompra", codCompra);
//            l= q.list();
//            sesion.disconnect();
//        } catch (Exception e) {
//            setError(e.getMessage());
//            return null;
//        }
//        return l;
//    }

    public List leer_fechaInicio_fechaFin_orderByFechaCompra(Date fechaInicio, Date fechaFin, int codArticuloProducto) {
        setError(null);
        try {
            sesion = HibernateUtil.getSessionFactory().openSession();
            Query q = sesion.createQuery("from CompraDetalle a where a.compra.fechaFactura>=:fechaInicio and "
                    + "a.compra.fechaFactura<=:fechaFin and "
                    + "a.articuloProducto.codArticuloProducto=:codArticuloProducto and "
                    + "substring(registro,1,1)=1 order by a.compra.fechaFactura")
                    .setParameter("fechaInicio", fechaInicio)
                    .setParameter("fechaFin", fechaFin)
                    .setParameter("codArticuloProducto", codArticuloProducto);
            return (List) q.list();
        } catch (Exception e) {
            setError(e.getMessage());
        }
        return new ArrayList();
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
        cUtilitarios objUtilitarios = new cUtilitarios();
        setError(null);
        sesion = HibernateUtil.getSessionFactory().openSession();
        sesion.getTransaction().begin();
        CompraDetalle objCompraDetalle = (CompraDetalle) sesion.get(CompraDetalle.class, codCompraDetalle);
        objCompraDetalle.setRegistro(objUtilitarios.registro(estado, user));
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
