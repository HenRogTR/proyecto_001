/*
 * To change this template, choose Tools | Templates
 * and open the template in the editor.
 */
package personaClases;

import java.util.List;
import org.hibernate.Query;
import org.hibernate.Session;
import org.hibernate.Transaction;
import otros.cUtilitarios;
import tablas.HibernateUtil;
import tablas.Proveedor;

/**
 *
 * @author Henrri
 */
public class cProveedor {

    Session sesion = null;
    public String error;

    public String getError() {
        return error;
    }

    public void setError(String error) {
        this.error = error;
    }

    public cProveedor() {
        this.sesion = HibernateUtil.getSessionFactory().getCurrentSession();
        this.error = null;
    }

    public int Crear(Proveedor objProveedor) {
        setError(null);
        sesion = HibernateUtil.getSessionFactory().openSession();
        sesion.getTransaction().begin();
        try {
            int cod = (Integer) sesion.save(objProveedor);
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
            Query q = sesion.createQuery("from Proveedor where substring(registro,1,1)=1");
            return (List) q.list();
        } catch (Exception e) {
            setError(e.getMessage());
        }
        return null;
    }

    public List leer_autocompletado() {
        setError(null);
        try {
            sesion = HibernateUtil.getSessionFactory().openSession();
            Query q = sesion.createQuery("from Proveedor where est=1");
            return (List) q.list();
        } catch (Exception e) {
            setError(e.getMessage());
        }

        return null;
    }

    public List leerRucRazonSocial(String criterio) {
        setError(null);
        try {
//            from Proveedor where substring(registro,1,1)=1 and ruc like '%asi%' or razonSocial like '%asi%'
            sesion = HibernateUtil.getSessionFactory().openSession();
            Query q = sesion.createQuery("from Proveedor where ruc like :criterio or razonSocial like :criterio and substring(registro,1,1)=1")
                    .setParameter("criterio", "%" + criterio + "%");
            return (List) q.list();
        } catch (Exception e) {
            setError(e.getMessage());
        }
        return null;
    }

    public List leer_coincidencia_SC(String term) {
        List l = null;
        Transaction trns = null;
        sesion = HibernateUtil.getSessionFactory().openSession();
        try {
            trns = sesion.beginTransaction();
            Query q = sesion.createQuery("from Proveedor p"
                    + " where (p.ruc like :par1 or p.razonSocial like :par1)"
                    + " and substring(p.registro,1,1) = 1 ")
                    .setString("par1", "%" + term.replace(" ", "%") + "%");
            l = q.list();
        } catch (Exception e) {
            e.printStackTrace();
            setError(e.getMessage());
        } finally {
            sesion.flush();
            sesion.close();
        }
        return l;
    }

    public List leerRucORazonSocial(String criterio) {
        setError(null);
        try {
            sesion = HibernateUtil.getSessionFactory().openSession();
            Query q = sesion.createQuery("from Proveedor where ruc like :criterio or razonSocial like :criterio and substring(registro,1,1)=1")
                    .setParameter("criterio", "%" + criterio + "%");
            return (List) q.list();
        } catch (Exception e) {
            setError(e.getMessage());
        }
        return null;
    }

    public Proveedor leer_cod(int codProveedor) {
        sesion = HibernateUtil.getSessionFactory().openSession();
        return (Proveedor) sesion.get(Proveedor.class, codProveedor);
    }

    public Proveedor leer_primero() {
        setError(null);
        sesion = HibernateUtil.getSessionFactory().openSession();
        try {
            Query q = sesion.createQuery("from Proveedor p "
                    + "where substring(registro,1,1)=1 "
                    + "order by p.codProveedor asc");
            return (Proveedor) q.list().iterator().next();
        } catch (Exception e) {
            setError(e.getMessage());
        }
        return null;
    }

    public Proveedor leer_ultimo() {
        setError(null);
        sesion = HibernateUtil.getSessionFactory().openSession();
        try {
            Query q = sesion.createQuery("from Proveedor p "
                    + "where substring(registro,1,1)=1 "
                    + "order by p.codProveedor desc");
            return (Proveedor) q.list().iterator().next();
        } catch (Exception e) {
            setError(e.getMessage());
        }
        return null;
    }

    public List leer_admin() {
        setError(null);
        try {
            sesion = HibernateUtil.getSessionFactory().openSession();
            Query q = sesion.createQuery("from Proveedor");
            return (List) q.list();
        } catch (Exception e) {
            setError(e.getMessage());
        }
        return null;
    }

    public boolean verificarProveedor(String ruc) {
        setError(null);
        try {
            sesion = HibernateUtil.getSessionFactory().openSession();
            Query q = sesion.createQuery("from Proveedor where substring(registro,1,1)=1 and ruc=:ruc")
                    .setParameter("ruc", ruc);
            Proveedor obj = (Proveedor) q.list().iterator().next();
            if (obj != null) {
                return true;
            }
        } catch (Exception e) {
            setError(e.getMessage());
        }
        return false;
    }

    /**
     * Busca una coincidencia de proveedor por el <b>RUC</b> diferente del
     * <b>codProveedor</b> proporcionado.
     *
     * @param codProveedor
     * @param ruc
     * @return
     */
    public boolean verificarRuc(int codProveedor, String ruc) {
        setError(null);
        sesion = HibernateUtil.getSessionFactory().openSession();
        try {
            Query q = sesion.createQuery("from Proveedor p "
                    + "where substring(p.registro,1,1)=1 "
                    + "and p.ruc=:ruc "
                    + "and p.codProveedor!=:codProveedor")
                    .setParameter("ruc", ruc)
                    .setParameter("codProveedor", codProveedor);
            if (q.list().size() > 0) {
                return false;
            }

        } catch (Exception e) {
            setError(e.getMessage());
        }
        return true;
    }

    /**
     * Busca una coincidencia de proveedor por el <b>razonSocial</b> diferente
     * del
     * <b>codProveedor</b> proporcionado.
     *
     * @param codProveedor
     * @param razonSocial
     * @return
     */
    public boolean verificarRazonSocial(int codProveedor, String razonSocial) {
        setError(null);
        sesion = HibernateUtil.getSessionFactory().openSession();
        try {
            Query q = sesion.createQuery("from Proveedor p "
                    + "where substring(p.registro,1,1)=1 "
                    + "and p.razonSocial=:razonSocial "
                    + "and p.codProveedor!=:codProveedor")
                    .setParameter("razonSocial", razonSocial)
                    .setParameter("codProveedor", codProveedor);
            if (q.list().size() > 0) {
                return false;
            }

        } catch (Exception e) {
            setError(e.getMessage());
        }
        return true;
    }

    public Proveedor leer_ruc(String ruc) {
        setError(null);
        try {
            sesion = HibernateUtil.getSessionFactory().openSession();
            Query q = sesion.createQuery("from Proveedor where substring(registro,1,1)=1 and ruc=:ruc")
                    .setParameter("ruc", ruc);
            Proveedor obj = (Proveedor) q.list().iterator().next();
            return obj;
        } catch (Exception e) {
            setError(e.getMessage());
        }
        return null;
    }

    public Proveedor leer_razonSocial(String razonSocial) {
        setError(null);
        try {
            sesion = HibernateUtil.getSessionFactory().openSession();
            Query q = sesion.createQuery("from Proveedor where substring(registro,1,1)=1 and razonSocial=:razonSocial")
                    .setParameter("razonSocial", razonSocial);
            return (Proveedor) q.list().iterator().next();
        } catch (Exception e) {
            setError(e.getMessage());
        }
        return null;
    }

    public boolean proveedorRazonSocialVerificar(String razonSocial) {
        setError(null);
        try {
            sesion = HibernateUtil.getSessionFactory().openSession();
            Query q = sesion.createQuery("from Proveedor where substring(registro,1,1)=1 and razonSocial=:razonSocial")
                    .setParameter("razonSocial", razonSocial);
            Proveedor obj = (Proveedor) q.list().iterator().next();
            if (obj != null) {
                return true;
            }
        } catch (Exception e) {
            setError(e.getMessage());
        }
        return false;
    }

    public boolean actualizar_registro(int codProveedor, String estado, String user) {
        cUtilitarios objUtilitarios = new cUtilitarios();
        setError(null);
        sesion = HibernateUtil.getSessionFactory().openSession();
        sesion.getTransaction().begin();
        Proveedor obj = (Proveedor) sesion.get(Proveedor.class, codProveedor);
        obj.setRegistro(objUtilitarios.registro(estado, user));
        try {
            sesion.update(obj);
            sesion.getTransaction().commit();
            return true;
        } catch (Exception e) {
            sesion.getTransaction().rollback();
            setError("Proveedor_actualizar_est: " + e.getMessage());
        }
        return false;
    }
}
