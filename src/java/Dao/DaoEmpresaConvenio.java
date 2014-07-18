/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package Dao;

import Interface.InterfaceDaoEmpresaConvenio;
import java.util.List;
import org.hibernate.Query;
import org.hibernate.Session;
import tablas.EmpresaConvenio;

/**
 *
 * @author Henrri
 */
public class DaoEmpresaConvenio implements InterfaceDaoEmpresaConvenio {

    @Override
    public List<EmpresaConvenio> leerTodos(Session session) throws Exception {
        String hql = "from EmpresaConvenio";
        Query q = session.createQuery(hql);
        List<EmpresaConvenio> empresaConvenio = (List<EmpresaConvenio>) q.list();
        return empresaConvenio;
    }

}
