/*
 * To change this template, choose Tools | Templates
 * and open the template in the editor.
 */
package articuloProductoClases;

import java.util.List;
import org.hibernate.Query;
import org.hibernate.Session;
import org.hibernate.Transaction;
import tablas.HibernateUtil;
import tablas.KardexArticuloProducto;
import utilitarios.cOtros;

/**
 *
 * @author Henrri
 */
public class cKardexArticuloProducto {

    Session sesion = null;
    public String error;

    public String getError() {
        return error;
    }

    public void setError(String error) {
        this.error = error;
    }

    public cKardexArticuloProducto() {
        this.sesion = HibernateUtil.getSessionFactory().getCurrentSession();
        this.error = null;
    }

    public int crear(KardexArticuloProducto objKardexArticuloProducto) {
        int cod = 0;
        Transaction trns = null;
        sesion = HibernateUtil.getSessionFactory().openSession();
        try {
            trns = sesion.beginTransaction();
            cod = (Integer) sesion.save(objKardexArticuloProducto);
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

    public List leer(int codArticuloProducto, int codAlmacen) {
        setError(null);
        try {
            sesion = HibernateUtil.getSessionFactory().openSession();
            Query q = sesion.createQuery("from KardexArticuloProducto a "
                    + "where substring(registro,1,1)=1 and a.articuloProducto.codArticuloProducto=:codArticuloProducto "
                    + "and a.almacen.codAlmacen=:codAlmacen")
                    .setParameter("codArticuloProducto", codArticuloProducto)
                    .setParameter("codAlmacen", codAlmacen);
            return (List) q.list();
        } catch (Exception e) {
            setError(e.getMessage());
        }
        return null;
    }

    // <editor-fold defaultstate="collapsed" desc="Haga clic en el signo + para mostrar descripción">
    /**
     * Consulta el stock actual de un producto en un almacen (toma el kardex
     * ultimo en registrase)
     *
     * @param codArticuloProducto codigo del artículo a seleccionar
     * @param codAlmacen código del almacén
     * @return objeto de tipo KardexArticuloProducto
     */
    // </editor-fold>
    public KardexArticuloProducto leer_articuloProductoStock(int codArticuloProducto, int codAlmacen) {
        KardexArticuloProducto obj = null;
        Transaction trns = null;
        sesion = HibernateUtil.getSessionFactory().openSession();
        try {
            trns = sesion.beginTransaction();
            Query q = sesion.createQuery("from KardexArticuloProducto k where substring(registro,1,1)=1 and "
                    + "k.almacen.codAlmacen=:codAlmacen and "
                    + "k.articuloProducto.codArticuloProducto=:codArticuloProducto "
                    + "order by codKardexArticuloProducto desc")
                    .setParameter("codArticuloProducto", codArticuloProducto)
                    .setParameter("codAlmacen", codAlmacen)
                    .setMaxResults(1);
            obj = (KardexArticuloProducto) q.list().get(0);
        } catch (Exception e) {
            e.printStackTrace();
        } finally {
            sesion.flush();
        }
        return obj;
    }

    public List leer_admin() {
        setError(null);
        try {
            sesion = HibernateUtil.getSessionFactory().openSession();
            Query q = sesion.createQuery("from KardexArticuloProducto");
            return (List) q.list();
        } catch (Exception e) {
            setError(e.getMessage());
        }
        return null;
    }

    public boolean actualizar_registro(int codKardexArticuloProducto, String estado, String user) {
        cOtros objcOtros = new cOtros();
        setError(null);
        sesion = HibernateUtil.getSessionFactory().openSession();
        sesion.getTransaction().begin();
        KardexArticuloProducto obj = (KardexArticuloProducto) sesion.get(KardexArticuloProducto.class, codKardexArticuloProducto);
        obj.setRegistro(objcOtros.registro(estado, user));
        try {
            sesion.update(obj);
            sesion.getTransaction().commit();
            return true;
        } catch (Exception e) {
            sesion.getTransaction().rollback();
            setError("KardexArticuloProducto_actualizar_registro: " + e.getMessage());
        }
        return false;
    }
    
}
