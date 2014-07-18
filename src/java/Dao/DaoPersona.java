/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package Dao;

import Interface.InterfaceDaoPersona;
import org.hibernate.Query;
import org.hibernate.Session;
import tablas.Persona;

/**
 *
 * @author Henrri
 */
public class DaoPersona implements InterfaceDaoPersona {

    @Override
    public int crear(Session session, Persona persona) throws Exception {
        throw new UnsupportedOperationException("Not supported yet."); //To change body of generated methods, choose Tools | Templates.
    }

    @Override
    public Persona leerPorCodigo(Session session, int codPersona) throws Exception {
        String hql = "from Persona p where p.codPersona= :codPersona";
        Query q = session.createQuery(hql)
                .setInteger("codPersona", codPersona);
        return (Persona) q.uniqueResult();
    }

}
