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
        this.error = null;
    }

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
        sesion = HibernateUtil.getSessionFactory().openSession();
        return (ArticuloProducto) sesion.get(ArticuloProducto.class, codArticuloProducto);
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
                    setParameter("term", "%" + term.replace(" ", "%") + "%");
            return (List) q.list();
        } catch (Exception e) {
            setError(e.getMessage());
        }
        return null;
    }

    /**
     *
     * @param term
     * @return
     */
    public List leer_SC(String term) {
        List l = null;
        Transaction trns = null;
        sesion = HibernateUtil.getSessionFactory().openSession();
        try {
            trns = sesion.beginTransaction();
            Query q = sesion.createQuery("from ArticuloProducto ap "
                    + " where ap.descripcion like :term"
                    + " and substring(ap.registro,1,1)=1"
                    + " order by ap.descripcion").
                    setParameter("term", "%" + term.replace(" ", "%") + "%");
            l = q.list();
        } catch (Exception e) {
            e.printStackTrace();
        } finally {
            sesion.flush();
            sesion.close();
        }
        return l;
    }

    /**
     *
     * @return
     */
    public List leer_inventario_SC() {
        List l = null;
        Transaction trns = null;
        sesion = HibernateUtil.getSessionFactory().openSession();
        try {
            trns = sesion.beginTransaction();
            Query q = sesion.createQuery("select ap.codArticuloProducto,"
                    + " ap.descripcion"
                    + ", ap.usarSerieNumero"
                    + ", (select cd.precioUnitario from CompraDetalle cd"
                    + "     where cd = ( select max(cd1.codCompraDetalle) "
                    + "        from CompraDetalle cd1 where cd1.articuloProducto = ap and substring(cd1.registro,1,1) = '1' and substring(cd1.compra.registro,1,1) = '1' )"
                    + "   )"
                    + ", ap.precioVenta"
                    + ", (select kap.codKardexArticuloProducto from KardexArticuloProducto kap"
                    + "     where kap = ( select max(kap1.codKardexArticuloProducto) "
                    + "        from KardexArticuloProducto kap1 where kap1.articuloProducto = ap and substring(kap1.registro,1,1) = '1' ))"
                    + ", (select kap.stock from KardexArticuloProducto kap"
                    + "     where kap = ( select max(kap1.codKardexArticuloProducto) "
                    + "        from KardexArticuloProducto kap1 where kap1.articuloProducto = ap and substring(kap1.registro,1,1) = '1' ))"
                    + " from ArticuloProducto ap"
                    + " where substring(ap.registro,1,1) = 1");
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

    /**
     *
     * @return
     */
    public List leer_inventario_ordenDescripcion_SC() {
        List l = null;
        Transaction trns = null;
        sesion = HibernateUtil.getSessionFactory().openSession();
        try {
            trns = sesion.beginTransaction();
            Query q = sesion.createQuery("select ap.codArticuloProducto,"
                    + " ap.descripcion"
                    + ", ap.usarSerieNumero"
                    + ", (select cd.precioUnitario from CompraDetalle cd"
                    + "     where cd = ( select max(cd1.codCompraDetalle) "
                    + "        from CompraDetalle cd1 where cd1.articuloProducto = ap and substring(cd1.registro,1,1) = '1' and substring(cd1.compra.registro,1,1) = '1' )"
                    + "   )"
                    + ", ap.precioVenta"
                    + ", (select kap.codKardexArticuloProducto from KardexArticuloProducto kap"
                    + "     where kap = ( select max(kap1.codKardexArticuloProducto) "
                    + "        from KardexArticuloProducto kap1 where kap1.articuloProducto = ap and substring(kap1.registro,1,1) = '1' ))"
                    + ", (select kap.stock from KardexArticuloProducto kap"
                    + "     where kap = ( select max(kap1.codKardexArticuloProducto) "
                    + "        from KardexArticuloProducto kap1 where kap1.articuloProducto = ap and substring(kap1.registro,1,1) = '1' ))"
                    + " from ArticuloProducto ap"
                    + " where substring(ap.registro,1,1) = 1"
                    + " order by ap.descripcion");
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

    /**
     *
     * @param codFamilia
     * @return
     */
    public List leer_inventario_familia_SC(int codFamilia) {
        List l = null;
        Transaction trns = null;
        sesion = HibernateUtil.getSessionFactory().openSession();
        try {
            trns = sesion.beginTransaction();
            Query q = sesion.createQuery("select ap.codArticuloProducto,"
                    + " ap.descripcion"
                    + ", ap.usarSerieNumero"
                    + ", (select cd.precioUnitario from CompraDetalle cd"
                    + "     where cd = ( select max(cd1.codCompraDetalle) "
                    + "        from CompraDetalle cd1 where cd1.articuloProducto = ap and substring(cd1.registro,1,1) = '1' and substring(cd1.compra.registro,1,1) = '1' )"
                    + "   )"
                    + ", ap.precioVenta"
                    + ", (select kap.codKardexArticuloProducto from KardexArticuloProducto kap"
                    + "     where kap = ( select max(kap1.codKardexArticuloProducto) "
                    + "        from KardexArticuloProducto kap1 where kap1.articuloProducto = ap and substring(kap1.registro,1,1) = '1' ))"
                    + ", (select kap.stock from KardexArticuloProducto kap"
                    + "     where kap = ( select max(kap1.codKardexArticuloProducto) "
                    + "        from KardexArticuloProducto kap1 where kap1.articuloProducto = ap and substring(kap1.registro,1,1) = '1' ))"
                    + " from ArticuloProducto ap"
                    + " where substring(ap.registro,1,1) = 1"
                    + " and ap.familia = :par1")
                    .setInteger("par1", codFamilia);
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

    /**
     *
     * @param codFamilia
     * @return
     */
    public List leer_inventario_familia_ordenDescripcion_SC(int codFamilia) {
        List l = null;
        Transaction trns = null;
        sesion = HibernateUtil.getSessionFactory().openSession();
        try {
            trns = sesion.beginTransaction();
            Query q = sesion.createQuery("select ap.codArticuloProducto,"
                    + " ap.descripcion"
                    + ", ap.usarSerieNumero"
                    + ", (select cd.precioUnitario from CompraDetalle cd"
                    + "     where cd = ( select max(cd1.codCompraDetalle) "
                    + "        from CompraDetalle cd1 where cd1.articuloProducto = ap and substring(cd1.registro,1,1) = '1' and substring(cd1.compra.registro,1,1) = '1' )"
                    + "   )"
                    + ", ap.precioVenta"
                    + ", (select kap.codKardexArticuloProducto from KardexArticuloProducto kap"
                    + "     where kap = ( select max(kap1.codKardexArticuloProducto) "
                    + "        from KardexArticuloProducto kap1 where kap1.articuloProducto = ap and substring(kap1.registro,1,1) = '1' ))"
                    + ", (select kap.stock from KardexArticuloProducto kap"
                    + "     where kap = ( select max(kap1.codKardexArticuloProducto) "
                    + "        from KardexArticuloProducto kap1 where kap1.articuloProducto = ap and substring(kap1.registro,1,1) = '1' ))"
                    + " from ArticuloProducto ap"
                    + " where substring(ap.registro,1,1) = 1"
                    + " and ap.familia = :par1"
                    + " order by ap.descripcion")
                    .setInteger("par1", codFamilia);
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

    /**
     *
     * @param codFamilia
     * @param codMarca
     * @return
     */
    public List leer_inventario_familia_marca_SC(int codFamilia, int codMarca) {
        List l = null;
        Transaction trns = null;
        sesion = HibernateUtil.getSessionFactory().openSession();
        try {
            trns = sesion.beginTransaction();
            Query q = sesion.createQuery("select ap.codArticuloProducto,"
                    + " ap.descripcion"
                    + ", ap.usarSerieNumero"
                    + ", (select cd.precioUnitario from CompraDetalle cd"
                    + "     where cd = ( select max(cd1.codCompraDetalle) "
                    + "        from CompraDetalle cd1 where cd1.articuloProducto = ap and substring(cd1.registro,1,1) = '1' and substring(cd1.compra.registro,1,1) = '1' )"
                    + "   )"
                    + ", ap.precioVenta"
                    + ", (select kap.codKardexArticuloProducto from KardexArticuloProducto kap"
                    + "     where kap = ( select max(kap1.codKardexArticuloProducto) "
                    + "        from KardexArticuloProducto kap1 where kap1.articuloProducto = ap and substring(kap1.registro,1,1) = '1' ))"
                    + ", (select kap.stock from KardexArticuloProducto kap"
                    + "     where kap = ( select max(kap1.codKardexArticuloProducto) "
                    + "        from KardexArticuloProducto kap1 where kap1.articuloProducto = ap and substring(kap1.registro,1,1) = '1' ))"
                    + " from ArticuloProducto ap"
                    + " where substring(ap.registro,1,1) = 1"
                    + " and ap.familia = :par1"
                    + " and ap.marca = :par2")
                    .setInteger("par1", codFamilia)
                    .setInteger("par2", codMarca);
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

    /**
     *
     * @param codFamilia
     * @param codMarca
     * @return
     */
    public List leer_inventario_familia_marca_ordenDescripcion_SC(int codFamilia, int codMarca) {
        List l = null;
        Transaction trns = null;
        sesion = HibernateUtil.getSessionFactory().openSession();
        try {
            trns = sesion.beginTransaction();
            Query q = sesion.createQuery("select ap.codArticuloProducto,"
                    + " ap.descripcion"
                    + ", ap.usarSerieNumero"
                    + ", (select cd.precioUnitario from CompraDetalle cd"
                    + "     where cd = ( select max(cd1.codCompraDetalle) "
                    + "        from CompraDetalle cd1 where cd1.articuloProducto = ap and substring(cd1.registro,1,1) = '1' and substring(cd1.compra.registro,1,1) = '1' )"
                    + "   )"
                    + ", ap.precioVenta"
                    + ", (select kap.codKardexArticuloProducto from KardexArticuloProducto kap"
                    + "     where kap = ( select max(kap1.codKardexArticuloProducto) "
                    + "        from KardexArticuloProducto kap1 where kap1.articuloProducto = ap and substring(kap1.registro,1,1) = '1' ))"
                    + ", (select kap.stock from KardexArticuloProducto kap"
                    + "     where kap = ( select max(kap1.codKardexArticuloProducto) "
                    + "        from KardexArticuloProducto kap1 where kap1.articuloProducto = ap and substring(kap1.registro,1,1) = '1' ))"
                    + " from ArticuloProducto ap"
                    + " where substring(ap.registro,1,1) = 1"
                    + " and ap.familia = :par1"
                    + " and ap.marca = :par2"
                    + " order by ap.descripcion")
                    .setInteger("par1", codFamilia)
                    .setInteger("par2", codMarca);
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
                    setParameter("term", "%" + term.replace(" ", "%") + "%");
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
        Boolean est = false;
        Transaction trns = null;
        sesion = HibernateUtil.getSessionFactory().openSession();
        try {
            trns = sesion.beginTransaction();
            ArticuloProducto obj = (ArticuloProducto) sesion.get(ArticuloProducto.class, codArticuloProducto);
            obj.setPrecioVenta(precioVenta);
            obj.setPrecioVentaRango(precioVentaRango);
            sesion.update(obj);
            sesion.getTransaction().commit();
            est = true;
        } catch (Exception e) {
            if (trns != null) {
                trns.rollback();
            }
            e.printStackTrace();
        } finally {
            sesion.flush();
            sesion.close();
        }
        return est;
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
