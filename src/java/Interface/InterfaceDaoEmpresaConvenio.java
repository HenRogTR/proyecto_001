/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package Interface;

import java.util.List;
import org.hibernate.Session;
import tablas.EmpresaConvenio;

/**
 *
 * @author Henrri
 */
public interface InterfaceDaoEmpresaConvenio {

    public List<EmpresaConvenio> leerTodos(Session session) throws Exception;
}
