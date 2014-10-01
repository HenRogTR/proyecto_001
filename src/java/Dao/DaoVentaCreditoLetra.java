/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package Dao;

import Interface.InterfaceDaoVentaCreditoLetra;
import java.util.List;
import org.hibernate.Query;
import org.hibernate.Session;
import tablas.VentaCreditoLetra;

/**
 *
 * @author Henrri
 */
public class DaoVentaCreditoLetra implements InterfaceDaoVentaCreditoLetra {

    @Override
    public int crear(Session session, VentaCreditoLetra objVentaCreditoLetra) throws Exception {
        //recogemos el código generado automáticamente
        int codigo = (Integer) session.save(objVentaCreditoLetra);
        //devolvemos el código en caso de ser usado
        return codigo;
    }

    @Override
    public VentaCreditoLetra leerPorCodigo(Session session, int codVentaCreditoLetra) throws Exception {
        String hql = "from VentaCreditoLetra vcl where vcl= :codVentaCreditoLetra";
        Query q = session.createQuery(hql)
                .setInteger("codVentaCreditoLetra", codVentaCreditoLetra);
        return (VentaCreditoLetra) q.uniqueResult();
    }

    @Override
    public List<VentaCreditoLetra> leerPorCodigoVenta(Session session, int codVenta) throws Exception {
        String hql = "";
        hql = hql.concat(" from VentaCreditoLetra vcl");
        hql = hql.concat(" where vcl.ventas.codVentas= :codVenta");
        hql = hql.concat(" order by vcl.numeroLetra, vcl.codVentaCreditoLetra");
        Query q = session.createQuery(hql)
                .setInteger("codVenta", codVenta);
        List<VentaCreditoLetra> ventaCreditoLetraList = (List<VentaCreditoLetra>) q.list();
        return ventaCreditoLetraList;
    }

    @Override
    public List<VentaCreditoLetra> leerPorCodigoVentaActivos(Session session, int codVenta) throws Exception {
        String hql = "";
        hql = hql.concat(" from VentaCreditoLetra vcl");
        hql = hql.concat(" where vcl.ventas.codVentas= :codVenta");
        hql = hql.concat("    and substring(vcl.registro,1,1)= 1");
        hql = hql.concat(" order by vcl.numeroLetra, vcl.codVentaCreditoLetra");
        Query q = session.createQuery(hql)
                .setInteger("codVenta", codVenta);
        List<VentaCreditoLetra> ventaCreditoLetraList = (List<VentaCreditoLetra>) q.list();
        return ventaCreditoLetraList;
    }

    @Override
    public List<VentaCreditoLetra> leerPorCodigoCliente(Session session, int codCliente) throws Exception {
        String hql = "";
        hql = hql.concat(" select vcl");
        hql = hql.concat(" from VentaCreditoLetra vcl");
        hql = hql.concat(" where vcl.ventas.codCliente= :codCliente");
        hql = hql.concat("    and substring(vcl.registro,1,1)= 1");
        hql = hql.concat(" order by vcl.ventas.codVentas, vcl.numeroLetra");
        Query q = session.createQuery(hql)
                .setInteger("codCliente", codCliente);
        List<VentaCreditoLetra> ventaCreditoLetraList = (List<VentaCreditoLetra>) q.list();
        return ventaCreditoLetraList;
    }

    @Override
    public List<VentaCreditoLetra> leerPorCodigoClienteOrderFechaVencimientoAsc(Session session, int codCliente) throws Exception {
        String hql = "";
        hql = hql.concat(" select vcl");
        hql = hql.concat(" from VentaCreditoLetra vcl");
        hql = hql.concat(" where vcl.ventas.codCliente= :codCliente");
        hql = hql.concat("    and substring(vcl.registro,1,1)= 1");
        hql = hql.concat(" order by vcl.fechaVencimiento");
        Query q = session.createQuery(hql)
                .setInteger("codCliente", codCliente);
        List<VentaCreditoLetra> ventaCreditoLetraList = (List<VentaCreditoLetra>) q.list();
        return ventaCreditoLetraList;
    }

    @Override
    public List<Object[]> leerResumenPorCodigoCliente(Session session, int codCliente) throws Exception {
        String hql = "";
        hql = hql.concat(" select vcl.fechaVencimiento");
        hql = hql.concat("    , sum(vcl.monto), sum(vcl.interes), sum(vcl.totalPago)");
        hql = hql.concat("    , sum(vcl.interesPagado)");
        hql = hql.concat(" from VentaCreditoLetra vcl");
        hql = hql.concat("    join vcl.ventas.persona.datosClientes dc");
        hql = hql.concat(" where dc.codDatosCliente= :codCliente");
        hql = hql.concat("    and substring(vcl.registro,1,1)= 1");
        hql = hql.concat(" group by year(vcl.fechaVencimiento), month(vcl.fechaVencimiento)");
        hql = hql.concat(" order by vcl.fechaVencimiento");
        Query q = session.createQuery(hql)
                .setInteger("codCliente", codCliente);
        List<Object[]> ventaCreditoLetraList = (List<Object[]>) q.list();
        return ventaCreditoLetraList;
    }

    @Override
    public boolean actualizar(Session session, VentaCreditoLetra objVentaCreditoLetra) throws Exception {
        session.update(objVentaCreditoLetra);
        return true;
    }

    @Override
    public boolean persistir(Session session, VentaCreditoLetra objVentaCreditoLetra) throws Exception {
        session.persist(objVentaCreditoLetra);
        return true;
    }

    @Override
    public List<VentaCreditoLetra> leerConDeudaPorCodigoCliente(Session session, int codCliente) throws Exception {
        String hql = "";
        hql = hql.concat(" select vcl");
        hql = hql.concat(" from VentaCreditoLetra vcl join vcl.ventas v");
        hql = hql.concat(" where v.codCliente= :codCliente and vcl.monto-vcl.totalPago> 0");
        hql = hql.concat(" and substring(vcl.registro,1,1)= 1");
        hql = hql.concat(" order by vcl.fechaVencimiento asc");
        Query q = session.createQuery(hql)
                .setInteger("codCliente", codCliente);
        return (List<VentaCreditoLetra>) q.list();
    }

    @Override
    public List<VentaCreditoLetra> leerConDeudaPorCodigoVenta(Session session, int codVenta) throws Exception {
        String hql = "";
        hql = hql.concat(" select vcl");
        hql = hql.concat(" from VentaCreditoLetra vcl join vcl.ventas v");
        hql = hql.concat(" where v.codVentas= :codVenta and vcl.monto-vcl.totalPago> 0");
        hql = hql.concat(" and substring(vcl.registro,1,1)= 1");
        hql = hql.concat(" order by vcl.fechaVencimiento asc");
        Query q = session.createQuery(hql)
                .setInteger("codVenta", codVenta);
        return (List<VentaCreditoLetra>) q.list();
    }

}
