/*
 * To change this template, choose Tools | Templates
 * and open the template in the editor.
 */
package otrasTablasClases;

import java.util.Iterator;
import java.util.List;
import org.hibernate.Query;
import org.hibernate.Session;
import org.hibernate.Transaction;
import tablas.ComprobantePago;
import tablas.HibernateUtil;

/**
 *
 * @author Henrri
 */
public class cComprobantePago {

    Session sesion = null;
    public String error;

    public String getError() {
        return error;
    }

    public void setError(String error) {
        this.error = error;
    }

    public cComprobantePago() {
        this.sesion = HibernateUtil.getSessionFactory().getCurrentSession();
        this.sesion = null;
    }

    public int Crear(ComprobantePago objComprobantePago) {
        setError(null);
        sesion = HibernateUtil.getSessionFactory().openSession();
        sesion.getTransaction().begin();
        try {
            int cod = (Integer) sesion.save(objComprobantePago);
            sesion.getTransaction().commit();
            sesion.clear();
            sesion.close();
            return cod;
        } catch (Exception e) {
            sesion.getTransaction().rollback();
            e.printStackTrace();
            setError(e.getMessage());
        }
        return 0;
    }

    public List leer_series() {
        setError(null);
        sesion = HibernateUtil.getSessionFactory().openSession();
        try {
            Query q = sesion.createQuery("select distinct cp.tipo from ComprobantePago cp order by cp.tipo");
            return q.list();
        } catch (Exception e) {
            e.printStackTrace();
            setError(e.getMessage());
            return null;
        }
    }

    public List leer_serieGenerada(String codCobranza) {
        setError(null);
        sesion = HibernateUtil.getSessionFactory().openSession();
        try {
            Query q = sesion.createQuery("from ComprobantePago cp "
                    + "where substring(cp.registro,1,1)=1 and cp.tipo=:codCobranza")
                    .setParameter("codCobranza", codCobranza);
            return q.list();
        } catch (Exception e) {
            setError(e.getMessage());
            return null;
        }
    }

    public Boolean generarSerieDocumento(List lComprobantePago) {
        Boolean estado = false;
        setError(null);
        sesion = HibernateUtil.getSessionFactory().openSession();
        sesion.getTransaction().begin();
        try {
            for (Iterator it = lComprobantePago.iterator(); it.hasNext();) {
                ComprobantePago objComprobantePago = (ComprobantePago) it.next();
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

    /**
     * Se cierra la sesion Hibernate
     *
     * @param tipo
     * @param serie
     * @return
     */
    public ComprobantePago leer_tipoSerie_SC(String tipo, String serie) {
        ComprobantePago obj = null;
        Transaction trns = null;
        sesion = HibernateUtil.getSessionFactory().openSession();
        try {
            Query q = sesion.createQuery("from ComprobantePago cp "
                    + "where substring(cp.registro,1,1)=1 "
                    + "and cp.tipo=:tipo and cp.serie=:serie")
                    .setParameter("tipo", tipo)
                    .setParameter("serie", serie)
                    .setMaxResults(1);
            obj = (ComprobantePago) q.list().get(0);
        } catch (Exception e) {
            setError(e.getMessage());
            e.printStackTrace();
        } finally {
            sesion.flush();
            sesion.close();
        }
        return obj;
    }
}
