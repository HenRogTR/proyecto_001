/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package Interface;

import org.hibernate.Session;
import tablas.Persona;

/**
 *
 * @author Henrri
 */
public interface InterfaceDaoPersona {

    public int crear(Session session, Persona persona) throws Exception;

    public Persona leerPorCodigo(Session session, int codPersona) throws Exception;
}
