/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package Ejb;

import Dao.DaoVentaSerieNumero;
import HiberanteUtil.HibernateUtil;
import java.util.List;
import javax.ejb.Stateless;
import org.hibernate.Session;
import org.hibernate.Transaction;
import tablas.VentasSerieNumero;

/**
 *
 * @author Henrri
 */
@Stateless
public class EjbVentaSerieNumero {

    private VentasSerieNumero ventasSerieNumero;
    private List<VentasSerieNumero> ventasSerieNumeroList;

    private String error;
    private Session session;
    private Transaction transaction;

    public EjbVentaSerieNumero() {
        ventasSerieNumero = new VentasSerieNumero();
        ventasSerieNumeroList = null;
    }

    public List<VentasSerieNumero> leerActivoPorCodigoVenta(int codVenta, boolean cerrarSession) {
        this.session = null;
        this.transaction = null;
        try {
            this.session = HibernateUtil.getSessionFactory().openSession();
            this.transaction = session.beginTransaction();
            DaoVentaSerieNumero daoVentaSerieNumero = new DaoVentaSerieNumero();
            //Ventas que tiene un cliente
            this.ventasSerieNumeroList = daoVentaSerieNumero.leerPorCodigoVenta(this.session, codVenta);
            int tam = this.ventasSerieNumeroList.size();
            //quitamos aquellos que estan elimiandos
            for (int i = 0; i < tam; i++) {
                this.ventasSerieNumero = this.ventasSerieNumeroList.get(i);
                if (!"1".equals(this.ventasSerieNumero.getVentasDetalle().getRegistro().substring(0, 1))) {
                    this.ventasSerieNumeroList.remove(i);
                    i--;
                    tam--;
                }
            }
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
        return this.ventasSerieNumeroList;
    }

    public VentasSerieNumero getVentasSerieNumero() {
        return ventasSerieNumero;
    }

    public void setVentasSerieNumero(VentasSerieNumero ventasSerieNumero) {
        this.ventasSerieNumero = ventasSerieNumero;
    }

    public List<VentasSerieNumero> getVentasSerieNumeroList() {
        return ventasSerieNumeroList;
    }

    public void setVentasSerieNumeroList(List<VentasSerieNumero> ventasSerieNumeroList) {
        this.ventasSerieNumeroList = ventasSerieNumeroList;
    }

    public String getError() {
        return error;
    }

    public void setError(String error) {
        this.error = error;
    }

}
