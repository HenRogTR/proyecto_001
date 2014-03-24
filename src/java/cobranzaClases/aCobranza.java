/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package cobranzaClases;

import java.util.Iterator;
import java.util.List;
import utilitarios.cManejoFechas;

/**
 *
 * @author Henrri
 */
public class aCobranza {

    /**
     * @param args the command line arguments
     */
    public static void main(String[] args) {
        // TODO code application logic here
        cCobranza objcCobranza = new cCobranza();

        System.out.println(objcCobranza.leer_documentoCaja_query("c", true));

        List cobranzaList = objcCobranza.leer_cobranzaPagos_todos(new cManejoFechas().StringADate("01/03/2013"), new cManejoFechas().StringADate("31/06/2014"));

        System.out.println(objcCobranza.getError());
        for (Iterator it = cobranzaList.iterator(); it.hasNext();) {
            Object dato[] = (Object[]) it.next();
            System.out.println(dato[0] + " / " + dato[1] + " / " + dato[2] + " / " + dato[3] + " / " + dato[4] + " / " + dato[5] + " / " + dato[6]);
        }
    }

}
