/*
 * To change this template, choose Tools | Templates
 * and open the template in the editor.
 */
package personaClases;

import java.util.List;
import org.hibernate.Query;
import org.hibernate.Transaction;
import org.hibernate.classic.Session;
import otros.cUtilitarios;
import tablas.DatosCliente;
import tablas.HibernateUtil;

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
    }

    //***************************************************
    public DatosCliente leer_codPersona(int codPersona) {
        setError(null);
        sesion = HibernateUtil.getSessionFactory().openSession();
        try {
            Query q = sesion.createQuery("from DatosCliente d where substring(registro,1,1)=1 and d.persona.codPersona=:codPersona")
                    .setParameter("codPersona", codPersona);
            return (DatosCliente) q.list().iterator().next();
        } catch (Exception e) {
            setError("Error en consulta datos clientes: " + e.getMessage());
        }
        return null;
    }

    public DatosCliente leer_cod(int codCliente) {
        Session session = HibernateUtil.getSessionFactory().openSession();
        return (DatosCliente) session.get(DatosCliente.class, codCliente);
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

    public List leer_nombresC_autocompletado(String nombresC) {
        setError(null);
        sesion = HibernateUtil.getSessionFactory().openSession();
        try {
            Query q = sesion.createQuery("from DatosCliente dc where substring(dc.registro,1,1)=1 "
                    + "and substring(dc.persona.registro,1,1)=1 "
                    + "and dc.persona.nombresC like :nombresC")
                    .setParameter("nombresC", "%" + nombresC + "%");
            return q.list();
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
                    .setParameter("nombresC", "%" + nombresC + "%");
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
                    + "where (dc.persona.dniPasaporte=:dniPasaporte or dc.persona.ruc like :ruc) "
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
                    .setParameter("term", "%" + term + "%");
            return q.list();
        } catch (Exception e) {
            setError(e.getMessage());
            System.out.println(e.getMessage());
        }
        return null;
    }

    //***************************************************
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
        setError(null);
        sesion = HibernateUtil.getSessionFactory().openSession();
        try {
            Query q = sesion.createQuery("from DatosCliente dc "
                    + "where substring(registro,1,1)=1 "
                    + "order by dc.persona.nombresC");
            return q.list();
        } catch (Exception e) {
            setError(e.getMessage());
        }
        return null;
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
    public List leer_empresaConvenio_ordenadoNombresC(int codEmpresaConvenio) {
        setError(null);
        sesion = HibernateUtil.getSessionFactory().openSession();
        try {
            Query q = sesion.createQuery("from DatosCliente dc "
                    + "where substring(registro,1,1)=1 "
                    + "and dc.empresaConvenio.codEmpresaConvenio=:codEmpresaConvenio "
                    + "order by dc.persona.nombresC")
                    .setParameter("codEmpresaConvenio", codEmpresaConvenio);
            return q.list();
        } catch (Exception e) {
            setError(e.getMessage());
        }
        return null;
    }

    public List leer_empresaConvenio_tipo_ordenadoNombresC(int codEmpresaConvenio, int tipo) {
        setError(null);
        sesion = HibernateUtil.getSessionFactory().openSession();
        try {
            Query q = sesion.createQuery("from DatosCliente dc "
                    + "where substring(registro,1,1)=1 "
                    + "and dc.empresaConvenio.codEmpresaConvenio=:codEmpresaConvenio "
                    + "and dc.tipo=:tipo "
                    + "order by dc.persona.nombresC")
                    .setParameter("codEmpresaConvenio", codEmpresaConvenio)
                    .setParameter("tipo", tipo);
            return q.list();
        } catch (Exception e) {
            setError(e.getMessage());
        }
        return null;
    }

    public List leer_empresaConvenio_tipo_condicion_ordenadoNombresC(int codEmpresaConvenio, int tipo, int condicion) {
        setError(null);
        sesion = HibernateUtil.getSessionFactory().openSession();
        try {
            Query q = sesion.createQuery("from DatosCliente dc "
                    + "where substring(registro,1,1)=1 "
                    + "and dc.empresaConvenio.codEmpresaConvenio=:codEmpresaConvenio "
                    + "and dc.tipo=:tipo "
                    + "and dc.condicion=:condicion "
                    + "order by dc.persona.nombresC")
                    .setParameter("codEmpresaConvenio", codEmpresaConvenio)
                    .setParameter("tipo", tipo)
                    .setParameter("condicion", condicion);
            return q.list();
        } catch (Exception e) {
            setError(e.getMessage());
        }
        return null;
    }

    public List leer_codCobrador_empresaConvenio_ordenadoNombresC(int codEmpresaConvenio, int codCobrador) {
        setError(null);
        sesion = HibernateUtil.getSessionFactory().openSession();
        try {
            Query q = sesion.createQuery("from DatosCliente dc "
                    + "where substring(registro,1,1)=1 "
                    + "and dc.codCobrador=:codCobrador "
                    + "and dc.empresaConvenio.codEmpresaConvenio=:codEmpresaConvenio "
                    + "order by dc.persona.nombresC")
                    .setParameter("codEmpresaConvenio", codEmpresaConvenio)
                    .setParameter("codCobrador", codCobrador);
            return q.list();
        } catch (Exception e) {
            setError(e.getMessage());
        }
        return null;
    }

    public List leer_empresaConvenio_ordenadoDireccion(int codEmpresaConvenio) {
        setError(null);
        sesion = HibernateUtil.getSessionFactory().openSession();
        try {
            Query q = sesion.createQuery("from DatosCliente dc "
                    + "where substring(registro,1,1)=1 "
                    + "and dc.empresaConvenio.codEmpresaConvenio=:codEmpresaConvenio "
                    + "order by dc.persona.direccion")
                    .setParameter("codEmpresaConvenio", codEmpresaConvenio);
            return q.list();
        } catch (Exception e) {
            setError(e.getMessage());
        }
        return null;
    }

    public List leer_empresaConvenio_tipo_ordenadoDireccion(int codEmpresaConvenio, int tipo) {
        setError(null);
        sesion = HibernateUtil.getSessionFactory().openSession();
        try {
            Query q = sesion.createQuery("from DatosCliente dc "
                    + "where substring(registro,1,1)=1 "
                    + "and dc.empresaConvenio.codEmpresaConvenio=:codEmpresaConvenio "
                    + "and dc.tipo=:tipo "
                    + "order by dc.persona.direccion")
                    .setParameter("codEmpresaConvenio", codEmpresaConvenio)
                    .setParameter("tipo", tipo);
            return q.list();
        } catch (Exception e) {
            setError(e.getMessage());
        }
        return null;
    }

    public List leer_empresaConvenio_tipo_condicion_ordenadoDireccion(int codEmpresaConvenio, int tipo, int condicion) {
        setError(null);
        sesion = HibernateUtil.getSessionFactory().openSession();
        try {
            Query q = sesion.createQuery("from DatosCliente dc "
                    + "where substring(registro,1,1)=1 "
                    + "and dc.empresaConvenio.codEmpresaConvenio=:codEmpresaConvenio "
                    + "and dc.tipo=:tipo "
                    + "and dc.condicion=:condicion "
                    + "order by dc.persona.direccion")
                    .setParameter("codEmpresaConvenio", codEmpresaConvenio)
                    .setParameter("tipo", tipo)
                    .setParameter("condicion", condicion);
            return q.list();
        } catch (Exception e) {
            setError(e.getMessage());
        }
        return null;
    }

    public List leer_codCobrador_empresaConvenio_ordenadoDireccion(int codEmpresaConvenio, int codCobrador) {
        setError(null);
        sesion = HibernateUtil.getSessionFactory().openSession();
        try {
            Query q = sesion.createQuery("from DatosCliente dc "
                    + "where substring(registro,1,1)=1 "
                    + "and dc.codCobrador=:codCobrador "
                    + "and dc.empresaConvenio.codEmpresaConvenio=:codEmpresaConvenio "
                    + "order by dc.persona.direccion")
                    .setParameter("codEmpresaConvenio", codEmpresaConvenio)
                    .setParameter("codCobrador", codCobrador);
            return q.list();
        } catch (Exception e) {
            setError(e.getMessage());
        }
        return null;
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
        cUtilitarios objUtilitarios = new cUtilitarios();
        setError(null);
        sesion = HibernateUtil.getSessionFactory().openSession();
        sesion.getTransaction().begin();
        DatosCliente obj = (DatosCliente) sesion.get(DatosCliente.class, codDatosCliente);
        obj.setRegistro(objUtilitarios.registro(estado, user));
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
        setError(null);
        Boolean estado = false;
        Transaction trns = null;
        sesion = HibernateUtil.getSessionFactory().openSession();
        try {
            trns = sesion.beginTransaction();
            DatosCliente obj = (DatosCliente) sesion.get(DatosCliente.class, codDatosCliente);
            Double tem = obj.getSaldoFavor();
            System.out.println(obj.getSaldoFavor() + "******************" + saldoFavor);
            obj.setSaldoFavor(tem + saldoFavor);
            sesion.update(obj);
            sesion.getTransaction().commit();
            estado = true;
        } catch (Exception e) {
            if (trns != null) {
                trns.rollback();
            }
            setError(e.getMessage());
            System.out.println("***************************" + e.getMessage());
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

    public String tipoCliente(int tipo) {
        switch (tipo) {
            case 1:
                return "Activo";
            case 2:
                return "4 Sueldos";
            case 3:
                return "Cesante";
            case 4:
                return "Particular";
        }
        return "";
    }

    public String condicionCliente(int condicion) {
        switch (condicion) {
            case 2:
                return "Nombrado";
            case 1:
                return "Contratado";
            case 3:
                return "Otros";
        }
        return "";
    }
    
    
}
