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
    public List<Object[]> leerPorCodigoClienteReporte(Session session, int codCliente) throws Exception {
        String hql = "";
        hql = hql.concat(" select dc.codDatosCliente, dc.persona.nombresC");
        hql = hql.concat("  , v.codVentas, v.docSerieNumero, v.fecha, v.tipo, v.neto");
        hql = hql.concat("  , v.registro");
        hql = hql.concat("  , (select sum( CASE WHEN vd.precioReal>vd.precioVenta THEN (vd.precioVenta*vd.cantidad) ELSE (vd.precioReal*vd.cantidad) END ) ");
        hql = hql.concat("       from VentasDetalle vd ");
        hql = hql.concat("       where vd.ventas = v and substring(vd.registro,1,1) = 1 and substring(vd.ventas.registro,1,1) = 1 )");
        hql = hql.concat("  , (select sum(vc.montoInicial) from VentaCredito vc ");
        hql = hql.concat("       where vc.ventas = v and substring(vc.registro,1,1) = 1)");
        hql = hql.concat("  , (select sum(vc.cantidadLetras) from VentaCredito vc ");
        hql = hql.concat("       where vc.ventas = v and substring(vc.registro,1,1) = 1)");
        hql = hql.concat("  , (select sum(vd2.precioProforma * vd2.cantidad) ");
        hql = hql.concat("       from VentasDetalle vd2 ");
        hql = hql.concat("       where vd2.ventas = v and substring(vd2.registro,1,1) = 1 and substring(vd2.ventas.registro,1,1) = 1 )");
        hql = hql.concat("  , (select sum(vd3.precioCash * vd3.cantidad) ");
        hql = hql.concat("       from VentasDetalle vd3 ");
        hql = hql.concat("       where vd3.ventas = v and substring(vd3.registro,1,1) = 1 and substring(vd3.ventas.registro,1,1) = 1 )");
        hql = hql.concat("  from Ventas v join v.persona.datosClientes dc");
        hql = hql.concat("  where dc.codDatosCliente= :codCliente ");
        hql = hql.concat("    and (substring(v.registro,1,1) = 0 or substring(v.registro,1,1) = 1)");
        hql = hql.concat("  order by v.fecha, v.docSerieNumero");
        Query q = session.createQuery(hql)
                .setInteger("codCliente", codCliente);
        List<Object[]> ventaList = (List<Object[]>) q.list();
        return ventaList;
    }

}
