/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package Interface;

import java.util.Date;
import java.util.List;
import org.hibernate.Session;
import tablas.VentaCreditoLetra;

/**
 *
 * @author Henrri
 */
public interface InterfaceDaoVentaCreditoLetra {

    public int crear(Session session, VentaCreditoLetra objVentaCreditoLetra) throws Exception;

    public VentaCreditoLetra leerPorCodigo(Session session, int codVentaCreditoLetra) throws Exception;

    public List<VentaCreditoLetra> leerPorCodigoVenta(Session session, int codVenta) throws Exception;

    public List<VentaCreditoLetra> leerPorCodigoVentaActivos(Session session, int codVenta) throws Exception;

    public List<VentaCreditoLetra> leerPorCodigoCliente(Session session, int codCliente) throws Exception;

    public List<VentaCreditoLetra> leerPorCodigoClienteOrderFechaVencimientoAsc(Session session, int codCliente) throws Exception;

    public List<Object[]> leerResumenPorCodigoCliente(Session session, int codCliente) throws Exception;

    public boolean actualizar(Session session, VentaCreditoLetra objVentaCreditoLetra) throws Exception;

    public boolean persistir(Session session, VentaCreditoLetra objVentaCreditoLetra) throws Exception;

    public List<VentaCreditoLetra> leerConDeudaPorCodigoCliente(Session session, int codCliente) throws Exception;

    public List<VentaCreditoLetra> leerConDeudaPorCodigoVenta(Session session, int codCliente) throws Exception;

}
