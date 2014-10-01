/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package Dao;

import Interface.InterfaceDaoCobranzaDetalle;
import org.hibernate.Session;
import tablas.CobranzaDetalle;

/**
 *
 * @author Henrri
 */
public class DaoCobranzaDetalle implements InterfaceDaoCobranzaDetalle {

    @Override
    public boolean pesistir(Session session, CobranzaDetalle objCobranzaDetalle) throws Exception {
        session.persist(objCobranzaDetalle);
        return true;
    }

}
