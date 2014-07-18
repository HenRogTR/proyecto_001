/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package Interface;

import org.hibernate.Session;
import tablas.ArticuloProducto;

/**
 *
 * @author Henrri
 */
public interface InterfaceDaoArticuloProducto {

    public ArticuloProducto leerPorCodigoArticuloProducto(Session session, int codArticuloProducto) throws Exception;

}
