/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package Interface;

import org.hibernate.Session;
import tablas.Personal;

/**
 *
 * @author Henrri
 */
public interface InterfaceDaoPersonal {

    public Personal leerPorCodigoPersonal(Session session, int codPersonal) throws Exception;

    public Personal leerPorCodigoPersona(Session session, int codPersona) throws Exception;
}
