/*
 * To change this template, choose Tools | Templates
 * and open the template in the editor.
 */
package otrasTablasClases;

import java.util.List;
import org.hibernate.Query;
import org.hibernate.classic.Session;
import tablas.DatosExtras;
import tablas.HibernateUtil;

/**
 *
 * @author Henrri
 */
public class cDatosExtras {

    Session sesion = null;
    public String error;

    public String getError() {
        return error;
    }

    public void setError(String error) {
        this.error = error;
    }

    public cDatosExtras() {
        this.sesion = HibernateUtil.getSessionFactory().getCurrentSession();
    }

    public List leer_cobranza() {
        setError(null);
        sesion = HibernateUtil.getSessionFactory().openSession();
        try {
            Query q = sesion.createQuery("from DatosExtras de where substring(de.registro,1,1)=1 "
                    + "and de.descripcionDato='serieCobranza'");
            return q.list();
        } catch (Exception e) {
            setError(e.getMessage());
            e.printStackTrace();
            return null;
        }
    }

    public List leer_ticketera() {
        setError(null);
        sesion = HibernateUtil.getSessionFactory().openSession();
        try {
            Query q = sesion.createQuery("from DatosExtras de where substring(de.registro,1,1)=1 "
                    + "and de.descripcionDato='ticketera1'");
            return q.list();
        } catch (Exception e) {
            setError(e.getMessage());
            e.printStackTrace();
            return null;
        }
    }

    public List leer_documentoCaja() {
        List l = null;
        sesion = HibernateUtil.getSessionFactory().openSession();
        try {
            Query q = sesion.createQuery("from DatosExtras de where substring(de.registro,1,1)=1 "
                    + "and de.descripcionDato='documentoCaja'");
            l = q.list();
        } catch (Exception e) {
            setError(e.getMessage());
            e.printStackTrace();
        }
        return l;
    }

    public List leer_documentoDescuento() {
        List l = null;
        sesion = HibernateUtil.getSessionFactory().openSession();
        try {
            Query q = sesion.createQuery("from DatosExtras de where substring(de.registro,1,1)=1 "
                    + "and de.descripcionDato='documentoDescuento'");
            l = q.list();
        } catch (Exception e) {
            setError(e.getMessage());
            e.printStackTrace();
        }
        return l;
    }

    public DatosExtras nombreEmpresa() {
        sesion = HibernateUtil.getSessionFactory().openSession();
        return (DatosExtras) sesion.get(DatosExtras.class, 1);
    }

    public DatosExtras rucEmpresa() {
        sesion = HibernateUtil.getSessionFactory().openSession();
        return (DatosExtras) sesion.get(DatosExtras.class, 2);
    }

    public DatosExtras direccionEmpresa() {
        sesion = HibernateUtil.getSessionFactory().openSession();
        return (DatosExtras) sesion.get(DatosExtras.class, 3);
    }

    public DatosExtras gerenteEmpresa() {
        sesion = HibernateUtil.getSessionFactory().openSession();
        return (DatosExtras) sesion.get(DatosExtras.class, 4);
    }

    public DatosExtras dniGerenteEmpresa() {
        sesion = HibernateUtil.getSessionFactory().openSession();
        return (DatosExtras) sesion.get(DatosExtras.class, 5);
    }

    public DatosExtras rucGerenteEmpresa() {
        sesion = HibernateUtil.getSessionFactory().openSession();
        return (DatosExtras) sesion.get(DatosExtras.class, 6);
    }
}
