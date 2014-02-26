/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package ventaClases;

import java.util.Date;
import java.util.List;
import org.hibernate.Query;
import org.hibernate.Transaction;
import org.hibernate.classic.Session;
import tablas.HibernateUtil;

/**
 *
 * @author Henrri
 */
public class cVentaCreditoLetraReporte {

    Session sesion = null;
    public String error;

    public String getError() {
        return error;
    }

    public void setError(String error) {
        this.error = error;
    }

    public cVentaCreditoLetraReporte() {
        this.sesion = HibernateUtil.getSessionFactory().getCurrentSession();
        this.error = null;
    }

    /**
     *
     * @param codPersona
     * @return
     */
    public Object[] leer_resumenDeudaCliente(int codPersona) {
        Object tem[] = null;
        Transaction trns = null;
        sesion = HibernateUtil.getSessionFactory().openSession();
        try {
            trns = sesion.beginTransaction();
            Query q = sesion.createQuery("select sum(vcl.monto),sum(vcl.totalPago),(sum(vcl.monto)-sum(vcl.totalPago)) "
                    + "from VentaCreditoLetra vcl where substring(vcl.registro,1,1)=1 "
                    + "and vcl.ventaCredito.ventas.persona.codPersona=:codPersona")
                    .setParameter("codPersona", codPersona);
            tem = (Object[]) q.list().get(0);
            if (tem[0] == null & tem[1] == null & tem[2] == null) {
                tem[0] = 0.00;
                tem[1] = 0.00;
                tem[2] = 0.00;
            }
        } catch (RuntimeException e) {
            e.printStackTrace();
        } finally {
            sesion.flush();
            sesion.close();
        }
        return tem;
    }

    /**
     * Lista todas las letras vencidas hasta una fecha dada, ademas de estar
     * ordenada por nombresC
     *
     * @param fechaVencimiento
     * @return
     */
    public List letrasVencidas_ordenNombresC(Date fechaVencimiento) {
        List l = null;
        Transaction trns = null;
        sesion = HibernateUtil.getSessionFactory().openSession();
        try {
            trns = sesion.beginTransaction();
            Query q = sesion.createQuery("from VentaCreditoLetra vcl "
                    + "where vcl.fechaVencimiento<=:fechaVencimiento "
                    + "and (vcl.monto-vcl.totalPago)>0 "
                    + "and substring(vcl.registro,1,1)=1 "
                    + "order by vcl.ventaCredito.ventas.persona.nombresC asc, vcl.codVentaCreditoLetra")
                    .setParameter("fechaVencimiento", fechaVencimiento);
            l = q.list();
        } catch (Exception e) {
            e.printStackTrace();
        } finally {
            sesion.flush();
        }
        return l;
    }

    /**
     *
     * @param fechaVencimiento
     * @return
     */
    public List letrasVencidas_ordenDireccion(Date fechaVencimiento) {
        List l = null;
        Transaction trns = null;
        sesion = HibernateUtil.getSessionFactory().openSession();
        try {
            trns = sesion.beginTransaction();
            Query q = sesion.createQuery("from VentaCreditoLetra vcl "
                    + "where vcl.fechaVencimiento<=:fechaVencimiento "
                    + "and (vcl.monto-vcl.totalPago)>0 "
                    + "and substring(vcl.registro,1,1)=1 "
                    + "order by vcl.ventaCredito.ventas.persona.direccion asc, vcl.codVentaCreditoLetra")
                    .setParameter("fechaVencimiento", fechaVencimiento);
            l = q.list();
        } catch (Exception e) {
            e.printStackTrace();
        } finally {
            sesion.flush();
        }
        return l;
    }

    /**
     *
     * @param fechaVencimiento
     * @param codCobrador
     * @return
     */
    public List letrasVencidas_codCobrador_ordenNombresC(Date fechaVencimiento, int codCobrador) {
        List l = null;
        Transaction trns = null;
        sesion = HibernateUtil.getSessionFactory().openSession();
        try {
            trns = sesion.beginTransaction();
            Query q = sesion.createQuery("select vcl from VentaCreditoLetra vcl, DatosCliente dc "
                    + "where vcl.ventaCredito.ventas.persona=dc.persona "
                    + "and dc.codCobrador=:codCobrador "
                    + "and vcl.fechaVencimiento<=:fechaVencimiento "
                    + "and (vcl.monto-vcl.totalPago)>0 "
                    + "and substring(vcl.registro,1,1)=1 "
                    + "order by vcl.ventaCredito.ventas.persona.nombresC asc, vcl.codVentaCreditoLetra")
                    .setParameter("fechaVencimiento", fechaVencimiento)
                    .setParameter("codCobrador", codCobrador);
            l = q.list();
        } catch (Exception e) {
            e.printStackTrace();
        } finally {
            sesion.flush();
        }
        return l;
    }

    /**
     *
     * @param fechaVencimiento
     * @param codCobrador
     * @return
     */
    public List letrasVencidas_codCobrador_ordenDireccion(Date fechaVencimiento, int codCobrador) {
        List l = null;
        Transaction trns = null;
        sesion = HibernateUtil.getSessionFactory().openSession();
        try {
            trns = sesion.beginTransaction();
            Query q = sesion.createQuery("select vcl from VentaCreditoLetra vcl,DatosCliente dc "
                    + "where vcl.ventaCredito.ventas.persona=dc.persona "
                    + "and vcl.fechaVencimiento<=:fechaVencimiento "
                    + "and dc.codCobrador=:codCobrador "
                    + "and (vcl.monto-vcl.totalPago)>0 "
                    + "and substring(vcl.registro,1,1)=1 "
                    + "order by vcl.ventaCredito.ventas.persona.direccion asc, vcl.codVentaCreditoLetra")
                    .setParameter("fechaVencimiento", fechaVencimiento)
                    .setParameter("codCobrador", codCobrador);
            l = q.list();
        } catch (Exception e) {
            setError(e.getMessage());
            e.printStackTrace();
        } finally {
            sesion.flush();
        }
        return l;
    }

    /**
     * Obtener todas las deudas por cliente hasta un perido dado, retornara
     * NombresC, dni, ruc, monto ordenado por NombresC
     *
     * @param fechaVencimiento
     * @return
     */
    public List letrasVencidas_total_ordenNombresC(Date fechaVencimiento) {
        List l = null;
        Transaction trns = null;
        sesion = HibernateUtil.getSessionFactory().openSession();
        try {
            trns = sesion.beginTransaction();
            Query q = sesion.createQuery("select vcl.ventaCredito.ventas.persona.nombresC, "
                    + "vcl.ventaCredito.ventas.persona.dniPasaporte, "
                    + "vcl.ventaCredito.ventas.persona.ruc, "
                    + "sum(vcl.monto-vcl.totalPago) "
                    + "from VentaCreditoLetra vcl "
                    + "where (vcl.monto-vcl.totalPago)>0 "
                    + "and substring(vcl.registro,1,1)=1 "
                    + "and vcl.fechaVencimiento<=:fechaVencimiento "
                    + "group by vcl.ventaCredito.ventas.persona.codPersona "
                    + "order by vcl.ventaCredito.ventas.persona.nombresC ")
                    .setParameter("fechaVencimiento", fechaVencimiento);
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
     * Obtener todas las deudas por cliente hasta un perido dado, retornara
     * NombresC, dni, ruc, monto ordenado por direccion
     *
     * @param fechaVencimiento
     * @return
     */
    public List letrasVencidas_total_ordenDireccion(Date fechaVencimiento) {
        List l = null;
        Transaction trns = null;
        sesion = HibernateUtil.getSessionFactory().openSession();
        try {
            trns = sesion.beginTransaction();
            Query q = sesion.createQuery("select vcl.ventaCredito.ventas.persona.nombresC, "
                    + "vcl.ventaCredito.ventas.persona.dniPasaporte, "
                    + "vcl.ventaCredito.ventas.persona.ruc, "
                    + "sum(vcl.monto-vcl.totalPago) "
                    + "from VentaCreditoLetra vcl "
                    + "where (vcl.monto-vcl.totalPago)>0 "
                    + "and substring(vcl.registro,1,1)=1 "
                    + "and vcl.fechaVencimiento<=:fechaVencimiento "
                    + "group by vcl.ventaCredito.ventas.persona.codPersona "
                    + "order by vcl.ventaCredito.ventas.persona.direccion ")
                    .setParameter("fechaVencimiento", fechaVencimiento);
            l = q.list();
        } catch (Exception e) {
            e.printStackTrace();
        } finally {
            sesion.flush();
            sesion.close();
        }
        return l;
    }

    public List letrasVencidas_codCobrador_total_ordenNombresC(Date fechaVencimiento, int codCobrador) {
        List l = null;
        Transaction trns = null;
        sesion = HibernateUtil.getSessionFactory().openSession();
        try {
            trns = sesion.beginTransaction();
            Query q = sesion.createQuery("select vcl.ventaCredito.ventas.persona.nombresC, "
                    + "vcl.ventaCredito.ventas.persona.dniPasaporte, "
                    + "vcl.ventaCredito.ventas.persona.ruc, "
                    + "sum(vcl.monto-vcl.totalPago) "
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
            l = q.list();
        } catch (Exception e) {
            e.printStackTrace();
        } finally {
            sesion.flush();
            sesion.close();
        }
        return l;
    }

    public List letrasVencidas_codCobrador_total_ordenDireccion(Date fechaVencimiento, int codCobrador) {
        List l = null;
        Transaction trns = null;
        sesion = HibernateUtil.getSessionFactory().openSession();
        try {
            trns = sesion.beginTransaction();
            Query q = sesion.createQuery("select vcl.ventaCredito.ventas.persona.nombresC, "
                    + "vcl.ventaCredito.ventas.persona.dniPasaporte, "
                    + "vcl.ventaCredito.ventas.persona.ruc, "
                    + "sum(vcl.monto-vcl.totalPago) "
                    + "from VentaCreditoLetra vcl, DatosCliente dc "
                    + "where vcl.ventaCredito.ventas.persona=dc.persona "
                    + "and dc.codCobrador=:codCobrador "
                    + "and (vcl.monto-vcl.totalPago)>0 "
                    + "and substring(vcl.registro,1,1)=1 "
                    + "and vcl.fechaVencimiento<=:fechaVencimiento "
                    + "group by vcl.ventaCredito.ventas.persona.codPersona "
                    + "order by vcl.ventaCredito.ventas.persona.direccion ")
                    .setParameter("fechaVencimiento", fechaVencimiento)
                    .setParameter("codCobrador", codCobrador);
            l = q.list();
        } catch (Exception e) {
            e.printStackTrace();
        } finally {
            sesion.flush();
            sesion.close();
        }
        return l;
    }
}
