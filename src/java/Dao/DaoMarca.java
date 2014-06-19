/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package Dao;

import Interface.InterfaceDaoMarca;
import java.util.List;
import org.hibernate.Query;
import org.hibernate.Session;
import tablas.Marca;

/**
 *
 * @author Henrri
 */
public class DaoMarca implements InterfaceDaoMarca {

    @Override
    public int crear(Session sesion, Marca objMarca) throws Exception {
        return (Integer) sesion.save(objMarca);
    }

    @Override
    public List<Marca> leer_todo(Session sesion) throws Exception {
        throw new UnsupportedOperationException("Not supported yet."); //To change body of generated methods, choose Tools | Templates.
    }

    @Override
    public Marca leer_codigo(Session session, int codMarca) throws Exception {
        Query query = session.createQuery("from Marca m where m= :codMarca")
                .setInteger("codMarca", codMarca);
        return (Marca) query.uniqueResult();
    }

    @Override
    public Marca leer_descripcion(Session session, String descripcion) throws Exception {
        Query query = session.createQuery("from Marca m where m.descripcion= :descripcion")
                .setString("descripcion", descripcion);
        return (Marca) query.uniqueResult();
    }

    @Override
    public boolean actualizar(Session session, Marca objMarca) throws Exception {
        session.update(objMarca);
        return true;
    }

}
