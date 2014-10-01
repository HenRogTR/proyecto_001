/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package Interface;

import org.hibernate.Session;
import tablas.DatosExtras;

/**
 *
 * @author Henrri
 */
public interface InterfaceDaoDatosExtras {

    public DatosExtras interesFactor(Session session) throws Exception;
    
    public DatosExtras diaEspera(Session session) throws Exception;

}
