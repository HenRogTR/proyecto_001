/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package Dao;

import Interface.InterfaceDaoVenta;
import java.util.List;
import org.hibernate.Query;
import org.hibernate.Session;
import tablas.Ventas;

/**
 *
 * @author Henrri
 */
public class DaoVenta implements InterfaceDaoVenta {

    @Override
    public List<Ventas> leerPorCodigoCliente(Session session, int codCliente) throws Exception {
        String hql = "select v from Ventas v join v.persona.datosClientes dc"
                + " where (substring(v.registro,1,1)= 0 or substring(v.registro,1,1)= 1)"
                + " and dc.codDatosCliente= :codCliente"
                + " order by v.fecha, v.codVentas";
        Query q = session.createQuery(hql)
                .setInteger("codCliente", codCliente);
        List<Ventas> ventaList = (List<Ventas>) q.list();
        return ventaList;
    }

    /**
     * Tomamos solo aquellos activos o anulados
     *
     * @param session
     * @return
     * @throws Exception
     */
    @Override
    public List<Ventas> leerTodos(Session session) throws Exception {
        String hql = "from Ventas v"
                + " where (substring(v.registro,1,1)= 0 or substring(v.registro,1,1)= 1)";
        Query q = session.createQuery(hql);
        List<Ventas> ventaList = (List<Ventas>) q.list();
        return ventaList;
    }

    @Override
    public Ventas leerPorCodigo(Session session, int codVenta) throws Exception {
        String hql = "from Ventas v where v.codVentas= :codVenta";
        Query q = session.createQuery(hql)
                .setInteger("codVenta", codVenta);
        return (Ventas) q.uniqueResult();
    }

    @Override
    public boolean actualizar(Session session, Ventas objVenta) throws Exception {
        session.update(objVenta);
        return true;
    }

}
