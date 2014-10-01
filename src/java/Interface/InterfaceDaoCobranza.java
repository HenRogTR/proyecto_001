/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package Interface;

import java.util.List;
import org.hibernate.Session;
import tablas.Cobranza;

/**
 *
 * @author Henrri
 */
public interface InterfaceDaoCobranza {

    public int registrar(Session session, Cobranza objCobranza) throws Exception;

    public List<Cobranza> leerPorCodigoCliente(Session session, int codCliente) throws Exception;

    public List<Cobranza> leerPorCodigoVenta(Session session, int codVenta) throws Exception;

    public Cobranza leerPorDocSerieNumero(Session session, String docSerieNumero) throws Exception;

    public boolean actualizar(Session session, Cobranza objCobranza) throws Exception;
}
