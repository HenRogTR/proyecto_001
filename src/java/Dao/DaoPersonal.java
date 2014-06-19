/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package Dao;

import Interface.InterfaceDaoPersonal;
import org.hibernate.Query;
import org.hibernate.Session;
import tablas.Personal;

/**
 *
 * @author Henrri
 */
public class DaoPersonal implements InterfaceDaoPersonal {

    @Override
    public Personal leerPorCodigoPersonal(Session session, int codPersonal) throws Exception {
        Query query = session.createQuery("from Personal pl where pl.codPersonal= :codPersonal")
                .setInteger("codPersonal", codPersonal);
        return (Personal) query.uniqueResult();
    }

    @Override
    public Personal leerPorCodigoPersona(Session session, int codPersona) throws Exception {
        Query query = session.createQuery("from Personal pl where pl.persona.codPersona= :codPersona")
                .setInteger("codPersona", codPersona);
        return (Personal) query.uniqueResult();
    }

}
