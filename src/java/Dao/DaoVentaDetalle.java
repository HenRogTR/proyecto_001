/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package Dao;

import Interface.InterfaceDaoVentaDetalle;
import java.util.List;
import org.hibernate.Query;
import org.hibernate.Session;
import tablas.VentasDetalle;

/**
 *
 * @author Henrri
 */
public class DaoVentaDetalle implements InterfaceDaoVentaDetalle {

    @Override
    public List<VentasDetalle> leerPorCodigoVenta(Session session, int codVenta) throws Exception {
        String hql = "from VentasDetalle vd where vd.ventas.codVentas= :codVenta";
        Query q = session.createQuery(hql)
                .setInteger("codVenta", codVenta);
        List<VentasDetalle> ventaDetalleList = (List<VentasDetalle>) q.list();
        return ventaDetalleList;
    }

}
