/*
 * To change this template, choose Tools | Templates
 * and open the template in the editor.
 */
package personaClases;

import java.util.List;
import org.hibernate.Query;
import org.hibernate.Session;
import tablas.HibernateUtil;
import tablas.Personal;

/**
 *
 * @author Henrri
 */
public class cPersonal {

    Session sesion = null;
    public String error;

    public String getError() {
        return error;
    }

    public void setError(String error) {
        this.error = error;
    }

    public cPersonal() {
        this.sesion = HibernateUtil.getSessionFactory().getCurrentSession();
    }

    //**************************************************************************
    /**
     *
     * @param dniPasaporte
     * @return
     */
    public int crear(Personal objPersonal) {
        setError(null);
        sesion = HibernateUtil.getSessionFactory().openSession();
        sesion.getTransaction().begin();
        try {
            int codPersona = (Integer) sesion.save(objPersonal);
            sesion.getTransaction().commit();
            return codPersona;
        } catch (Exception e) {
            sesion.getTransaction().rollback();
            e.printStackTrace();
            setError(e.getMessage());
        }
        return 0;
    }

    public Personal leer_dniPasaporte(String dniPasaporte) {
        setError(null);
        try {
            sesion = HibernateUtil.getSessionFactory().openSession();
            Query q = sesion.createQuery("from Personal p "
                    + "where (p.persona.dniPasaporte=:dniPasaporte or p.persona.ruc like :ruc) "
                    + "and substring(p.registro,1,1)=1")
                    .setParameter("dniPasaporte", dniPasaporte)
                    .setParameter("ruc", "%" + dniPasaporte + "%");
            return (Personal) q.list().iterator().next();
        } catch (Exception e) {
            setError(e.getMessage());
        }
        return null;
    }

    public Personal leer_ruc(String ruc) {
        setError(null);
        try {
            sesion = HibernateUtil.getSessionFactory().openSession();
            Query q = sesion.createQuery("from Personal p "
                    + "where (p.persona.dniPasaporte like :dniPasaporte or p.persona.ruc=:ruc) "
                    + "and substring(p.registro,1,1)=1")
                    .setParameter("dniPasaporte", "%" + ruc.substring(2, ruc.length() - 1) + "%")
                    .setParameter("ruc", ruc);
            return (Personal) q.list().iterator().next();
        } catch (Exception e) {
            setError(e.getMessage());
        }
        return null;
    }

    public Personal leer_cod(int codPersonal) {
        sesion = HibernateUtil.getSessionFactory().openSession();
        return (Personal) sesion.get(Personal.class, codPersonal);
    }

    public Personal leer_primero() {
        setError(null);
        sesion = HibernateUtil.getSessionFactory().openSession();
        try {
            Query q = sesion.createQuery("from Personal p where substring(p.registro,1,1)=1 "
                    + "and substring(p.persona.registro,1,1)=1 "
                    + "order by p.codPersonal asc")
                    .setMaxResults(1);
            return (Personal) q.list().iterator().next();
        } catch (Exception e) {
            setError("Error en consulta datos clientes: " + e.getMessage());
        }
        return null;
    }

    public Personal leer_ultimo() {
        setError(null);
        sesion = HibernateUtil.getSessionFactory().openSession();
        try {
            Query q = sesion.createQuery("from Personal p where substring(p.registro,1,1)=1 "
                    + "and substring(p.persona.registro,1,1)=1 "
                    + "order by p.codPersonal desc")
                    .setMaxResults(1);
            return (Personal) q.list().iterator().next();
        } catch (Exception e) {
            setError("Error en consulta datos clientes: " + e.getMessage());
        }
        return null;
    }

    public boolean actualizar(Personal objPersonal) {
        sesion = HibernateUtil.getSessionFactory().openSession();
        sesion.getTransaction().begin();
        try {
            sesion.update(objPersonal);
            sesion.getTransaction().commit();
            return true;
        } catch (Exception e) {
            sesion.getTransaction().rollback();
            e.printStackTrace();
            setError(e.getMessage());
        }
        return false;
    }

    public List leer_cobradorVendedor(String term) {
        setError(null);
        try {
            sesion = HibernateUtil.getSessionFactory().openSession();
            Query q = sesion.createQuery("from Personal p "
                    + "where (p.persona.dniPasaporte=:term or p.persona.ruc like :term or p.persona.nombresC like :term) "
                    + "and p.cargo.codCargo=1"
                    + "and substring(p.registro,1,1)=1")
                    .setParameter("term", "%" + term + "%");
            return q.list();
        } catch (Exception e) {
            setError(e.getMessage());
        }
        return null;
    }

    public List leer_cobradorVendedor() {
        setError(null);
        try {
            sesion = HibernateUtil.getSessionFactory().openSession();
            Query q = sesion.createQuery("from Personal p "
                    + "where p.cargo.codCargo=1 "
                    + "and substring(p.registro,1,1)=1");
            return q.list();
        } catch (Exception e) {
            setError(e.getMessage());
        }
        return null;
    }
    
    public List leer_personal(String personal) {
        setError(null);
        try {
            sesion = HibernateUtil.getSessionFactory().openSession();
            Query q = sesion.createQuery("from Personal p "
                    + "where (p.persona.dniPasaporte=:term or p.persona.ruc like :term or p.persona.nombresC like :term) "                    
                    + "and substring(p.registro,1,1)=1")
                    .setParameter("term", "%" + personal + "%");
            return q.list();
        } catch (Exception e) {
            setError(e.getMessage());
        }
        return null;
    }
    //**************************************************************************
}
