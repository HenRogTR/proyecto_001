/*
 * To change this template, choose Tools | Templates
 * and open the template in the editor.
 */
package ventaClases;

import java.util.Date;
import java.util.Iterator;
import java.util.List;
import org.hibernate.Query;
import org.hibernate.Session;
import org.hibernate.Transaction;
import otrasTablasClases.cDatosExtras;
import tablas.CobranzaDetalle;
import HiberanteUtil.HibernateUtil;
import tablas.VentaCreditoLetra;
import utilitarios.cManejoFechas;
import utilitarios.cOtros;

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
        this.error = null;
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
     * Retorna todas las letras de credito a vencerse de las empresas
     * afectada/no afectadas al interes.
     *
     * 0:codVentaCreditoLetra,
     *
     * @return
     */
    public List leer_letraConDeuda() {
        List l = null;
        Transaction trns = null;
        sesion = HibernateUtil.getSessionFactory().openSession();
        try {
            trns = sesion.beginTransaction();
            Query q = sesion.createQuery("select vcl.codVentaCreditoLetra "
                    + "from VentaCreditoLetra vcl "
                    + "where substring(vcl.registro,1,1) = 1 "
                    + "and (vcl.monto-vcl.totalPago) > 0 ");
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
     * Retorna todas las letras de credito a vencerse de las empresas
     * afectada/no afectadas al interes.
     *
     * 0:codVentaCreditoLetra,
     *
     * @param codCliente
     * @return
     */
    public List leer_letraConDeuda_codCliente(int codCliente) {
        //*corregir* el uso de datosCleinte esta por demas
        List l = null;
        Transaction trns = null;
        sesion = HibernateUtil.getSessionFactory().openSession();
        try {
            trns = sesion.beginTransaction();
            Query q = sesion.createQuery("select vcl.codVentaCreditoLetra "
                    + "from VentaCreditoLetra vcl, DatosCliente dc "
                    + "where vcl.ventas.persona = dc.persona"
                    + " and dc = :par1"
                    + " and substring(vcl.registro,1,1) = 1 "
                    + " and (vcl.monto-vcl.totalPago) > 0 ")
                    .setInteger("par1", codCliente);
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
                    + "where v.ventas.codVentas=:codVentas "
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
        //*corregir* el uso de datosCleinte esta por demas
        Object[] resumen = null;
        sesion = HibernateUtil.getSessionFactory().openSession();
        try {
            Query q = sesion.createQuery("select sum(vcl.monto+ vcl.interes),sum(vcl.totalPago+vcl.interesPagado),(sum(vcl.monto)-sum(vcl.totalPago)+sum(vcl.interes)-sum(vcl.interesPagado)) "
                    + "from VentaCreditoLetra vcl where substring(vcl.registro,1,1)=1 "
                    + "and vcl.ventas.persona.codPersona=:codPersona")
                    .setParameter("codPersona", codPersona);
            resumen = (Object[]) q.list().iterator().next();
            sesion.flush();
            sesion.close();
        } catch (Exception e) {
            setError(e.getMessage());
            e.printStackTrace();
        }
        return resumen;
    }

    public VentaCreditoLetra leer_codVentaCreditoLetra(int codVentaCreditoLetra) {
        sesion = HibernateUtil.getSessionFactory().openSession();
        return (VentaCreditoLetra) sesion.get(VentaCreditoLetra.class, codVentaCreditoLetra);
    }

    /**
     * Listara todas la letras de credito de un cliente donde los interes no
     * esten actualizados ademas de estar vencidos.
     *
     * @param fechaVencimiento fecha en la que se sacará las letras vencidas
     * fechaBase - diaEspera
     * @param fechaBase fecha actual
     * @param interesAsigando si está o no afectada a los interes.
     * @param codCliente
     * @return <b>[0:codVCL, 1:fechaVencimiento, 2:monto, 3:interes,
     * 4:fechaPago, 5:totalPago, 6:interesPagado, 7:interesUltimoCalculo]</b>
     */
    public List leer_cliente_interesSinActualizar(Date fechaVencimiento, Date fechaBase, boolean interesAsigando, int codCliente) {
        //*corregir* el uso de datosCliente esta por demas
        List l = null;
        Transaction trns = null;
        sesion = HibernateUtil.getSessionFactory().openSession();
        try {
            trns = sesion.beginTransaction();
            Query q = sesion.createQuery("select vcl.codVentaCreditoLetra, "
                    + "vcl.fechaVencimiento, vcl.monto, vcl.interes, "
                    + "vcl.fechaPago, vcl.totalPago, vcl.interesPagado, "
                    + "vcl.interesUltimoCalculo "
                    + "from VentaCreditoLetra vcl, DatosCliente dc, EmpresaConvenio ec "
                    + "where vcl.ventas.persona = dc.persona "
                    + "and dc.empresaConvenio = ec "
                    + "and substring(vcl.registro,1,1) = 1 "
                    + "and vcl.monto- vcl.totalPago > 0 " //que tengan deuda de capital
                    + "and (vcl.interesUltimoCalculo is NULL or vcl.interesUltimoCalculo < :par1 ) " //si es NULL o la fecha ultima de actualizacion sea menor a la actual
                    + "and vcl.fechaVencimiento < :par2 " //todas las letras vencidas    < porque si se vence el primero y se consulta el 1 este marcara como vencido
                    + "and ec.interesAsigando = :par3 " //empresas afectadas nada mas     
                    + "and dc = :par4 ")
                    .setDate("par1", fechaBase)
                    .setDate("par2", fechaVencimiento)
                    .setBoolean("par3", interesAsigando)
                    .setInteger("par4", codCliente);
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
     * Actualiza los interes. Calcula la cantidad de dias que no se ha generado
     * los intereses y los va generando.
     *
     * @param lista
     * @param fechaDate restamos un dia
     * @return
     */
    public boolean actualizar_interes(List lista, Date fechaDate) {
        boolean est = false;
        Transaction trns = null;
        sesion = HibernateUtil.getSessionFactory().openSession();
        try {
            trns = sesion.beginTransaction();
            double factorInteres = (new cDatosExtras().leer_interesFactor().getDecimalDato() / 100) / 30;

            Integer codVentaCreditoLetra = 0;
            Date fechaVencimiento = null;
            Double monto = 0.00;
//            Double interes = 0.00;
            Date fechaPago = null;
            Double totalPago = 0.00;
//            Double interesPagado = 0.00;
            Date interesUltimoCalculo = null;

            Integer diaRetraso = 0;
            Double interesSumar = 0.00;

            for (Iterator it = lista.iterator(); it.hasNext();) {
                Object vCLetraObject[] = (Object[]) it.next();
                codVentaCreditoLetra = (Integer) vCLetraObject[0];
                fechaVencimiento = (Date) vCLetraObject[1];
                monto = (Double) vCLetraObject[2];
//                interes = (Double) vCLetraObject[3];
                fechaPago = (Date) vCLetraObject[4];
                totalPago = (Double) vCLetraObject[5];
//                interesPagado = (Double) vCLetraObject[6];
                interesUltimoCalculo = (Date) vCLetraObject[7];
                if (interesUltimoCalculo == null) {//se tomara el ultimo pago o la fecha de vencimiento
                    diaRetraso = new cManejoFechas().diferenciaDosDias(fechaDate, fechaPago != null ? fechaPago : fechaVencimiento);
                } else {
                    diaRetraso = new cManejoFechas().diferenciaDosDias(fechaDate, interesUltimoCalculo);
                }
                System.out.println(diaRetraso);
                //aun falta solucionar
                diaRetraso = diaRetraso < 0 ? 0 : diaRetraso;
                interesSumar = (monto - totalPago) * factorInteres * diaRetraso;
                //procedemos a actualizar
                VentaCreditoLetra objVentaCreditoLetra = (VentaCreditoLetra) sesion.get(VentaCreditoLetra.class, codVentaCreditoLetra);
                objVentaCreditoLetra.setInteres(objVentaCreditoLetra.getInteres() + interesSumar);
                //actualizamos fecha de interes
                objVentaCreditoLetra.setInteresUltimoCalculo(fechaDate);
                sesion.persist(objVentaCreditoLetra);
            }
            sesion.getTransaction().commit();
            est = true;
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
        return est;
    }

    /**
     * Lista de todas las letras que un cliente tiene.
     *
     * @param codCliente
     * @return
     */
    public List leer_codCliente(int codCliente) {
        //*corregir* el uso de datosCleinte esta por demas
        List l = null;
        Transaction trns = null;
        sesion = HibernateUtil.getSessionFactory().openSession();
        try {
            trns = sesion.beginTransaction();
            Query q = sesion.createQuery("select vcl"
                    + " from VentaCreditoLetra vcl join vcl.ventas.persona.datosClientes dc"
                    + " where substring(vcl.registro, 1, 1)= 1"
                    + " and dc= :par1"
                    + " order by vcl.codVentaCreditoLetra asc, vcl.ventas asc")
                    .setInteger("par1", codCliente);
            l = q.list();
        } catch (Exception e) {
            e.printStackTrace();
            setError(e.getMessage());
        } finally {
            sesion.flush();
        }
        return l;
    }

    /**
     *
     * @param codPersona
     * @return
     */
    public List leer_resumenPagos(int codPersona) {
        //*corregir* el uso de datosCleinte esta por demas
        List l = null;
        sesion = HibernateUtil.getSessionFactory().openSession();
        try {
            Query q = sesion.createQuery("select month(vcl.fechaVencimiento), year(vcl.fechaVencimiento), "
                    + "sum(vcl.monto), sum(interes), sum(vcl.totalPago+vcl.interesPagado), sum(vcl.monto)-sum(vcl.totalPago)+sum(vcl.interes)-sum(vcl.interesPagado), vcl.fechaVencimiento "
                    + "from VentaCreditoLetra vcl "
                    + "where substring(vcl.registro,1,1)=1 "
                    + "and vcl.ventas.persona.codPersona=:codPersona "
                    + "group by year(vcl.fechaVencimiento), month(vcl.fechaVencimiento) "
                    + "order by vcl.fechaVencimiento")
                    .setParameter("codPersona", codPersona);
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
     * @param codCliente
     * @return 0:fechaVencimiento, 1:monto(mensual), 2:interes(mensual),
     * 3:totalPago(mensual), 4:interesPagado(mensual)
     */
    public List leer_deudaMes(int codCliente) {
        //*corregir* el uso de datosCleinte esta por demas y el uso de intereses y lo demas
        List l = null;
        Transaction trns = null;
        sesion = HibernateUtil.getSessionFactory().openSession();
        try {
            trns = sesion.beginTransaction();
            Query q = sesion.createQuery("select vcl.fechaVencimiento"
                    + ", sum(vcl.monto)"
                    + ", sum(vcl.interes)"
                    + ", sum(vcl.totalPago)"
                    + ", sum(vcl.interesPagado)"
                    + " from VentaCreditoLetra vcl join vcl.ventas.persona.datosClientes dc"
                    + " where substring(vcl.registro,1,1) = 1 "
                    + " and dc = :par1"
                    + " group by year(vcl.fechaVencimiento), month(vcl.fechaVencimiento) "
                    + " order by vcl.fechaVencimiento")
                    .setInteger("par1", codCliente);
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
     * Deuda del cliente por venta hecha
     *
     * @param codPersona
     * @param codVentas
     * @return
     */
    public Double leer_deudaCliente_codCliente_codVentas_SC(int codPersona, int codVentas) {
        //*corregir* el uso de datosCleinte esta por demas
        Double deuda = 0.0;
        Transaction trns = null;
        sesion = HibernateUtil.getSessionFactory().openSession();
        try {
            trns = sesion.beginTransaction();
            Query q = sesion.createQuery("select sum(v.monto- v.totalPago+ v.interes- v.interesPagado)"
                    + " from VentaCreditoLetra v "
                    + "where v.ventas.persona.codPersona=:codPersona "
                    + "and v.monto-v.totalPago>0 "
                    + "and v.ventas.codVentas=:codVentas "
                    + "and substring(v.registro,1,1)=1 "
                    + "order by v.fechaVencimiento asc")
                    .setParameter("codPersona", codPersona)
                    .setParameter("codVentas", codVentas);
            deuda = (Double) q.list().iterator().next();
            deuda = deuda == null ? 0.00 : deuda;
        } catch (Exception e) {
            e.printStackTrace();
            setError(e.getMessage());
        } finally {
            sesion.flush();
            sesion.close();
        }
        return deuda;
    }

    /**
     * Retonra la letra mas vencida de un cliente buscado por codigo;
     * Saldo=deudaNormal+interesDeuda
     *
     * @param codPersona
     * @return
     */
    public VentaCreditoLetra leer_letraVencidaAntigua(int codPersona) {
        //*corregir* el uso de datosCleinte esta por demas
        VentaCreditoLetra objVCL = null;
        Transaction trns = null;
        sesion = HibernateUtil.getSessionFactory().openSession();
        try {
            trns = sesion.beginTransaction();
            Query q = sesion.createQuery("from VentaCreditoLetra v "
                    + "where v.ventas.persona.codPersona=:codPersona "
                    + "and (v.monto- v.totalPago> 0 or v.interes- v.interesPagado> 0 )"
                    + "and substring(v.registro,1,1)=1 "
                    + "order by v.fechaVencimiento asc")
                    .setParameter("codPersona", codPersona);
            objVCL = (VentaCreditoLetra) q.list().get(0);
        } catch (Exception e) {
            setError(e.getMessage());
            e.printStackTrace();
        } finally {
            sesion.flush();
        }
        return objVCL;
    }

    /**
     * Retonra la letra mas vencida de un cliente buscado por codigo;
     * Saldo=deudaNormal+interesDeuda
     *
     * @param codPersona
     * @return
     */
    public VentaCreditoLetra leer_letraVencidaAntigua_interesEvitar(int codPersona) {
        //*corregir* el uso de datosCleinte esta por demas
        VentaCreditoLetra objVCL = null;
        Transaction trns = null;
        sesion = HibernateUtil.getSessionFactory().openSession();
        try {
            trns = sesion.beginTransaction();
            Query q = sesion.createQuery("from VentaCreditoLetra v "
                    + "where v.ventas.persona.codPersona=:codPersona "
                    + "and v.monto- v.totalPago> 0"
                    + "and substring(v.registro,1,1)=1 "
                    + "order by v.fechaVencimiento asc")
                    .setParameter("codPersona", codPersona);
            objVCL = (VentaCreditoLetra) q.list().get(0);
        } catch (Exception e) {
            setError(e.getMessage());
            e.printStackTrace();
        } finally {
            sesion.flush();
        }
        return objVCL;
    }

    /**
     * Retorna la letra mas vencida de un cliente buscado por codigo y por venta
     * hecha. Saldo=deudaNormal+interesDeuda
     *
     * @param codPersona
     * @param codVentas
     * @return
     */
    public VentaCreditoLetra leer_letraVencidaAntigua_codVenta(int codPersona, int codVentas) {
        //*corregir* el uso de datosCleinte esta por demas
        VentaCreditoLetra obj = null;
        Transaction trns = null;
        sesion = HibernateUtil.getSessionFactory().openSession();
        try {
            trns = sesion.beginTransaction();
            Query q = sesion.createQuery("from VentaCreditoLetra v "
                    + "where v.ventas.persona.codPersona=:codPersona "
                    + "and (v.monto- v.totalPago> 0 or v.interes- v.interesPagado> 0 )"
                    + "and v.ventas.codVentas=:codVentas "
                    + "and substring(v.registro,1,1)=1 "
                    + "order by v.fechaVencimiento asc")
                    .setParameter("codPersona", codPersona)
                    .setParameter("codVentas", codVentas);
            obj = (VentaCreditoLetra) q.list().get(0);
        } catch (Exception e) {
            e.printStackTrace();
            setError(e.getMessage());
        } finally {
            sesion.flush();
        }
        return obj;
    }

    /**
     * Retorna la letra mas vencida de un cliente buscado por codigo y por venta
     * hecha. Saldo=deudaNormal
     *
     * @param codPersona
     * @param codVentas
     * @return
     */
    public VentaCreditoLetra leer_letraVencidaAntigua_interesEvitar_codVenta(int codPersona, int codVentas) {
        //*corregir* el uso de datosCleinte esta por demas
        VentaCreditoLetra obj = null;
        Transaction trns = null;
        sesion = HibernateUtil.getSessionFactory().openSession();
        try {
            trns = sesion.beginTransaction();
            Query q = sesion.createQuery("from VentaCreditoLetra v "
                    + "where v.ventas.persona.codPersona=:codPersona "
                    + "and v.monto- v.totalPago> 0"
                    + "and v.ventas.codVentas=:codVentas "
                    + "and substring(v.registro,1,1)=1 "
                    + "order by v.fechaVencimiento asc")
                    .setParameter("codPersona", codPersona)
                    .setParameter("codVentas", codVentas);
            obj = (VentaCreditoLetra) q.list().get(0);
        } catch (Exception e) {
            e.printStackTrace();
            setError(e.getMessage());
        } finally {
            sesion.flush();
        }
        return obj;
    }

    /**
     * Retorna la letra mas vencida de un cliente buscado por codigo y por venta
     * hecha. Saldo=deudaNormal+interesDeuda
     *
     * @param codCliente
     * @return
     */
    public List leer_letras_deudaSoloInteres_SC(int codCliente) {
        //*corregir* el uso de datosCleinte esta por demas
        List lista = null;
        Transaction trns = null;
        sesion = HibernateUtil.getSessionFactory().openSession();
        try {
            trns = sesion.beginTransaction();
            Query q = sesion.createQuery("select vcl.codVentaCreditoLetra"
                    + " from VentaCreditoLetra vcl join vcl.ventas.persona.datosClientes dc"
                    + " where dc.codDatosCliente= :par1 and vcl.monto- vcl.totalPago= 0"
                    + " and vcl.interes- vcl.interesPagado> 0"
                    + " and substring(vcl.registro,1,1)=1")
                    .setParameter("par1", codCliente);
            lista = q.list();
        } catch (Exception e) {
            e.printStackTrace();
            setError(e.getMessage());
        } finally {
            sesion.flush();
            sesion.close();
        }
        return lista;
    }

    /**
     * Actualiza los interes. Calcula la cantidad de dias que no se ha generado
     * los intereses y los va generando.
     *
     * @param lista
     * @return
     */
    public boolean actualizar_interesPendiente(List lista) {
        boolean est = false;
        Transaction trns = null;
        sesion = HibernateUtil.getSessionFactory().openSession();
        try {
            trns = sesion.beginTransaction();

            Integer codVentaCreditoLetra = 0;

            for (Iterator it = lista.iterator(); it.hasNext();) {
                Object vCLetraObject = (Object) it.next();
                codVentaCreditoLetra = (Integer) vCLetraObject;
                VentaCreditoLetra objVentaCreditoLetra = (VentaCreditoLetra) sesion.get(VentaCreditoLetra.class, codVentaCreditoLetra);
                //obtenemos los intereses no pagados
                Double deudaInteresPendiente = objVentaCreditoLetra.getInteres() - objVentaCreditoLetra.getInteresPagado();
                objVentaCreditoLetra.setInteresPendiente(deudaInteresPendiente);
                //igualamos interese pagados con generados
                objVentaCreditoLetra.setInteres(objVentaCreditoLetra.getInteresPagado());
                sesion.persist(objVentaCreditoLetra);
            }
            sesion.getTransaction().commit();
            est = true;
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
        return est;
    }

    public boolean actualizar_interesPendiente_retornar(int codVCL) {
        boolean est = false;
        Transaction trns = null;
        sesion = HibernateUtil.getSessionFactory().openSession();
        try {
            trns = sesion.beginTransaction();
            VentaCreditoLetra objVentaCreditoLetra = (VentaCreditoLetra) sesion.get(VentaCreditoLetra.class, codVCL);
            //sumamos el interes
            objVentaCreditoLetra.setInteres(objVentaCreditoLetra.getInteres() + objVentaCreditoLetra.getInteresPendiente());
            //ponemos a cero para no volver a generar denuevo
            objVentaCreditoLetra.setInteresPendiente(0.00);
            sesion.save(objVentaCreditoLetra);
            sesion.getTransaction().commit();
            est = true;
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
        return est;
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
        cOtros objcOtros = new cOtros();
        setError(null);
        sesion = HibernateUtil.getSessionFactory().openSession();
        sesion.getTransaction().begin();
        VentaCreditoLetra obj = (VentaCreditoLetra) sesion.get(VentaCreditoLetra.class, codVentaCreditoLetra);
        obj.setRegistro(objcOtros.registro(estado, user));
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

    /**
     * La letra se cancela en su totalidad, de manera que los interes e
     * interesPagado = 0.00
     *
     * @param codVentaCreditoLetra
     * @param montoAmortizar
     * @param interesAmortizar
     * @param fechaPago
     * @return
     */
    public boolean actualizar_pago(int codVentaCreditoLetra, Double montoAmortizar, Double interesAmortizar, Date fechaPago) {
        boolean est = false;
        Transaction trns = null;
        sesion = HibernateUtil.getSessionFactory().openSession();
        try {
            trns = sesion.beginTransaction();
            VentaCreditoLetra obj = (VentaCreditoLetra) sesion.get(VentaCreditoLetra.class, codVentaCreditoLetra);
            obj.setTotalPago(obj.getTotalPago() + montoAmortizar);
            obj.setFechaPago(fechaPago == null ? obj.getFechaPago() : fechaPago);//si es null cogemos el que tiene en la bd
            obj.setInteresPagado(obj.getInteresPagado() + interesAmortizar);
            sesion.update(obj);
            sesion.getTransaction().commit();
            est = true;
        } catch (Exception e) {
            if (trns != null) {
                trns.rollback();
            }
            setError("VentaCreditoLetra_actualizar_registro: " + e.getMessage());
            e.printStackTrace();
        } finally {
            sesion.flush();
            sesion.close();
        }
        return est;
    }

    public boolean actualizar_totalPago(int codVentaCreditoLetra, Double montoAmortizar, Date fechaPago) {
        boolean est = false;
        Transaction trns = null;
        sesion = HibernateUtil.getSessionFactory().openSession();
        try {
            trns = sesion.beginTransaction();
            VentaCreditoLetra obj = (VentaCreditoLetra) sesion.get(VentaCreditoLetra.class, codVentaCreditoLetra);
            obj.setTotalPago(obj.getTotalPago() + montoAmortizar);
            obj.setFechaPago(fechaPago);
            sesion.update(obj);
            sesion.getTransaction().commit();
            est = true;
        } catch (Exception e) {
            if (trns != null) {
                trns.rollback();
            }
            setError("VentaCreditoLetra_actualizar_registro: " + e.getMessage());
            e.printStackTrace();
        } finally {
            sesion.flush();
            sesion.close();
        }
        return est;
    }

    public boolean actualizar_fechaUltimoPago(int codVentaCreditoLetra) {
        boolean est = false;
        Transaction trns = null;
        sesion = HibernateUtil.getSessionFactory().openSession();
        try {
            trns = sesion.beginTransaction();
            VentaCreditoLetra obj = (VentaCreditoLetra) sesion.get(VentaCreditoLetra.class, codVentaCreditoLetra);

            // si en caso no tiene monto
            if (obj.getMonto() <= 0) {
                obj.setFechaPago(null);
            }
            // si en caso no se hizo pago alguno
            if (obj.getTotalPago() == 0) {
                obj.setFechaPago(null);
            } else {
                //si en caso se hizo pago, hay que buscar el ultimo pago que
                //afecto a esa letra, buscado todos aquellos con registro 1 
                //y tomar el mayor.
                Date temp = null;
                for (CobranzaDetalle objCobranzaDetalle : obj.getCobranzaDetalles()) {
                    //solo cobranzaDetalle existentes.
                    if (objCobranzaDetalle.getRegistro().substring(0, 1).equals("1")) {
                        //inicio de busqueda.
                        if (temp == null) {
                            temp = objCobranzaDetalle.getCobranza().getFechaCobranza();
                        }
                        //si en caso solo fue interes no se toma la fecha de cobranza
                        if (temp.compareTo(objCobranzaDetalle.getCobranza().getFechaCobranza()) <= 0 & objCobranzaDetalle.getImporte() > 0) {
                            temp = objCobranzaDetalle.getCobranza().getFechaCobranza();
                        }
                    }
                }
                obj.setFechaPago(temp);
            }
            sesion.update(obj);
            sesion.getTransaction().commit();
            est = true;
        } catch (Exception e) {
            if (trns != null) {
                trns.rollback();
            }
            setError("VentaCreditoLetra_actualizar_registro: " + e.getMessage());
            e.printStackTrace();
        } finally {
            sesion.flush();
            sesion.close();
        }
        return est;
    }

}
