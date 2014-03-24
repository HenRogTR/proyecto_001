/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package personaClases;

import java.util.List;
import org.hibernate.Query;
import org.hibernate.Transaction;
import org.hibernate.Session;
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
        this.error = null;
    }

    public int crear(DocumentoNotificacion objDocumentoNotificacion) {
        int cod = 0;
        Transaction trns = null;
        sesion = HibernateUtil.getSessionFactory().openSession();
        try {
            trns = sesion.beginTransaction();
            cod = (Integer) sesion.save(objDocumentoNotificacion);
            sesion.getTransaction().commit();
        } catch (Exception e) {
            if (trns != null) {
                trns.rollback();
            }
            setError(e.getMessage());
        } finally {
            sesion.flush();
            sesion.close();
        }
        return cod;
    }

    public List leer_codCliente(int codCliente) {
        List objList = null;
        setError(null);
       sesion = HibernateUtil.getSessionFactory().openSession();
        try {
            sesion.flush();
            Query q = sesion.createQuery("from DocumentoNotificacion dc "
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
        sesion = HibernateUtil.getSessionFactory().openSession();
        return (DocumentoNotificacion) sesion.get(DocumentoNotificacion.class, codDocumentoNotificacion);
    }

    public Boolean actualizar(DocumentoNotificacion objDocumentoNotificacion) {
        Boolean est = false;
        Transaction trns = null;
        sesion = HibernateUtil.getSessionFactory().openSession();
        try {
            trns = sesion.beginTransaction();
            sesion.update(objDocumentoNotificacion);
            sesion.getTransaction().commit();
            est = true;
        } catch (Exception e) {
            if (trns != null) {
                trns.rollback();
            }
            setError(e.getMessage());
        } finally {
            sesion.flush();
            sesion.close();
        }
        return est;
    }

    public Boolean actualizar_registro_historial(int codDocumentoNotificacion, String registro) {
        Boolean est = false;
        Transaction trns = null;
        sesion = HibernateUtil.getSessionFactory().openSession();
        try {
            DocumentoNotificacion obj = (DocumentoNotificacion) sesion.get(DocumentoNotificacion.class, codDocumentoNotificacion);
            obj.setRegistro(registro);
            trns = sesion.beginTransaction();
            sesion.update(obj);
            sesion.getTransaction().commit();
            est = true;
        } catch (Exception e) {
            if (trns != null) {
                trns.rollback();
            }
            setError(e.getMessage());
        } finally {
            sesion.flush();
            sesion.close();
        }
        return est;
    }

}
