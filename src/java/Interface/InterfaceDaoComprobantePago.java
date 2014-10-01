/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package Interface;

import java.util.List;
import org.hibernate.Session;
import tablas.ComprobantePago;

/**
 *
 * @author Henrri
 */
public interface InterfaceDaoComprobantePago {

    public List<ComprobantePago> verificarDisponible(Session session, String tipo, String serie) throws Exception;
}
