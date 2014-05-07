/*
 * To change this template, choose Tools | Templates
 * and open the template in the editor.
 */
package ventaClases;

import java.util.List;
import org.hibernate.Query;
import org.hibernate.Session;
import org.hibernate.Transaction;
import tablas.HibernateUtil;
import tablas.VentasDetalle;
import utilitarios.cOtros;

/**
 *
 * @author Henrri
 */
public class cVentasDetalle {

    Session sesion = null;
    public String error;

    public String getError() {
        return error;
    }

    public void setError(String error) {
        this.error = error;
    }

    public cVentasDetalle() {
        this.sesion = HibernateUtil.getSessionFactory().getCurrentSession();
        this.error = null;
    }

    public List leer_ventasDetalle_porCodVentas(int codVentas) {
        sesion = HibernateUtil.getSessionFactory().openSession();
        try {
            Query q = sesion.createQuery("from VentasDetalle v where "
                    + "v.ventas.codVentas=:codVentas and "
                    + "substring(registro,1,1)=1 order by codVentasDetalle asc")
                    .setParameter("codVentas", codVentas);
            return (List) q.list();
        } catch (Exception e) {
            e.printStackTrace();
            setError(e.getMessage());
        }
        return null;
    }

    public List leer_ultimoDiez(int codArticuloProducto) {
        setError(null);
        try {
            sesion = HibernateUtil.getSessionFactory().openSession();
            Query q = sesion.createQuery("from VentasDetalle vd "
                    + "where substring(vd.registro,1,1)=1 "
                    + "and vd.articuloProducto.codArticuloProducto=:codArticuloProducto "
                    + "order by vd.codVentasDetalle desc")
                    .setParameter("codArticuloProducto", codArticuloProducto)
                    .setMaxResults(10);
            return (List) q.list();
        } catch (Exception e) {
            setError(e.getMessage());
        }
        return null;
    }

    /**
     *
     * @param objVentasDetalle
     * @return
     */
    public int crear(VentasDetalle objVentasDetalle) {
        int cod = 0;
        Transaction trns = null;
        sesion = HibernateUtil.getSessionFactory().openSession();
        try {
            trns = sesion.beginTransaction();
            cod = (Integer) sesion.save(objVentasDetalle);
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
        setError(null);
        try {
            sesion = HibernateUtil.getSessionFactory().openSession();
            Query q = sesion.createQuery("from VentasDetalle where substring(registro,1,1)=1");
            return (List) q.list();
        } catch (Exception e) {
            setError(e.getMessage());
        }
        return null;
    }

    public List leer_ventas_porCodVentas(int codVentas) {
        setError(null);
        try {
            sesion = HibernateUtil.getSessionFactory().openSession();
            Query q = sesion.createQuery("from VentasDetalle v where "
                    + "v.ventas.codVentas=:codVentas and "
                    + "substring(registro,1,1)=1 order by codVentasDetalle asc")
                    .setParameter("codVentas", codVentas);
            return (List) q.list();
        } catch (Exception e) {
            setError(e.getMessage());
            e.printStackTrace();
        }
        return null;
    }

    public VentasDetalle leer_ventasDetalle(int codVentas, int codArticuloProducto) {
        setError(null);
        try {
            sesion = HibernateUtil.getSessionFactory().openSession();
            Query q = sesion.createQuery("from VentasDetalle a where substring(registro,1,1)=1 and "
                    + "a.ventas.codVentas=:codVentas and "
                    + "a.articuloProducto.codArticuloProducto=:codArticuloProducto "
                    + "order by codVentasDetalle desc")
                    .setParameter("codArticuloProducto", codArticuloProducto)
                    .setParameter("codVentas", codVentas)
                    .setMaxResults(1);
            return (VentasDetalle) q.list().get(0);
        } catch (Exception e) {
            setError(e.getMessage());
        }
        return null;
    }

    public List leer_admin() {
        setError(null);
        try {
            sesion = HibernateUtil.getSessionFactory().openSession();
            Query q = sesion.createQuery("from VentasDetalle");
            return (List) q.list();
        } catch (Exception e) {
            setError(e.getMessage());
        }
        return null;
    }

    public boolean actualizar_registro(int codVentasDetalle, String estado, String user) {
        sesion = HibernateUtil.getSessionFactory().openSession();
        sesion.getTransaction().begin();
        VentasDetalle obj = (VentasDetalle) sesion.get(VentasDetalle.class, codVentasDetalle);
        obj.setRegistro(new cOtros().registro(estado, user));
        try {
            sesion.update(obj);
            sesion.getTransaction().commit();
            return true;
        } catch (Exception e) {
            sesion.getTransaction().rollback();
            setError("VentasDetalle_actualizar_registro: " + e.getMessage());
        }
        return false;
    }

    public boolean actualizar_valorVenta(int codVentaDetalle, Double valorVenta) {
        sesion = HibernateUtil.getSessionFactory().openSession();
        sesion.getTransaction().begin();
        VentasDetalle obj = (VentasDetalle) sesion.get(VentasDetalle.class, codVentaDetalle);
        obj.setValorVenta(valorVenta);
        try {
            sesion.update(obj);
            sesion.getTransaction().commit();
            return true;
        } catch (Exception e) {
            sesion.getTransaction().rollback();
            setError("VentasDetalle_actualizar_valorVenta: " + e.getMessage());
        }
        return false;
    }

    public Boolean actualizar_descripcion(int codVentaDetalle, String descripcion) {
        sesion = HibernateUtil.getSessionFactory().openSession();
        sesion.getTransaction().begin();
        VentasDetalle obj = (VentasDetalle) sesion.get(VentasDetalle.class, codVentaDetalle);
        obj.setDescripcion(descripcion);
        try {
            sesion.update(obj);
            sesion.getTransaction().commit();
            return true;
        } catch (Exception e) {
            sesion.getTransaction().rollback();
            setError("VentasDetalle_actualizar_valorVenta: " + e.getMessage());
        }
        return false;
    }
}
