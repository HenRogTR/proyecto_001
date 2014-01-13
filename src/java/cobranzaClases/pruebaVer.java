/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package cobranzaClases;

import java.util.Date;
import java.util.Iterator;
import java.util.List;
import org.hibernate.stat.Statistics;
import personaClases.cDatosCliente;
import personaClases.cPersona;
import tablas.Cobranza;
import tablas.CobranzaDetalle;
import tablas.DatosCliente;
import tablas.HibernateUtil;
import utilitarios.cOtros;

/**
 *
 * @author Henrri
 */
public class pruebaVer {

    /**
     * @param args the command line arguments
     */
    public static void main(String[] args) {
        // TODO code application logic here

//        for (int i = 0; i < 100; i++) {
//            Cobranza objCobranza = new Cobranza();
//            objCobranza.setPersona(new cPersona().leer_cod(14));
//            objCobranza.setFechaCobranza(new Date());
//            objCobranza.setDocSerieNumero("R-001-000" + i);
//            objCobranza.setSaldoAnterior(0.00);
//            objCobranza.setImporte(0.00);
//            objCobranza.setSaldo(100 + i);
//            objCobranza.setObservacion("Anticipo");
//            objCobranza.setRegistro(new cOtros().registro("1", "1"));
//            int codCobranza = new cCobranza().Crear(objCobranza);
//            List cobranzaList = new cCobranza().leer_codPersona(14);
//            for (Iterator it = cobranzaList.iterator(); it.hasNext();) {
//                Cobranza objCobranza1 = (Cobranza) it.next();
//                System.out.println(objCobranza1.getDocSerieNumero());
//            }
//
//            System.out.println(objCobranza.getDocSerieNumero());
//            System.out.println("****************************************************************************************************");
//        }
//        HibernateUtil.getSessionFactory().close();
//        org.hibernate.stat.Statistics stats = 
        DatosCliente objCliente = new cDatosCliente().leer_codPersona(4);
        System.out.println(objCliente.getPersona().getNombresC());
        Statistics stats = HibernateUtil.getSessionFactory().getStatistics();

        //Primero despliego el numero de conexiones que se han pedido a Hibernate
        // (No es el numero actual, sino cuantas se han pedido en total)
        System.out.println("Connection count: " + stats.getConnectCount());
        System.out.println("");

        //Numero de transacciones completadas (falladas y satisfactorias)
        System.out.println("Trx count: " + stats.getTransactionCount());
        System.out.println("");

        //Numero de transacciones completadas (solo satisfactorias)
        System.out.println("Succ trx count: " + stats.getSuccessfulTransactionCount());
        System.out.println("");

        // Numero de sesiones que el codigo ha abierto
        System.out.println("Opened sessions: " + stats.getSessionOpenCount());
        System.out.println("");

        // Numero de sesiones que el codigo ha cerrado
        System.out.println("Closed sessions: " + stats.getSessionCloseCount());
        System.out.println("");

        // Numero total de queries ejecutados
        System.out.println("No. queries: " + stats.getQueryExecutionCount());

    }

}
