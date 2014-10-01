/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package Dao;

import Interface.InterfaceDaoCliente;
import java.util.List;
import org.hibernate.Query;
import org.hibernate.Session;
import tablas.DatosCliente;

/**
 *
 * @author Henrri
 */
public class DaoCliente implements InterfaceDaoCliente {

    @Override
    public int crear(Session session, DatosCliente objCliente) throws Exception {
        //recogemos el código generado automáticamente
        int codigo = (Integer) session.save(objCliente);
        //devolvemos el código en caso de ser usado
        return codigo;
    }

    /**
     * Retorna un cliente buscado por el código, este puede o no tener el
     * atributo 0 ó 1 y aun así lo retornará
     *
     * @param session
     * @param codCliente
     * @return
     * @throws Exception
     */
    @Override
    public DatosCliente leerPorCodigo(Session session, int codCliente) throws Exception {
        String hql = "from DatosCliente dc where dc= :codCliente";
        Query q = session.createQuery(hql)
                .setInteger("codCliente", codCliente);
        return (DatosCliente) q.uniqueResult();
    }

    @Override
    public DatosCliente leerPorCodigoPersona(Session session, int codPersona) throws Exception {
        String hql = "from DatosCliente dc where dc.persona.codPersona= :codPersona";
        Query q = session.createQuery(hql)
                .setInteger("codPersona", codPersona);
        return (DatosCliente) q.uniqueResult();
    }

    @Override
    public List<DatosCliente> leerClienteActivo(Session session) throws Exception {
        String hql = "from DatosCliente dc where substring(dc.registro,1,1)= 1";
        Query q = session.createQuery(hql);
        List<DatosCliente> clienteList = (List<DatosCliente>) q.list();
        return clienteList;
    }

    @Override
    public List leerClienteOrdenadoAlfabeticamente(Session session) throws Exception {
        String hql = "select dc.codDatosCliente, p.codPersona, p.dniPasaporte, p.ruc,"
                + " p.nombresC from Persona p join p.datosClientes dc"
                + " where substring(dc.registro,1,1)= 1"
                + " order by dc.persona.nombresC, dc.persona.dniPasaporte asc,"
                + " dc.persona.ruc asc";
        Query q = session.createQuery(hql);
        List clienteList = (List) q.list();
        return clienteList;
    }

    @Override
    public boolean actualizar(Session session, DatosCliente objCliente) throws Exception {
        session.update(objCliente);
        return true;
    }

}
