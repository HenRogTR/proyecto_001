/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package Interface;

import java.util.List;
import org.hibernate.Session;
import tablas.DatosCliente;

/**
 *
 * @author Henrri
 */
public interface InterfaceDaoCliente {

    public int crear(Session session, DatosCliente objCliente) throws Exception;

    public DatosCliente leerPorCodigo(Session session, int codCliente) throws Exception;

    public DatosCliente leerPorCodigoPersona(Session session, int codPersona) throws Exception;

    public List<DatosCliente> leerClienteActivo(Session session) throws Exception;

    public List leerClienteOrdenadoAlfabeticamente(Session session) throws Exception;

    public boolean actualizar(Session session, DatosCliente objCliente) throws Exception;
}
