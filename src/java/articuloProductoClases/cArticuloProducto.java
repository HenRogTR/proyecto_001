/*
 * To change this template, choose Tools | Templates
 * and open the template in the editor.
 */
package articuloProductoClases;

import java.util.Date;
import java.util.List;
import org.hibernate.Query;
import org.hibernate.Session;
import org.hibernate.Transaction;
import tablas.ArticuloProducto;
import HiberanteUtil.HibernateUtil;
import utilitarios.cOtros;

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
            setError(e.getMessage());
        } finally {
            sesion.flush();
            sesion.close();
        }
        return l;
    }

    /**
     * <strong>precioUnitario</strong>; es el precio de compra ultimo, puede
     * retornar
     * <strong>NULL</strong> si en caso no se ha realizado ninguna compra.<br>
     * <strong>codKardexArticuloProducto</strong> y <strong>stock</strong>;
     * puede retornar <strong>NULL</strong>
     * si en caso no se ha realizado ninguna compra.
     *
     * @return 0:codArticuloProducto, 1:descripcion, 2:usarSerieNumero,
     * 3:precioUnitario, 4:precioVenta, 5:codKardexArticuloProducto, 6:stock
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
     * <strong>precioUnitario</strong>; es el precio de compra ultimo, puede
     * retornar
     * <strong>NULL</strong> si en caso no se ha realizado ninguna compra.<br>
     * <strong>codKardexArticuloProducto</strong> y <strong>stock</strong>;
     * puede retornar <strong>NULL</strong>
     * si en caso no se ha realizado ninguna compra.
     *
     * @return 0:codArticuloProducto, 1:descripcion, 2:usarSerieNumero,
     * 3:precioUnitario, 4:precioVenta, 5:codKardexArticuloProducto, 6:stock
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
     * <strong>precioUnitario</strong>; es el precio de compra ultimo, puede
     * retornar
     * <strong>NULL</strong> si en caso no se ha realizado ninguna compra.<br>
     * <strong>codKardexArticuloProducto</strong> y <strong>stock</strong>;
     * puede retornar <strong>NULL</strong>
     * si en caso no se ha realizado ninguna compra.
     *
     * @param codFamilia
     * @return 0:codArticuloProducto, 1:descripcion, 2:usarSerieNumero,
     * 3:precioUnitario, 4:precioVenta, 5:codKardexArticuloProducto, 6:stock
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
     * <strong>precioUnitario</strong>; es el precio de compra ultimo, puede
     * retornar
     * <strong>NULL</strong> si en caso no se ha realizado ninguna compra.<br>
     * <strong>codKardexArticuloProducto</strong> y <strong>stock</strong>;
     * puede retornar <strong>NULL</strong>
     * si en caso no se ha realizado ninguna compra.
     *
     * @param codFamilia
     * @return 0:codArticuloProducto, 1:descripcion, 2:usarSerieNumero,
     * 3:precioUnitario, 4:precioVenta, 5:codKardexArticuloProducto, 6:stock
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
     * <strong>precioUnitario</strong>; es el precio de compra ultimo, puede
     * retornar
     * <strong>NULL</strong> si en caso no se ha realizado ninguna compra.<br>
     * <strong>codKardexArticuloProducto</strong> y <strong>stock</strong>;
     * puede retornar <strong>NULL</strong>
     * si en caso no se ha realizado ninguna compra.
     *
     * @param codFamilia
     * @param codMarca
     * @return 0:codArticuloProducto, 1:descripcion, 2:usarSerieNumero,
     * 3:precioUnitario, 4:precioVenta, 5:codKardexArticuloProducto, 6:stock
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
     * <strong>precioUnitario</strong>; es el precio de compra ultimo, puede
     * retornar
     * <strong>NULL</strong> si en caso no se ha realizado ninguna compra.<br>
     * <strong>codKardexArticuloProducto</strong> y <strong>stock</strong>;
     * puede retornar <strong>NULL</strong>
     * si en caso no se ha realizado ninguna compra.
     *
     * @param codFamilia
     * @param codMarca
     * @return 0:codArticuloProducto, 1:descripcion, 2:usarSerieNumero,
     * 3:precioUnitario, 4:precioVenta, 5:codKardexArticuloProducto, 6:stock
     */
    public List leer_inventario_familia_marca_ordenDescripcion_SC(int codFamilia,
            int codMarca) {
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

    /**
     *
     * @param fechaInicio
     * @param fechaFin
     * @return 0:codArticuloProducto, 1:descripcion, 2:codVenta,
     * 3:docSerieNumero, 4:fecha, 5:cliente, 6:codVentaDetalle, 7:cantidad,
     * 8:precioVenta, 9:valorVenta
     */
    public List leer_vendidos_SC(Date fechaInicio, Date fechaFin) {
        List l = null;
        Transaction trns = null;
        sesion = HibernateUtil.getSessionFactory().openSession();
        try {
            trns = sesion.beginTransaction();
            Query q = sesion.createQuery("select ap.codArticuloProducto"
                    + ", ap.descripcion"
                    + ", vd.ventas.codVentas"
                    + ", vd.ventas.docSerieNumero"
                    + ", vd.ventas.fecha"
                    + ", vd.ventas.cliente"
                    + ", vd.codVentasDetalle"
                    + ", vd.cantidad"
                    + ", vd.precioVenta"
                    + ", vd.valorVenta"
                    + " from ArticuloProducto ap join ap.ventasDetalles vd"
                    + " where substring(vd.registro,1,1) = 1"
                    + " and substring(vd.ventas.registro,1,1) = 1"
                    + " and vd.ventas.fecha between :par1 and :par2"
                    + " order by ap.descripcion, vd.ventas.fecha")
                    .setDate("par1", fechaInicio)
                    .setDate("par2", fechaFin);
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
     * @param fechaInicio
     * @param fechaFin
     * @param codFamilia
     * @return 0:codArticuloProducto, 1:descripcion, 2:codVenta,
     * 3:docSerieNumero, 4:fecha, 5:cliente, 6:codVentaDetalle, 7:cantidad,
     * 8:precioVenta, 9:valorVenta
     */
    public List leer_vendidos_familia_SC(Date fechaInicio, Date fechaFin,
            int codFamilia) {
        List l = null;
        Transaction trns = null;
        sesion = HibernateUtil.getSessionFactory().openSession();
        try {
            trns = sesion.beginTransaction();
            Query q = sesion.createQuery("select ap.codArticuloProducto"
                    + ", ap.descripcion"
                    + ", vd.ventas.codVentas"
                    + ", vd.ventas.docSerieNumero"
                    + ", vd.ventas.fecha"
                    + ", vd.ventas.cliente"
                    + ", vd.codVentasDetalle"
                    + ", vd.cantidad"
                    + ", vd.precioVenta"
                    + ", vd.valorVenta"
                    + " from ArticuloProducto ap join ap.ventasDetalles vd"
                    + " where substring(vd.registro,1,1) = 1"
                    + " and substring(vd.ventas.registro,1,1) = 1"
                    + " and vd.ventas.fecha between :par1 and :par2"
                    + " and ap.familia = :par3"
                    + " order by ap.descripcion, vd.ventas.fecha")
                    .setDate("par1", fechaInicio)
                    .setDate("par2", fechaFin)
                    .setInteger("par3", codFamilia);
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
     * @param fechaInicio
     * @param fechaFin
     * @param codFamilia
     * @param codMarca
     * @return 0:codArticuloProducto, 1:descripcion, 2:codVenta,
     * 3:docSerieNumero, 4:fecha, 5:cliente, 6:codVentaDetalle, 7:cantidad,
     * 8:precioVenta, 9:valorVenta
     */
    public List leer_vendidos_familia_marca_SC(Date fechaInicio, Date fechaFin,
            int codFamilia, int codMarca) {
        List l = null;
        Transaction trns = null;
        sesion = HibernateUtil.getSessionFactory().openSession();
        try {
            trns = sesion.beginTransaction();
            Query q = sesion.createQuery("select ap.codArticuloProducto"
                    + ", ap.descripcion"
                    + ", vd.ventas.codVentas"
                    + ", vd.ventas.docSerieNumero"
                    + ", vd.ventas.fecha"
                    + ", vd.ventas.cliente"
                    + ", vd.codVentasDetalle"
                    + ", vd.cantidad"
                    + ", vd.precioVenta"
                    + ", vd.valorVenta"
                    + " from ArticuloProducto ap join ap.ventasDetalles vd"
                    + " where substring(vd.registro,1,1) = 1"
                    + " and substring(vd.ventas.registro,1,1) = 1"
                    + " and vd.ventas.fecha between :par1 and :par2"
                    + " and ap.familia = :par3"
                    + " and ap.marca = :par4"
                    + " order by ap.descripcion, vd.ventas.fecha")
                    .setDate("par1", fechaInicio)
                    .setDate("par2", fechaFin)
                    .setInteger("par3", codFamilia)
                    .setInteger("par4", codMarca);
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
     * @param fechaInicio
     * @param fechaFin
     * @param codArticuloProducto
     * @return 0:codArticuloProducto, 1:descripcion, 2:codVenta,
     * 3:docSerieNumero, 4:fecha, 5:cliente, 6:codVentaDetalle, 7:cantidad,
     * 8:precioVenta, 9:valorVenta
     */
    public List leer_vendidos_articuloProducto_SC(Date fechaInicio, Date fechaFin,
            int codArticuloProducto) {
        List l = null;
        Transaction trns = null;
        sesion = HibernateUtil.getSessionFactory().openSession();
        try {
            trns = sesion.beginTransaction();
            Query q = sesion.createQuery("select ap.codArticuloProducto"
                    + ", ap.descripcion"
                    + ", vd.ventas.codVentas"
                    + ", vd.ventas.docSerieNumero"
                    + ", vd.ventas.fecha"
                    + ", vd.ventas.cliente"
                    + ", vd.codVentasDetalle"
                    + ", vd.cantidad"
                    + ", vd.precioVenta"
                    + ", vd.valorVenta"
                    + " from ArticuloProducto ap join ap.ventasDetalles vd"
                    + " where substring(vd.registro,1,1) = 1"
                    + " and substring(vd.ventas.registro,1,1) = 1"
                    + " and vd.ventas.fecha between :par1 and :par2"
                    + " and ap = :par3"
                    + " order by ap.descripcion, vd.ventas.fecha")
                    .setDate("par1", fechaInicio)
                    .setDate("par2", fechaFin)
                    .setInteger("par3", codArticuloProducto);
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
     * @param fechaInicio
     * @param fechaFin
     * @return 0:codArticuloProducto, 1:descripcion, 2:codCompra,
     * 3:docSerieNumero, 4:fechaFactura, 5:proveedor, 6:codCompraDetalle,
     * 7:cantidad, 8:precioUnitario, 9:precioTotal
     */
    public List leer_comprados_SC(Date fechaInicio, Date fechaFin) {
        List l = null;
        Transaction trns = null;
        sesion = HibernateUtil.getSessionFactory().openSession();
        try {
            trns = sesion.beginTransaction();
            Query q = sesion.createQuery("select ap.codArticuloProducto"
                    + ", ap.descripcion"
                    + ", cd.compra.codCompra"
                    + ", cd.compra.docSerieNumero"
                    + ", cd.compra.fechaFactura"
                    + ", cd.compra.proveedor.razonSocial"
                    + ", cd.codCompraDetalle"
                    + ", cd.cantidad"
                    + ", cd.precioUnitario"
                    + ", cd.precioTotal"
                    + " from ArticuloProducto ap join ap.compraDetalles cd"
                    + " where substring(cd.registro,1,1) = 1"
                    + " and substring(cd.compra.registro,1,1) = 1"
                    + " and cd.compra.fechaFactura between :par1 and :par2"
                    + " order by ap.descripcion, cd.compra.fechaFactura")
                    .setDate("par1", fechaInicio)
                    .setDate("par2", fechaFin);
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
     * @param fechaInicio
     * @param fechaFin
     * @param codFamilia
     * @return 0:codArticuloProducto, 1:descripcion, 2:codCompra,
     * 3:docSerieNumero, 4:fechaFactura, 5:proveedor, 6:codCompraDetalle,
     * 7:cantidad, 8:precioUnitario, 9:precioTotal
     */
    public List leer_comprados_familia_SC(Date fechaInicio, Date fechaFin,
            int codFamilia) {
        List l = null;
        Transaction trns = null;
        sesion = HibernateUtil.getSessionFactory().openSession();
        try {
            trns = sesion.beginTransaction();
            Query q = sesion.createQuery("select ap.codArticuloProducto"
                    + ", ap.descripcion"
                    + ", cd.compra.codCompra"
                    + ", cd.compra.docSerieNumero"
                    + ", cd.compra.fechaFactura"
                    + ", cd.compra.proveedor.razonSocial"
                    + ", cd.codCompraDetalle"
                    + ", cd.cantidad"
                    + ", cd.precioUnitario"
                    + ", cd.precioTotal"
                    + " from ArticuloProducto ap join ap.compraDetalles cd"
                    + " where substring(cd.registro,1,1) = 1"
                    + " and substring(cd.compra.registro,1,1) = 1"
                    + " and cd.compra.fechaFactura between :par1 and :par2"
                    + " and ap.familia = :par3"
                    + " order by ap.descripcion, cd.compra.fechaFactura")
                    .setDate("par1", fechaInicio)
                    .setDate("par2", fechaFin)
                    .setInteger("par3", codFamilia);
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
     * @param fechaInicio
     * @param fechaFin
     * @param codFamilia
     * @param codMarca
     * @return 0:codArticuloProducto, 1:descripcion, 2:codCompra,
     * 3:docSerieNumero, 4:fechaFactura, 5:proveedor, 6:codCompraDetalle,
     * 7:cantidad, 8:precioUnitario, 9:precioTotal
     */
    public List leer_comprados_familia_marca_SC(Date fechaInicio, Date fechaFin,
            int codFamilia, int codMarca) {
        List l = null;
        Transaction trns = null;
        sesion = HibernateUtil.getSessionFactory().openSession();
        try {
            trns = sesion.beginTransaction();
            Query q = sesion.createQuery("select ap.codArticuloProducto"
                    + ", ap.descripcion"
                    + ", cd.compra.codCompra"
                    + ", cd.compra.docSerieNumero"
                    + ", cd.compra.fechaFactura"
                    + ", cd.compra.proveedor.razonSocial"
                    + ", cd.codCompraDetalle"
                    + ", cd.cantidad"
                    + ", cd.precioUnitario"
                    + ", cd.precioTotal"
                    + " from ArticuloProducto ap join ap.compraDetalles cd"
                    + " where substring(cd.registro,1,1) = 1"
                    + " and substring(cd.compra.registro,1,1) = 1"
                    + " and cd.compra.fechaFactura between :par1 and :par2"
                    + " and ap.familia = :par3"
                    + " and ap.marca = :par4"
                    + " order by ap.descripcion, cd.compra.fechaFactura")
                    .setDate("par1", fechaInicio)
                    .setDate("par2", fechaFin)
                    .setInteger("par3", codFamilia)
                    .setInteger("par4", codMarca);
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
     * @param fechaInicio
     * @param fechaFin
     * @param codArticuloProducto
     * @return 0:codArticuloProducto, 1:descripcion, 2:codCompra,
     * 3:docSerieNumero, 4:fechaFactura, 5:proveedor, 6:codCompraDetalle,
     * 7:cantidad, 8:precioUnitario, 9:precioTotal
     */
    public List leer_comprados_articuloProducto_SC(Date fechaInicio, Date fechaFin, int codArticuloProducto) {
        List l = null;
        Transaction trns = null;
        sesion = HibernateUtil.getSessionFactory().openSession();
        try {
            trns = sesion.beginTransaction();
            Query q = sesion.createQuery("select ap.codArticuloProducto"
                    + ", ap.descripcion"
                    + ", cd.compra.codCompra"
                    + ", cd.compra.docSerieNumero"
                    + ", cd.compra.fechaFactura"
                    + ", cd.compra.proveedor.razonSocial"
                    + ", cd.codCompraDetalle"
                    + ", cd.cantidad"
                    + ", cd.precioUnitario"
                    + ", cd.precioTotal"
                    + " from ArticuloProducto ap join ap.compraDetalles cd"
                    + " where substring(cd.registro,1,1) = 1"
                    + " and substring(cd.compra.registro,1,1) = 1"
                    + " and cd.compra.fechaFactura between :par1 and :par2"
                    + " and ap = :par3"
                    + " order by ap.descripcion, cd.compra.fechaFactura")
                    .setDate("par1", fechaInicio)
                    .setDate("par2", fechaFin)
                    .setInteger("par3", codArticuloProducto);
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
        cOtros objcOtros = new cOtros();
        setError(null);
        sesion = HibernateUtil.getSessionFactory().openSession();
        sesion.getTransaction().begin();
        ArticuloProducto obj = (ArticuloProducto) sesion.get(ArticuloProducto.class, codArticuloProducto);
        obj.setRegistro(objcOtros.registro(estado, user));
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

    public boolean actualizar_precioCash(int codArticuloProducto, Double precioCash) {
        Boolean est = false;
        Transaction trns = null;
        sesion = HibernateUtil.getSessionFactory().openSession();
        try {
            trns = sesion.beginTransaction();
            ArticuloProducto obj = (ArticuloProducto) sesion.get(ArticuloProducto.class, codArticuloProducto);
            obj.setPrecioCash(precioCash);
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
