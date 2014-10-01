/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package Dao;

import Interface.InterfaceDaoComprobantePago;
import java.util.List;
import org.hibernate.Query;
import org.hibernate.Session;
import tablas.ComprobantePago;

/**
 *
 * @author Henrri
 */
public class DaoComprobantePago implements InterfaceDaoComprobantePago {

    @Override
    public List<ComprobantePago> verificarDisponible(Session session, String tipo, String serie) throws Exception {
        String hql = "";
        hql = hql.concat(" from ComprobantePago cp");
        hql = hql.concat(" where substring(cp.registro,1,1)=1");
        hql = hql.concat(" and cp.tipo= :tipo and cp.serie= :serie");
        Query q = session.createQuery(hql)
                .setString("tipo", tipo)
                .setString("serie", serie);
        return (List<ComprobantePago>) q.list();
    }

}
