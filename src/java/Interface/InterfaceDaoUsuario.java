/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package Interface;

import org.hibernate.Session;
import tablas.Usuario;

/**
 *
 * @author Henrri
 */
public interface InterfaceDaoUsuario {

    public int registrar(Session session, Usuario objUsuario) throws Exception;

    public Usuario leerPorCodigoUsuario(Session session, int codUsuario) throws Exception;

    public Usuario leerPorUsuario(Session session, String usuario) throws Exception;

    public Usuario leerPorCodigoPersona(Session session, int codPersona) throws Exception;

    public boolean actualizar(Session session, Usuario objUsuario) throws Exception;
}
