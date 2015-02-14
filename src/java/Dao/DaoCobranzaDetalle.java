/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package Dao;

import Interface.InterfaceDaoCobranzaDetalle;
import java.util.List;
import org.hibernate.Query;
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

    @Override
    public List<CobranzaDetalle> leerPorCodigoCobranza(Session session, int codCobranza) throws Exception {
        String hql
                = " from CobranzaDetalle cd"
                + " where cd.cobranza.codCobranza = :codCobranza"
                + "    and substring(cd.registro,1,1) = 1";
        Query q = session.createQuery(hql)
                .setInteger("codCobranza", codCobranza);
        List<CobranzaDetalle> cobranzaDetalleList = (List<CobranzaDetalle>) q.list();
        return cobranzaDetalleList;
    }

}
