/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package Ejb;

import Dao.DaoZona;
import HiberanteUtil.HibernateUtil;
import java.util.List;
import javax.ejb.Stateless;
import org.hibernate.Session;
import org.hibernate.Transaction;
import tablas.Zona;

/**
 *
 * @author Henrri
 */
@Stateless
public class EjbZona {

    private Zona zona;
    private List<Zona> zonaList;

    private String error;
    private Session session;
    private Transaction transaction;

    public EjbZona() {
        zona = new Zona();
        zonaList = null;
        error = null;
    }

    public List<Zona> leerActivos(boolean cerrarSession) {
        this.session = null;
        this.transaction = null;
        try {
            this.session = HibernateUtil.getSessionFactory().openSession();
            this.transaction = session.beginTransaction();
            DaoZona daoZona = new DaoZona();
            //buscamos todos los registros
            this.zonaList = daoZona.leer(this.session);
            //obtener tamaño de lista
            int tam = this.zonaList.size();
            //dejar solo activos
            for (int i = 0; i < tam; i++) {
                this.zona = this.zonaList.get(i);
                //comparar si se encuentra activo
                if (!"1".equals(this.zona.getRegistro().substring(0, 1))) {
                    this.zonaList.remove(i);
                    //regresamos una posicion
                    i--;
                    /*el tamaño se reduce en uno, se quita uno ya que el tamaño 
                     *del array se calcula solo al inicio y se mantiene constante
                     *cosa que cambiaria si el tam se obtendria dentro del for
                     */
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
            if (cerrarSession & this.session != null) {
                this.session.close();
            }
        }
        return zonaList;
    }

    public Zona getZona() {
        return zona;
    }

    public void setZona(Zona zona) {
        this.zona = zona;
    }

    public List<Zona> getZonaList() {
        return zonaList;
    }

    public void setZonaList(List<Zona> zonaList) {
        this.zonaList = zonaList;
    }

    public String getError() {
        return error;
    }

    public void setError(String error) {
        this.error = error;
    }

}
