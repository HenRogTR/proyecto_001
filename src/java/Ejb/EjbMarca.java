/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package Ejb;

import Dao.DaoMarca;
import HiberanteUtil.HibernateUtil;
import java.util.List;
import javax.ejb.Stateless;
import org.hibernate.Session;
import org.hibernate.Transaction;
import tablas.Marca;

/**
 *
 * @author Henrri
 */
@Stateless
public class EjbMarca {

    private Marca marca;
    private List<Marca> listMarca;
    private String error;
    private Session session;
    private Transaction transaction;

    public String getError() {
        return error;
    }

    public void setError(String error) {
        this.error = error;
    }

    public EjbMarca() {
        this.marca = new Marca();
    }

    public boolean crear() {
        boolean est = false;
        this.session = null;
        this.transaction = null;
        this.error = null;
        try {
            this.session = HibernateUtil.getSessionFactory().openSession();
            this.transaction = session.beginTransaction();
            DaoMarca daoTMarca = new DaoMarca();
            //verificamos que no se haya registrado una marca en la base de datos
            if (daoTMarca.leer_descripcion(this.session, this.marca.getDescripcion()) != null) {
                this.error = "La marca ya se encuentra registrada.";
                //terminamos ejecución del programa
                return false;
            }
            //obtenemos el código autogenerado en la base de datos
            int codMarca = daoTMarca.crear(this.session, this.marca);
            //actualizamos el código generado
            this.marca.setCodMarca(codMarca);
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
    

    public Marca getMarca() {
        return marca;
    }

    public void setMarca(Marca marca) {
        this.marca = marca;
    }

    public List<Marca> getListMarca() {
        return listMarca;
    }

    public void setListMarca(List<Marca> listMarca) {
        this.listMarca = listMarca;
    }
}
