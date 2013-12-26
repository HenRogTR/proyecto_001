/*
 * To change this template, choose Tools | Templates
 * and open the template in the editor.
 */
package ventaClases;

import java.util.Date;
import java.util.List;
import org.hibernate.Query;
import org.hibernate.Transaction;
import org.hibernate.classic.Session;
import otros.cUtilitarios;
import tablas.HibernateUtil;
import tablas.VentaCreditoLetra;

/**
 *
 * @author Henrri
 */
public class cVentaCreditoLetra {

    Session sesion = null;
    public String error;

    public String getError() {
        return error;
    }

    public void setError(String error) {
        this.error = error;
    }

    public cVentaCreditoLetra() {
        this.sesion = HibernateUtil.getSessionFactory().getCurrentSession();
    }

    public int crear(VentaCreditoLetra objVentaCreditoLetra) {
        int cod = 0;
        Transaction trns = null;
        sesion = HibernateUtil.getSessionFactory().openSession();
        try {
            trns = sesion.beginTransaction();
            cod = (Integer) sesion.save(objVentaCreditoLetra);
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

    public List leer() {
        setError(null);
        try {
            sesion = HibernateUtil.getSessionFactory().openSession();
            Query q = sesion.createQuery("from VentaCreditoLetra where substring(registro,1,1)=1");
            return (List) q.list();
        } catch (Exception e) {
            setError(e.getMessage());
        }
        return null;
    }

    /**
     * Se obtinene una lista de todos las letras de credito obtenenidas, de una
     * venta determinada.
     *
     * @param codVenta
     * @return
     */
    public List leer_porCodVenta(int codVenta) {
        setError(null);
        sesion = HibernateUtil.getSessionFactory().openSession();
        try {
            Query q = sesion.createQuery("from VentaCreditoLetra v "
                    + "where v.ventaCredito.ventas.codVentas=:codVentas "
                    + "and substring(v.registro,1,1)=1 "
                    + "order by codVentaCreditoLetra asc")
                    .setParameter("codVentas", codVenta);
            return q.list();
        } catch (Exception e) {
            setError(e.getMessage());
        }
        return null;
    }

    public Object[] leer_resumen(int codPersona) {
        setError(null);
        sesion = HibernateUtil.getSessionFactory().openSession();
        try {
            Query q = sesion.createQuery("select sum(vcl.monto),sum(vcl.totalPago),(sum(vcl.monto)-sum(vcl.totalPago)) "
                    + "from VentaCreditoLetra vcl where substring(vcl.registro,1,1)=1 "
                    + "and vcl.ventaCredito.ventas.persona.codPersona=:codPersona")
                    .setParameter("codPersona", codPersona);
            return (Object[]) q.list().iterator().next();
        } catch (Exception e) {
            setError(e.getMessage());
        }
        return null;
    }

    public VentaCreditoLetra leer_codVentaCreditoLetra(int codVentaCreditoLetra) {
        sesion = HibernateUtil.getSessionFactory().openSession();
        return (VentaCreditoLetra) sesion.get(VentaCreditoLetra.class, codVentaCreditoLetra);
    }

    /**
     * Lista de todas las letras que un cliente tiene.
     *
     * @param codPersona
     * @return
     */
    public List leer_porCodCliente(int codPersona) {
        setError(null);
        sesion = HibernateUtil.getSessionFactory().openSession();
        try {
//            session.beginTransaction();
//            session.flush();
            Query q = sesion.createQuery("from VentaCreditoLetra v "
                    + "where v.ventaCredito.ventas.persona.codPersona=:codPersona "
                    + "and substring(v.registro,1,1)=1 "
                    + "order by codVentaCreditoLetra asc")
                    .setParameter("codPersona", codPersona);
            return q.list();
        } catch (Exception e) {
            setError(e.getMessage());
        }
        return null;
    }

    public List leer_resumenPagos(int codPersona) {
        setError(null);
        sesion = HibernateUtil.getSessionFactory().openSession();
        try {
            Query q = sesion.createQuery("select month(vcl.fechaVencimiento), year(vcl.fechaVencimiento), "
                    + "sum(vcl.monto), sum(interes), sum(vcl.totalPago),sum(vcl.monto)-sum(vcl.totalPago), vcl.fechaVencimiento "
                    + "from VentaCreditoLetra vcl "
                    + "where substring(vcl.registro,1,1)=1 "
                    + "and vcl.ventaCredito.ventas.persona.codPersona=:codPersona "
                    + "group by year(vcl.fechaVencimiento), month(vcl.fechaVencimiento) "
                    + "order by vcl.fechaVencimiento")
                    .setParameter("codPersona", codPersona);
            return q.list();
        } catch (Exception e) {
            setError(e.getMessage());
        }
        return null;
    }

    /**
     * Lista todas las letras que tiene un cliente el cual ya haya vencido,
     * ademas de que el saldo a deber es mayor a <b>0.00</b>.
     *
     * @param codCliente
     * @param fechaVencimiento
     * @return
     */
    public List leer_porCodCliente_letrasVencidas(int codCliente, Date fechaVencimiento) {
        setError(null);
        sesion = HibernateUtil.getSessionFactory().openSession();
        try {
            Query q = sesion.createQuery("from VentaCreditoLetra v "
                    + "where v.ventaCredito.ventas.persona.codPersona=:codPersona "
                    + "and v.fechaVencimiento<=:fechaVencimiento "
                    + "and (v.monto-v.totalPago)>0 "
                    + "and substring(v.registro,1,1)=1 "
                    + "order by codVentaCreditoLetra asc")
                    .setParameter("codPersona", codCliente)
                    .setParameter("fechaVencimiento", fechaVencimiento);
            return q.list();
        } catch (Exception e) {
            setError(e.getMessage());
        }
        return null;
    }

    /**
     * Retorna un array con todas las letras vencidas, ordenadas alfabeticamente
     * por el nombre del cliente.
     *
     * @param fechaVencimiento
     * @return Array.
     */
    public List letrasVencidas_orderByNombresC(Date fechaVencimiento) {
        setError(null);
        sesion = HibernateUtil.getSessionFactory().openSession();
        try {
            Query q = sesion.createQuery("from VentaCreditoLetra vcl "
                    + "where vcl.fechaVencimiento<=:fechaVencimiento "
                    + "and (vcl.monto-vcl.totalPago)>0 "
                    + "and substring(vcl.registro,1,1)=1 "
                    + "order by vcl.ventaCredito.ventas.persona.nombresC asc, vcl.codVentaCreditoLetra")
                    .setParameter("fechaVencimiento", fechaVencimiento);
            return q.list();
        } catch (Exception e) {
            setError(e.getMessage());
        }
        return null;
    }

    public List letrasVencidas_codCobrador_orderByNombresC(Date fechaVencimiento, int codCobrador) {
        setError(null);
        sesion = HibernateUtil.getSessionFactory().openSession();
        try {
            Query q = sesion.createQuery("select vcl from VentaCreditoLetra vcl, DatosCliente dc "
                    + "where vcl.ventaCredito.ventas.persona=dc.persona "
                    + "and dc.codCobrador=:codCobrador "
                    + "and vcl.fechaVencimiento<=:fechaVencimiento "
                    + "and (vcl.monto-vcl.totalPago)>0 "
                    + "and substring(vcl.registro,1,1)=1 "
                    + "order by vcl.ventaCredito.ventas.persona.nombresC asc, vcl.codVentaCreditoLetra")
                    .setParameter("fechaVencimiento", fechaVencimiento)
                    .setParameter("codCobrador", codCobrador);
            return q.list();
        } catch (Exception e) {
            setError(e.getMessage());
        }
        return null;
    }

    public List letrasVencidas_codEmpresaConvenio_orderByNombresC(Date fechaVencimiento, int codEmpresaConvenio) {
        setError(null);
        sesion = HibernateUtil.getSessionFactory().openSession();
        try {
            Query q = sesion.createQuery("select vcl from VentaCreditoLetra vcl, DatosCliente dc "
                    + "where vcl.fechaVencimiento<=:fechaVencimiento "
                    + "and vcl.ventaCredito.ventas.persona=dc.persona "
                    + "and dc.empresaConvenio.codEmpresaConvenio=:codEmpresaConvenio "
                    + "and (vcl.monto-vcl.totalPago)>0 "
                    + "and substring(vcl.registro,1,1)=1 "
                    + "order by vcl.ventaCredito.ventas.persona.nombresC asc, vcl.codVentaCreditoLetra")
                    .setParameter("fechaVencimiento", fechaVencimiento)
                    .setParameter("codEmpresaConvenio", codEmpresaConvenio);
            return q.list();
        } catch (Exception e) {
            setError(e.getMessage());
        }
        return null;
    }

    public List letrasVencidas_codEmpresaConvenio_tipo_orderByNombresC(Date fechaVencimiento, int codEmpresaConvenio, int tipo) {
        setError(null);
        sesion = HibernateUtil.getSessionFactory().openSession();
        try {
            Query q = sesion.createQuery("select vcl from VentaCreditoLetra vcl, DatosCliente dc "
                    + "where vcl.fechaVencimiento<=:fechaVencimiento "
                    + "and vcl.ventaCredito.ventas.persona=dc.persona "
                    + "and dc.empresaConvenio.codEmpresaConvenio=:codEmpresaConvenio "
                    + "and dc.tipo=:tipo "
                    + "and (vcl.monto-vcl.totalPago)>0 "
                    + "and substring(vcl.registro,1,1)=1 "
                    + "order by vcl.ventaCredito.ventas.persona.nombresC asc, vcl.codVentaCreditoLetra")
                    .setParameter("fechaVencimiento", fechaVencimiento)
                    .setParameter("codEmpresaConvenio", codEmpresaConvenio)
                    .setParameter("tipo", tipo);
            return q.list();
        } catch (Exception e) {
            setError(e.getMessage());
        }
        return null;
    }

    public List letrasVencidas_codEmpresaConvenio_tipo_condicion_orderByNombresC(Date fechaVencimiento, int codEmpresaConvenio, int tipo, int condicion) {
        setError(null);
        sesion = HibernateUtil.getSessionFactory().openSession();
        try {
            Query q = sesion.createQuery("select vcl from VentaCreditoLetra vcl, DatosCliente dc "
                    + "where vcl.fechaVencimiento<=:fechaVencimiento "
                    + "and vcl.ventaCredito.ventas.persona=dc.persona "
                    + "and dc.empresaConvenio.codEmpresaConvenio=:codEmpresaConvenio "
                    + "and dc.tipo=:tipo "
                    + "and dc.condicion=:condicion "
                    + "and (vcl.monto-vcl.totalPago)>0 "
                    + "and substring(vcl.registro,1,1)=1 "
                    + "order by vcl.ventaCredito.ventas.persona.nombresC asc, vcl.codVentaCreditoLetra")
                    .setParameter("fechaVencimiento", fechaVencimiento)
                    .setParameter("codEmpresaConvenio", codEmpresaConvenio)
                    .setParameter("tipo", tipo)
                    .setParameter("condicion", condicion);
            return q.list();
        } catch (Exception e) {
            setError(e.getMessage());
        }
        return null;
    }

    public List letrasVencidas_codCobrador_codEmpresaConvenio_orderByNombresC(Date fechaVencimiento, int codEmpresaConvenio, int codCobrador) {
        setError(null);
        sesion = HibernateUtil.getSessionFactory().openSession();
        try {
            Query q = sesion.createQuery("select vcl from VentaCreditoLetra vcl, DatosCliente dc "
                    + "where vcl.fechaVencimiento<=:fechaVencimiento "
                    + "and dc.codCobrador=:codCobrador "
                    + "and vcl.ventaCredito.ventas.persona=dc.persona "
                    + "and dc.empresaConvenio.codEmpresaConvenio=:codEmpresaConvenio "
                    + "and (vcl.monto-vcl.totalPago)>0 "
                    + "and substring(vcl.registro,1,1)=1 "
                    + "order by vcl.ventaCredito.ventas.persona.nombresC asc, vcl.codVentaCreditoLetra")
                    .setParameter("fechaVencimiento", fechaVencimiento)
                    .setParameter("codEmpresaConvenio", codEmpresaConvenio)
                    .setParameter("codCobrador", codCobrador);
            return q.list();
        } catch (Exception e) {
            setError(e.getMessage());
        }
        return null;
    }

    public List letrasVencidas_codEmpresaConvenio_orderByDireccion(Date fechaVencimiento, int codEmpresaConvenio) {
        setError(null);
        sesion = HibernateUtil.getSessionFactory().openSession();
        try {
            Query q = sesion.createQuery("select vcl from VentaCreditoLetra vcl, DatosCliente dc "
                    + "where vcl.fechaVencimiento<=:fechaVencimiento "
                    + "and vcl.ventaCredito.ventas.persona=dc.persona "
                    + "and dc.empresaConvenio.codEmpresaConvenio=:codEmpresaConvenio "
                    + "and (vcl.monto-vcl.totalPago)>0 "
                    + "and substring(vcl.registro,1,1)=1 "
                    + "order by vcl.ventaCredito.ventas.persona.direccion asc, vcl.codVentaCreditoLetra")
                    .setParameter("fechaVencimiento", fechaVencimiento)
                    .setParameter("codEmpresaConvenio", codEmpresaConvenio);
            return q.list();
        } catch (Exception e) {
            setError(e.getMessage());
        }
        return null;
    }

    public List letrasVencidas_codEmpresaConvenio_tipo_orderByDireccion(Date fechaVencimiento, int codEmpresaConvenio, int tipo) {
        setError(null);
        sesion = HibernateUtil.getSessionFactory().openSession();
        try {
            Query q = sesion.createQuery("select vcl from VentaCreditoLetra vcl, DatosCliente dc "
                    + "where vcl.fechaVencimiento<=:fechaVencimiento "
                    + "and vcl.ventaCredito.ventas.persona=dc.persona "
                    + "and dc.empresaConvenio.codEmpresaConvenio=:codEmpresaConvenio "
                    + "and dc.tipo=:tipo "
                    + "and (vcl.monto-vcl.totalPago)>0 "
                    + "and substring(vcl.registro,1,1)=1 "
                    + "order by vcl.ventaCredito.ventas.persona.direccion asc, vcl.codVentaCreditoLetra")
                    .setParameter("fechaVencimiento", fechaVencimiento)
                    .setParameter("codEmpresaConvenio", codEmpresaConvenio)
                    .setParameter("tipo", tipo);
            return q.list();
        } catch (Exception e) {
            setError(e.getMessage());
        }
        return null;
    }

    public List letrasVencidas_codEmpresaConvenio_tipo_condicion_orderByDireccion(Date fechaVencimiento, int codEmpresaConvenio, int tipo, int condicion) {
        setError(null);
        sesion = HibernateUtil.getSessionFactory().openSession();
        try {
            Query q = sesion.createQuery("select vcl from VentaCreditoLetra vcl, DatosCliente dc "
                    + "where vcl.fechaVencimiento<=:fechaVencimiento "
                    + "and vcl.ventaCredito.ventas.persona=dc.persona "
                    + "and dc.empresaConvenio.codEmpresaConvenio=:codEmpresaConvenio "
                    + "and dc.tipo=:tipo "
                    + "and dc.condicion=:condicion "
                    + "and (vcl.monto-vcl.totalPago)>0 "
                    + "and substring(vcl.registro,1,1)=1 "
                    + "order by vcl.ventaCredito.ventas.persona.direccion asc, vcl.codVentaCreditoLetra")
                    .setParameter("fechaVencimiento", fechaVencimiento)
                    .setParameter("codEmpresaConvenio", codEmpresaConvenio)
                    .setParameter("tipo", tipo)
                    .setParameter("condicion", condicion);
            return q.list();
        } catch (Exception e) {
            setError(e.getMessage());
        }
        return null;
    }

    public List letrasVencidas_codCobrador_codEmpresaConvenio_orderByDireccion(Date fechaVencimiento, int codEmpresaConvenio, int codCobrador) {
        setError(null);
        sesion = HibernateUtil.getSessionFactory().openSession();
        try {
            Query q = sesion.createQuery("select vcl from VentaCreditoLetra vcl, DatosCliente dc "
                    + "where vcl.fechaVencimiento<=:fechaVencimiento "
                    + "and vcl.ventaCredito.ventas.persona=dc.persona "
                    + "and dc.codCobrador=:codCobrador "
                    + "and dc.empresaConvenio.codEmpresaConvenio=:codEmpresaConvenio "
                    + "and (vcl.monto-vcl.totalPago)>0 "
                    + "and substring(vcl.registro,1,1)=1 "
                    + "order by vcl.ventaCredito.ventas.persona.direccion asc, vcl.codVentaCreditoLetra")
                    .setParameter("fechaVencimiento", fechaVencimiento)
                    .setParameter("codEmpresaConvenio", codEmpresaConvenio)
                    .setParameter("codCobrador", codCobrador);
            return q.list();
        } catch (Exception e) {
            setError(e.getMessage());
        }
        return null;
    }

    /**
     * Retorna todas las letras existentes, en la cual hay una deuda mayor a
     * 0.00, ordenado por nombres.
     *
     * @return
     */
    public List letras_orderByNombresC() {
        setError(null);
        sesion = HibernateUtil.getSessionFactory().openSession();
        try {
            Query q = sesion.createQuery("from VentaCreditoLetra vcl "
                    + "where (vcl.monto-vcl.totalPago)>0 "
                    + "and substring(vcl.registro,1,1)=1 "
                    + "order by vcl.ventaCredito.ventas.persona.nombresC asc, vcl.codVentaCreditoLetra");
            return q.list();
        } catch (Exception e) {
            setError(e.getMessage());
        }
        return null;
    }

    public List letras_codCobrador_orderByNombresC(int codCobrador) {
        setError(null);
        sesion = HibernateUtil.getSessionFactory().openSession();
        try {
            Query q = sesion.createQuery("select vcl from VentaCreditoLetra vcl, DatosCliente dc "
                    + "where vcl.ventaCredito.ventas.persona=dc.persona "
                    + "and dc.codCobrador=:codCobrador "
                    + "and (vcl.monto-vcl.totalPago)>0 "
                    + "and substring(vcl.registro,1,1)=1 "
                    + "order by vcl.ventaCredito.ventas.persona.nombresC asc, vcl.codVentaCreditoLetra")
                    .setParameter("codCobrador", codCobrador);
            return q.list();
        } catch (Exception e) {
            setError(e.getMessage());
        }
        return null;
    }

    public List letras_codEmpresaConvenio_orderByNombresC(int codEmpresaConvenio) {
        setError(null);
        sesion = HibernateUtil.getSessionFactory().openSession();
        try {
            Query q = sesion.createQuery("select vcl from VentaCreditoLetra vcl, DatosCliente dc "
                    + "where vcl.ventaCredito.ventas.persona=dc.persona "
                    + "and dc.empresaConvenio.codEmpresaConvenio=:codEmpresaConvenio "
                    + "and (vcl.monto-vcl.totalPago)>0 "
                    + "and substring(vcl.registro,1,1)=1 "
                    + "order by vcl.ventaCredito.ventas.persona.nombresC asc, vcl.codVentaCreditoLetra")
                    .setParameter("codEmpresaConvenio", codEmpresaConvenio);
            return q.list();
        } catch (Exception e) {
            setError(e.getMessage());
        }
        return null;
    }

    public List letras_codCobrador_codEmpresaConvenio_orderByNombresC(int codEmpresaConvenio, int codCobrador) {
        setError(null);
        sesion = HibernateUtil.getSessionFactory().openSession();
        try {
            Query q = sesion.createQuery("select vcl from VentaCreditoLetra vcl, DatosCliente dc "
                    + "where vcl.ventaCredito.ventas.persona=dc.persona "
                    + "and dc.codCobrador=:codCobrador "
                    + "and dc.empresaConvenio.codEmpresaConvenio=:codEmpresaConvenio "
                    + "and (vcl.monto-vcl.totalPago)>0 "
                    + "and substring(vcl.registro,1,1)=1 "
                    + "order by vcl.ventaCredito.ventas.persona.nombresC asc, vcl.codVentaCreditoLetra")
                    .setParameter("codEmpresaConvenio", codEmpresaConvenio)
                    .setParameter("codCobrador", codCobrador);
            return q.list();
        } catch (Exception e) {
            setError(e.getMessage());
        }
        return null;
    }

    public List letras_codEmpresaConvenio_orderByDireccion(int codEmpresaConvenio) {
        setError(null);
        sesion = HibernateUtil.getSessionFactory().openSession();
        try {
            Query q = sesion.createQuery("select vcl from VentaCreditoLetra vcl, DatosCliente dc "
                    + "where vcl.ventaCredito.ventas.persona=dc.persona "
                    + "and dc.empresaConvenio.codEmpresaConvenio=:codEmpresaConvenio "
                    + "and (vcl.monto-vcl.totalPago)>0 "
                    + "and substring(vcl.registro,1,1)=1 "
                    + "order by vcl.ventaCredito.ventas.persona.direccion asc, vcl.codVentaCreditoLetra")
                    .setParameter("codEmpresaConvenio", codEmpresaConvenio);
            return q.list();
        } catch (Exception e) {
            setError(e.getMessage());
        }
        return null;
    }

    public List letras_codCobrador_codEmpresaConvenio_orderByDireccion(int codEmpresaConvenio, int codCobrador) {
        setError(null);
        sesion = HibernateUtil.getSessionFactory().openSession();
        try {
            Query q = sesion.createQuery("select vcl from VentaCreditoLetra vcl, DatosCliente dc "
                    + "where vcl.ventaCredito.ventas.persona=dc.persona "
                    + "and dc.codCobrador=:codCobrador "
                    + "and dc.empresaConvenio.codEmpresaConvenio=:codEmpresaConvenio "
                    + "and (vcl.monto-vcl.totalPago)>0 "
                    + "and substring(vcl.registro,1,1)=1 "
                    + "order by vcl.ventaCredito.ventas.persona.direccion asc, vcl.codVentaCreditoLetra")
                    .setParameter("codEmpresaConvenio", codEmpresaConvenio)
                    .setParameter("codCobrador", codCobrador);
            return q.list();
        } catch (Exception e) {
            setError(e.getMessage());
        }
        return null;
    }

    /**
     * Retorna todas las letras existentes, en la cual hay una deuda mayor a
     * 0.00, ordenado por nombres.
     *
     * @return
     */
    public List letras_orderByDireccion() {
        setError(null);
        sesion = HibernateUtil.getSessionFactory().openSession();
        try {
            Query q = sesion.createQuery("from VentaCreditoLetra vcl "
                    + "where (vcl.monto-vcl.totalPago)>0 "
                    + "and substring(vcl.registro,1,1)=1 "
                    + "order by vcl.ventaCredito.ventas.persona.direccion asc, vcl.codVentaCreditoLetra");
            return q.list();
        } catch (Exception e) {
            setError(e.getMessage());
        }
        return null;
    }

    public List letras_codCobrador_orderByDireccion(int codCobrador) {
        setError(null);
        sesion = HibernateUtil.getSessionFactory().openSession();
        try {
            Query q = sesion.createQuery("select vcl from VentaCreditoLetra vcl,DatosCliente dc "
                    + "where vcl.ventaCredito.ventas.persona=dc.persona "
                    + "and dc.codCobrador=:codCobrador "
                    + "and (vcl.monto-vcl.totalPago)>0 "
                    + "and substring(vcl.registro,1,1)=1 "
                    + "order by vcl.ventaCredito.ventas.persona.direccion asc, vcl.codVentaCreditoLetra")
                    .setParameter("codCobrador", codCobrador);
            return q.list();
        } catch (Exception e) {
            setError(e.getMessage());
        }
        return null;
    }

    /**
     * Retorna un array con todas las letras vencidas.
     *
     * @param fechaVencimiento
     * @return Array.
     */
    public List letrasVencidas_orderDireccion(Date fechaVencimiento) {
        setError(null);
        sesion = HibernateUtil.getSessionFactory().openSession();
        try {
            Query q = sesion.createQuery("from VentaCreditoLetra vcl "
                    + "where vcl.fechaVencimiento<=:fechaVencimiento "
                    + "and (vcl.monto-vcl.totalPago)>0 "
                    + "and substring(vcl.registro,1,1)=1 "
                    + "order by vcl.ventaCredito.ventas.persona.direccion asc, vcl.codVentaCreditoLetra")
                    .setParameter("fechaVencimiento", fechaVencimiento);
            return q.list();
        } catch (Exception e) {
            setError(e.getMessage());
        }
        return null;
    }

    public List letrasVencidas_codCobrador_orderDireccion(Date fechaVencimiento, int codCobrador) {
        setError(null);
        sesion = HibernateUtil.getSessionFactory().openSession();
        try {
            Query q = sesion.createQuery("select vcl from VentaCreditoLetra vcl,DatosCliente dc "
                    + "where vcl.ventaCredito.ventas.persona=dc.persona "
                    + "and vcl.fechaVencimiento<=:fechaVencimiento "
                    + "and dc.codCobrador=:codCobrador "
                    + "and (vcl.monto-vcl.totalPago)>0 "
                    + "and substring(vcl.registro,1,1)=1 "
                    + "order by vcl.ventaCredito.ventas.persona.direccion asc, vcl.codVentaCreditoLetra")
                    .setParameter("fechaVencimiento", fechaVencimiento)
                    .setParameter("codCobrador", codCobrador);
            return q.list();
        } catch (Exception e) {
            setError(e.getMessage());
        }
        return null;
    }

    public List leer_porCodCliente_letrasVencidas_x(int codCliente, Date fechaVencimiento, Date fechaInicio) {
        setError(null);
        sesion = HibernateUtil.getSessionFactory().openSession();
        try {
            Query q = sesion.createQuery("from VentaCreditoLetra v "
                    + "where v.ventaCredito.ventas.persona.codPersona=:codPersona "
                    + "and v.fechaVencimiento<=:fechaVencimiento "
                    + "and v.fechaVencimiento>=:fechaInicio "
                    + "and (v.monto-v.totalPago)>0 "
                    + "and substring(v.registro,1,1)=1 "
                    + "order by codVentaCreditoLetra asc")
                    .setParameter("codPersona", codCliente)
                    .setParameter("fechaVencimiento", fechaVencimiento)
                    .setParameter("fechaInicio", fechaInicio);
            return q.list();
        } catch (Exception e) {
            setError(e.getMessage());
        }
        return null;
    }

    public Double leer_deudaCliente_codCliente(int codPersona) {
        setError(null);
        sesion = HibernateUtil.getSessionFactory().openSession();
        try {
            Query q = sesion.createQuery("select sum(monto-totalPago) from VentaCreditoLetra v "
                    + "where v.ventaCredito.ventas.persona.codPersona=:codPersona "
                    + "and v.monto-v.totalPago>0 "
                    + "and substring(v.registro,1,1)=1 "
                    + "order by v.fechaVencimiento asc")
                    .setParameter("codPersona", codPersona);
            return (Double) q.list().iterator().next();
        } catch (Exception e) {
            setError(e.getMessage());
        }
        return 0.00;
    }

    /**
     * Deuda del cliente por venta hecha
     *
     * @param codPersona
     * @param codVentas
     * @return
     */
    public Double leer_deudaCliente_codCliente_codVentas(int codPersona, int codVentas) {
        setError(null);
        sesion = HibernateUtil.getSessionFactory().openSession();
        try {
            Query q = sesion.createQuery("select sum(monto-totalPago) from VentaCreditoLetra v "
                    + "where v.ventaCredito.ventas.persona.codPersona=:codPersona "
                    + "and v.monto-v.totalPago>0 "
                    + "and v.ventaCredito.ventas.codVentas=:codVentas "
                    + "and substring(v.registro,1,1)=1 "
                    + "order by v.fechaVencimiento asc")
                    .setParameter("codPersona", codPersona)
                    .setParameter("codVentas", codVentas);
            return (Double) q.list().iterator().next();
        } catch (Exception e) {
            setError(e.getMessage());
        }
        return 0.00;
    }

    /**
     * Retonra la letra mas vencida de un cliente buscado por codigo;
     *
     * @param codPersona
     * @return
     */
    public VentaCreditoLetra leer_letraVencidaAntigua(int codPersona) {
        setError(null);
        sesion = HibernateUtil.getSessionFactory().openSession();
        try {
            Query q = sesion.createQuery("from VentaCreditoLetra v "
                    + "where v.ventaCredito.ventas.persona.codPersona=:codPersona "
                    + "and v.monto-v.totalPago>0 "
                    + "and substring(v.registro,1,1)=1 "
                    + "order by v.fechaVencimiento asc")
                    .setParameter("codPersona", codPersona);
            return (VentaCreditoLetra) q.list().get(0);
        } catch (Exception e) {
            setError(e.getMessage());
        }
        return null;
    }

    /**
     * Retonra la letra mas vencida de un cliente buscado por codigo y por venta
     * hecha
     *
     * @param codPersona
     * @return
     */
    public VentaCreditoLetra leer_letraVencidaAntigua_codVentas(int codPersona, int codVentas) {
        setError(null);
        sesion = HibernateUtil.getSessionFactory().openSession();
        try {
            Query q = sesion.createQuery("from VentaCreditoLetra v "
                    + "where v.ventaCredito.ventas.persona.codPersona=:codPersona "
                    + "and v.monto-v.totalPago>0 "
                    + "and v.ventaCredito.ventas.codVentas=:codVentas "
                    + "and substring(v.registro,1,1)=1 "
                    + "order by v.fechaVencimiento asc")
                    .setParameter("codPersona", codPersona)
                    .setParameter("codVentas", codVentas);
            return (VentaCreditoLetra) q.list().get(0);
        } catch (Exception e) {
            setError(e.getMessage());
        }
        return null;
    }

    /**
     * Retorna las letras pendiente de pago de un cliente.
     *
     * @param codPersona
     * @return
     */
    public List leer_letrasPendientePago(int codPersona) {
        setError(null);
        sesion = HibernateUtil.getSessionFactory().openSession();
        try {
            Query q = sesion.createQuery("from VentaCreditoLetra v "
                    + "where v.ventaCredito.ventas.persona.codPersona=:codPersona "
                    + "and v.monto-v.totalPago>0 "
                    + "and substring(v.registro,1,1)=1 "
                    + "order by v.fechaVencimiento asc")
                    .setParameter("codPersona", codPersona);
            return q.list();
        } catch (Exception e) {
            setError(e.getMessage());
        }
        return null;
    }

    /**
     * Obtener todas las deudas por cliente hasta un perido dado, retornara
     * NombresC, dni, ruc, monto ordenado por NombresC
     *
     * @param fechaVencimiento
     * @return
     */
    public List leer_letrasVencidas_orderByNombresC(Date fechaVencimiento) {
        setError(null);
        sesion = HibernateUtil.getSessionFactory().openSession();
        try {
            Query q = sesion.createQuery("select vcl.ventaCredito.ventas.persona.nombresC,vcl.ventaCredito.ventas.persona.dniPasaporte,vcl.ventaCredito.ventas.persona.ruc, sum(vcl.monto-vcl.totalPago) "
                    + "from VentaCreditoLetra vcl "
                    + "where (vcl.monto-vcl.totalPago)>0 "
                    + "and substring(vcl.registro,1,1)=1 "
                    + "and vcl.fechaVencimiento<=:fechaVencimiento "
                    + "group by vcl.ventaCredito.ventas.persona.codPersona "
                    + "order by vcl.ventaCredito.ventas.persona.nombresC ")
                    .setParameter("fechaVencimiento", fechaVencimiento);
            return q.list();
        } catch (Exception e) {
            setError(e.getMessage());
        }
        return null;
    }

    public List leer_letrasVencidas_codCobrador_orderByNombresC(Date fechaVencimiento, int codCobrador) {
        setError(null);
        sesion = HibernateUtil.getSessionFactory().openSession();
        try {
            Query q = sesion.createQuery("select vcl.ventaCredito.ventas.persona.nombresC,vcl.ventaCredito.ventas.persona.dniPasaporte,vcl.ventaCredito.ventas.persona.ruc, sum(vcl.monto-vcl.totalPago) "
                    + "from VentaCreditoLetra vcl, DatosCliente dc "
                    + "where vcl.ventaCredito.ventas.persona=dc.persona "
                    + "and dc.codCobrador=:codCobrador "
                    + "and (vcl.monto-vcl.totalPago)>0 "
                    + "and substring(vcl.registro,1,1)=1 "
                    + "and vcl.fechaVencimiento<=:fechaVencimiento "
                    + "group by vcl.ventaCredito.ventas.persona.codPersona "
                    + "order by vcl.ventaCredito.ventas.persona.nombresC ")
                    .setParameter("fechaVencimiento", fechaVencimiento)
                    .setParameter("codCobrador", codCobrador);
            return q.list();
        } catch (Exception e) {
            setError(e.getMessage());
        }
        return null;
    }

    /**
     * Obtener todas las deudas por cliente hasta un perido dado, retornara
     * NombresC, dni, ruc, monto ordenado por NombresC
     *
     * @param fechaVencimiento
     * @return
     */
    public List leer_letrasVencidas_orderByDireccion(Date fechaVencimiento) {
        setError(null);
        sesion = HibernateUtil.getSessionFactory().openSession();
        try {
            Query q = sesion.createQuery("select vcl.ventaCredito.ventas.persona.nombresC,vcl.ventaCredito.ventas.persona.dniPasaporte,vcl.ventaCredito.ventas.persona.ruc, sum(vcl.monto-vcl.totalPago) "
                    + "from VentaCreditoLetra vcl "
                    + "where (vcl.monto-vcl.totalPago)>0 "
                    + "and substring(vcl.registro,1,1)=1 "
                    + "and vcl.fechaVencimiento<=:fechaVencimiento "
                    + "group by vcl.ventaCredito.ventas.persona.codPersona "
                    + "order by vcl.ventaCredito.ventas.persona.direccion ")
                    .setParameter("fechaVencimiento", fechaVencimiento);
            return q.list();
        } catch (Exception e) {
            setError(e.getMessage());
        }
        return null;
    }

    public List leer_codCobrador_letrasVencidas_orderByDireccion(Date fechaVencimiento, int codCobrador) {
        setError(null);
        sesion = HibernateUtil.getSessionFactory().openSession();
        try {
            Query q = sesion.createQuery("select vcl.ventaCredito.ventas.persona.nombresC,vcl.ventaCredito.ventas.persona.dniPasaporte,vcl.ventaCredito.ventas.persona.ruc, sum(vcl.monto-vcl.totalPago) "
                    + "from VentaCreditoLetra vcl,DatosCliente dc "
                    + "where vcl.ventaCredito.ventas.persona=dc.persona "
                    + "and dc.codCobrador=:codCobrador "
                    + "and (vcl.monto-vcl.totalPago)>0 "
                    + "and substring(vcl.registro,1,1)=1 "
                    + "and vcl.fechaVencimiento<=:fechaVencimiento "
                    + "group by vcl.ventaCredito.ventas.persona.codPersona "
                    + "order by vcl.ventaCredito.ventas.persona.direccion ")
                    .setParameter("fechaVencimiento", fechaVencimiento)
                    .setParameter("codCobrador", codCobrador);
            return q.list();
        } catch (Exception e) {
            setError(e.getMessage());
        }
        return null;
    }

    /**
     *
     * @param fechaVencimiento
     * @param codEmpresaConvenio
     * @return
     */
    public List leer_deudaPendiente_orderByNombresC_empresaConvenio(Date fechaVencimiento, int codEmpresaConvenio) {
        sesion = HibernateUtil.getSessionFactory().openSession();
        try {
            Query q = sesion.createQuery("select dc.persona.nombresC, dc.persona.dniPasaporte, dc.persona.ruc, sum(vcl.monto-vcl.totalPago) "
                    + "from VentaCreditoLetra vcl, DatosCliente dc "
                    + "where dc.persona=vcl.ventaCredito.ventas.persona "
                    + "and vcl.monto-vcl.totalPago>0 "
                    + "and substring(vcl.registro,1,1)=1 "
                    + "and vcl.fechaVencimiento<=:fechaVencimiento "
                    + "and dc.empresaConvenio.codEmpresaConvenio=:codEmpresaConvenio "
                    + "group by dc.persona.codPersona "
                    + "order by dc.persona.nombresC")
                    .setParameter("fechaVencimiento", fechaVencimiento)
                    .setParameter("codEmpresaConvenio", codEmpresaConvenio);
            return q.list();
        } catch (Exception e) {
            setError(e.getMessage());
        }
        return null;
    }

    public List leer_deudaPendiente_tipo_orderByNombresC_empresaConvenio(Date fechaVencimiento, int codEmpresaConvenio, int tipo) {
        sesion = HibernateUtil.getSessionFactory().openSession();
        try {
            Query q = sesion.createQuery("select dc.persona.nombresC, dc.persona.dniPasaporte, dc.persona.ruc, sum(vcl.monto-vcl.totalPago) "
                    + "from VentaCreditoLetra vcl, DatosCliente dc "
                    + "where dc.persona=vcl.ventaCredito.ventas.persona "
                    + "and vcl.monto-vcl.totalPago>0 "
                    + "and substring(vcl.registro,1,1)=1 "
                    + "and vcl.fechaVencimiento<=:fechaVencimiento "
                    + "and dc.empresaConvenio.codEmpresaConvenio=:codEmpresaConvenio "
                    + "and dc.tipo=:tipo "
                    + "group by dc.persona.codPersona "
                    + "order by dc.persona.nombresC")
                    .setParameter("fechaVencimiento", fechaVencimiento)
                    .setParameter("codEmpresaConvenio", codEmpresaConvenio)
                    .setParameter("tipo", tipo);
            return q.list();
        } catch (Exception e) {
            setError(e.getMessage());
        }
        return null;
    }

    public List leer_deudaPendiente_tipo_condicion_orderByNombresC_empresaConvenio(Date fechaVencimiento, int codEmpresaConvenio, int tipo, int condicion) {
        sesion = HibernateUtil.getSessionFactory().openSession();
        try {
            Query q = sesion.createQuery("select dc.persona.nombresC, dc.persona.dniPasaporte, dc.persona.ruc, sum(vcl.monto-vcl.totalPago) "
                    + "from VentaCreditoLetra vcl, DatosCliente dc "
                    + "where dc.persona=vcl.ventaCredito.ventas.persona "
                    + "and vcl.monto-vcl.totalPago>0 "
                    + "and substring(vcl.registro,1,1)=1 "
                    + "and vcl.fechaVencimiento<=:fechaVencimiento "
                    + "and dc.empresaConvenio.codEmpresaConvenio=:codEmpresaConvenio "
                    + "and dc.tipo=:tipo "
                    + "and dc.condicion=:condicion "
                    + "group by dc.persona.codPersona "
                    + "order by dc.persona.nombresC")
                    .setParameter("fechaVencimiento", fechaVencimiento)
                    .setParameter("codEmpresaConvenio", codEmpresaConvenio)
                    .setParameter("tipo", tipo)
                    .setParameter("condicion", condicion);
            return q.list();
        } catch (Exception e) {
            setError(e.getMessage());
        }
        return null;
    }

    public List leer_codCobrador_deudaPendiente_orderByNombresC_empresaConvenio(Date fechaVencimiento, int codEmpresaConvenio, int codCobrador) {
        sesion = HibernateUtil.getSessionFactory().openSession();
        try {
            Query q = sesion.createQuery("select dc.persona.nombresC, dc.persona.dniPasaporte, dc.persona.ruc, sum(vcl.monto-vcl.totalPago) "
                    + "from VentaCreditoLetra vcl, DatosCliente dc "
                    + "where dc.persona=vcl.ventaCredito.ventas.persona "
                    + "and dc.codCobrador=:codCobrador "
                    + "and vcl.monto-vcl.totalPago>0 "
                    + "and substring(vcl.registro,1,1)=1 "
                    + "and vcl.fechaVencimiento<=:fechaVencimiento "
                    + "and dc.empresaConvenio.codEmpresaConvenio=:codEmpresaConvenio "
                    + "group by dc.persona.codPersona "
                    + "order by dc.persona.nombresC")
                    .setParameter("fechaVencimiento", fechaVencimiento)
                    .setParameter("codEmpresaConvenio", codEmpresaConvenio)
                    .setParameter("codCobrador", codCobrador);
            return q.list();
        } catch (Exception e) {
            setError(e.getMessage());
        }
        return null;
    }

    public List leer_deudaPendiente_orderDireccion_empresaConvenio(Date fechaVencimiento, int codEmpresaConvenio) {
        sesion = HibernateUtil.getSessionFactory().openSession();
        try {
            Query q = sesion.createQuery("select dc.persona.nombresC, dc.persona.dniPasaporte, dc.persona.ruc, sum(vcl.monto-vcl.totalPago) "
                    + "from VentaCreditoLetra vcl, DatosCliente dc "
                    + "where dc.persona=vcl.ventaCredito.ventas.persona "
                    + "and vcl.monto-vcl.totalPago>0 "
                    + "and substring(vcl.registro,1,1)=1 "
                    + "and vcl.fechaVencimiento<=:fechaVencimiento "
                    + "and dc.empresaConvenio.codEmpresaConvenio=:codEmpresaConvenio "
                    + "group by dc.persona.codPersona "
                    + "order by dc.persona.direccion")
                    .setParameter("fechaVencimiento", fechaVencimiento)
                    .setParameter("codEmpresaConvenio", codEmpresaConvenio);
            return q.list();
        } catch (Exception e) {
            setError(e.getMessage());
        }
        return null;
    }

    public List leer_deudaPendiente_tipo_orderDireccion_empresaConvenio(Date fechaVencimiento, int codEmpresaConvenio, int tipo) {
        sesion = HibernateUtil.getSessionFactory().openSession();
        try {
            Query q = sesion.createQuery("select dc.persona.nombresC, dc.persona.dniPasaporte, dc.persona.ruc, sum(vcl.monto-vcl.totalPago) "
                    + "from VentaCreditoLetra vcl, DatosCliente dc "
                    + "where dc.persona=vcl.ventaCredito.ventas.persona "
                    + "and vcl.monto-vcl.totalPago>0 "
                    + "and substring(vcl.registro,1,1)=1 "
                    + "and vcl.fechaVencimiento<=:fechaVencimiento "
                    + "and dc.empresaConvenio.codEmpresaConvenio=:codEmpresaConvenio "
                    + "and dc.tipo=:tipo "
                    + "group by dc.persona.codPersona "
                    + "order by dc.persona.direccion")
                    .setParameter("fechaVencimiento", fechaVencimiento)
                    .setParameter("codEmpresaConvenio", codEmpresaConvenio)
                    .setParameter("tipo", tipo);
            return q.list();
        } catch (Exception e) {
            setError(e.getMessage());
        }
        return null;
    }

    public List leer_deudaPendiente_tipo_condicion_orderDireccion_empresaConvenio(Date fechaVencimiento, int codEmpresaConvenio, int tipo, int condicion) {
        sesion = HibernateUtil.getSessionFactory().openSession();
        try {
            Query q = sesion.createQuery("select dc.persona.nombresC, dc.persona.dniPasaporte, dc.persona.ruc, sum(vcl.monto-vcl.totalPago) "
                    + "from VentaCreditoLetra vcl, DatosCliente dc "
                    + "where dc.persona=vcl.ventaCredito.ventas.persona "
                    + "and vcl.monto-vcl.totalPago>0 "
                    + "and substring(vcl.registro,1,1)=1 "
                    + "and vcl.fechaVencimiento<=:fechaVencimiento "
                    + "and dc.empresaConvenio.codEmpresaConvenio=:codEmpresaConvenio "
                    + "and dc.tipo=:tipo "
                    + "and dc.condicion=:condicion "
                    + "group by dc.persona.codPersona "
                    + "order by dc.persona.direccion")
                    .setParameter("fechaVencimiento", fechaVencimiento)
                    .setParameter("codEmpresaConvenio", codEmpresaConvenio)
                    .setParameter("tipo", tipo)
                    .setParameter("condicion", condicion);
            return q.list();
        } catch (Exception e) {
            setError(e.getMessage());
        }
        return null;
    }

    public List leer_codCobrador_deudaPendiente_orderDireccion_empresaConvenio(Date fechaVencimiento, int codEmpresaConvenio, int codCobrador) {
        sesion = HibernateUtil.getSessionFactory().openSession();
        try {
            Query q = sesion.createQuery("select dc.persona.nombresC, dc.persona.dniPasaporte, dc.persona.ruc, sum(vcl.monto-vcl.totalPago) "
                    + "from VentaCreditoLetra vcl, DatosCliente dc "
                    + "where dc.persona=vcl.ventaCredito.ventas.persona "
                    + "and dc.codCobrador=:codCobrador "
                    + "and vcl.monto-vcl.totalPago>0 "
                    + "and substring(vcl.registro,1,1)=1 "
                    + "and vcl.fechaVencimiento<=:fechaVencimiento "
                    + "and dc.empresaConvenio.codEmpresaConvenio=:codEmpresaConvenio "
                    + "group by dc.persona.codPersona "
                    + "order by dc.persona.direccion")
                    .setParameter("fechaVencimiento", fechaVencimiento)
                    .setParameter("codEmpresaConvenio", codEmpresaConvenio)
                    .setParameter("codCobrador", codCobrador);
            return q.list();
        } catch (Exception e) {
            setError(e.getMessage());
        }
        return null;
    }

    public String moneda(int moneda) {
        switch (moneda) {
            case 0:
                return "Soles";
            case 1:
                return "Dolares";
        }
        return "";
    }

    public List leer_admin() {
        setError(null);
        try {
            sesion = HibernateUtil.getSessionFactory().openSession();
            Query q = sesion.createQuery("from VentaCreditoLetra");
            return (List) q.list();
        } catch (Exception e) {
            setError(e.getMessage());
        }
        return null;
    }

    public boolean actualizar_registro(int codVentaCreditoLetra, String estado, String user) {
        cUtilitarios objUtilitarios = new cUtilitarios();
        setError(null);
        sesion = HibernateUtil.getSessionFactory().openSession();
        sesion.getTransaction().begin();
        VentaCreditoLetra obj = (VentaCreditoLetra) sesion.get(VentaCreditoLetra.class, codVentaCreditoLetra);
        obj.setRegistro(objUtilitarios.registro(estado, user));
        try {
            sesion.update(obj);
            sesion.getTransaction().commit();
            return true;
        } catch (Exception e) {
            sesion.getTransaction().rollback();
            setError("VentaCreditoLetra_actualizar_registro: " + e.getMessage());
        }
        return false;
    }

    public boolean actualizar_totalPago(int codVentaCreditoLetra, Double montoAmortizar, Date fechaPago) {
        setError(null);
        sesion = HibernateUtil.getSessionFactory().openSession();
        sesion.getTransaction().begin();
        VentaCreditoLetra obj = (VentaCreditoLetra) sesion.get(VentaCreditoLetra.class, codVentaCreditoLetra);
        obj.setTotalPago(obj.getTotalPago() + montoAmortizar);
        obj.setFechaPago(fechaPago);
        try {
            sesion.update(obj);
            sesion.getTransaction().commit();
            return true;
        } catch (Exception e) {
            sesion.getTransaction().rollback();
            setError("VentaCreditoLetra_actualizar_registro: " + e.getMessage());
        }
        return false;
    }
}
