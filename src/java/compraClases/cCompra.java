/*
 * To change this template, choose Tools | Templates
 * and open the template in the editor.
 */
package compraClases;

/**
 *
 * @author Henrri
 */
import java.util.Date;
import java.util.List;
import org.hibernate.Query;
import org.hibernate.Session;
import org.hibernate.Transaction;
import tablas.Compra;
import tablas.HibernateUtil;
import utilitarios.cOtros;

public class cCompra {

    Session sesion = null;
    public String error;

    public String getError() {
        return error;
    }

    public void setError(String error) {
        this.error = error;
    }

    public cCompra() {
        this.sesion = HibernateUtil.getSessionFactory().getCurrentSession();
        this.error = null;
    }

    public int crear(Compra objCompra) {
        int cod = 0;
        Transaction trns = null;
        sesion = HibernateUtil.getSessionFactory().openSession();
        try {
            trns = sesion.beginTransaction();
            cod = (Integer) sesion.save(objCompra);
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
            Query q = sesion.createQuery("from Compra where substring(registro,1,1)=1");
            return (List) q.list();
        } catch (Exception e) {
            setError(e.getMessage());
        }
        return null;
    }

    public Compra leer_cod(int codCompra) {
        sesion = HibernateUtil.getSessionFactory().openSession();
        return (Compra) sesion.get(Compra.class, codCompra);
    }

    public Compra leer_primero() {
        setError(null);
        sesion = HibernateUtil.getSessionFactory().openSession();
        try {
            Query q = sesion.createQuery("from Compra c "
                    + "where (substring(registro,1,1)=1 or substring(registro,1,1)=0) "
                    + "order by c.codCompra")
                    .setMaxResults(1);
            return (Compra) q.list().iterator().next();
        } catch (Exception e) {
            setError("Compra: " + e.getMessage());
        }
        return null;
    }

    public Compra leer_ultimo() {
        setError(null);
        sesion = HibernateUtil.getSessionFactory().openSession();
        try {
            Query q = sesion.createQuery("from Compra c "
                    + "where (substring(registro,1,1)=1 or substring(registro,1,1)=0) "
                    + "order by c.codCompra desc")
                    .setMaxResults(1);
            return (Compra) q.list().iterator().next();
        } catch (Exception e) {
            setError("Compra: " + e.getMessage());
        }
        return null;
    }

    public List leerDocNumeroSerie(String criterio) {
        setError(null);
        try {
            sesion = HibernateUtil.getSessionFactory().openSession();
            Query q = sesion.createQuery("from Compra where substring(registro,1,1)=1 and docSerieNumero like :criterio")
                    .setParameter("criterio", "%" + criterio + "%");
            return (List) q.list();
        } catch (Exception e) {
            setError(e.getMessage());
        }
        return null;
    }

    public Compra leer_docSerieNumero(String docSerieNumero) {
        setError(null);
        try {
            sesion = HibernateUtil.getSessionFactory().openSession();
            Query q = sesion.createQuery("from Compra where substring(registro,1,1)=1 and docSerieNumero=:criterio")
                    .setParameter("criterio", docSerieNumero);
            return (Compra) q.list().get(0);
        } catch (Exception e) {
            setError(e.getMessage());
        }
        return null;
    }

    public List leer_fechaInicio_fechafin_orderByFechaCompra(Date fechaInicio, Date fechaFin) {
        setError(null);
        try {
            sesion = HibernateUtil.getSessionFactory().openSession();
            Query q = sesion.createQuery("from Compra where fechaFactura >= :fechaInicio and fechaFactura <= :fechaFin and substring(registro,1,1)='1' order by fechaFactura")
                    .setParameter("fechaInicio", fechaInicio)
                    .setParameter("fechaFin", fechaFin);
            return (List) q.list();
        } catch (Exception e) {
            setError(e.getMessage());
        }
        return null;
    }

    /**
     *
     * @param fechaInicio
     * @param fechaFin
     * @return 0:codCompra, 1:docSerieNumero, 2:fechaFactura, 3:tipo,
     * 4:observacion, 5:neto, 6:codProveedor, 7:ruc, 8:razonSocial,
     * 9:codCompraDetalle, 10:codArticuloProducto, 11:cantidad, 12:descripcion,
     * 13:usarSerieNumero, 14:precioUnitario, 15:precioTotal
     */
    public List leer_fechas_SC(Date fechaInicio, Date fechaFin) {
        List l = null;
        Transaction trns = null;
        sesion = HibernateUtil.getSessionFactory().openSession();
        try {
            trns = sesion.beginTransaction();
            Query q = sesion.createQuery("select c.codCompra"
                    + ", c.docSerieNumero"
                    + ", c.fechaFactura"
                    + ", c.tipo"
                    + ", c.observacion"
                    + ", c.neto"
                    + ", c.proveedor.codProveedor"
                    + ", c.proveedor.ruc"
                    + ", c.proveedor.razonSocial"
                    + ", cd.codCompraDetalle"
                    + ", cd.articuloProducto.codArticuloProducto"
                    + ", cd.cantidad"
                    + ", cd.descripcion"
                    + ", cd.articuloProducto.usarSerieNumero"
                    + ", cd.precioUnitario"
                    + ", cd.precioTotal"
                    + " from Compra c join c.compraDetalles cd"
                    + " where substring(c.registro,1,1) = 1"
                    + " and substring(cd.registro,1,1) = 1"
                    + " and c.fechaFactura between :par1 and :par2"
                    + " order by c.fechaFactura, c.codCompra")
                    .setDate("par1", fechaInicio)
                    .setDate("par2", fechaFin);
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

    /**
     *
     * @param fechaInicio
     * @param fechaFin
     * @param codProveedor
     * @return 0:codCompra, 1:docSerieNumero, 2:fechaFactura, 3:tipo,
     * 4:observacion, 5:neto, 6:codProveedor, 7:ruc, 8:razonSocial,
     * 9:codCompraDetalle, 10:codArticuloProducto, 11:cantidad, 12:descripcion,
     * 13:usarSerieNumero, 14:precioUnitario, 15:precioTotal
     */
    public List leer_proveedor_fechas_SC(Date fechaInicio, Date fechaFin, int codProveedor) {
        List l = null;
        Transaction trns = null;
        sesion = HibernateUtil.getSessionFactory().openSession();
        try {
            trns = sesion.beginTransaction();
            Query q = sesion.createQuery("select c.codCompra"
                    + ", c.docSerieNumero"
                    + ", c.fechaFactura"
                    + ", c.tipo"
                    + ", c.observacion"
                    + ", c.neto"
                    + ", c.proveedor.codProveedor"
                    + ", c.proveedor.ruc"
                    + ", c.proveedor.razonSocial"
                    + ", cd.codCompraDetalle"
                    + ", cd.articuloProducto.codArticuloProducto"
                    + ", cd.cantidad"
                    + ", cd.descripcion"
                    + ", cd.articuloProducto.usarSerieNumero"
                    + ", cd.precioUnitario"
                    + ", cd.precioTotal"
                    + " from Compra c join c.compraDetalles cd"
                    + " where substring(c.registro,1,1) = 1"
                    + " and substring(cd.registro,1,1) = 1"
                    + " and c.fechaFactura between :par1 and :par2"
                    + " and c.proveedor = :par3"
                    + " order by c.fechaFactura, c.codCompra")
                    .setDate("par1", fechaInicio)
                    .setDate("par2", fechaFin)
                    .setInteger("par3", codProveedor);
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

    public List leer_fechaInicio_fechafin_codProveedor_orderByFechaCompra(Date fechaInicio, Date fechaFin, int codProveedor) {
        setError(null);
        try {
            sesion = HibernateUtil.getSessionFactory().openSession();
            Query q = sesion.createQuery("from Compra a where "
                    + "a.fechaFactura>=:fechaInicio and "
                    + "a.fechaFactura<=:fechaFin and "
                    + "a.proveedor.codProveedor=:codProveedor and "
                    + "substring(registro,1,1)=1")
                    .setParameter("fechaInicio", fechaInicio)
                    .setParameter("fechaFin", fechaFin)
                    .setParameter("codProveedor", codProveedor);
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
            Query q = sesion.createQuery("from Compra");
            return (List) q.list();
        } catch (Exception e) {
            setError(e.getMessage());
        }
        return null;
    }

    public boolean actualizar_est(int codCompra, String estado, String user) {
        sesion = HibernateUtil.getSessionFactory().openSession();
        sesion.getTransaction().begin();
        Compra objCompra = (Compra) sesion.get(Compra.class, codCompra);
        objCompra.setRegistro(new cOtros().registro(estado, user));
        try {
            sesion.update(objCompra);
            sesion.getTransaction().commit();
            return true;
        } catch (Exception e) {
            sesion.getTransaction().rollback();
            setError("Compra_actualizar_est: " + e.getMessage());
        }
        return false;
    }
}
