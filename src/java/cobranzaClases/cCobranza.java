/*
 * To change this template, choose Tools | Templates
 * and open the template in the editor.
 */
package cobranzaClases;

import java.util.Date;
import java.util.Iterator;
import java.util.List;
import org.hibernate.Query;
import org.hibernate.Session;
import org.hibernate.Transaction;
import otrasTablasClases.cDatosExtras;
import tablas.Cobranza;
import tablas.DatosExtras;
import HiberanteUtil.HibernateUtil;
import utilitarios.cOtros;

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
        this.error = null;
    }

    public int crear(Cobranza objCobranza) {
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
            Query q = sesion.createQuery("from Cobranza where substring(registro,1,1)=1");
            return (List) q.list();
        } catch (Exception e) {
            setError(e.getMessage());
        }
        return null;
    }

    public Cobranza leer_codCobranza(int codCobranza) {
        sesion = HibernateUtil.getSessionFactory().openSession();
        return (Cobranza) sesion.get(Cobranza.class, codCobranza);
    }

    /**
     * Retorna una el objeto cobranza buscado por el docSerieNumero
     *
     * @param docSerieNumero
     * @return objeto cobranza en caso haya coincidencia
     */
    public Cobranza leer_docSerieNumero(String docSerieNumero) {
        Cobranza obj = null;
        Transaction trns = null;
        sesion = HibernateUtil.getSessionFactory().openSession();
        try {
            Query q = sesion.createQuery("from Cobranza where (substring(registro,1,1)=1 or substring(registro,1,1)=0) and docSerieNumero=:docSerieNumero")
                    .setParameter("docSerieNumero", docSerieNumero)
                    .setMaxResults(1);
            obj = (Cobranza) q.list().get(0);
        } catch (Exception e) {
            setError(e.getMessage());
            e.printStackTrace();
        } finally {
            sesion.flush();
        }
        return obj;
    }

    /**
     * Permite ver si una cobranza se encuentra registrada.
     *
     * @param docSerieNumero
     * @return True si esta registrdo o False si no esta.
     */
    public Boolean siExiste_SC(String docSerieNumero) {
        Boolean est = false;
        Transaction trns = null;
        sesion = HibernateUtil.getSessionFactory().openSession();
        try {
            trns = sesion.beginTransaction();
            Cobranza obj = (Cobranza) sesion.createQuery("from Cobranza"
                    + " where (substring(registro,1,1)=1 or substring(registro,1,1)=0)"
                    + " and docSerieNumero = :docSerieNumero")
                    .setParameter("docSerieNumero", docSerieNumero)
                    .setMaxResults(1) //solo un registro
                    .list() //casteamos lis
                    .get(0);            //la primera poscion
            if (obj != null) {
                est = true;
            }
        } catch (Exception e) {
            setError(e.getMessage());
            e.printStackTrace();
        } finally {
            sesion.flush();
            sesion.close();
        }
        return est;
    }

    /**
     * Me retorna un array con todos los pagos que ha realizado un cliente.
     * ordenados por codCobranza.
     *
     * @param codPersona
     * @return Array con pagos de un cliente
     */
    public List leer_codPersona(int codPersona) {
        List cobranzaList = null;
        Transaction trns = null;
        sesion = HibernateUtil.getSessionFactory().openSession();
        try {

            Query q = sesion.createQuery("from Cobranza c where substring(registro,1,1)=1 "
                    + "and c.persona.codPersona=:codPersona order by codCobranza asc")
                    .setParameter("codPersona", codPersona);
            cobranzaList = q.list();
        } catch (Exception e) {
            e.printStackTrace();
            setError(e.getMessage());
        } finally {
            sesion.flush();
        }
        return cobranzaList;
    }

    //<editor-fold defaultstate="collapsed" desc="Método(s) para reporte cobranza. Clic en el signo + de la izquierda para mas detalles.">
    //<editor-fold defaultstate="collapsed" desc="Método: leer_documentoCaja_query(String abreviatura, boolean and). Clic en el signo + de la izquierda para mas detalles.">
    /**
     * Genera un String con la consulta que se hará para los datos referentes a
     * los códigos de cobranza.
     *
     * @param abreviatura
     * @param and
     * @return
     */
    public String leer_documentoCaja_query(String abreviatura, boolean and) {
        String queryString = "";
        List documentoCajaList = new cDatosExtras().leer_documentoCaja();
        int contador = 0;
        for (Iterator it = documentoCajaList.iterator(); it.hasNext();) {
            DatosExtras objDE = (DatosExtras) it.next();
            if (contador++ > 0) {
                queryString += " or";
            }
            queryString += " substring(" + abreviatura + ".docSerieNumero,1," + objDE.getLetras().length() + ")='" + objDE.getLetras() + "'";
        }
        if (and & queryString.length() > 0) {
            queryString = " and (" + queryString + ")";
        }
        return queryString;
    }
    //</editor-fold>

    //<editor-fold defaultstate="collapsed" desc="Método: leer_todo_todos_fechas_SC(Date fechaInicio, Date fechaFin). Clic en el signo + de la izquierda para mas detalles.">
    /**
     *
     * 0:codCliente, 1:nombresC, 2:codCobranza, 3:fechaCobranza,
     * 4:docSerieNumero, 5:total, 6:registro
     *
     * @param fechaInicio
     * @param fechaFin
     * @return
     */
    public List leer_todo_todos_fechas_SC(Date fechaInicio, Date fechaFin) {
        List l = null;
        Transaction trns = null;
        sesion = HibernateUtil.getSessionFactory().openSession();
        try {
            trns = sesion.beginTransaction();
            Query q = sesion.createQuery("select"
                    + " dc.codDatosCliente"
                    + " ,dc.persona.nombresC"
                    + " ,c.codCobranza"
                    + " ,c.fechaCobranza"
                    + " ,c.docSerieNumero"
                    + " ,( c.importe + c.saldo )"
                    + " ,c.registro"
                    + " from Cobranza c join c.persona.datosClientes dc"
                    + "	where (substring(c.registro,1,1) = 0 or substring(c.registro,1,1) = 1)" //hay casos con tipo 2 las cuales son las que deberian eliminarse pero se corservan por seguridad
                    + leer_documentoCaja_query("c", true)
                    + "	and c.fechaCobranza between :par1 and :par2"
                    + " order by c.fechaCobranza asc, c.docSerieNumero asc")
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
    //</editor-fold>

    //<editor-fold defaultstate="collapsed" desc="Método: leer_inicial_todos_fechas_SC(Date fechaInicio, Date fechaFin). Clic en el signo + de la izquierda para mas detalles.">
    /**
     *
     * 0:codCliente, 1:nombresC, 2:codCobranza, 3:fechaCobranza,
     * 4:docSerieNumero, 5:total, 6:registro
     *
     * @param fechaInicio
     * @param fechaFin
     * @return
     */
    public List leer_inicial_todos_fechas_SC(Date fechaInicio, Date fechaFin) {
        List l = null;
        Transaction trns = null;
        sesion = HibernateUtil.getSessionFactory().openSession();
        try {
            trns = sesion.beginTransaction();
            Query q = sesion.createQuery("select"
                    + " dc.codDatosCliente"
                    + " ,dc.persona.nombresC"
                    + " ,c.codCobranza"
                    + " ,c.fechaCobranza"
                    + " ,c.docSerieNumero"
                    + " ,( c.importe + c.saldo )"
                    + " ,c.registro"
                    + " from Cobranza c join c.persona.datosClientes dc"
                    + "	where (substring(c.registro,1,1) = 0 or substring(c.registro,1,1) = 1)" //hay casos con tipo 2 las cuales son las que deberian eliminarse pero se corservan por seguridad
                    + leer_documentoCaja_query("c", true)
                    + " and c.observacion like 'PAGO INICIAL%'"
                    + "	and c.fechaCobranza between :par1 and :par2"
                    + " order by c.fechaCobranza asc, c.docSerieNumero asc")
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
    //</editor-fold>

    //<editor-fold defaultstate="collapsed" desc="Método: leer_cobranza_todos_fechas_SC(Date fechaInicio, Date fechaFin). Clic en el signo + de la izquierda para mas detalles.">
    /**
     *
     * 0:codCliente, 1:nombresC, 2:codCobranza, 3:fechaCobranza,
     * 4:docSerieNumero, 5:total, 6:registro
     *
     * @param fechaInicio
     * @param fechaFin
     * @return
     */
    public List leer_cobranza_todos_fechas_SC(Date fechaInicio, Date fechaFin) {
        List l = null;
        Transaction trns = null;
        sesion = HibernateUtil.getSessionFactory().openSession();
        try {
            trns = sesion.beginTransaction();
            Query q = sesion.createQuery("select"
                    + " dc.codDatosCliente"
                    + " ,dc.persona.nombresC"
                    + " ,c.codCobranza"
                    + " ,c.fechaCobranza"
                    + " ,c.docSerieNumero"
                    + " ,( c.importe + c.saldo )"
                    + " ,c.registro"
                    + " from Cobranza c join c.persona.datosClientes dc"
                    + "	where (substring(c.registro,1,1) = 0 or substring(c.registro,1,1) = 1)" //hay casos con tipo 2 las cuales son las que deberian eliminarse pero se corservan por seguridad
                    + leer_documentoCaja_query("c", true)
                    + " and c.observacion like 'LETRA N%'"
                    + "	and c.fechaCobranza between :par1 and :par2"
                    + " order by c.fechaCobranza asc, c.docSerieNumero asc")
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
    //</editor-fold>

    //<editor-fold defaultstate="collapsed" desc="Método: leer_anticipo_todos_fechas_SC(Date fechaInicio, Date fechaFin). Clic en el signo + de la izquierda para mas detalles.">
    /**
     *
     * 0:codCliente, 1:nombresC, 2:codCobranza, 3:fechaCobranza,
     * 4:docSerieNumero, 5:total, 6:registro
     *
     * @param fechaInicio
     * @param fechaFin
     * @return
     */
    public List leer_anticipo_todos_fechas_SC(Date fechaInicio, Date fechaFin) {
        List l = null;
        Transaction trns = null;
        sesion = HibernateUtil.getSessionFactory().openSession();
        try {
            trns = sesion.beginTransaction();
            Query q = sesion.createQuery("select"
                    + " dc.codDatosCliente"
                    + " ,dc.persona.nombresC"
                    + " ,c.codCobranza"
                    + " ,c.fechaCobranza"
                    + " ,c.docSerieNumero"
                    + " ,( c.importe + c.saldo )"
                    + " ,c.registro"
                    + " from Cobranza c join c.persona.datosClientes dc"
                    + "	where (substring(c.registro,1,1) = 0 or substring(c.registro,1,1) = 1)" //hay casos con tipo 2 las cuales son las que deberian eliminarse pero se corservan por seguridad
                    + leer_documentoCaja_query("c", true)
                    + " and c.observacion like 'ANTICIPO%'"
                    + "	and c.fechaCobranza between :par1 and :par2"
                    + " order by c.fechaCobranza asc, c.docSerieNumero asc")
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
    //</editor-fold>

    //<editor-fold defaultstate="collapsed" desc="Método: leer_todo_cobrador_fechas_SC(Date fechaInicio, Date fechaFin, int codCobrador). Clic en el signo + de la izquierda para mas detalles.">
    /**
     *
     * 0:codCliente, 1:nombresC, 2:codCobranza, 3:fechaCobranza,
     * 4:docSerieNumero, 5:total, 6:registro
     *
     * @param fechaInicio
     * @param fechaFin
     * @param codCobrador
     * @return
     */
    public List leer_todo_cobrador_fechas_SC(Date fechaInicio, Date fechaFin, int codCobrador) {
        List l = null;
        Transaction trns = null;
        sesion = HibernateUtil.getSessionFactory().openSession();
        try {
            trns = sesion.beginTransaction();
            Query q = sesion.createQuery("select"
                    + " dc.codDatosCliente"
                    + " ,dc.persona.nombresC"
                    + " ,c.codCobranza"
                    + " ,c.fechaCobranza"
                    + " ,c.docSerieNumero"
                    + " ,( c.importe + c.saldo )"
                    + " ,c.registro"
                    + " from Cobranza c join c.persona.datosClientes dc"
                    + "	where (substring(c.registro,1,1) = 0 or substring(c.registro,1,1) = 1)" //hay casos con tipo 2 las cuales son las que deberian eliminarse pero se corservan por seguridad
                    + leer_documentoCaja_query("c", true)
                    + "	and c.fechaCobranza between :par1 and :par2"
                    + " and dc.codCobrador = :par3"
                    + " order by c.fechaCobranza asc, c.docSerieNumero asc")
                    .setDate("par1", fechaInicio)
                    .setDate("par2", fechaFin)
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
    //</editor-fold>

    //<editor-fold defaultstate="collapsed" desc="Método: leer_inicial_cobrador_fechas_SC(Date fechaInicio, Date fechaFin, int codCobrador). Clic en el signo + de la izquierda para mas detalles.">
    /**
     *
     * 0:codCliente, 1:nombresC, 2:codCobranza, 3:fechaCobranza,
     * 4:docSerieNumero, 5:total, 6:registro
     *
     * @param fechaInicio
     * @param fechaFin
     * @param codCobrador
     * @return
     */
    public List leer_inicial_cobrador_fechas_SC(Date fechaInicio, Date fechaFin, int codCobrador) {
        List l = null;
        Transaction trns = null;
        sesion = HibernateUtil.getSessionFactory().openSession();
        try {
            trns = sesion.beginTransaction();
            Query q = sesion.createQuery("select"
                    + " dc.codDatosCliente"
                    + " ,dc.persona.nombresC"
                    + " ,c.codCobranza"
                    + " ,c.fechaCobranza"
                    + " ,c.docSerieNumero"
                    + " ,( c.importe + c.saldo )"
                    + " ,c.registro"
                    + " from Cobranza c join c.persona.datosClientes dc"
                    + "	where (substring(c.registro,1,1) = 0 or substring(c.registro,1,1) = 1)" //hay casos con tipo 2 las cuales son las que deberian eliminarse pero se corservan por seguridad
                    + leer_documentoCaja_query("c", true)
                    + " and c.observacion like 'PAGO INICIAL%'"
                    + "	and c.fechaCobranza between :par1 and :par2"
                    + " and dc.codCobrador = :par3"
                    + " order by c.fechaCobranza asc, c.docSerieNumero asc")
                    .setDate("par1", fechaInicio)
                    .setDate("par2", fechaFin)
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
    //</editor-fold>

    //<editor-fold defaultstate="collapsed" desc="Método: leer_cobranza_cobrador_fechas_SC(Date fechaInicio, Date fechaFin, int codCobrador). Clic en el signo + de la izquierda para mas detalles.">
    /**
     *
     * 0:codCliente, 1:nombresC, 2:codCobranza, 3:fechaCobranza,
     * 4:docSerieNumero, 5:total, 6:registro
     *
     * @param fechaInicio
     * @param fechaFin
     * @param codCobrador
     * @return
     */
    public List leer_cobranza_cobrador_fechas_SC(Date fechaInicio, Date fechaFin, int codCobrador) {
        List l = null;
        Transaction trns = null;
        sesion = HibernateUtil.getSessionFactory().openSession();
        try {
            trns = sesion.beginTransaction();
            Query q = sesion.createQuery("select"
                    + " dc.codDatosCliente"
                    + " ,dc.persona.nombresC"
                    + " ,c.codCobranza"
                    + " ,c.fechaCobranza"
                    + " ,c.docSerieNumero"
                    + " ,( c.importe + c.saldo )"
                    + " ,c.registro"
                    + " from Cobranza c join c.persona.datosClientes dc"
                    + "	where (substring(c.registro,1,1) = 0 or substring(c.registro,1,1) = 1)" //hay casos con tipo 2 las cuales son las que deberian eliminarse pero se corservan por seguridad
                    + leer_documentoCaja_query("c", true)
                    + " and c.observacion like 'PAGO INICIAL%'"
                    + "	and c.fechaCobranza between :par1 and :par2"
                    + " and dc.codCobrador = :par3"
                    + " order by c.fechaCobranza asc, c.docSerieNumero asc")
                    .setDate("par1", fechaInicio)
                    .setDate("par2", fechaFin)
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
    //</editor-fold>

    //<editor-fold defaultstate="collapsed" desc="Método: leer_anticipo_cobrador_fechas_SC(Date fechaInicio, Date fechaFin, int codCobrador). Clic en el signo + de la izquierda para mas detalles.">
    /**
     *
     * 0:codCliente, 1:nombresC, 2:codCobranza, 3:fechaCobranza,
     * 4:docSerieNumero, 5:total, 6:registro
     *
     * @param fechaInicio
     * @param fechaFin
     * @param codCobrador
     * @return
     */
    public List leer_anticipo_cobrador_fechas_SC(Date fechaInicio, Date fechaFin, int codCobrador) {
        List l = null;
        Transaction trns = null;
        sesion = HibernateUtil.getSessionFactory().openSession();
        try {
            trns = sesion.beginTransaction();
            Query q = sesion.createQuery("select"
                    + " dc.codDatosCliente"
                    + " ,dc.persona.nombresC"
                    + " ,c.codCobranza"
                    + " ,c.fechaCobranza"
                    + " ,c.docSerieNumero"
                    + " ,( c.importe + c.saldo )"
                    + " ,c.registro"
                    + " from Cobranza c join c.persona.datosClientes dc"
                    + "	where (substring(c.registro,1,1) = 0 or substring(c.registro,1,1) = 1)" //hay casos con tipo 2 las cuales son las que deberian eliminarse pero se corservan por seguridad
                    + leer_documentoCaja_query("c", true)
                    + " and c.observacion like 'PAGO INICIAL%'"
                    + "	and c.fechaCobranza between :par1 and :par2"
                    + " and dc.codCobrador = :par3"
                    + " order by c.fechaCobranza asc, c.docSerieNumero asc")
                    .setDate("par1", fechaInicio)
                    .setDate("par2", fechaFin)
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
    //</editor-fold>

    //<editor-fold defaultstate="collapsed" desc="Método: leer_todo_documento_todos_fechas_SC(Date fechaInicio, Date fechaFin, String tipoSerie). Clic en el signo + de la izquierda para mas detalles.">
    /**
     *
     * @param fechaInicio
     * @param fechaFin
     * @param tipoSerie
     * @return
     */
    public List leer_todo_documento_todos_fechas_SC(Date fechaInicio, Date fechaFin, String tipoSerie) {
        List l = null;
        Transaction trns = null;
        sesion = HibernateUtil.getSessionFactory().openSession();
        try {
            trns = sesion.beginTransaction();
            Query q = sesion.createQuery("select"
                    + " dc.codDatosCliente"
                    + " ,dc.persona.nombresC"
                    + " ,c.codCobranza"
                    + " ,c.fechaCobranza"
                    + " ,c.docSerieNumero"
                    + " ,( c.importe + c.saldo )"
                    + " ,c.registro"
                    + " from Cobranza c join c.persona.datosClientes dc"
                    + "	where (substring(c.registro,1,1) = 0 or substring(c.registro,1,1) = 1)" //hay casos con tipo 2 las cuales son las que deberian eliminarse pero se corservan por seguridad
                    + "	and c.fechaCobranza between :par1 and :par2"
                    + " and c.docSerieNumero like :par3"
                    + " order by c.fechaCobranza asc, c.docSerieNumero asc")
                    .setDate("par1", fechaInicio)
                    .setDate("par2", fechaFin).
                    setString("par3", tipoSerie + "%");
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
    //</editor-fold>

    //<editor-fold defaultstate="collapsed" desc="Método: leer_todo_documento_cobrador_fechas_SC(Date fechaInicio, Date fechaFin, String tipoSerie, int codcobrador). Clic en el signo + de la izquierda para mas detalles.">
    /**
     *
     * @param fechaInicio
     * @param fechaFin
     * @param tipoSerie
     * @param codcobrador
     * @return
     */
    public List leer_todo_documento_cobrador_fechas_SC(Date fechaInicio, Date fechaFin, String tipoSerie, int codcobrador) {
        List l = null;
        Transaction trns = null;
        sesion = HibernateUtil.getSessionFactory().openSession();
        try {
            trns = sesion.beginTransaction();
            Query q = sesion.createQuery("select"
                    + " dc.codDatosCliente"
                    + " ,dc.persona.nombresC"
                    + " ,c.codCobranza"
                    + " ,c.fechaCobranza"
                    + " ,c.docSerieNumero"
                    + " ,( c.importe + c.saldo )"
                    + " ,c.registro"
                    + " from Cobranza c join c.persona.datosClientes dc"
                    + "	where (substring(c.registro,1,1) = 0 or substring(c.registro,1,1) = 1)" //hay casos con tipo 2 las cuales son las que deberian eliminarse pero se corservan por seguridad
                    + "	and c.fechaCobranza between :par1 and :par2"
                    + " and c.docSerieNumero like :par3"
                    + " and dc.codCobrador = :par4"
                    + " order by c.fechaCobranza asc, c.docSerieNumero asc")
                    .setDate("par1", fechaInicio)
                    .setDate("par2", fechaFin).
                    setString("par3", tipoSerie + "%")
                    .setInteger("par4", codcobrador);
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
    //</editor-fold> 

    //<editor-fold defaultstate="collapsed" desc="Método: leer_todo_anulado_todos_fechas_SC(Date fechaInicio, Date fechaFin). Clic en el signo + de la izquierda para mas detalles.">
    /**
     *
     * 0:codCliente, 1:nombresC, 2:codCobranza, 3:fechaCobranza,
     * 4:docSerieNumero, 5:total, 6:registro
     *
     * @param fechaInicio
     * @param fechaFin
     * @return
     */
    public List leer_todo_anulado_todos_fechas_SC(Date fechaInicio, Date fechaFin) {
        List l = null;
        Transaction trns = null;
        sesion = HibernateUtil.getSessionFactory().openSession();
        try {
            trns = sesion.beginTransaction();
            Query q = sesion.createQuery("select"
                    + " dc.codDatosCliente"
                    + " ,dc.persona.nombresC"
                    + " ,c.codCobranza"
                    + " ,c.fechaCobranza"
                    + " ,c.docSerieNumero"
                    + " ,( c.importe + c.saldo )"
                    + " ,c.registro"
                    + " from Cobranza c join c.persona.datosClientes dc"
                    + "	where substring(c.registro,1,1) = 0" //hay casos con tipo 2 las cuales son las que deberian eliminarse pero se corservan por seguridad
                    + leer_documentoCaja_query("c", true)
                    + "	and c.fechaCobranza between :par1 and :par2"
                    + " order by c.fechaCobranza asc, c.docSerieNumero asc")
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
    //</editor-fold>

    //<editor-fold defaultstate="collapsed" desc="Método: leer_todo_anulado_cobrador_fechas_SC(Date fechaInicio, Date fechaFin, int codCobrador). Clic en el signo + de la izquierda para mas detalles.">
    /**
     *
     * 0:codCliente, 1:nombresC, 2:codCobranza, 3:fechaCobranza,
     * 4:docSerieNumero, 5:total, 6:registro
     *
     * @param fechaInicio
     * @param fechaFin
     * @param codCobrador
     * @return
     */
    public List leer_todo_anulado_cobrador_fechas_SC(Date fechaInicio, Date fechaFin, int codCobrador) {
        List l = null;
        Transaction trns = null;
        sesion = HibernateUtil.getSessionFactory().openSession();
        try {
            trns = sesion.beginTransaction();
            Query q = sesion.createQuery("select"
                    + " dc.codDatosCliente"
                    + " ,dc.persona.nombresC"
                    + " ,c.codCobranza"
                    + " ,c.fechaCobranza"
                    + " ,c.docSerieNumero"
                    + " ,( c.importe + c.saldo )"
                    + " ,c.registro"
                    + " from Cobranza c join c.persona.datosClientes dc"
                    + "	where substring(c.registro,1,1) = 0" //hay casos con tipo 2 las cuales son las que deberian eliminarse pero se corservan por seguridad
                    + leer_documentoCaja_query("c", true)
                    + "	and c.fechaCobranza between :par1 and :par2"
                    + " and dc.codCobrador = :par3"
                    + " order by c.fechaCobranza asc, c.docSerieNumero asc")
                    .setDate("par1", fechaInicio)
                    .setDate("par2", fechaFin)
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
    //</editor-fold>

    //<editor-fold defaultstate="collapsed" desc="Método: leer_cobranzaPagos_todos(Date fechaInicio, Date fechaFin). Clic en el signo + de la izquierda para mas detalles.">
    /**
     *
     * @param fechaInicio
     * @param fechaFin
     * @return
     */
    public List leer_cobranzaPagos_todos(Date fechaInicio, Date fechaFin) {
        List l = null;
        Transaction trns = null;
        sesion = HibernateUtil.getSessionFactory().openSession();
        try {
            trns = sesion.beginTransaction();
            Query q = sesion.createQuery("select"
                    + " dc.codDatosCliente"
                    + " ,dc.persona.nombresC"
                    + " ,c.codCobranza"
                    + " ,c.fechaCobranza"
                    + " ,c.docSerieNumero"
                    + " ,( c.importe + c.saldo )"
                    + " ,c.registro"
                    + " ,c.observacion"
                    + " from Cobranza c join c.persona.datosClientes dc"
                    + "	where (substring(c.registro,1,1) = 0 or substring(c.registro,1,1) = 1)" //hay casos con tipo 2 las cuales son las que deberian eliminarse pero se corservan por seguridad
                    + " and c.docSerieNumero not like 'X%'"
                    + "	and c.fechaCobranza between :par1 and :par2"
                    + " order by dc.persona.nombresC, dc.codDatosCliente, c.fechaCobranza")
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
    //</editor-fold>

    //<editor-fold defaultstate="collapsed" desc="Método: leer_cobranzaPagos_cobrador(Date fechaInicio, Date fechaFin, int codCobrador). Clic en el signo + de la izquierda para mas detalles.">
    /**
     *
     * @param fechaInicio
     * @param fechaFin
     * @param codCobrador
     * @return
     */
    public List leer_cobranzaPagos_cobrador(Date fechaInicio, Date fechaFin, int codCobrador) {
        List l = null;
        Transaction trns = null;
        sesion = HibernateUtil.getSessionFactory().openSession();
        try {
            trns = sesion.beginTransaction();
            Query q = sesion.createQuery("select"
                    + " dc.codDatosCliente"
                    + " ,dc.persona.nombresC"
                    + " ,c.codCobranza"
                    + " ,c.fechaCobranza"
                    + " ,c.docSerieNumero"
                    + " ,( c.importe + c.saldo )"
                    + " ,c.registro"
                    + " from Cobranza c join c.persona.datosClientes dc"
                    + "	where (substring(c.registro,1,1) = 0 or substring(c.registro,1,1) = 1)" //hay casos con tipo 2 las cuales son las que deberian eliminarse pero se corservan por seguridad
                    + " and c.docSerieNumero not like 'X%'"
                    + "	and c.fechaCobranza between :par1 and :par2"
                    + " and dc.codCobrador = :par3"
                    + " order by dc.persona.nombresC, dc.codDatosCliente, c.fechaCobranza")
                    .setDate("par1", fechaInicio)
                    .setDate("par2", fechaFin)
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
    //</editor-fold>
    //</editor-fold>

    //<editor-fold defaultstate="collapsed" desc="Método(s) para borrar *borrar*. Clic en el signo + de la izquierda para mas detalles.">
    //*borrar*
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

    //*borrar*
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

    // *borrar*
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

    // *borrar*
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

    //*borrar
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

    //*borrar*
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

    //*borrar*
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

    //*borrar*
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

    //*borrar
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

    //*borrar*
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

    //*borrar
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

    //*borrar
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
    //</editor-fold>

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
        Boolean est = false;
        setError(null);
        Transaction trns = null;
        sesion = HibernateUtil.getSessionFactory().openSession();
        try {
            Cobranza obj = (Cobranza) sesion.get(Cobranza.class, codCobranza);
            obj.setRegistro(new cOtros().registro(estado, user));
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
            est = true;
        } catch (Exception e) {
            if (trns != null) {
                trns.rollback();
            }
            setError(e.getMessage());
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
        boolean est = false;
        Transaction trns = null;
        sesion = HibernateUtil.getSessionFactory().openSession();
        try {
            trns = sesion.beginTransaction();
            Cobranza obj = (Cobranza) sesion.get(Cobranza.class, codCobranza);
            obj.setObservacion(obsevacion);
            obj.setImporte(importe);
            obj.setSaldo(saldo);
            sesion.update(obj);
            sesion.getTransaction().commit();
            est = true;
        } catch (Exception e) {
            if (trns != null) {
                trns.rollback();
            }
            e.printStackTrace();
            setError("Tabla_actualizar_registro: " + e.getMessage());
        } finally {
            sesion.flush();
            sesion.close();
        }
        return est;
    }

    /**
     * ... se cierra la sesion así que no usar otras tablas
     *
     * @param codPersona
     * @return
     */
    public List leer_codPersona_SC(int codPersona) {
        List lCobranza = null;
        sesion = HibernateUtil.getSessionFactory().openSession();
        try {
            Query q = sesion.createQuery("from Cobranza c where substring(registro,1,1)=1 "
                    + "and c.persona.codPersona=:codPersona order by codCobranza asc")
                    .setParameter("codPersona", codPersona);
            lCobranza = q.list();
        } catch (Exception e) {
            e.printStackTrace();
            setError(e.getMessage());
        } finally {
            sesion.flush();
            sesion.close();
        }
        return lCobranza;
    }
}
