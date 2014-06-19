/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package Interface;

import java.util.List;
import org.hibernate.Session;
import tablas.VentasSerieNumero;

/**
 *
 * @author Henrri
 */
public interface InterfaceDaoVentaSerieNumero {

    public List<VentasSerieNumero> leerPorCodigoVenta(Session session, int codVenta) throws Exception;
}
