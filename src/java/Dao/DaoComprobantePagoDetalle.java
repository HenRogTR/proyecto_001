/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package Dao;

import java.util.List;
import org.hibernate.Query;
import org.hibernate.Session;
import tablas.ComprobantePagoDetalle;

/**
 *
 * @author Henrri
 */
public class DaoComprobantePagoDetalle implements Interface.InterfaceDaoComprobantePagoDetalle {

    @Override
    public List<ComprobantePagoDetalle> leerDisponible(Session session, int codigoComprobantePago) throws Exception {
        String hql = "";
        hql = hql.concat(" from ComprobantePagoDetalle cpd ");
        hql = hql.concat(" where substring(cpd.registro,1,1)= 1");
        hql = hql.concat(" and cpd.comprobantePago.codComprobantePago= :codComprobantePago");
        hql = hql.concat(" and cpd.estado= 0");
        hql = hql.concat(" order by cpd.docSerieNumero asc");
        Query q = session.createQuery(hql)
                .setInteger("codComprobantePago", codigoComprobantePago);
        return (List<ComprobantePagoDetalle>) q.list();
    }

    @Override
    public boolean actualizar(Session session, ComprobantePagoDetalle objComprobantePagoDetalle) throws Exception {
        session.update(objComprobantePagoDetalle);
        return true;
    }

}
