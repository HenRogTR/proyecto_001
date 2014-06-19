/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package Dao;

import Interface.InterfaceDaoCobranza;
import java.util.List;
import org.hibernate.Query;
import org.hibernate.Session;
import tablas.Cobranza;

/**
 *
 * @author Henrri
 */
public class DaoCobranza implements InterfaceDaoCobranza {

    @Override
    public List<Cobranza> leerPorCodigoCliente(Session session, int codCliente) throws Exception {
        String hql = "select c from Cobranza c join c.persona.datosClientes dc where dc.codDatosCliente= :codCliente";
        Query q = session.createQuery(hql)
                .setInteger("codCliente", codCliente);
        List<Cobranza> cobranzaList = (List<Cobranza>) q.list();
        return cobranzaList;
    }

}
