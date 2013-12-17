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
import otros.cUtilitarios;
import tablas.HibernateUtil;
import tablas.OtrosCC;

/**
 *
 * @author Henrri
 */
public class cOtrosCC {

    Session sesion = null;
    public String error;

    public String getError() {
        return error;
    }

    public void setError(String error) {
        this.error = error;
    }

    public cOtrosCC() {
        this.sesion = HibernateUtil.getSessionFactory().getCurrentSession();
    }

    public int crear(OtrosCC objOtrosCC) {
        int cod = 0;
        Transaction trns = null;
        sesion = HibernateUtil.getSessionFactory().openSession();
        try {
            trns = sesion.beginTransaction();
            cod = (Integer) sesion.save(objOtrosCC);
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
        List objList = null;
        setError(null);
        sesion = HibernateUtil.getSessionFactory().openSession();
        try {
            sesion.flush();
            Query q = sesion.createQuery("from OtrosCC");
            objList = q.list();
        } catch (Exception e) {
            setError(e.getMessage());
        }
        return objList;
    }

    public List leer_codEmpresaConvenio(int codEmpresaConvenio) {
        List l = null;
        setError(null);
        sesion = HibernateUtil.getSessionFactory().openSession();
        try {
            Query q = sesion.createQuery("from OtrosCC occ "
                    + "where occ.empresaConvenio.codEmpresaConvenio=:cod")
                    .setParameter("cod", codEmpresaConvenio);
            l = q.list();
        } catch (Exception e) {
            setError(e.getMessage());
            e.printStackTrace();
        }
        return l;
    }

    public List leer_admin() {
        setError(null);
        try {
            sesion = HibernateUtil.getSessionFactory().openSession();
            Query q = sesion.createQuery("from OtrosCC");
            return (List) q.list();
        } catch (Exception e) {
            setError(e.getMessage());
        }
        return null;
    }

    public boolean actualizar_registro(int codOtrosCC, String estado, String user) {
        cUtilitarios objUtilitarios = new cUtilitarios();
        setError(null);
        sesion = HibernateUtil.getSessionFactory().openSession();
        sesion.getTransaction().begin();
        OtrosCC obj = (OtrosCC) sesion.get(OtrosCC.class, codOtrosCC);
        obj.setRegistro(objUtilitarios.registro(estado, user));
        try {
            sesion.update(obj);
            sesion.getTransaction().commit();
            return true;
        } catch (Exception e) {
            sesion.getTransaction().rollback();
            setError("OtrosCC_actualizar_registro: " + e.getMessage());
        }
        return false;
    }

}
