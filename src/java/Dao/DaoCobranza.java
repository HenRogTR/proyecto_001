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
    public int registrar(Session session, Cobranza objCobranza) throws Exception {
        //recogemos el código generado automáticamente
        int codigo = (Integer) session.save(objCobranza);
        //devolvemos el código en caso de ser usado
        return codigo;
    }

    @Override
    public List<Cobranza> leerPorCodigoCliente(Session session, int codCliente) throws Exception {
        String hql = "";
        hql = hql.concat(" select c");
        hql = hql.concat(" from Cobranza c join c.persona.datosClientes dc");
        hql = hql.concat(" where dc.codDatosCliente= :codCliente");
        Query q = session.createQuery(hql)
                .setInteger("codCliente", codCliente);
        List<Cobranza> cobranzaList = (List<Cobranza>) q.list();
        return cobranzaList;
    }

    @Override
    public List<Cobranza> leerPorCodigoVenta(Session session, int codVenta) throws Exception {
        String hql = "";
        hql = hql.concat(" select c ");
        hql = hql.concat(" from Cobranza c join c.cobranzaDetalles cd");
        hql = hql.concat(" where cd.ventaCreditoLetra.ventas.codVentas= :codVenta");
        hql = hql.concat(" order by c.fechaCobranza");
        Query q = session.createQuery(hql)
                .setInteger("codVenta", codVenta);
        List<Cobranza> cobranzaList = (List<Cobranza>) q.list();
        return cobranzaList;
    }

    @Override
    public Cobranza leerPorDocSerieNumero(Session session, String docSerieNumero) throws Exception {
        String hql = "";
        hql = hql.concat(" from Cobranza");
        hql = hql.concat(" where (substring(registro,1,1)= 1 or substring(registro,1,1)= 0)");
        hql = hql.concat("and docSerieNumero = :docSerieNumero");
        Query q = session.createQuery(hql)
                .setString("docSerieNumero", docSerieNumero);
        return (Cobranza) q.uniqueResult();
    }

    @Override
    public boolean actualizar(Session session, Cobranza objCobranza) throws Exception {
        session.update(objCobranza);
        return true;
    }

}
