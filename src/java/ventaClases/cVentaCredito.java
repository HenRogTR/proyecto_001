/*
 * To change this template, choose Tools | Templates
 * and open the template in the editor.
 */
package ventaClases;

import java.util.Date;
import java.util.List;
import org.hibernate.Query;
import org.hibernate.Transaction;
import org.hibernate.Session;
import otros.cUtilitarios;
import tablas.HibernateUtil;
import tablas.VentaCredito;

/**
 *
 * @author Henrri
 */
public class cVentaCredito {

    Session sesion = null;
    public String error;

    public String getError() {
        return error;
    }

    public void setError(String error) {
        this.error = error;
    }

    public cVentaCredito() {
        this.sesion = HibernateUtil.getSessionFactory().getCurrentSession();
    }

    public int Crear(VentaCredito objVentaCredito) {
        setError(null);
        sesion = HibernateUtil.getSessionFactory().openSession();
        sesion.getTransaction().begin();
        try {
            int cod = (Integer) sesion.save(objVentaCredito);
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
            Query q = sesion.createQuery("from VentaCredito where substring(registro,1,1)=1");
            return (List) q.list();
        } catch (Exception e) {
            setError(e.getMessage());
        }
        return null;
    }

    public VentaCredito leer_cod(int codVentaCredito) {
        sesion = HibernateUtil.getSessionFactory().openSession();
        return (VentaCredito) sesion.get(VentaCredito.class, codVentaCredito);
    }

    public VentaCredito leer_codVenta(int codVenta) {
        VentaCredito objVentaCredito = null;
        try {
            sesion = HibernateUtil.getSessionFactory().openSession();
            Query q = sesion.createQuery("from VentaCredito vc where substring(vc.registro,1,1)=1 "
                    + "and vc.ventas.codVentas=:a").
                    setParameter("a", codVenta);
            objVentaCredito = (VentaCredito) q.list().get(0);
        } catch (Exception e) {
            setError(e.getMessage());
            e.printStackTrace();
        }
        return objVentaCredito;
    }

    /**
     * Retorna los detalles de una venta aun estando eliminada ademas la
     * conexion se cierra.
     *
     * @param codVenta
     * @return
     */
    public VentaCredito leer_codVenta_01(int codVenta) {
        VentaCredito objVC = null;
        Transaction trns = null;
        sesion = HibernateUtil.getSessionFactory().openSession();
        try {
            trns = sesion.beginTransaction();
            Query q = sesion.createQuery("from VentaCredito vc "
                    + "where (substring(vc.registro,1,1)=1 or substring(vc.registro,1,1)=0) "
                    + "and vc.ventas.codVentas=:a").
                    setParameter("a", codVenta);
            objVC = (VentaCredito) q.list().get(0);
        } catch (RuntimeException e) {
            e.printStackTrace();
        } finally {
            sesion.flush();
        }
        return objVC;
    }
    
    /**
     * Retorna los detalles de una venta aun estando eliminada ademas la
     * conexion se cierra.
     *
     * @param codVenta
     * @return
     */
    public VentaCredito leer_codVenta_01_SC(int codVenta) {
        VentaCredito objVC = null;
        Transaction trns = null;
        sesion = HibernateUtil.getSessionFactory().openSession();
        try {
            trns = sesion.beginTransaction();
            Query q = sesion.createQuery("from VentaCredito vc "
                    + "where (substring(vc.registro,1,1)=1 or substring(vc.registro,1,1)=0) "
                    + "and vc.ventas.codVentas=:a").
                    setParameter("a", codVenta);
            objVC = (VentaCredito) q.list().get(0);
        } catch (RuntimeException e) {
            e.printStackTrace();
        } finally {
            sesion.flush();
            sesion.close();
        }
        return objVC;
    }

    public List leer_admin() {
        setError(null);
        try {
            sesion = HibernateUtil.getSessionFactory().openSession();
            Query q = sesion.createQuery("from VentaCredito");
            return (List) q.list();
        } catch (Exception e) {
            setError(e.getMessage());
        }
        return null;
    }

    public boolean actualizar_registro(int codVentaCredito, String estado, String user) {
        cUtilitarios objUtilitarios = new cUtilitarios();
        setError(null);
        sesion = HibernateUtil.getSessionFactory().openSession();
        sesion.getTransaction().begin();
        VentaCredito obj = (VentaCredito) sesion.get(VentaCredito.class, codVentaCredito);
        obj.setRegistro(objUtilitarios.registro(estado, user));
        try {
            sesion.update(obj);
            sesion.getTransaction().commit();
            return true;
        } catch (Exception e) {
            sesion.getTransaction().rollback();
            setError("VentaCredito_actualizar_registro: " + e.getMessage());
        }
        return false;
    }

    public Boolean actualizar_fechaInicial_montoLetra(int codVentaCredito, Date fechaInicial, Double montoLetra, String duracion, Date fechaVencimientoLetra) {
        Boolean estado = false;
        Transaction trns = null;
        sesion = HibernateUtil.getSessionFactory().openSession();
        try {
            trns = sesion.beginTransaction();
            VentaCredito objVC = (VentaCredito) sesion.get(VentaCredito.class, codVentaCredito);
            objVC.setFechaInicial(fechaInicial);
            objVC.setMontoLetra(montoLetra);
            objVC.setDuracion(duracion);
            objVC.setFechaVencimientoLetra(fechaVencimientoLetra);
            sesion.update(objVC);
            sesion.getTransaction().commit();
            estado = true;
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
        return estado;
    }

    public Boolean actualizar(int codVentaCredito, Date fechaInicial, Double montoLetra, String duracion, Date fechaVencimientoLetra, Double montoInicial, int cantidadLetras) {
        Boolean estado = false;
        Transaction trns = null;
        sesion = HibernateUtil.getSessionFactory().openSession();
        try {
            trns = sesion.beginTransaction();
            VentaCredito objVC = (VentaCredito) sesion.get(VentaCredito.class, codVentaCredito);
            objVC.setFechaInicial(fechaInicial);
            objVC.setMontoLetra(montoLetra);
            objVC.setDuracion(duracion);
            objVC.setFechaVencimientoLetra(fechaVencimientoLetra);
            objVC.setMontoInicial(montoInicial);
            objVC.setCantidadLetras(cantidadLetras);
            sesion.update(objVC);
            sesion.getTransaction().commit();
            estado = true;
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
        return estado;
    }
}
