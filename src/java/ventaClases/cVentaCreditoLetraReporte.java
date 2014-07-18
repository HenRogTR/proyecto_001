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
import org.hibernate.Session;
import HiberanteUtil.HibernateUtil;

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
    public Object[] leer_resumenDeudaCliente(Integer codPersona) {
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
     * 0: codPersona, 1:nombresC, 2:dniPasaporte, 3:ruc, 4:dirección,
     * 5:telefono1, 6:telefono2, 7:codDatosCliente, 8:codVentas,
     * 9:docSerieNumero, 10:fecha, 11:itemCantidad, 12:cantidadLetras,
     * 13:codVentaCreditoLetra, 14:numeroLetra, 15:detalleLetra,
     * 16:fechaVencimiento, 17:monto, 18:interes, 19:fechaPago, 20:totalPago,
     * 21:interesPagado, 22:interesUltimoCalculo
     *
     * @param fechaVencimiento
     * @return
     */
    public List letrasVencidas_todos_ordenNombresC_SC(Date fechaVencimiento) {
        List l = null;
        Transaction trns = null;
        sesion = HibernateUtil.getSessionFactory().openSession();
        try {
            trns = sesion.beginTransaction();
            Query q = sesion.createQuery("select dc.persona.codPersona, "
                    + "dc.persona.nombresC, dc.persona.dniPasaporte, dc.persona.ruc, "
                    + "dc.persona.direccion, dc.persona.telefono1, "
                    + "dc.persona.telefono2, dc.codDatosCliente, "
                    + "vcl.ventaCredito.ventas.codVentas, "
                    + "vcl.ventaCredito.ventas.docSerieNumero, "
                    + "vcl.ventaCredito.ventas.fecha, "
                    + "vcl.ventaCredito.ventas.itemCantidad, "
                    + "vcl.ventaCredito.cantidadLetras, vcl.codVentaCreditoLetra, "
                    + "vcl.numeroLetra, vcl.detalleLetra, vcl.fechaVencimiento, "
                    + "vcl.monto, vcl.interes, vcl.fechaPago, vcl.totalPago "
                    + " ,vcl.interesPagado, vcl.interesUltimoCalculo "
                    + "from VentaCreditoLetra vcl, DatosCliente dc "
                    + "where vcl.ventaCredito.ventas.persona=dc.persona "
                    + "and substring(vcl.registro,1,1) = 1 "
                    + "and vcl.fechaVencimiento < :fechaVencimiento "
                    + "and (vcl.monto- vcl.totalPago> 0 or vcl.interes- vcl.interesPagado> 0) "
                    + "order by dc.persona.nombresC, dc.codDatosCliente, vcl.ventaCredito.codVentaCredito, vcl.numeroLetra")
                    .setParameter("fechaVencimiento", fechaVencimiento);
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
     * 0: codPerosna, 1:nombresC, 2:dniPasaporte, 3:ruc, 4:dirección,
     * 5:telefono1, 6:telefono2, 7:codDatosCliente, 8:codVentas,
     * 9:docSerieNumero, 10:fecha, 11:itemCantidad, 12:cantidadLetras,
     * 13:codVentaCreditoLetra, 14:numeroLetra, 15:detalleLetra,
     * 16:fechaVencimiento, 17:monto, 18:interes, 19:fechaPago, 20:totalPago,
     * 21:interesPagado, 22:interesUltimoCalculo
     *
     * @param fechaVencimiento
     * @return
     */
    public List letrasVencidas_todos_ordenDireccion_SC(Date fechaVencimiento) {
        List l = null;
        Transaction trns = null;
        sesion = HibernateUtil.getSessionFactory().openSession();
        try {
            trns = sesion.beginTransaction();
            Query q = sesion.createQuery("select dc.persona.codPersona, "
                    + "dc.persona.nombresC, dc.persona.dniPasaporte, dc.persona.ruc, "
                    + "dc.persona.direccion, dc.persona.telefono1, "
                    + "dc.persona.telefono2, dc.codDatosCliente, "
                    + "vcl.ventaCredito.ventas.codVentas, "
                    + "vcl.ventaCredito.ventas.docSerieNumero, "
                    + "vcl.ventaCredito.ventas.fecha, "
                    + "vcl.ventaCredito.ventas.itemCantidad, "
                    + "vcl.ventaCredito.cantidadLetras, vcl.codVentaCreditoLetra, "
                    + "vcl.numeroLetra, vcl.detalleLetra, vcl.fechaVencimiento, "
                    + "vcl.monto, vcl.interes, vcl.fechaPago, vcl.totalPago "
                    + " ,vcl.interesPagado, vcl.interesUltimoCalculo "
                    + "from VentaCreditoLetra vcl, DatosCliente dc "
                    + "where vcl.ventaCredito.ventas.persona=dc.persona "
                    + "and substring(vcl.registro,1,1) = 1 "
                    + "and vcl.fechaVencimiento < :fechaVencimiento "
                    + "and (vcl.monto- vcl.totalPago> 0 or vcl.interes- vcl.interesPagado> 0) "
                    + "order by dc.persona.direccion, dc.codDatosCliente, vcl.ventaCredito.codVentaCredito, vcl.numeroLetra")
                    .setParameter("fechaVencimiento", fechaVencimiento);
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
     * 0: codPerosna, 1:nombresC, 2:dniPasaporte, 3:ruc, 4:dirección,
     * 5:telefono1, 6:telefono2, 7:codDatosCliente, 8:codVentas,
     * 9:docSerieNumero, 10:fecha, 11:itemCantidad, 12:cantidadLetras,
     * 13:codVentaCreditoLetra, 14:numeroLetra, 15:detalleLetra,
     * 16:fechaVencimiento, 17:monto, 18:interes, 19:fechaPago, 20:totalPago,
     * 21:interesPagado, 22:interesUltimoCalculo
     *
     * @param fechaVencimiento
     * @param codCobrador
     * @return
     */
    public List letrasVencidas_cobrador_ordenNombresC_SC(Date fechaVencimiento,
            Integer codCobrador) {
        List l = null;
        Transaction trns = null;
        sesion = HibernateUtil.getSessionFactory().openSession();
        try {
            trns = sesion.beginTransaction();
            Query q = sesion.createQuery("select dc.persona.codPersona, "
                    + "dc.persona.nombresC, dc.persona.dniPasaporte, dc.persona.ruc, "
                    + "dc.persona.direccion, dc.persona.telefono1, "
                    + "dc.persona.telefono2, dc.codDatosCliente, "
                    + "vcl.ventaCredito.ventas.codVentas, "
                    + "vcl.ventaCredito.ventas.docSerieNumero, "
                    + "vcl.ventaCredito.ventas.fecha, "
                    + "vcl.ventaCredito.ventas.itemCantidad, "
                    + "vcl.ventaCredito.cantidadLetras, vcl.codVentaCreditoLetra, "
                    + "vcl.numeroLetra, vcl.detalleLetra, vcl.fechaVencimiento, "
                    + "vcl.monto, vcl.interes, vcl.fechaPago, vcl.totalPago "
                    + " ,vcl.interesPagado, vcl.interesUltimoCalculo "
                    + "from VentaCreditoLetra vcl, DatosCliente dc "
                    + "where vcl.ventaCredito.ventas.persona=dc.persona "
                    + "and substring(vcl.registro,1,1) = 1 "
                    + "and vcl.fechaVencimiento < :fechaVencimiento "
                    + "and (vcl.monto- vcl.totalPago> 0 or vcl.interes- vcl.interesPagado> 0) "
                    + "and dc.codCobrador = :codCobrador "
                    + "order by dc.persona.nombresC, dc.codDatosCliente, vcl.ventaCredito.codVentaCredito, vcl.numeroLetra")
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

    /**
     * 0: codPerosna, 1:nombresC, 2:dniPasaporte, 3:ruc, 4:dirección,
     * 5:telefono1, 6:telefono2, 7:codDatosCliente, 8:codVentas,
     * 9:docSerieNumero, 10:fecha, 11:itemCantidad, 12:cantidadLetras,
     * 13:codVentaCreditoLetra, 14:numeroLetra, 15:detalleLetra,
     * 16:fechaVencimiento, 17:monto, 18:interes, 19:fechaPago, 20:totalPago,
     * 21:interesPagado, 22:interesUltimoCalculo
     *
     * @param fechaVencimiento
     * @param codCobrador
     * @return
     */
    public List letrasVencidas_cobrador_ordenDireccion_SC(Date fechaVencimiento,
            Integer codCobrador) {
        List l = null;
        Transaction trns = null;
        sesion = HibernateUtil.getSessionFactory().openSession();
        try {
            trns = sesion.beginTransaction();
            Query q = sesion.createQuery("select dc.persona.codPersona, "
                    + "dc.persona.nombresC, dc.persona.dniPasaporte, dc.persona.ruc, "
                    + "dc.persona.direccion, dc.persona.telefono1, "
                    + "dc.persona.telefono2, dc.codDatosCliente, "
                    + "vcl.ventaCredito.ventas.codVentas, "
                    + "vcl.ventaCredito.ventas.docSerieNumero, "
                    + "vcl.ventaCredito.ventas.fecha, "
                    + "vcl.ventaCredito.ventas.itemCantidad, "
                    + "vcl.ventaCredito.cantidadLetras, vcl.codVentaCreditoLetra, "
                    + "vcl.numeroLetra, vcl.detalleLetra, vcl.fechaVencimiento, "
                    + "vcl.monto, vcl.interes, vcl.fechaPago, vcl.totalPago "
                    + " ,vcl.interesPagado, vcl.interesUltimoCalculo "
                    + "from VentaCreditoLetra vcl, DatosCliente dc "
                    + "where vcl.ventaCredito.ventas.persona=dc.persona "
                    + "and substring(vcl.registro,1,1) = 1 "
                    + "and vcl.fechaVencimiento < :fechaVencimiento "
                    + "and (vcl.monto- vcl.totalPago> 0 or vcl.interes- vcl.interesPagado> 0) "
                    + "and dc.codCobrador = :codCobrador "
                    + "order by dc.persona.direccion, dc.codDatosCliente, vcl.ventaCredito.codVentaCredito, vcl.numeroLetra")
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

    /**
     * 0: codPerosna, 1:nombresC, 2:dniPasaporte, 3:ruc, 4:dirección,
     * 5:telefono1, 6:telefono2, 7:codDatosCliente, 8:codVentas,
     * 9:docSerieNumero, 10:fecha, 11:itemCantidad, 12:cantidadLetras,
     * 13:codVentaCreditoLetra, 14:numeroLetra, 15:detalleLetra,
     * 16:fechaVencimiento, 17:monto, 18:interes, 19:fechaPago, 20:totalPago,
     * 21:interesPagado, 22:interesUltimoCalculo
     *
     * @param fechaVencimiento
     * @param codEmpresaConvenio
     * @return
     */
    public List letrasVencidas_empresaConvenio_todos_ordenNombresC_SC(Date fechaVencimiento,
            Integer codEmpresaConvenio) {
        List l = null;
        Transaction trns = null;
        sesion = HibernateUtil.getSessionFactory().openSession();
        try {
            trns = sesion.beginTransaction();
            Query q = sesion.createQuery("select dc.persona.codPersona, "
                    + "dc.persona.nombresC, dc.persona.dniPasaporte, dc.persona.ruc, "
                    + "dc.persona.direccion, dc.persona.telefono1, "
                    + "dc.persona.telefono2, dc.codDatosCliente, "
                    + "vcl.ventaCredito.ventas.codVentas, "
                    + "vcl.ventaCredito.ventas.docSerieNumero, "
                    + "vcl.ventaCredito.ventas.fecha, "
                    + "vcl.ventaCredito.ventas.itemCantidad, "
                    + "vcl.ventaCredito.cantidadLetras, vcl.codVentaCreditoLetra, "
                    + "vcl.numeroLetra, vcl.detalleLetra, vcl.fechaVencimiento, "
                    + "vcl.monto, vcl.interes, vcl.fechaPago, vcl.totalPago "
                    + " ,vcl.interesPagado, vcl.interesUltimoCalculo "
                    + "from VentaCreditoLetra vcl, DatosCliente dc "
                    + "where vcl.ventaCredito.ventas.persona=dc.persona "
                    + "and substring(vcl.registro,1,1) = 1 "
                    + "and vcl.fechaVencimiento < :fechaVencimiento "
                    + "and (vcl.monto- vcl.totalPago> 0 or vcl.interes- vcl.interesPagado> 0) "
                    + "and dc.empresaConvenio.codEmpresaConvenio = :codEmpresaConvenio "
                    + "order by dc.persona.nombresC, dc.codDatosCliente, vcl.ventaCredito.codVentaCredito, vcl.numeroLetra")
                    .setParameter("fechaVencimiento", fechaVencimiento)
                    .setParameter("codEmpresaConvenio", codEmpresaConvenio);
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
     * 0: codPerosna, 1:nombresC, 2:dniPasaporte, 3:ruc, 4:dirección,
     * 5:telefono1, 6:telefono2, 7:codDatosCliente, 8:codVentas,
     * 9:docSerieNumero, 10:fecha, 11:itemCantidad, 12:cantidadLetras,
     * 13:codVentaCreditoLetra, 14:numeroLetra, 15:detalleLetra,
     * 16:fechaVencimiento, 17:monto, 18:interes, 19:fechaPago, 20:totalPago,
     * 21:interesPagado, 22:interesUltimoCalculo
     *
     * @param fechaVencimiento
     * @param codEmpresaConvenio
     * @return
     */
    public List letrasVencidas_empresaConvenio_todos_ordenDireccion_SC(Date fechaVencimiento,
            Integer codEmpresaConvenio) {
        List l = null;
        Transaction trns = null;
        sesion = HibernateUtil.getSessionFactory().openSession();
        try {
            trns = sesion.beginTransaction();
            Query q = sesion.createQuery("select dc.persona.codPersona, "
                    + "dc.persona.nombresC, dc.persona.dniPasaporte, dc.persona.ruc, "
                    + "dc.persona.direccion, dc.persona.telefono1, "
                    + "dc.persona.telefono2, dc.codDatosCliente, "
                    + "vcl.ventaCredito.ventas.codVentas, "
                    + "vcl.ventaCredito.ventas.docSerieNumero, "
                    + "vcl.ventaCredito.ventas.fecha, "
                    + "vcl.ventaCredito.ventas.itemCantidad, "
                    + "vcl.ventaCredito.cantidadLetras, vcl.codVentaCreditoLetra, "
                    + "vcl.numeroLetra, vcl.detalleLetra, vcl.fechaVencimiento, "
                    + "vcl.monto, vcl.interes, vcl.fechaPago, vcl.totalPago "
                    + " ,vcl.interesPagado, vcl.interesUltimoCalculo "
                    + "from VentaCreditoLetra vcl, DatosCliente dc "
                    + "where vcl.ventaCredito.ventas.persona=dc.persona "
                    + "and substring(vcl.registro,1,1) = 1 "
                    + "and vcl.fechaVencimiento < :fechaVencimiento "
                    + "and (vcl.monto- vcl.totalPago> 0 or vcl.interes- vcl.interesPagado> 0) "
                    + "and dc.empresaConvenio.codEmpresaConvenio = :codEmpresaConvenio "
                    + "order by dc.persona.direccion, dc.codDatosCliente, vcl.ventaCredito.codVentaCredito, vcl.numeroLetra")
                    .setParameter("fechaVencimiento", fechaVencimiento)
                    .setParameter("codEmpresaConvenio", codEmpresaConvenio);
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
     * 0: codPerosna, 1:nombresC, 2:dniPasaporte, 3:ruc, 4:dirección,
     * 5:telefono1, 6:telefono2, 7:codDatosCliente, 8:codVentas,
     * 9:docSerieNumero, 10:fecha, 11:itemCantidad, 12:cantidadLetras,
     * 13:codVentaCreditoLetra, 14:numeroLetra, 15:detalleLetra,
     * 16:fechaVencimiento, 17:monto, 18:interes, 19:fechaPago, 20:totalPago,
     * 21:interesPagado, 22:interesUltimoCalculo
     *
     * @param fechaVencimiento
     * @param codEmpresaConvenio
     * @param codCobrador
     * @return
     */
    public List letrasVencidas_empresaConvenio_cobrador_ordenNombresC_SC(Date fechaVencimiento,
            Integer codEmpresaConvenio, Integer codCobrador) {
        List l = null;
        Transaction trns = null;
        sesion = HibernateUtil.getSessionFactory().openSession();
        try {
            trns = sesion.beginTransaction();
            Query q = sesion.createQuery("select dc.persona.codPersona, "
                    + "dc.persona.nombresC, dc.persona.dniPasaporte, dc.persona.ruc, "
                    + "dc.persona.direccion, dc.persona.telefono1, "
                    + "dc.persona.telefono2, dc.codDatosCliente, "
                    + "vcl.ventaCredito.ventas.codVentas, "
                    + "vcl.ventaCredito.ventas.docSerieNumero, "
                    + "vcl.ventaCredito.ventas.fecha, "
                    + "vcl.ventaCredito.ventas.itemCantidad, "
                    + "vcl.ventaCredito.cantidadLetras, vcl.codVentaCreditoLetra, "
                    + "vcl.numeroLetra, vcl.detalleLetra, vcl.fechaVencimiento, "
                    + "vcl.monto, vcl.interes, vcl.fechaPago, vcl.totalPago "
                    + " ,vcl.interesPagado, vcl.interesUltimoCalculo "
                    + "from VentaCreditoLetra vcl, DatosCliente dc "
                    + "where vcl.ventaCredito.ventas.persona=dc.persona "
                    + "and substring(vcl.registro,1,1) = 1 "
                    + "and vcl.fechaVencimiento < :fechaVencimiento "
                    + "and (vcl.monto- vcl.totalPago> 0 or vcl.interes- vcl.interesPagado> 0) "
                    + "and dc.empresaConvenio.codEmpresaConvenio = :codEmpresaConvenio "
                    + "and dc.codCobrador = :codCobrador "
                    + "order by dc.persona.nombresC, dc.codDatosCliente, vcl.ventaCredito.codVentaCredito, vcl.numeroLetra")
                    .setParameter("fechaVencimiento", fechaVencimiento)
                    .setParameter("codEmpresaConvenio", codEmpresaConvenio)
                    .setParameter("codCobrador", codCobrador);
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
     * 0: codPerosna, 1:nombresC, 2:dniPasaporte, 3:ruc, 4:dirección,
     * 5:telefono1, 6:telefono2, 7:codDatosCliente, 8:codVentas,
     * 9:docSerieNumero, 10:fecha, 11:itemCantidad, 12:cantidadLetras,
     * 13:codVentaCreditoLetra, 14:numeroLetra, 15:detalleLetra,
     * 16:fechaVencimiento, 17:monto, 18:interes, 19:fechaPago, 20:totalPago,
     * 21:interesPagado, 22:interesUltimoCalculo
     *
     * @param fechaVencimiento
     * @param codEmpresaConvenio
     * @param codCobrador
     * @return
     */
    public List letrasVencidas_empresaConvenio_cobrador_ordenDireccion_SC(Date fechaVencimiento,
            Integer codEmpresaConvenio, Integer codCobrador) {
        List l = null;
        Transaction trns = null;
        sesion = HibernateUtil.getSessionFactory().openSession();
        try {
            trns = sesion.beginTransaction();
            Query q = sesion.createQuery("select dc.persona.codPersona, "
                    + "dc.persona.nombresC, dc.persona.dniPasaporte, dc.persona.ruc, "
                    + "dc.persona.direccion, dc.persona.telefono1, "
                    + "dc.persona.telefono2, dc.codDatosCliente, "
                    + "vcl.ventaCredito.ventas.codVentas, "
                    + "vcl.ventaCredito.ventas.docSerieNumero, "
                    + "vcl.ventaCredito.ventas.fecha, "
                    + "vcl.ventaCredito.ventas.itemCantidad, "
                    + "vcl.ventaCredito.cantidadLetras, vcl.codVentaCreditoLetra, "
                    + "vcl.numeroLetra, vcl.detalleLetra, vcl.fechaVencimiento, "
                    + "vcl.monto, vcl.interes, vcl.fechaPago, vcl.totalPago "
                    + " ,vcl.interesPagado, vcl.interesUltimoCalculo "
                    + "from VentaCreditoLetra vcl, DatosCliente dc "
                    + "where vcl.ventaCredito.ventas.persona=dc.persona "
                    + "and substring(vcl.registro,1,1) = 1 "
                    + "and vcl.fechaVencimiento < :fechaVencimiento "
                    + "and (vcl.monto- vcl.totalPago> 0 or vcl.interes- vcl.interesPagado> 0) "
                    + "and dc.empresaConvenio.codEmpresaConvenio = :codEmpresaConvenio "
                    + "and dc.codCobrador = :codCobrador "
                    + "order by dc.persona.direccion, dc.codDatosCliente, vcl.ventaCredito.codVentaCredito, vcl.numeroLetra")
                    .setParameter("fechaVencimiento", fechaVencimiento)
                    .setParameter("codEmpresaConvenio", codEmpresaConvenio)
                    .setParameter("codCobrador", codCobrador);
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
     * 0: codPerosna, 1:nombresC, 2:dniPasaporte, 3:ruc, 4:dirección,
     * 5:telefono1, 6:telefono2, 7:codDatosCliente, 8:codVentas,
     * 9:docSerieNumero, 10:fecha, 11:itemCantidad, 12:cantidadLetras,
     * 13:codVentaCreditoLetra, 14:numeroLetra, 15:detalleLetra,
     * 16:fechaVencimiento, 17:monto, 18:interes, 19:fechaPago, 20:totalPago,
     * 21:interesPagado, 22:interesUltimoCalculo
     *
     * @param fechaVencimiento
     * @param codEmpresaConvenio
     * @param tipo
     * @return
     */
    public List letrasVencidas_empresaConvenio_tipo_todos_ordenNombresC_SC(Date fechaVencimiento,
            Integer codEmpresaConvenio, Integer tipo) {
        List l = null;
        Transaction trns = null;
        sesion = HibernateUtil.getSessionFactory().openSession();
        try {
            trns = sesion.beginTransaction();
            Query q = sesion.createQuery("select dc.persona.codPersona, "
                    + "dc.persona.nombresC, dc.persona.dniPasaporte, dc.persona.ruc, "
                    + "dc.persona.direccion, dc.persona.telefono1, "
                    + "dc.persona.telefono2, dc.codDatosCliente, "
                    + "vcl.ventaCredito.ventas.codVentas, "
                    + "vcl.ventaCredito.ventas.docSerieNumero, "
                    + "vcl.ventaCredito.ventas.fecha, "
                    + "vcl.ventaCredito.ventas.itemCantidad, "
                    + "vcl.ventaCredito.cantidadLetras, vcl.codVentaCreditoLetra, "
                    + "vcl.numeroLetra, vcl.detalleLetra, vcl.fechaVencimiento, "
                    + "vcl.monto, vcl.interes, vcl.fechaPago, vcl.totalPago "
                    + " ,vcl.interesPagado, vcl.interesUltimoCalculo "
                    + "from VentaCreditoLetra vcl, DatosCliente dc "
                    + "where vcl.ventaCredito.ventas.persona=dc.persona "
                    + "and substring(vcl.registro,1,1) = 1 "
                    + "and vcl.fechaVencimiento < :fechaVencimiento "
                    + "and (vcl.monto- vcl.totalPago> 0 or vcl.interes- vcl.interesPagado> 0) "
                    + "and dc.empresaConvenio.codEmpresaConvenio = :codEmpresaConvenio "
                    + "and dc.tipo = :tipo "
                    + "order by dc.persona.nombresC, dc.codDatosCliente, vcl.ventaCredito.codVentaCredito, vcl.numeroLetra")
                    .setParameter("fechaVencimiento", fechaVencimiento)
                    .setParameter("codEmpresaConvenio", codEmpresaConvenio)
                    .setParameter("tipo", tipo);
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
     * 0: codPerosna, 1:nombresC, 2:dniPasaporte, 3:ruc, 4:dirección,
     * 5:telefono1, 6:telefono2, 7:codDatosCliente, 8:codVentas,
     * 9:docSerieNumero, 10:fecha, 11:itemCantidad, 12:cantidadLetras,
     * 13:codVentaCreditoLetra, 14:numeroLetra, 15:detalleLetra,
     * 16:fechaVencimiento, 17:monto, 18:interes, 19:fechaPago, 20:totalPago,
     * 21:interesPagado, 22:interesUltimoCalculo
     *
     * @param fechaVencimiento
     * @param codEmpresaConvenio
     * @param tipo
     * @return
     */
    public List letrasVencidas_empresaConvenio_tipo_todos_ordenDireccion_SC(Date fechaVencimiento,
            Integer codEmpresaConvenio, Integer tipo) {
        List l = null;
        Transaction trns = null;
        sesion = HibernateUtil.getSessionFactory().openSession();
        try {
            trns = sesion.beginTransaction();
            Query q = sesion.createQuery("select dc.persona.codPersona, "
                    + "dc.persona.nombresC, dc.persona.dniPasaporte, dc.persona.ruc, "
                    + "dc.persona.direccion, dc.persona.telefono1, "
                    + "dc.persona.telefono2, dc.codDatosCliente, "
                    + "vcl.ventaCredito.ventas.codVentas, "
                    + "vcl.ventaCredito.ventas.docSerieNumero, "
                    + "vcl.ventaCredito.ventas.fecha, "
                    + "vcl.ventaCredito.ventas.itemCantidad, "
                    + "vcl.ventaCredito.cantidadLetras, vcl.codVentaCreditoLetra, "
                    + "vcl.numeroLetra, vcl.detalleLetra, vcl.fechaVencimiento, "
                    + "vcl.monto, vcl.interes, vcl.fechaPago, vcl.totalPago "
                    + " ,vcl.interesPagado, vcl.interesUltimoCalculo "
                    + "from VentaCreditoLetra vcl, DatosCliente dc "
                    + "where vcl.ventaCredito.ventas.persona=dc.persona "
                    + "and substring(vcl.registro,1,1) = 1 "
                    + "and vcl.fechaVencimiento < :fechaVencimiento "
                    + "and (vcl.monto- vcl.totalPago> 0 or vcl.interes- vcl.interesPagado> 0) "
                    + "and dc.empresaConvenio.codEmpresaConvenio = :codEmpresaConvenio "
                    + "and dc.tipo = :tipo "
                    + "order by dc.persona.direccion, dc.codDatosCliente, vcl.ventaCredito.codVentaCredito, vcl.numeroLetra")
                    .setParameter("fechaVencimiento", fechaVencimiento)
                    .setParameter("codEmpresaConvenio", codEmpresaConvenio)
                    .setParameter("tipo", tipo);
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
     * 0: codPerosna, 1:nombresC, 2:dniPasaporte, 3:ruc, 4:dirección,
     * 5:telefono1, 6:telefono2, 7:codDatosCliente, 8:codVentas,
     * 9:docSerieNumero, 10:fecha, 11:itemCantidad, 12:cantidadLetras,
     * 13:codVentaCreditoLetra, 14:numeroLetra, 15:detalleLetra,
     * 16:fechaVencimiento, 17:monto, 18:interes, 19:fechaPago, 20:totalPago,
     * 21:interesPagado, 22:interesUltimoCalculo
     *
     * @param fechaVencimiento
     * @param codEmpresaConvenio
     * @param tipo
     * @param codCobrador
     * @return
     */
    public List letrasVencidas_empresaConvenio_tipo_cobrador_ordenNombresC_SC(Date fechaVencimiento,
            Integer codEmpresaConvenio, Integer tipo, Integer codCobrador) {
        List l = null;
        Transaction trns = null;
        sesion = HibernateUtil.getSessionFactory().openSession();
        try {
            trns = sesion.beginTransaction();
            Query q = sesion.createQuery("select dc.persona.codPersona, "
                    + "dc.persona.nombresC, dc.persona.dniPasaporte, dc.persona.ruc, "
                    + "dc.persona.direccion, dc.persona.telefono1, "
                    + "dc.persona.telefono2, dc.codDatosCliente, "
                    + "vcl.ventaCredito.ventas.codVentas, "
                    + "vcl.ventaCredito.ventas.docSerieNumero, "
                    + "vcl.ventaCredito.ventas.fecha, "
                    + "vcl.ventaCredito.ventas.itemCantidad, "
                    + "vcl.ventaCredito.cantidadLetras, vcl.codVentaCreditoLetra, "
                    + "vcl.numeroLetra, vcl.detalleLetra, vcl.fechaVencimiento, "
                    + "vcl.monto, vcl.interes, vcl.fechaPago, vcl.totalPago "
                    + " ,vcl.interesPagado, vcl.interesUltimoCalculo "
                    + "from VentaCreditoLetra vcl, DatosCliente dc "
                    + "where vcl.ventaCredito.ventas.persona=dc.persona "
                    + "and substring(vcl.registro,1,1) = 1 "
                    + "and vcl.fechaVencimiento < :fechaVencimiento "
                    + "and (vcl.monto- vcl.totalPago> 0 or vcl.interes- vcl.interesPagado> 0) "
                    + "and dc.empresaConvenio.codEmpresaConvenio = :codEmpresaConvenio "
                    + "and dc.codCobrador = :codCobrador "
                    + "and dc.tipo = :tipo "
                    + "order by dc.persona.nombresC, dc.codDatosCliente, vcl.ventaCredito.codVentaCredito, vcl.numeroLetra")
                    .setParameter("fechaVencimiento", fechaVencimiento)
                    .setParameter("codEmpresaConvenio", codEmpresaConvenio)
                    .setParameter("codCobrador", codCobrador)
                    .setParameter("tipo", tipo);
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
     * 0: codPerosna, 1:nombresC, 2:dniPasaporte, 3:ruc, 4:dirección,
     * 5:telefono1, 6:telefono2, 7:codDatosCliente, 8:codVentas,
     * 9:docSerieNumero, 10:fecha, 11:itemCantidad, 12:cantidadLetras,
     * 13:codVentaCreditoLetra, 14:numeroLetra, 15:detalleLetra,
     * 16:fechaVencimiento, 17:monto, 18:interes, 19:fechaPago, 20:totalPago,
     * 21:interesPagado, 22:interesUltimoCalculo
     *
     * @param fechaVencimiento
     * @param codEmpresaConvenio
     * @param tipo
     * @param codCobrador
     * @return
     */
    public List letrasVencidas_empresaConvenio_tipo_cobrador_ordenDireccion_SC(Date fechaVencimiento,
            Integer codEmpresaConvenio, Integer tipo, Integer codCobrador) {
        List l = null;
        Transaction trns = null;
        sesion = HibernateUtil.getSessionFactory().openSession();
        try {
            trns = sesion.beginTransaction();
            Query q = sesion.createQuery("select dc.persona.codPersona, "
                    + "dc.persona.nombresC, dc.persona.dniPasaporte, dc.persona.ruc, "
                    + "dc.persona.direccion, dc.persona.telefono1, "
                    + "dc.persona.telefono2, dc.codDatosCliente, "
                    + "vcl.ventaCredito.ventas.codVentas, "
                    + "vcl.ventaCredito.ventas.docSerieNumero, "
                    + "vcl.ventaCredito.ventas.fecha, "
                    + "vcl.ventaCredito.ventas.itemCantidad, "
                    + "vcl.ventaCredito.cantidadLetras, vcl.codVentaCreditoLetra, "
                    + "vcl.numeroLetra, vcl.detalleLetra, vcl.fechaVencimiento, "
                    + "vcl.monto, vcl.interes, vcl.fechaPago, vcl.totalPago "
                    + " ,vcl.interesPagado, vcl.interesUltimoCalculo "
                    + "from VentaCreditoLetra vcl, DatosCliente dc "
                    + "where vcl.ventaCredito.ventas.persona=dc.persona "
                    + "and substring(vcl.registro,1,1) = 1 "
                    + "and vcl.fechaVencimiento < :fechaVencimiento "
                    + "and (vcl.monto- vcl.totalPago> 0 or vcl.interes- vcl.interesPagado> 0) "
                    + "and dc.empresaConvenio.codEmpresaConvenio = :codEmpresaConvenio "
                    + "and dc.codCobrador = :codCobrador "
                    + "and dc.tipo = :tipo "
                    + "order by dc.persona.direccion, dc.codDatosCliente, vcl.ventaCredito.codVentaCredito, vcl.numeroLetra")
                    .setParameter("fechaVencimiento", fechaVencimiento)
                    .setParameter("codEmpresaConvenio", codEmpresaConvenio)
                    .setParameter("codCobrador", codCobrador)
                    .setParameter("tipo", tipo);
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
     * 0: codPerosna, 1:nombresC, 2:dniPasaporte, 3:ruc, 4:dirección,
     * 5:telefono1, 6:telefono2, 7:codDatosCliente, 8:codVentas,
     * 9:docSerieNumero, 10:fecha, 11:itemCantidad, 12:cantidadLetras,
     * 13:codVentaCreditoLetra, 14:numeroLetra, 15:detalleLetra,
     * 16:fechaVencimiento, 17:monto, 18:interes, 19:fechaPago, 20:totalPago,
     * 21:interesPagado, 22:interesUltimoCalculo
     *
     * @param fechaVencimiento
     * @param codEmpresaConvenio
     * @param tipo
     * @param condicion
     * @return
     */
    public List letrasVencidas_empresaConvenio_tipo_condicion_todos_ordenNombresC_SC(Date fechaVencimiento,
            Integer codEmpresaConvenio, Integer tipo, Integer condicion) {
        List l = null;
        Transaction trns = null;
        sesion = HibernateUtil.getSessionFactory().openSession();
        try {
            trns = sesion.beginTransaction();
            Query q = sesion.createQuery("select dc.persona.codPersona, "
                    + "dc.persona.nombresC, dc.persona.dniPasaporte, dc.persona.ruc, "
                    + "dc.persona.direccion, dc.persona.telefono1, "
                    + "dc.persona.telefono2, dc.codDatosCliente, "
                    + "vcl.ventaCredito.ventas.codVentas, "
                    + "vcl.ventaCredito.ventas.docSerieNumero, "
                    + "vcl.ventaCredito.ventas.fecha, "
                    + "vcl.ventaCredito.ventas.itemCantidad, "
                    + "vcl.ventaCredito.cantidadLetras, vcl.codVentaCreditoLetra, "
                    + "vcl.numeroLetra, vcl.detalleLetra, vcl.fechaVencimiento, "
                    + "vcl.monto, vcl.interes, vcl.fechaPago, vcl.totalPago "
                    + " ,vcl.interesPagado, vcl.interesUltimoCalculo "
                    + "from VentaCreditoLetra vcl, DatosCliente dc "
                    + "where vcl.ventaCredito.ventas.persona=dc.persona "
                    + "and substring(vcl.registro,1,1) = 1 "
                    + "and vcl.fechaVencimiento < :fechaVencimiento "
                    + "and (vcl.monto- vcl.totalPago> 0 or vcl.interes- vcl.interesPagado> 0) "
                    + "and dc.empresaConvenio.codEmpresaConvenio = :codEmpresaConvenio "
                    + "and dc.tipo = :tipo "
                    + "and dc.condicion = :condicion "
                    + "order by dc.persona.nombresC, dc.codDatosCliente, vcl.ventaCredito.codVentaCredito, vcl.numeroLetra")
                    .setParameter("fechaVencimiento", fechaVencimiento)
                    .setParameter("codEmpresaConvenio", codEmpresaConvenio)
                    .setParameter("tipo", tipo)
                    .setParameter("condicion", condicion);
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
     * 0: codPerosna, 1:nombresC, 2:dniPasaporte, 3:ruc, 4:dirección,
     * 5:telefono1, 6:telefono2, 7:codDatosCliente, 8:codVentas,
     * 9:docSerieNumero, 10:fecha, 11:itemCantidad, 12:cantidadLetras,
     * 13:codVentaCreditoLetra, 14:numeroLetra, 15:detalleLetra,
     * 16:fechaVencimiento, 17:monto, 18:interes, 19:fechaPago, 20:totalPago,
     * 21:interesPagado, 22:interesUltimoCalculo
     *
     * @param fechaVencimiento
     * @param codEmpresaConvenio
     * @param tipo
     * @param condicion
     * @return
     */
    public List letrasVencidas_empresaConvenio_tipo_condicion_todos_ordenDireccion_SC(Date fechaVencimiento,
            Integer codEmpresaConvenio, Integer tipo, Integer condicion) {
        List l = null;
        Transaction trns = null;
        sesion = HibernateUtil.getSessionFactory().openSession();
        try {
            trns = sesion.beginTransaction();
            Query q = sesion.createQuery("select dc.persona.codPersona, "
                    + "dc.persona.nombresC, dc.persona.dniPasaporte, dc.persona.ruc, "
                    + "dc.persona.direccion, dc.persona.telefono1, "
                    + "dc.persona.telefono2, dc.codDatosCliente, "
                    + "vcl.ventaCredito.ventas.codVentas, "
                    + "vcl.ventaCredito.ventas.docSerieNumero, "
                    + "vcl.ventaCredito.ventas.fecha, "
                    + "vcl.ventaCredito.ventas.itemCantidad, "
                    + "vcl.ventaCredito.cantidadLetras, vcl.codVentaCreditoLetra, "
                    + "vcl.numeroLetra, vcl.detalleLetra, vcl.fechaVencimiento, "
                    + "vcl.monto, vcl.interes, vcl.fechaPago, vcl.totalPago "
                    + " ,vcl.interesPagado, vcl.interesUltimoCalculo "
                    + "from VentaCreditoLetra vcl, DatosCliente dc "
                    + "where vcl.ventaCredito.ventas.persona=dc.persona "
                    + "and substring(vcl.registro,1,1) = 1 "
                    + "and vcl.fechaVencimiento < :fechaVencimiento "
                    + "and (vcl.monto- vcl.totalPago> 0 or vcl.interes- vcl.interesPagado> 0) "
                    + "and dc.empresaConvenio.codEmpresaConvenio = :codEmpresaConvenio "
                    + "and dc.tipo = :tipo "
                    + "and dc.condicion = :condicion "
                    + "order by dc.persona.direccion, dc.codDatosCliente, vcl.ventaCredito.codVentaCredito, vcl.numeroLetra")
                    .setParameter("fechaVencimiento", fechaVencimiento)
                    .setParameter("codEmpresaConvenio", codEmpresaConvenio)
                    .setParameter("tipo", tipo)
                    .setParameter("condicion", condicion);
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
     * 0: codPerosna, 1:nombresC, 2:dniPasaporte, 3:ruc, 4:dirección,
     * 5:telefono1, 6:telefono2, 7:codDatosCliente, 8:codVentas,
     * 9:docSerieNumero, 10:fecha, 11:itemCantidad, 12:cantidadLetras,
     * 13:codVentaCreditoLetra, 14:numeroLetra, 15:detalleLetra,
     * 16:fechaVencimiento, 17:monto, 18:interes, 19:fechaPago, 20:totalPago,
     * 21:interesPagado, 22:interesUltimoCalculo
     *
     * @param fechaVencimiento
     * @param codEmpresaConvenio
     * @param tipo
     * @param condicion
     * @param codCobrador
     * @return
     */
    public List letrasVencidas_empresaConvenio_tipo_condicion_cobrador_ordenNombresC_SC(Date fechaVencimiento,
            Integer codEmpresaConvenio, Integer tipo, Integer condicion, Integer codCobrador) {
        List l = null;
        Transaction trns = null;
        sesion = HibernateUtil.getSessionFactory().openSession();
        try {
            trns = sesion.beginTransaction();
            Query q = sesion.createQuery("select dc.persona.codPersona, "
                    + "dc.persona.nombresC, dc.persona.dniPasaporte, dc.persona.ruc, "
                    + "dc.persona.direccion, dc.persona.telefono1, "
                    + "dc.persona.telefono2, dc.codDatosCliente, "
                    + "vcl.ventaCredito.ventas.codVentas, "
                    + "vcl.ventaCredito.ventas.docSerieNumero, "
                    + "vcl.ventaCredito.ventas.fecha, "
                    + "vcl.ventaCredito.ventas.itemCantidad, "
                    + "vcl.ventaCredito.cantidadLetras, vcl.codVentaCreditoLetra, "
                    + "vcl.numeroLetra, vcl.detalleLetra, vcl.fechaVencimiento, "
                    + "vcl.monto, vcl.interes, vcl.fechaPago, vcl.totalPago "
                    + " ,vcl.interesPagado, vcl.interesUltimoCalculo "
                    + "from VentaCreditoLetra vcl, DatosCliente dc "
                    + "where vcl.ventaCredito.ventas.persona=dc.persona "
                    + "and substring(vcl.registro,1,1) = 1 "
                    + "and vcl.fechaVencimiento < :fechaVencimiento "
                    + "and (vcl.monto- vcl.totalPago> 0 or vcl.interes- vcl.interesPagado> 0) "
                    + "and dc.empresaConvenio.codEmpresaConvenio = :codEmpresaConvenio "
                    + "and dc.codCobrador = :codCobrador "
                    + "and dc.tipo = :tipo "
                    + "and dc.condicion = :condicion "
                    + "order by dc.persona.nombresC, dc.codDatosCliente, vcl.ventaCredito.codVentaCredito, vcl.numeroLetra")
                    .setParameter("fechaVencimiento", fechaVencimiento)
                    .setParameter("codEmpresaConvenio", codEmpresaConvenio)
                    .setParameter("codCobrador", codCobrador)
                    .setParameter("tipo", tipo)
                    .setParameter("condicion", condicion);
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
     * 0: codPerosna, 1:nombresC, 2:dniPasaporte, 3:ruc, 4:dirección,
     * 5:telefono1, 6:telefono2, 7:codDatosCliente, 8:codVentas,
     * 9:docSerieNumero, 10:fecha, 11:itemCantidad, 12:cantidadLetras,
     * 13:codVentaCreditoLetra, 14:numeroLetra, 15:detalleLetra,
     * 16:fechaVencimiento, 17:monto, 18:interes, 19:fechaPago, 20:totalPago,
     * 21:interesPagado, 22:interesUltimoCalculo
     *
     * @param fechaVencimiento
     * @param codEmpresaConvenio
     * @param tipo
     * @param condicion
     * @param codCobrador
     * @return
     */
    public List letrasVencidas_empresaConvenio_tipo_condicion_cobrador_ordenDireccion_SC(Date fechaVencimiento,
            Integer codEmpresaConvenio, Integer tipo, Integer condicion, Integer codCobrador) {
        List l = null;
        Transaction trns = null;
        sesion = HibernateUtil.getSessionFactory().openSession();
        try {
            trns = sesion.beginTransaction();
            Query q = sesion.createQuery("select dc.persona.codPersona, "
                    + "dc.persona.nombresC, dc.persona.dniPasaporte, dc.persona.ruc, "
                    + "dc.persona.direccion, dc.persona.telefono1, "
                    + "dc.persona.telefono2, dc.codDatosCliente, "
                    + "vcl.ventaCredito.ventas.codVentas, "
                    + "vcl.ventaCredito.ventas.docSerieNumero, "
                    + "vcl.ventaCredito.ventas.fecha, "
                    + "vcl.ventaCredito.ventas.itemCantidad, "
                    + "vcl.ventaCredito.cantidadLetras, vcl.codVentaCreditoLetra, "
                    + "vcl.numeroLetra, vcl.detalleLetra, vcl.fechaVencimiento, "
                    + "vcl.monto, vcl.interes, vcl.fechaPago, vcl.totalPago "
                    + " ,vcl.interesPagado, vcl.interesUltimoCalculo "
                    + "from VentaCreditoLetra vcl, DatosCliente dc "
                    + "where vcl.ventaCredito.ventas.persona=dc.persona "
                    + "and substring(vcl.registro,1,1) = 1 "
                    + "and vcl.fechaVencimiento < :fechaVencimiento "
                    + "and (vcl.monto- vcl.totalPago> 0 or vcl.interes- vcl.interesPagado> 0) "
                    + "and dc.empresaConvenio.codEmpresaConvenio = :codEmpresaConvenio "
                    + "and dc.codCobrador = :codCobrador "
                    + "and dc.tipo = :tipo "
                    + "and dc.condicion = :condicion "
                    + "order by dc.persona.direccion, dc.codDatosCliente, vcl.ventaCredito.codVentaCredito, vcl.numeroLetra")
                    .setParameter("fechaVencimiento", fechaVencimiento)
                    .setParameter("codEmpresaConvenio", codEmpresaConvenio)
                    .setParameter("codCobrador", codCobrador)
                    .setParameter("tipo", tipo).
                    setParameter("condicion", condicion);
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

    //REPORTES A EXCEL
    /**
     * Obtener todas las deudas por cliente hasta un perido dado. 0:nombresC,
     * 1:dni, 2:ruc, 3:codDatosCliente, 4:monto
     *
     * @param fechaVencimiento
     * @return
     */
    public List letrasVencidasSuma_todos_ordenNombresC_SC(Date fechaVencimiento) {
        List l = null;
        Transaction trns = null;
        sesion = HibernateUtil.getSessionFactory().openSession();
        try {
            trns = sesion.beginTransaction();
            Query q = sesion.createQuery("select vcl.ventaCredito.ventas.persona.nombresC,"
                    + "	vcl.ventaCredito.ventas.persona.dniPasaporte,"
                    + "	vcl.ventaCredito.ventas.persona.ruc,"
                    + "	dc.codDatosCliente,"
                    + "	sum(vcl.monto-vcl.totalPago)"
                    + " from VentaCreditoLetra vcl, DatosCliente dc"
                    + " where vcl.ventaCredito.ventas.persona=dc.persona"
                    + "	and (vcl.monto-vcl.totalPago) > 0"
                    + "	and substring(vcl.registro,1,1) = 1"
                    + "	and vcl.fechaVencimiento <= :par1"
                    + " group by dc.codDatosCliente"
                    + " order by vcl.ventaCredito.ventas.persona.nombresC, dc.codDatosCliente")
                    .setDate("par1", fechaVencimiento);
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
     * Obtener todas las deudas por cliente hasta un perido dado. 0:nombresC,
     * 1:dni, 2:ruc, 3:codDatosCliente, 4:monto
     *
     * @param fechaVencimiento
     * @return
     */
    public List letrasVencidasSuma_todos_ordenDireccion_SC(Date fechaVencimiento) {
        List l = null;
        Transaction trns = null;
        sesion = HibernateUtil.getSessionFactory().openSession();
        try {
            trns = sesion.beginTransaction();
            Query q = sesion.createQuery("select vcl.ventaCredito.ventas.persona.nombresC,"
                    + "	vcl.ventaCredito.ventas.persona.dniPasaporte,"
                    + "	vcl.ventaCredito.ventas.persona.ruc,"
                    + "	dc.codDatosCliente,"
                    + "	sum(vcl.monto-vcl.totalPago)"
                    + " from VentaCreditoLetra vcl, DatosCliente dc"
                    + " where vcl.ventaCredito.ventas.persona=dc.persona"
                    + "	and (vcl.monto-vcl.totalPago) > 0"
                    + "	and substring(vcl.registro,1,1) = 1"
                    + "	and vcl.fechaVencimiento <= :par1"
                    + " group by dc.codDatosCliente"
                    + " order by vcl.ventaCredito.ventas.persona.direccion, dc.codDatosCliente")
                    .setDate("par1", fechaVencimiento);
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
     * Obtener todas las deudas por cliente hasta un perido dado. 0:nombresC,
     * 1:dni, 2:ruc, 3:codDatosCliente, 4:monto
     *
     * @param fechaVencimiento
     * @param codCobrador
     * @return
     */
    public List letrasVencidasSuma_cobrador_ordenNombresC_SC(Date fechaVencimiento,
            Integer codCobrador) {
        List l = null;
        Transaction trns = null;
        sesion = HibernateUtil.getSessionFactory().openSession();
        try {
            trns = sesion.beginTransaction();
            Query q = sesion.createQuery("select vcl.ventaCredito.ventas.persona.nombresC,"
                    + "	vcl.ventaCredito.ventas.persona.dniPasaporte,"
                    + "	vcl.ventaCredito.ventas.persona.ruc,"
                    + "	dc.codDatosCliente,"
                    + "	sum(vcl.monto-vcl.totalPago)"
                    + " from VentaCreditoLetra vcl, DatosCliente dc"
                    + " where vcl.ventaCredito.ventas.persona=dc.persona"
                    + "	and (vcl.monto-vcl.totalPago) > 0"
                    + "	and substring(vcl.registro,1,1) = 1"
                    + "	and vcl.fechaVencimiento <= :par1"
                    + " and dc.codCobrador = :par2"
                    + " group by dc.codDatosCliente"
                    + " order by vcl.ventaCredito.ventas.persona.nombresC,"
                    + " dc.codDatosCliente")
                    .setDate("par1", fechaVencimiento)
                    .setInteger("par2", codCobrador);
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
     * Obtener todas las deudas por cliente hasta un perido dado. 0:nombresC,
     * 1:dni, 2:ruc, 3:codDatosCliente, 4:monto
     *
     * @param fechaVencimiento
     * @param codCobrador
     * @return
     */
    public List letrasVencidasSuma_cobrador_ordenDireccion_SC(Date fechaVencimiento,
            Integer codCobrador) {
        List l = null;
        Transaction trns = null;
        sesion = HibernateUtil.getSessionFactory().openSession();
        try {
            trns = sesion.beginTransaction();
            Query q = sesion.createQuery("select vcl.ventaCredito.ventas.persona.nombresC,"
                    + "	vcl.ventaCredito.ventas.persona.dniPasaporte,"
                    + "	vcl.ventaCredito.ventas.persona.ruc,"
                    + "	dc.codDatosCliente,"
                    + "	sum(vcl.monto-vcl.totalPago)"
                    + " from VentaCreditoLetra vcl, DatosCliente dc"
                    + " where vcl.ventaCredito.ventas.persona=dc.persona"
                    + "	and (vcl.monto-vcl.totalPago) > 0"
                    + "	and substring(vcl.registro,1,1) = 1"
                    + "	and vcl.fechaVencimiento <= :par1"
                    + " and dc.codCobrador = :par2"
                    + " group by dc.codDatosCliente"
                    + " order by vcl.ventaCredito.ventas.persona.direccion,"
                    + " dc.codDatosCliente")
                    .setDate("par1", fechaVencimiento)
                    .setInteger("par2", codCobrador);
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
     * Obtener todas las deudas por cliente hasta un perido dado. 0:nombresC,
     * 1:dni, 2:ruc, 3:codDatosCliente, 4:monto
     *
     * @param fechaVencimiento
     * @param codEmpresaConvenio
     * @return
     */
    public List letrasVencidasSuma_empresaConvenio_todos_ordenNombresC_SC(Date fechaVencimiento,
            int codEmpresaConvenio) {
        List l = null;
        Transaction trns = null;
        sesion = HibernateUtil.getSessionFactory().openSession();
        try {
            trns = sesion.beginTransaction();
            Query q = sesion.createQuery("select vcl.ventaCredito.ventas.persona.nombresC,"
                    + "	vcl.ventaCredito.ventas.persona.dniPasaporte,"
                    + "	vcl.ventaCredito.ventas.persona.ruc,"
                    + "	dc.codDatosCliente,"
                    + "	sum(vcl.monto-vcl.totalPago)"
                    + " from VentaCreditoLetra vcl, DatosCliente dc"
                    + " where vcl.ventaCredito.ventas.persona=dc.persona"
                    + "	and (vcl.monto-vcl.totalPago) > 0"
                    + "	and substring(vcl.registro,1,1) = 1"
                    + "	and vcl.fechaVencimiento <= :par1"
                    + " and dc.empresaConvenio.codEmpresaConvenio = :par2"
                    + " group by dc.codDatosCliente"
                    + " order by vcl.ventaCredito.ventas.persona.nombresC, dc.codDatosCliente")
                    .setDate("par1", fechaVencimiento)
                    .setInteger("par2", codEmpresaConvenio);
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
     * Obtener todas las deudas por cliente hasta un perido dado. 0:nombresC,
     * 1:dni, 2:ruc, 3:codDatosCliente, 4:monto
     *
     * @param fechaVencimiento
     * @param codEmpresaConvenio
     * @return
     */
    public List letrasVencidasSuma_empresaConvenio_todos_ordenDireccion_SC(Date fechaVencimiento,
            int codEmpresaConvenio) {
        List l = null;
        Transaction trns = null;
        sesion = HibernateUtil.getSessionFactory().openSession();
        try {
            trns = sesion.beginTransaction();
            Query q = sesion.createQuery("select vcl.ventaCredito.ventas.persona.nombresC,"
                    + "	vcl.ventaCredito.ventas.persona.dniPasaporte,"
                    + "	vcl.ventaCredito.ventas.persona.ruc,"
                    + "	dc.codDatosCliente,"
                    + "	sum(vcl.monto-vcl.totalPago)"
                    + " from VentaCreditoLetra vcl, DatosCliente dc"
                    + " where vcl.ventaCredito.ventas.persona=dc.persona"
                    + "	and (vcl.monto-vcl.totalPago) > 0"
                    + "	and substring(vcl.registro,1,1) = 1"
                    + "	and vcl.fechaVencimiento <= :par1"
                    + " and dc.empresaConvenio.codEmpresaConvenio = :par2"
                    + " group by dc.codDatosCliente"
                    + " order by vcl.ventaCredito.ventas.persona.direccion, dc.codDatosCliente")
                    .setDate("par1", fechaVencimiento)
                    .setInteger("par2", codEmpresaConvenio);
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
     * Obtener todas las deudas por cliente hasta un perido dado. 0:nombresC,
     * 1:dni, 2:ruc, 3:codDatosCliente, 4:monto
     *
     * @param fechaVencimiento
     * @param codEmpresaConvenio
     * @param codCobrador
     * @return
     */
    public List letrasVencidasSuma_empresaConvenio_cobrador_ordenNombresC_SC(Date fechaVencimiento,
            int codEmpresaConvenio, int codCobrador) {
        List l = null;
        Transaction trns = null;
        sesion = HibernateUtil.getSessionFactory().openSession();
        try {
            trns = sesion.beginTransaction();
            Query q = sesion.createQuery("select vcl.ventaCredito.ventas.persona.nombresC,"
                    + "	vcl.ventaCredito.ventas.persona.dniPasaporte,"
                    + "	vcl.ventaCredito.ventas.persona.ruc,"
                    + "	dc.codDatosCliente,"
                    + "	sum(vcl.monto-vcl.totalPago)"
                    + " from VentaCreditoLetra vcl, DatosCliente dc"
                    + " where vcl.ventaCredito.ventas.persona=dc.persona"
                    + "	and (vcl.monto-vcl.totalPago) > 0"
                    + "	and substring(vcl.registro,1,1) = 1"
                    + "	and vcl.fechaVencimiento <= :par1"
                    + " and dc.empresaConvenio.codEmpresaConvenio = :par2"
                    + " and dc.codCobrador = :par3"
                    + " group by dc.codDatosCliente"
                    + " order by vcl.ventaCredito.ventas.persona.nombresC, dc.codDatosCliente")
                    .setDate("par1", fechaVencimiento)
                    .setInteger("par2", codEmpresaConvenio)
                    .setInteger("par3", codCobrador);
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
     * Obtener todas las deudas por cliente hasta un perido dado. 0:nombresC,
     * 1:dni, 2:ruc, 3:codDatosCliente, 4:monto
     *
     * @param fechaVencimiento
     * @param codEmpresaConvenio
     * @param codCobrador
     * @return
     */
    public List letrasVencidasSuma_empresaConvenio_cobrador_ordenDireccion_SC(Date fechaVencimiento,
            int codEmpresaConvenio, int codCobrador) {
        List l = null;
        Transaction trns = null;
        sesion = HibernateUtil.getSessionFactory().openSession();
        try {
            trns = sesion.beginTransaction();
            Query q = sesion.createQuery("select vcl.ventaCredito.ventas.persona.nombresC,"
                    + "	vcl.ventaCredito.ventas.persona.dniPasaporte,"
                    + "	vcl.ventaCredito.ventas.persona.ruc,"
                    + "	dc.codDatosCliente,"
                    + "	sum(vcl.monto-vcl.totalPago)"
                    + " from VentaCreditoLetra vcl, DatosCliente dc"
                    + " where vcl.ventaCredito.ventas.persona=dc.persona"
                    + "	and (vcl.monto-vcl.totalPago) > 0"
                    + "	and substring(vcl.registro,1,1) = 1"
                    + "	and vcl.fechaVencimiento <= :par1"
                    + " and dc.empresaConvenio.codEmpresaConvenio = :par2"
                    + " and dc.codCobrador = :par3"
                    + " group by dc.codDatosCliente"
                    + " order by vcl.ventaCredito.ventas.persona.direccion, dc.codDatosCliente")
                    .setDate("par1", fechaVencimiento)
                    .setInteger("par2", codEmpresaConvenio)
                    .setInteger("par3", codCobrador);
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
     * Obtener todas las deudas por cliente hasta un perido dado. 0:nombresC,
     * 1:dni, 2:ruc, 3:codDatosCliente, 4:monto
     *
     * @param fechaVencimiento
     * @param codEmpresaConvenio
     * @param tipo
     * @return
     */
    public List letrasVencidasSuma_empresaConvenio_tipo_todos_ordenNombresC_SC(Date fechaVencimiento,
            int codEmpresaConvenio, int tipo) {
        List l = null;
        Transaction trns = null;
        sesion = HibernateUtil.getSessionFactory().openSession();
        try {
            trns = sesion.beginTransaction();
            Query q = sesion.createQuery("select vcl.ventaCredito.ventas.persona.nombresC,"
                    + "	vcl.ventaCredito.ventas.persona.dniPasaporte,"
                    + "	vcl.ventaCredito.ventas.persona.ruc,"
                    + "	dc.codDatosCliente,"
                    + "	sum(vcl.monto-vcl.totalPago)"
                    + " from VentaCreditoLetra vcl, DatosCliente dc"
                    + " where vcl.ventaCredito.ventas.persona=dc.persona"
                    + "	and (vcl.monto-vcl.totalPago) > 0"
                    + "	and substring(vcl.registro,1,1) = 1"
                    + "	and vcl.fechaVencimiento <= :par1"
                    + " and dc.empresaConvenio.codEmpresaConvenio = :par2"
                    + " and dc.tipo = :par3"
                    + " group by dc.codDatosCliente"
                    + " order by vcl.ventaCredito.ventas.persona.nombresC, dc.codDatosCliente")
                    .setDate("par1", fechaVencimiento)
                    .setInteger("par2", codEmpresaConvenio)
                    .setInteger("par3", tipo);
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
     * Obtener todas las deudas por cliente hasta un perido dado. 0:nombresC,
     * 1:dni, 2:ruc, 3:codDatosCliente, 4:monto
     *
     * @param fechaVencimiento
     * @param codEmpresaConvenio
     * @param tipo
     * @return
     */
    public List letrasVencidasSuma_empresaConvenio_tipo_todos_ordenDireccion_SC(Date fechaVencimiento,
            int codEmpresaConvenio, int tipo) {
        List l = null;
        Transaction trns = null;
        sesion = HibernateUtil.getSessionFactory().openSession();
        try {
            trns = sesion.beginTransaction();
            Query q = sesion.createQuery("select vcl.ventaCredito.ventas.persona.nombresC,"
                    + "	vcl.ventaCredito.ventas.persona.dniPasaporte,"
                    + "	vcl.ventaCredito.ventas.persona.ruc,"
                    + "	dc.codDatosCliente,"
                    + "	sum(vcl.monto-vcl.totalPago)"
                    + " from VentaCreditoLetra vcl, DatosCliente dc"
                    + " where vcl.ventaCredito.ventas.persona=dc.persona"
                    + "	and (vcl.monto-vcl.totalPago) > 0"
                    + "	and substring(vcl.registro,1,1) = 1"
                    + "	and vcl.fechaVencimiento <= :par1"
                    + " and dc.empresaConvenio.codEmpresaConvenio = :par2"
                    + " and dc.tipo = :par3"
                    + " group by dc.codDatosCliente"
                    + " order by vcl.ventaCredito.ventas.persona.direccion, dc.codDatosCliente")
                    .setDate("par1", fechaVencimiento)
                    .setInteger("par2", codEmpresaConvenio)
                    .setInteger("par3", tipo);
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
     * Obtener todas las deudas por cliente hasta un perido dado. 0:nombresC,
     * 1:dni, 2:ruc, 3:codDatosCliente, 4:monto
     *
     * @param fechaVencimiento
     * @param codEmpresaConvenio
     * @param tipo
     * @param codCobrador
     * @return
     */
    public List letrasVencidasSuma_empresaConvenio_tipo_cobrador_ordenNombresC_SC(Date fechaVencimiento,
            int codEmpresaConvenio, int tipo, int codCobrador) {
        List l = null;
        Transaction trns = null;
        sesion = HibernateUtil.getSessionFactory().openSession();
        try {
            trns = sesion.beginTransaction();
            Query q = sesion.createQuery("select vcl.ventaCredito.ventas.persona.nombresC,"
                    + "	vcl.ventaCredito.ventas.persona.dniPasaporte,"
                    + "	vcl.ventaCredito.ventas.persona.ruc,"
                    + "	dc.codDatosCliente,"
                    + "	sum(vcl.monto-vcl.totalPago)"
                    + " from VentaCreditoLetra vcl, DatosCliente dc"
                    + " where vcl.ventaCredito.ventas.persona=dc.persona"
                    + "	and (vcl.monto-vcl.totalPago) > 0"
                    + "	and substring(vcl.registro,1,1) = 1"
                    + "	and vcl.fechaVencimiento <= :par1"
                    + " and dc.empresaConvenio.codEmpresaConvenio = :par2"
                    + " and dc.tipo = :par3"
                    + " and dc.codCobrador = :par4"
                    + " group by dc.codDatosCliente"
                    + " order by vcl.ventaCredito.ventas.persona.nombresC, dc.codDatosCliente")
                    .setDate("par1", fechaVencimiento)
                    .setInteger("par2", codEmpresaConvenio)
                    .setInteger("par3", tipo)
                    .setInteger("par4", codCobrador);
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
     * Obtener todas las deudas por cliente hasta un perido dado. 0:nombresC,
     * 1:dni, 2:ruc, 3:codDatosCliente, 4:monto
     *
     * @param fechaVencimiento
     * @param codEmpresaConvenio
     * @param tipo
     * @param codCobrador
     * @return
     */
    public List letrasVencidasSuma_empresaConvenio_tipo_cobrador_ordenDireccion_SC(Date fechaVencimiento,
            int codEmpresaConvenio, int tipo, int codCobrador) {
        List l = null;
        Transaction trns = null;
        sesion = HibernateUtil.getSessionFactory().openSession();
        try {
            trns = sesion.beginTransaction();
            Query q = sesion.createQuery("select vcl.ventaCredito.ventas.persona.nombresC,"
                    + "	vcl.ventaCredito.ventas.persona.dniPasaporte,"
                    + "	vcl.ventaCredito.ventas.persona.ruc,"
                    + "	dc.codDatosCliente,"
                    + "	sum(vcl.monto-vcl.totalPago)"
                    + " from VentaCreditoLetra vcl, DatosCliente dc"
                    + " where vcl.ventaCredito.ventas.persona=dc.persona"
                    + "	and (vcl.monto-vcl.totalPago) > 0"
                    + "	and substring(vcl.registro,1,1) = 1"
                    + "	and vcl.fechaVencimiento <= :par1"
                    + " and dc.empresaConvenio.codEmpresaConvenio = :par2"
                    + " and dc.tipo = :par3"
                    + " and dc.codCobrador = :par4"
                    + " group by dc.codDatosCliente"
                    + " order by vcl.ventaCredito.ventas.persona.direccion, dc.codDatosCliente")
                    .setDate("par1", fechaVencimiento)
                    .setInteger("par2", codEmpresaConvenio)
                    .setInteger("par3", tipo)
                    .setInteger("par4", codCobrador);
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
     * Obtener todas las deudas por cliente hasta un perido dado. 0:nombresC,
     * 1:dni, 2:ruc, 3:codDatosCliente, 4:monto
     *
     * @param fechaVencimiento
     * @param codEmpresaConvenio
     * @param tipo
     * @param condicion
     * @return
     */
    public List letrasVencidasSuma_empresaConvenio_tipo_condicion_todos_ordenNombresC_SC(Date fechaVencimiento,
            int codEmpresaConvenio, int tipo, int condicion) {
        List l = null;
        Transaction trns = null;
        sesion = HibernateUtil.getSessionFactory().openSession();
        try {
            trns = sesion.beginTransaction();
            Query q = sesion.createQuery("select vcl.ventaCredito.ventas.persona.nombresC,"
                    + "	vcl.ventaCredito.ventas.persona.dniPasaporte,"
                    + "	vcl.ventaCredito.ventas.persona.ruc,"
                    + "	dc.codDatosCliente,"
                    + "	sum(vcl.monto-vcl.totalPago)"
                    + " from VentaCreditoLetra vcl, DatosCliente dc"
                    + " where vcl.ventaCredito.ventas.persona=dc.persona"
                    + "	and (vcl.monto-vcl.totalPago) > 0"
                    + "	and substring(vcl.registro,1,1) = 1"
                    + "	and vcl.fechaVencimiento <= :par1"
                    + " and dc.empresaConvenio.codEmpresaConvenio = :par2"
                    + " and dc.tipo = :par3"
                    + " and dc.condicion = :par4"
                    + " group by dc.codDatosCliente"
                    + " order by vcl.ventaCredito.ventas.persona.nombresC, dc.codDatosCliente")
                    .setDate("par1", fechaVencimiento)
                    .setInteger("par2", codEmpresaConvenio)
                    .setInteger("par3", tipo)
                    .setInteger("par4", condicion);
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
     * Obtener todas las deudas por cliente hasta un perido dado. 0:nombresC,
     * 1:dni, 2:ruc, 3:codDatosCliente, 4:monto
     *
     * @param fechaVencimiento
     * @param codEmpresaConvenio
     * @param tipo
     * @param condicion
     * @return
     */
    public List letrasVencidasSuma_empresaConvenio_tipo_condicion_todos_ordenDireccion_SC(Date fechaVencimiento,
            int codEmpresaConvenio, int tipo, int condicion) {
        List l = null;
        Transaction trns = null;
        sesion = HibernateUtil.getSessionFactory().openSession();
        try {
            trns = sesion.beginTransaction();
            Query q = sesion.createQuery("select vcl.ventaCredito.ventas.persona.nombresC,"
                    + "	vcl.ventaCredito.ventas.persona.dniPasaporte,"
                    + "	vcl.ventaCredito.ventas.persona.ruc,"
                    + "	dc.codDatosCliente,"
                    + "	sum(vcl.monto-vcl.totalPago)"
                    + " from VentaCreditoLetra vcl, DatosCliente dc"
                    + " where vcl.ventaCredito.ventas.persona=dc.persona"
                    + "	and (vcl.monto-vcl.totalPago) > 0"
                    + "	and substring(vcl.registro,1,1) = 1"
                    + "	and vcl.fechaVencimiento <= :par1"
                    + " and dc.empresaConvenio.codEmpresaConvenio = :par2"
                    + " and dc.tipo = :par3"
                    + " and dc.condicion = :par4"
                    + " group by dc.codDatosCliente"
                    + " order by vcl.ventaCredito.ventas.persona.direccion, dc.codDatosCliente")
                    .setDate("par1", fechaVencimiento)
                    .setInteger("par2", codEmpresaConvenio)
                    .setInteger("par3", tipo)
                    .setInteger("par4", condicion);
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
     * Obtener todas las deudas por cliente hasta un perido dado. 0:nombresC,
     * 1:dni, 2:ruc, 3:codDatosCliente, 4:monto
     *
     * @param fechaVencimiento
     * @param codEmpresaConvenio
     * @param tipo
     * @param condicion
     * @param codCobrador
     * @return
     */
    public List letrasVencidasSuma_empresaConvenio_tipo_condicion_cobrador_ordenNombresC_SC(Date fechaVencimiento,
            int codEmpresaConvenio, int tipo, int condicion, int codCobrador) {
        List l = null;
        Transaction trns = null;
        sesion = HibernateUtil.getSessionFactory().openSession();
        try {
            trns = sesion.beginTransaction();
            Query q = sesion.createQuery("select vcl.ventaCredito.ventas.persona.nombresC,"
                    + "	vcl.ventaCredito.ventas.persona.dniPasaporte,"
                    + "	vcl.ventaCredito.ventas.persona.ruc,"
                    + "	dc.codDatosCliente,"
                    + "	sum(vcl.monto-vcl.totalPago)"
                    + " from VentaCreditoLetra vcl, DatosCliente dc"
                    + " where vcl.ventaCredito.ventas.persona=dc.persona"
                    + "	and (vcl.monto-vcl.totalPago) > 0"
                    + "	and substring(vcl.registro,1,1) = 1"
                    + "	and vcl.fechaVencimiento <= :par1"
                    + " and dc.empresaConvenio.codEmpresaConvenio = :par2"
                    + " and dc.tipo = :par3"
                    + " and dc.condicion = :par4"
                    + " and dc.codCobrador = :par5"
                    + " group by dc.codDatosCliente"
                    + " order by vcl.ventaCredito.ventas.persona.nombresC, dc.codDatosCliente")
                    .setDate("par1", fechaVencimiento)
                    .setInteger("par2", codEmpresaConvenio)
                    .setInteger("par3", tipo)
                    .setInteger("par4", condicion)
                    .setInteger("par5", codCobrador);
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
     * Obtener todas las deudas por cliente hasta un perido dado. 0:nombresC,
     * 1:dni, 2:ruc, 3:codDatosCliente, 4:monto
     *
     * @param fechaVencimiento
     * @param codEmpresaConvenio
     * @param tipo
     * @param condicion
     * @param codCobrador
     * @return
     */
    public List letrasVencidasSuma_empresaConvenio_tipo_condicion_cobrador_ordenDireccion_SC(Date fechaVencimiento,
            int codEmpresaConvenio, int tipo, int condicion, int codCobrador) {
        List l = null;
        Transaction trns = null;
        sesion = HibernateUtil.getSessionFactory().openSession();
        try {
            trns = sesion.beginTransaction();
            Query q = sesion.createQuery("select vcl.ventaCredito.ventas.persona.nombresC,"
                    + "	vcl.ventaCredito.ventas.persona.dniPasaporte,"
                    + "	vcl.ventaCredito.ventas.persona.ruc,"
                    + "	dc.codDatosCliente,"
                    + "	sum(vcl.monto-vcl.totalPago)"
                    + " from VentaCreditoLetra vcl, DatosCliente dc"
                    + " where vcl.ventaCredito.ventas.persona=dc.persona"
                    + "	and (vcl.monto-vcl.totalPago) > 0"
                    + "	and substring(vcl.registro,1,1) = 1"
                    + "	and vcl.fechaVencimiento <= :par1"
                    + " and dc.empresaConvenio.codEmpresaConvenio = :par2"
                    + " and dc.tipo = :par3"
                    + " and dc.condicion = :par4"
                    + " and dc.codCobrador = :par5"
                    + " group by dc.codDatosCliente"
                    + " order by vcl.ventaCredito.ventas.persona.direccion, dc.codDatosCliente")
                    .setDate("par1", fechaVencimiento)
                    .setInteger("par2", codEmpresaConvenio)
                    .setInteger("par3", tipo)
                    .setInteger("par4", condicion)
                    .setInteger("par5", codCobrador);
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
     * 0: codVentas, 1:docSerieNumero, 2:fecha, 3:identificacion, 4:cliente,
     * 5:direccion, 6:neto, 7:codVentaCreditoLetra, 8:fechaVencimiento, 9:monto,
     * 10:totalPago
     *
     * @return
     */
    public List letrasVencidasTramos_todos_ordenNombresC_SC() {
        List l = null;
        Transaction trns = null;
        sesion = HibernateUtil.getSessionFactory().openSession();
        try {
            trns = sesion.beginTransaction();
            Query q = sesion.createQuery("select vcl.ventaCredito.ventas.codVentas,"
                    + "	vcl.ventaCredito.ventas.docSerieNumero,"
                    + "	vcl.ventaCredito.ventas.fecha,"
                    + "	vcl.ventaCredito.ventas.identificacion,"
                    + "	vcl.ventaCredito.ventas.cliente,"
                    + "	vcl.ventaCredito.ventas.direccion,"
                    + "	vcl.ventaCredito.ventas.neto,"
                    + "	vcl.codVentaCreditoLetra,"
                    + "	vcl.fechaVencimiento,"
                    + "	vcl.monto,"
                    + "	vcl.totalPago,"
                    + " dc.empresaConvenio.codCobranza"
                    + " from VentaCreditoLetra vcl, DatosCliente dc"
                    + " where vcl.ventaCredito.ventas.persona = dc.persona"
                    + " and (vcl.monto-vcl.totalPago)>0"
                    + "	and substring(vcl.registro,1,1)=1"
                    + " order by vcl.ventaCredito.ventas.persona.nombresC,"
                    + " dc.codDatosCliente, vcl.ventaCredito.codVentaCredito");
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
     * 0: codVentas, 1:docSerieNumero, 2:fecha, 3:identificacion, 4:cliente,
     * 5:direccion, 6:neto, 7:codVentaCreditoLetra, 8:fechaVencimiento, 9:monto,
     * 10:totalPago
     *
     * @return
     */
    public List letrasVencidasTramos_todos_ordenDireccion_SC() {
        List l = null;
        Transaction trns = null;
        sesion = HibernateUtil.getSessionFactory().openSession();
        try {
            trns = sesion.beginTransaction();
            Query q = sesion.createQuery("select vcl.ventaCredito.ventas.codVentas,"
                    + "	vcl.ventaCredito.ventas.docSerieNumero,"
                    + "	vcl.ventaCredito.ventas.fecha,"
                    + "	vcl.ventaCredito.ventas.identificacion,"
                    + "	vcl.ventaCredito.ventas.cliente,"
                    + "	vcl.ventaCredito.ventas.direccion,"
                    + "	vcl.ventaCredito.ventas.neto,"
                    + "	vcl.codVentaCreditoLetra,"
                    + "	vcl.fechaVencimiento,"
                    + "	vcl.monto,"
                    + "	vcl.totalPago,"
                    + " dc.empresaConvenio.codCobranza"
                    + " from VentaCreditoLetra vcl, DatosCliente dc"
                    + " where vcl.ventaCredito.ventas.persona = dc.persona"
                    + " and (vcl.monto-vcl.totalPago)>0"
                    + "	and substring(vcl.registro,1,1)=1"
                    + " order by vcl.ventaCredito.ventas.persona.direccion,"
                    + " dc.codDatosCliente, vcl.ventaCredito.codVentaCredito");
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
     * 0: codVentas, 1:docSerieNumero, 2:fecha, 3:identificacion, 4:cliente,
     * 5:direccion, 6:neto, 7:codVentaCreditoLetra, 8:fechaVencimiento, 9:monto,
     * 10:totalPago
     *
     * @param codCobrador
     * @return
     */
    public List letrasVencidasTramos_cobrador_ordenNombresC_SC(int codCobrador) {
        List l = null;
        Transaction trns = null;
        sesion = HibernateUtil.getSessionFactory().openSession();
        try {
            trns = sesion.beginTransaction();
            Query q = sesion.createQuery("select vcl.ventaCredito.ventas.codVentas,"
                    + "	vcl.ventaCredito.ventas.docSerieNumero,"
                    + "	vcl.ventaCredito.ventas.fecha,"
                    + "	vcl.ventaCredito.ventas.identificacion,"
                    + "	vcl.ventaCredito.ventas.cliente,"
                    + "	vcl.ventaCredito.ventas.direccion,"
                    + "	vcl.ventaCredito.ventas.neto,"
                    + "	vcl.codVentaCreditoLetra,"
                    + "	vcl.fechaVencimiento,"
                    + "	vcl.monto,"
                    + "	vcl.totalPago,"
                    + " dc.empresaConvenio.codCobranza"
                    + " from VentaCreditoLetra vcl, DatosCliente dc"
                    + " where vcl.ventaCredito.ventas.persona = dc.persona"
                    + " and (vcl.monto-vcl.totalPago)>0"
                    + "	and substring(vcl.registro,1,1)=1"
                    + " and dc.codCobrador = :par1"
                    + " order by vcl.ventaCredito.ventas.persona.nombresC,"
                    + " dc.codDatosCliente, vcl.ventaCredito.codVentaCredito")
                    .setInteger("par1", codCobrador);
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
     * 0: codVentas, 1:docSerieNumero, 2:fecha, 3:identificacion, 4:cliente,
     * 5:direccion, 6:neto, 7:codVentaCreditoLetra, 8:fechaVencimiento, 9:monto,
     * 10:totalPago
     *
     * @param codCobrador
     * @return
     */
    public List letrasVencidasTramos_cobrador_ordenDireccion_SC(int codCobrador) {
        List l = null;
        Transaction trns = null;
        sesion = HibernateUtil.getSessionFactory().openSession();
        try {
            trns = sesion.beginTransaction();
            Query q = sesion.createQuery("select vcl.ventaCredito.ventas.codVentas,"
                    + "	vcl.ventaCredito.ventas.docSerieNumero,"
                    + "	vcl.ventaCredito.ventas.fecha,"
                    + "	vcl.ventaCredito.ventas.identificacion,"
                    + "	vcl.ventaCredito.ventas.cliente,"
                    + "	vcl.ventaCredito.ventas.direccion,"
                    + "	vcl.ventaCredito.ventas.neto,"
                    + "	vcl.codVentaCreditoLetra,"
                    + "	vcl.fechaVencimiento,"
                    + "	vcl.monto,"
                    + "	vcl.totalPago,"
                    + " dc.empresaConvenio.codCobranza"
                    + " from VentaCreditoLetra vcl, DatosCliente dc"
                    + " where vcl.ventaCredito.ventas.persona = dc.persona"
                    + " and (vcl.monto-vcl.totalPago)>0"
                    + "	and substring(vcl.registro,1,1)=1"
                    + " and dc.codCobrador = :par1"
                    + " order by vcl.ventaCredito.ventas.persona.direccion,"
                    + " dc.codDatosCliente, vcl.ventaCredito.codVentaCredito")
                    .setInteger("par1", codCobrador);
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
     * 0: codVentas, 1:docSerieNumero, 2:fecha, 3:identificacion, 4:cliente,
     * 5:direccion, 6:neto, 7:codVentaCreditoLetra, 8:fechaVencimiento, 9:monto,
     * 10:totalPago
     *
     * @param codEmpresaConvenio
     * @return
     */
    public List letrasVencidasTramos_empresaConvenio_todos_ordenNombresC_SC(int codEmpresaConvenio) {
        List l = null;
        Transaction trns = null;
        sesion = HibernateUtil.getSessionFactory().openSession();
        try {
            trns = sesion.beginTransaction();
            Query q = sesion.createQuery("select vcl.ventaCredito.ventas.codVentas,"
                    + "	vcl.ventaCredito.ventas.docSerieNumero,"
                    + "	vcl.ventaCredito.ventas.fecha,"
                    + "	vcl.ventaCredito.ventas.identificacion,"
                    + "	vcl.ventaCredito.ventas.cliente,"
                    + "	vcl.ventaCredito.ventas.direccion,"
                    + "	vcl.ventaCredito.ventas.neto,"
                    + "	vcl.codVentaCreditoLetra,"
                    + "	vcl.fechaVencimiento,"
                    + "	vcl.monto,"
                    + "	vcl.totalPago,"
                    + " dc.empresaConvenio.codCobranza"
                    + " from VentaCreditoLetra vcl, DatosCliente dc"
                    + " where vcl.ventaCredito.ventas.persona = dc.persona"
                    + " and (vcl.monto-vcl.totalPago)>0"
                    + "	and substring(vcl.registro,1,1)=1"
                    + " and dc.empresaConvenio.codEmpresaConvenio = :ter1"
                    + " order by vcl.ventaCredito.ventas.persona.nombresC,"
                    + " dc.codDatosCliente, vcl.ventaCredito.codVentaCredito")
                    .setInteger("ter1", codEmpresaConvenio);
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
     * 0: codVentas, 1:docSerieNumero, 2:fecha, 3:identificacion, 4:cliente,
     * 5:direccion, 6:neto, 7:codVentaCreditoLetra, 8:fechaVencimiento, 9:monto,
     * 10:totalPago
     *
     * @param codEmpresaConvenio
     * @return
     */
    public List letrasVencidasTramos_empresaConvenio_todos_ordenDireccion_SC(int codEmpresaConvenio) {
        List l = null;
        Transaction trns = null;
        sesion = HibernateUtil.getSessionFactory().openSession();
        try {
            trns = sesion.beginTransaction();
            Query q = sesion.createQuery("select vcl.ventaCredito.ventas.codVentas,"
                    + "	vcl.ventaCredito.ventas.docSerieNumero,"
                    + "	vcl.ventaCredito.ventas.fecha,"
                    + "	vcl.ventaCredito.ventas.identificacion,"
                    + "	vcl.ventaCredito.ventas.cliente,"
                    + "	vcl.ventaCredito.ventas.direccion,"
                    + "	vcl.ventaCredito.ventas.neto,"
                    + "	vcl.codVentaCreditoLetra,"
                    + "	vcl.fechaVencimiento,"
                    + "	vcl.monto,"
                    + "	vcl.totalPago,"
                    + " dc.empresaConvenio.codCobranza"
                    + " from VentaCreditoLetra vcl, DatosCliente dc"
                    + " where vcl.ventaCredito.ventas.persona = dc.persona"
                    + " and (vcl.monto-vcl.totalPago)>0"
                    + "	and substring(vcl.registro,1,1)=1"
                    + " and dc.empresaConvenio.codEmpresaConvenio = :ter1"
                    + " order by vcl.ventaCredito.ventas.persona.direccion,"
                    + " dc.codDatosCliente, vcl.ventaCredito.codVentaCredito")
                    .setInteger("ter1", codEmpresaConvenio);
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
     * 0: codVentas, 1:docSerieNumero, 2:fecha, 3:identificacion, 4:cliente,
     * 5:direccion, 6:neto, 7:codVentaCreditoLetra, 8:fechaVencimiento, 9:monto,
     * 10:totalPago
     *
     * @param codEmpresaConvenio
     * @param codCobrador
     * @return
     */
    public List letrasVencidasTramos_empresaConvenio_cobrador_ordenNombresC_SC(int codEmpresaConvenio,
            int codCobrador) {
        List l = null;
        Transaction trns = null;
        sesion = HibernateUtil.getSessionFactory().openSession();
        try {
            trns = sesion.beginTransaction();
            Query q = sesion.createQuery("select vcl.ventaCredito.ventas.codVentas,"
                    + "	vcl.ventaCredito.ventas.docSerieNumero,"
                    + "	vcl.ventaCredito.ventas.fecha,"
                    + "	vcl.ventaCredito.ventas.identificacion,"
                    + "	vcl.ventaCredito.ventas.cliente,"
                    + "	vcl.ventaCredito.ventas.direccion,"
                    + "	vcl.ventaCredito.ventas.neto,"
                    + "	vcl.codVentaCreditoLetra,"
                    + "	vcl.fechaVencimiento,"
                    + "	vcl.monto,"
                    + "	vcl.totalPago,"
                    + " dc.empresaConvenio.codCobranza"
                    + " from VentaCreditoLetra vcl, DatosCliente dc"
                    + " where vcl.ventaCredito.ventas.persona = dc.persona"
                    + " and (vcl.monto-vcl.totalPago)>0"
                    + "	and substring(vcl.registro,1,1)=1"
                    + " and dc.empresaConvenio.codEmpresaConvenio = :ter1"
                    + " and dc.codCobrador = :par2"
                    + " order by vcl.ventaCredito.ventas.persona.nombresC,"
                    + " dc.codDatosCliente, vcl.ventaCredito.codVentaCredito")
                    .setInteger("ter1", codEmpresaConvenio)
                    .setInteger("par2", codCobrador);
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
     * 0: codVentas, 1:docSerieNumero, 2:fecha, 3:identificacion, 4:cliente,
     * 5:direccion, 6:neto, 7:codVentaCreditoLetra, 8:fechaVencimiento, 9:monto,
     * 10:totalPago
     *
     * @param codEmpresaConvenio
     * @param codCobrador
     * @return
     */
    public List letrasVencidasTramos_empresaConvenio_cobrador_ordenDireccion_SC(int codEmpresaConvenio,
            int codCobrador) {
        List l = null;
        Transaction trns = null;
        sesion = HibernateUtil.getSessionFactory().openSession();
        try {
            trns = sesion.beginTransaction();
            Query q = sesion.createQuery("select vcl.ventaCredito.ventas.codVentas,"
                    + "	vcl.ventaCredito.ventas.docSerieNumero,"
                    + "	vcl.ventaCredito.ventas.fecha,"
                    + "	vcl.ventaCredito.ventas.identificacion,"
                    + "	vcl.ventaCredito.ventas.cliente,"
                    + "	vcl.ventaCredito.ventas.direccion,"
                    + "	vcl.ventaCredito.ventas.neto,"
                    + "	vcl.codVentaCreditoLetra,"
                    + "	vcl.fechaVencimiento,"
                    + "	vcl.monto,"
                    + "	vcl.totalPago,"
                    + " dc.empresaConvenio.codCobranza"
                    + " from VentaCreditoLetra vcl, DatosCliente dc"
                    + " where vcl.ventaCredito.ventas.persona = dc.persona"
                    + " and (vcl.monto-vcl.totalPago)>0"
                    + "	and substring(vcl.registro,1,1)=1"
                    + " and dc.empresaConvenio.codEmpresaConvenio = :ter1"
                    + " and dc.codCobrador = :par2"
                    + " order by vcl.ventaCredito.ventas.persona.direccion,"
                    + " dc.codDatosCliente, vcl.ventaCredito.codVentaCredito")
                    .setInteger("ter1", codEmpresaConvenio)
                    .setInteger("par2", codCobrador);
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

}
