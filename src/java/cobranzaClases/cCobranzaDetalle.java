/*
 * To change this template, choose Tools | Templates
 * and open the template in the editor.
 */
package cobranzaClases;

import java.util.List;
import org.hibernate.Query;
import org.hibernate.Session;
import org.hibernate.Transaction;
import tablas.CobranzaDetalle;
import HiberanteUtil.HibernateUtil;
import utilitarios.cOtros;

/**
 *
 * @author Henrri
 */
public class cCobranzaDetalle {

    Session sesion = null;
    public String error;

    public String getError() {
        return error;
    }

    public void setError(String error) {
        this.error = error;
    }

    public cCobranzaDetalle() {
        this.sesion = HibernateUtil.getSessionFactory().getCurrentSession();
        this.error = null;
    }

    public boolean crear(CobranzaDetalle objCobranzaDetalle) {
        boolean est = false;
        Transaction trns = null;
        sesion = HibernateUtil.getSessionFactory().openSession();
        try {
            trns = sesion.beginTransaction();
            sesion.save(objCobranzaDetalle);
            sesion.getTransaction().commit();
            est = true;
        } catch (Exception e) {
            if (trns != null) {
                trns.rollback();
            }
            System.out.println(e.getMessage());
            e.printStackTrace();
        } finally {
            sesion.flush();
            sesion.close();
        }
        return est;
    }

    public List leer() {
        setError(null);
        try {
            sesion = HibernateUtil.getSessionFactory().openSession();
            Query q = sesion.createQuery("from CobranzaDetalle where substring(registro,1,1)=1");
            return (List) q.list();
        } catch (Exception e) {
            setError(e.getMessage());
        }
        return null;
    }

    public List leer_codCobranza(int codCobranza) {
        setError(null);
        try {
            sesion = HibernateUtil.getSessionFactory().openSession();
            Query q = sesion.createQuery("from CobranzaDetalle cd where substring(cd.registro,1,1)=1 "
                    + "and cd.cobranza.codCobranza=:codCobranza order by cd.codCobranzaDetalle")
                    .setParameter("codCobranza", codCobranza);
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
            Query q = sesion.createQuery("from CobranzaDetalle");
            return (List) q.list();
        } catch (Exception e) {
            setError(e.getMessage());
        }
        return null;
    }

    public boolean actualizar_registro(int codCobranzaDetalle, String estado, String user) {
        boolean est = false;
        Transaction trns = null;
        sesion = HibernateUtil.getSessionFactory().openSession();
        try {
            trns = sesion.beginTransaction();
            sesion.getTransaction().begin();
            CobranzaDetalle obj = (CobranzaDetalle) sesion.get(CobranzaDetalle.class, codCobranzaDetalle);
            obj.setRegistro(new cOtros().registro(estado, user));
            sesion.update(obj);
            sesion.getTransaction().commit();
            est = true;
        } catch (RuntimeException e) {
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

}
