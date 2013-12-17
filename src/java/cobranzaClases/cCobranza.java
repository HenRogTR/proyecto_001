/*
 * To change this template, choose Tools | Templates
 * and open the template in the editor.
 */
package cobranzaClases;

import java.util.Date;
import java.util.List;
import org.hibernate.Query;
import org.hibernate.Session;
import org.hibernate.Transaction;
import otros.cUtilitarios;
import tablas.Cobranza;
import tablas.HibernateUtil;

/**
 *
 * @author Henrri
 */
public class cCobranza {

    Session sesion = null;
    public String error;

    public String getError() {
        return error;
    }

    public void setError(String error) {
        this.error = error;
    }

    public cCobranza() {
        this.sesion = HibernateUtil.getSessionFactory().getCurrentSession();
    }

    public int Crear(Cobranza objCobranza) {
        int cod = 0;
        Transaction trns = null;
        sesion = HibernateUtil.getSessionFactory().openSession();
        try {
            trns = sesion.beginTransaction();
            cod = (Integer) sesion.save(objCobranza);
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

    public List leer() {
        setError(null);
        try {
            sesion = HibernateUtil.getSessionFactory().openSession();
            Query q = sesion.createQuery("from Cobranza where substring(registro,1,1)=1");
            return (List) q.list();
        } catch (Exception e) {
            setError(e.getMessage());
        }
        return null;
    }

    public List leer_prueba() {
        List user = null;
        Transaction trns = null;
//       sesion = HibernateUtil.getSessionFactory().getCurrentSession();
        try {
            trns = sesion.beginTransaction();
            String queryString = "from Cobranza where substring(registro,1,1)=1";
            Query query = sesion.createQuery(queryString);

            user = query.list();
        } catch (RuntimeException e) {
            e.printStackTrace();
        } finally {
            sesion.flush();
//            session.close();
        }
        return user;
    }

    public Cobranza leer_codCobranza(int codCobranza) {
        Session session = HibernateUtil.getSessionFactory().openSession();
        return (Cobranza) session.get(Cobranza.class, codCobranza);
    }

    /**
     * Retorna una el objeto cobranza buscado por el docSerieNumero
     *
     * @param docSerieNumero
     * @return objeto cobranza en caso haya coincidencia
     */
    public Cobranza leer_docSerieNumero(String docSerieNumero) {
        setError(null);
        try {
            sesion = HibernateUtil.getSessionFactory().openSession();
            Query q = sesion.createQuery("from Cobranza where (substring(registro,1,1)=1 or substring(registro,1,1)=0) and docSerieNumero=:docSerieNumero")
                    .setParameter("docSerieNumero", docSerieNumero);
            return (Cobranza) q.list().iterator().next();
        } catch (Exception e) {
            setError(e.getMessage());
        }
        return null;
    }

    /**
     * Me retorna un array con todos los pagos que ha realizado un cliente.
     * ordenados por codCobranza.
     *
     * @param codPersona
     * @return Array con pagos de un cliente
     */
    public List leer_codPersona(int codPersona) {
        setError(null);
        Session session = HibernateUtil.getSessionFactory().openSession();
        try {
            session.flush();
            Query q = session.createQuery("from Cobranza c where substring(registro,1,1)=1 "
                    + "and c.persona.codPersona=:codPersona order by codCobranza asc")
                    .setParameter("codPersona", codPersona);
            return q.list();
        } catch (Exception e) {
            setError(e.getMessage());
        }
        return null;
    }

    /**
     * Retorna una lista de todas las cobranzas en un periodo dado ordenado
     * segun fecha de cobranza.
     *
     * @param fechaInicio
     * @param fechaFin
     * @return
     */
    public List leer_todo_fechaInicio_fechaFin(Date fechaInicio, Date fechaFin) {
        setError(null);
        sesion = HibernateUtil.getSessionFactory().openSession();
        try {
            Query q = sesion.createQuery("from Cobranza c "
                    + "where c.fechaCobranza>=:fechaInicio "
                    + "and c.fechaCobranza<=:fechaFin "
                    + "and (substring(c.docSerieNumero,1,1)='R' or substring(c.docSerieNumero,1,3)='TKR') "
                    + "order by c.fechaCobranza asc, c.docSerieNumero asc")
                    .setParameter("fechaInicio", fechaInicio)
                    .setParameter("fechaFin", fechaFin);
            return q.list();
        } catch (Exception e) {
            setError(e.getMessage());
        }
        return null;
    }

    public List leer_todo_fechaInicio_fechaFin_codCobrador(Date fechaInicio, Date fechaFin, int codCobrador) {
        setError(null);
        sesion = HibernateUtil.getSessionFactory().openSession();
        try {
            Query q = sesion.createQuery("select c from Cobranza c, DatosCliente dc "
                    + "where c.persona=dc.persona "
                    + "and c.fechaCobranza>=:fechaInicio "
                    + "and c.fechaCobranza<=:fechaFin "
                    + "and (substring(c.docSerieNumero,1,1)='R' or substring(c.docSerieNumero,1,3)='TKR') "
                    + "and (substring(c.registro,1,1)=1 or substring(c.registro,1,1)=0) "
                    + "and dc.codCobrador=:codCobrador "
                    + "order by c.fechaCobranza asc, c.docSerieNumero asc")
                    .setParameter("fechaInicio", fechaInicio)
                    .setParameter("fechaFin", fechaFin)
                    .setParameter("codCobrador", codCobrador);
            return q.list();
        } catch (Exception e) {
            setError(e.getMessage());
        }
        return null;
    }

    /**
     * Retorna una lista de todas las cobranzas en un periodo dado ordenado
     * segun fecha de cobranza.
     *
     * @param fechaInicio
     * @param fechaFin
     * @return
     */
    public List leer_iniciales_fechaInicio_fechaFin(Date fechaInicio, Date fechaFin) {
        setError(null);
        sesion = HibernateUtil.getSessionFactory().openSession();
        try {
            Query q = sesion.createQuery("from Cobranza c "
                    + "where c.fechaCobranza>=:fechaInicio "
                    + "and c.fechaCobranza<=:fechaFin "
                    + "and (substring(c.docSerieNumero,1,1)='R' or substring(c.docSerieNumero,1,3)='TKR') "
                    + "and c.observacion like '%inicial%' "
                    + "order by c.fechaCobranza asc, c.docSerieNumero asc")
                    .setParameter("fechaInicio", fechaInicio)
                    .setParameter("fechaFin", fechaFin);
            return q.list();
        } catch (Exception e) {
            setError(e.getMessage());
        }
        return null;
    }

    public List leer_iniciales_fechaInicio_fechaFin_codCobrador(Date fechaInicio, Date fechaFin, int codCobrador) {
        setError(null);
        sesion = HibernateUtil.getSessionFactory().openSession();
        try {
            Query q = sesion.createQuery("select c from Cobranza c, DatosCliente dc "
                    + "where c.persona=dc.persona "
                    + "and c.fechaCobranza>=:fechaInicio "
                    + "and c.fechaCobranza<=:fechaFin "
                    + "and (substring(c.docSerieNumero,1,1)='R' or substring(c.docSerieNumero,1,3)='TKR') "
                    + "and c.observacion like '%inicial%' "
                    + "and (substring(c.registro,1,1)=1 or substring(c.registro,1,1)=0) "
                    + "and dc.codCobrador=:codCobrador "
                    + "order by c.fechaCobranza asc, c.docSerieNumero asc")
                    .setParameter("fechaInicio", fechaInicio)
                    .setParameter("fechaFin", fechaFin)
                    .setParameter("codCobrador", codCobrador);
            return q.list();
        } catch (Exception e) {
            setError(e.getMessage());
        }
        return null;
    }

    /**
     * Retorna una lista de todas las cobranzas en un periodo dado ordenado
     * segun fecha de cobranza.
     *
     * @param fechaInicio
     * @param fechaFin
     * @return
     */
    public List leer_cobranza_fechaInicio_fechaFin(Date fechaInicio, Date fechaFin) {
        setError(null);
        sesion = HibernateUtil.getSessionFactory().openSession();
        try {
            Query q = sesion.createQuery("from Cobranza c "
                    + "where c.fechaCobranza>=:fechaInicio "
                    + "and c.fechaCobranza<=:fechaFin "
                    + "and (substring(c.docSerieNumero,1,1)='R' or substring(c.docSerieNumero,1,3)='TKR') "
                    + "and c.observacion like 'Letra N%' "
                    + "order by c.fechaCobranza asc, c.docSerieNumero asc")
                    .setParameter("fechaInicio", fechaInicio)
                    .setParameter("fechaFin", fechaFin);
            return q.list();
        } catch (Exception e) {
            setError(e.getMessage());
        }
        return null;
    }

    public List leer_cobranza_fechaInicio_fechaFin_codCobrador(Date fechaInicio, Date fechaFin, int codCobrador) {
        setError(null);
        sesion = HibernateUtil.getSessionFactory().openSession();
        try {
            Query q = sesion.createQuery("select c from Cobranza c, DatosCliente dc "
                    + "where c.persona=dc.persona "
                    + "and c.fechaCobranza>=:fechaInicio "
                    + "and c.fechaCobranza<=:fechaFin "
                    + "and (substring(c.docSerieNumero,1,1)='R' or substring(c.docSerieNumero,1,3)='TKR') "
                    + "and c.observacion like 'Letra N%' "
                    + "and (substring(c.registro,1,1)=1 or substring(c.registro,1,1)=0) "
                    + "and dc.codCobrador=:codCobrador "
                    + "order by c.fechaCobranza asc, c.docSerieNumero asc")
                    .setParameter("fechaInicio", fechaInicio)
                    .setParameter("fechaFin", fechaFin)
                    .setParameter("codCobrador", codCobrador);
            return q.list();
        } catch (Exception e) {
            setError(e.getMessage());
        }
        return null;
    }

    /**
     * Retorna una lista de todas las cobranzas en un periodo dado ordenado
     * segun fecha de cobranza.
     *
     * @param fechaInicio
     * @param fechaFin
     * @return
     */
    public List leer_anticipo_fechaInicio_fechaFin(Date fechaInicio, Date fechaFin) {
        setError(null);
        sesion = HibernateUtil.getSessionFactory().openSession();
        try {
            Query q = sesion.createQuery("from Cobranza c "
                    + "where c.fechaCobranza>=:fechaInicio "
                    + "and c.fechaCobranza<=:fechaFin "
                    + "and (substring(c.docSerieNumero,1,1)='R' or substring(c.docSerieNumero,1,3)='TKR') "
                    + "and c.observacion='Anticipo' "
                    + "order by c.fechaCobranza asc, c.docSerieNumero asc")
                    .setParameter("fechaInicio", fechaInicio)
                    .setParameter("fechaFin", fechaFin);
            return q.list();
        } catch (Exception e) {
            setError(e.getMessage());
        }
        return null;
    }

    public List leer_anticipo_fechaInicio_fechaFin_codCobrador(Date fechaInicio, Date fechaFin, int codCobrador) {
        setError(null);
        sesion = HibernateUtil.getSessionFactory().openSession();
        try {
            Query q = sesion.createQuery("select c from Cobranza c, DatosCliente dc "
                    + "where c.persona=dc.persona "
                    + "and c.fechaCobranza>=:fechaInicio "
                    + "and c.fechaCobranza<=:fechaFin "
                    + "and (substring(c.docSerieNumero,1,1)='R' or substring(c.docSerieNumero,1,3)='TKR') "
                    + "and c.observacion='Anticipo' "
                    + "and (substring(c.registro,1,1)=1 or substring(c.registro,1,1)=0) "
                    + "and dc.codCobrador=:codCobrador "
                    + "order by c.fechaCobranza asc, c.docSerieNumero asc")
                    .setParameter("fechaInicio", fechaInicio)
                    .setParameter("fechaFin", fechaFin)
                    .setParameter("codCobrador", codCobrador);
            return q.list();
        } catch (Exception e) {
            setError(e.getMessage());
        }
        return null;
    }

    /**
     * Retorna una lista de todas las cobranzas en un periodo dado ordenado
     * segun fecha de cobranza.
     *
     * @param fechaInicio
     * @param fechaFin
     * @return
     */
    public List leer_serie_fechaInicio_fechaFin(Date fechaInicio, Date fechaFin, String serie) {
        setError(null);
        sesion = HibernateUtil.getSessionFactory().openSession();
        try {
            Query q = sesion.createQuery("from Cobranza c "
                    + "where c.fechaCobranza>=:fechaInicio "
                    + "and c.fechaCobranza<=:fechaFin "
                    + "and c.docSerieNumero like :serie "
                    + "order by c.fechaCobranza asc, c.docSerieNumero asc")
                    .setParameter("fechaInicio", fechaInicio)
                    .setParameter("fechaFin", fechaFin)
                    .setParameter("serie", serie + "%");
            return q.list();
        } catch (Exception e) {
            setError(e.getMessage());
        }
        return null;
    }

    public List leer_serie_fechaInicio_fechaFin_codCobrador(Date fechaInicio, Date fechaFin, String serie, int codCobrador) {
        setError(null);
        sesion = HibernateUtil.getSessionFactory().openSession();
        try {
            Query q = sesion.createQuery("select c from Cobranza c, DatosCliente dc "
                    + "where c.persona=dc.persona "
                    + "and c.fechaCobranza>=:fechaInicio "
                    + "and c.fechaCobranza<=:fechaFin "
                    + "and c.docSerieNumero like :serie "
                    + "and (substring(c.registro,1,1)=1 or substring(c.registro,1,1)=0) "
                    + "and dc.codCobrador=:codCobrador "
                    + "order by c.fechaCobranza asc, c.docSerieNumero asc")
                    .setParameter("fechaInicio", fechaInicio)
                    .setParameter("fechaFin", fechaFin)
                    .setParameter("serie", serie + "%")
                    .setParameter("codCobrador", codCobrador);
            return q.list();
        } catch (Exception e) {
            setError(e.getMessage());
        }
        return null;
    }

    public List leer_anulados_fechaInicio_fechaFin(Date fechaInicio, Date fechaFin) {
        setError(null);
        sesion = HibernateUtil.getSessionFactory().openSession();
        try {
            Query q = sesion.createQuery("from Cobranza c "
                    + "where c.fechaCobranza>=:fechaInicio "
                    + "and c.fechaCobranza<=:fechaFin "
                    + "and substring(c.registro,1,1)='0' "
                    + "order by c.fechaCobranza asc, c.docSerieNumero asc")
                    .setParameter("fechaInicio", fechaInicio)
                    .setParameter("fechaFin", fechaFin);
            return q.list();
        } catch (Exception e) {
            setError(e.getMessage());
        }
        return null;
    }

    public List leer_anulados_fechaInicio_fechaFin_codCobrador(Date fechaInicio, Date fechaFin, int codCobrador) {
        setError(null);
        sesion = HibernateUtil.getSessionFactory().openSession();
        try {
            Query q = sesion.createQuery("select c from Cobranza c, DatosCliente dc "
                    + "where c.persona=dc.persona "
                    + "and dc.codCobrador=:codCobrador "
                    + "and c.fechaCobranza>=:fechaInicio "
                    + "and c.fechaCobranza<=:fechaFin "
                    + "and substring(c.registro,1,1)='0' "
                    + "order by c.fechaCobranza asc, c.docSerieNumero asc")
                    .setParameter("fechaInicio", fechaInicio)
                    .setParameter("fechaFin", fechaFin)
                    .setParameter("codCobrador", codCobrador);
            return q.list();
        } catch (Exception e) {
            setError(e.getMessage());
        }
        return null;
    }

    public List leer_cobranzaGeneral(Date fechaInicio, Date fechaFin) {
        setError(null);
        sesion = HibernateUtil.getSessionFactory().openSession();
        try {
            Query q = sesion.createQuery("from Cobranza c "
                    + "where c.fechaCobranza>=:fechaInicio "
                    + "and c.fechaCobranza<=:fechaFin "
                    + "and (substring(c.registro,1,1)=1 or substring(c.registro,1,1)=0) "
                    + "and c.docSerieNumero not like 'XXX%' "
                    + "order by c.persona.nombresC, c.fechaCobranza")
                    .setParameter("fechaInicio", fechaInicio)
                    .setParameter("fechaFin", fechaFin);
            return q.list();
        } catch (Exception e) {
            setError(e.getMessage());
        }
        return null;
    }

    public List leer_codCobrador_cobranzaGeneral(Date fechaInicio, Date fechaFin, int codCobrador) {
        setError(null);
        sesion = HibernateUtil.getSessionFactory().openSession();
        try {
            Query q = sesion.createQuery("select c from Cobranza c, DatosCliente dc "
                    + "where c.persona=dc.persona "
                    + "and c.fechaCobranza>=:fechaInicio "
                    + "and c.fechaCobranza<=:fechaFin "
                    + "and (substring(c.registro,1,1)=1 or substring(c.registro,1,1)=0) "
                    + "and c.docSerieNumero not like 'XXX%' "
                    + "and dc.codCobrador=:codCobrador "
                    + "order by c.persona.nombresC, c.fechaCobranza")
                    .setParameter("fechaInicio", fechaInicio)
                    .setParameter("fechaFin", fechaFin)
                    .setParameter("codCobrador", codCobrador);
            return q.list();
        } catch (Exception e) {
            setError(e.getMessage());
        }
        return null;
    }

    public List leer_admin() {
        setError(null);
        try {
            sesion = HibernateUtil.getSessionFactory().openSession();
            Query q = sesion.createQuery("from Cobranza");
            return (List) q.list();
        } catch (Exception e) {
            setError(e.getMessage());
        }
        return null;
    }

    public boolean actualizar_registro(int codCobranza, String estado, String user) {
        cUtilitarios objUtilitarios = new cUtilitarios();
        Boolean est = false;
        setError(null);
        Transaction trns = null;
        sesion = HibernateUtil.getSessionFactory().openSession();
        try {
            Cobranza obj = (Cobranza) sesion.get(Cobranza.class, codCobranza);
            obj.setRegistro(objUtilitarios.registro(estado, user));
            trns = sesion.beginTransaction();
            sesion.update(obj);
            sesion.getTransaction().commit();
            est = true;
        } catch (Exception e) {
            if (trns != null) {
                setError(e.getMessage());
                trns.rollback();
            }
        } finally {
            sesion.flush();
            sesion.close();
        }
        return est;
    }

    public boolean actualizar_importe_saldo_registro(int codCobranza, String registro) {
        Boolean est = false;
        setError(null);
        Transaction trns = null;
        sesion = HibernateUtil.getSessionFactory().openSession();
        try {
            Cobranza obj = (Cobranza) sesion.get(Cobranza.class, codCobranza);
            obj.setRegistro(registro);
            obj.setSaldoAnterior(0.00);
            obj.setImporte(0.00);
            obj.setSaldo(0.00);
            trns = sesion.beginTransaction();
            sesion.update(obj);
            sesion.getTransaction().commit();
            return true;
        } catch (Exception e) {
            if (trns != null) {
                setError(e.getMessage());
                trns.rollback();
            }
        } finally {
            sesion.flush();
            sesion.close();
        }
        return est;
    }

    /**
     *
     * @param codCobranza
     * @param obsevacion
     * @param importe total de pago realizados
     * @param saldo resto si en caso el monto amortizado superaba la deuda
     * @return
     */
    public boolean actualizar_observacion_saldo(int codCobranza, String obsevacion, double importe, double saldo) {
        setError(null);
        sesion = HibernateUtil.getSessionFactory().openSession();
        sesion.getTransaction().begin();
        Cobranza obj = (Cobranza) sesion.get(Cobranza.class, codCobranza);
        obj.setObservacion(obsevacion);
        obj.setImporte(importe);
        obj.setSaldo(saldo);
        try {
            sesion.update(obj);
            sesion.getTransaction().commit();
            return true;
        } catch (Exception e) {
            sesion.getTransaction().rollback();
            setError("Tabla_actualizar_registro: " + e.getMessage());
        } finally {
            sesion.flush();
            sesion.close();
        }
        return false;
    }
}
