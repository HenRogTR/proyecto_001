/*
 * To change this template, choose Tools | Templates
 * and open the template in the editor.
 */
package personaClases;

import java.util.Date;
import java.util.List;
import org.hibernate.Query;
import org.hibernate.Session;
import org.hibernate.Transaction;
import tablas.DatosCliente;
import HiberanteUtil.HibernateUtil;
import utilitarios.cOtros;

/**
 *
 * @author Henrri
 */
public class cDatosCliente {

    Session sesion = null;
    public String error;

    public String getError() {
        return error;
    }

    public void setError(String error) {
        this.error = error;
    }

    public cDatosCliente() {
        this.sesion = HibernateUtil.getSessionFactory().getCurrentSession();
        this.error = null;
    }

    public DatosCliente leer_codPersona(int codPersona) {
        DatosCliente objCliente = null;
        Transaction trns = null;
        sesion = HibernateUtil.getSessionFactory().openSession();
        try {
            trns = sesion.beginTransaction();
            Query q = sesion.createQuery("from DatosCliente d where substring(registro,1,1)=1 and d.persona.codPersona=:codPersona")
                    .setParameter("codPersona", codPersona);
            objCliente = (DatosCliente) q.list().iterator().next();
        } catch (Exception e) {
            e.printStackTrace();
            setError("Error en consulta datos clientes: " + e.getMessage());
        } finally {
            sesion.flush();
        }
        return objCliente;
    }

    public DatosCliente leer_cod(int codCliente) {
        sesion = HibernateUtil.getSessionFactory().openSession();
        return (DatosCliente) sesion.get(DatosCliente.class, codCliente);
    }

    /**
     *
     * @param codCliente
     * @return
     */
    public Object[] leer_codigo_SC(int codCliente) {
        Object objCliente[] = null;
        Transaction trns = null;
        sesion = HibernateUtil.getSessionFactory().openSession();
        try {
            trns = sesion.beginTransaction();
            Query q = sesion.createQuery("select dc.codDatosCliente"
                    + ", dc.persona.nombresC"
                    + ", dc.persona.direccion"
                    + ", dc.empresaConvenio.codEmpresaConvenio"
                    + ", dc.empresaConvenio.nombre"
                    + ", dc.empresaConvenio.codCobranza"
                    + ", dc.tipoCliente"
                    + ", dc.condicion"
                    + ", dc.saldoFavor"
                    + ", dc.interesEvitar"
                    + " from DatosCliente dc"
                    + " where dc = :par1")
                    .setInteger("par1", codCliente);
            objCliente = (Object[]) q.list().get(0);
        } catch (Exception e) {
            e.printStackTrace();
        } finally {
            sesion.flush();
        }
        return objCliente;
    }

    public DatosCliente leer_primero() {
        setError(null);
        sesion = HibernateUtil.getSessionFactory().openSession();
        try {
            Query q = sesion.createQuery("from DatosCliente dc where substring(dc.registro,1,1)=1 "
                    + "and substring(dc.persona.registro,1,1)=1 "
                    + "order by dc.codDatosCliente asc")
                    .setMaxResults(1);
            return (DatosCliente) q.list().iterator().next();
        } catch (Exception e) {
            setError("Error en consulta datos clientes: " + e.getMessage());
        }
        return null;
    }

    public DatosCliente leer_ultimo() {
        setError(null);
        sesion = HibernateUtil.getSessionFactory().openSession();
        try {
            Query q = sesion.createQuery("from DatosCliente dc where substring(dc.registro,1,1)=1 "
                    + "and substring(dc.persona.registro,1,1)=1 "
                    + "order by dc.codDatosCliente desc")
                    .setMaxResults(1);
            return (DatosCliente) q.list().iterator().next();
        } catch (Exception e) {
            setError("Error en consulta datos clientes: " + e.getMessage());
        }
        return null;
    }

    public List leer_nombresC_autocompletado_ordenadoNombresCAsc(String nombresC) {
        setError(null);
        sesion = HibernateUtil.getSessionFactory().openSession();
        try {
            Query q = sesion.createQuery("from DatosCliente dc where substring(dc.registro,1,1)=1 "
                    + "and substring(dc.persona.registro,1,1)=1 "
                    + "and dc.persona.nombresC like :nombresC "
                    + "order by dc.persona.nombresC asc")
                    .setParameter("nombresC", "%" + nombresC.replace(" ", "%") + "%");
            return q.list();
        } catch (Exception e) {
            setError("Error en consulta datos clientes: " + e.getMessage());
        }
        return null;
    }

    public List leer_dniPasaporte_autocompletado_ordenadoNombresCAsc(String dniPasaporteRuc) {
        setError(null);
        sesion = HibernateUtil.getSessionFactory().openSession();
        try {
            Query q = sesion.createQuery("from DatosCliente dc where substring(dc.registro,1,1)=1 "
                    + "and substring(dc.persona.registro,1,1)=1 "
                    + "and (dc.persona.dniPasaporte like :dniPasaporteRuc or dc.persona.ruc like :dniPasaporteRuc) "
                    + "order by dc.persona.nombresC asc")
                    .setParameter("dniPasaporteRuc", "%" + dniPasaporteRuc + "%");
            return q.list();
        } catch (Exception e) {
            setError("Error en consulta datos clientes: " + e.getMessage());
            System.out.println(e.getMessage());
        }
        return null;
    }

    public DatosCliente leer_dniPasaporte(String dniPasaporte) {
        setError(null);
        try {
            sesion = HibernateUtil.getSessionFactory().openSession();
            Query q = sesion.createQuery("from DatosCliente dc "
                    + "where (dc.persona.dniPasaporte=:dniPasaporte or substring(dc.persona.ruc,3,8) like :ruc) "
                    + "and substring(dc.registro,1,1)=1")
                    .setParameter("dniPasaporte", dniPasaporte)
                    .setParameter("ruc", "%" + dniPasaporte + "%");
            return (DatosCliente) q.list().iterator().next();
        } catch (Exception e) {
            setError(e.getMessage());
        }
        return null;
    }

    public DatosCliente leer_ruc(String ruc) {
        setError(null);
        try {
            sesion = HibernateUtil.getSessionFactory().openSession();
            Query q = sesion.createQuery("from DatosCliente dc "
                    + "where (dc.persona.dniPasaporte like :dniPasaporte or dc.persona.ruc=:ruc) "
                    + "and substring(dc.registro,1,1)=1")
                    .setParameter("dniPasaporte", "%" + ruc.substring(2, ruc.length() - 1) + "%")
                    .setParameter("ruc", ruc);
            return (DatosCliente) q.list().iterator().next();
        } catch (Exception e) {
            setError(e.getMessage());
        }
        return null;
    }

    public List leer_dniPasaporteRucNombresC_ordenado(String term) {
        setError(null);
        sesion = HibernateUtil.getSessionFactory().openSession();
        try {
            Query q = sesion.createQuery("from DatosCliente dc where substring(dc.registro,1,1)=1 "
                    + "and substring(dc.persona.registro,1,1)=1 "
                    + "and (dc.persona.dniPasaporte like :term or dc.persona.ruc like :term or dc.persona.nombresC like :term ) "
                    + "order by dc.persona.nombresC,dc.persona.dniPasaporte asc ,dc.persona.ruc asc")
                    .setParameter("term", "%" + term.replace(" ", "%") + "%");
            return q.list();
        } catch (Exception e) {
            setError(e.getMessage());
            System.out.println(e.getMessage());
        }
        return null;
    }

    /**
     *
     * @param term
     * @return Una lista de obejtos con 5 elementos [0]=codCliente,
     * [1]=codPersona, [2]=dniPasaporte [3]=ruc, [4]=nombresC
     */
    public List leer_dniPasaporteRucNombresC_ordenado_CS(String term) {
        List clienteList = null;
        Transaction trns = null;
        sesion = HibernateUtil.getSessionFactory().openSession();
        try {
            trns = sesion.beginTransaction();
            Query q = sesion.createQuery("select dc.codDatosCliente, p.codPersona, p.dniPasaporte, p.ruc, p.nombresC "
                    + "from Persona p, DatosCliente dc "
                    + "where p=dc.persona "
                    + "and (dc.persona.dniPasaporte like :term or dc.persona.ruc like :term or dc.persona.nombresC like :term ) "
                    + "order by dc.persona.nombresC, dc.persona.dniPasaporte asc, dc.persona.ruc asc")
                    .setParameter("term", "%" + term.replace(" ", "%") + "%");
            clienteList = q.list();
        } catch (RuntimeException e) {
            e.printStackTrace();
        } finally {
            sesion.flush();
            sesion.close();
        }
        return clienteList;
    }

    public int Crear(DatosCliente objDatosCliente) {
        setError(null);
        sesion = HibernateUtil.getSessionFactory().openSession();
        sesion.getTransaction().begin();
        try {
            int cod = (Integer) sesion.save(objDatosCliente);
            sesion.getTransaction().commit();
            return cod;
        } catch (Exception e) {
            sesion.getTransaction().rollback();
            e.printStackTrace();
            setError(e.getMessage());
        }
        return 0;
    }

    /**
     * Listado de clientes actuales.
     *
     * @return listado de clientes.
     */
    public List leer() {
        setError(null);
        try {
            sesion = HibernateUtil.getSessionFactory().openSession();
            Query q = sesion.createQuery("from DatosCliente "
                    + "where substring(registro,1,1)=1");
            return (List) q.list();
        } catch (Exception e) {
            setError(e.getMessage());
        }
        return null;
    }

    /**
     * lista con objeto <b>Pesona</b> ordenado alfabeticamente.
     *
     * @return
     */
    public List leer_ordenadoNombresC() {
        List l = null;
        Transaction trns = null;
        sesion = HibernateUtil.getSessionFactory().openSession();
        try {
            trns = sesion.beginTransaction();
            Query q = sesion.createQuery("from DatosCliente dc "
                    + "where substring(registro,1,1)=1 "
                    + "order by dc.persona.nombresC");
            l = q.list();
        } catch (Exception e) {
            e.printStackTrace();
        } finally {
            sesion.flush();
        }
        return l;
    }

    public List leer_codCobrador_ordenadoNombresC(int codCobrador) {
        setError(null);
        sesion = HibernateUtil.getSessionFactory().openSession();
        try {
            Query q = sesion.createQuery("from DatosCliente dc "
                    + "where substring(registro,1,1)=1 "
                    + "and dc.codCobrador=:codCobrador "
                    + "order by dc.persona.nombresC")
                    .setParameter("codCobrador", codCobrador);
            return q.list();
        } catch (Exception e) {
            setError(e.getMessage());
        }
        return null;
    }

    /**
     * lista con objeto <b>Pesona</b> ordenado por la dirección.
     *
     * @return
     */
    public List leer_ordenadoDireccion() {
        setError(null);
        sesion = HibernateUtil.getSessionFactory().openSession();
        try {
            Query q = sesion.createQuery("from DatosCliente dc "
                    + "where substring(registro,1,1)=1 "
                    + "order by dc.persona.direccion");
            return q.list();
        } catch (Exception e) {
            setError(e.getMessage());
        }
        return null;
    }

    public List leer_codCobrador_ordenadoDireccion(int codCobrador) {
        setError(null);
        sesion = HibernateUtil.getSessionFactory().openSession();
        try {
            Query q = sesion.createQuery("from DatosCliente dc "
                    + "where substring(registro,1,1)=1 "
                    + "and dc.codCobrador=:codCobrador "
                    + "order by dc.persona.direccion")
                    .setParameter("codCobrador", codCobrador);
            return q.list();
        } catch (Exception e) {
            setError(e.getMessage());
        }
        return null;
    }

    /**
     *
     * @param codEmpresaConvenio
     * @return
     */
    public List leer_empresaConvenio_ordenNombresC(int codEmpresaConvenio) {
        List l = null;
        Transaction trns = null;
        sesion = HibernateUtil.getSessionFactory().openSession();
        try {
            trns = sesion.beginTransaction();
            Query q = sesion.createQuery("from DatosCliente dc "
                    + "where substring(registro,1,1)=1 "
                    + "and dc.empresaConvenio.codEmpresaConvenio=:codEmpresaConvenio "
                    + "order by dc.persona.nombresC")
                    .setParameter("codEmpresaConvenio", codEmpresaConvenio);
            l = q.list();
        } catch (Exception e) {
            e.printStackTrace();
        } finally {
            sesion.flush();
        }
        return l;
    }

    public List leer_empresaConvenio_tipo_ordenNombresC(int codEmpresaConvenio, int tipo) {
        List l = null;
        Transaction trns = null;
        sesion = HibernateUtil.getSessionFactory().openSession();
        try {
            trns = sesion.beginTransaction();
            Query q = sesion.createQuery("from DatosCliente dc "
                    + "where substring(registro,1,1)=1 "
                    + "and dc.empresaConvenio.codEmpresaConvenio=:codEmpresaConvenio "
                    + "and dc.tipo=:tipo "
                    + "order by dc.persona.nombresC")
                    .setParameter("codEmpresaConvenio", codEmpresaConvenio)
                    .setParameter("tipo", tipo);
            l = q.list();
        } catch (Exception e) {
            e.printStackTrace();
        } finally {
            sesion.flush();
        }
        return l;
    }

    public List leer_empresaConvenio_tipo_condicion_ordenNombresC(int codEmpresaConvenio, int tipo, int condicion) {
        List l = null;
        Transaction trns = null;
        sesion = HibernateUtil.getSessionFactory().openSession();
        try {
            trns = sesion.beginTransaction();
            Query q = sesion.createQuery("from DatosCliente dc "
                    + "where substring(registro,1,1)=1 "
                    + "and dc.empresaConvenio.codEmpresaConvenio=:codEmpresaConvenio "
                    + "and dc.tipo=:tipo "
                    + "and dc.condicion=:condicion "
                    + "order by dc.persona.nombresC")
                    .setParameter("codEmpresaConvenio", codEmpresaConvenio)
                    .setParameter("tipo", tipo)
                    .setParameter("condicion", condicion);
            l = q.list();
        } catch (Exception e) {
            e.printStackTrace();
        } finally {
            sesion.flush();
        }
        return l;
    }

    public List leer_codCobrador_empresaConvenio_ordenNombresC(int codEmpresaConvenio, int codCobrador) {
        List l = null;
        Transaction trns = null;
        sesion = HibernateUtil.getSessionFactory().openSession();
        try {
            trns = sesion.beginTransaction();
            Query q = sesion.createQuery("from DatosCliente dc "
                    + "where substring(registro,1,1)=1 "
                    + "and dc.codCobrador=:codCobrador "
                    + "and dc.empresaConvenio.codEmpresaConvenio=:codEmpresaConvenio "
                    + "order by dc.persona.nombresC")
                    .setParameter("codEmpresaConvenio", codEmpresaConvenio)
                    .setParameter("codCobrador", codCobrador);
            l = q.list();
        } catch (Exception e) {
            e.printStackTrace();
        } finally {
            sesion.flush();
        }
        return l;
    }

    public List leer_empresaConvenio_ordenDireccion(int codEmpresaConvenio) {
        List l = null;
        Transaction trns = null;
        sesion = HibernateUtil.getSessionFactory().openSession();
        try {
            trns = sesion.beginTransaction();
            Query q = sesion.createQuery("from DatosCliente dc "
                    + "where substring(registro,1,1)=1 "
                    + "and dc.empresaConvenio.codEmpresaConvenio=:codEmpresaConvenio "
                    + "order by dc.persona.direccion")
                    .setParameter("codEmpresaConvenio", codEmpresaConvenio);
            l = q.list();
        } catch (Exception e) {
            e.printStackTrace();
        } finally {
            sesion.flush();
        }
        return l;
    }

    public List leer_empresaConvenio_tipo_ordenDireccion(int codEmpresaConvenio, int tipo) {
        List l = null;
        Transaction trns = null;
        sesion = HibernateUtil.getSessionFactory().openSession();
        try {
            trns = sesion.beginTransaction();
            Query q = sesion.createQuery("from DatosCliente dc "
                    + "where substring(registro,1,1)=1 "
                    + "and dc.empresaConvenio.codEmpresaConvenio=:codEmpresaConvenio "
                    + "and dc.tipo=:tipo "
                    + "order by dc.persona.direccion")
                    .setParameter("codEmpresaConvenio", codEmpresaConvenio)
                    .setParameter("tipo", tipo);
            l = q.list();
        } catch (Exception e) {
            e.printStackTrace();
        } finally {
            sesion.flush();
        }
        return l;
    }

    public List leer_empresaConvenio_tipo_condicion_ordenDireccion(int codEmpresaConvenio, int tipo, int condicion) {
        List l = null;
        Transaction trns = null;
        sesion = HibernateUtil.getSessionFactory().openSession();
        try {
            trns = sesion.beginTransaction();
            Query q = sesion.createQuery("from DatosCliente dc "
                    + "where substring(registro,1,1)=1 "
                    + "and dc.empresaConvenio.codEmpresaConvenio=:codEmpresaConvenio "
                    + "and dc.tipo=:tipo "
                    + "and dc.condicion=:condicion "
                    + "order by dc.persona.direccion")
                    .setParameter("codEmpresaConvenio", codEmpresaConvenio)
                    .setParameter("tipo", tipo)
                    .setParameter("condicion", condicion);
            l = q.list();
        } catch (Exception e) {
            e.printStackTrace();
        } finally {
            sesion.flush();
        }
        return l;
    }

    public List leer_codCobrador_empresaConvenio_ordenDireccion(int codEmpresaConvenio, int codCobrador) {
        List l = null;
        Transaction trns = null;
        sesion = HibernateUtil.getSessionFactory().openSession();
        try {
            trns = sesion.beginTransaction();
            Query q = sesion.createQuery("from DatosCliente dc "
                    + "where substring(registro,1,1)=1 "
                    + "and dc.codCobrador=:codCobrador "
                    + "and dc.empresaConvenio.codEmpresaConvenio=:codEmpresaConvenio "
                    + "order by dc.persona.direccion")
                    .setParameter("codEmpresaConvenio", codEmpresaConvenio)
                    .setParameter("codCobrador", codCobrador);
            l = q.list();
        } catch (Exception e) {
            e.printStackTrace();
        } finally {
            sesion.flush();
        }
        return l;
    }

    public DatosCliente leer_codDatosCliente(int codDatosCliente) {
        sesion = HibernateUtil.getSessionFactory().openSession();
        return (DatosCliente) sesion.get(DatosCliente.class, codDatosCliente);
    }

    /**
     *
     * @param codPersona
     * @return
     */
    public Double saldoFavor(int codPersona) {
        setError(null);
        sesion = HibernateUtil.getSessionFactory().openSession();
        try {
            Query q = sesion.createQuery("select saldoFavor from DatosCliente d where substring(registro,1,1)=1 and d.persona.codPersona=:codPersona")
                    .setParameter("codPersona", codPersona);
            return (Double) q.list().iterator().next();
        } catch (Exception e) {
            setError("Error en consulta datos clientes: " + e.getMessage());
        }
        return 0.00;
    }

    public List leer_admin() {
        setError(null);
        try {
            sesion = HibernateUtil.getSessionFactory().openSession();
            Query q = sesion.createQuery("from DatosCliente");
            return (List) q.list();
        } catch (Exception e) {
            setError(e.getMessage());
        }
        return null;
    }

    public boolean actualizar(DatosCliente objDatosCliente) {
        sesion = HibernateUtil.getSessionFactory().openSession();
        sesion.getTransaction().begin();
        try {
            sesion.update(objDatosCliente);
            sesion.getTransaction().commit();
            return true;
        } catch (Exception e) {
            sesion.getTransaction().rollback();
            e.printStackTrace();
            setError("DatosCliente_actualizar: " + e.getMessage());
        }
        return false;
    }

    public boolean actualizar_registro(int codDatosCliente, String estado, String user) {
        setError(null);
        sesion = HibernateUtil.getSessionFactory().openSession();
        sesion.getTransaction().begin();
        DatosCliente obj = (DatosCliente) sesion.get(DatosCliente.class, codDatosCliente);
        obj.setRegistro(new cOtros().registro(estado, user));
        try {
            sesion.update(obj);
            sesion.getTransaction().commit();
            return true;
        } catch (Exception e) {
            sesion.getTransaction().rollback();
            setError("DatosCliente_actualizar_registro: " + e.getMessage());
        }
        return false;
    }

    public boolean actualizar_saldoFavor(int codDatosCliente, Double saldoFavor) {
        boolean estado = false;
        Transaction trns = null;
        sesion = HibernateUtil.getSessionFactory().openSession();
        try {
            trns = sesion.beginTransaction();
            DatosCliente obj = (DatosCliente) sesion.get(DatosCliente.class, codDatosCliente);
            Double tem = obj.getSaldoFavor();
            System.out.println("SA actual" + obj.getSaldoFavor() + "******************" + saldoFavor);
            obj.setSaldoFavor(tem + saldoFavor);
            sesion.update(obj);
            sesion.getTransaction().commit();
            estado = true;
        } catch (Exception e) {
            if (trns != null) {
                trns.rollback();
            }
            setError(e.getMessage());
            e.printStackTrace();
        } finally {
            sesion.flush();
            sesion.close();
        }
        return estado;
    }

    public boolean actualizar_interesEvitar(int codCliente, Date fecha) {
        boolean estado = false;
        Transaction trns = null;
        sesion = HibernateUtil.getSessionFactory().openSession();
        try {
            trns = sesion.beginTransaction();
            DatosCliente obj = (DatosCliente) sesion.get(DatosCliente.class, codCliente);
            obj.setInteresEvitar(fecha);
            sesion.update(obj);
            sesion.getTransaction().commit();
            estado = true;
        } catch (Exception e) {
            if (trns != null) {
                trns.rollback();
            }
            setError(e.getMessage());
            e.printStackTrace();
        } finally {
            sesion.flush();
            sesion.close();
        }
        return estado;
    }

    public boolean actualizar_cobrador(int codDatoCliente, int codCobrador) {
        setError(null);
        sesion = HibernateUtil.getSessionFactory().openSession();
        sesion.getTransaction().begin();
        DatosCliente obj = (DatosCliente) sesion.get(DatosCliente.class, codDatoCliente);
        obj.setCodCobrador(codCobrador);
        try {
            sesion.update(obj);
            sesion.getTransaction().commit();
            return true;
        } catch (Exception e) {
            sesion.getTransaction().rollback();
            setError("DatosCliente_codCobrador: " + e.getMessage());
        }
        return false;
    }

    public boolean actualizar_tipoCliente(int codDatoCliente, int tipoCliente) {
        setError(null);
        sesion = HibernateUtil.getSessionFactory().openSession();
        sesion.getTransaction().begin();
        DatosCliente obj = (DatosCliente) sesion.get(DatosCliente.class, codDatoCliente);
        obj.setTipoCliente(tipoCliente);
        try {
            sesion.update(obj);
            sesion.getTransaction().commit();
            return true;
        } catch (Exception e) {
            sesion.getTransaction().rollback();
            setError("DatosCliente_codCobrador: " + e.getMessage());
        }
        return false;
    }

    public static String tipoCliente(int tipo) {
        switch (tipo) {
            case 1:
                return "ACTIVO";
            case 2:
                return "4 SUELDOS";
            case 3:
                return "CESANTE";
            case 4:
                return "PARTICULAR";
        }
        return "";
    }

    public static String condicionCliente(int condicion) {
        switch (condicion) {
            case 2:
                return "NOMBRADO";
            case 1:
                return "CONTRATADO";
            case 3:
                return "OTROS";
        }
        return "";
    }

}
