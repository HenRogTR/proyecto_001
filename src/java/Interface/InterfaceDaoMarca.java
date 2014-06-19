/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package Interface;

import java.util.List;
import org.hibernate.Session;
import tablas.Marca;

/**
 *
 * @author Henrri
 */
public interface InterfaceDaoMarca {

    public int crear(Session session, Marca objMarca) throws Exception;

    public Marca leer_codigo(Session session, int codMarca) throws Exception;

    public List<Marca> leer_todo(Session session) throws Exception;

    public Marca leer_descripcion(Session session, String descripcion) throws Exception;

    public boolean actualizar(Session session, Marca objMarca) throws Exception;
}
