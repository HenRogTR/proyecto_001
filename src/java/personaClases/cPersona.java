/*
 * To change this template, choose Tools | Templates
 * and open the template in the editor.
 */
package personaClases;

import java.util.List;
import org.hibernate.Query;
import org.hibernate.Session;
import otros.cUtilitarios;
import tablas.HibernateUtil;
import tablas.Persona;

/**
 *
 * @author Henrri
 */
public class cPersona {

    Session sesion = null;
    public String error;

    public String getError() {
        return error;
    }

    public void setError(String error) {
        this.error = error;
    }

    public cPersona() {
        this.sesion = HibernateUtil.getSessionFactory().getCurrentSession();
    }

    /**
     * Crear un objeto para la tabla persona, devolviendo el id de la persona
     * creada.
     *
     * @param objPersona
     * @return código con el que se creó y 0 si en caso no se ha creado.
     */
    public int crear(Persona objPersona) {
        setError(null);
        sesion = HibernateUtil.getSessionFactory().openSession();
        sesion.getTransaction().begin();
        try {
            int codPersona = (Integer) sesion.save(objPersona);
            sesion.getTransaction().commit();
            return codPersona;
        } catch (Exception e) {
            sesion.getTransaction().rollback();
            e.printStackTrace();
            setError(e.getMessage());
        }
        return 0;
    }

    public boolean actualizarObjeto(Persona objPersona) {
        setError(null);
        sesion = HibernateUtil.getSessionFactory().openSession();
        sesion.getTransaction().begin();
        try {
            sesion.update(objPersona);
            sesion.getTransaction().commit();
            return true;
        } catch (Exception e) {
            sesion.getTransaction().rollback();
            e.printStackTrace();
            setError(e.getMessage());
        }
        return false;
    }

    /**
     * Listado de persona con todos los de estado 1
     *
     * @return lista con persona o null.
     */
    public List leer() {
        setError(null);
        try {
            sesion = HibernateUtil.getSessionFactory().openSession();
            Query q = sesion.createQuery("from Persona where substring(registro,1,1)=1");
            return (List) q.list();
        } catch (Exception e) {
            setError(e.getMessage());
        }
        return null;
    }

    /**
     *
     * @param codPersona
     * @return
     */
    public Persona leer_cod(int codPersona) {
        Session session = HibernateUtil.getSessionFactory().openSession();
        return (Persona) session.get(Persona.class, codPersona);
    }

    public List leer_admin() {
        setError(null);
        try {
            sesion = HibernateUtil.getSessionFactory().openSession();
            Query q = sesion.createQuery("from Persona");
            return (List) q.list();
        } catch (Exception e) {
            setError(e.getMessage());
        }
        return null;
    }

    public List leer_clientes() {
        setError(null);
        try {
            sesion = HibernateUtil.getSessionFactory().openSession();
            Query q = sesion.createQuery("from Persona");
            return (List) q.list();
        } catch (Exception e) {
            setError(e.getMessage());
        }
        return null;
    }

    /**
     * Retorna el objeto con los datos de una persona listados por DniPasaporte
     *
     * @param dniPasaporte
     * @return
     */
    public Persona leer_dniPasaporte(String dniPasaporte) {
        setError(null);
        try {
            sesion = HibernateUtil.getSessionFactory().openSession();
            Query q = sesion.createQuery("from Persona where dniPasaporte=:dniPasaporte or substring(ruc,3,8) like :ruc and substring(registro,1,1)=1")
                    .setParameter("dniPasaporte", dniPasaporte)
                    .setParameter("ruc", "%" + dniPasaporte + "%");
            return (Persona) q.list().iterator().next();
        } catch (Exception e) {
            setError(e.getMessage());
        }
        return null;
    }

    /**
     * Retorna el objeto persona por Ruc o sino toma los 8 de los 11 caracteres
     * del ruc que vendria a ser el dni.
     *
     * @param term
     * @return
     */
    public Persona leer_ruc(String term) {
        setError(null);
        sesion = HibernateUtil.getSessionFactory().openSession();
        try {
            Query q = sesion.createQuery("from Persona where ruc=:ruc or dniPasaporte=:dniPasaporte "
                    + "and substring(registro,1,1)=1")
                    .setParameter("ruc", term)
                    .setParameter("dniPasaporte", term.substring(2, term.length() - 1));
            return (Persona) q.list().get(0);
        } catch (Exception e) {
            setError(e.getMessage());
        }
        return null;
    }

    /**
     * Retorna listado de persona que coiicida por dni o ruc
     *
     * @param term
     * @return
     */
    public List leer_dniPasaporte_ruc(String term) {
        setError(null);
        sesion = HibernateUtil.getSessionFactory().openSession();
        try {
            Query q = sesion.createQuery("from Persona p "
                    + "where (p.dniPasaporte like :term or p.ruc like :term) "
                    + "and substring(registro,1,1)='1' "
                    + "order by p.nombresC asc")
                    .setParameter("term", "%" + term + "%");
            return q.list();
        } catch (Exception e) {
            setError(e.getMessage());
        }
        return null;
    }

    /**
     * Listado de persona con coincidencia en nombre.
     *
     * @param term
     * @return
     */
    public List leer_nombresC(String term) {
        setError(null);
        sesion = HibernateUtil.getSessionFactory().openSession();
        try {
            Query q = sesion.createQuery("from Persona p "
                    + "where p.nombresC like :term "
                    + "and substring(registro,1,1)='1' "
                    + "order by p.nombresC asc")
                    .setParameter("term", "%" + term + "%");
            return q.list();
        } catch (Exception e) {
            setError(e.getMessage());
        }
        return null;
    }

    public List leer_clientes_admin() {
        setError(null);
        try {
            sesion = HibernateUtil.getSessionFactory().openSession();
            Query q = sesion.createQuery("from Persona");
            return (List) q.list();
        } catch (Exception e) {
            setError(e.getMessage());
        }
        return null;
    }

    /**
     *
     * @param objPersona
     * @return
     */
    public boolean actualizar(Persona objPersona) {
        setError(null);
//        sesion = HibernateUtil.getSessionFactory().openSession();
        try {
            sesion.beginTransaction();
            sesion.update(objPersona);
            sesion.beginTransaction().commit();
            return true;
        } catch (Exception e) {
            setError("Error al actualizar persona..." + e.getMessage());
            sesion.beginTransaction().rollback();
        }
        return false;
    }

    public boolean actualizar_(Persona objPersona) {
        sesion = HibernateUtil.getSessionFactory().openSession();
        sesion.getTransaction().begin();
        try {
            sesion.update(objPersona);
            sesion.getTransaction().commit();
            return true;
        } catch (Exception e) {
            sesion.getTransaction().rollback();
            e.printStackTrace();
            setError(e.getMessage());
        }
        return false;
    }

    public boolean actualizar_registro(int codPersona, String estado, String user) {
        cUtilitarios objUtilitarios = new cUtilitarios();
        setError(null);
        sesion = HibernateUtil.getSessionFactory().openSession();
        sesion.getTransaction().begin();
        Persona obj = (Persona) sesion.get(Persona.class, codPersona);
        obj.setRegistro(objUtilitarios.registro(estado, user));
        try {
            sesion.update(obj);
            sesion.getTransaction().commit();
            return true;
        } catch (Exception e) {
            sesion.getTransaction().rollback();
            setError("Persona_actualizar_est: " + e.getMessage());
        }
        return false;
    }

    /**
     * Tipo cliente 1=natural, 2=jurídico
     *
     * @param codPersona
     * @param tipoCliente
     * @return
     */
//    public boolean actualizar_tipoCliente(int codPersona, int tipoCliente) {
//        setError(null);
//        sesion = HibernateUtil.getSessionFactory().openSession();
//        sesion.getTransaction().begin();
//        Persona obj = (Persona) sesion.get(Persona.class, codPersona);
//        obj.setTipoCliente(tipoCliente);
//        try {
//            sesion.update(obj);
//            sesion.getTransaction().commit();
//            return true;
//        } catch (Exception e) {
//            sesion.getTransaction().rollback();
//            setError("Persona_actualizar_tipoCliente: " + e.getMessage());
//            return false;
//        }
//    }
    /**
     *
     * @param codPersona
     * @param telefono1
     * @return
     */
    public boolean actualizar_telefono1(int codPersona, String telefono1) {
        setError(null);
        sesion = HibernateUtil.getSessionFactory().openSession();
        sesion.getTransaction().begin();
        Persona obj = (Persona) sesion.get(Persona.class, codPersona);
        obj.setTelefono1(telefono1);
        try {
            sesion.update(obj);
            sesion.getTransaction().commit();
            return true;
        } catch (Exception e) {
            sesion.getTransaction().rollback();
            setError("Persona_actualizar_telefono1: " + e.getMessage());
            return false;
        }
    }

    /**
     *
     * @param codPersona
     * @param telefono2
     * @return
     */
    public boolean actualizar_telefono2(int codPersona, String telefono2) {
        setError(null);
        sesion = HibernateUtil.getSessionFactory().openSession();
        sesion.getTransaction().begin();
        Persona obj = (Persona) sesion.get(Persona.class, codPersona);
        obj.setTelefono1(telefono2);
        try {
            sesion.update(obj);
            sesion.getTransaction().commit();
            return true;
        } catch (Exception e) {
            sesion.getTransaction().rollback();
            setError("Persona_actualizar_telefono1: " + e.getMessage());
            return false;
        }
    }
}
