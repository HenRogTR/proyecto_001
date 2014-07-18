/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package Ejb;

import Dao.DaoEmpresaConvenio;
import HiberanteUtil.HibernateUtil;
import java.util.List;
import javax.ejb.Stateless;
import org.hibernate.Session;
import org.hibernate.Transaction;
import tablas.EmpresaConvenio;

/**
 *
 * @author Henrri
 */
@Stateless
public class EjbEmpresaConvenio {

    private EmpresaConvenio empresaConvenio;
    private List<EmpresaConvenio> empresaConvenioList;

    private String error;
    private Session session;
    private Transaction transaction;

    public EjbEmpresaConvenio() {
        empresaConvenio = new EmpresaConvenio();
        empresaConvenioList = null;
        error = null;
    }

    public List<EmpresaConvenio> leerActivos(boolean cerrarSession) {
        this.session = null;
        this.transaction = null;
        try {
            this.session = HibernateUtil.getSessionFactory().openSession();
            this.transaction = session.beginTransaction();
            DaoEmpresaConvenio daoEmpresaConvenio = new DaoEmpresaConvenio();
            //buscamos toda la cobranza hecha por cliente
            this.empresaConvenioList = daoEmpresaConvenio.leerTodos(this.session);
            //obtener tamaño de lista
            int tam = this.empresaConvenioList.size();
            //dejar solo activos
            for (int i = 0; i < tam; i++) {
                this.empresaConvenio = this.empresaConvenioList.get(i);
                //comparar si se encuentra activo
                if (!"1".equals(this.empresaConvenio.getRegistro().substring(0, 1))) {
                    this.empresaConvenioList.remove(i);
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
        return empresaConvenioList;
    }

    public EmpresaConvenio getEmpresaConvenio() {
        return empresaConvenio;
    }

    public void setEmpresaConvenio(EmpresaConvenio empresaConvenio) {
        this.empresaConvenio = empresaConvenio;
    }

    public List<EmpresaConvenio> getEmpresaConvenioList() {
        return empresaConvenioList;
    }

    public void setEmpresaConvenioList(List<EmpresaConvenio> empresaConvenioList) {
        this.empresaConvenioList = empresaConvenioList;
    }

    public String getError() {
        return error;
    }

    public void setError(String error) {
        this.error = error;
    }

}
