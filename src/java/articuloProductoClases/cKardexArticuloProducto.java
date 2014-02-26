/*
 * To change this template, choose Tools | Templates
 * and open the template in the editor.
 */
package articuloProductoClases;

import java.util.List;
import org.hibernate.Query;
import org.hibernate.Session;
import org.hibernate.Transaction;
import otros.cUtilitarios;
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
     * Me retorna un objeto del tipo KardexAticuloProducto ó null en caso no
     * haya. Para este caso se usa como <b>codOperacion</b> 1.
     *
     * @param codArticuloProducto
     * @param codAlmacen
     * @return objeto de tipo KardexArticuloProducto
     */
    // </editor-fold>
    public KardexArticuloProducto leer_ultimaCompra(int codArticuloProducto, int codAlmacen) {
        setError(null);
        try {
            sesion = HibernateUtil.getSessionFactory().openSession();
            Query q = sesion.createQuery("from KardexArticuloProducto k "
                    + "where substring(registro,1,1)=1 and k.tipoOperacion=1 "
                    + "and k.articuloProducto.codArticuloProducto=:codArticuloProducto "
                    + "and k.almacen.codAlmacen=:codAlmacen "
                    + "order by codKardexArticuloProducto desc")
                    .setParameter("codArticuloProducto", codArticuloProducto)
                    .setParameter("codAlmacen", codAlmacen)
                    .setMaxResults(1);
            return (KardexArticuloProducto) q.list().get(0);
        } catch (Exception e) {
            setError(e.getMessage());
        }
        return null;
    }

    // <editor-fold defaultstate="collapsed" desc="Haga clic en el signo + para mostrar descripción">
    /**
     * Me retorna un objeto del tipo KardexAticuloProducto ó null en caso no
     * haya. Para este caso se usa como <b>codOperacion</b> 2.
     *
     * @param codArticuloProducto
     * @param codAlmacen
     * @return objeto de tipo KardexArticuloProducto
     */
    // </editor-fold>
    public KardexArticuloProducto leer_ultimaVenta(int codArticuloProducto, int codAlmacen) {
        setError(null);
        try {
            sesion = HibernateUtil.getSessionFactory().openSession();
            Query q = sesion.createQuery("from KardexArticuloProducto k "
                    + "where substring(registro,1,1)=1 and k.tipoOperacion=2 "
                    + "and k.articuloProducto.codArticuloProducto=:codArticuloProducto "
                    + "and k.almacen.codAlmacen=:codAlmacen "
                    + "order by codKardexArticuloProducto desc")
                    .setParameter("codArticuloProducto", codArticuloProducto)
                    .setParameter("codAlmacen", codAlmacen)
                    .setMaxResults(1);
            return (KardexArticuloProducto) q.list().get(0);
        } catch (Exception e) {
            setError(e.getMessage());
        }
        return null;
    }

    // <editor-fold defaultstate="collapsed" desc="Haga clic en el signo + para mostrar descripción">
    /**
     * Me retorna un objeto del tipo KardexAticuloProducto ó null en caso no
     * haya. Para este caso se usa como <b>codOperacion</b> 3.
     *
     * @param codArticuloProducto
     * @param codAlmacen
     * @return objeto de tipo KardexArticuloProducto
     */
    // </editor-fold>
    public KardexArticuloProducto leer_ultimoTraslado(int codArticuloProducto, int codAlmacen) {
        setError(null);
        try {
            sesion = HibernateUtil.getSessionFactory().openSession();
            Query q = sesion.createQuery("from KardexArticuloProducto k "
                    + "where substring(registro,1,1)=1 and k.tipoOperacion=3 "
                    + "and k.articuloProducto.codArticuloProducto=:codArticuloProducto "
                    + "and k.almacen.codAlmacen=:codAlmacen "
                    + "order by codKardexArticuloProducto desc")
                    .setParameter("codArticuloProducto", codArticuloProducto)
                    .setParameter("codAlmacen", codAlmacen)
                    .setMaxResults(1);
            return (KardexArticuloProducto) q.list().get(0);
        } catch (Exception e) {
            setError(e.getMessage());
        }
        return null;
    }

    // <editor-fold defaultstate="collapsed" desc="Haga clic en el signo + para mostrar descripción">
    /**
     * Me retorna un objeto del tipo KardexAticuloProducto ó null en caso no
     * haya. Para este caso se usa como <b>codOperacion</b> 4.
     *
     * @param codArticuloProducto
     * @param codAlmacen
     * @return objeto de tipo KardexArticuloProducto
     */
    // </editor-fold>
    public KardexArticuloProducto leer_ultimaActualizacionManual(int codArticuloProducto, int codAlmacen) {
        setError(null);
        try {
            sesion = HibernateUtil.getSessionFactory().openSession();
            Query q = sesion.createQuery("from KardexArticuloProducto k "
                    + "where substring(registro,1,1)=1 and k.tipoOperacion=4 "
                    + "and k.articuloProducto.codArticuloProducto=:codArticuloProducto "
                    + "and k.almacen.codAlmacen=:codAlmacen "
                    + "order by codKardexArticuloProducto desc")
                    .setParameter("codArticuloProducto", codArticuloProducto)
                    .setParameter("codAlmacen", codAlmacen)
                    .setMaxResults(1);
            return (KardexArticuloProducto) q.list().get(0);
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

    public List leer_codOperacion_tipoOperacion_codArticuloProducto(int codOperacion, int tipoOperacion, int codArticuloProducto) {
        setError(null);
        sesion = HibernateUtil.getSessionFactory().openSession();
        try {
            Query q = sesion.createQuery("from KardexArticuloProducto k "
                    + "where k.codOperacion=:codOperacion "
                    + "and k.tipoOperacion=:tipoOperacion "
                    + "and k.articuloProducto.codArticuloProducto=:codArticuloProducto")
                    .setParameter("codOperacion", codOperacion)
                    .setParameter("tipoOperacion", tipoOperacion)
                    .setParameter("codArticuloProducto", codArticuloProducto);
            return q.list();
        } catch (Exception e) {
            setError("leer_codOperacion_tipoOperacion_codArticuloProducto " + e.getMessage());
        }
        return null;
    }

    public List leer_codOperacion_tipoOperacion(int codOperacion, int tipoOperacion) {
        setError(null);
        sesion = HibernateUtil.getSessionFactory().openSession();
        try {
            Query q = sesion.createQuery("from KardexArticuloProducto k "
                    + "where k.codOperacion=:codOperacion "
                    + "and k.tipoOperacion=:tipoOperacion ")
                    .setParameter("codOperacion", codOperacion)
                    .setParameter("tipoOperacion", tipoOperacion);
            return q.list();
        } catch (Exception e) {
            setError("leer_codOperacion_tipoOperacion_codArticuloProducto " + e.getMessage());
        }
        return null;
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

    public boolean actualizar_codOperacionDetalle(int codKardexArticuloProducto, int codOperacionDetalle) {
        sesion = HibernateUtil.getSessionFactory().openSession();
        sesion.getTransaction().begin();
        KardexArticuloProducto objKardexArticuloProducto = (KardexArticuloProducto) sesion.get(KardexArticuloProducto.class, codKardexArticuloProducto);
        objKardexArticuloProducto.setCodOperacionDetalle(codOperacionDetalle);
        try {
            sesion.update(objKardexArticuloProducto);
            sesion.getTransaction().commit();
            return true;
        } catch (Exception e) {
            sesion.getTransaction().rollback();
            setError("KardexArticuloProducto_actualizar_registro: " + e.getMessage());
        }
        return false;
    }
}
