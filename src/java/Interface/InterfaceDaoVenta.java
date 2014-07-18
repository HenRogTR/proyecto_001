/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package Interface;

import java.util.List;
import org.hibernate.Session;
import tablas.Ventas;

/**
 *
 * @author Henrri
 */
public interface InterfaceDaoVenta {

    public List<Ventas> leerPorCodigoCliente(Session session, int codCliente) throws Exception;

    public List<Ventas> leerTodos(Session session) throws Exception;

    public List<Object[]> leerPorCodigoClienteReporte(Session session, int codCliente) throws Exception;
}
