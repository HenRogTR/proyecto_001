/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */

package Dao;

import Interface.InterfaceDaoArticuloProducto;
import org.hibernate.Session;
import tablas.ArticuloProducto;

/**
 *
 * @author Henrri
 */
public class DaoArticuloProducto implements InterfaceDaoArticuloProducto{

    @Override
    public ArticuloProducto leerPorCodigoArticuloProducto(Session session, int codArticuloProducto) throws Exception {
        throw new UnsupportedOperationException("Not supported yet."); //To change body of generated methods, choose Tools | Templates.
    }
    
}
