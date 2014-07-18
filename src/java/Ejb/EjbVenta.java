/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package Ejb;

import Dao.DaoVenta;
import HiberanteUtil.HibernateUtil;
import java.util.List;
import javax.ejb.Stateless;
import org.hibernate.Transaction;
import org.hibernate.Session;
import tablas.Ventas;

/**
 *
 * @author Henrri
 */
@Stateless
public class EjbVenta {

    private Ventas venta;
    private List<Ventas> ventaList;
    private List<Object[]> ventaObjects;

    private String error;
    private Session session;
    private Transaction transaction;

    public EjbVenta() {
        venta = new Ventas();
        ventaList = null;
        ventaObjects = null;
        error = null;
    }

    public List<Ventas> leerPorCodigoCliente(int codCliente, boolean cerrarSession) {
        this.session = null;
        this.transaction = null;
        try {
            this.session = HibernateUtil.getSessionFactory().openSession();
            this.transaction = session.beginTransaction();
            DaoVenta daoVenta = new DaoVenta();
            //Ventas que tiene un cliente
            this.ventaList = daoVenta.leerPorCodigoCliente(this.session, codCliente);
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
        return this.ventaList;
    }

    public List<Object[]> leerPorCodigoClienteReporte(int codCliente) {
        this.session = null;
        this.transaction = null;
        try {
            this.session = HibernateUtil.getSessionFactory().openSession();
            this.transaction = session.beginTransaction();
            DaoVenta daoVenta = new DaoVenta();
            //Ventas que tiene un cliente
            this.ventaObjects = daoVenta.leerPorCodigoClienteReporte(this.session, codCliente);
            this.transaction.commit();
        } catch (Exception e) {
            if (this.transaction != null) {
                this.transaction.rollback();
            }
            this.error = "Contacte al administrador << " + e.getMessage() + " >>";
            e.printStackTrace();
        } finally {
            //la sesión se cerrará si es true el valor
            if (this.session != null) {
                this.session.close();
            }
        }
        return this.ventaObjects;
    }

    public Ventas leerPrimeraVenta(boolean cerrarSession) {
        return this.venta;
    }

    public Ventas leerAnteriorVenta(int codVenta, boolean cerrarSession) {
        return this.venta;
    }

    public Ventas leerSiguienteVenta(int codVenta, boolean cerrarSession) {
        return this.venta;
    }

    public Ventas leerUltimaVenta(boolean cerrarSession) {
        this.session = null;
        this.transaction = null;
        //en caso de que no haya venta retornará NULL
        this.venta = null;
        try {
            this.session = HibernateUtil.getSessionFactory().openSession();
            this.transaction = session.beginTransaction();
            DaoVenta daoVenta = new DaoVenta();
            //Ventas que tiene un cliente
            this.ventaList = daoVenta.leerTodos(this.session);
            //obtener el la última venta
            int tam = ventaList.size();
            //recorrer en orden inverso
            for (int i = tam - 1; i >= 0; i--) {
                this.venta = ventaList.get(i);
                //obtenemos la ultima venta
                if (("0".equals(this.venta.getRegistro().substring(0, 1)) || "1".equals(this.venta.getRegistro().substring(0, 1)))) {
                    //terminamos el for
                    break;
                }
            }
            this.transaction.commit();
        } catch (Exception e) {
            if (cerrarSession & this.transaction != null) {
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
        return this.venta;
    }

    public Ventas leerUltimaVentaCredito(boolean cerrarSession) {
        this.session = null;
        this.transaction = null;
        //en caso de que no haya venta retornará NULL
        this.venta = null;
        try {
            this.session = HibernateUtil.getSessionFactory().openSession();
            this.transaction = session.beginTransaction();
            DaoVenta daoVenta = new DaoVenta();
            //Ventas que tiene un cliente
            this.ventaList = daoVenta.leerTodos(this.session);
            //obtener el la última venta
            int tam = ventaList.size();
            //recorrer en orden inverso
            for (int i = tam - 1; i >= 0; i--) {
                this.venta = ventaList.get(i);
                //si la venta es al crédito y esta activa o eliminada
                if ("CREDITO".equals(this.venta.getTipo())
                        & ("0".equals(this.venta.getRegistro().substring(0, 1)) || "1".equals(this.venta.getRegistro().substring(0, 1)))) {
                    //terminamos el for
                    break;
                }
            }
            this.transaction.commit();
        } catch (Exception e) {
            if (cerrarSession & this.transaction != null) {
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
        return this.venta;
    }

    public List<Ventas> leerTodos(boolean cerrarSession) {
        this.session = null;
        this.transaction = null;
        try {
            this.session = HibernateUtil.getSessionFactory().openSession();
            this.transaction = session.beginTransaction();
            DaoVenta daoVenta = new DaoVenta();
            //Ventas que tiene un cliente
            this.ventaList = daoVenta.leerTodos(this.session);
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
        return this.ventaList;
    }

    public Ventas getVenta() {
        return venta;
    }

    public void setVenta(Ventas venta) {
        this.venta = venta;
    }

    public List<Ventas> getVentaList() {
        return ventaList;
    }

    public void setVentaList(List<Ventas> ventaList) {
        this.ventaList = ventaList;
    }

    public String getError() {
        return error;
    }

    public void setError(String error) {
        this.error = error;
    }

    public List<Object[]> getVentaObjects() {
        return ventaObjects;
    }

    public void setVentaObjects(List<Object[]> ventaObjects) {
        this.ventaObjects = ventaObjects;
    }

}
