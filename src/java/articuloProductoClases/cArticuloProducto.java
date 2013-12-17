/*
 * To change this template, choose Tools | Templates
 * and open the template in the editor.
 */
package articuloProductoClases;

import java.util.List;
import org.hibernate.Query;
import org.hibernate.Session;
import otros.cUtilitarios;
import tablas.ArticuloProducto;
import tablas.HibernateUtil;

/**
 *
 * @author Henrri
 */
public class cArticuloProducto {

    Session sesion = null;
    public String error;

    public String getError() {
        return error;
    }

    public void setError(String error) {
        this.error = error;
    }

    public cArticuloProducto() {
        this.sesion = HibernateUtil.getSessionFactory().getCurrentSession();
    }

    //**************************************************************
    public int Crear(ArticuloProducto objArticuloProducto) {
        setError(null);
        sesion = HibernateUtil.getSessionFactory().openSession();
        sesion.getTransaction().begin();
        try {
            int cod = (Integer) sesion.save(objArticuloProducto);
            sesion.getTransaction().commit();
            return cod;
        } catch (Exception e) {
            sesion.getTransaction().rollback();
            e.printStackTrace();
            setError(e.getMessage());
        }
        return 0;
    }

    public ArticuloProducto leer_cod(int codArticuloProducto) {
        Session session = HibernateUtil.getSessionFactory().openSession();
        return (ArticuloProducto) session.get(ArticuloProducto.class, codArticuloProducto);
    }

    public ArticuloProducto leer_primero() {
        setError(null);
        sesion = HibernateUtil.getSessionFactory().openSession();
        try {
            sesion = HibernateUtil.getSessionFactory().openSession();
            Query q = sesion.createQuery("from ArticuloProducto ap "
                    + "where substring(ap.registro,1,1)=1 "
                    + "order by ap.codArticuloProducto asc")
                    .setMaxResults(1);
            return ((ArticuloProducto) q.list().iterator().next());
        } catch (Exception e) {
            setError(e.getMessage());
        }
        return null;
    }

    public ArticuloProducto leer_ultimo() {
        setError(null);
        sesion = HibernateUtil.getSessionFactory().openSession();
        try {
            sesion = HibernateUtil.getSessionFactory().openSession();
            Query q = sesion.createQuery("from ArticuloProducto ap "
                    + "where substring(ap.registro,1,1)=1 "
                    + "order by ap.codArticuloProducto desc")
                    .setMaxResults(1);
            return ((ArticuloProducto) q.list().iterator().next());
        } catch (Exception e) {
            setError(e.getMessage());
        }
        return null;
    }

    public List leer(String term) {
        setError(null);
        try {
            sesion = HibernateUtil.getSessionFactory().openSession();
            Query q = sesion.createQuery("from ArticuloProducto ap "
                    + "where ap.descripcion like :term "
                    + "and  substring(ap.registro,1,1)=1"
                    + "order by ap.descripcion").
                    setParameter("term", "%" + term + "%");
            return (List) q.list();
        } catch (Exception e) {
            setError(e.getMessage());
        }
        return null;
    }
//************************************

    public List leer() {
        setError(null);
        try {
            sesion = HibernateUtil.getSessionFactory().openSession();
            Query q = sesion.createQuery("from ArticuloProducto where substring(registro,1,1)=1");
            return (List) q.list();
        } catch (Exception e) {
            setError(e.getMessage());
        }
        return null;
    }

    //<editor-fold defaultstate="collapsed" desc="Haga clic en el signo + para mostrar descripción">
    /**
     * Obtener un listado de todos los articulos de una determinada familia
     *
     * @param codFamilia
     * @return
     */
    //</editor-fold>
    public List leer_familia(int codFamilia) {
        setError(null);
        try {
            sesion = HibernateUtil.getSessionFactory().openSession();
            Query q = sesion.createQuery("from ArticuloProducto a where "
                    + "a.familia.codFamilia=:codFamilia and "
                    + "substring(registro,1,1)=1")
                    .setParameter("codFamilia", codFamilia);
            return (List) q.list();
        } catch (Exception e) {
            setError(e.getMessage());
        }
        return null;
    }

    //<editor-fold defaultstate="collapsed" desc="Haga clic en el signo + para mostrar descripción">
    /**
     * Retorna una lista de articulos con coincidencias dadas en la la
     * descripción del artículo.
     *
     * @param term
     * @return
     */
    //</editor-fold>
    public List leer_descripcion(String term) {
        setError(null);
        try {
            sesion = HibernateUtil.getSessionFactory().openSession();
            Query q = sesion.createQuery("from ArticuloProducto a "
                    + "where a.descripcion like :term "
                    + "and  substring(registro,1,1)=1").
                    setParameter("term", "%" + term + "%");
            return (List) q.list();
        } catch (Exception e) {
            setError("Error leer x descripcion: " + e.getMessage());
        }
        return null;
    }

    public ArticuloProducto leer_top() {
        setError(null);
        try {
            sesion = HibernateUtil.getSessionFactory().openSession();
            Query q = sesion.createQuery("from ArticuloProducto where codArticuloProducto=1400 order by codArticuloProducto desc ");
            return (ArticuloProducto) q.list().get(0);
        } catch (Exception e) {
            setError(e.getMessage());
        }
        return null;
    }

    //<editor-fold defaultstate="collapsed" desc="Haga clic en el signo + para mostrar descripción">
    /**
     * Listar articulos ordenados alfabeticamente
     *
     * @return
     */
    //</editor-fold>
    public List leer_orderByDescripcion() {
        setError(null);
        try {
            sesion = HibernateUtil.getSessionFactory().openSession();
            Query q = sesion.createQuery("from ArticuloProducto a where "
                    + "substring(registro,1,1)=1 "
                    + "order by a.descripcion asc");
            return (List) q.list();
        } catch (Exception e) {
            setError(e.getMessage());
        }
        return null;
    }

    //<editor-fold defaultstate="collapsed" desc="Haga clic en el signo + para mostrar descripción">
    /**
     *
     * @param codFamilia
     * @return
     */
    //</editor-fold>
    public List leer_familia_orderByDescripcion(int codFamilia) {
        setError(null);
        try {
            sesion = HibernateUtil.getSessionFactory().openSession();
            Query q = sesion.createQuery("from ArticuloProducto a where "
                    + "a.familia.codFamilia=:codFamilia and "
                    + "substring(registro,1,1)=1 "
                    + "order by a.descripcion asc")
                    .setParameter("codFamilia", codFamilia);
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
            Query q = sesion.createQuery("from ArticuloProducto");
            return (List) q.list();
        } catch (Exception e) {
            setError(e.getMessage());
        }
        return null;
    }

    public boolean verficarArticuloProducto(String descripcion) {
        setError(null);
        try {
            sesion = HibernateUtil.getSessionFactory().openSession();
            Query q = sesion.createQuery("from ArticuloProducto where substring(registro,1,1)=1 and descripcion=:descripcion")
                    .setParameter("descripcion", descripcion);
            ArticuloProducto objArticuloProducto = (ArticuloProducto) q.list().iterator().next();
            if (objArticuloProducto != null) {
                return true;
            }
        } catch (Exception e) {
            setError(e.getMessage());
        }
        return false;
    }

    public boolean actualizar_registro(int codArticuloProducto, String estado, String user) {
        cUtilitarios objUtilitarios = new cUtilitarios();
        setError(null);
        sesion = HibernateUtil.getSessionFactory().openSession();
        sesion.getTransaction().begin();
        ArticuloProducto obj = (ArticuloProducto) sesion.get(ArticuloProducto.class, codArticuloProducto);
        obj.setRegistro(objUtilitarios.registro(estado, user));
        try {
            sesion.update(obj);
            sesion.getTransaction().commit();
            return true;
        } catch (Exception e) {
            sesion.getTransaction().rollback();
            setError("ArticuloProducto_actualizar_registro: " + e.getMessage());
        }
        return false;
    }

    public boolean actualizar_precio_venta(int codArticuloProducto, Double precioVenta, int precioVentaRango) {
        setError(null);
        sesion = HibernateUtil.getSessionFactory().openSession();
        sesion.getTransaction().begin();
        ArticuloProducto obj = (ArticuloProducto) sesion.get(ArticuloProducto.class, codArticuloProducto);
        obj.setPrecioVenta(precioVenta);
        obj.setPrecioVentaRango(precioVentaRango);
        try {
            sesion.update(obj);
            sesion.getTransaction().commit();
            return true;
        } catch (Exception e) {
            sesion.getTransaction().rollback();
            setError("ArticuloProducto_precioVenta: " + e.getMessage());
        }
        return false;
    }

    /**
     *
     * @param objArticuloProducto
     * @return
     */
    public boolean actualizar(ArticuloProducto objArticuloProducto) {
        setError(null);
        sesion = HibernateUtil.getSessionFactory().openSession();
        sesion.getTransaction().begin();
        try {
            sesion.update(objArticuloProducto);
            sesion.getTransaction().commit();
            return true;
        } catch (Exception e) {
            sesion.getTransaction().rollback();
            setError("ArticuloProducto_actualizar: " + e.getMessage());
        }
        HibernateUtil.getSessionFactory().close();
        return false;
    }
}
