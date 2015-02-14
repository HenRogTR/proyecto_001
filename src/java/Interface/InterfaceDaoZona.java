/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package Interface;

import java.util.List;
import org.hibernate.Session;
import tablas.Zona;

/**
 *
 * @author Henrri
 */
public interface InterfaceDaoZona {

    public List<Zona> leer(Session session) throws Exception;

}
