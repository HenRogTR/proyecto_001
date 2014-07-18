/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package Dao;

import Interface.InterfaceDaoUsuario;
import org.hibernate.Query;
import org.hibernate.Session;
import tablas.Usuario;

/**
 *
 * @author Henrri
 */
public class DaoUsuario implements InterfaceDaoUsuario {

    @Override
    public int registrar(Session session, Usuario objUsuario) throws Exception {
        return (Integer) session.save(objUsuario);
    }

    @Override
    public Usuario leerPorCodigoUsuario(Session session, int codUsuario) throws Exception {
        String hql = "from Usuario u where u.codUsuario= :codUsuario";
        Query q = session.createQuery(hql)
                .setInteger("codUsuario", codUsuario);
        return (Usuario) q.uniqueResult();
    }

    @Override
    public Usuario leerPorUsuario(Session session, String usuario) throws Exception {
        String hql = "from Usuario u where u.usuario= :usuario";
        Query q = session.createQuery(hql)
                .setString("usuario", usuario);
        return (Usuario) q.uniqueResult();
    }

    @Override
    public Usuario leerPorCodigoPersona(Session session, int codPersona) throws Exception {
        String hql = "from Usuario u where u.persona.codPersona= :codPersona";
        Query q = session.createQuery(hql)
                .setInteger("codPersona", codPersona);
        return (Usuario) q.uniqueResult();
    }

    @Override
    public boolean actualizar(Session session, Usuario objUsuario) throws Exception {
        session.update(objUsuario);
        return true;
    }

}
