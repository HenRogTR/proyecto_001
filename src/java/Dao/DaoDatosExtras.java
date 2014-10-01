/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package Dao;

import Interface.InterfaceDaoDatosExtras;
import org.hibernate.Query;
import org.hibernate.Session;
import tablas.DatosExtras;

/**
 *
 * @author Henrri
 */
public class DaoDatosExtras implements InterfaceDaoDatosExtras {

    @Override
    public DatosExtras interesFactor(Session session) throws Exception {
        String hql
                = " from DatosExtras de"
                + " where substring(de.registro,1,1) = 1"
                + " and de.descripcionDato = 'interesFactor'";
        Query q = session.createQuery(hql);
        return (DatosExtras) q.uniqueResult();
    }
    
    @Override
    public DatosExtras diaEspera(Session session) throws Exception {
        String hql
                = " from DatosExtras de"
                + " where substring(de.registro,1,1) = 1"
                + " and de.descripcionDato = 'diaEspera'";
        Query q = session.createQuery(hql);
        return (DatosExtras) q.uniqueResult();
    }

}
