/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package personaClases;

import java.util.List;
import org.hibernate.Query;
import org.hibernate.Transaction;
import org.hibernate.classic.Session;
import tablas.DocumentoNotificacion;
import tablas.HibernateUtil;

/**
 *
 * @author Henrri
 */
public class cDocumentoNotificacion {

    Session sesion = null;
    public String error;

    public String getError() {
        return error;
    }

    public void setError(String error) {
        this.error = error;
    }

    public cDocumentoNotificacion() {
        this.sesion = HibernateUtil.getSessionFactory().getCurrentSession();
    }

    public int crear(DocumentoNotificacion objDocumentoNotificacion) {
        int cod = 0;
        Transaction trns = null;
        Session session = HibernateUtil.getSessionFactory().openSession();
        try {
            trns = session.beginTransaction();
            cod = (Integer) session.save(objDocumentoNotificacion);
            session.getTransaction().commit();
        } catch (Exception e) {
            if (trns != null) {
                trns.rollback();
            }
            setError(e.getMessage());
        } finally {
            session.flush();
            session.close();
        }
        return cod;
    }

    public List leer_codCliente(int codCliente) {
        List objList = null;
        setError(null);
        Session session = HibernateUtil.getSessionFactory().openSession();
        try {
            session.flush();
            Query q = session.createQuery("from DocumentoNotificacion dc "
                    + "where substring(dc.registro,1,1)= 1 "
                    + "and dc.datosCliente.codDatosCliente= :codCliente "
                    + "order by dc.fech1 desc")
                    .setParameter("codCliente", codCliente);
            objList = q.list();
        } catch (Exception e) {
            e.printStackTrace();
            setError(e.getMessage());
        }
        return objList;
    }

    public DocumentoNotificacion leer_cod(int codDocumentoNotificacion) {
        Session session = HibernateUtil.getSessionFactory().openSession();
        return (DocumentoNotificacion) session.get(DocumentoNotificacion.class, codDocumentoNotificacion);
    }

    public Boolean actualizar(DocumentoNotificacion objDocumentoNotificacion) {
        Boolean est = false;
        Transaction trns = null;
        Session session = HibernateUtil.getSessionFactory().openSession();
        try {
            trns = session.beginTransaction();
            session.update(objDocumentoNotificacion);
            session.getTransaction().commit();
            est = true;
        } catch (Exception e) {
            if (trns != null) {
                trns.rollback();
            }
            setError(e.getMessage());
        } finally {
            session.flush();
            session.close();
        }
        return est;
    }

    public Boolean actualizar_registro_historial(int codDocumentoNotificacion, String registro) {
        Boolean est = false;
        Transaction trns = null;
        Session session = HibernateUtil.getSessionFactory().openSession();
        try {
            DocumentoNotificacion obj = (DocumentoNotificacion) session.get(DocumentoNotificacion.class, codDocumentoNotificacion);
            obj.setRegistro(registro);
            trns = session.beginTransaction();
            session.update(obj);
            session.getTransaction().commit();
            est = true;
        } catch (Exception e) {
            if (trns != null) {
                trns.rollback();
            }
            setError(e.getMessage());
        } finally {
            session.flush();
            session.close();
        }
        return est;
    }

}
