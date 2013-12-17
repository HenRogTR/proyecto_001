/*
 * To change this template, choose Tools | Templates
 * and open the template in the editor.
 */
package cobranzaClases;

import java.util.List;
import org.hibernate.Query;
import org.hibernate.Session;
import otros.cUtilitarios;
import tablas.CobranzaDetalle;
import tablas.HibernateUtil;

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
    }

    //**************************************************************************
    public boolean Crear(CobranzaDetalle objCobranzaDetalle) {
        setError(null);
        sesion = HibernateUtil.getSessionFactory().openSession();
        sesion.getTransaction().begin();
        try {
            sesion.save(objCobranzaDetalle);
            sesion.getTransaction().commit();
            return true;
        } catch (Exception e) {
            sesion.getTransaction().rollback();
            e.printStackTrace();
            setError(e.getMessage());
        }
        return false;
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
        cUtilitarios objUtilitarios = new cUtilitarios();
        setError(null);
        sesion = HibernateUtil.getSessionFactory().openSession();
        sesion.getTransaction().begin();
        CobranzaDetalle obj = (CobranzaDetalle) sesion.get(CobranzaDetalle.class, codCobranzaDetalle);
        obj.setRegistro(objUtilitarios.registro(estado, user));
        try {
            sesion.update(obj);
            sesion.getTransaction().commit();
            return true;
        } catch (Exception e) {
            sesion.getTransaction().rollback();
            setError("CobranzaDetalle_actualizar_registro: " + e.getMessage());
        }
        return false;
    }
    //**************************************************************************
}
