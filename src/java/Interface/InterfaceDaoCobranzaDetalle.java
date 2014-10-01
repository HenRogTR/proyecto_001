/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package Interface;

import org.hibernate.Session;
import tablas.CobranzaDetalle;

/**
 *
 * @author Henrri
 */
public interface InterfaceDaoCobranzaDetalle {

    public boolean pesistir(Session session, CobranzaDetalle objCobranzaDetalle) throws Exception;
}
