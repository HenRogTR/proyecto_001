/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package Dao;

import Interface.InterfaceDaoZona;
import java.util.List;
import org.hibernate.Query;
import org.hibernate.Session;
import tablas.Zona;

/**
 *
 * @author Henrri
 */
public class DaoZona implements InterfaceDaoZona {

    @Override
    public List<Zona> leer(Session session) throws Exception {
        String hql = "from Zona";
        Query q = session.createQuery(hql);
        List<Zona> zona = (List<Zona>) q.list();
        return zona;
    }

}
