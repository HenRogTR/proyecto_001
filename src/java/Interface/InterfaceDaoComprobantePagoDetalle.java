/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package Interface;

import java.util.List;
import org.hibernate.Session;
import tablas.ComprobantePagoDetalle;

/**
 *
 * @author Henrri
 */
public interface InterfaceDaoComprobantePagoDetalle {

    public List<ComprobantePagoDetalle> leerDisponible(Session session, int codigoComprobantePago) throws Exception;

    public boolean actualizar(Session session, ComprobantePagoDetalle objComprobantePagoDetalle) throws Exception;

}
