/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package Ejb;

import Dao.DaoCliente;
import HiberanteUtil.HibernateUtil;
import java.util.Date;
import java.util.List;
import javax.ejb.Stateless;
import org.hibernate.Session;
import org.hibernate.Transaction;
import tablas.DatosCliente;

/**
 *
 * @author Henrri
 */
@Stateless
public class EjbCliente {

    private DatosCliente cliente;
    private List<DatosCliente> clienteList;

    private String error;
    private Session session;
    private Transaction transaction;

    public EjbCliente() {
        cliente = new DatosCliente();
        clienteList = null;
    }

    public boolean crear() {
        boolean est = false;
        this.session = null;
        this.transaction = null;
        this.error = null;
        try {
            this.session = HibernateUtil.getSessionFactory().openSession();
            this.transaction = session.beginTransaction();
            DaoCliente DaoCliente = new DaoCliente();
            int codCliente = DaoCliente.crear(this.session, this.cliente);
            //actualizamos el código generado
            this.cliente.setCodDatosCliente(codCliente);
            this.transaction.commit();
            est = true;
        } catch (Exception e) {
            if (this.transaction != null) {
                this.transaction.rollback();
            }
            this.error = "Contacte al administrador << " + e.getMessage() + " >>";
            e.printStackTrace();
        } finally {
            if (this.session != null) {
                this.session.close();
            }
        }
        return est;
    }

    public DatosCliente leerCodigoCliente(int codCliente, boolean cerrarSession) {
        this.cliente = null;
        this.session = null;
        this.transaction = null;
        this.error = null;
        try {
            this.session = HibernateUtil.getSessionFactory().openSession();
            this.transaction = session.beginTransaction();
            DaoCliente DaoCliente = new DaoCliente();
            //leemos todos los clientes existentes en la base de datos
            this.cliente = DaoCliente.leerPorCodigo(this.session, codCliente);
            this.transaction.commit();
        } catch (Exception e) {
            if (this.transaction != null) {
                this.transaction.rollback();
            }
            this.error = "Contacte al administrador << " + e.getMessage() + " >>";
            e.printStackTrace();
        } finally {
            //la sesión se cerrará si es true el valor
            if (cerrarSession & this.session != null) {
                this.session.close();
            }
        }
        return this.cliente;
    }

    public DatosCliente leerPorCodigoPersona(int codPersona, boolean cerrarSession) {
        this.cliente = null;
        this.session = null;
        this.transaction = null;
        this.error = null;
        try {
            this.session = HibernateUtil.getSessionFactory().openSession();
            this.transaction = session.beginTransaction();
            DaoCliente DaoCliente = new DaoCliente();
            //leemos todos los clientes existentes en la base de datos
            this.cliente = DaoCliente.leerPorCodigoPersona(this.session, codPersona);
            this.transaction.commit();
        } catch (Exception e) {
            if (this.transaction != null) {
                this.transaction.rollback();
            }
            this.error = "Contacte al administrador << " + e.getMessage() + " >>";
            e.printStackTrace();
        } finally {
            //la sesión se cerrará si es true el valor
            if (cerrarSession & this.session != null) {
                this.session.close();
            }
        }
        return this.cliente;
    }

    /**
     * Lee solo los clientes que tengan el registro 1
     *
     * @return
     */
    public List leerClienteOrdenadoAlfabeticamente() {
        this.session = null;
        this.transaction = null;
        this.error = null;
        try {
            this.session = HibernateUtil.getSessionFactory().openSession();
            this.transaction = session.beginTransaction();
            DaoCliente DaoCliente = new DaoCliente();
            //leemos todos los clientes existentes en la base de datos
            this.clienteList = DaoCliente.leerClienteOrdenadoAlfabeticamente(this.session);
            this.transaction.commit();
        } catch (Exception e) {
            if (this.transaction != null) {
                this.transaction.rollback();
            }
            this.error = "Contacte al administrador << " + e.getMessage() + " >>";
            e.printStackTrace();
        } finally {
            if (this.session != null) {
                this.session.close();
            }
        }
        return this.clienteList;
    }

    public boolean actualizarInteresAsignar(int codCliente, Date interesEvitar, boolean interesEvitarPermanente) {
        boolean est = false;
        this.session = null;
        this.transaction = null;
        this.error = null;
        try {
            this.session = HibernateUtil.getSessionFactory().openSession();
            this.transaction = session.beginTransaction();
            DaoCliente daoCliente = new DaoCliente();
            //leemos todos los clientes existentes en la base de datos
            this.cliente = daoCliente.leerPorCodigo(this.session, codCliente);
            //procedemos a setear el interes asignar
            this.cliente.setInteresEvitar(interesEvitar);
            this.cliente.setInteresEvitarPermanente(interesEvitarPermanente);
            //actualizamos objeto
            daoCliente.actualizar(this.session, this.cliente);
            this.transaction.commit();
            est = true;
        } catch (Exception e) {
            if (this.transaction != null) {
                this.transaction.rollback();
            }
            this.error = "Contacte al administrador << " + e.getMessage() + " >>";
            e.printStackTrace();
        } finally {
            if (this.session != null) {
                this.session.close();
            }
        }
        return est;
    }

    public String getError() {
        return error;
    }

    public void setError(String error) {
        this.error = error;
    }

    public DatosCliente getCliente() {
        return cliente;
    }

    public void setCliente(DatosCliente cliente) {
        this.cliente = cliente;
    }

    public List<DatosCliente> getClienteList() {
        return clienteList;
    }

    public void setClienteList(List<DatosCliente> clienteList) {
        this.clienteList = clienteList;
    }
}
