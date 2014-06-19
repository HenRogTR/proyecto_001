/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package Dao;

import Interface.InterfaceDaoVentaSerieNumero;
import java.util.List;
import org.hibernate.Query;
import org.hibernate.Session;
import tablas.VentasSerieNumero;

/**
 *
 * @author Henrri
 */
public class DaoVentaSerieNumero implements InterfaceDaoVentaSerieNumero {

    @Override
    public List<VentasSerieNumero> leerPorCodigoVenta(Session session, int codVenta) throws Exception {
        String hql = "";
        hql = hql.concat(" from VentasSerieNumero vsn");
        hql = hql.concat(" where vsn.ventasDetalle.ventas.codVentas= :codVenta");
        Query q = session.createQuery(hql).
                setInteger("codVenta", codVenta);
        List<VentasSerieNumero> ventaSerieNumeroList = (List<VentasSerieNumero>) q.list();
        return ventaSerieNumeroList;
    }

}
