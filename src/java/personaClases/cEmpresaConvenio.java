/*
 * To change this template, choose Tools | Templates
 * and open the template in the editor.
 */
package personaClases;

import java.util.List;
import org.hibernate.Query;
import org.hibernate.Transaction;
import org.hibernate.Session;
import tablas.EmpresaConvenio;
import tablas.HibernateUtil;
import utilitarios.cOtros;

/**
 *
 * @author Henrri
 */
public class cEmpresaConvenio {

    Session sesion = null;
    public String error;

    public String getError() {
        return error;
    }

    public void setError(String error) {
        this.error = error;
    }

    public cEmpresaConvenio() {
        this.sesion = HibernateUtil.getSessionFactory().getCurrentSession();
        this.error = null;
    }

    public int Crear(EmpresaConvenio objEmpresaConvenio) {
        setError(null);
        sesion = HibernateUtil.getSessionFactory().openSession();
        sesion.getTransaction().begin();
        try {
            int cod = (Integer) sesion.save(objEmpresaConvenio);
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
            Query q = sesion.createQuery("from EmpresaConvenio where substring(registro,1,1)=1");
            return (List) q.list();
        } catch (Exception e) {
            setError(e.getMessage());
        }
        return null;
    }

    public List leer_SC() {
        List l = null;
        Transaction trns = null;
        sesion = HibernateUtil.getSessionFactory().openSession();
        try {
            trns = sesion.beginTransaction();
            Query q = sesion.createQuery("from EmpresaConvenio ec "
                    + "where substring(ec.registro,1,1)=1");
            l = q.list();
        } catch (Exception e) {
            e.printStackTrace();
        } finally {
            sesion.flush();
            sesion.close();
        }
        return l;
    }

    public EmpresaConvenio leer_nombre(String nombre) {
        setError(null);
        try {
            sesion = HibernateUtil.getSessionFactory().openSession();
            Query q = sesion.createQuery("from EmpresaConvenio ec where substring(ec.registro,1,1)=1 "
                    + "and ec.nombre=:nombre")
                    .setParameter("nombre", nombre)
                    .setMaxResults(1);
            return (EmpresaConvenio) q.list().iterator().next();
        } catch (Exception e) {
            setError(e.getMessage());
            return null;
        }
    }

    public EmpresaConvenio leer_cod(int codEmpresaConvenio) {
        sesion = HibernateUtil.getSessionFactory().openSession();
        return (EmpresaConvenio) sesion.get(EmpresaConvenio.class, codEmpresaConvenio);
    }

    public List leer_admin() {
        setError(null);
        try {
            sesion = HibernateUtil.getSessionFactory().openSession();
            Query q = sesion.createQuery("from EmpresaConvenio");
            return (List) q.list();
        } catch (Exception e) {
            setError(e.getMessage());
        }
        return null;
    }

    public boolean actualizar_registro(int codEmpresaConvenio, String estado, String user) {
        sesion = HibernateUtil.getSessionFactory().openSession();
        sesion.getTransaction().begin();
        EmpresaConvenio obj = (EmpresaConvenio) sesion.get(EmpresaConvenio.class, codEmpresaConvenio);
        obj.setRegistro(new cOtros().registro(estado, user));
        try {
            sesion.update(obj);
            sesion.getTransaction().commit();
            return true;
        } catch (Exception e) {
            sesion.getTransaction().rollback();
            setError("EmpresaConvenio_actualizar_registro: " + e.getMessage());
        }
        return false;
    }

    public String generarCodCobranza(String codCobranza) {
        setError(null);
        try {
            sesion = HibernateUtil.getSessionFactory().openSession();
            Query q = sesion.createQuery("from EmpresaConvenio ec "
                    + "where ec.codCobranza like :codCobranza "
                    + "order by ec.codCobranza desc")
                    .setParameter("codCobranza", "%" + codCobranza + "%")
                    .setMaxResults(1);
            EmpresaConvenio objEmpresaConvenio = (EmpresaConvenio) q.list().iterator().next();
            int numero = Integer.parseInt(objEmpresaConvenio.getCodCobranza().substring(1, 3)) + 1;
            String a = String.valueOf(numero);
            return codCobranza + (a.length() < 2 ? ("0" + a) : a);
        } catch (Exception e) {
            setError(e.getMessage());
            return codCobranza + "01";
        }
    }

    public EmpresaConvenio leer_primero() {
        setError(null);
        sesion = HibernateUtil.getSessionFactory().openSession();
        try {
            Query q = sesion.createQuery("from EmpresaConvenio ec where substring(ec.registro,1,1)=1 "
                    + "order by ec.codEmpresaConvenio asc")
                    .setMaxResults(1);
            return (EmpresaConvenio) q.list().iterator().next();
        } catch (Exception e) {
            setError("EmpresaConvenio/leer_primero : " + e.getMessage());
            return null;
        }
    }

    public EmpresaConvenio leer_ultimo() {
        setError(null);
        sesion = HibernateUtil.getSessionFactory().openSession();
        try {
            Query q = sesion.createQuery("from EmpresaConvenio ec where substring(ec.registro,1,1)=1 "
                    + "order by ec.codEmpresaConvenio desc")
                    .setMaxResults(1);
            return (EmpresaConvenio) q.list().iterator().next();
        } catch (Exception e) {
            setError("EmpresaConvenio/leer_ultimo : " + e.getMessage());
            return null;
        }
    }

    public boolean actualizar(EmpresaConvenio objEmpresaConvenio) {
        sesion = HibernateUtil.getSessionFactory().openSession();
        sesion.getTransaction().begin();
        try {
            sesion.update(objEmpresaConvenio);
            sesion.getTransaction().commit();
            return true;
        } catch (Exception e) {
            sesion.getTransaction().rollback();
            e.printStackTrace();
            setError("DatosCliente_actualizar: " + e.getMessage());
        }
        return false;
    }

    public boolean actualizar_interesAsigando(int codEmpresaConvenio, boolean interesAsignado) {
        boolean estado = false;
        Transaction trns = null;
        sesion = HibernateUtil.getSessionFactory().openSession();
        try {
            trns = sesion.beginTransaction();
            EmpresaConvenio objEmpresaConvenio = (EmpresaConvenio) sesion.get(EmpresaConvenio.class, codEmpresaConvenio);
            objEmpresaConvenio.setInteresAsigando(interesAsignado);
            sesion.update(objEmpresaConvenio);
            sesion.getTransaction().commit();
            estado = true;
        } catch (Exception e) {
            if (trns != null) {
                trns.rollback();
            }
            e.printStackTrace();
        } finally {
            sesion.flush();
            sesion.close();
        }
        return estado;
    }

    public boolean actualizar_interesAutomatico(int codEmpresaConvenio, boolean interesAutomatico) {
        boolean estado = false;
        Transaction trns = null;
        sesion = HibernateUtil.getSessionFactory().openSession();
        try {
            trns = sesion.beginTransaction();
            EmpresaConvenio objEmpresaConvenio = (EmpresaConvenio) sesion.get(EmpresaConvenio.class, codEmpresaConvenio);
            objEmpresaConvenio.setInteresAutomatico(interesAutomatico);
            sesion.update(objEmpresaConvenio);
            sesion.getTransaction().commit();
            estado = true;
        } catch (Exception e) {
            if (trns != null) {
                trns.rollback();
            }
            e.printStackTrace();
        } finally {
            sesion.flush();
            sesion.close();
        }
        return estado;
    }
}
