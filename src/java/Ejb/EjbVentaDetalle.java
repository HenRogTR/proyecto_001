/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package Ejb;

import Dao.DaoVentaDetalle;
import HiberanteUtil.HibernateUtil;
import java.util.List;
import javax.ejb.Stateless;
import org.hibernate.Session;
import org.hibernate.Transaction;
import tablas.VentasDetalle;

/**
 *
 * @author Henrri
 */
@Stateless
public class EjbVentaDetalle {

    private VentasDetalle ventaDetalle;
    private List<VentasDetalle> ventaDetalleList;

    private String error;
    private Session session;
    private Transaction transaction;

    public EjbVentaDetalle() {
        ventaDetalle = new VentasDetalle();
        ventaDetalleList = null;
    }

    public List<VentasDetalle> leerActivoPorCodigoVenta(int codVenta, boolean cerrarSession) {
        this.session = null;
        this.transaction = null;
        this.error = null;
        try {
            this.session = HibernateUtil.getSessionFactory().openSession();
            this.transaction = session.beginTransaction();
            DaoVentaDetalle daoVentaDetalle = new DaoVentaDetalle();
            //leer ventaCreditoLetra existentes
            this.ventaDetalleList = daoVentaDetalle.leerPorCodigoVenta(this.session, codVenta);
            //quitamos los anulados
            int tam = this.ventaDetalleList.size();
            for (int i = 0; i < tam; i++) {
                //obtenemos en objVCL
                this.ventaDetalle = this.ventaDetalleList.get(i);
                //si se encuentra anulado
                if (!"1".equals(this.ventaDetalle.getRegistro().substring(0, 1))) {
                    //regresamos una posicion ya que al ser quitada la posicion actual este será "reemplazada"
                    this.ventaDetalleList.remove(i);
                    i--;
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
            if (cerrarSession & this.session != null) {
                this.session.close();
            }
        }
        return this.ventaDetalleList;
    }

    public VentasDetalle getVentaDetalle() {
        return ventaDetalle;
    }

    public void setVentaDetalle(VentasDetalle ventaDetalle) {
        this.ventaDetalle = ventaDetalle;
    }

    public List<VentasDetalle> getVentaDetalleList() {
        return ventaDetalleList;
    }

    public void setVentaDetalleList(List<VentasDetalle> ventaDetalleList) {
        this.ventaDetalleList = ventaDetalleList;
    }

    public String getError() {
        return error;
    }

    public void setError(String error) {
        this.error = error;
    }

}
