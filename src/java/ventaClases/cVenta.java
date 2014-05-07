/*
 * To change this template, choose Tools | Templates
 * and open the template in the editor.
 */
package ventaClases;

import java.util.Date;
import java.util.List;
import org.hibernate.Query;
import org.hibernate.Session;
import org.hibernate.Transaction;
import tablas.HibernateUtil;
import tablas.Ventas;
import utilitarios.cOtros;

/**
 *
 * @author Henrri***
 */
public class cVenta {

    Session sesion = null;
    public String error;

    public String getError() {
        return error;
    }

    public void setError(String error) {
        this.error = error;
    }

    public cVenta() {
        this.sesion = HibernateUtil.getSessionFactory().getCurrentSession();
        this.error = null;
    }

    public Ventas leer_cod(int codVenta) {
        sesion = HibernateUtil.getSessionFactory().openSession();
        return (Ventas) sesion.get(Ventas.class, codVenta);
    }

    public Ventas leer_primero() {
        try {
            sesion = HibernateUtil.getSessionFactory().openSession();
            Query q = sesion.createQuery("from Ventas v "
                    + "where (substring(v.registro,1,1)=1 or substring(v.registro,1,1)=0) "
                    + "order by v.codVentas asc").
                    setMaxResults(1);
            return (Ventas) q.list().iterator().next();
        } catch (Exception e) {
            setError(e.getMessage());
        }
        return null;
    }

    public Ventas leer_ultimo() {
        try {
            sesion = HibernateUtil.getSessionFactory().openSession();
            Query q = sesion.createQuery("from Ventas v "
                    + "where (substring(v.registro,1,1)=1 or substring(v.registro,1,1)=0) "
                    + "order by v.codVentas desc").
                    setMaxResults(1);
            return (Ventas) q.list().iterator().next();
        } catch (Exception e) {
            setError(e.getMessage());
        }
        return null;
    }

    public List leer_ventaResumen_codPersona(int codPersona) {
        setError(null);
        try {
            sesion = HibernateUtil.getSessionFactory().openSession();
            Query q = sesion.createQuery("select v.codVentas, v.fecha,v.tipo, "
                    + "v.docSerieNumero, "
                    + "v.neto,(select p.nombresC from Persona p where p.codPersona=v.personaCodVendedor), "
                    + "v.registro "
                    + "from Ventas v "
                    + "where v.persona.codPersona=:codPersona "
                    + "and (substring(v.registro,1,1)=0 or substring(v.registro,1,1)=1) "
                    + "order by v.fecha desc,v.docSerieNumero desc").
                    setParameter("codPersona", codPersona)
                    .setMaxResults(10);
            return (List) q.list();
        } catch (Exception e) {
            setError(e.getMessage());
        }
        return null;
    }

    //<editor-fold defaultstate="collapsed" desc="Metódos corregidos *correcto*. Clic en el signo + de la izquierda para mas detalles.">
    /**
     *
     * @param objVentas
     * @return
     */
    public int crear(Ventas objVentas) {
        int cod = 0;
        Transaction trns = null;
        sesion = HibernateUtil.getSessionFactory().openSession();
        try {
            trns = sesion.beginTransaction();
            cod = (Integer) sesion.save(objVentas);
            sesion.getTransaction().commit();
        } catch (Exception e) {
            if (trns != null) {
                trns.rollback();
            }
            setError(e.getMessage());
        } finally {
            sesion.flush();
            sesion.close();
        }
        return cod;
    }

    /**
     *
     * @return
     */
    public List leer() {
        setError(null);
        try {
            sesion = HibernateUtil.getSessionFactory().openSession();
            Query q = sesion.createQuery("from Ventas v where (substring(registro,1,1)=0 or substring(registro,1,1)=1) order by docSerieNumero");
            return (List) q.list();
        } catch (Exception e) {
            setError(e.getMessage());
        }
        return null;
    }

    /**
     * 0:codCliente, 1:nombresC, 2:codVenta, 3:docSerieNumero, 4:fecha, 5:tipo,
     * 6:neto, 7:registro, 8:precioReal, 9:montoInicial, 10:cantidadLetras
     *
     * @param fechaInicio
     * @param fechaFin
     * @return
     */
    public List leer_todos_fechas_SC(Date fechaInicio, Date fechaFin) {
        List l = null;
        Transaction trns = null;
        sesion = HibernateUtil.getSessionFactory().openSession();
        try {
            trns = sesion.beginTransaction();
            Query q = sesion.createQuery("select"
                    + " dc.codDatosCliente, "
                    + " dc.persona.nombresC,"
                    + "	v.codVentas,"
                    + " v.docSerieNumero,"
                    + " v.fecha,"
                    + " v.tipo,"
                    + "	v.neto,"
                    + " v.registro,"
                    + " (select sum( CASE WHEN vd.precioReal>vd.precioVenta THEN (vd.precioVenta*vd.cantidad) ELSE (vd.precioReal*vd.cantidad) END ) from VentasDetalle vd where vd.ventas = v and substring(vd.registro,1,1) = 1 and substring(vd.ventas.registro,1,1) = 1 ),"
                    + "	(select sum(vc.montoInicial) from VentaCredito vc where vc.ventas = v and substring(vc.registro,1,1) = 1),"
                    + "	(select sum(vc.cantidadLetras) from VentaCredito vc where vc.ventas = v and substring(vc.registro,1,1) = 1),"
                    + " (select sum(vd2.precioProforma * vd2.cantidad) from VentasDetalle vd2 where vd2.ventas = v and substring(vd2.registro,1,1) = 1 and substring(vd2.ventas.registro,1,1) = 1 )"
                    + " from Ventas v, DatosCliente dc"
                    + " where v.persona = dc.persona"
                    + "	and (substring(v.registro,1,1) = 0 or substring(v.registro,1,1) = 1)"
                    + "	and v.fecha between :par1 and :par2"
                    + " order by v.fecha, v.docSerieNumero")
                    .setDate("par1", fechaInicio)
                    .setDate("par2", fechaFin);
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
     * 0:codCliente, 1:nombresC, 2:codVenta, 3:docSerieNumero, 4:fecha, 5:tipo,
     * 6:neto, 7:registro, 8:precioReal, 9:montoInicial, 10:cantidadLetras
     *
     * @param fechaInicio
     * @param fechaFin
     * @return
     */
    public List leer_contado_fechas_SC(Date fechaInicio, Date fechaFin) {
        List l = null;
        Transaction trns = null;
        sesion = HibernateUtil.getSessionFactory().openSession();
        try {
            trns = sesion.beginTransaction();
            Query q = sesion.createQuery("select"
                    + " dc.codDatosCliente, "
                    + " dc.persona.nombresC,"
                    + "	v.codVentas,"
                    + " v.docSerieNumero,"
                    + " v.fecha,"
                    + " v.tipo,"
                    + "	v.neto,"
                    + " v.registro,"
                    + " (select sum( CASE WHEN vd.precioReal>vd.precioVenta THEN (vd.precioVenta*vd.cantidad) ELSE (vd.precioReal*vd.cantidad) END ) from VentasDetalle vd where vd.ventas = v and substring(vd.registro,1,1) = 1 and substring(vd.ventas.registro,1,1) = 1 ),"
                    + "	(select sum(vc.montoInicial) from VentaCredito vc where vc.ventas = v and substring(vc.registro,1,1) = 1),"
                    + "	(select sum(vc.cantidadLetras) from VentaCredito vc where vc.ventas = v and substring(vc.registro,1,1) = 1),"
                    + " (select sum(vd2.precioProforma * vd2.cantidad) from VentasDetalle vd2 where vd2.ventas = v and substring(vd2.registro,1,1) = 1 and substring(vd2.ventas.registro,1,1) = 1 )"
                    + " from Ventas v, DatosCliente dc"
                    + " where v.persona = dc.persona"
                    + "	and (substring(v.registro,1,1) = 0 or substring(v.registro,1,1) = 1)"
                    + "	and v.fecha between :par1 and :par2"
                    + " and v.tipo = 'contado'"
                    + " order by v.fecha, v.docSerieNumero")
                    .setDate("par1", fechaInicio)
                    .setDate("par2", fechaFin);
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
     * 0:codCliente, 1:nombresC, 2:codVenta, 3:docSerieNumero, 4:fecha, 5:tipo,
     * 6:neto, 7:registro, 8:precioReal, 9:montoInicial, 10:cantidadLetras
     *
     * @param fechaInicio
     * @param fechaFin
     * @return
     */
    public List leer_credito_fechas_SC(Date fechaInicio, Date fechaFin) {
        List l = null;
        Transaction trns = null;
        sesion = HibernateUtil.getSessionFactory().openSession();
        try {
            trns = sesion.beginTransaction();
            Query q = sesion.createQuery("select"
                    + " dc.codDatosCliente, "
                    + " dc.persona.nombresC,"
                    + "	v.codVentas,"
                    + " v.docSerieNumero,"
                    + " v.fecha,"
                    + " v.tipo,"
                    + "	v.neto,"
                    + " v.registro,"
                    + " (select sum( CASE WHEN vd.precioReal>vd.precioVenta THEN (vd.precioVenta*vd.cantidad) ELSE (vd.precioReal*vd.cantidad) END ) from VentasDetalle vd where vd.ventas = v and substring(vd.registro,1,1) = 1 and substring(vd.ventas.registro,1,1) = 1 ),"
                    + "	(select sum(vc.montoInicial) from VentaCredito vc where vc.ventas = v and substring(vc.registro,1,1) = 1),"
                    + "	(select sum(vc.cantidadLetras) from VentaCredito vc where vc.ventas = v and substring(vc.registro,1,1) = 1),"
                    + " (select sum(vd2.precioProforma * vd2.cantidad) from VentasDetalle vd2 where vd2.ventas = v and substring(vd2.registro,1,1) = 1 and substring(vd2.ventas.registro,1,1) = 1 )"
                    + " from Ventas v, DatosCliente dc"
                    + " where v.persona = dc.persona"
                    + "	and (substring(v.registro,1,1) = 0 or substring(v.registro,1,1) = 1)"
                    + "	and v.fecha between :par1 and :par2"
                    + " and v.tipo = 'credito'"
                    + " order by v.fecha, v.docSerieNumero")
                    .setDate("par1", fechaInicio)
                    .setDate("par2", fechaFin);
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
     * 0:codCliente, 1:nombresC, 2:codVenta, 3:docSerieNumero, 4:fecha, 5:tipo,
     * 6:neto, 7:registro, 8:precioReal, 9:montoInicial, 10:cantidadLetras
     *
     * @param fechaInicio
     * @param fechaFin
     * @param tipo_serie
     * @return
     */
    public List leer_documento_todos_fechas_SC(Date fechaInicio, Date fechaFin, String tipo_serie) {
        List l = null;
        Transaction trns = null;
        sesion = HibernateUtil.getSessionFactory().openSession();
        try {
            trns = sesion.beginTransaction();
            Query q = sesion.createQuery("select"
                    + " dc.codDatosCliente, "
                    + " dc.persona.nombresC,"
                    + "	v.codVentas,"
                    + " v.docSerieNumero,"
                    + " v.fecha,"
                    + " v.tipo,"
                    + "	v.neto,"
                    + " v.registro,"
                    + " (select sum( CASE WHEN vd.precioReal>vd.precioVenta THEN (vd.precioVenta*vd.cantidad) ELSE (vd.precioReal*vd.cantidad) END ) from VentasDetalle vd where vd.ventas = v and substring(vd.registro,1,1) = 1 and substring(vd.ventas.registro,1,1) = 1 ),"
                    + "	(select sum(vc.montoInicial) from VentaCredito vc where vc.ventas = v and substring(vc.registro,1,1) = 1),"
                    + "	(select sum(vc.cantidadLetras) from VentaCredito vc where vc.ventas = v and substring(vc.registro,1,1) = 1),"
                    + " (select sum(vd2.precioProforma * vd2.cantidad) from VentasDetalle vd2 where vd2.ventas = v and substring(vd2.registro,1,1) = 1 and substring(vd2.ventas.registro,1,1) = 1 )"
                    + " from Ventas v, DatosCliente dc"
                    + " where v.persona = dc.persona"
                    + "	and (substring(v.registro,1,1) = 0 or substring(v.registro,1,1) = 1)"
                    + "	and v.fecha between :par1 and :par2"
                    + " and substring(v.docSerieNumero,1,5) = :par3 "
                    + " order by v.fecha, v.docSerieNumero")
                    .setDate("par1", fechaInicio)
                    .setDate("par2", fechaFin)
                    .setString("par3", tipo_serie);
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
     * 0:codCliente, 1:nombresC, 2:codVenta, 3:docSerieNumero, 4:fecha, 5:tipo,
     * 6:neto, 7:registro, 8:precioReal, 9:montoInicial, 10:cantidadLetras
     *
     * @param fechaInicio
     * @param fechaFin
     * @param tipo_serie
     * @return
     */
    public List leer_documento_contado_fechas_SC(Date fechaInicio, Date fechaFin, String tipo_serie) {
        List l = null;
        Transaction trns = null;
        sesion = HibernateUtil.getSessionFactory().openSession();
        try {
            trns = sesion.beginTransaction();
            Query q = sesion.createQuery("select"
                    + " dc.codDatosCliente, "
                    + " dc.persona.nombresC,"
                    + "	v.codVentas,"
                    + " v.docSerieNumero,"
                    + " v.fecha,"
                    + " v.tipo,"
                    + "	v.neto,"
                    + " v.registro,"
                    + " (select sum( CASE WHEN vd.precioReal>vd.precioVenta THEN (vd.precioVenta*vd.cantidad) ELSE (vd.precioReal*vd.cantidad) END ) from VentasDetalle vd where vd.ventas = v and substring(vd.registro,1,1) = 1 and substring(vd.ventas.registro,1,1) = 1 ),"
                    + "	(select sum(vc.montoInicial) from VentaCredito vc where vc.ventas = v and substring(vc.registro,1,1) = 1),"
                    + "	(select sum(vc.cantidadLetras) from VentaCredito vc where vc.ventas = v and substring(vc.registro,1,1) = 1),"
                    + " (select sum(vd2.precioProforma * vd2.cantidad) from VentasDetalle vd2 where vd2.ventas = v and substring(vd2.registro,1,1) = 1 and substring(vd2.ventas.registro,1,1) = 1 )"
                    + " from Ventas v, DatosCliente dc"
                    + " where v.persona = dc.persona"
                    + "	and (substring(v.registro,1,1) = 0 or substring(v.registro,1,1) = 1)"
                    + "	and v.fecha between :par1 and :par2"
                    + " and v.tipo = 'contado'"
                    + " and substring(v.docSerieNumero,1,5) = :par3 "
                    + " order by v.fecha, v.docSerieNumero")
                    .setDate("par1", fechaInicio)
                    .setDate("par2", fechaFin)
                    .setString("par3", tipo_serie);
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
     * 0:codCliente, 1:nombresC, 2:codVenta, 3:docSerieNumero, 4:fecha, 5:tipo,
     * 6:neto, 7:registro, 8:precioReal, 9:montoInicial, 10:cantidadLetras
     *
     * @param fechaInicio
     * @param fechaFin
     * @param tipo_serie
     * @return
     */
    public List leer_documento_credito_fechas_SC(Date fechaInicio, Date fechaFin, String tipo_serie) {
        List l = null;
        Transaction trns = null;
        sesion = HibernateUtil.getSessionFactory().openSession();
        try {
            trns = sesion.beginTransaction();
            Query q = sesion.createQuery("select"
                    + " dc.codDatosCliente, "
                    + " dc.persona.nombresC,"
                    + "	v.codVentas,"
                    + " v.docSerieNumero,"
                    + " v.fecha,"
                    + " v.tipo,"
                    + "	v.neto,"
                    + " v.registro,"
                    + " (select sum( CASE WHEN vd.precioReal>vd.precioVenta THEN (vd.precioVenta*vd.cantidad) ELSE (vd.precioReal*vd.cantidad) END ) from VentasDetalle vd where vd.ventas = v and substring(vd.registro,1,1) = 1 and substring(vd.ventas.registro,1,1) = 1 ),"
                    + "	(select sum(vc.montoInicial) from VentaCredito vc where vc.ventas = v and substring(vc.registro,1,1) = 1),"
                    + "	(select sum(vc.cantidadLetras) from VentaCredito vc where vc.ventas = v and substring(vc.registro,1,1) = 1),"
                    + " (select sum(vd2.precioProforma * vd2.cantidad) from VentasDetalle vd2 where vd2.ventas = v and substring(vd2.registro,1,1) = 1 and substring(vd2.ventas.registro,1,1) = 1 )"
                    + " from Ventas v, DatosCliente dc"
                    + " where v.persona = dc.persona"
                    + "	and (substring(v.registro,1,1) = 0 or substring(v.registro,1,1) = 1)"
                    + "	and v.fecha between :par1 and :par2"
                    + " and v.tipo = 'credito'"
                    + " and substring(v.docSerieNumero,1,5) = :par3 "
                    + " order by v.fecha, v.docSerieNumero")
                    .setDate("par1", fechaInicio)
                    .setDate("par2", fechaFin)
                    .setString("par3", tipo_serie);
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
     * 0:codCliente, 1:nombresC, 2:codVenta, 3:docSerieNumero, 4:fecha, 5:tipo,
     * 6:neto, 7:registro, 8:precioReal, 9:montoInicial, 10:cantidadLetras
     *
     * @param fechaInicio
     * @param fechaFin
     * @param codVendedor
     * @return
     */
    public List leer_todos_vendedor_fechas_SC(Date fechaInicio, Date fechaFin, int codVendedor) {
        List l = null;
        Transaction trns = null;
        sesion = HibernateUtil.getSessionFactory().openSession();
        try {
            trns = sesion.beginTransaction();
            Query q = sesion.createQuery("select"
                    + " dc.codDatosCliente, "
                    + " dc.persona.nombresC,"
                    + "	v.codVentas,"
                    + " v.docSerieNumero,"
                    + " v.fecha,"
                    + " v.tipo,"
                    + "	v.neto,"
                    + " v.registro,"
                    + " (select sum( CASE WHEN vd.precioReal>vd.precioVenta THEN (vd.precioVenta*vd.cantidad) ELSE (vd.precioReal*vd.cantidad) END ) from VentasDetalle vd where vd.ventas = v and substring(vd.registro,1,1) = 1 and substring(vd.ventas.registro,1,1) = 1 ),"
                    + "	(select sum(vc.montoInicial) from VentaCredito vc where vc.ventas = v and substring(vc.registro,1,1) = 1),"
                    + "	(select sum(vc.cantidadLetras) from VentaCredito vc where vc.ventas = v and substring(vc.registro,1,1) = 1),"
                    + " (select sum(vd2.precioProforma * vd2.cantidad) from VentasDetalle vd2 where vd2.ventas = v and substring(vd2.registro,1,1) = 1 and substring(vd2.ventas.registro,1,1) = 1 )"
                    + " from Ventas v, DatosCliente dc"
                    + " where v.persona = dc.persona"
                    + "	and (substring(v.registro,1,1) = 0 or substring(v.registro,1,1) = 1)"
                    + "	and v.fecha between :par1 and :par2"
                    + " and v.personaCodVendedor = :par3"
                    + " order by v.fecha, v.docSerieNumero")
                    .setDate("par1", fechaInicio)
                    .setDate("par2", fechaFin)
                    .setInteger("par3", codVendedor);
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
     * 0:codCliente, 1:nombresC, 2:codVenta, 3:docSerieNumero, 4:fecha, 5:tipo,
     * 6:neto, 7:registro, 8:precioReal, 9:montoInicial, 10:cantidadLetras
     *
     * @param fechaInicio
     * @param fechaFin
     * @param codVendedor
     * @return
     */
    public List leer_contado_vendedor_fechas_SC(Date fechaInicio, Date fechaFin, int codVendedor) {
        List l = null;
        Transaction trns = null;
        sesion = HibernateUtil.getSessionFactory().openSession();
        try {
            trns = sesion.beginTransaction();
            Query q = sesion.createQuery("select"
                    + " dc.codDatosCliente, "
                    + " dc.persona.nombresC,"
                    + "	v.codVentas,"
                    + " v.docSerieNumero,"
                    + " v.fecha,"
                    + " v.tipo,"
                    + "	v.neto,"
                    + " v.registro,"
                    + " (select sum( CASE WHEN vd.precioReal>vd.precioVenta THEN (vd.precioVenta*vd.cantidad) ELSE (vd.precioReal*vd.cantidad) END ) from VentasDetalle vd where vd.ventas = v and substring(vd.registro,1,1) = 1 and substring(vd.ventas.registro,1,1) = 1 ),"
                    + "	(select sum(vc.montoInicial) from VentaCredito vc where vc.ventas = v and substring(vc.registro,1,1) = 1),"
                    + "	(select sum(vc.cantidadLetras) from VentaCredito vc where vc.ventas = v and substring(vc.registro,1,1) = 1),"
                    + " (select sum(vd2.precioProforma * vd2.cantidad) from VentasDetalle vd2 where vd2.ventas = v and substring(vd2.registro,1,1) = 1 and substring(vd2.ventas.registro,1,1) = 1 )"
                    + " from Ventas v, DatosCliente dc"
                    + " where v.persona = dc.persona"
                    + "	and (substring(v.registro,1,1) = 0 or substring(v.registro,1,1) = 1)"
                    + "	and v.fecha between :par1 and :par2"
                    + " and v.tipo = 'contado'"
                    + " and v.personaCodVendedor = :par3"
                    + " order by v.fecha, v.docSerieNumero")
                    .setDate("par1", fechaInicio)
                    .setDate("par2", fechaFin)
                    .setInteger("par3", codVendedor);
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
     * 0:codCliente, 1:nombresC, 2:codVenta, 3:docSerieNumero, 4:fecha, 5:tipo,
     * 6:neto, 7:registro, 8:precioReal, 9:montoInicial, 10:cantidadLetras
     *
     * @param fechaInicio
     * @param fechaFin
     * @param codVendedor
     * @return
     */
    public List leer_credito_vendedor_fechas_SC(Date fechaInicio, Date fechaFin, int codVendedor) {
        List l = null;
        Transaction trns = null;
        sesion = HibernateUtil.getSessionFactory().openSession();
        try {
            trns = sesion.beginTransaction();
            Query q = sesion.createQuery("select"
                    + " dc.codDatosCliente, "
                    + " dc.persona.nombresC,"
                    + "	v.codVentas,"
                    + " v.docSerieNumero,"
                    + " v.fecha,"
                    + " v.tipo,"
                    + "	v.neto,"
                    + " v.registro,"
                    + " (select sum( CASE WHEN vd.precioReal>vd.precioVenta THEN (vd.precioVenta*vd.cantidad) ELSE (vd.precioReal*vd.cantidad) END ) from VentasDetalle vd where vd.ventas = v and substring(vd.registro,1,1) = 1 and substring(vd.ventas.registro,1,1) = 1 ),"
                    + "	(select sum(vc.montoInicial) from VentaCredito vc where vc.ventas = v and substring(vc.registro,1,1) = 1),"
                    + "	(select sum(vc.cantidadLetras) from VentaCredito vc where vc.ventas = v and substring(vc.registro,1,1) = 1),"
                    + " (select sum(vd2.precioProforma * vd2.cantidad) from VentasDetalle vd2 where vd2.ventas = v and substring(vd2.registro,1,1) = 1 and substring(vd2.ventas.registro,1,1) = 1 )"
                    + " from Ventas v, DatosCliente dc"
                    + " where v.persona = dc.persona"
                    + "	and (substring(v.registro,1,1) = 0 or substring(v.registro,1,1) = 1)"
                    + "	and v.fecha between :par1 and :par2"
                    + " and v.tipo = 'credito'"
                    + " and v.personaCodVendedor = :par3"
                    + " order by v.fecha, v.docSerieNumero")
                    .setDate("par1", fechaInicio)
                    .setDate("par2", fechaFin)
                    .setInteger("par3", codVendedor);
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
     * 0:codCliente, 1:nombresC, 2:codVenta, 3:docSerieNumero, 4:fecha, 5:tipo,
     * 6:neto, 7:registro, 8:precioReal, 9:montoInicial, 10:cantidadLetras
     *
     * @param fechaInicio
     * @param fechaFin
     * @return
     */
    public List leer_todos_anulado_fechas_SC(Date fechaInicio, Date fechaFin) {
        List l = null;
        Transaction trns = null;
        sesion = HibernateUtil.getSessionFactory().openSession();
        try {
            trns = sesion.beginTransaction();
            Query q = sesion.createQuery("select"
                    + " dc.codDatosCliente, "
                    + " dc.persona.nombresC,"
                    + "	v.codVentas,"
                    + " v.docSerieNumero,"
                    + " v.fecha,"
                    + " v.tipo,"
                    + "	v.neto,"
                    + " v.registro,"
                    + " (select sum( CASE WHEN vd.precioReal>vd.precioVenta THEN (vd.precioVenta*vd.cantidad) ELSE (vd.precioReal*vd.cantidad) END ) from VentasDetalle vd where vd.ventas = v and substring(vd.registro,1,1) = 1 and substring(vd.ventas.registro,1,1) = 1 ),"
                    + "	(select sum(vc.montoInicial) from VentaCredito vc where vc.ventas = v and substring(vc.registro,1,1) = 1),"
                    + "	(select sum(vc.cantidadLetras) from VentaCredito vc where vc.ventas = v and substring(vc.registro,1,1) = 1),"
                    + " (select sum(vd2.precioProforma * vd2.cantidad) from VentasDetalle vd2 where vd2.ventas = v and substring(vd2.registro,1,1) = 1 and substring(vd2.ventas.registro,1,1) = 1 )"
                    + " from Ventas v, DatosCliente dc"
                    + " where v.persona = dc.persona"
                    + "	and substring(v.registro,1,1) = 0"
                    + "	and v.fecha between :par1 and :par2"
                    + " order by v.fecha, v.docSerieNumero")
                    .setDate("par1", fechaInicio)
                    .setDate("par2", fechaFin);
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
     * 0:codCliente, 1:nombresC, 2:codVenta, 3:docSerieNumero, 4:fecha, 5:tipo,
     * 6:neto, 7:registro, 8:precioReal, 9:montoInicial, 10:cantidadLetras
     *
     * @param fechaInicio
     * @param fechaFin
     * @return
     */
    public List leer_contado_anulado_fechas_SC(Date fechaInicio, Date fechaFin) {
        List l = null;
        Transaction trns = null;
        sesion = HibernateUtil.getSessionFactory().openSession();
        try {
            trns = sesion.beginTransaction();
            Query q = sesion.createQuery("select"
                    + " dc.codDatosCliente, "
                    + " dc.persona.nombresC,"
                    + "	v.codVentas,"
                    + " v.docSerieNumero,"
                    + " v.fecha,"
                    + " v.tipo,"
                    + "	v.neto,"
                    + " v.registro,"
                    + " (select sum( CASE WHEN vd.precioReal>vd.precioVenta THEN (vd.precioVenta*vd.cantidad) ELSE (vd.precioReal*vd.cantidad) END ) from VentasDetalle vd where vd.ventas = v and substring(vd.registro,1,1) = 1 and substring(vd.ventas.registro,1,1) = 1 ),"
                    + "	(select sum(vc.montoInicial) from VentaCredito vc where vc.ventas = v and substring(vc.registro,1,1) = 1),"
                    + "	(select sum(vc.cantidadLetras) from VentaCredito vc where vc.ventas = v and substring(vc.registro,1,1) = 1),"
                    + " (select sum(vd2.precioProforma * vd2.cantidad) from VentasDetalle vd2 where vd2.ventas = v and substring(vd2.registro,1,1) = 1 and substring(vd2.ventas.registro,1,1) = 1 )"
                    + " from Ventas v, DatosCliente dc"
                    + " where v.persona = dc.persona"
                    + "	and substring(v.registro,1,1) = 0"
                    + "	and v.fecha between :par1 and :par2"
                    + " and v.tipo = 'contado'"
                    + " order by v.fecha, v.docSerieNumero")
                    .setDate("par1", fechaInicio)
                    .setDate("par2", fechaFin);
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
     * 0:codCliente, 1:nombresC, 2:codVenta, 3:docSerieNumero, 4:fecha, 5:tipo,
     * 6:neto, 7:registro, 8:precioReal, 9:montoInicial, 10:cantidadLetras
     *
     * @param fechaInicio
     * @param fechaFin
     * @return
     */
    public List leer_credito_anulado_fechas_SC(Date fechaInicio, Date fechaFin) {
        List l = null;
        Transaction trns = null;
        sesion = HibernateUtil.getSessionFactory().openSession();
        try {
            trns = sesion.beginTransaction();
            Query q = sesion.createQuery("select"
                    + " dc.codDatosCliente, "
                    + " dc.persona.nombresC,"
                    + "	v.codVentas,"
                    + " v.docSerieNumero,"
                    + " v.fecha,"
                    + " v.tipo,"
                    + "	v.neto,"
                    + " v.registro,"
                    + " (select sum( CASE WHEN vd.precioReal>vd.precioVenta THEN (vd.precioVenta*vd.cantidad) ELSE (vd.precioReal*vd.cantidad) END ) from VentasDetalle vd where vd.ventas = v and substring(vd.registro,1,1) = 1 and substring(vd.ventas.registro,1,1) = 1 ),"
                    + "	(select sum(vc.montoInicial) from VentaCredito vc where vc.ventas = v and substring(vc.registro,1,1) = 1),"
                    + "	(select sum(vc.cantidadLetras) from VentaCredito vc where vc.ventas = v and substring(vc.registro,1,1) = 1),"
                    + " (select sum(vd2.precioProforma * vd2.cantidad) from VentasDetalle vd2 where vd2.ventas = v and substring(vd2.registro,1,1) = 1 and substring(vd2.ventas.registro,1,1) = 1 )"
                    + " from Ventas v, DatosCliente dc"
                    + " where v.persona = dc.persona"
                    + "	and substring(v.registro,1,1) = 0"
                    + "	and v.fecha between :par1 and :par2"
                    + " and v.tipo = 'credito'"
                    + " order by v.fecha, v.docSerieNumero")
                    .setDate("par1", fechaInicio)
                    .setDate("par2", fechaFin);
            l = q.list();
        } catch (Exception e) {
            e.printStackTrace();
        } finally {
            sesion.flush();
            sesion.close();
        }
        return l;
    }
    //</editor-fold>

    //<editor-fold defaultstate="collapsed" desc="Métodos que seran borrados *borrar*. Clic en el signo + de la izquierda para mas detalles.">
    //borrar
    public List leer_fechaInicio_fechaFin(Date fechaInicio, Date fechaFin) {//borrar funcion
        setError(null);
        try {
            sesion = HibernateUtil.getSessionFactory().openSession();
            Query q = sesion.createQuery("from Ventas v "
                    + "where (substring(v.registro,1,1)=0 or substring(v.registro,1,1)=1) "
                    + "and v.fecha>=:fechaInicio "
                    + "and v.fecha<=:fechaFin order by v.fecha,v.docSerieNumero")
                    .setParameter("fechaInicio", fechaInicio)
                    .setParameter("fechaFin", fechaFin);
            return (List) q.list();
        } catch (Exception e) {
            setError(e.getMessage());
        }
        return null;
    }

    //borrar
    public List leer_contado_fechaInicio_fechaFin(Date fechaInicio, Date fechaFin) {//borrar
        setError(null);
        try {
            sesion = HibernateUtil.getSessionFactory().openSession();
            Query q = sesion.createQuery("from Ventas v "
                    + "where (substring(v.registro,1,1)=0 or substring(v.registro,1,1)=1) "
                    + "and v.fecha>=:fechaInicio "
                    + "and v.fecha<=:fechaFin "
                    + "and v.tipo='contado' "
                    + "order by v.fecha,v.docSerieNumero")
                    .setParameter("fechaInicio", fechaInicio)
                    .setParameter("fechaFin", fechaFin);
            return (List) q.list();
        } catch (Exception e) {
            setError(e.getMessage());
        }
        return null;
    }

    //borrar
    public List leer_credito_fechaInicio_fechaFin(Date fechaInicio, Date fechaFin) {//borrar
        setError(null);
        try {
            sesion = HibernateUtil.getSessionFactory().openSession();
            Query q = sesion.createQuery("from Ventas v "
                    + "where (substring(v.registro,1,1)=0 or substring(v.registro,1,1)=1) "
                    + "and v.fecha>=:fechaInicio "
                    + "and v.fecha<=:fechaFin "
                    + "and v.tipo='credito' "
                    + "order by v.fecha,v.docSerieNumero")
                    .setParameter("fechaInicio", fechaInicio)
                    .setParameter("fechaFin", fechaFin);
            return (List) q.list();
        } catch (Exception e) {
            setError(e.getMessage());
        }
        return null;
    }

    //borrar
    public List leer_fechaInicio_fechaFin_serie(Date fechaInicio, Date fechaFin, String serie) {
        setError(null);
        try {
            sesion = HibernateUtil.getSessionFactory().openSession();
            Query q = sesion.createQuery("from Ventas v "
                    + "where (substring(v.registro,1,1)=0 or substring(v.registro,1,1)=1) "
                    + "and v.fecha>=:fechaInicio "
                    + "and v.fecha<=:fechaFin "
                    + "and substring(v.docSerieNumero,1,5)=:docSerieNumero "
                    + "order by v.fecha,v.docSerieNumero")
                    .setParameter("fechaInicio", fechaInicio)
                    .setParameter("fechaFin", fechaFin)
                    .setParameter("docSerieNumero", serie);
            return (List) q.list();
        } catch (Exception e) {
            setError(e.getMessage());
        }
        return null;
    }

    //borrar
    public List leer_contado_fechaInicio_fechaFin_serie(Date fechaInicio, Date fechaFin, String serie) {
        setError(null);
        try {
            sesion = HibernateUtil.getSessionFactory().openSession();
            Query q = sesion.createQuery("from Ventas v "
                    + "where (substring(v.registro,1,1)=0 or substring(v.registro,1,1)=1) "
                    + "and v.fecha>=:fechaInicio "
                    + "and v.fecha<=:fechaFin "
                    + "and substring(v.docSerieNumero,1,5)=:docSerieNumero "
                    + "and v.tipo='contado' "
                    + "order by v.fecha,v.docSerieNumero")
                    .setParameter("fechaInicio", fechaInicio)
                    .setParameter("fechaFin", fechaFin)
                    .setParameter("docSerieNumero", serie);
            return (List) q.list();
        } catch (Exception e) {
            setError(e.getMessage());
        }
        return null;
    }

    //borrar
    public List leer_credito_fechaInicio_fechaFin(Date fechaInicio, Date fechaFin, String serie) {
        setError(null);
        try {
            sesion = HibernateUtil.getSessionFactory().openSession();
            Query q = sesion.createQuery("from Ventas v "
                    + "where (substring(v.registro,1,1)=0 or substring(v.registro,1,1)=1) "
                    + "and v.fecha>=:fechaInicio "
                    + "and v.fecha<=:fechaFin "
                    + "and substring(v.docSerieNumero,1,5)=:docSerieNumero "
                    + "and v.tipo='credito' "
                    + "order by v.fecha,v.docSerieNumero")
                    .setParameter("fechaInicio", fechaInicio)
                    .setParameter("fechaFin", fechaFin)
                    .setParameter("docSerieNumero", serie);
            return (List) q.list();
        } catch (Exception e) {
            setError(e.getMessage());
        }
        return null;
    }

    //borrar
    public List leer_fechaInicio_fechaFin_vendedor(Date fechaInicio, Date fechaFin, int codVendedor) {
        setError(null);
        try {
            sesion = HibernateUtil.getSessionFactory().openSession();
            Query q = sesion.createQuery("from Ventas v "
                    + "where (substring(v.registro,1,1)=0 or substring(v.registro,1,1)=1) "
                    + "and v.fecha>=:fechaInicio "
                    + "and v.fecha<=:fechaFin "
                    + "and v.personaCodVendedor=:codVendedor "
                    + "order by v.fecha,v.docSerieNumero")
                    .setParameter("fechaInicio", fechaInicio)
                    .setParameter("fechaFin", fechaFin)
                    .setParameter("codVendedor", codVendedor);
            return (List) q.list();
        } catch (Exception e) {
            setError(e.getMessage());
        }
        return null;
    }

    //borrar
    public List leer_contado_fechaInicio_fechaFin_vendedor(Date fechaInicio, Date fechaFin, int codVendedor) {
        setError(null);
        try {
            sesion = HibernateUtil.getSessionFactory().openSession();
            Query q = sesion.createQuery("from Ventas v "
                    + "where (substring(v.registro,1,1)=0 or substring(v.registro,1,1)=1) "
                    + "and v.fecha>=:fechaInicio "
                    + "and v.fecha<=:fechaFin "
                    + "and v.personaCodVendedor=:codVendedor "
                    + "and v.tipo='contado' "
                    + "order by v.fecha,v.docSerieNumero")
                    .setParameter("fechaInicio", fechaInicio)
                    .setParameter("fechaFin", fechaFin)
                    .setParameter("codVendedor", codVendedor);
            return (List) q.list();
        } catch (Exception e) {
            setError(e.getMessage());
        }
        return null;
    }

    //borrar
    public List leer_credito_fechaInicio_fechaFin_vendedor(Date fechaInicio, Date fechaFin, int codVendedor) {
        setError(null);
        try {
            sesion = HibernateUtil.getSessionFactory().openSession();
            Query q = sesion.createQuery("from Ventas v "
                    + "where (substring(v.registro,1,1)=0 or substring(v.registro,1,1)=1) "
                    + "and v.fecha>=:fechaInicio "
                    + "and v.fecha<=:fechaFin "
                    + "and v.personaCodVendedor=:codVendedor "
                    + "and v.tipo='credito' "
                    + "order by v.fecha,v.docSerieNumero")
                    .setParameter("fechaInicio", fechaInicio)
                    .setParameter("fechaFin", fechaFin)
                    .setParameter("codVendedor", codVendedor);
            return (List) q.list();
        } catch (Exception e) {
            setError(e.getMessage());
        }
        return null;
    }

    //borrar
    public List leer_fechaInicio_fechaFin_anulado(Date fechaInicio, Date fechaFin) {
        setError(null);
        try {
            sesion = HibernateUtil.getSessionFactory().openSession();
            Query q = sesion.createQuery("from Ventas v "
                    + "where substring(v.registro,1,1)=0 "
                    + "and v.fecha>=:fechaInicio "
                    + "and v.fecha<=:fechaFin order by v.fecha,v.docSerieNumero")
                    .setParameter("fechaInicio", fechaInicio)
                    .setParameter("fechaFin", fechaFin);
            return (List) q.list();
        } catch (Exception e) {
            setError(e.getMessage());
        }
        return null;
    }

    //borrar
    public List leer_contado_fechaInicio_fechaFin_anulado(Date fechaInicio, Date fechaFin) {
        setError(null);
        try {
            sesion = HibernateUtil.getSessionFactory().openSession();
            Query q = sesion.createQuery("from Ventas v "
                    + "where substring(v.registro,1,1)=0 "
                    + "and v.fecha>=:fechaInicio "
                    + "and v.fecha<=:fechaFin "
                    + "and v.tipo='contado' "
                    + "order by v.fecha,v.docSerieNumero")
                    .setParameter("fechaInicio", fechaInicio)
                    .setParameter("fechaFin", fechaFin);
            return (List) q.list();
        } catch (Exception e) {
            setError(e.getMessage());
        }
        return null;
    }

    //borrar
    public List leer_credito_fechaInicio_fechaFin_anulado(Date fechaInicio, Date fechaFin) {
        setError(null);
        try {
            sesion = HibernateUtil.getSessionFactory().openSession();
            Query q = sesion.createQuery("from Ventas v "
                    + "where substring(v.registro,1,1)=0 "
                    + "and v.fecha>=:fechaInicio "
                    + "and v.fecha<=:fechaFin "
                    + "and v.tipo='credito' "
                    + "order by v.fecha,v.docSerieNumero")
                    .setParameter("fechaInicio", fechaInicio)
                    .setParameter("fechaFin", fechaFin);
            return (List) q.list();
        } catch (Exception e) {
            setError(e.getMessage());
        }
        return null;
    }

    //</editor-fold>
    public List ventas_credito() {
        setError(null);
        sesion = HibernateUtil.getSessionFactory().openSession();
        try {
            Query q = sesion.createQuery("from Ventas v where (substring(registro,1,1)=0 or substring(registro,1,1)=1) order by docSerieNumero");
            return (List) q.list();
        } catch (Exception e) {
            setError("Ventas: ventas_credito: " + e.getMessage());
        }
        return null;
    }

    /**
     * Retorna un listado con todas los documentos parecidos al parametro
     * enviado, usado en autocompletado.
     *
     * @param docSerieNumero
     * @return
     */
    public List leer_docNumeroSerie_like(String docSerieNumero) {
        setError(null);
        try {
            sesion = HibernateUtil.getSessionFactory().openSession();
            Query q = sesion.createQuery("from Ventas v where (substring(v.registro,1,1)=0 or substring(v.registro,1,1)=1) and v.docSerieNumero like :criterio order by docSerieNumero")
                    //            Query q = sesion.createQuery("from Ventas where substring(registro,1,1)=1 and docSerieNumero like :criterio")
                    .setParameter("criterio", "%" + docSerieNumero + "%");
            return (List) q.list();
        } catch (Exception e) {
            setError(e.getMessage());
        }
        return null;
    }

    /**
     * Leer una venta por el docSerieNumero.
     *
     * @param docSerieNumero
     * @return
     */
    public Ventas leer_docSerieNumero(String docSerieNumero) {
        setError(null);
        try {
            sesion = HibernateUtil.getSessionFactory().openSession();
            Query q = sesion.createQuery("from Ventas where substring(registro,1,1)=1 and docSerieNumero=:criterio")
                    .setParameter("criterio", docSerieNumero);
            return (Ventas) q.list().get(0);
        } catch (Exception e) {
            setError(e.getMessage());
        }
        return null;
    }

    /**
     * Leer una venta por el número de guía asignadoo.
     *
     * @param docSerieNumeroGuia
     * @return objVenta
     */
    public Ventas leer_docSerieNumeroGuia(String docSerieNumeroGuia) {
        Ventas objVenta = null;
        setError(null);
        try {
            sesion = HibernateUtil.getSessionFactory().openSession();
            Query q = sesion.createQuery("from Ventas where substring(registro,1,1)=1 and docSerieNumeroGuia=:a")
                    .setParameter("a", docSerieNumeroGuia);
            objVenta = (Ventas) q.list().get(0);
        } catch (Exception e) {
            setError(e.getMessage());
            e.printStackTrace();
        }
        return objVenta;
    }

    /**
     * Retorna un listado con todas las compras que ha realizado un cliente.
     *
     * @param codPersona
     * @return
     */
    public List leer_codPersona_orderByAsc(int codPersona) {
        setError(null);
        sesion = HibernateUtil.getSessionFactory().openSession();
        try {
            Query q = sesion.createQuery("from Ventas v where (substring(v.registro,1,1)=0 or substring(v.registro,1,1)=1) and v.persona.codPersona=:codPersona order by codVentas asc")
                    .setParameter("codPersona", codPersona);
            return q.list();
        } catch (Exception e) {
            setError(e.getMessage());
        }
        return null;
    }

    /**
     * Retorna el id del ultima venta realizada.
     *
     * @return objeto de tipo Venta
     */
    public int leer_ultimaVenta() {
        setError(null);
        sesion = HibernateUtil.getSessionFactory().openSession();
        try {
            sesion = HibernateUtil.getSessionFactory().openSession();
            Query q = sesion.createQuery("from Ventas v order by v.codVentas desc");
            return ((Ventas) q.list().get(0)).getCodVentas();
        } catch (Exception e) {
            setError(e.getMessage());
        }
        return 0;
    }

    public Ventas leer_ultimaVentaCredito() {
        setError(null);
        sesion = HibernateUtil.getSessionFactory().openSession();
        try {
            sesion = HibernateUtil.getSessionFactory().openSession();
            Query q = sesion.createQuery("from Ventas v "
                    + "where v.tipo='CREDITO' "
                    + "order by v.codVentas desc").
                    setMaxResults(1);
            return (Ventas) q.list().iterator().next();
        } catch (Exception e) {
            setError(e.getMessage());
            return null;
        }
    }

    /**
     *
     * @return codCliente de la última venta al crédito realizada.
     */
    public int leer_codCliente_ultimaVentaCredito_SC() {
        int codCliente = 0;
        Transaction trns = null;
        sesion = HibernateUtil.getSessionFactory().openSession();
        try {
            trns = sesion.beginTransaction();
            Query q = sesion.createQuery("select dc.codDatosCliente"
                    + " from Ventas v join v.persona.datosClientes dc"
                    + " where substring(v.registro,1,1) = 1"
                    + " and v.tipo = 'CREDITO'"
                    + " order by v.fecha desc, v.codVentas desc");
            codCliente = (Integer) q.list().iterator().next();
        } catch (Exception e) {
            e.printStackTrace();
            setError(e.getMessage());
        } finally {
            sesion.flush();
            sesion.close();
        }
        return codCliente;
    }

    public List leer_admin() {
        setError(null);
        try {
            sesion = HibernateUtil.getSessionFactory().openSession();
            Query q = sesion.createQuery("from Ventas");
            return (List) q.list();
        } catch (Exception e) {
            setError(e.getMessage());
        }
        return null;
    }

    public boolean actualizar_registro(int codVentas, String estado, String user) {
        sesion = HibernateUtil.getSessionFactory().openSession();
        sesion.getTransaction().begin();
        Ventas obj = (Ventas) sesion.get(Ventas.class, codVentas);
        obj.setRegistro(new cOtros().registro(estado, user));
        try {
            sesion.update(obj);
            sesion.getTransaction().commit();
            return true;
        } catch (Exception e) {
            sesion.getTransaction().rollback();
            setError("Ventas_actualizar_registro: " + e.getMessage());
        }
        return false;
    }

    public boolean actualizar_nombresC_identifacion_direccion(int codVentas, String nombresC, String identificacion, String direccion) {
        setError(null);
        sesion = HibernateUtil.getSessionFactory().openSession();
        sesion.getTransaction().begin();
        Ventas obj = (Ventas) sesion.get(Ventas.class, codVentas);
        obj.setCliente(nombresC);
        obj.setIdentificacion(identificacion);
        obj.setDireccion(direccion);
        try {
            sesion.update(obj);
            sesion.getTransaction().commit();
            return true;
        } catch (Exception e) {
            sesion.getTransaction().rollback();
            setError("Ventas_actualizar_registro: " + e.getMessage());
        }
        return false;
    }

    public boolean actualizar_tipo(int codVentas, String tipo) {
        setError(null);
        sesion = HibernateUtil.getSessionFactory().openSession();
        sesion.getTransaction().begin();
        Ventas obj = (Ventas) sesion.get(Ventas.class, codVentas);
        obj.setTipo(tipo);
        try {
            sesion.update(obj);
            sesion.getTransaction().commit();
            return true;
        } catch (Exception e) {
            sesion.getTransaction().rollback();
            setError("Ventas_actualizar_tipo: " + e.getMessage());
        }
        return false;
    }

    public boolean actualizar_anularVenta(int codVenta, Double subTotal, Double descuento, Double total, Double montoIgv, Double neto, String son, String registro) {
        setError(null);
        sesion = HibernateUtil.getSessionFactory().openSession();
        sesion.getTransaction().begin();
        Ventas obj = (Ventas) sesion.get(Ventas.class, codVenta);
        obj.setSubTotal(subTotal);
        obj.setDescuento(descuento);
        obj.setTotal(total);
        obj.setValorIgv(montoIgv);
        obj.setNeto(neto);
        obj.setSon(son);
        obj.setRegistro(registro);
        try {
            sesion.update(obj);
            sesion.getTransaction().commit();
            return true;
        } catch (Exception e) {
            sesion.getTransaction().rollback();
            setError("Ventas_actualizar_anularVenta: " + e.getMessage());
        }
        return false;
    }

    /**
     *
     * @param codVenta
     * @param direccion2
     * @param direccion3
     * @param docSerieNumeroGuia
     * @return
     */
    public Boolean actualizar_docSerieNumeroGuia(int codVenta, String direccion2, String direccion3, String docSerieNumeroGuia) {
        Boolean est = false;
        setError(null);
        sesion = HibernateUtil.getSessionFactory().openSession();
        sesion.getTransaction().begin();
        Ventas obj = (Ventas) sesion.get(Ventas.class, codVenta);
        obj.setDireccion2(direccion2);
        obj.setDireccion3(direccion3);
        obj.setDocSerieNumeroGuia(docSerieNumeroGuia);
        try {
            sesion.update(obj);
            sesion.getTransaction().commit();
            est = true;
        } catch (Exception e) {
            sesion.getTransaction().rollback();
            setError("Tabla_actualizar_registro: " + e.getMessage());
            e.printStackTrace();
        }
        return est;
    }
}
