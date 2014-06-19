/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package Ejb;

import Dao.DaoCobranza;
import HiberanteUtil.HibernateUtil;
import java.util.List;
import javax.ejb.Stateless;
import org.hibernate.Session;
import org.hibernate.Transaction;
import tablas.Cobranza;

/**
 *
 * @author Henrri
 */
@Stateless
public class EjbCobranza {

    private Cobranza cobranza;
    private List<Cobranza> cobranzaList;

    private String error;
    private Session session;
    private Transaction transaction;

    public EjbCobranza() {
        cobranza = new Cobranza();
        cobranzaList = null;
        error = null;
    }

    public List<Cobranza> leerActivoPorCodigoCliente(int codCliente, boolean cerrarSession) {
        this.session = null;
        this.transaction = null;
        try {
            this.session = HibernateUtil.getSessionFactory().openSession();
            this.transaction = session.beginTransaction();
            DaoCobranza daoCobranza = new DaoCobranza();
            //buscamos toda la cobranza hecha por cliente
            this.cobranzaList = daoCobranza.leerPorCodigoCliente(this.session, codCliente);
            //obtener tamaño de lista
            int tam = this.cobranzaList.size();
            //dejar solo activos
            for (int i = 0; i < tam; i++) {
                this.cobranza = this.cobranzaList.get(i);
                //comparar si se encuentra activo
                if (!"1".equals(this.cobranza.getRegistro().substring(0, 1))) {
                    this.cobranzaList.remove(i);
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
        return this.cobranzaList;
    }

    public Cobranza getCobranza() {
        return cobranza;
    }

    public void setCobranza(Cobranza cobranza) {
        this.cobranza = cobranza;
    }

    public List<Cobranza> getCobranzaList() {
        return cobranzaList;
    }

    public void setCobranzaList(List<Cobranza> cobranzaList) {
        this.cobranzaList = cobranzaList;
    }

    public String getError() {
        return error;
    }

    public void setError(String error) {
        this.error = error;
    }

}
