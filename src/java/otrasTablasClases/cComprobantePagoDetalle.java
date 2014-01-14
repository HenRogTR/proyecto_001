/*
 * To change this template, choose Tools | Templates
 * and open the template in the editor.
 */
package otrasTablasClases;

import java.util.Iterator;
import java.util.List;
import org.hibernate.Query;
import org.hibernate.Transaction;
import org.hibernate.classic.Session;
import otros.cUtilitarios;
import tablas.ComprobantePagoDetalle;
import tablas.HibernateUtil;

/**
 *
 * @author Henrri
 */
public class cComprobantePagoDetalle {

    Session sesion = null;
    public String error;

    public String getError() {
        return error;
    }

    public void setError(String error) {
        this.error = error;
    }

    public cComprobantePagoDetalle() {
        this.sesion = HibernateUtil.getSessionFactory().getCurrentSession();
        this.error = null;
    }

    public int Crear(ComprobantePagoDetalle objComprobantePagoDetalle) {
        setError(null);
        sesion = HibernateUtil.getSessionFactory().openSession();
        sesion.getTransaction().begin();
        try {
            int cod = (Integer) sesion.save(objComprobantePagoDetalle);
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
            Query q = sesion.createQuery("from ComprobantePagoDetalle cpd where substring(cpd.registro,1,1)=1");
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
            Query q = sesion.createQuery("from ComprobantePagoDetalle");
            return (List) q.list();
        } catch (Exception e) {
            setError(e.getMessage());
        }
        return null;
    }

    public ComprobantePagoDetalle leer_docSerieNumero(String docSerieNumero) {
        setError(null);
        try {
            sesion = HibernateUtil.getSessionFactory().openSession();
            Query q = sesion.createQuery("from ComprobantePagoDetalle cpd where substring(registro,1,1)=1 "
                    + "and cpd.docSerieNumero=:docSerieNumero")
                    .setParameter("docSerieNumero", docSerieNumero);
            return (ComprobantePagoDetalle) q.list().iterator().next();
        } catch (Exception e) {
            setError(e.getMessage());
        }
        return null;
    }

    public List leer_codComprobantePago(int codComprobantePago) {
        setError(null);
        try {
            sesion = HibernateUtil.getSessionFactory().openSession();
            Query q = sesion.createQuery("from ComprobantePagoDetalle cpd "
                    + "where substring(cpd.registro,1,1)=1 and "
                    + "cpd.comprobantePago.codComprobantePago=:codComprobantePago")
                    .setParameter("codComprobantePago", codComprobantePago);
            return (List) q.list();
        } catch (Exception e) {
            setError(e.getMessage());
        }
        return null;
    }

    public List leer_codComprobantePago(int codComprobantePago, int cantidad) {
        setError(null);
        try {
            sesion = HibernateUtil.getSessionFactory().openSession();
            Query q = sesion.createQuery("from ComprobantePagoDetalle cpd "
                    + "where substring(cpd.registro,1,1)=1 and "
                    + "cpd.comprobantePago.codComprobantePago=:codComprobantePago")
                    .setParameter("codComprobantePago", codComprobantePago)
                    .setMaxResults(cantidad);
            return (List) q.list();
        } catch (Exception e) {
            setError(e.getMessage());
        }
        return null;
    }

    public boolean actualizar_registro(int codComprobantePagoDetalle, String estado, String user) {
        cUtilitarios objUtilitarios = new cUtilitarios();
        setError(null);
        sesion = HibernateUtil.getSessionFactory().openSession();
        sesion.getTransaction().begin();
        ComprobantePagoDetalle obj = (ComprobantePagoDetalle) sesion.get(ComprobantePagoDetalle.class, codComprobantePagoDetalle);
        obj.setRegistro(objUtilitarios.registro(estado, user));
        try {
            sesion.update(obj);
            sesion.getTransaction().commit();
            return true;
        } catch (Exception e) {
            sesion.getTransaction().rollback();
            setError("Tabla_actualizar_registro: " + e.getMessage());
        }
        return false;
    }

    public boolean actualizar_estado(int codComprobantePagoDetalle, Boolean estado) {
        setError(null);
        sesion = HibernateUtil.getSessionFactory().openSession();
        sesion.getTransaction().begin();
        ComprobantePagoDetalle obj = (ComprobantePagoDetalle) sesion.get(ComprobantePagoDetalle.class, codComprobantePagoDetalle);
        obj.setEstado(estado);
        try {
            sesion.update(obj);
            sesion.getTransaction().commit();
            return true;
        } catch (Exception e) {
            sesion.getTransaction().rollback();
            setError("Tabla_actualizar_registro: " + e.getMessage());
        }
        return false;
    }

    public boolean generar(List lista) {
        Boolean estado = false;
        setError(null);
        sesion = HibernateUtil.getSessionFactory().openSession();
        sesion.getTransaction().begin();
        try {
            for (Iterator it = lista.iterator(); it.hasNext();) {
                ComprobantePagoDetalle objComprobantePago = (ComprobantePagoDetalle) it.next();
                sesion.persist(objComprobantePago);
            }
            sesion.getTransaction().commit();
            sesion.clear();
            sesion.close();
            estado = true;
        } catch (Exception e) {
            setError(e.getMessage());
            sesion.getTransaction().rollback();
        }
        return estado;
    }

    public ComprobantePagoDetalle leer_disponible(int codComprobantePago) {
        ComprobantePagoDetalle obj = null;
        Transaction trns = null;
        sesion = HibernateUtil.getSessionFactory().openSession();
        try {
            trns = sesion.beginTransaction();
            Query q = sesion.createQuery("from ComprobantePagoDetalle cpd "
                    + "where substring(cpd.registro,1,1)=1 "
                    + "and cpd.comprobantePago.codComprobantePago=:codComprobantePago "
                    + "and cpd.estado=0 "
                    + "order by cpd.docSerieNumero asc")
                    .setParameter("codComprobantePago", codComprobantePago)
                    .setMaxResults(1);
            obj = (ComprobantePagoDetalle) q.list().get(0);
        } catch (RuntimeException e) {
            setError(e.getMessage());
            e.printStackTrace();
        } finally {
            sesion.flush();
        }
        return obj;
    }

    /**
     * Se cierra la sesion Hibernate
     *
     * @param codComprobantePago
     * @return
     */
    public ComprobantePagoDetalle leer_disponible_SC(int codComprobantePago) {
        ComprobantePagoDetalle obj = null;
        Transaction trns = null;
        sesion = HibernateUtil.getSessionFactory().openSession();
        try {
            trns = sesion.beginTransaction();
            Query q = sesion.createQuery("from ComprobantePagoDetalle cpd "
                    + "where substring(cpd.registro,1,1)=1 "
                    + "and cpd.comprobantePago.codComprobantePago=:codComprobantePago "
                    + "and cpd.estado=0 "
                    + "order by cpd.docSerieNumero asc")
                    .setParameter("codComprobantePago", codComprobantePago)
                    .setMaxResults(1);
            obj = (ComprobantePagoDetalle) q.list().get(0);
        } catch (RuntimeException e) {
            setError(e.getMessage());
            e.printStackTrace();
        } finally {
            sesion.flush();
        }
        return obj;
    }

    public ComprobantePagoDetalle leer_disponible_siguiente(int codComprobantePago, int codComprobantePagoDetalle) {
        ComprobantePagoDetalle obj = null;
        Transaction trns = null;
        sesion = HibernateUtil.getSessionFactory().openSession();
        try {
            trns = sesion.beginTransaction();
            Query q = sesion.createQuery("from ComprobantePagoDetalle cpd "
                    + "where substring(cpd.registro,1,1)=1 "
                    + "and cpd.comprobantePago.codComprobantePago=:codComprobantePago "
                    + "and cpd.estado=0 "
                    + "and cpd.codComprobantePagoDetalle>=:codComprobantePagoDetalle "
                    + "order by cpd.docSerieNumero asc")
                    .setParameter("codComprobantePago", codComprobantePago)
                    .setParameter("codComprobantePagoDetalle", codComprobantePagoDetalle)
                    .setMaxResults(1);
            obj = (ComprobantePagoDetalle) q.list().get(0);
        } catch (Exception e) {
            setError(e.getMessage());
            e.printStackTrace();
        } finally {
            sesion.flush();
        }
        return obj;
    }

    public ComprobantePagoDetalle leer_disponible_siguiente_SC(int codComprobantePago, int codComprobantePagoDetalle) {
        ComprobantePagoDetalle obj = null;
        Transaction trns = null;
        sesion = HibernateUtil.getSessionFactory().openSession();
        try {
            trns = sesion.beginTransaction();
            Query q = sesion.createQuery("from ComprobantePagoDetalle cpd "
                    + "where substring(cpd.registro,1,1)=1 "
                    + "and cpd.comprobantePago.codComprobantePago=:codComprobantePago "
                    + "and cpd.estado=0 "
                    + "and cpd.codComprobantePagoDetalle>=:codComprobantePagoDetalle "
                    + "order by cpd.docSerieNumero asc")
                    .setParameter("codComprobantePago", codComprobantePago)
                    .setParameter("codComprobantePagoDetalle", codComprobantePagoDetalle)
                    .setMaxResults(1);
            obj = (ComprobantePagoDetalle) q.list().get(0);
        } catch (Exception e) {
            setError(e.getMessage());
            e.printStackTrace();
        } finally {
            sesion.flush();
            sesion.close();
        }
        return obj;
    }

    public List leer_siguiente(int codComprobantePago, int codComprobantePagoDetalle, int cantidad) {
        setError(null);
        try {
            sesion = HibernateUtil.getSessionFactory().openSession();
            Query q = sesion.createQuery("from ComprobantePagoDetalle cpd "
                    + "where substring(cpd.registro,1,1)=1 "
                    + "and cpd.comprobantePago.codComprobantePago=:codComprobantePago "
                    + "and cpd.codComprobantePagoDetalle>:codComprobantePagoDetalle "
                    + "order by cpd.docSerieNumero asc")
                    .setParameter("codComprobantePago", codComprobantePago)
                    .setParameter("codComprobantePagoDetalle", codComprobantePagoDetalle)
                    .setMaxResults(cantidad);
            return q.list();
        } catch (Exception e) {
            setError(e.getMessage());
            return null;
        }
    }

    public List leer_anterior(int codComprobantePago, int codComprobantePagoDetalle, int cantidad) {
        setError(null);
        try {
            sesion = HibernateUtil.getSessionFactory().openSession();
            Query q = sesion.createQuery("from ComprobantePagoDetalle cpd "
                    + "where substring(cpd.registro,1,1)=1 "
                    + "and cpd.comprobantePago.codComprobantePago=:codComprobantePago "
                    + "and cpd.codComprobantePagoDetalle<:codComprobantePagoDetalle "
                    + "order by cpd.docSerieNumero desc")
                    .setParameter("codComprobantePago", codComprobantePago)
                    .setParameter("codComprobantePagoDetalle", codComprobantePagoDetalle)
                    .setMaxResults(cantidad);
            return q.list();
        } catch (Exception e) {
            setError(e.getMessage());
            return null;
        }
    }

    public ComprobantePagoDetalle leer_ultimo(int codComprobantePago) {
        setError(null);
        try {
            sesion = HibernateUtil.getSessionFactory().openSession();
            Query q = sesion.createQuery("from ComprobantePagoDetalle a "
                    + "where substring(a.registro,1,1) = 1 "
                    + "and a.comprobantePago.codComprobantePago = :codComprobantePago "
                    + "order by a.docSerieNumero desc ")
                    .setParameter("codComprobantePago", codComprobantePago)
                    .setMaxResults(1);
            return (ComprobantePagoDetalle) q.list().get(0);
        } catch (Exception e) {
            setError(e.getMessage());
        }

        return null;
        //        setError(null);
        //        try {
        //            sesion = HibernateUtil.getSessionFactory().openSession();
        //            Query q = sesion.createQuery("from ComprobantePagoDetalle a "
        //                    + "where substring(a.registro,1,1) = 1 "
        //                    + "and a.comprobantePago.codComprobantePago = :codComprobantePago "
        //                    + "order by a.docSerieNumero desc ")
        //                    .setParameter("codComprobantePago", codComprobantePago)
        //                    .setMaxResults(1);
        //            return (ComprobantePagoDetalle) q.list().get(0);
        //        } catch (Exception e) {
        //            setError(e.getMessage());
        //        }
        //        return null;
        //    
    }

    public ComprobantePagoDetalle leer_cod(int codComprobantePagoDetalle) {
        sesion = HibernateUtil.getSessionFactory().openSession();
        return (ComprobantePagoDetalle) sesion.get(ComprobantePagoDetalle.class, codComprobantePagoDetalle);
    }
}
